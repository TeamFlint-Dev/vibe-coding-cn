# 7. Final Result

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-07-final-result-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:30:27.667461

---

In this final step, you can find all the code used to create the project. Each heading below is the filename in the project where the code lives.

Try to change the code and figure out ways to add more functionality to the minigame. The following are some ideas to get you started:

- Add more levels for the character to solve.
- Keep track of how long it took the player to solve the puzzle or how many moves the character performed per level.
- Add more commands for the character to make more complex puzzles, such as picking up items and placing them on the board.

## submodules.verse

The project file **submodules.verse** sets the access level for submodules and assets in the project so they can be used in the Verse code. For more details, check out step [5. Controlling the NPC with UI](verse-starter-template-5-controlling-npc-with-ui-in-unreal-editor-for-fortnite) and [Exposing Assets to Verse](https://dev.epicgames.com/documentation/en-us/fortnite/exposing-assets-with-asset-reflection-to-verse-in-unreal-editor-for-fortnite).

```verse
# This file sets the access levels for submodules in the project.
# Specifically, this file is making art assets accessible to the Verse files in the project
# so textures, meshes, and materials can be used in the UI and in the game.

# The submodule Textures.MiniGameUI below is the same as the folder
# Textures/MinigameUI that you can see in the project's Content Browser.
Textures := module:
    MiniGameUI<public> := module{}

# The submodule VerseCommander below is the same as the folder
# VerseCommander that you can see in the project's Content Browser.
VerseCommander := module:
    Meshes<public> := module{}
    Materials<public> := module{}
    MiniGameTextures<public> := module{}
```

## verse\_starter\_tags.verse

The project file **verse\_starter\_tags.verse** contains the definition for the [Gameplay Tag](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-tags-in-verse) `verse_commander_minigame_tag` which the Verse Commander Character NPC script can use to find the Verse Commander Minigame device and listen to its events. For more details, check out step [1. Creating the NPC Behavior](verse-starter-template-1-creating-npc-behavior-in-unreal-editor-for-fortnite).

```verse
# This file contains the Gameplay Tags for the project.
# You can use Gameplay Tags to tag an object in the island
# and be able to query all objects that have the tag during the game using Verse.

using { /Verse.org/Simulation/Tags }

# The verse_commander_minigame_tag is for the Verse Commander Character NPC script
# to be able to find the Verse Commander Minigame device and listen to its events.
verse_commander_minigame_tag := class(tag){}
```

## commands.verse

The project file **commands.verse** in the submodule **VerseCommander** contains the data representation of all the commands that the NPC can receive. For more details, check out step [4. Representing Command Data](verse-starter-template-4-representing-command-data-in-unreal-editor-for-fortnite).

```verse
# This file contains the data representation of all the commands that the NPC can receive
# and utilities for the data to help with debugging and troubleshooting issues.

# Each type of command that the NPC can perform will be an instance of this class.
# The class has the unique specifier to make instances of the class comparable.
# The class has the computes specifier to be able to instantiate it at module-scope.
# The class has the abstract specifier so it cannot be instantiated directly, and
# requires subclasses to implement any non-initialized functions, like DebugString().
command := class<computes><unique><abstract>:
    DebugString():string

# The Commands module contains definitions of commands that the NPC can perform.
# This example uses instances of command subclasses instead of the enum type
# so you can add more commands after the initial published version of the project.
Commands := module:
    # The following are subclasses of the command class
    # that implement the abstract command class and define what commands are valid.
    # Each has their own implementation of DebugString(), for example,
    # so when you print a command value it has the correct string associated with it.
    # Since the command class is abstract, it means these subclasses are the only valid commands,
    # otherwise there will be a compiler error.
    forward_command<public> := class<computes><unique>(command):
        DebugString<override>():string = "Forward"

    turnright_command<public> := class<computes><unique>(command):
        DebugString<override>():string = "TurnRight"

    turnleft_command<public> := class<computes><unique>(command):
        DebugString<override>():string = "TurnLeft"

    # Instances of each command type that can be used in the minigame.
    Forward<public>:forward_command = forward_command{}
    TurnRight<public>:turnright_command = turnright_command{}
    TurnLeft<public>:turnleft_command = turnleft_command{}

# Convert the command data to a string to be able to print it when debugging issues.
# For example, Print("Player selected {Command} command.")
ToString(Command:command):string=
    Command.DebugString()
```

## gameboard.verse

The project file **gameboard.verse** in the submodule **VerseCommander** contains the gameboard data and behavior. For more details, check out step [2. Defining Boards for the Game](verse-starter-template-2-defining-boards-for-game-in-unreal-editor-for-fortnite).

```verse
# This file contains the gameboard structure and how it works.
# The gameboard knows where the NPC is supposed to start on the board
# how many obstacles / barriers there are to getting to the end goal,
# and what the end goal is and when it has been reached.
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Simulation }
using { /Verse.org/Simulation/Tags }

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

    # The transform of the NPC’s starting position on this board.
    @editable
    var StartingCharacterPosition<public>:creative_prop = creative_prop{}

    @editable
    OpeningCinematic:cinematic_sequence_device = cinematic_sequence_device{}

    # The Z offset to add to the NPC’s starting position when spawning them.
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

## ui\_manager.verse

The project file **ui\_manager.verse** in the submodule **VerseCommander** contains the code for creating and modifying the look of the UI. For more details, check out step [5. Controlling the NPC with UI](verse-starter-template-5-controlling-npc-with-ui-in-unreal-editor-for-fortnite).

```verse
# This file contains all the code to create and modify the UI
# in the Verse Commander minigame.
# The UI for the game contains:
#  - Buttons that map to commands for the NPC: forward, turn left, turn right.
#  - An execute button that tells the NPC to perform the queue of commands.
#  - A remove button that removes the last command added.
#  - A reset button that resets the current board and clears out the command queue.
#  - A dynamic list of commands that grows wider when a player adds commands and shrinks when a player removes commands.

using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Colors }
using { /Verse.org/Assets }
using { /Verse.org/Simulation }

