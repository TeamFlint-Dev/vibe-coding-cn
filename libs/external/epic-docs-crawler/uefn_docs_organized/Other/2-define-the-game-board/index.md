# 2. Define the Game Board

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/2-define-the-game-board
> **爬取时间**: 2025-12-27T00:24:25.747979

---

The first step in constructing the logic behind the game board is deciding how to programmatically represent a game board tile.

To design how to represent a board tile, think about how you and the player use board tiles. A board game typically consists of discrete spaces that are individually separated from one another and distinct. This is different from the UEFN world space.

In world space, coordinates are represented by `vector3` locations, which means that coordinates can be as close together as floating point numbers can be, which makes world coordinates more continuous than discrete. Furthermore, there are many different `vector3` locations that will all be on the same board tile. From this, you can conclude a few things:

- Since board tiles are discrete, you may want to use a discrete data (discrete data is data that takes on a range of values that is in correspondence with integer or whole-number values) type to represent our locations, which means that one should use `int` instead of `float`.type
- The board is two-dimensional, so you only need to store a location within two dimensions. You do not need a three-dimensional data structure to store the board tile location.

### Define Board Data Types

The `tile_coordinate` class represents where a tile is located on the game board. To create the `tile_coordinate` class, create a new Verse file named `utilities.verse`. Within this file, create a new module named `DataTypes`.

```verse
DataTypes<public> := module:
```

Add to this module the new `TileCoordinate` class and define the components of the class.

```verse
using { /Verse.org/Simulation }

DataTypes<public> := module:

	tile_coordinate<public> := class<concrete>:
		@editable
		Left<public>:int = 0
		@editable
		Forward<public>:int = 0
```

In Coordinate Battle, you are building a 5 x 5 board grid. This means that you need to define the bounds of the game board. To do this, create a new class `bounds` that defines a low and high bound on how small or large a `tile_coordinate``Left` or `Forward` value can be.

```verse
using { /Verse.org/Simulation }

DataTypes<public> := module:

	tile_coordinate<public> := class<concrete>:
		@editable
		Left<public>:int = 0
		@editable
		Forward<public>:int = 0

	bounds<public> := class<concrete>:
		@editable
		Low<public>:int = 0
		@editable
		High<public>:int = 0
```

You want a structure that will hold the bounds for a single game board in one data structure. To do this, create a new class`board_bounds` that defines a low and high bound for each of the components of a `tile_coordinate`.

```verse
using { /Verse.org/Simulation }

DataTypes<public> := module:

	tile_coordinate<public> := class<concrete>:
		@editable
		Left<public>:int = 0
		@editable
		Forward<public>:int = 0

	bounds<public> := class<concrete>:
		@editable
		Low<public>:int = 0
		@editable
		High<public>:int = 0

	board_bounds<public> := class<concrete>:
		@editable
		LeftBounds<public>:bounds = bounds{}
		@editable
		ForwardBounds<public>:bounds = bounds{}
```

### Define Game Board

You now have structures to:

- Define a representation of a tile in board space.
- Define the limits of board space.

A large piece is still missing — the game board itself. To define the game board, create a new Verse file named `board.verse` and add a new Verse device named `board`.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Assets }
using { DataTypes }
using { UtilityFunctions }

board<public> := class(creative_device):
```

The board should include a few things:

- Where is the board located in world space?
- What are the bounds of the board?
- What is the size of a board tile?

The first question does not need a new variable; you can use the built-in transform of the device itself. You can obtain the `transform` of a Creative device with the `GetTransform` API function.

The second question can be defined with a `board_bounds` variable.

The third question can be solved by defining a `vector2` variable to track the tile size.

The last two of these are added as fields for your `board` device.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Assets }
using { DataTypes }
using { UtilityFunctions }

board<public> := class(creative_device):

    @editable
    Bounds<public>:board_bounds = board_bounds{}

    @editable
    TileSize<public>:vector2 = vector2{}
```

### Convert from Board Space to World Space

Next, determine where a tile is located in the world as a `vector3`, given a location on the game board as a `tile_coordinate`. Name this function `ToVector3`. This must be done within the confines of a game board to know where the center of the game board is located.

There is a particular ambiguity that you will need to address first. Given a `tile_coordinate`, there are many different `vector3` world locations on the same tile. In the language of mathematics, this is a one-to-many function. Ideally, you would choose a single world location to say where the tile lives in world space. A natural choice is the center of the tile.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Assets }
using { DataTypes }
using { UtilityFunctions }

board<public> := class(creative_device):

	<#
		...
	#>

