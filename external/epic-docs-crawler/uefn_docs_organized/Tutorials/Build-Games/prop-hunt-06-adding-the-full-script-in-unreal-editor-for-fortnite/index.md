# 6. Adding the Full Script

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-06-adding-the-full-script-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:23:44.569150

---

This section includes the complete code to add to the Verse files you created.

## Complete Code

There are multiple Verse files in this project.

- **heartbeat.verse:** See below for the file’s complete code.
- **base\_team.verse:** See below for the file’s complete code.
- **hunter\_team.verse:** See below for the file’s complete code.
- **prop\_team.verse:** See below for the file’s complete code.
- **round\_timer.verse:** See below for the file’s complete code.
- **waiting\_for\_more\_players.verse:** See below for the file’s complete code.

## heartbeat.verse

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }

log_heart_beat := class(log_channel){}

# These messages are used to notify a prop agent with a message (or to hide it) when they need to move to avoid their heartbeat from becoming visible.
HeartBeatWarningMessage<localizes>(Time:int):message = "Heart Beat in {Time} Seconds. Move!"
HeartBeatWarningClear<localizes>:message = ""

# This class exposed the editable properties for the heartbeat to the prop_hunt device.
heart_beat := class<concrete>():
    Logger:log = log{Channel:=log_heart_beat}

    @editable # The number of seconds before a prop agent must move before the heartbeat reveals their position.
    MoveTime:float = 15.0

    @editable # The seconds remaining before the heartbeat warning appears. Shouldn't be > than HeartBeatTimer.
    WarningTime:float = 5.0

    @editable # An array of heartbeat VFX devices. There is one per player.
    AgentVFX:[]heartbeat_vfx = array{}

    @editable # The audio player device used to play the heartbeat sound effects (SFX).
    SFXPlayer:radio_device = radio_device{}

    # This map associates a UI for displaying the heartbeat warning to each prop agent.
    var WarningUI:[agent]heartbeat_warning_ui = map{}

    # Keeps track of how many players have an active heartbeat so we can manage the SFX device.
    var NumberOfHeartBeats:int = 0

    # Sets up heartbeat UI for the agent.
    SetUpUI(PropAgent:agent):void =
        if:
            not WarningUI[PropAgent]
            AsPlayer := player[PropAgent]
            PlayerUI := GetPlayerUI[AsPlayer]
        then:
            UIData:heartbeat_warning_ui = heartbeat_warning_ui{}
            UIData.CreateCanvas()
            PlayerUI.AddWidget(UIData.Canvas, player_ui_slot{ZOrder := 1})
            if (set WarningUI[PropAgent] = UIData) {}

    # Activates the heartbeat VFX and SFX for the specified player.
    Enable(PropAgent:agent, HeartBeatVFXData:heartbeat_vfx):void =
        if:
            # Get the character, which is used to find the prop agent's position in the scene.
            Character := PropAgent.GetFortCharacter[]
        then:

            # Set the heartbeat VFX's position to the prop agent's position.
            HeartBeatVFXData.Activate(Character.GetTransform())

            # Increment the heartbeat count, and if this is the first heartbeat playing, we need to play the audio to get it started.
            set NumberOfHeartBeats += 1
            if (NumberOfHeartBeats = 1) then SFXPlayer.Play()

            # Register the prop agent to the audio player device so the heartbeat audio will play from that position.
            SFXPlayer.Register(PropAgent)
        else:
            Logger.Print("Character, Index, or HeartBeatVFXData not found. Cannot start the heartbeat")

    # Clears the heartbeat VFX and SFX for the specified prop agent.
    Disable(PropAgent:agent, HeartBeatVFXData:heartbeat_vfx):void =
        Logger.Print("Disabling heart beat.")

        # Deactivate the VFX visuals.
        HeartBeatVFXData.Deactivate()

        # Unregister the prop agent from the audio player device, causing the heartbeat audio to stop.
        SFXPlayer.Unregister(PropAgent)

        # Decrement the heartbeat counter. This counter should never drop below 0.
        set NumberOfHeartBeats -= 1
        if (NumberOfHeartBeats < 0) then set NumberOfHeartBeats = 0

    # Clears all heartbeat VFX and SFX for all prop agents.
    DisableAll():void =
        Logger.Print("Disabling all heart beats.")

        # Iterate through all VFX and move them to 0,0,0.
        for (HeartBeatVFXDevice : AgentVFX):
            HeartBeatVFXDevice.Deactivate()

        # Unregister all players from the heart beat audio.
        SFXPlayer.UnregisterAll()

        # Reinitialize the heartbeat counter to 0
        set NumberOfHeartBeats = 0

