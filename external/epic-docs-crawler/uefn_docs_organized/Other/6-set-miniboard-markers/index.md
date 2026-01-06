# 6. Set Miniboard Markers

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/6-set-miniboard-markers
> **爬取时间**: 2025-12-27T00:24:17.878118

---

To mark up the miniboard with indicators showing which tiles on your board have been attacked, you need to convert a board tile coordinate to a world location on the miniboard.

### Convert Tile Coordinate to World Transform on Miniboard

The procedure to convert a tile coordinate to a world location on the miniboard is:

1. Obtain the scale factor of the miniboard.
2. Convert the tile coordinate to `vector3`by using the scale factor.
3. Rotate the marker to match the rotation of the miniboard.
4. Return the constructed transform.

Create a function named `GetDimensions` to obtain the dimensions of the game board:

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

	GetDimensions<public>()<transacts>:vector3 = 
		vector3:
			Left := 1.0 * (Bounds.LeftBounds.High - Bounds.LeftBounds.Low)
			Forward := 1.0 * (Bounds.ForwardBounds.High - Bounds.ForwardBounds.Low)
```

Next, you will need a procedure to convert a tile coordinate to a transform located on the miniboard:

1. Ensure that there is a valid miniboard.
2. Obtain the dimensions of the game board.
3. Obtain the relative scale of a tile in miniboard space from the dimensions of the miniboard and the larger board dimensions.
4. Obtain the camera transform.
5. Define the rotation required to rotate the miniboard mesh axis forward.
6. Construct the rotated offset world location with respect to the center of the miniboard.
7. Obtain the miniboard transform.
8. Add the miniboard offset from center to the location of the miniboard to obtain the miniboard transform for the tile coordinate.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { DataTypes }

miniboard<public> := class(creative_device):

	...

	ToMiniboardTransform(TileCoordinate:tile_coordinate)<decides><transacts>:transform =
		Miniboard := MiniboardProp?
		BoardDimensions := GameBoard.GetDimensions()
		MiniboardScaleFactors:vector3 = Dimensions / BoardDimensions
		MiniboardOffset:vector3 = vector3:
			X := TileCoordinate.Forward * MiniboardScaleFactors.X
			Y := -1.0 * (TileCoordinate.Left * MiniboardScaleFactors.Y)
		CameraTransform := CameraDevice.GetTransform()
RotationToFaceCamera:rotation = MakeRotation(vector3{Y := 1.0}, -PiFloat/2.0)
		RotatedMiniboardOffset := CameraTransform.Rotation.RotateVector(RotationToFaceCamera.RotateVector(MiniboardOffset))
		MiniboardTransform := Miniboard.GetTransform()
		transform:
			Translation := MiniboardTransform.Translation + RotatedMiniboardOffset
			Rotation := MiniboardTransform.Rotation
```

### Place a Miniboard Marker

To place a miniboard marker on the miniboard, you need to know:

- The board tile coordinate where the marker is will be located.
- Whether it should be a hit marker or a miss marker.

Construct a new enum to represent the marker type in the `DataTypes` module:

```verse
using{/Verse.org/Simulation}
using{/Verse.org/Random}
using{/UnrealEngine.com/Temporary/SpatialMath}

DataTypes<public> := module:

	...

	marker_type<public> := enum<open>:
		Hit
		Miss
		Unknown
```

Define a function `SetMarker` to place a marker on the miniboard in the miniboard class.

This function performs the following steps:

1. Ensure there is a valid miniboard.
2. Determine what type of marker mesh to use: hit or miss.
3. Obtain the miniboard transform of the input tile coordinate.
4. Spawn the marker.
5. Add the marker to the markers array.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { DataTypes }

miniboard<public> := class(creative_device):

	...

	var<private> Markers:[]creative_prop = array{}

	...

SetMarker<public>(TileCoordinate:tile_coordinate, MarkerType:marker_type)<decides><transacts>:void =
       	# Ensure the miniboard is valid
        	MiniboardProp?

        	# Determine static mesh for marker
        	MarkerStaticMesh:?mesh = case(MarkerType):
            		marker_type.Hit => option{HitMarkerStaticMesh}
            		marker_type.Miss => option{MissMarkerStaticMesh}
            		marker_type.Unknown => false
            		_ => false
       MarkerMesh := MarkerStaticMesh?

       # Get marker transform
       MarkerTransform := ToMiniboardTransform[TileCoordinate]

       # Spawn the marker
       MarkerSpawnResult := SpawnProp(DefaultCreativePropAsset, MarkerTransform)
       MarkerProp := MarkerSpawnResult(0)?
       MarkerProp.SetMesh(MarkerMesh)
       Print("Miniboard marker set")

       # Update markers array