# This text is localizable and must be a message type to be used in Verse UI.
ForwardText<localizes>:message = "Forward"
TurnRightText<localizes>:message = "Turn Right"
TurnLeftText<localizes>:message = "Turn Left"
RemoveText<localizes>:message = "Remove"
ExecuteText<localizes>:message = "Execute"
ResetText<localizes>:message = "Reset"
PlaceholderText<localizes>:message = ""

# This is the class that holds all the UI element references
# and is in charge of the designs for each UI element and how a UI element responds.
verse_commander_minigame_ui := class:

    # These are references to the canvases used in the UI.
    # The interactive UI canvas holds all the buttons that the player can interact with.
    # The QueueUI holds the dynamic list of commands that the player can only interact with using the interactive UI.
    var InteractiveCanvas:?canvas = false
    var QueueUI:?canvas = false

    # A counter for the number of command in the queue.
    var CommandCounter:int = 0

    # References to each button. The class minigame_button handles the look and feel of each button and how it responds to player interaction.
    ButtonExecute:minigame_button = minigame_button:
        ActiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Yellow_Rounded
        ActiveIconTexture := Textures.MiniGameUI.T_UI_Icon_Execute
        ActiveTextColor := MakeColorFromHex("0D137E")
        InactiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Yellow_Rounded_Dim
        InactiveIconTexture := Textures.MiniGameUI.T_UI_Icon_Execute_Dim
        InactiveTextColor := MakeColorFromHex("030628")
        TextMessage := ExecuteText

    ButtonRemove:minigame_button = minigame_button:
        ActiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Yellow_Rounded
        ActiveIconTexture := Textures.MiniGameUI.T_UI_Icon_Remove
        ActiveTextColor := MakeColorFromHex("0D137E")
        InactiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Yellow_Rounded_Dim
        InactiveIconTexture := Textures.MiniGameUI.T_UI_Icon_Remove_Dim
        InactiveTextColor := MakeColorFromHex("030628")
        TextMessage := RemoveText

    ButtonReset:minigame_button = minigame_button:
        ActiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Yellow_Rounded
        ActiveIconTexture := Textures.MiniGameUI.T_UI_Icon_Reset
        ActiveTextColor := MakeColorFromHex("0D137E")
        InactiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Yellow_Rounded_Dim
        InactiveIconTexture := Textures.MiniGameUI.T_UI_Icon_Reset_Dim
        InactiveTextColor := MakeColorFromHex("030628")
        TextMessage := ResetText

    ButtonForward:minigame_button = minigame_button:
        ActiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Blue_Rounded
        ActiveIconTexture := Textures.MiniGameUI.T_UI_Arrow_ForwardRight
        ActiveTextColor := MakeColorFromHex("ABD0D0")
        InactiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Blue_Rounded_Dim
        InactiveIconTexture := Textures.MiniGameUI.T_UI_Arrow_Forward_Dim
        InactiveTextColor := MakeColorFromHex("364242")
        TextMessage := ForwardText

    ButtonTurnRight:minigame_button = minigame_button:
        ActiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Blue_Rounded
        ActiveIconTexture := Textures.MiniGameUI.T_UI_Arrow_Right
        ActiveTextColor := MakeColorFromHex("ABD0D0")
        InactiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Blue_Rounded_Dim
        InactiveIconTexture := Textures.MiniGameUI.T_UI_Arrow_Right_Dim
        InactiveTextColor := MakeColorFromHex("364242")
        TextMessage := TurnRightText

    ButtonTurnLeft:minigame_button = minigame_button:
        ActiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Blue_Rounded
        ActiveIconTexture := Textures.MiniGameUI.T_UI_Arrow_Left
        ActiveTextColor := MakeColorFromHex("ABD0D0")
        InactiveBackgroundTexture := Textures.MiniGameUI.T_UI_Button_Blue_Rounded_Dim
        InactiveIconTexture := Textures.MiniGameUI.T_UI_Arrow_Left_Dim
        InactiveTextColor := MakeColorFromHex("364242")
        TextMessage := TurnLeftText

    # An array that stores the commands displayed on the UI.
    # These commands are passed to the NPC behavior when the player chooses to execute the commands on the NPC.
    var CommandQueueSlots<private>:[]command_queue = array{}

    # Widget reference for the commands to be able to add and remove widgets (stored in CommandQueueSlots) later.
    var CommandQueueWidget:stack_box = stack_box{Orientation := orientation.Horizontal}

    # Generate all the UI from scratch in Verse and store it to draw and reference later.
    Create<public>():void=
        CommandQueueCanvas := canvas:
            Slots := array:
                CreateCommandQueue()
        set QueueUI = option{CommandQueueCanvas}

        NewInteractiveCanvas := canvas:
            Slots := array:
                CreateButtons()
        set InteractiveCanvas = option{NewInteractiveCanvas}

    # Empty out all the commands from the current dynamic list.
    ResetCommandQueue<private>():void=
        for (Index -> CommandQueueSlot : CommandQueueSlots, Index > 1):
            CommandQueueWidget.RemoveWidget(CommandQueueSlot.Widget)

        # When the command queue is empty, there are still two slots to display
        # for the empty left and right ends of the queue to show that there are no commands in the UI.
        if:
            FirstCommandQueueSlot := CommandQueueSlots[0]
            LastCommandQueueSlot := CommandQueueSlots[1]
        then:
            # Set as the left side.
            FirstCommandQueueSlot.SetAsEnd(false)

            # Set as the right side.
            LastCommandQueueSlot.SetAsEnd(true)

            set CommandQueueSlots = array{FirstCommandQueueSlot, LastCommandQueueSlot}

    # Create an empty command queue at the bottom of the screen and save the widget for reference later.
    CreateCommandQueue<private>():canvas_slot=
        # Create an end slot and set it as the left side.
        LeftEndSlot := command_queue{}
        LeftEndSlot.CreateEnd(false)

        # Create an end slot and set it as the right side.
        RightEndSlot := command_queue{}
        RightEndSlot.CreateEnd(true)
        set CommandQueueSlots = array{LeftEndSlot, RightEndSlot}

        # Save the widget to add and remove widgets from later.
        set CommandQueueWidget = stack_box:
            Orientation := orientation.Horizontal
            Slots := array:
                stack_box_slot:
                    Widget := LeftEndSlot.Widget
                stack_box_slot:
                    Widget := RightEndSlot.Widget

        # Creates a canvas slot that contains the horizontal stackbox of commands and anchors the widget in the lower middle of the screen.
        CanvasSlot := canvas_slot: # Lower Middle of Screen
            Anchors := anchors{ Minimum := vector2{X := 0.5, Y := 0.9}, Maximum := vector2{X := 0.5, Y := 0.9}}
            Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
            Alignment := vector2{X := 0.5, Y := 1.0}
            SizeToContent := true
            Widget := CommandQueueWidget

        return CanvasSlot

    # Create all the buttons and position them at the top of the screen.
    CreateButtons<private>():canvas_slot=
        ButtonForward.Create()
        ButtonTurnRight.Create()
        ButtonTurnLeft.Create()
        ButtonExecute.Create()
        ButtonRemove.Create()
        ButtonReset.Create()

        # Creates a canvas slot that contains the horizontal stackbox of buttons and positions them at top of screen.
        # Padding is added between buttons to space them apart from each other but keep them all still centered.
        canvas_slot:
            Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.0}, Maximum := vector2{X := 0.5, Y := 0.0} }
            Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
            Alignment := vector2{X := 0.5, Y := 0.0}
            SizeToContent := true
            Widget := stack_box:
                Orientation := orientation.Horizontal
                Slots := array:
                    stack_box_slot:
                        Padding := margin{Top := 0.0, Left := 0.0, Right := 2.5, Bottom := 0.0}
                        Widget := ButtonTurnLeft.Widget
                    stack_box_slot:
                        Padding := margin{Top := 0.0, Left := 2.5, Right := 2.5, Bottom := 0.0}
                        Widget := ButtonForward.Widget
                    stack_box_slot:
                        Padding := margin{Top := 0.0, Left := 2.5, Right := 2.5, Bottom := 0.0}
                        Widget := ButtonTurnRight.Widget
                    stack_box_slot:
                        Padding := margin{Top := 0.0, Left := 2.5, Right := 2.5, Bottom := 0.0}
                        Widget := ButtonExecute.Widget
                    stack_box_slot:
                        Padding := margin{Top := 0.0, Left := 2.5, Right := 2.5, Bottom := 0.0}
                        Widget := ButtonRemove.Widget
                    stack_box_slot:
                        Padding := margin{Top := 0.0, Left := 2.5, Right := 0.0, Bottom := 0.0}
                        Widget := ButtonReset.Widget

    # Adds the custom UI created in this class to the player’s UI.
    Draw<public>(PlayerUI:player_ui):void=
        if:
            CommandQueueCanvas := QueueUI?
            ButtonCanvas := InteractiveCanvas?
        then:
            PlayerUI.AddWidget(CommandQueueCanvas)

            # Input mode is set to All so the player can click the buttons.
            PlayerUI.AddWidget(ButtonCanvas, player_ui_slot{InputMode := ui_input_mode.All})

    # Clear out the queue and reset the command counter.
    ClearQueue<public>():void=
        ResetCommandQueue()
        set CommandCounter = 0

    # Removes the custom UI created in this class from the player’s UI.
    Remove<public>(PlayerUI:player_ui):void=
        if:
            CommandQueueCanvas := QueueUI?
            ButtonCanvas := InteractiveCanvas?
        then:
            PlayerUI.RemoveWidget(CommandQueueCanvas)
            PlayerUI.RemoveWidget(ButtonCanvas)

    # Appends the command icon to the command queue at the bottom of the screen.
    # If the commands in the queue are at the max number of commands allowed, no more commands can be added.
    AddCommandToDisplay(Command:command, UICommandLimit:int):void=
        # Checks if the queue has already reached the max number of commands allowed.
        # The check ignores the left and right end slots since they don’t contain commands, which is why 2 is subtracted from the command length.
        if:
            (CommandQueueSlots.Length - 2) = UICommandLimit
        then:
            return

        # Increase the command counter and add the command to the end of the queue.
        set CommandCounter += 1
        if:
            LastCommandQueueSlot := CommandQueueSlots[CommandCounter]
        then:
            LastCommandQueueSlot.SetCommand(Command)

        # Create a new slot to add to the end of the queue and set it as the right end.
        CommandQueueSlotToAdd := command_queue{}
        CommandQueueSlotToAdd.CreateEnd(true)

        # Update the references and add the new end widget to the stackbox.
        if:
            NewArray := CommandQueueSlots.Insert[CommandCounter + 1, array{CommandQueueSlotToAdd}]
        then:
            set CommandQueueSlots = NewArray
            CommandQueueWidget.AddWidget(stack_box_slot{Widget := CommandQueueSlotToAdd.Widget})

    # Removes the last command icon from the command queue at the bottom of the screen.
    # If there are no commands already in the queue, nothing happens.
    RemoveLastCommandFromDisplay():void=
        if:
            CommandCounter = 0
        then:
            return

        # Set the last command as the right end slot instead.
        if:
            CommandQueueSlot := CommandQueueSlots[CommandCounter]
        then:
            CommandQueueSlot.SetAsEnd(true)

        # Remove the previous right end slot from the display.
        if:
            LastCommandQueueSlot := CommandQueueSlots[CommandCounter + 1]
        then:
            CommandQueueWidget.RemoveWidget(LastCommandQueueSlot.Widget)

        # Update the references.
        if:
            NewArray := CommandQueueSlots.RemoveElement[CommandQueueSlots.Length - 1]
        then:
            set CommandQueueSlots = NewArray

        # Decrease the command counter.
        set CommandCounter -= 1

    # Gets the current queue of commands from the command queue UI.
    GetCommandQueue():[]command=
        CommandQueue := for(Slot : CommandQueueSlots, Command := Slot.CommandData?):
            Command

        return CommandQueue

    # Set whether the player can interact with the buttons.
    # When IsEnabled is true, then the buttons become interactable and bright.
    # When IsEnabled is false, then the buttons become non-interactable and dim.
    SetQueueButtonInteractivity(IsEnabled:logic):void=
        ButtonForward.SetEnabled(IsEnabled)
        ButtonTurnRight.SetEnabled(IsEnabled)
        ButtonTurnLeft.SetEnabled(IsEnabled)
        ButtonExecute.SetEnabled(IsEnabled)
        ButtonRemove.SetEnabled(IsEnabled)