# The heartbeat_warning_ui class contains a struct of data to track the UI canvas and text_block per player as well as the function to create a new heartbeat warning UI canvas.
heartbeat_warning_ui := class:
    var Canvas:canvas = canvas{}
    var Text:text_block = text_block{}

    # Creates the UI canvas for the warning message.
    CreateCanvas():void =
        set Text = text_block{DefaultTextColor := NamedColors.White, DefaultShadowColor := NamedColors.Black}
        set Canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.75}, Maximum := vector2{X := 0.5, Y := 0.75}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 1.0}
                    SizeToContent := true
                    Widget := Text

# The heartbeat_vfx class contains a struct of data to track the VFX's root and vfx_spawner_device objects per player as well as the functions to set the VFX to a position or reset it.
heartbeat_vfx := class<concrete>:

    @editable # The VFX device for each heart beat.
    VFXDevice:vfx_spawner_device = vfx_spawner_device{}

    # This offset is used to position the heartbeat above a prop agent's head.
    HeartBeatVFXOffset:vector3 = vector3{X := 0.0, Y := 0.0, Z := 110.0}

    # Sets the position of the heartbeat VFX and then enables the VFX.
    Activate(Transform:transform):void =
        VFXPosition := Transform.Translation + HeartBeatVFXOffset
        if (VFXDevice.TeleportTo[VFXPosition, Transform.Rotation]):
            VFXDevice.Enable()

    # Disables the VFX, hiding the heartbeat visuals.
    Deactivate():void =
        VFXDevice.Disable()
```

## base\_team.verse

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }

log_team := class(log_channel){}

# This class defines the devices needed for the different teams in the experience.

# This class is abstract so it cannot be used on its own. It has to be inherited by another class.
base_team := class<abstract>:
    Logger:log = log{Channel:=log_team}

    @editable # Used to set a player to the team.
    ClassSelector:class_and_team_selector_device = class_and_team_selector_device{}

    @editable # Used to award score to agents on the team.
    ScoreManager:score_manager_device = score_manager_device{}

    @editable # Used to display the team assignment title.
    TeamTitle:hud_message_device = hud_message_device{}

    @editable # Used to display the team assignment description.
    TeamDescription:hud_message_device = hud_message_device{}

    @editable # Used to subscribe to team member (prop team) or enemy (hunter team) eliminated events.
    TeamManager:team_settings_and_inventory_device = team_settings_and_inventory_device{}

    # This is an array of agents on the team.
    var TeamAgents<private>:[]agent = array{}

    # This event is signaled when the TeamAgents array becomes empty (signaling the end of the round).
    TeamEmptyEvent:event() = event(){}

    # Returns the current TeamAgents array.

    # This is required because the TeamAgents array is private, so other classes cannot access it directly.
    GetAgents()<decides><transacts>:[]agent =
        TeamAgents

    # Return the size of the TeamAgents array

    # This requires a function because the TeamAgents array is private, so other classes cannot access it directly.
    Count()<transacts>:int =
        TeamAgents.Length

    # Returns an index in the TeamAgents array of an agent, fails otherwise.
    FindOnTeam(Agent:agent)<decides><transacts>: int =
        Index := TeamAgents.Find[Agent]

    # Set the agent to the team and notify the player.
    InitializeAgent(Agent:agent):void =
        AddAgentToTeam(Agent)
        ClassSelector.ChangeTeamAndClass(Agent)
        DisplayTeamInformation(Agent)

    # Add an agent to TeamAgents.
    AddAgentToTeam(AgentToAdd:agent):void =
        if (not FindOnTeam[AgentToAdd]):
            Logger.Print("Adding agent to team.")
            set TeamAgents += array{AgentToAdd}

    # Activates HUD message devices to show the player what team they are on
    DisplayTeamInformation(Agent:agent):void =
        TeamTitle.Show(Agent)
        TeamDescription.Show(Agent)

    # When an agent leaves the match, remove them from the TeamAgents array and check for the end of the round.
    EliminateAgent(Agent:agent)<suspends>:void =
        Sleep(0.0) # Delaying 1 game tick to ensure the player is respawned before proceeding.
        RemoveAgentFromTeam(Agent)

    # Remove an agent from TeamAgents.

    # If the agent removed was the last, signal TeamEmptyEvent.
    RemoveAgentFromTeam(AgentToRemove:agent):void =
        set TeamAgents = TeamAgents.RemoveAllElements(AgentToRemove)
        Logger.Print("{Count()} agent(s) on team remaining.")
        if (Count() < 1):
            Logger.Print("No agents on team remaining. Ending the round.")
            TeamEmptyEvent.Signal()
```

