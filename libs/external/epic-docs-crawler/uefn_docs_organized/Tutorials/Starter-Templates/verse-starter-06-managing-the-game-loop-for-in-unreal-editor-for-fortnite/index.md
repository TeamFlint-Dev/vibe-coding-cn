# 6. Managing the Game Loop

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-06-managing-the-game-loop-for-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:30:48.589690

---

The core behavior of the minigame is defined in the `verse_commander_minigame` Verse device. This device starts the minigame, handles communication between the UI and the character, and runs the boards used in the game.

This device has the following fields that you can modify in the editor:

- **HUDController**: A [HUD Controller device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-controller-devices-in-fortnite-creative) to remove all default Fortnite HUD elements.
- **PlayVerseCommanderButton**: The [Button device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-button-devices-in-fortnite-creative) that starts the minigame.
- **NPCSpawner**: The [NPC Spawner device](using-npc-spawner-devices-in-unreal-editor-for-fortnite) to be able to spawn the character for the minigame.
- **Gameboards**: The list of boards for the game. The boards are played in the order they appear in the list.
- **UICommandLimit**: The max limit of commands that can be queued on screen at the bottom of the list.

The device also contains custom events to communicate with the character and pass info to the character: the list of the commands for the character to execute, and the transform for the character to teleport to when the board is reset.

```verse
# A Verse-authored creative device that can be placed in a level
verse_commander_minigame := class(creative_device):

    # The HUD Controller device for the minigame.
    @editable
    HUDController<private>:hud_controller_device = hud_controller_device{}

    # The button that starts the minigame.
    @editable
    PlayVerseCommanderButton:button_device = button_device{}

    # The NPC spawner that spawns the NPC used in the minigame.
    @editable
    NPCSpawner:npc_spawner_device = npc_spawner_device{}

    # An array of gameboards that the user can customize in the editor.
    # Each element in this array is a level that the character has to complete.
    @editable
    var Gameboards<private>:[]gameboard = array{}

    # The cinematic sequence used to show off design billboards.
    @editable
    Cinematic:billboard_cinematic = billboard_cinematic{}

    # A variable to track which gameboard the character is currently on.
    var CurrentBoard<private>:int = 0

    # Whether this is the first time a gameboard has been played. Used to know when to play
    # intro VFX for the board.
    var FirstTimeOnCurrentBoard<private>:logic = true

    # Minigame events that the character and Verse device can use to communicate with each other.
    ExecuteCommandsEvent:event(tuple([]command, vector3)) = event(tuple([]command, vector3)){}
    BoardResetEvent:event(transform) = event(transform){}
    GameStartedEvent:event() = event(){}
    GameEndedEvent:event() = event(){}
    CharacterFinishedMovingEvent:event() = event(){}

    # Internal events for handling player UI selection.
    ExecuteButtonSelected<private>:event() = event(){}
    ResetButtonSelected<private>:event() = event(){}

    # Define max limit of commands that can be queued on screen.
    @editable
    UICommandLimit<private>:int = 10

    # Keep a reference of the UI for each player so we can update it for each player.
    var UIPerPlayer<private>:[player]verse_commander_minigame_ui = map{}
```

## Starting the Minigame

The Verse Commander Minigame device waits for the player to interact with the Button device at the computer before starting the minigame for all players. This wait is in a loop. Once you finish all the levels you can replay the minigame as many times as you want.

```verse
# Runs when the device is started in a running game.
    OnBegin<override>()<suspends>:void=
        spawn{Cinematic.EnterCinematicModeForAll(GetPlayspace().GetPlayers())}
        loop:
            PlayVerseCommanderButton.InteractedWithEvent.Await()

            Setup()
            # Wait for all Gameboards to be set up.
            Sleep(2.0)

            Start()
```

## Game Loop

The game loop starts by getting the current board. If it's the first time a player is on this board, the character teleports to the board's starting position and the board switches to its camera and plays its opening cinematic.

Then, there's a race between the level loop and waiting on the reset event from the UI. If either of those finish first, it cancels the other. The expressions in the loop then repeat and go back to getting the current board and starting the race again.