# The class for storing all the widget references for a button and setting its look.
minigame_button := class:

    # Store a reference of the overlay for easy removal later.
    var Widget:overlay = overlay:

    # Store a reference of the background texture widget to change easily later.
    BackgroundImage:texture_block = texture_block:
        DefaultImage := Textures.MiniGameUI.T_UI_Button_Blue_Rounded
        DefaultDesiredSize := vector2{X := 256.0, Y := 128.0}

    ActiveBackgroundTexture:texture = Textures.MiniGameUI.T_UI_Button_Blue_Rounded
    ActiveIconTexture:texture = Textures.MiniGameUI.T_UI_Arrow_ForwardRight
    ActiveTextColor:color = MakeColorFromHex("ABD0D0")
    InactiveBackgroundTexture:texture = Textures.MiniGameUI.T_UI_Button_Blue_Rounded_Dim
    InactiveIconTexture:texture = Textures.MiniGameUI.T_UI_Arrow_Forward_Dim
    InactiveTextColor:color = MakeColorFromHex("364242")
    TextMessage:message = ForwardText

    # Store a reference of the icon texture widget to change easily later.
    Icon:texture_block = texture_block:
        DefaultImage := Textures.MiniGameUI.T_UI_Arrow_ForwardRight
        DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}

    # Store a reference of the text widget to change easily later.
    Text:text_block = text_block:
        DefaultText := ForwardText
        DefaultTextColor := MakeColorFromHex("ABD0D0")

    # Store a reference of the button widget to change easily later.
    Button:button_quiet = button_quiet:
        DefaultText := PlaceholderText

    # Set the interactivity of the button.
    # When InIsEnabled is true, enable the button and add the bright versions of textures and text color.
    # When InIsEnabled is false, disable the button and add the dim versions of textures and text color.
    SetEnabled(InIsEnabled:logic):void=
        Button.SetEnabled(InIsEnabled)

        if (InIsEnabled?):
            BackgroundImage.SetImage(ActiveBackgroundTexture)
            Icon.SetImage(ActiveIconTexture)
            Text.SetTextColor(ActiveTextColor)
        else:
            BackgroundImage.SetImage(InactiveBackgroundTexture)
            Icon.SetImage(InactiveIconTexture)
            Text.SetTextColor(InactiveTextColor)

    # Create the button based on its type and set its default textures and text.
    # The button widget overlays the text and icon, which overlay the background.
    # This is to have the custom look of the button but maintain the functionality and responsiveness of the button design.
    Create():void=
        set Widget = overlay:
            Slots := array:
                overlay_slot: # background of button
                    Widget := BackgroundImage
                overlay_slot:
                    Widget := stack_box:
                        Orientation := orientation.Horizontal
                        Slots := array:
                            stack_box_slot:
                                Widget := Icon
                            stack_box_slot:
                                Widget := Text
                overlay_slot: # button
                    HorizontalAlignment := horizontal_alignment.Fill
                    Widget := Button

        BackgroundImage.SetImage(ActiveBackgroundTexture)
        Icon.SetImage(ActiveIconTexture)
        Text.SetTextColor(ActiveTextColor)
        Text.SetText(TextMessage)