## hunter\_team.verse

```verse
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Simulation }

# Inheriting from the base_team class, The hunter_team class contains the device definitions and functions related to the hunter team and its agents.
hunter_team := class<concrete>(base_team):

    @editable # One hunter agent is created each round for each n players. Example: HunterTeamPerNumberOfPlayers = 5.0 is 1 per 5 players. If players = 6, 2 hunter agents are created.
    HunterAgentPerNumberOfPlayers:float = 5.0 # Minimum 1.1 is enforced to ensure at least 1 prop agent is created.

    @editable # The number of seconds before the hunter agents are spawned, giving the prop agents a head start to hide.
    SpawnDelay:float = 15.0

    @editable # The maximum base points a hunter agent gets for eliminating a prop agent. These points are divided by the number of prop agents remaining.
    MaxEliminationScore:int = 5000

    @editable # The timer device is used to give props a grace period to hide.
    WaitTimer:timer_device = timer_device{}

    # Set the agent to a hunter agent.
    InitializeAgent<override>(NewHunterAgent:agent):void =
        Logger.Print("Setting a new hunter agent.")
        (super:)InitializeAgent(NewHunterAgent)

    # When a hunter agent leaves the match, remove them from the HunterAgents array and check for the end of the round.

    # Notice that we're overriding this function because we don't need to pass extra data here as we do for the prop team.
    EliminateAgent<override>(HunterAgent:agent)<suspends>:void =
        Logger.Print("Hunter agent eliminated.")
        (super:)EliminateAgent(HunterAgent)
```

## prop\_team.verse

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }

# This message is used to print the number of props remaining to all players during a round.
PropAgentsRemainingMessage<localizes>(Count:int):message = "{Count} Prop(s) Remaining"

# Inheriting from the base_team class, the prop_team class contains the device definitions and functions related to the prop team and its agents.

