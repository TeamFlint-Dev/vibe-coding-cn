# 2. Playing Visual Effects on Players

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-02-playing-visual-effects-on-players-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:23:13.452435

---

This section will show you how to add custom heartbeat VFX [(visual effect)](https://dev.epicgames.com/documentation/en-us/fortnite/visual-effects-in-unreal-editor-for-fortnite) to your gameplay that gives away an unmoving prop’s location.

When players of the prop team are idle for too long, a heartbeat visual effect plays on that player, notifying the hunter team. This visual effect is registered to each player of the prop team as they spawn into the game.

You’ll use VFX Spawner devices along with Verse to implement the heartbeat functionality. This includes:

- Activating the visual effects.
- Teleporting the VFX Spawner to the players.
- Creating a UI showing members of the prop team how long they have left to move before the heartbeat goes off.

This tutorial includes Verse snippets that show how to execute gameplay mechanics needed in this game. Follow the steps below and copy the full script on [step 6](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-06-adding-the-full-script-in-unreal-editor-for-fortnite) of this tutorial.

## Before You Begin

[![Asset Folders](https://dev.epicgames.com/community/api/documentation/image/42eb1dd3-d8dd-41fb-8d72-8be0e1c7aceb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42eb1dd3-d8dd-41fb-8d72-8be0e1c7aceb?resizing_type=fit)

It’s good practice to keep assets and devices organized in folders to make locating them easier. You can group devices by purpose, location, type, or however else you would like.

*You can move placed assets to folders and actors you create.*

In the gif above, the VFX Spawner device is being dragged into the prop team’s HeartBeatVFX folder for organization purposes. You can also right-click and select **Move To** to choose the folder you want the asset moved to.

**Devices used:**

- ~ 16 x [VFX Spawners](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-vfx-spawner-devices-in-fortnite-creative)

## VFX Spawner Device

[![VFX Spawner](https://dev.epicgames.com/community/api/documentation/image/99b453b0-477f-4799-804f-cd04f254ccb5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/99b453b0-477f-4799-804f-cd04f254ccb5?resizing_type=fit)

Create a VFX spawner for each player. When a player needs the VFX, it will be teleported to the player's location. When no longer needed, it will be hidden until it is needed again.

The VFX Spawners in this template use Niagara VFX to make custom assets that show during gameplay. The VFX assets used in this tutorial are set to display a heartbeat to reveal unmoving players on the prop team. This VFX will appear over props that have been static for at least 15 seconds.

You can visit our documentation’s [Visual Effects](https://dev.epicgames.com/documentation/en-us/fortnite/visual-effects-in-unreal-editor-for-fortnite) section for many tutorials on how to create heartbeat VFX. You can then use the custom heartbeat you created with the VFX Spawner.

You can try this when you place a VFX Spawner. From the **Details** panel, select your custom effect from the **Custom Visual Effect** dropdown menu. Make sure to enable **Custom Visual Effect Override** for the selected VFX to appear in the viewport.

[![Select your own custom VFX from the VFX spawner.](https://dev.epicgames.com/community/api/documentation/image/0ab3b205-1b23-4a2f-9d68-0dae140bb7bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0ab3b205-1b23-4a2f-9d68-0dae140bb7bb?resizing_type=fit)

From here, you can further customize your effect from the Details panel by adding color and deciding when the VFX will play and who it will be seen by.

Place this device in a location unseen by players and configure the **User Options** to match the table below. Then, copy and paste this device to match the number of players your gameplay allows.

[![Modified VFX Spawner](https://dev.epicgames.com/community/api/documentation/image/1d6e2bfd-5d14-4fc0-9969-7d481814926c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d6e2bfd-5d14-4fc0-9969-7d481814926c?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Custom Visual Effect** | HeartBeatVFX | Defines a custom particle to use rather than one from the preset list. |
| **Custom Visual Effect Override** | True | Determines whether to use developer FX. |
| **Enabled on Phase** | Gameplay Only | Determines the game phases during which the device will be enabled. An enabled VFX Spawner will play its defined particle effect. |

## Play Heartbeat Effects at a Location

Follow these steps to move the VFX Spawner device in Verse to play and stop the heartbeat effect on players of the prop team.

1. [Create a new Verse file](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) in your project called **heartbeat.verse**. This will not be a Verse device, so you can create it as an empty Verse file.
2. Start by double-clicking the Verse file you created to add the following [Verse paths to import](https://dev.epicgames.com/documentation/en-us/uefn/verse-api).

   ```verse
        using { /Fortnite.com/Characters }
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/UI }
        using { /UnrealEngine.com/Temporary/SpatialMath }
        using { /UnrealEngine.com/Temporary/Diagnostics }
        using { /UnrealEngine.com/Temporary/UI }
        using { /Verse.org/Colors }
        using { /Verse.org/Simulation }
   ```
3. This code creates a class named `heartbeat_vfx` in **heartbeat.verse**. The `heartbeat_vfx` class contains a struct of data to track `vfx_spawner_device` objects per player as well as the functions to set the VFX to a position or reset it.

   ```verse
        log_heart_beat := class(log_channel){}
            # These messages are used to notify a prop agent with a message (or to hide it) when they need to move to avoid their heartbeat from becoming visible.
        HeartBeatWarningMessage<localizes>(Time:int):message = "Heart Beat in {Time} Seconds. Move!"
        HeartBeatWarningClear<localizes>:message = ""
            # This class exposes the editable properties for the heartbeat to the prop_hunt Verse device.
        heart_beat := class<concrete>():
            Logger:log = log{Channel:=log_heart_beat}
            @editable # The number of seconds before a prop agent must move before the heartbeat reveals their position.
            MoveTime:float = 15.0
            @editable # The seconds remaining before the heartbeat warning appears. Shouldn't be > than HeartBeatTimer.
            WarningTime:float = 5.0
            @editable # An array of heartbeat VFX devices. There is one per player.
            AgentVFX:[]heartbeat_vfx = array{}
            @editable # The Radio Player device used to play the heartbeat sound effects (SFX).
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
                    # Set the heart beat VFX's position to the prop agent's position.
                    HeartBeatVFXData.Activate(Character.GetTransform())
                    # Increment the heartbeat count, and if this is the first heartbeat playing, we need to play the audio to get it started.
                    set NumberOfHeartBeats += 1
                    if (NumberOfHeartBeats = 1) then SFXPlayer.Play()
                    # Register the prop agent to the audio player device so the heart beat audio will play from that position.
                    SFXPlayer.Register(PropAgent)
                else:
                    Logger.Print("Character, Index, or HeartBeatVFXData not found. Cannot start the heartbeat")
            # Clears the heartbeat VFX and SFX for the specified prop agent.
            Disable(PropAgent:agent, HeartBeatVFXData:heartbeat_vfx):void =
                Logger.Print("Disabling heart beat.")
                # Deactivate the VFX visuals.
                HeartBeatVFXData.Deactivate()
                # Unregister the prop agent from the audio player device, causing the heart beat audio to stop.
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
   ```
4. This code creates an `Activate()` method in the `heartbeat_vfx` class that takes a transform argument and moves the VFX Spawner device to that `transform`.

   ```verse
        # The heartbeat_vfx class contains a struct of data to track the VFX's root and vfx_spawner_device objects per player as well as the functions to set the VFX to a position or reset it.
        heartbeat_vfx := class<concrete>:
            @editable # The VFX device for each heart beat.
            VFXDevice:vfx_spawner_device = vfx_spawner_device{}
            # This offset is used to position the heartbeat above a prop agent's head.
            HeartBeatVFXOffset:vector3 = vector3{X := 0.0, Y := 0.0, Z := 110.0}
            # Sets the position of the heart beat VFX and then enables the VFX.
            Activate(Transform:transform):void =
                VFXPosition := Transform.Translation + HeartBeatVFXOffset
                if (VFXDevice.TeleportTo[VFXPosition, Transform.Rotation]):
                    VFXDevice.Enable()
   ```
5. This code creates a `Deactivate()` method in the `heartbeat_vfx` class that disables the VFX Spawner device and therefore hides the heartbeat visuals.

   ```verse
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

## Display Heartbeat Warning to a Player

Follow these steps to set up a custom UI with a text block that will display the heartbeat warning message. See [In-Game User Interfaces](https://dev.epicgames.com/documentation/en-us/fortnite/ingame-user-interfaces-in-unreal-editor-for-fortnite) to learn more about creating custom UI and other Verse UI components.

1. The two constants below control the text that will be shown to players of the prop team at different times in the game.

   - The constant `HeartBeatWarningMessage` is a function that takes an `int` and returns the type `message`. This type is used in UI elements because it can be localized. This is the text that players will see when they need to move to avoid their heartbeat effect revealing their position.
   - The constant `HeartBeatWarningClear` is an empty `message` that will be shown so that players no longer see the warning message.

     ```verse
       # These messages are used to notify a prop agent with a message (or to hide it) when they need to move to avoid their heartbeat from becoming visible.
       HeartBeatWarningMessage<localizes>(Time:int):message = "Heart Beat in {Time} Seconds. Move!"
       HeartBeatWarningClear<localizes>:message = ""
     ```
2. Create a new class named `heartbeat_warning_ui` in **heartbeat.verse**. The heartbeat\_warning\_ui class contains a struct of data to track the UI canvas and text\_block per player as well as the function to create a new heartbeat warning UI canvas.

   ```verse
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
   ```

## Manage Heartbeat Effects

Follow these steps to create the heartbeat manager.

1. The code below creates a class named `heart_beat` in **heartbeat.verse**. This class exposes the editable properties for the heartbeat to the prop\_hunt device and manages the heartbeat effects.

   ```verse
        log_heart_beat := class(log_channel){}
        # This class exposes the editable properties for the heartbeat to the prop_hunt device.
        heart_beat := class<concrete>():
            Logger:log = log{Channel:=log_heart_beat}
                @editable
                MoveTime:float = 15.0
   ```
2. This code adds the following editable properties to the `heart_beat` class.

   1. This code controls the seconds before a prop agent must move before the heartbeat effect reveals its position.

      ```verse
           @editable 
           MoveTime:float = 15.0
      ```

      1. This code controls the seconds remaining before words appear on screen to warn a prop team member and tell them to move before the heartbeat goes off.

      ```verse
       @editable
       WarningTime:float = 5.0
      ```

      1. This code is an array of heartbeat VFX devices. There is one per player.

      ```verse
       @editable
       AgentVFX:[]heartbeat_vfx = array{}
      ```

      1. In this code, the Radio Player device is used to play the heartbeat sound effects (SFX).

      ```verse
       @editable
       SFXPlayer:radio_device = radio_device{}
      ```
3. This code maps associates a UI for displaying the heartbeat warning to each prop agent.

   ```verse
        # This map associates a UI for displaying the heartbeat warning to each prop agent.
        var WarningUI:[agent]heartbeat_warning_ui = map{}
   ```
4. This code keeps track of how many players have an active heartbeat so we can manage the SFX device.

   ```verse
        # Keeps track of how many players have an active heartbeat so we can manage the SFX device.
        var NumberOfHeartBeats:int = 0
   ```
5. This code shows the warning UI for players.

   ```verse
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
   ```
6. This code activates visual effects (VFX) and sound effects (SFX) for the specified player.

   ```verse
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
   ```
7. This code creates a method to disable the VFX and SFX for one player, and another to disable it for all players.

   ```verse
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
   ```

## Next Section

[![3. Playing Effects on Idle Players](https://dev.epicgames.com/community/api/documentation/image/29b74f2b-a3a4-40a0-8c54-b92ee2228969?resizing_type=fit&width=640&height=640)

3. Playing Effects on Idle Players

Use the Verse code in this section to add effects to idle players.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-03-playing-effects-on-idle-players-in-unreal-editor-for-fortnite)
