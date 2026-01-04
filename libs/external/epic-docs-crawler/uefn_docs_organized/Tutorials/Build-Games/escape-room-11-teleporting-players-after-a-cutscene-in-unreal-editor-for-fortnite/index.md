# 11. Teleporting Players After a Cutscene

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-11-teleporting-players-after-a-cutscene-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:18:13.989443

---

To create the opening scene where the player is part of the cutscene, you need to teleport the player to the basement after the opening cutscene finishes playing. To do this, you’ll use the code snippet below:

```verse
    AllPlayers := GetPlayspace().GetPlayers()
        for (Agent : AllPlayers):
            Teleporter.Teleport(Agent)
```

This piece of code is designed to grab all players on your island and apply a function to them. In this case, teleportation.

## Teleporting Players after a Cutscene

Create a new Verse device named **cutscene\_****trasnporter** using Verse Explorer, and drag the device into the level. Double-click **cutscene\_transporter.verse** from Verse Explorer to open the script in Visual Studio Code.

1. Underneath the **transporter\_device** class definition, add editable fields for the following devices:

- CinemtaicSequence
- Teleporter
- PlayerSpawner

  ```verse
  		
        cutscene_transporter := class(creative-device):
  		
            @editable 
  		
            CinematicSequence : cinematic_sequence_device = cinematic_sequence_device{}
  		
            @editable    
  		
            Teleporter : teleporter_device = teleporter_device{}
  		
            @editable   
  		
            PlayerSpawner : player_spawner_device = player_spawner_device{}
  		
  ```

1. Add a new method `TeleportPlayers()` to the `teleport_device` class. This method teleports each player to the teleporter you set up in the sub-basement. Add the code snippet from earlier to the `TeleportPlayers()` method.

   ```verse
   		
   			
   		
            TeleportPlayers():void=
   		
                AllPlayers := GetPlayspace().GetPlayers()
   		
                    for (Agent : AllPlayers):
   		
                        Teleporter.Teleport(Agent)
   		
   ```
2. In `OnBegin()`, subscribe the `StoppedEvent` from your `CinematicSequence` to the `TeleportPlayers()` method. Subscribing `TeleportPlayers()` this event causes the device to listen for the `StoppedEvent` of the `CinematicSequence`, then executes the method TeleportPlayers below.

   ```verse
            OnBegin<override>()<suspends>:void=

                Print("Loading Cutscene")

                CinematicSequence.StoppedEvent.Subscribe(TeleportPlayers)
   ```
3. Your `teleporter_device` code should now look like the following:

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }

        ## A Verse-authored creative device that can be placed in a level
        log_transporter_device := class(log_channel){}

        transporter_device := class(creative_device):

            @editable
            CinematicSequence : cinematic_sequence_device = cinematic_sequence_device{}

            @editable
            Teleporter : teleporter_device = teleporter_device{}

            @editable
            PlayerSpawner : player_spawner_device = player_spawner_device{}

            ## Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
                Print("Loading CutScene")

                CinematicSequence.StoppedEvent.Subscribe(TeleportPlayers)

            TeleportPlayers():void=
               AllPlayers := GetPlayspace().GetPlayers()
                for (Agent : AllPlayers):
                    Teleporter.Teleport(Agent)
   ```
4. Save the script in Visual Studio Code, and in UEFN, click **Build Verse Code**.
5. Place the **Player Spawner** in the parking lot of the Durr Burger, and the **Teleporter** should be placed in the holding area of the sub basement.
6. Select the **teleport\_device** in the **Outliner** and assign the **Cinemtaic Sequence**, **Player Spawner**, and **Teleporter** devices to their respective properties in the **Details** panel.
7. Click **Push Changes** to playtest the code.

When the cutscene begins, the player should begin in the Durr Buger parking lot. Once the cutscene finishes playing, the player should be teleported to the basement where the game begins.

## Next Section

In the next step of this tutorial, you’ll learn how to use cinematics both drive the story and create mood and atmosphere.

[![12. Cinematics](https://dev.epicgames.com/community/api/documentation/image/55d25538-b892-41be-bdf8-96569d73c0d4?resizing_type=fit&width=640&height=640)

12. Cinematics

Learn how to make cinematics to show players obstacles using a camera shake and sequencer.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-12-custom-assets-in-unreal-editor-for-fortnite)