# Notably, a prop agent's heart beat behavior can be found in this class.
prop_team := class<concrete>(base_team):

    @editable # The score a prop agent receives per second.
    ScorePerSecond:int = 10

    @editable # The minimum distance a prop agent must move to reset the heart beat timer.
    MinimumMoveDistance:float = 100.0

    @editable # The timer device used to award score to a prop.
    ScoreTimer:timer_device = timer_device{}

    @editable # This tracker device is used to display the props remaining to the screen.
    PropsRemainingTracker:tracker_device = tracker_device{}

    @editable # Get the properties from the heart_beat class.
    HeartBeat:heart_beat = heart_beat{}

    # Set the agent to a prop agent and assign heartbeat warning UI.
    InitializeAgent<override>(NewPropAgent:agent):void =
        Logger.Print("Setting a new prop agent.")
        (super:)InitializeAgent(NewPropAgent)

    # When the PropScoreTimer completes, award points to all prop agents. PropInstigator is needed for the event subscription but is not used.
    OnPropsScore(PropInstigator:?agent):void =
        if (PropAgents := GetAgents[]):
            for (PropAgent : PropAgents):
                ScoreManager.Activate(PropAgent)

    # When a prop agent is eliminated or leaves the match, remove them from the PropAgents array and check for the end of the round.

    # Note that this isn't overriding because we're passing all players to the function to update the props' remaining message.
    EliminateAgent<override>(PropAgent:agent)<suspends>:void =
        Logger.Print("Prop agent eliminated.")
        (super:)EliminateAgent(PropAgent)

        # Update the props' remaining number.
        UpdatePropsRemainingTracker()

    # Updates the value of the tracker device showing the number of props remaining.
    UpdatePropsRemainingTracker():void =
        PropsRemainingTracker.SetValue(Count())

    # If the prop agent stops moving then race to see if the prop agent moves beyond the MinimumMoveDistance, the heartbeat timer completes, or the prop agent is eliminated.
    RunPropGameLoop(PropAgent:agent)<suspends>:void =
        Logger.Print("Starting prop agent game loop.")

        # Loop forever through the prop behavior until the prop agent is eliminated or the player leaves the session.
        race:
            PropAgent.AwaitNoLongerAProp()
            loop:

                # Wait until the prop agent moves less than the minimum distance, then advance.
                PropAgent.AwaitStopMoving(MinimumMoveDistance)

                # Until the prop agent moves beyond the minimum distance, countdown to the heart beat and then play the heart beat indefinitely.
                race:
                    PropAgent.AwaitStartMoving(MinimumMoveDistance)
                    block:
                        CountdownTimer(PropAgent)
                        PropAgent.StartHeartbeat()
                Sleep(0.0) # Once the race completes (the prop agent moves), start the loop again.

    # Loop until the prop agent is no longer a part of the PropAgents array. Removal happens if the prop agent is eliminated and turned into a hunter or if the player leaves the session.
    (PropAgent:agent).AwaitNoLongerAProp()<suspends>:void =
        loop:
            if (not FindOnTeam[PropAgent]):
                Logger.Print("Cancelling prop agent behavior.")
                break
            Sleep(0.0) # Advance to the next game tick.

    # Loops until the agent moves less than the MinimumDistance.
    (PropAgent:agent).AwaitStopMoving(MinimumDistance:float)<suspends>:void =
        Logger.Print("Checking if the agent has moved less than the minimum distance.")

        # Get the initial position of the agent from the agent's character in the scene.
        if (Tracked := PropAgent.GetFortCharacter[]):
            var StartPosition:vector3 = Tracked.GetTransform().Translation
            loop:
                Sleep(0.0) # Get the position of the agent in the next game tick.
                NewPosition := Tracked.GetTransform().Translation

                # If the distance of the new position from the starting position is less than MinimumDistance, the agent has not moved and we break the loop.
                if (Distance(StartPosition, NewPosition) < MinimumDistance):
                    Logger.Print("Agent has moved less than the minimum distance.")
                    break

                # Otherwise, we reset StartPosition to make sure the player moves from the new position.
                else:
                    set StartPosition = NewPosition

    # Loops until the agent moves more than the MinimumDistance.
    (PropAgent:agent).AwaitStartMoving(MinimumDistance:float)<suspends>:void =
        Logger.Print("Checking if the agent moves further than the minimum distance.")

        # Get the initial position of the agent from the agent's character in the scene.
        if (Tracked := PropAgent.GetFortCharacter[]):
            StartPosition:vector3 = Tracked.GetTransform().Translation
            loop:
                Sleep(0.0) # Get the position of the agent in the next game tick.
                NewPosition := Tracked.GetTransform().Translation

                # If the distance of the new position from the starting position is greater than or equal to MinimumDistance, the agent has moved and we break the loop.
                if (Distance(StartPosition, NewPosition) >= MinimumDistance):
                    Logger.Print("Agent has moved more than or equal to the minimum distance.")
                    break

    # Delays until HeartBeatWarningTime should start. Then counts down by HeartBeatWarningTime and sets the countdown text. Clears the text when deferred.
    CountdownTimer(PropAgent:agent)<suspends>:void =
        Logger.Print("Starting heart beat countdown.")
        if (UIData := HeartBeat.WarningUI[PropAgent]):
            Sleep(HeartBeat.MoveTime - HeartBeat.WarningTime) # Sleep for the amount of time before the warning appears.
            Logger.Print("Starting heart beat warning.")
            var WarningTimeRemaining:int = 0
            if (set WarningTimeRemaining = Ceil[HeartBeat.WarningTime]) {}

            # A defer happens when the function completes or if it is cancelled, such as if it loses a race.

            # So in this case, the warning text is cleared when the countdown finishes or if the prop agent moves before the countdown finishes.
            defer:
                UIData.Text.SetText(HeartBeatWarningClear)

            # Set the warning text to the time remaining, wait a second, and then decrement the time remaining. If the countdown completes, break the loop.
            loop:
                Logger.Print("Heart beat in {WarningTimeRemaining} seconds.")
                UIData.Text.SetText(HeartBeatWarningMessage(WarningTimeRemaining))
                Sleep(1.0)
                set WarningTimeRemaining -= 1
                if (WarningTimeRemaining <= 0):
                    break
        else:
            Logger.Print("UIData not found.")

    # Turns on the heart beat VFX and SFX. Waits infinitely until deferred then disables the heart beat VFX and SFX.
    (PropAgent:agent).StartHeartbeat()<suspends>:void =
        Logger.Print("Spawning heart beat.")

        # Save the heartbeat data so we can pass it in the defer later, after the PropAgent is destroyed or leaves the game.
        var HeartBeatVFXData:heartbeat_vfx = heartbeat_vfx{}
        if:

            # Get the index of the prop agent in the PropAgents array to then access the corresponding heart beat VFX actor.
            Index := FindOnTeam[PropAgent]
            set HeartBeatVFXData = HeartBeat.AgentVFX[Index]
        then:
            HeartBeat.Enable(PropAgent, HeartBeatVFXData)

        # When this function is cancelled by the prop agent moving, being eliminated, or the player leaving the session, disable the heartbeat.
        defer:
            HeartBeat.Disable(PropAgent, HeartBeatVFXData)
        Sleep(Inf) # Do not stop sleeping until the race is completed.