# A class that stores the image (texture) that is used to represent a command in the queue on screen
# and the enum associated with that command.
command_queue := class:
    # Store a reference of the overlay for easy removal later.
    var Widget:overlay = overlay{}

    # Store a reference of the background texture block to change the image easily later.
    BackgroundImage:texture_block = texture_block:
        DefaultImage := Textures.MiniGameUI.TransparentImage512
        DefaultDesiredSize := vector2{X := 88.0, Y := 88.0}

    # Store a reference of the command texture block to change the image easily later.
    CommandImage:texture_block = texture_block:
        DefaultImage := Textures.MiniGameUI.TransparentImage256
        DefaultDesiredSize := vector2{X := 88.0, Y := 88.0}

    # Store the command data that's also displayed in the UI for easy retrieval later.
    var CommandData:?command = false

    # Create the overlay widget with the background and command images.
    CreateEnd(IsRight:logic):void=
        set Widget = overlay:
            Slots := array:
                overlay_slot:
                    Widget := BackgroundImage
                overlay_slot:
                    Widget := CommandImage
        SetAsEnd(IsRight)

    # Update the widget to show the new command.
    SetCommand(Command:command):void=
        BackgroundImage.SetImage(Textures.MiniGameUI.T_UI_Prompt_Middle)
        if (Command = Commands.Forward):
            CommandImage.SetImage(Textures.MiniGameUI.T_UI_Arrow_ForwardRight)
        else if (Command = Commands.TurnRight):
            CommandImage.SetImage(Textures.MiniGameUI.T_UI_Arrow_Right)
        else if (Command = Commands.TurnLeft):
            CommandImage.SetImage(Textures.MiniGameUI.T_UI_Arrow_Left)
        else:
            CommandImage.SetImage(Textures.MiniGameUI.TransparentImage256)
        set CommandData = option{Command}

    # Update the widget to be the end of the UI.
    # When IsRight is true, the right end texture is used.
    # When IsRight is false, the left end texture is used.
    SetAsEnd(IsRight:logic):void=
        if:
            IsRight?
        then:
            BackgroundImage.SetImage(Textures.MiniGameUI.T_UI_Prompt_EndRight)
        else:
            BackgroundImage.SetImage(Textures.MiniGameUI.T_UI_Prompt_End)
        CommandImage.SetImage(Textures.MiniGameUI.TransparentImage256)
        set CommandData = false