set Markers += array{MarkerProp}
```

## Summary

To summarize, this page has taken you through the following steps:

1. Place a marker on the miniboard.
2. Convert between miniboard space, board space, and world space.

## Files

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Random }

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
		LeftBounds<public>:Bounds = Bounds{}
		ForwardBounds<public>:Bounds = Bounds{}

marker_type := enum<open>:
	Hit
	Miss
	Unknown

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

<# Variable Fields #>

	@editable
	Bounds<public>:board_bounds = board_bounds{}

	@editable
	TileSize<public>:vector2 = vector2{}

	@editable
	PawnStaticMesh:mesh = Meshes.SM_Pawn

	@editable
	NumberOfPawns:int = 5

	var<private> Pawns:[]creative_prop = array{}

<# Function Fields - Utilities #>

	GetDimensions<public>()<transacts>:vector3 = 
		vector3:
			Left := 1.0 * (Bounds.LeftBounds.High - Bounds.LeftBounds.Low)
			Forward := 1.0 * (Bounds.ForwardBounds.High - Bounds.ForwardBounds.Low)

<# Function Fields - Tiles #>

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

<# Function Fields - Pawns #>

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

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { DataTypes }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
miniboard<public> := class(creative_device):

    <# Variable Fields #>

    @editable
    CameraDevice:gameplay_camera_fixed_point_device = gameplay_camera_fixed_point_device{}

    @editable
    StaticMesh:mesh = Meshes.SM_Miniboard

    @editable
    Dimensions:vector3 = vector3{}

    @editable
    HitMarkerStaticMesh:mesh = Meshes.SM_Hit

    @editable
    MissMarkerStaticMesh:mesh = Meshes.SM_Miss

    @editable
    BoardOffsetFromCameraDevice:vector3 = vector3{}

    @editable
    GameBoard:board = board{}

    var<private> MiniboardProp:?creative_prop = false

    RotationToFaceCamera:rotation = MakeRotation(vector3{Y := 1.0}, -PiFloat/2.0)

    var<private> Markers:[]creative_prop = array{}

    <# Function Fields #>

    ToMiniboardTransform(TileCoordinate:tile_coordinate)<decides><transacts>:transform =
        BoardDimensions := GameBoard.GetDimensions()
        MiniboardScaleFactors:vector3 = Dimensions / BoardDimensions
        MiniboardOffset:vector3 = vector3:
            X := TileCoordinate.Forward * MiniboardScaleFactors.X
            Y := -1.0 * (TileCoordinate.Left * MiniboardScaleFactors.Y)
        CameraTransform := CameraDevice.GetTransform()
        RotatedMiniboardOffset := CameraTransform.Rotation.RotateVector(RotationToFaceCamera.RotateVector(MiniboardOffset))
        Miniboard := MiniboardProp?
        MiniboardTransform := Miniboard.GetTransform()
        transform:
            Translation := MiniboardTransform.Translation + RotatedMiniboardOffset
            Rotation := MiniboardTransform.Rotation

    Position<public>():void =
        CameraTransform := CameraDevice.GetTransform()
        StaticMeshRotationCorrection := MakeRotation(vector3{Y := 1.0}, -PiFloat/2.0)
        MiniboardTransform:transform = transform:
            Translation := CameraTransform.Translation + CameraTransform.Rotation.RotateVector(BoardOffsetFromCameraDevice)
            Rotation := CameraTransform.Rotation.RotateBy(StaticMeshRotationCorrection)
        MiniboardSpawnResult := SpawnProp(DefaultCreativePropAsset, MiniboardTransform)
        if (MiniboardPropTemp := MiniboardSpawnResult(0)?, MiniboardStaticMesh := StaticMesh):
            MiniboardPropTemp.SetMesh(MiniboardStaticMesh)
            set MiniboardProp = option{MiniboardPropTemp}
            Print("Miniboard positioned")

    SetMarker<public>(TileCoordinate:tile_coordinate, MarkerType:marker_type)<decides><transacts>:void =
        # Ensure the miniboard is valid
        MiniboardProp?

        # Determine static mesh for marker
        MarkerStaticMesh:?mesh = case(MarkerType):
            marker_type.Hit => option{HitMarkerStaticMesh}
            marker_type.Miss => option{MissMarkerStaticMesh}
            marker_type.Unknown => false
            _ => false
        MarkerMesh := MarkerStaticMesh?

        # Get marker transform
        MarkerTransform := ToMiniboardTransform[TileCoordinate]

        # Spawn the marker
        MarkerSpawnResult := SpawnProp(DefaultCreativePropAsset, MarkerTransform)
        MarkerProp := MarkerSpawnResult(0)?
        MarkerProp.SetMesh(MarkerMesh)
        Print("Miniboard marker set")

        # Update markers array
        set Markers += array{MarkerProp}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Position()
```