```

## round\_timer.verse

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }

log_round_timer_device := class(log_channel){}

# An int that allows values between the ranges specified. This type is required by player_ui_slot.ZOrder.
round_int_clamped := type{_X:int where 0 <= _X, _X <= 2147483647}

# This message is used to print the time remaining before a round ends.
TimeRemainingMessage<localizes>(Minutes:string, Seconds:string):message = "{Minutes}:{Seconds}"

<#
This class contains all the logic for managing the round time and displaying the time to the screen.
You can use this device with a round_settings_device to actually end the round.

This device manages time without the use of a timer.
To use this class:

    1) Add the file to your project.

    2) Compile Verse Code from the Verse menu on the toolbar.

    3) Drag the device into your island from your island's Content/Creative Devices folder in the Content Browser.

    4) Include the waiting_for_more_players class in another Verse script with:

        @editable
        RoundTimer:round_timer = round_timer{}

    5) Compile Verse Code from the Verse menu on the toolbar.

    6) Connect the device you made in step 3 to the Verse device.

    7) Start the round timer with the following Verse:
        RoundTimer.Start()

    8) Restart or Stop the timer with the equivalent functions.

    9) Wait for the timer to start with:
        RoundTimer.AwaitStart()

    10) Wait for the timer to complete with:
        RoundTimer.AwaitEnd()
        Call the EndRound function on a round_settings_device to actually end the game round.

#>
round_timer := class(creative_device):
    Logger:log = log{Channel:=log_prop_hunt_device}

    @editable # The time, in minutes, a round lasts.
    RoundTimeInMinutes:float = 5.0

    @editable # The horizontal and vertical position of the timer UI on screen. X 0-1 is left-right and Y 0-1 is top-bottom.
    UIPosition:vector2 = vector2{X:= 0.98, Y:=0.13}

    @editable # The horizontal and vertical position of the timer UI on screen. X 0-1 is left-right and Y 0-1 is top-bottom.
    UIAlignment:vector2 = vector2{X := 1.0, Y := 0.0}

    @editable # The ZOrder of the UI compared to other UI elements.
    UIZOrder:round_int_clamped = 4

    # Signaled when the round has been started.
    RoundStarted:event() = event(){}

    # Signaled when the round is about to be ended.
    RoundEndedEvent:event() = event(){}

    # This map associates a text box for displaying the time to each player.
    var TimeRemainingTextBlocks:[player]text_block = map{}

    # The time remaining before the round completes, as an integer.
    var TimeRemainingInSeconds:int = 0

    # Waits until the round timer is started.
    AwaitStart()<suspends>:void =
        RoundStarted.Await()
        Logger.Print("Round timer started.")

    # Used to start the round timer.
    Start():void =
        Logger.Print("Starting the round timer.")
        RoundStarted.Signal()
        set TimeRemainingInSeconds = GetRoundTimeInSeconds()
        spawn{ Running() }

    # Restarts the timer to RoundTime
    Restart():void =
        Logger.Print("Restarting the round timer.")
        set TimeRemainingInSeconds = GetRoundTimeInSeconds()

    # Runs the timer logic.
    Running()<suspends>:void =
        Logger.Print("Round timer running.")
        loop:
            UpdateTimeUI()
            Sleep(1.0)

            # Decrement TimeRemaining by 1 second then check if the time has run out. If so, end the round.
            set TimeRemainingInSeconds -= 1
            if (TimeRemainingInSeconds < 0):
                Stop()
                break

    # Stops the timer and ends the round.
    Stop():void =
        Logger.Print("Ending the round timer.")

        # We get a player from the players remaining in the scene to end the round.
        Players:[]player = GetPlayspace().GetPlayers()
        if (Instigator := Players[0]):
            RoundEndedEvent.Signal()

    # Waits until the round timer is just about to end.
    AwaitEnd()<suspends>:void =
        RoundEndedEvent.Await()
        Logger.Print("Round timer ended.")

    # Accepts a time value in minutes and returns the value in seconds.
    GetRoundTimeInSeconds():int =
        var InSeconds:int = 0
        if (set InSeconds = Round[RoundTimeInMinutes * 60.0]) {}
        InSeconds

    # When the timer completes, update the time remaining and check if time has expired.
    UpdateTimeUI():void =

        # Set Minutes to TimeRemainingInSeconds/60 without the remainder.
        var Minutes:int = 0
        if (set Minutes = Floor(TimeRemainingInSeconds / 60)) {}

        # Set Seconds to the remainder of TimeRemainingInSeconds/60.
        var Seconds:int = 0
        if (set Seconds = Mod[TimeRemainingInSeconds, 60]) {}

        # Convert Minutes and Seconds to strings.
        MinutesAsString := string("{Minutes}")

        # If Seconds < 10, then we need to add a 0 in front of the value so it displays as :0# instead of :#
        SecondsAsString := if (Seconds < 10) then Join(array{string("{0}"),string("{Seconds}")},string()) else string("{Seconds}")

        # Iterate through all players, check if they have a TimeRemainingTextBlock, if not, give them one. Then update the text.
        Players:[]player = GetPlayspace().GetPlayers()
        for (Player : Players):
            var TextBlock:text_block = text_block{}
            if (set TextBlock = TimeRemainingTextBlocks[Player]) {}
            else:
                set TextBlock = SetUpTimeRemainingUI(Player)
            TextBlock.SetText(TimeRemainingMessage(MinutesAsString, SecondsAsString))

    # Accepts a player and then adds a round time ui canvas to their screen and stores their TimeRemainingTextBlock for updating later.
    SetUpTimeRemainingUI(Player:player):text_block =
        Logger.Print("Adding round timer UI to a player.")

        # This is the text_block that prints the time remaining text to the screen.
        TextBlock:text_block = text_block:
            DefaultTextColor := NamedColors.White
            DefaultShadowColor := NamedColors.Black
        if (PlayerUI := GetPlayerUI[Player]):
            if (set TimeRemainingTextBlocks[Player] = TextBlock) {}

            # This is the canvas that holds and positions the text_block on the screen.
            Canvas := canvas:
                Slots := array:
                    canvas_slot:
                        Anchors := anchors{Minimum := UIPosition, Maximum := UIPosition}
                        Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                        Alignment := UIAlignment
                        SizeToContent := true
                        Widget := TextBlock

            # The canvas is assigned to the player.
            PlayerUI.AddWidget(Canvas, player_ui_slot{ZOrder := UIZOrder})

        # The text_block is returned so it can be saved to the map and updated later as time ticks down.
        return TextBlock
```

