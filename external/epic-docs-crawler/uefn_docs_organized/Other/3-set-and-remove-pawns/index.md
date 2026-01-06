# 3. Set and Remove Pawns

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/3-set-and-remove-pawns
> **爬取时间**: 2025-12-27T00:24:32.469847

---

Now that the board is constructed, you will place pawns on the board, check whether a pawn exists at a particular tile coordinate, and remove a pawn from the board.

Start with the following scenario. Given a `tile_coordinate`, determine whether there is a pawn there, and, if there is, retrieve it. The idea is as follows:

- The board holds an array of `creative_prop` pawns.
- Iterate through the existing pawns and obtain each pawn location as a tile coordinate.
- If there is a pawn at the given tile coordinate, retrieve it.
- If there is not, the function fails.

### Determine Tile Coordinate Equality

This requires that you have the ability to test whether two tile\_coordinate's are equal. This is necessary because our custom tile coordinate data type is not a subtype of Verse's built-in comparable type. As a result, you need to manually define what it means for two tile coordinates to be equal. First, create a `AreTileCoordinatesEqual` function in the `DataTypes`module to determine this:

```verse
using { /Verse.org/Simulation }

DataTypes<public> := module:

	...

UtilityFunctions<public> := module:

	...

	AreTileCoordinatesEqual<public>(LeftTileCoordinate:tile_coordinate, RightTileCoordinate:tile_coordinate)<decides><transacts>:void =
		LeftTileCoordinate.Left = RightTileCoordinate.Left
		LeftTileCoordinate.Forward = RightTileCoordinate.Forward
```

This function succeeds if and only if each component of the two input tile coordinates are equal as integers.

### Get Tile Coordinate of Prop

Working with the pawns requires obtaining the location of a pawn as a tile coordinate. To this end, also write a helper function to get the location of a creative prop as a tile coordinate:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Assets }
using { DataTypes }
using { UtilityFunctions }

board<public> := class(creative_device):

	...

GetTileCoordinate<public>(Pawn:creative_prop)<decides><transacts>:tile_coordinate =
        	PawnWorldTransform := Pawn.GetTransform()
PawnWorldLocation := PawnWorldTransform.Translation
       	ToTileCoordinate[PawnWorldLocation]
```

This function succeeds if and only if the world location of the input creative prop can be converted to a tile coordinate on the game board. It also uses the function `ToTileCoordinate` previously defined to convert a world location to a board space location.

### Get Pawn from Tile Coordinate

Write the `GetPawn` function:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Assets }
using { DataTypes }
using { UtilityFunctions }

board<public> := class(creative_device):

	...

	var<private> Pawns:[]creative_prop = array{}

	...

	GetPawn<public>(TileCoordinate:tile_coordinate)<decides><transacts>:creative_prop =
		# Find all pawns at the input location
		FoundPawns := for:
			Pawn : Pawns
			PawnTileCoordinate := GetTileCoordinate[Pawn]
			AreCoordinatesEqual[PawnTileCoordinate, TileCoordinate]
		do:
			Pawn

		# Ensure there is only one there
		FoundPawns.Length = 1
		
		# Return the only pawn at the input location
		FoundPawns[0]
```

This function performs the following steps:

1. It iterates through all existing pawns on the board.
2. It obtains the pawn's location as a tile coordinate.
3. If the pawn's location is the same as the input location, it stores it as a found pawn.
4. It ensures that only a single pawn was found at that location.
5. It returns that one pawn.

This function succeeds if and only if there is exactly one pawn at the input tile coordinate and that pawn is successfully retrieved from the Pawns array.

### Set Pawn at Tile Coordinate

Write a function to place a single pawn on the board. To keep it simple, use `creative_prop` objects as the pawns and use a `SM_Box_asset` as the pawn mesh. You can always change these later to custom objects of your choosing. The idea is:

1. The board holds an array of `creative_prop` pawns.
2. Given a `tile_coordinate`, check if there is already a pawn there.
3. If no pawn exists, place one there.

Write the `SetPawn` function:

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
	PawnStaticMesh:mesh = Meshes.SM_Box_asset

	...

	SetPawn<public>(TileCoordinate:tile_coordinate)<decides><transacts>:void =
		IsTileCoordinateOnBoard[TileCoordinate]

		# Are there any pawns at the input location?
		FoundPawns := for:
			Pawn : Pawns
			PawnTileCoordinate := GetTileCoordinate[Pawn]
			AreCoordinatesEqual[PawnTileCoordinate, TileCoordinate]
		do:
			Pawn

		# Ensure there are no pawns there already
		FoundPawns.Length = 0
		
		# Construct the pawn
		PawnWorldLocation := ToVector3[TileCoordinate]
		PawnSpawnResult := SpawnProp(DefaultCreativePropAsset, PawnWorldLocation, IdentityRotation())
		PawnPropTemp := PawnSpawnResult(0)?
		PawnPropTemp.SetMesh(PawnStaticMesh)
		
		# Add pawn to pawns array
		set Pawns += array{PawnPropTemp}
