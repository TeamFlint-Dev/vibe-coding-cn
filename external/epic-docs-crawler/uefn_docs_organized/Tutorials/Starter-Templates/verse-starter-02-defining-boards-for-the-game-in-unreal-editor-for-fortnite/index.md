# 2. Defining Boards for the Game

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-02-defining-boards-for-the-game-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:30:34.796489

---

In the previous step, we created an NPC that can move forward, rotate left, and rotate right when it receives commands. Now in this step, we'll set up gameboards that the character can move around on.

For this game, the gameboard needs to know and manage the following:

- **Tile Size**: How big the tiles on the board are so the character knows how far to move.
- **Camera**: What camera to use when the character reaches this gameboard. For this, we use the [Fixed Point Camera](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-fixed-point-camera-devices-in-fortnite-creative) device.
- **Start Position**: The position where the character should start on the board. For this, we use a [Creative Prop](https://dev.epicgames.com/documentation/en-us/fortnite/converting-assets-into-props-in-unreal-editor-for-fortnite) so we can easily set it as an editable property and get its transform.
- **End Goal**: The end goal for the character to progress towards which signals the end of the gameboard. For this, we use a [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative) that signals when the character steps on it.
- **Obstacles**: Obstacles prevent the character from immediately reaching the end goal. These are explained in more detail in [Creating Obstacles](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-02-defining-boards-for-the-game-in-unreal-editor-for-fortnite).

Each of these are tracked in the gameboard's `class`. The class has the concrete specifier so it can be an editable property on a Verse device, and each class member has an editable attribute to be able to change their values from UEFN.

```verse
# This class represents the gameboard and how it behaves.
# This class has the concrete specifier so it can be an editable property on a Verse device.
gameboard<public> := class<concrete>:

    # The size of each tile on the gameboard. By default set to
    # the default Fortnite tile size of 512x512x384.
    @editable
    TileSize<public>:vector3 = vector3{X:=512.0, Y:=512.0, Z:=384.0}

    # The fixed point camera that provides a top-down view of the gameboard
    @editable
    Camera:gameplay_camera_fixed_point_device = gameplay_camera_fixed_point_device{}

    # The trigger device the NPC needs to activate to complete the board.
    @editable
    EndGoal:trigger_device = trigger_device{}

    # The array of obstacles for this gameboard.
    @editable
    Obstacles:[]obstacle = array{}

    # The transform of the NPC's starting position on this board.
    @editable
    var StartingCharacterPosition<public>:creative_prop = creative_prop{}
```

Now that the gameboard is defined with its properties, let's add its behavior:

- **Handling end goal**: When the gameboard is set up, we'll subscribe to the End Goal's `TriggeredEvent`. We use an event handler and a custom event to signal publicly that the end goal was reached when the trigger device is triggered by the character. For more details, check out [Coding Device Interactions](https://dev.epicgames.com/documentation/en-us/fortnite/coding-device-interactions-in-verse).
- **Starting gameboard**: When it's the start of the gameboard, assign the Camera device to all players.
- **Ending gameboard**: When it's the end of the gameboard, remove the Camera device from all players.

The following is the complete class for `gameboard`:

```verse
# This class represents the gameboard and how it behaves.
# This class has the concrete specifier so it can be an editable property on a Verse device.
gameboard<public> := class<concrete>:

    # The size of each tile on the gameboard. By default set to
    # the default Fortnite tile size of 512x512x384.
    @editable
    TileSize<public>:vector3 = vector3{X:=512.0, Y:=512.0, Z:=384.0}

    # The fixed point camera that provides a top-down view of the gameboard
    @editable
    Camera:gameplay_camera_fixed_point_device = gameplay_camera_fixed_point_device{}

    # The trigger device the NPC needs to activate to complete the board.
    @editable
    EndGoal:trigger_device = trigger_device{}

    # The array of obstacles for this gameboard.
    @editable
    Obstacles:[]obstacle = array{}

    # The transform of the NPC's starting position on this board.
    @editable
    var StartingCharacterPosition<public>:creative_prop = creative_prop{}

    @editable
    OpeningCinematic:cinematic_sequence_device = cinematic_sequence_device{}

    # The Z offset to add to the NPC's starting position when spawning them.
    ZOffset:float = 100.0

    # Event that signals when the end goal has been reached.
    EndGoalReached<public>:event() = event(){}

    # Gets the starting transform of the NPC on this gameboard by adding the ZOffest to the starting transform.
    GetStartingCharacterPosition():transform=
        var Transform:transform = StartingCharacterPosition.GetTransform()
        # Add a small Z offset to the transform of the starting position to spawn the NPC
        # slightly in the air. This prevent the NPC from colliding with the ground or other
        # objects when spawning.
        set Transform.Translation.Z += ZOffset
        Transform

    # Call Setup on each obstacle, and subscribe to the EndGoal trigger event.
    Setup<public>():void=
        EndGoal.TriggeredEvent.Subscribe(OnEndGoalEmitted)
        for (Obstacle : Obstacles):
            Obstacle.Setup()

    # Swap the camera view to top-down and play an opening cinematic.
    Start<public>():void=
        Camera.AddToAll()
        OpeningCinematic.Play()

    # Remove the current top-down camera view.
    Stop<public>():void=
        Camera.RemoveFromAll()

    # Signal that the end goal has been reached.
    OnEndGoalEmitted<private>(MaybeAgent:?agent):void=
        EndGoalReached.Signal()

    # Reset all obstacles.
    Reset<public>():void=
        for (Obstacle : Obstacles):
            Obstacle.Reset()
```

## Creating Obstacles

Obstacles prevent the character from immediately reaching the end goal. We use Barrier devices as the obstacles in this game to block the character from moving, and Trigger devices that deactivate the barriers.

Our definition of the `obstacle` class includes:

- **IsObstaclePassed**: Data for storing whether the barriers are currently activated or deactivated. [Logic](https://dev.epicgames.com/documentation/en-us/fortnite/logic-in-verse) type because there are only two states.
- **Barriers**: [Barrier devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-barrier-devices-in-fortnite-creative) associated with the obstacle. This means you can have more than one barrier device attached to a trigger that deactivates them.
- **BarrierDissolves**: [Cinematic sequences](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) to play when obstacles are passed.
- **BarrierAppears**: [Cinematic sequences](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) to play when obstacles are reset.
- **Trigger**: A [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative) for the character to reach to deactivate the obstacle.

The following is the complete class for representing obstacles, and the class has the concrete specifier so it can be an editable property on a Verse device.

```verse
# An obstacle on the gameboard, with an associated set of
# Barrier devices, Trigger devices that deactivate the barriers,
# and Cinematic Sequence devices that play sequences for barriers dissolving and appearing for visual feedback on what is happening.
# This class has the concrete specifier so it can be an editable property on a Verse device.
obstacle := class<concrete>:

    # Data for storing whether barriers are currently enabled/disabled.
    var IsObstaclePassed:logic = false

    # The array of barriers for this obstacle.
    @editable
    Barriers:[]barrier_device = array{}

    # The cinematic sequences for barriers disappearing.
    @editable
    BarrierDissolves:[]cinematic_sequence_device = array{}

    #The cinematic sequences for barriers appearing.
    @editable
    BarrierAppears:[]cinematic_sequence_device = array{}

    # The array of triggers for this obstacle.
    @editable
    Trigger:trigger_device = trigger_device{}

    # Runs when the NPC steps on the obstacle Trigger device.
    # Disables the trigger, each barrier assigned to this obstacle,
    # and plays the cinematic for the barrier dissolving for visual feedback.
    OnObstaclePassed(Agent:?agent):void=
        set IsObstaclePassed = true
        Trigger.Disable()
        for(BarrierDissolve:BarrierDissolves):
            BarrierDissolve.Play()
        for(Barrier:Barriers):
            Barrier.Disable()

    # Set up the obstacle by subscribing to the Trigger device event.
    Setup():void=
        Trigger.TriggeredEvent.Subscribe(OnObstaclePassed)

    # Reset the obstacle by enabling the trigger and barriers assigned to this obstacle,
    # and playing the cinematic for the barriers appearing.
    Reset():void=
        if:
            IsObstaclePassed?
        then:
            set IsObstaclePassed = false
            Trigger.Enable()
            for(BarrierAppear:BarrierAppears):
                BarrierAppear.Play()
            for (Barrier:Barriers):
                Barrier.Enable()
```

## Adding Gameboards

Now that the gameboard is defined, you can add an [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse) of these gameboards to your Verse device, which you'll see later in [6. Managing the Game Loop](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-06-managing-the-game-loop-for-in-unreal-editor-for-fortnite).

1. In the project you created from the **VKT - Verse Device Starter Games** template, search in the Outliner for the **Verse Commander Minigame** device and select it to open its **Details** panel.
2. In the Details panel under **Gameboards**, you'll see five elements that correspond to boards in the game. Expand these elements to see what devices, cinematics, and other properties are used for the gameboard.
3. You can add gameboards by selecting **Add Element** for Gameboards, to add more levels to the game.
4. You can remove gameboards by selecting the dropdown next to the gameboard you want to remove, to remove levels from the game.
5. You can also reorder the gameboards to change the order of the levels in the game by holding down on the element and dragging them before or after other gameboard elements.

To test out specific levels, you can reorder the boards so the level you want to test is the first in the list.

## Next Step

We've defined the gameboards and shown how to add as many as you want. In the next step, you'll learn how to design the boards to develop fun puzzles and work around limitations.

[![3. Designing Levels](https://dev.epicgames.com/community/api/documentation/image/19ab3795-416b-4ebf-a49b-4f92d594909b?resizing_type=fit&width=640&height=640)

1. Designing Levels

Learn how to design levels for a top-down camera and controlling a character through commands.](<https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-03-designing-levels-for-in-unreal-editor-for-fortnite>)