## waiting\_for\_more\_players.verse

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }

log_waiting_for_more_players_device := class(log_channel){}

# An int that allows values between the ranges specified. This type is required by player_ui_slot.ZOrder.
waiting_int_clamped := type{_X:int where 0 <= _X, _X <= 2147483647}

# This message is used to print the number of players needed before a round can begin.
WaitingForMorePlayersMessage<localizes>(Count:int):message = "Waiting for {Count} more Player(s)"

# This class is for showing how many players are needed to start the round.
waiting_for_more_players_ui := class:
    var Canvas:canvas
    var TextBlock:text_block
<#
This class contains all the logic for setting a minimum number of players and checking if there are enough to start the round.
To use this class:
    1) Add the file to your project.

    2) Compile Verse Code from the Verse menu on the toolbar.

    3) Drag the device into your island from your island's Content/Creative Devices folder in the Content Browser.

    4) Connect a Timer device to this device's "WaitingForMorePlayersTimer" property.

    5) Include the waiting_for_more_players class in another Verse script with:
        @editable
        WaitingForMorePlayers:waiting_for_more_players = waiting_for_more_players{}

    6) Compile Verse Code from the Verse menu on the toolbar.

    7) Connect the device you made in step 3 to the Verse device and property you exposed in step 6.

    8) Await the CheckForMinimumNumberOfPlayers functions by passing it a player. For example:
        Players = GetPlayspace().GetPlayers()
        CheckForMinimumNumberOfPlayers(Players)

    9) On IslandSettings, Set the Game Start Countdown to 0.0.