```verse
# Loops over the current gameboard and resets them.
GameLoop<private>()<suspends>:void=
    # For the current board, swap to that gameboard's camera and reset the character to the gameboard's starting position.
    loop:
        if:
            Gameboard := Gameboards[CurrentBoard]
        then:
            # If first time on this board, set up the board
            # and move character to starting position.
            if:
                FirstTimeOnCurrentBoard?
            then:
                set FirstTimeOnCurrentBoard = false
                BoardResetEvent.Signal(Gameboard.GetStartingCharacterPosition())
                Gameboard.Start()

            # Race between the gameplay loop and the board reset.
            race:
                LevelLoop(Gameboard)
                AwaitReset(Gameboard)
        else:
            break
```

## Level Loop

The `LevelLoop()` function manages the logic for the gameboard. It races between the command loop for the character and waiting on the board's end goal to be reached. Once the end goal is reached, the command loop is canceled and the next board in the list is called.

The command loop waits for the player to press the Execute button to receive the list of commands to perform. The buttons are deactivated, except for the reset button. The character is signaled to perform the commands and the Verse device waits to receive the finished signal before restarting the loop and waiting for more commands.

A [defer](https://dev.epicgames.com/documentation/en-us/fortnite/defer-in-verse) is used in this loop to clean up the UI if the command loop or `LevelLoop()` function is canceled. The defer expression will call `ResetUIForAllPlayers()` right before exiting the scope to reset the button interactivity so they're enabled again and clear the list of commands at the bottom.

```verse
# Handles command logic for the current gameboard.
LevelLoop<private>(Gameboard:gameboard)<suspends>:void=
    # On the current board, race between completing the board and looping player commands.
    # The race expression will cancel whichever action doesn't finish first.
    race:
        loop:
            defer:
                # If the loop is canceled because the character reached the end goal of the level,
                # Or the character finished performing their commands,
                # reset the UI for all the players so they can interact with it and have no commands in the queue.
                ResetUIForAllPlayers()

            # Wait for the player to choose to execute the commands.
            CommandQueue:[]command := WaitForExecuteCommand()

            if (CommandQueue.Length > 0):
                # Turn off button interactivity for all players until a player chooses to reset or the character finishes its animation.
                TurnOffButtonInteractivityForAllPlayers()

                # Send all the commands to the character to perform.
                ExecuteCommandsEvent.Signal(CommandQueue, Gameboard.TileSize)

                # Wait till the character finishes moving. Then reset the UI for all players.
                CharacterFinishedMovingEvent.Await()
        Gameboard.EndGoalReached.Await()

    # Advance the CurrentBoard to the next board in the Gameboards array.
    # And mark that it's first time on the board.
    set CurrentBoard += 1
    set FirstTimeOnCurrentBoard = true

    # Wait one second.
    Sleep(1.0)

    # Clean up gameboard and stop the current level.
    Gameboard.Stop()
```

## Resetting the Game

The `AwaitReset()` function waits for the player to select the reset button. Once they do, the board resets itself and tells the character to teleport to the starting position on the board.

```verse
# Waits for the Reset button to be selected, then resets the current gameboard
# and NPC.
AwaitReset<private>(Gameboard:gameboard)<suspends>:void=
    ResetButtonSelected.Await()
    # Reset the current gameboard, returning the game character to the starting position and
    # resetting any barriers or triggers on the board.
    BoardResetEvent.Signal(Gameboard.GetStartingCharacterPosition())

    # Reset Gameboard
    Gameboard.Reset()
```

## Next Step

This covers the main functionality of the Verse device for the minigame. You can find the full list of code to create the Verse Commander Minigame device in the next and final step.

[![7. Final Result](https://dev.epicgames.com/community/api/documentation/image/6ab54ba9-be1f-4951-99ca-7c1bc7e09166?resizing_type=fit&width=640&height=640)

7. Final Result

Find all the Verse code used to create the Verse Starter Template.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-07-final-result-in-unreal-editor-for-fortnite)
