# 4. Generate the Board

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/4-generate-the-board
> **爬取时间**: 2025-12-27T00:24:40.112224

---

One of the primary motivations for positioning pawns at runtime is to vary gameplay on each playthrough.

If pawns are placed within the editor and not moved each playthrough, once you play a single round, you will know exactly where those pawns are placed each time. If instead, you randomly place pawns each time, there are multiple starting configurations.

To put this into perspective, if you have a board that is 5 x 5 tiles and five pawns, there are (25 choose 5) 53,130 distinct configurations. If you increase the board by just 1 more space in each dimension to 6 x 6 and keep five pawns, that number goes up to (36 choose 5) 11,686,752.

Randomization can be a powerful tool to create varied gameplay.

### Generate a Random Tile Coordinate

To randomly place a pawn, you need to generate a random tile coordinate within the bounds of a board. There are many different ways to randomly generate a coordinate in two-dimensional space. The most common is **uniform distribution**, which is what you will use for this example. A uniform distribution places an equal likelihood for a pawn to be put on any tile on the board. For more information, see <https://en.wikipedia.org/wiki/Discrete_uniform_distribution> . To this end, construct a utility function named `GenerateUniformRandomTileCoordinate`that takes in a bounds object to know what domain to generate the coordinate within.

To generate a uniformly distributed tile coordinate in two-dimensional space, randomly generate an integer in each dimension independently, then combine them in a tile coordinate object.

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Random }

UtilityFunctions<public> := module:

	...

	GenerateUniformRandomTileCoordinate<public>(BoardBounds:board_bounds)<transacts>:tile_coordinate =
		tile_coordinate:
			Left := GetRandomInt(BoardBounds.LeftBounds.Low, BoardBounds.LeftBounds.High)
			Forward := GetRandomInt(BoardBounds.ForwardBounds.Low, BoardBounds.ForwardBounds.High)
```

This function performs the following steps:

1. Generate a random integer within the left bounds of the board.
2. Generate a random integer within the forward bounds of the board.
3. Combine these into a tile coordinate object.

For a list of more discrete distributions with finite support, see the following table <https://en.wikipedia.org/wiki/List_of_probability_distributions> . You can try to create functions of your own that generate coordinates with respect to some of these distributions and see how the pawn placement changes.

### Ensure Enough Open Spaces

One additional consideration before placing pawns on the board is to determine whether there are enough board spaces available for the number of pawns. This can be done by creating a utility function named ``NumberOfTileCoordinates`` that takes in a board bounds object and outputs the number of tiles on the board.

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Random }

UtilityFunctions<public> := module:

	...

	NumberOfTileCoordinates<public>(BoardBounds:board_bounds)<transacts>:int =
		(BoardBounds.LeftBounds.High - BoardBounds.LeftBounds.Low) * (BoardBounds.ForwardBounds.High - BoardBounds.ForwardBounds.Low)
```

### Randomly Place a Pawn

To randomly place the pawns on the board, you need to know how many pawns to generate. Add this as an editable variable on the board class.

After determining the number of pawns on the board, the procedure for placing pawns is:

1. Ensure there are enough tile coordinates available for the number of pawns with `NumberOfTileCoordinates`.
2. Randomly generate a tile coordinate with `GenerateUniformRandomTileCoordinate`.
3. Decide if there is already a pawn at that coordinate.

   1. If yes, go back to step 1.
   2. If no, go to step 4.
4. Decide if `SetPawn` at the generated coordinate succeeds.

   1. If yes, move on to the next pawn.
   2. If not, produce an error.

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
	
	@editable
	NumberOfPawns:int = 5

	...

	PlacePawns<public>()<decides><transacts>:void =
		NumberOfPawns < NumberOfTileCoordinates(Bounds)
		for (PawnIndex := 0..NumberOfPawns):
			var RandomTileCoordinate:tile_coordinate = tile_coordinate{}
			loop:
				set RandomTileCoordinate = GenerateUniformRandomTileCoordinate(Bounds)
				if (not GetPawn[RandomTileCoordinate]):
					break
			SetPawn[RandomTileCoordinate]
```

This function succeeds if and only if:

- There are enough board spaces for the prescribed number of pawns.
- Each pawn is successfully placed at a coordinate that does not already have a pawn there.

### Generate the Board at Runtime

To generate the board at runtime, all that is left to do is override the board `OnBegin` function and call `PlacePawns`:

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

	OnBegin<override>()<suspends>:void =
		if (PlacePawns[]):
			# Pawns successfully placed
		else:
			# Error!
```

## Summary

To summarize, this page has taken you through the following step:

1. Randomly place all pawns on the board.

### Files

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Random }

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

UtilityFunctions<public> := module:

	AreTileCoordinatesEqual<public>(LeftTileCoordinate:tile_coordinate, RightTileCoordinate:tile_coordinate)<decides><transacts>:void =
		LeftTileCoordinate.Left = RightTileCoordinate.Left
		LeftTileCoordinate.Right = RightTileCoordinate.Right

	GenerateUniformRandomTileCoordinate<public>(BoardBounds:board_bounds)<transacts>:tile_coordinate =
		tile_coordinate:
			Left := GetRandomInt(BoardBounds.LeftBounds.Low, BoardBounds.LeftBounds.High)
			Forward := GetRandomInt(BoardBounds.ForwardBounds.Low, BoardBounds.ForwardBounds.High)

	NumberOfTileCoordinates<public>(BoardBounds:board_bounds)<transacts>:int =
		(BoardBounds.LeftBounds.High - BoardBounds.LeftBounds.Low) * (BoardBounds.ForwardBounds.High - BoardBounds.ForwardBounds.Low)
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

<# Fields #>

	@editable
	Bounds<public>:board_bounds = board_bounds{}

	@editable
	TileSize<public>:vector2 = vector2{}

	@editable
	PawnStaticMesh:?mesh = false

	@editable
	NumberOfPawns:int = 5

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

	PlacePawns<public>()<decides><transacts>:void =
		NumberOfPawns < NumberOfTileCoordinates(Bounds)
		for (PawnIndex := 0..NumberOfPawns):
			var RandomTileCoordinate:tile_coordinate = tile_coordinate{}
			loop:
				set RandomTileCoordinate = GenerateUniformRandomTileCoordinate(Bounds)
				if (not GetPawn[RandomTileCoordinate]):
					break
			SetPawn[RandomTileCoordinate]

<# Events #>

	OnBegin<override>()<suspends>:void =
		if (PlacePawns[]):
			# Pawns successfully placed
```