#>
waiting_for_more_players := class(creative_device):
    Logger:log = log{Channel:=log_waiting_for_more_players_device}

    @editable # The minimum number of players needed in the match for a round to start.
    MinimumNumberOfPlayers:int = 2

    @editable # The horizontal and vertical position of the timer UI on screen. X 0-1 is left-right and Y 0-1 is top-bottom.
    UIPosition:vector2 = vector2{X:= 0.5, Y:=0.4}

    @editable # The horizontal and vertical position of the timer UI on screen. X 0-1 is left-right and Y 0-1 is top-bottom.
    UIAlignment:vector2 = vector2{X := 0.5, Y := 0.5}

    @editable # The ZOrder of the UI compared to other UI elements.
    UIZOrder:waiting_int_clamped = 3

    @editable # This timer is used to countdown to round start after waiting for players to join the match.
    WaitingForMorePlayersTimer:timer_device = timer_device{}

   # This map associates a UI canvas for displaying the number of players needed to start a round to each player.
    var WaitingForMorePlayersUI:[player]?waiting_for_more_players_ui = map{}

  # Check if there are enough players to start the round. If not, wait until number of players >= MinimumNumberOfPlayers.
    WaitForMinimumNumberOfPlayers(Players:[]player)<suspends>:[]player =
        Logger.Print("Waiting if there are enough players for the round to start.")
        # Creating a new variable so I can modify it as more players join. Initializing it with an array of players passed to the function.
        var PlayersWaiting:[]player = Players
        # If the number of players is less than the minimum needed to start the round...
        if (PlayersWaiting.Length < MinimumNumberOfPlayers):
            loop: # Loop until the number of players is greater than or equal to the minimum needed.
                Logger.Print("{PlayersWaiting.Length}/{MinimumNumberOfPlayers} players needed for the round to start.")
                # Update the waiting for more players UI.
                DisplayWaitingForMorePlayers(PlayersWaiting)
                Sleep(2.0) # Wait to see if more players join the match then check if there are enough players to start the round.
                set PlayersWaiting = GetPlayspace().GetPlayers()
                if (PlayersWaiting.Length >= MinimumNumberOfPlayers):
                    # If there are now enough players, clear the waiting for more players UI,
                    Logger.Print("{PlayersWaiting.Length}/{MinimumNumberOfPlayers} players in round, preparing for round start.")
                    ClearWaitingForMorePlayers()
                    # Then break out of the loop.
                    break
        # start the round start countdown, and wait until the countdown completes.
        WaitingForMorePlayersTimer.Start()
        WaitingForMorePlayersTimer.SuccessEvent.Await()
        Logger.Print("Starting round.")
        # Return the list of players in the session.
        return PlayersWaiting

 # Displays a "Waiting for more players" UI message for each player if they don't already have one. Updates the player counter for all players.
    DisplayWaitingForMorePlayers(Players:[]player):void =
        PlayersNeededCount := MinimumNumberOfPlayers - Players.Length
        Logger.Print("{Players.Length} players in round, waiting for {PlayersNeededCount} more player(s) to join.")
        for (Player: Players):

     # If the player has a WaitingForMorePlayersUI, get the TextBlock and refresh the text so it shows the correct number of players needed to start the round.
            if (UIData := WaitingForMorePlayersUI[Player]?):
                UIData.TextBlock.SetText(WaitingForMorePlayersMessage(PlayersNeededCount))
            # Else create a WaitingForMorePlayersUI for the player.
            else:
                SetUpWaitingForMorePlayersUI(Player, PlayersNeededCount)

  # Accepts a player and player_ui and adds a waiting for more players ui canvas to their screen.
    SetUpWaitingForMorePlayersUI(Player:player, PlayersNeededCount:int):void =
        Logger.Print("Creating 'waiting for more players' UI.")
        if (PlayerUI := GetPlayerUI[Player]):
            # This is the text_block that prints the waiting for more players text to the screen.
            TextBlock:text_block = text_block:
                DefaultText := WaitingForMorePlayersMessage(PlayersNeededCount)
                DefaultTextColor := NamedColors.White
                DefaultShadowColor := NamedColors.Black

  # This is the canvas that holds and positions the text_block on the screen.
            Canvas := canvas:
                Slots := array:
                    canvas_slot:
                        Anchors := anchors{Minimum := UIPosition, Maximum := UIPosition}
                        Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                        Alignment := UIAlignment
                        SizeToContent := true
                        Widget := TextBlock
            # The canvas is assigned to the player.
            PlayerUI.AddWidget(Canvas, player_ui_slot{ZOrder := UIZOrder})
            # The text_block is saved to the map so we can update the text later as more players join the game.
            if (set WaitingForMorePlayersUI[Player] = option{ waiting_for_more_players_ui{Canvas := Canvas, TextBlock := TextBlock} }) {}

  # Removes the "Waiting for more players" UI message for each player who has one.
    ClearWaitingForMorePlayers():void =
        Logger.Print("Clearing 'waiting for more players' UI.")
        for (Player -> UIData : WaitingForMorePlayersUI):
            if:
                PlayerUI := GetPlayerUI[Player]
                Canvas := UIData?.Canvas
                set WaitingForMorePlayersUI[Player] = false
            then:
                PlayerUI.RemoveWidget(Canvas)
```

## Next Section

[![7. Designing Your Island](https://dev.epicgames.com/community/api/documentation/image/6dfb7ca6-e523-43d6-8788-8c2ab35c2f04?resizing_type=fit&width=640&height=640)

1. Designing Your Island

Use your creativity to design your island.](<https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-07-designing-your-island-in-unreal-editor-for-fortnite>)