```

## verse\_commander\_minigame.verse

The project file **verse\_commander\_minigame.verse** in the submodule **VerseCommander** contains the Verse device that manages the minigame. For more details, check out step [6. Managing the Game Loop](verse-starter-template-6-managing-game-loop-in-unreal-editor-for-fortnite).

```verse
# This device is in charge of managing the minigame.
# In its Details panel in the editor, you can:
# - Define how many gameboards there are
# - The order you play the gameboards
# - All the details of the gameboard such as their obstacles.

using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }
using { /Verse.org/Simulation/Tags }

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

    # Runs when the device is started in a running game.
    OnBegin<override>()<suspends>:void=
        spawn{Cinematic.EnterCinematicModeForAll(GetPlayspace().GetPlayers())}
        loop:
            PlayVerseCommanderButton.InteractedWithEvent.Await()

            Setup()
            # Wait for all Gameboards to be set up.
            Sleep(2.0)

            Start()

    # Creates a verse_commander_minigame_ui for each player, and adds buttons for each NPC
    # command to the player's UI. Then setups all gameboards, and spawns the NPC that the player commands.
    Setup()<suspends>:void=
        # For each player, create a new verse_commander_minigame_ui.
        for:
            Number -> Player : GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
        do:
            # Add buttons for foward, turn right, turn left, remove, execute, and reset commands to each player's UI.
            # Subscribe those buttons to their associated functions.
            NewUI := verse_commander_minigame_ui{}
            NewUI.Create()
            NewUI.ButtonForward.Button.OnClick().Subscribe(OnForwardSelected)
            NewUI.ButtonTurnRight.Button.OnClick().Subscribe(OnTurnRightSelected)
            NewUI.ButtonTurnLeft.Button.OnClick().Subscribe(OnTurnLeftSelected)
            NewUI.ButtonRemove.Button.OnClick().Subscribe(OnRemoveSelected)
            NewUI.ButtonExecute.Button.OnClick().Subscribe(OnExecuteSelected)
            NewUI.ButtonReset.Button.OnClick().Subscribe(OnResetSelected)
            # Store a reference of the player's UI to be able to update it later.
            if (set UIPerPlayer[Player] = NewUI):

        # Set up all the gameboards.
        for (Gameboard : Gameboards):
            Gameboard.Setup()

        # Spawn the NPC that the player commands.
        NPCSpawner.Spawn()

    # Adds the foward command to each player's command queue.
    OnForwardSelected(Widget:widget_message):void=
        AddCommandForAllPlayers(Commands.Forward)

    # Adds the turn right command to each player's command queue.
    OnTurnRightSelected(Widget:widget_message):void=
        AddCommandForAllPlayers(Commands.TurnRight)

    # Adds the turn left command to each player's command queue.
    OnTurnLeftSelected(Widget:widget_message):void=
        AddCommandForAllPlayers(Commands.TurnLeft)

    # Signals that the execute command button was selected.
    OnExecuteSelected(Widget:widget_message):void=
        ExecuteButtonSelected.Signal()

    # Signals that the reset button was selected.
    OnResetSelected(Widget:widget_message):void=
        ResetButtonSelected.Signal()

    # Adds the given command to each player's command queue UI.
    AddCommandForAllPlayers(Command:command):void=
        for:
            Player : GetPlayspace().GetPlayers()
            CustomUI := UIPerPlayer[Player]
        do:
            CustomUI.AddCommandToDisplay(Command, UICommandLimit)

    # Removes the last command from each player's command queue UI.
    OnRemoveSelected(Widget:widget_message):void=
        for:
            Player : GetPlayspace().GetPlayers()
            CustomUI := UIPerPlayer[Player]
        do:
            CustomUI.RemoveLastCommandFromDisplay()

    # Draws the custom UI for each player in the game.
    DrawUIForAllPlayers():void=
        for:
            Player : GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
            CustomUI := UIPerPlayer[Player]
        do:
            CustomUI.Draw(PlayerUI)

    # Enable the HUDController, draw the UI for all players, and start the Gameloop.
    # Exit the minigame when the final board is completed.
    Start<private>()<suspends>:void=

        HUDController.Enable()

        DrawUIForAllPlayers()

        GameLoop()

        Exit()

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

                    # Wait till the character finishes moving. Then reset the UI for all players. When the race completes,=
                    CharacterFinishedMovingEvent.Await()
            Gameboard.EndGoalReached.Await()

        # Advance the CurrentBoard to the next board in the Gameboards array.
        # And mark that it's first time on the board.
        set CurrentBoard += 1
        set FirstTimeOnCurrentBoard = true

        # Wait one second.
        Sleep(1.0)

        # Clean up geamobard and stop the current level.
        Gameboard.Stop()

    # Wait for the Execute button to be selected, then returns the command queue of
    # the first player in the playspace.
    WaitForExecuteCommand()<suspends>:[]command=
        ExecuteButtonSelected.Await()
        # Because all players share the same UI, get the command queue of the first player in the playspace.
        # Then return that command queue, or a blank array if this fails.
        if:
            APlayer := GetPlayspace().GetPlayers()[0]
            CustomUI := UIPerPlayer[APlayer]
        then:
            CustomUI.GetCommandQueue()
        else:
            array{}

    # Reset the UI for all players by enabling all their buttons again  and removing commands from the queue.
    ResetUIForAllPlayers():void=
        for (Player : GetPlayspace().GetPlayers(), CustomUI := UIPerPlayer[Player]):
            CustomUI.SetQueueButtonInteractivity(true)
            CustomUI.ClearQueue()

    # Disables UI button interactivity while waiting for commands to finish executing.
    TurnOffButtonInteractivityForAllPlayers():void=
        # For each player, get the UI for that player, and disable the interactivity of their UI buttons.
        for (Player : GetPlayspace().GetPlayers(), CustomUI := UIPerPlayer[Player]):
            CustomUI.SetQueueButtonInteractivity(false)

    # Waits for the Reset button to be selected, then resets the current gameboard
    # and NPC.
    AwaitReset<private>(Gameboard:gameboard)<suspends>:void=
        ResetButtonSelected.Await()
        # Reset the current gameboard, returning the game character to the starting position and
        # resetting any barriers or triggers on the board.
        BoardResetEvent.Signal(Gameboard.GetStartingCharacterPosition())

        # Reset Gameboard
        Gameboard.Reset()

    # Clean up and end the minigame.
    Exit<private>():void=
        # Signal the minigame is over.
        GameEndedEvent.Signal()

        # Remove the HUD used for the minigame.
        HUDController.Disable()

        # Reset board data for next playthrough.
        set CurrentBoard = 0
        set FirstTimeOnCurrentBoard = true

        # Reset NPC Spawner for next playthrough.
        NPCSpawner.DespawnAll(false)
        NPCSpawner.Reset()

        # Remove the custom UI for all players.
        for:
            Player : GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
            CustomUI := UIPerPlayer[Player]
        do:
            CustomUI.Remove(PlayerUI)