ToVector3<public>(TileLocation:tile_coordinate)<transacts>:vector3 =
		BoardTransform:transform = GetTransform()
		CenterOfBoard:vector3 = BoardTransform.Translation
		TileOffsetFromCenter:vector3 = vector3:
			X := (TileLocation.Forward * TileSize.X)
			Y := (-TileLocation.Left * TileSize.Y)
			Z := 0.0
		CenterOfBoard + TileOffsetFromCenter
```

This function performs the following:

- It obtains the transform of the board in world space.
- It obtains the location of the board in world space from the transform.
- It calculates the offset of the input tile with respect to the center of the board.
- It adds the offset to the center of the board location to get the location with respect to the center of the world.

### Convert from World Space to Board Space

If you have a location in world space as a `vector3`, you will need to convert it to a `tile_coordinate`.

Construct a function named `ToTileCoordinate`. This function takes in a `vector3` as its argument and returns a `tile_coordinate`. Given a location in world space as a `vector3`, it is a bit more complex to determine the location on the game board as a `tile_coordinate`.

The main reason this is more complex is that since the board is a discrete grid, there are many locations in world space that are not part of the game board. Therefore, given a location in world space as a `vector3`, it is possible that the location is not on the game board at all. This makes ToTileCoordinate a prime candidate to have the `<decides>` function effect specifier. The reason it is a perfect candidate is because there are many locations in the game world that do not live on a tile coordinate. In this case, attempting to convert one fails. It is important to know when this conversion succeeds or fails. The function `ToTileCoordinate` first decides whether a location is one the game board, and, if it is, returns that `tile_coordinate` location.

Another reason for the increased complexity is that a single tile is made up of many different world locations. In mathematics, this makes the `ToTileCoordinate` function a many-to-one function.

To make things cleaner, make the failure part of `ToTileCoordinate` separate, define a function `IsTileCoordinateOnBoard` separately, and call it within `ToTileCoordinate`.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Assets }
using { DataTypes }
using { UtilityFunctions }

board<public> := class(creative_device):

	<#
		...
	#>

	IsTileCoordinateOnBoard<public>(TileCoordinate:tile_coordinate)<decides><transacts>:void =
		Bounds.LeftBounds.Low <= TileCoordinate.Left <= Bounds.LeftBounds.High
		Bounds.ForwardBounds.Low <= TileCoordinate.Forward <= Bounds.ForwardBounds.High

	ToTileCoordinate<public>(WorldLocation:vector3)<decides><transacts>:tile_coordinate =
		BoardTransform:transform = GetTransform()
		CenterOfBoard:vector3 = BoardTransform.Translation
		ShiftedWorldLocation:vector3 = WorldLocation - CenterOfBoard
		LocationAsTileCoordinate:tile_coordinate = tile_coordinate:
			Left := Floor[-ShiftedWorldLocation.Y / TileSize.Y]
			Forward := Floor[ShiftedWorldLocation.X / TileSize.X]
		IsTileCoordinateOnBoard[LocationAsTileCoordinate]
		LocationAsTileCoordinate
```

The function `IsTileCoordinateOnBoard` performs the following:

- Determines whether the input tile coordinate's left component is between the board bounds
- Determines whether the input tile coordinate forward component is between the board bounds

The function `IsTileCoordinateOnBoard` succeeds if the input tile coordinate is within the board bounds and fails otherwise.

The function `ToTileCoordinate` performs the following:

- It obtains the world space transform of the board.
- It obtains the center of the board location from the world space.
- It calculates the relative position of the world location with respect to the center of the board.
- It converts the relative world location to a tile coordinate.
- It determines whether the tile coordinate is on the board.
- It returns the tile coordinate if it is on the board.

The function `ToTileCoordinate` succeeds if and only if `IsTileCoordinateOnBoard` succeeds.

### Example

The section below works through an example of taking a `tile_coordinate` and converting to a `vector3`, then taking that same `vector3` and converting it back to a `tile_coordinate`.

#### Tile Coordinate to Vector3

Suppose you have the following:

- A game board that is 5 by 5 tiles.
- A game tile that is 512.0 by 512.0 units square.
- The game board is located at X := 5000.0, Y:= 0.0, Z := 1000.0 in world space.

Below are the steps to convert the tile with tile coordinates `Left := -1`, `Forward := 2.0` to world space.

```verse
ToVector3(tile_coordinate{Left := -1, Forward := 2.0})

BoardTransform:transform = GetTransform()
# BoardTransform := transform{Translation := vector3{X := 5000.0, Y := 0.0, Z := 1000.0}, ...}

CenterOfBoard:vector3 = BoardTransform.Translation
# CenterOfBoard := vector3{X := 5000.0, Y := 0.0, Z := 1000.0}

	TileOffsetFromCenter:vector3 = vector3:
		X := (TileLocation.Forward * TileSize.X)
		Y := (-TileLocation.Left * TileSize.Y)
		Z := 0.0

<# 
TileOffsetFromCenter := vector3:
	X := (2.0 * 512.0) 		= 1024.0
	Y := (- (-1.0) * 512.0)	= 512.0
	Z := 0.0			= 0.0
#>

CenterOfBoard + TileOffsetFromCenter

<# 
vector3{X := 5000.0, Y := 0.0, Z := 1000.0} + vector3{X := 1024.0, Y := 512.0, Z := 0.0} 
= vector3{X := 6024.0, Y := 512.0, Z := 1000.0}
#>
```