```

This function performs the following steps:

1. Ensures the input tile coordinate is on the board.
2. Finds all pawns currently at the input tile coordinate.
3. Ensures there are no pawns found there.
4. Attempts to spawn a prop at the input location.

This function succeeds if and only if:

- There are no pawns currently at the input tile coordinate.
- The input tile coordinate is on the board and can be converted to a world location.

### Remove a Pawn

One last function needed is the ability to remove a pawn from the board. This function takes in the creative prop to remove then removes it from the board and the bookkeeping `Pawns` array.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Assets }
using { DataTypes }
using { UtilityFunctions }

board<public> := class(creative_device):

	...

	RemovePawn<public>(PawnToRemove:creative_prop)<decides><transacts>:void =
		# Props are not comparable, get all props but the one to remove
		RemainingPawns := for:
			Pawn : Pawns
			PawnTileCoordinate := GetTileCoordinate[Pawn]
			PawnToRemoveTileCoordinate := GetTileCoordinate[PawnToRemove]
			not AreTileCoordinatesEqual[PawnTileCoordinate, PawnToRemoveTileCoordinate]
		do:
			Pawn
	
		# Ensure remaining pawns is 1 less than before
		RemainingPawns.Length = Pawns.Length - 1
	
		# Update Pawns array and dispose of pawn
		set Pawns = RemainingPawns
		PawnToRemove.Dispose()
```

## Summary

To summarize, this page has taken you through the following steps:

1. Place a pawn on the board.
2. Get a pawn from the board.
3. Remove a pawn from the board.

## Files

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

	AreTileCoordinatesEqual<public>(LeftTileCoordinate:tile_coordinate, RightTileCoordinate:tile_coordinate)<decides><transacts>:void =
		LeftTileCoordinate.Left = RightTileCoordinate.Left
		LeftTileCoordinate.Right = RightTileCoordinate.Right
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

	@editable
	PawnStaticMesh:mesh = Meshes.SM_Pawn

	var<private> Pawns:[]creative_prop = array{}

	<# Tile <--> World #>

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

	<# Pawns #>

	GetPawn<public>(TileCoordinate:tile_coordinate)<decides><transacts>:creative_prop =
		# Find all pawns at the input location
		FoundPawns := for:
			Pawn : Pawns
			PawnWorldTransform := Pawn.GetTransform()
			PawnWorldLocation := PawnWorldTransform.Translation
			PawnTileCoordinate := ToTileCoordinate[PawnWorldLocation]
			AreCoordinatesEqual[PawnTileCoordinate, TileCoordinate]
		do:
			Pawn

		# Ensure there is only one there
		FoundPawns.Length = 1
		
		# Return the only pawn at the input location
		FoundPawns[0]

	SetPawn<public>(TileCoordinate:tile_coordinate)<decides><transacts>:void =
		# Are there any pawns at the input location?
		FoundPawns := for:
			Pawn : Pawns
			PawnWorldTransform := Pawn.GetTransform()
			PawnWorldLocation := PawnWorldTransform.Translation
			PawnTileCoordinate := ToTileCoordinate[PawnWorldLocation]
			AreCoordinatesEqual[PawnTileCoordinate, TileCoordinate]
		do:
			Pawn

		# Ensure there are no pawns there already
		FoundPawns.Length = 0
		
		# Construct the pawn
		PawnMesh := PawnStaticMesh?
		PawnWorldLocation := ToVector3[TileCoordinate]
		PawnSpawnResult := SpawnProp(DefaultCreativePropAsset, PawnWorldLocation, IdentityRotation())
		PawnPropTemp := PawnSpawnResult(0)?
PawnMesh := PawnStaticMesh?
		PawnPropTemp.SetMesh(PawnMesh)
		
		# Add pawn to pawns array
		set Pawns += array{PawnPropTemp}

	RemovePawn<public>(PawnToRemove:creative_prop)<decides><transacts>:void =
		# Props are not comparable, get all props but the one to remove
		RemainingPawns := for:
			Pawn : Pawns
			PawnTileCoordinate := GetTileCoordinate[Pawn]
			PawnToRemoveTileCoordinate := GetTileCoordinate[PawnToRemove]
			not AreTileCoordinatesEqual[PawnTileCoordinate, PawnToRemoveTileCoordinate]
		do:
			Pawn
	
		# Ensure remaining pawns is 1 less than before
		RemainingPawns.Length = Pawns.Length - 1
	
		# Update Pawns array and dispose of pawn
		set Pawns = RemainingPawns
		PawnToRemove.Dispose()
```