# A log channel for printing messages to.
verse_commander_log_channel := class(log_channel):

# A project-wide Logger to print messages from functions that are not in a class with a log.
ProjectLog(Message:[]char, ?Level:log_level = log_level.Normal)<transacts>:void=
    Logger := log{Channel := verse_commander_log_channel}
    Logger.Print(Message, ?Level := Level)
```

## verse\_commander\_character.verse

The project file verse\_commander\_character.verse in the submodule VerseCommander contains the logic for the minigame’s NPC. For more details, check out step [1. Creating the NPC Behavior](verse-starter-template-1-creating-npc-behavior-in-unreal-editor-for-fortnite).

```verse
# This file handles the logic for the gameboard NPC. The NPC waits for commands from
# verse_commander_minigame, then executes movement based on those commands using navigation targets.
# It also tracks the NPC's position using a visual arrow that updates after each command.

using { /Fortnite.com/AI }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Assets }
using { /Verse.org/Simulation }

# Create a dedicated debug channel to draw to for this behavior
verse_commander_character_debug_draw := class(debug_draw_channel) {}

# This module contains functions which return messages used for helpful debugging information that are
# localized and paired with the NPC ID.
verse_commander_character_message_module:= module:

    OnBeginMessage<public><localizes>(Agent:agent):message =
        "NPC Agent = {Agent}: OnBegin triggered let's get started."
    OnEndMessage<public><localizes>(Agent:agent):message =
        "NPC Agent = {Agent}: OnEnd triggered let's cleanup."
    OnNavigateBeginMessage<public><localizes>(Agent:agent, X:float, Y:float, Z:float):message =
        "NPC Agent = {Agent}: Is moving to [{X},{Y},{Z}]"
    OnNavigateErrorMessage<public><localizes>(Agent:agent, X:float, Y:float, Z:float):message =
        "NPC Agent = {Agent}: Hit error moving to [{X},{Y},{Z}], please refer to Island Setting's Navigation debug"

# A Verse-authored NPC Behavior that can be used within an NPC Definition or a Character Spawner device's Behavior Script Override.
verse_commander_character<public> := class(npc_behavior):

    # Reference to the Agent that runs this NPC Behavior.
    var GameAgent<private>:?agent = false

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

    # Waits for the current board to be reset, then moves the
    # NPC back to the starting position of the board along with VFX.
    AwaitReset()<suspends>:void=
        # Wait for the current board to be reset.
        # The event payload is the starting position for the board.
        StartPosition := VerseCommanderMinigame.BoardResetEvent.Await()
        spawn{PlayVFXAndMoveCharacter(StartPosition)}

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

    # Race between resetting the character to start of the board and awaiting commands for that character.
    CharacterCommandLoop()<suspends>:void=
        race:
            AwaitReset()
            loop:
                AwaitCommands()

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

    # Gets a new navigation target for the NPC based on the current transform and the given command.
    GetNavTarget(CurrentTransform:transform, Command:command, TileDistance:vector3):transform=
        # Based on the command, get the character's local foward, right, or left (negative right).
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
