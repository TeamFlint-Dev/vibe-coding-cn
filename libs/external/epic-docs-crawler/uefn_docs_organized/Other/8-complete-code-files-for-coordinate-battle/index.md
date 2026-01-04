# 8. Complete Code Files for Coordinate Battle

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/8-complete-code-files-for-coordinate-battle
> **爬取时间**: 2025-12-27T00:23:50.873642

---

### utilities.verse

```verse
using{/Verse.org/Simulation}
using{/Verse.org/Random}
using{/UnrealEngine.com/Temporary/SpatialMath}

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

	marker_type<public> := enum<open>:
		Hit
		Miss
		Unknown

	move_type<public> := enum<open>:
		Attack
		Reveal
		Unknown

UtilityFunctions<public> := module:

	using{DataTypes}

	Abs(TileCoordinate:tile_coordinate)<transacts>:tile_coordinate = 
		tile_coordinate:
			Left := Abs(TileCoordinate.Left)
			Forward := Abs(TileCoordinate.Forward)

	operator'-'(LeftTileCoordinate:tile_coordinate, RightTileCoordinate:tile_coordinate)<transacts>:tile_coordinate =
		tile_coordinate:
			Left := LeftTileCoordinate.Left - RightTileCoordinate.Left
			Forward := LeftTileCoordinate.Forward - RightTileCoordinate.Forward

	ManhattanDistance<public>(TileCoordinateOne:tile_coordinate, TileCoordinateTwo:tile_coordinate)<transacts>:int =
		Difference := Abs(TileCoordinateOne - TileCoordinateTwo)
		Difference.Left + Difference.Forward

	AreTileCoordinatesEqual<public>(LeftTileCoordinate:tile_coordinate, RightTileCoordinate:tile_coordinate)<decides><transacts>:void =
		LeftTileCoordinate.Left = RightTileCoordinate.Left
		LeftTileCoordinate.Forward = RightTileCoordinate.Forward

	GenerateUniformRandomTileCoordinate<public>(BoardBounds:board_bounds)<transacts>:tile_coordinate =
		tile_coordinate:
			Left := GetRandomInt(BoardBounds.LeftBounds.Low, BoardBounds.LeftBounds.High)
			Forward := GetRandomInt(BoardBounds.ForwardBounds.Low, BoardBounds.ForwardBounds.High)

	NumberOfTileCoordinates<public>(BoardBounds:board_bounds)<transacts>:int =
		(BoardBounds.LeftBounds.High - BoardBounds.LeftBounds.Low) * (BoardBounds.ForwardBounds.High - BoardBounds.ForwardBounds.Low)
```

### board.verse

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Assets }
using { DataTypes }
using { UtilityFunctions }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
board<public> := class(creative_device):

    <# Variable Fields #>

    @editable
    Bounds<public>:board_bounds = board_bounds{}

    @editable
    TileSize<public>:vector2 = vector2{}

    @editable
    PawnStaticMesh:mesh = Meshes.SM_Box

    @editable
    NumberOfPawns:int = 5

    var<private> Pawns:[]creative_prop = array{}

    <# Function Fields - Utilities #>

    GetDimensions<public>()<transacts>:vector3 = 
        vector3:
            Y := -1.0 * (Bounds.LeftBounds.High - Bounds.LeftBounds.Low)
            X := 1.0 * (Bounds.ForwardBounds.High - Bounds.ForwardBounds.Low)

    GetTileCoordinate<public>(Pawn:creative_prop)<decides><transacts>:tile_coordinate =
        PawnWorldTransform := Pawn.GetTransform()
        PawnWorldLocation := PawnWorldTransform.Translation
        ToTileCoordinate[PawnWorldLocation]

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
            PawnTileCoordinate := GetTileCoordinate[Pawn]
            AreTileCoordinatesEqual[PawnTileCoordinate, TileCoordinate]
        do:
            Pawn

        # Ensure there is only one there
        FoundPawns.Length = 1
        
        Print("Pawn found")
        # Return the only pawn at the input location
        FoundPawns[0]

    SetPawn<public>(TileCoordinate:tile_coordinate)<decides><transacts>:void =
        # Are there any pawns at the input location?
        FoundPawns := for:
            Pawn : Pawns
            PawnTileCoordinate := GetTileCoordinate[Pawn]
            AreTileCoordinatesEqual[PawnTileCoordinate, TileCoordinate]
        do:
            Pawn

        # Ensure there are no pawns there already
        FoundPawns.Length = 0
        
        # Construct the pawn
        PawnMesh := PawnStaticMesh
        PawnSpawnWorldLocation := ToVector3[TileCoordinate]
        PawnSpawnResult := SpawnProp(DefaultCreativePropAsset, PawnSpawnWorldLocation, IdentityRotation())
        PawnPropTemp := PawnSpawnResult(0)?
        PawnPropTemp.SetMesh(PawnMesh)
        
        # Add pawn to pawns array
        set Pawns += array{PawnPropTemp}
        Print("Pawn set: Left: {TileCoordinate.Left}, Forward: {TileCoordinate.Forward}")

    RemovePawn(PawnToRemove:creative_prop)<decides><transacts>:void =
        RemainingPawns := for:
            Pawn : Pawns
            PawnTileCoordinate := GetTileCoordinate[Pawn]
            PawnToRemoveTileCoordinate := GetTileCoordinate[PawnToRemove]
            not AreTileCoordinatesEqual[PawnTileCoordinate, PawnToRemoveTileCoordinate]
        do:
            Pawn
        RemainingPawns.Length = Pawns.Length - 1
        set Pawns = RemainingPawns
        Print("Pawn removed")

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
            Print("Successfully placed all pawns")
