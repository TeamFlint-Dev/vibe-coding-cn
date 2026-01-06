# 1. Creating the NPC Behavior

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-template-1-creating-npc-behavior-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:21:54.520566

---

The character in this example uses a [Custom](https://dev.epicgames.com/documentation/en-us/fortnite/npc-types-in-unreal-editor-for-fortnite) type character definition, since they only need to move around, and don't need access to the guard or wildlife API. The character's behavior is driven by a custom Verse Behavior named `verse_commander_character`.

Guards are non-playable characters (NPCs) that can move along designated paths and can become hostile to attack enemy players. Wildlife are animals, like chicken and boar, that can also move along designated paths and attack enemy players.

To get started creating the custom NPC, create a new NPC Behavior named `vese_commander_character` using Verse Explorer. For info on creating your own custom NPC behaviors, see [Create Custom NPC Behavior](https://dev.epicgames.com/documentation/en-us/uefn/create-custom-npc-behavior-in-unreal-editor-for-fortnite).

The character needs to know and manage the following properties:

- **CommandWaitTime**: How long to wait between each command.
- **FocusTime**: How long to force focus on a target. Turning the character left or right is handled by using the character's `focus_interface` to force them to face a particular point to their left or right. Since focusing on a target doesn't complete unless interrupted, this is set to a very low number, just enough time for the character to turn to face a direction.
- **ReachRadius**: This is how close the character needs to get to their navigation target to consider having “reached” it.
- **VerseCommanderMinigame**: This is a reference to the **VerseCommanderMinigame** in the level, and lets the character listen for commands coming from it.
- **VFX and Arrow References**: These reference the different teleport in/teleport out VFX, as well as the Forward Arrow prop which makes it easier to see the character's orientation.

  ```verse
        # A Verse-authored NPC Behavior that can be used within an NPC Definition or a Character Spawner device's Behavior Script Override.
        verse_commander_character<public> := class(npc_behavior):

            # The VFX that play when the NPC teleports out.
            @editable
            CharacterTeleportOutVFX:vfx_spawner_device = vfx_spawner_device{}

            # The VFX that play when the NPC teleports in.
            @editable
            CharacterTeleportInVFX:vfx_spawner_device = vfx_spawner_device{}

            # The amount of time to wait for the VFX to finish playing.
            @editable
            VFXWaitTime:float = 1.75

            # The amount of time to wait between executing commands.
            @editable
            CommandWaitTime:float = 0.25

            # The amount of time to force focus on a target.
            @editable
            FocusTime:float = 0.5

            # The radius for the character to reach their navigation target.
            @editable
            ReachRadius:float = 0.1

            # The offset of the arrow asset from the NPC's position.
            @editable
            ForwardArrowAssetOffset:vector3 = vector3{X := 150.0, Y := 150.0, Z := 0.0}

            # The creative_prop_asset used to spawn the ForwardArrow prop.
            ForwardArrowAsset:creative_prop_asset = DefaultCreativePropAsset

            # The arrow prop that displays the orientation of the NPC.
            var ForwardArrow:creative_prop = creative_prop{}

            # Reference to the verse commander minigame device in the level.
            var VerseCommanderMinigame<private>:verse_commander_minigame = verse_commander_minigame{}
  ```

  Now that we've defined the character's properties, let's define their behaviors and the functions that drive them.

## Character Movement

The character in this game has the following behaviors:

- **Move Forward**: The **Forward** command moves the character forward 1 tile on the gameboard.
- **Turn Right** or **Turn Left**: The **Turn Right** and **Turn Left** commands make the character turn 90 degrees to face their right or left, respectively. This also needs to happen without moving the character from the tile they're standing on.
- **Reset**: When the **Reset** command is issued, the character teleports back to the starting position on the gameboard.
- **Await Commands**: Since the character's movement can't be controlled directly, they need to listen for commands coming from the **VerseCommanderMinigame** device in the level. After executing all of their commands, they'll stand still and await further commands.

The NPC in this template only has a few movement options, being able to move forward in the direction they're facing by one tile, turn right, or turn left. Each of these options is done through the `GetNavTarget()` function, which creates a new navigation target one `TileDistance` away for the character to use. This target is either to the character's local forward, right, or left depending on whether the given command is Forward, Right, or Left.

```verse
# Gets a new navigation target for the NPC based on the current transform and the given command.
GetNavTarget(CurrentTransform:transform, Command:command, TileDistance:vector3):transform=
    # Based on the command, get the character's local forward, right, or left (negative right).
    Direction :=
        if (Command = Commands.Forward):
            CurrentTransform.Rotation.GetLocalForward()
        else if (Command = Commands.TurnRight):
            CurrentTransform.Rotation.GetLocalRight()
        else if (Command = Commands.TurnLeft):
            -CurrentTransform.Rotation.GetLocalRight()
        else:
            CurrentTransform.Rotation.GetLocalForward()

    # Create a new transform for the character to navigate to from the character's current transform.
    var NewTransform:transform = CurrentTransform

    # Multiply the direction of the command and the tile distance then add them to the new transform's X and Y.
    # This creates a new target for the character to navigate to that is either ahead, to the right, or to the left of
    # the direction the character is currently facing.
    set NewTransform.Translation = vector3:
        X := NewTransform.Translation.X + Direction.X * TileDistance.X
        Y := NewTransform.Translation.Y + Direction.Y * TileDistance.Y
        Z := NewTransform.Translation.Z
    
    # Return the new target for the character to navigate to.
    return NewTransform
```

When the NPC receives the Execute signal, they iterate through the list of commands they receive and pass each of them to the `ExecuteCommand()` function. First, they get the `focus_interface` and `navigatable` interface for the character, then perform different actions based on the command. For each of Forward, Right, and Left, they call `GetNavTarget()` to find the new transform for the NPC to use. Then, they either navigate forward to the new transform using `NavigateTo()` from the `navigatable` interface or use the `focus_interface` to focus on the target to their right or left.

```verse
# Executes the given command, either moving the NPC forward one tile or turning them left
# or right.
ExecuteCommand(Command:command, TileSize:vector3)<suspends>:void=
    if:
        # Get the Agent (the NPC).
        Agent := GetAgent[]

        # Gets the Fortnite Character interface, which gets you access to its gameplay data
        # including its AI module for navigation and focus.
        Character := Agent.GetFortCharacter[]

        # Get the Navigatable Interface, this allows you to tell it to move.
        Navigatable := Character.GetNavigatable[]

        # Get the focus interface, which lets you force a character to focus on a target.
        Focusable := Character.GetFocusInterface[]
    then:
        CharacterTransform := Character.GetTransform()
        TargetTile := GetNavTarget(CharacterTransform, Command, TileSize)

        # If the command is forward, create a new navigation target from the target tile.
        if:
            Command = Commands.Forward
        then:
            NavTarget := MakeNavigationTarget(TargetTile.Translation)
            # Navigate the character to the navigation target. The ReachRadius is set to a small float
            # here rather than zero to allow the character a small leniency in how close it needs to get to the
            # exact position of the target.
            NavResult := Navigatable.NavigateTo(NavTarget, ?ReachRadius := ReachRadius)
        # If the command is right or left, force the character to maintain focus on the taget for
        # a short period of time to turn the character to face that target.
        else if:
            Command = Commands.TurnLeft or Command = Commands.TurnRight
        then:
            race:
                Focusable.MaintainFocus(TargetTile.Translation)
                Sleep(FocusTime)
    else:
        ProjectLog("No character to issue commands to")
```

## Character VFX

When the character moves around the gameboard, an arrow prop shows their position and orientation to make visualizing the character from the top-down camera easier. This arrow needs to follow the character around and update as the character turns and moves. The `MoveArrow()` function updates the arrow's position to match the character's, copying their position and orientation. The `CreateArrow()` function spawns the arrow prop and does an initial call to `MoveArrow()` so you can see where the character is right from the start.

```verse
# Creates an arrow prop at the NPC's position that visually shows the orientation of the NPC.
CreateArrow(Agent:agent):void=
    if :
        Character := Agent.GetFortCharacter[]
    then:
        var Transform:transform = Character.GetTransform()
        # Spawn the arrow prop, then set the mesh and material for the prop.
        SpawnPropResult := SpawnProp(ForwardArrowAsset, Transform)
        if:
            SpawnedProp := SpawnPropResult(0)?
        then:
            set ForwardArrow = SpawnedProp
            ForwardArrow.SetMesh(VerseCommander.Meshes.CP_VerseCommander_Floor_01)
            ForwardArrow.SetMaterial(VerseCommander.Materials.MI_CP_VerseCommander_CharacterArrow_01)
            # Update the arrow prop to the position and orientation of the NPC.
            MoveArrow(Agent)
            else:
                SpawnPropIssue:string = case(SpawnPropResult(1)):
                    spawn_prop_result.Ok => "Ok"
                    spawn_prop_result.InvalidSpawnPoint => "Invalid Spawn Point"
                    spawn_prop_result.SpawnPointOutOfBounds => "Spawn Point Outside Island's Boundaries"
                    spawn_prop_result.InvalidAsset => "Asset Is Not a Valid creative_prop"
                    spawn_prop_result.TooManyProps => "Too Many Props Spawned Than Permitted by Island."
                    _ => "Unknown Error"
                ProjectLog("Error spawning prop: {SpawnPropIssue}")

# Update the arrow prop to the position and orientation of the NPC,
# then make the arrow prop visible.
MoveArrow(Agent:agent):void=
    if:
        Character := Agent.GetFortCharacter[]
    then:
        CharacterTransform := Character.GetTransform()
        var ArrowTransform:transform = CharacterTransform
        LocalForward := ArrowTransform.Rotation.GetLocalForward()
        set ArrowTransform.Rotation = ArrowTransform.Rotation.ApplyWorldRotationZ(DegreesToRadians(90.0))
        set ArrowTransform.Translation = ArrowTransform.Translation + LocalForward * ForwardArrowAssetOffset
        set ArrowTransform.Scale = vector3{X := 0.5, Y:= 0.5, Z := 1.0}
        if (ForwardArrow.TeleportTo[ArrowTransform]):
        ForwardArrow.Show()
```

When the character spawns into the board, moves to a new board, or resets to the start of the board through the Reset command, a teleporting animation plays both for teleporting in and teleporting out. To create a teleporting effect, we first call `Hide()` on the character and the arrow, then play the TeleportOutVFX by moving the VFX spawner where the character is and enabling it. Once the teleporting out VFX finishes, we then need to teleport the character to their new position and play the TeleportInVFX at that location. When all that is done, we can then call `Show()` on the character and the arrow prop to show the character in the new position.

```verse
# Hides the NPC and the arrow prop, then teleports both to a new position,
# playing VFX for teleporting in and teleporting out.
PlayVFXAndMoveCharacter(StartPosition:transform)<suspends>:void=
    if:
        Agent := GetAgent[]
        FortCharacter := Agent.GetFortCharacter[]
    then:
        # Hide the NPC and the arrow.
        FortCharacter.Hide()
        ForwardArrow.Hide()

        # Get the character's current position to play the VFX at.
        CurrentPosition:transform = FortCharacter.GetTransform()

        # Move the VFX to the character's current position.
        if (CharacterTeleportOutVFX.TeleportTo[CurrentPosition]):

        # Play the VFX of the character teleporting out.
        CharacterTeleportOutVFX.Enable()

        # Wait for the VFX to finish playing.
        Sleep(VFXWaitTime)

        # Stop the VFX of the character teleporting out.
        CharacterTeleportOutVFX.Disable()

        # Move the VFX to the starting position of the board.
        if (CharacterTeleportInVFX.TeleportTo[StartPosition]):

        # Play the VFX of the character teleporting in.
        CharacterTeleportInVFX.Enable()

        # Move the character to the starting position of the board.
        if (MoveToTile[StartPosition]) {}
        else:
            # Since this expression, moving the character to the start again,
            # breaks the game, its failure is logged to help with debugging.
            # The other failable expressions only play and move the VFX device
            # which are not game breaking and so no need to add extra logging unless actively debugging.
            ProjectLog("Could not teleport character")

        # Show the character and wait for the VFX to finish.
        FortCharacter.Show()

        # Wait for the VFX to finish playing.
        Sleep(VFXWaitTime)

        # Show the NPC and the arrow.
        MoveArrow(Agent)
        ForwardArrow.Show()

        # Stop the VFX of the character teleporting in.
        CharacterTeleportInVFX.Disable()
```

Teleporting the character is done with a helper function `MoveToTile()`, which takes the transform to move the character to and teleports them there. A small offset is added to the transform's Z value to prevent the character from clipping into the floor.

```verse
# Teleports the NPC to the given transform.
MoveToTile(Transform:transform)<transacts><decides>:void=
    # Get the Agent (the NPC).
    Agent := GetAgent[]

    # Gets the Fortnite Character interface, which gets you access to its gameplay data
    # including its AI module for navigation and focus.
    Character := Agent.GetFortCharacter[]

    var NewTransform:transform = Transform
    set NewTransform.Translation.Z += 20.0

    # Teleport the character to the given transform.
    Character.TeleportTo[Transform.Translation, Transform.Rotation]
```

## Processing Commands

When the character is idle on the board, they need to sit and listen for the Execute signal to know what to do next. This happens in the `AwaitCommands()` function. This function has the [suspends](https://dev.epicgames.com/documentation/en-us/uefn/specifiers-and-attributes-in-verse#effectspecifiers) specifier so it can run asynchronously since the character needs to `Await()` the `ExecuteCommandsEvent`. Since commands come in as a tuple that contains an array of commands and the TileSize used for those commands, they each need to be processed in a `for` loop by calling `ExecuteCommand()`. As each command executes, we hide the forward arrow and only show it again when the command finishes executing. Once all commands are finished executing, we signal the Verse Commander Minigame that we're done with commands and are ready for more.

```verse
# Waits for commands to be sent from the verse_commander_minigame, then
# executes each command.
AwaitCommands()<suspends>:void=
    if:
        Agent := GetAgent[]
    then:
        # Wait for commands to be sent from the verse commander minigame.
        ExecuteResult := VerseCommanderMinigame.ExecuteCommandsEvent.Await()

        # For each execute result tuple, execute the command and pass the tile size from the tuple.
        # Then wait for a period of time.
        for (Command : ExecuteResult(0)):
            ForwardArrow.Hide()
            ExecuteCommand(Command, ExecuteResult(1))
            MoveArrow(Agent)
            ForwardArrow.Show()
            Sleep(CommandWaitTime)

        # When finished executing commands, signal that the character has finished moving.
        VerseCommanderMinigame.CharacterFinishedMovingEvent.Signal()
    else:
        ProjectLog("No agent in awaiting commands")
```

Instead of processing new commands, the character can also be reset back to the start of the current gameboard with the Reset button. Since resetting is immediate and doesn't use the command queue, the character needs to listen for it separately from the Execute signal. This happens in the `AwaitReset()` function, which waits for the `BoardResetEvent` to signal from the Verse Commander Minigame. When it does, it calls `PlayVFXAndMoveCharacter()` to move the character back to the starting position of the board.

```verse
# Waits for the current board to be reset, then moves the
# NPC back to the starting position of the board along with VFX.
AwaitReset()<suspends>:void=
    # Wait for the current board to be reset.
    # The event payload is the starting position for the board.
    StartPosition := VerseCommanderMinigame.BoardResetEvent.Await()
    spawn{PlayVFXAndMoveCharacter(StartPosition)}
```

## Running the Character Game Loop

Now that the different functions that process commands are set up, it's time to create the core game loop of the character. The character needs to continuously listen for the Execute signal to process a list of commands, or the Reset signal to reset back to the start of the board. Because waiting for the Execute signal and the Reset signal each need to happen asynchronously, and may occur multiple times per board, you need a separate helper function that handles looping through both. This is handled by the `CharacterCommandLoop()` function, which runs the main game loop for the character. In a race expression, it races between the `AwaitReset()` function and a loop that continuously calls `AwaitCommands()` to make sure the character is always listening for commands.

```verse
# Race between resetting the character to start of the board and awaiting commands for that character.
CharacterCommandLoop()<suspends>:void=
    race:
        AwaitReset()
        loop:
            AwaitCommands()
```

When the game begins, the character won't be present in the level until it spawns from the NPC Spawner. This means that when it spawns, it needs to find the Verse Commander Minigame in the level since it doesn't have a reference to it. It does this using `GetCreativeObjectsWithTag()` to find the object with the [Gameplay Tag](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-tags-in-verse) `verse_commander_minigame_tag`, and setting that as the `VerseCommanderMinigame`. When creating your own minigame experience, make sure to properly set your tags so characters in the level can find the objects they need to communicate with.

After finding the Verse Commander Minigame, the character needs to spawn the forward arrow that follows them around using `CreateArrow()`. To run the game loop, it needs to continuously loop the `CharacterCommandLoop()` function to restart it if a Reset signal occurs. This also needs to happen in a [race](https://dev.epicgames.com/documentation/en-us/fortnite/race-in-verse) expression against the `GameEndedEvent` from the Verse Commander Minigame, since if the game ends the character should immediately stop what they're doing.

```verse
# This function runs when the NPC is spawned in the world and ready to follow a behavior.
OnBegin<override>()<suspends>:void=

    # Get the Verse Commander Minigame Device.
    # Assumption is that there is only one device in the level.
    CreativeObjects := GetCreativeObjectsWithTag(verse_commander_minigame_tag{})
    if:
        CreativeObject := CreativeObjects[0]
        MinigameManager := verse_commander_minigame[CreativeObject]
    then:
        if:
            # Get the Agent (the NPC).
            Agent := GetAgent[]

            # Gets the Fortnite Character interface, which gets you access to its gameplay data
            # including its AI module for navigation and focus.
            Character := Agent.GetFortCharacter[]

            # Get the Navigatable Interface, this allows you to tell it to move.
            Navigatable := Character.GetNavigatable[]

            # Get the Focus Interface, this allows you to tell it to look at something or somewhere.
            Focus := Character.GetFocusInterface[]
        then:
            # Keep a reference of the Verse Commander Minigame so the character can receive commands from it.
            set VerseCommanderMinigame = MinigameManager

            # Create the arrow graphic.
            CreateArrow(Agent)

            # Wait two seconds.
            Sleep(CommandWaitTime)

            # Race between the minigame ending and the character performing commands on loop.
            race:
                loop:
                    CharacterCommandLoop()
                VerseCommanderMinigame.GameEndedEvent.Await()
        else:
            ProjectLog("Not able to get character")
    else:
        # If code falls here something failed when setting up the character for the game.
        ProjectLog("Error in NPC Behavior Script on NPC Setup")
```

## Next Step

We've defined a custom NPC that takes command data from a Verse device and uses it to move around a gameboard. You can find the full list of code to create the custom character in the final step [7. Final Result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-07-final-result-in-unreal-editor-for-fortnite).

In the next step, you'll learn how to create a board for the character to be able to move around on and solve its puzzle.

[![2. Defining Boards for the Game](https://dev.epicgames.com/community/api/documentation/image/aa8ee667-63cb-4225-aa8d-36ef417da110?resizing_type=fit&width=640&height=640)

2. Defining Boards for the Game

Create modular levels that you can customize in Unreal Editor for Fortnite using Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-02-defining-boards-for-the-game-in-unreal-editor-for-fortnite)