Next are the steps to convert back using the function `ToTileCoordinate`.

```verse
ToTileCoordinate(vector3{X := 6024.0, Y := 512.0, Z := 1000.0}):

	BoardTransform:transform = GetTransform()
# BoardTransform := transform{Translation := vector3{X := 5000.0, Y := 0.0, Z := 1000.0}, ...}

CenterOfBoard:vector3 = BoardTransform.Translation
# CenterOfBoard := vector3{X := 5000.0, Y := 0.0, Z := 1000.0}

ShiftedWorldLocation:vector3 = WorldLocation - CenterOfBoard
# ShiftedWorldLocation := vector3{X := 6024.0, Y := 512.0, Z := 1000.0} - vector3{X := 5000.0, Y := 0.0, Z := 1000.0}
# ShiftedWorldLocation := vector3{X := 1024.0, Y := 512.0, Z := 0.0}

	LocationAsTileCoordinate:tile_coordinate = tile_coordinate:
		Left := Floor[-ShiftedWorldLocation.Y / TileSize.Y]
		Forward := Floor[ShiftedWorldLocation.X / TileSize.X]

	<#
	LocationAsTileCoordinate := tile_coordinate:
		Left := Floor[-512.0 / 512.0]		= Floor[-1.0] 	= -1
		Forward := Floor[1024.0 / 512.0]		= Floor[2.0]		= 2
	#>

	IsTileCoordinateOnBoard[tile_coordinate{Left := -1, Forward := 2}] 
	# Succeeds

	LocationAsTileCoordinate
	# tile_coordinate{Left := -1, Forward := 2}
```

This last `tile_coordinate` is exactly the same as the initial value, meaning that everything worked as expected.

### Summary

To summarize, this page has taken you through the following steps:

1. Define a representation of a tile in board space.
2. Define the limits of board space.
3. Define where board space is located within world space.
4. Convert between board space and world space.

## Files

```verse
using { /Verse.org/Simulation }

DataTypes<public> := module:

	tile_coordinate<public> := class<concrete>:
		Left<public>:int = 0
		Forward<public>:int = 0

	bounds<public> := class<concrete>:
		@editable
		Low<public>:int = 0
		@editable
		High<public>:int = 0

	board_bounds<public> := class<concrete>:
		@editable
		LeftBounds<public>:bounds = bounds{}
		@editable
		ForwardBounds<public>:bounds = bounds{}
```

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Assets }
using { DataTypes }
using { UtilityFunctions }

board<public> := class(creative_device):

	@editable
	Bounds<public>:board_bounds = board_bounds{}

	@editable
	TileSize<public>:vector2 = vector2{}

	# tile_coordinate within board_bounds
	IsTileCoordinateOnBoard<public>(TileCoordinate:tile_coordinate)<decides><transacts>:void =
		Bounds.LeftBounds.Low <= TileCoordinate.Left <= Bounds.LeftBounds.High
		Bounds.ForwardBounds.Low <= TileCoordinate.Forward <= Bounds.ForwardBounds.High

	# tile_coordinate -> vector3
ToVector3<public>(TileLocation:tile_coordinate)<decides><transacts>:vector3 =
IsTileCoordinateOnBoard[TileLocation]
		BoardTransform:transform = GetTransform()
		CenterOfBoard:vector3 = BoardTransform.Translation
		TileOffsetFromCenter:vector3 = vector3:
			X := (TileLocation.Forward * TileSize.X)
			Y := (-TileLocation.Left * TileSize.Y)
			Z := 0.0
		CenterOfBoard + TileOffsetFromCenter

	# vector3 -> tile_coordinate
	ToTileCoordinate<public>(WorldLocation:vector3)<decides><transacts>:tile_coordinate =
		BoardTransform:transform = GetTransform()
		CenterOfBoard:vector3 = BoardTransform.Translation
		ShiftedWorldLocation:vector3 = WorldLocation - CenterOfBoard
		LocationAsTileCoordinate:tile_coordinate = tile_coordinate:
			Left := Floor[-ShiftedWorldLocation.Y / TileSize.Y]
			Forward := Floor[ShiftedWorldLocation.X / TileSize.X]
		IsTileCoordinateOnBoard[LocationAsTileCoordinate]
		LocationAsTileCoordinate
```

type