```

### miniboard.verse

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

### game\_manager.verse

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { DataTypes }
using { UtilityFunctions }

per_player_objects<public> := class:
    @editable
    Board<public>:board
    @editable
    Miniboard<public>:miniboard
    var AttackedTiles<public>:[]tile_coordinate = array{}
    MoveEvent<public>:event(tuple(tile_coordinate, move_type)) = event(tuple(tile_coordinate, move_type)){}
    CoordinateChangeEvent<public>:event(tile_coordinate) = event(tile_coordinate){}

# A Verse-authored creative device that can be placed in a level
game_manager := class(creative_device):

    var PerPlayerManagement:weak_map(agent, per_player_objects) = map{}

    @editable
    PerPlayerObjects:[]per_player_objects = array{}

    @editable
    RevealDistance:int = 1

    AssignPlayerObjects():void =
        for (Index -> Player : GetPlayspace().GetPlayers()):
            if:
                PlayerObjects := PerPlayerObjects[Index]
                set PerPlayerManagement[Player] = PlayerObjects
            then:
                # Set player objects successfully
            else:
                # Failed to set player objects, potentially not enough object pools
                Print("Not enough object pools")

    GameLoop()<suspends>:void =
        Players := GetPlayspace().GetPlayers()
        if :
            Players.Length = 2
            var TurnPlayer:player = Players[0]
            var OtherPlayer:player = Players[1]
        then:
            loop:
                OnTurn(TurnPlayer, OtherPlayer)
                if (WinConditionMet[TurnPlayer]):
                    # Process player win
                    Print("Player win")
                    break
                else:
                    TempPlayer := TurnPlayer
                    set TurnPlayer = OtherPlayer
                    set OtherPlayer = TempPlayer
        else:
            # Requisite number of players not met
            Print("Requisite number of players not met")

    OnTurn(Player:player, Opponent:player)<suspends>:void =
        if (PlayerObjects := PerPlayerManagement[Player]):
            loop:
                var Continue:logic = false
                race:
                    block:
                        # Listens for a call to PerPlayerManager[Player].CoordinateChangeEvent.Signal(:tile_coordinate)
                        TileCoordinate := PlayerObjects.CoordinateChangeEvent.Await()
                    block:
                        # Listens for a call to PerPlayerManager[Player].MoveEvent.Signal(:tile_coordinate,:move_type)
                        MoveTuple := PlayerObjects.MoveEvent.Await()
                        TileCoordinate := MoveTuple(0)
                        MoveType := MoveTuple(1)
                        case(MoveType):
                            move_type.Attack => block:
                                OnAttack(Player, Opponent, TileCoordinate)
                                set Continue = true
                            move_type.Reveal => block:
                                OnReveal(Player, Opponent, TileCoordinate)
                                set Continue = true
                            _ => void
                if (Continue?):
                    Print("Moving to next player")
                    break

    OnAttack(Instigator:player, Recipient:player, TileCoordinate:tile_coordinate):void = 
        if:
            InstigatorObjects := PerPlayerManagement[Instigator]
            RecipientObjects := PerPlayerManagement[Recipient]
        then:
            # Determine if the attack is a hit
            var MarkerType:marker_type = marker_type.Miss

            Print("Attack coordinate: Left: {TileCoordinate.Left}, Forward: {TileCoordinate.Forward}")

            # Remove the pawn from the board
            if:
                AttackedPawn := InstigatorObjects.Board.GetPawn[TileCoordinate]
                InstigatorObjects.Board.RemovePawn[AttackedPawn]
            then:
                set MarkerType = marker_type.Hit
                Print("Pawn hit")
            else:
                Print("Pawn miss")
                
            # Process the attack with effects here

            # Mark the other player miniboard
            if (RecipientObjects.Miniboard.SetMarker[TileCoordinate, MarkerType]):
                set InstigatorObjects.AttackedTiles += array{TileCoordinate}

    OnReveal(Instigator:player, Recipient:player, TileCoordinate:tile_coordinate):void =
        if:
            InstigatorObjects := PerPlayerManagement[Instigator]
            RecipientObjects := PerPlayerManagement[Recipient]
        then:
            for:
                Pawn : InstigatorObjects.Board.Pawns
                PawnTileCoordinate := InstigatorObjects.Board.GetTileCoordinate[Pawn]
                ManhattanDistance(PawnTileCoordinate, TileCoordinate) < RevealDistance
            do:
                # Process the reveal with effects here
                Print("Pawn reveal")

    WinConditionMet(Player:player)<decides><transacts>:void =
        # Player wins if no pawns remain
        Print("Pawns remaining: {PerPlayerManagement[Player].Board.Pawns.Length}")
        PerPlayerManagement[Player].Board.Pawns.Length = 0

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        AssignPlayerObjects()
        GameLoop()
```
