# 7. Construct the Game

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/7-construct-the-game>
> **爬取时间**: 2025-12-27T00:23:58.074141

---

The final step is to put all the pieces together through a **game manager**. The game manager controls the assignment of gameplay objects to players and the flow of the game loop. Specifically, the game manager:

- Assigns gameplay objects such as board and miniboard to players.
- Controls the logic of the game loop, including what happens when a move occurs.
- Determines when a player has won and gameplay ends.

### Define the Move Types

During a player's turn, the player chooses a coordinate on the game board. Once a coordinate is chosen, there are two different move types:

- **Attack:** Attempt to destroy the pawn at the given location.
- **Reveal:** Reveal all pawns within a certain radius of a given location.

In the `DataTypes` module, add the following `enum` defining the move types:

```verse
using{/Verse.org/Simulation}
using{/Verse.org/Random}
using{/UnrealEngine.com/Temporary/SpatialMath}

DataTypes<public> := module:

 ...

 move_type<public> := enum<open>:
  Attack
  Reveal
  Unknown
```

Since this enum is open, you can always add more move types in the future.

### Create the Game Manager

Next, create a new Verse file named `game_manager.verse` and add a new creative device named `game_manager`. This will be a single object living in the game world to control the flow of the game.

#### Define Per-Player Objects

Each player has several objects associated with them, including a game board and a miniboard, but also which tiles they have attacked, an event to indicate a move is made, and an event to indicate the chosen coordinate has changed. Define a new class named `per_player_objects`:

```verse
using { /Verse.org/Simulation }

per_player_objects<public> := class:
    @editable
    Board<public>:board
    @editable
    Miniboard<public>:miniboard
    var AttackedTiles<public>:[]tile_coordinate = array{}
    MoveEvent<public>:event(tuple(tile_coordinate, move_type)) = event(tuple(tile_coordinate, move_type)){}
    CoordinateChangeEvent<public>:event(tile_coordinate) = event(tile_coordinate){}
```

#### Define the Game Manager

The game manager class needs to associate players to their player objects. An ideal way to associate a player to an object in Verse is through a `weak_map`. Add the following fields to your game manager class:

```verse
using { /Verse.org/Simulation }

per_player_objects<public> := class:
    @editable
    Board<public>:board
    @editable
    Miniboard<public>:miniboard
    var AttackedTiles<public>:[]tile_coordinate = array{}
    MoveEvent<public>:event(tuple(tile_coordinate, move_type)) = event(tuple(tile_coordinate, move_type)){}
    CoordinateChangeEvent<public>:event(tile_coordinate) = event(tile_coordinate){}

game_manager := class(creative_device):

    var PerPlayerManagement:weak_map(agent, per_player_objects) = map{}

    @editable
    PerPlayerObjects:[]per_player_objects = array{}
```

#### Assign Player Objects

As players join, assign player objects to each player from the `PerPlayerObjects` to the `PerPlayerManagement` object. First, get all of the players in the game, then assign player objects to each player. If there are not enough player objects, handle the error. Add the following `AssignPlayerObjects` function to your game manager:

```verse
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

...

game_manager := class(creative_device):

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
```

#### Define Win Condition

The next thing to do is determine when a player has met the win condition. A player has won if there are no more pawns for them to find and destroy on the board. This is done through directly querying the length of the `Pawns` array in the board. Add the following `WinConditionMet` function to the game manager:

```verse
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

...

game_manager := class(creative_device):

WinConditionMet(Player:player)<decides><transacts>:void =
         # Player wins if no pawns remain
         Print("Pawns remaining: {PerPlayerManagement[Player].Board.Pawns.Length}")
         PerPlayerManagement[Player].Board.Pawns.Length = 0
```

This function succeeds if and only if there are no more pawns left to find and dispose of for the input player.

#### On Attack Move

Now that you know how to assign the game objects to each player and determine whether or not a player has won, the next step is to define what happens during an attack move. When a player attacks one of their opponents tiles, the following steps occur:

1. Determine if there is a pawn on the board at the attack coordinate.
2. If yes:

   1. Remove the pawn from the player's board.
   2. Set a hit marker on the opponent's miniboard.
3. If no:

   1. Set a miss marker on the opponent's miniboard.

Add a function named `OnAttack` to your `game_manager` class with the following definition:

```verse
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
```

#### On Reveal Move

The other move type is the reveal move. This requires some additional setup to work over the attack move. First, add three new functions to your `UtilityFunctions` module:

- `operator'-'`: Define the subtraction binary operation for two `tile_coordinate` objects.
- `Abs`: Obtain the componentwise absolute value of a `tile_coordinate`.
- `ManhattanDistance`: Get the Manhattan or Taxicab distance between two `tile_coordinate` objects.

```verse
UtilityFunctions<public> := module:

 using{DataTypes}

 ...

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
```

The Manhattan Distance computes the distance between two `tile_coordinate` objects by navigating along the cardinal directions on the tile grid. For more information, see <https://en.wikipedia.org/wiki/Taxicab_geometry>.

Now that the utilities are defined, define the behavior of the `OnReveal` function. When a player chooses to reveal pawns in a certain radius of a `tile_coordinate` for their enemy, the following steps occur:

- Find all pawns on the player's board that are within a set `RevealDistance` from the input coordinate according to the `ManhattanDistance`.
- For every pawn within that distance, play a reveal effect.

Add a function named `OnReveal` to your `game_manager` class with the following definition:

```verse
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
```

#### Player Turn

Next, piece together what a player's turn looks like. When it is a player's turn, wait for one of the two different events that could be signaled: `MoveEvent` or `CoordinateChangeEvent`. Whenever one of these events are signaled, abandon the other event, put these events side by side inside a [race](https://dev.epicgames.com/documentation/en-us/fortnite/race-in-verse)  condition. When a coordinate change is signaled, the same player should keep playing until they choose a move type. Therefore, only move on to the next player when attack or reveal is selected.

Add the function `OnTurn` to your `game_manager` class with the following definition:

```verse
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
```

#### Define the Game Loop

You can finally construct the primary game loop now that the player's turn is defined. Within the game loop, the following steps occur:

1. Get all players.
2. Assign one player to have their turn and the other to wait for the first player to move.
3. Loop until one of the player's wins where each takes alternating turns.

To to do this, add the following `GameLoop` function to your `game_manager`class:

```verse
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
```

#### Beginning Gameplay

The last thing to do is assign player objects to each player and begin the game loop. Do this automatically by adding calls to `AssignPlayerObjects` and `GameLoop` to the `OnBegin` function:

```verse
     # Runs when the device is started in a running game
     OnBegin<override>()<suspends>:void=
         AssignPlayerObjects()
         GameLoop()
```

## Summary

To summarize, this page has taken you through the following steps:

1. efine the game moves.
2. Construct the game loop.
3. Determine when a win condition is met.

There are still many things you can do to make this experience uniquely your own, including:

- Designing and implementing a user interface.
- Hooking up when and how the player moves are signaled to the game manager.
- Designing the game world and setting.
- Creating effects for attacks and reveals.
- Adding music design and set dressing.

Feel free to build off these core gameplay classes, reconstruct them, use pieces of them, and make it all your own.

## Files

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
        Sleep(3.0)
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
