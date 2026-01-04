# Multiplayer Skill Checks

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-multiplayer-skill-checks-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:13:29.425822

---

The ****Skilled Interaction Device (Multiplayer)**** room in the [Minigame Mastery template](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-minigame-mastery-template-in-unreal-editor-for-fortnite) is all about teamwork. The room focuses on how to approach the new multiplayer aspects of the [Skilled Interaction](https://dev.epicgames.com/documentation/en-us/fortnite/using-skilled-interaction-devices-in-fortnite-creative) device to unlock new types of quick time events (QTE).

Add the pressure to teams through synchronous skill checks or put the pressure on a random teammate.

[![](https://dev.epicgames.com/community/api/documentation/image/b1990fc1-9d76-4ad6-b08b-d635031da223?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1990fc1-9d76-4ad6-b08b-d635031da223?resizing_type=fit)

## Skilled Interaction Device

You can configure multiplayer for the Skilled Interaction device in the **Queue** category of the device options. There are three multiplayer event types to choose from: **Synchronous**, **Random**, and **Sequential**. Activating one of the **Queue Event Types** enables multiplayer.

|  |  |
| --- | --- |
| Queue Event | Description |
| **Synchronous** | Plays the skill check for all players at the same time.This can put the most pressure on a group. You can set how many successes are required to pass the event. For example, setting it so that all participants must pass. This can get players to seek out skilled teammates. |
| **Random** | Plays the skill check for one random player. This skill check is useful for adding in a bit of pressure to a random player in the queue. |
| **Sequential** | Plays the same skill check one at a time in the order players joined. Useful for relay-based gameplay. Everyone in a line must succeed, perhaps to pass a hot potato from player to player, or a ball from player to player before reaching a goal. |

Multiplayer works around a queue system. If there is no room for that round, players are placed in a queue based on the order that they join. You can set the queue limit with the **Maximum Queued Players** option. If there are no active players at the call for interaction then the player skips to the interaction instead of joining a queue.

[![Squid Game Multiplayer Skill Check in UEFN](https://dev.epicgames.com/community/api/documentation/image/5cbfdafd-4c39-4d8a-acda-9fe654224c6f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5cbfdafd-4c39-4d8a-acda-9fe654224c6f?resizing_type=fit)

Multiplayer Flow

The device is available for all Fortnite islands in Creative and UEFN, but is especially useful for Squid Game islands.

In the template, you can find the device in the **Content Drawer**, under **All > Fortnite > Devices > UI**. To learn more about the device, see [Using Skilled Interaction Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-skilled-interaction-devices-in-fortnite-creative).

## Gameplay

In the mini-game, two teams take part in a versus match. The goal is to hit all their QTEs and not fall into the lava. The pressure is on: each team member must successfully complete their QTEs to avoid the floor falling out from beneath the full team. Teamwork matters, and so does who you have chosen for your team.

The template includes two levels for different room setups. One uses only devices, and the other incorporates Verse. The level with **\_Verse** appended to the end of the level name includes the Verse example. To see how the two levels compare, see the Verse Level section on this page.

### Device-Only Level

Devices Used

- [Skilled Interaction Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-skilled-interaction-devices-in-fortnite-creative) x 10
- [Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) x 1
- [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) x 2
- [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) x 9
- [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) x 3
- [Player Counter](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-counter-devices-in-fortnite-creative) x 11
- [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) x 10
- [Teleporter](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative) x 8
- [Barrier](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative) x 8
- [VFX Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative) x 1
- [Damage Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative) x 1

Both towers have the same setup. Pressing the **Button** device at the top of either stairs adds the player to the tower. To officially start the event, the Button device in the tower must be pressed. This second toggle triggers the following:

- The multiplayer QTE event starts for all players.
- Answer enough before the time runs out to stay safe.
- After a successful skill check another one appears.
- If time runs out or there are too many wrong answers, the floor moves via the **Cinematic Sequence** device, dropping you to the next platform.
- The cycle repeats until a team is in the lava.

Each floor in the tower includes a skill check, creating opportunity for teams to catch up.

[![Squid Game Multiplayer Skill Check  in UEFN](https://dev.epicgames.com/community/api/documentation/image/0b685fd9-7d8f-4064-9769-0e946151068d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0b685fd9-7d8f-4064-9769-0e946151068d?resizing_type=fit)

Multiplayer Skill Check

### Verse Level

The Verse level for the room has the same gameplay but different setup for the flow of triggering the quick time event. Added to the device list is the custom `qte_game_device` and `qte_tower_device` Verse devices.

|  |  |
| --- | --- |
|  |  |
| Game Device User Options | Tower Device User Options |

In the device-only level, two triggers control the flow of the game: **QTE Game Started Trigger** and **QTE Game Ended Trigger**. They send signals to other devices that should for example reset the state of each tower after the game concludes.

Each floor in the tower uses its own device of a certain type, so that the connected events can control the progress of the game. Failure on the current floor triggers devices placed one floor below:

- The Cinematic Sequence device plays the animation of hiding the floor.
- The **Timer** device waits a few seconds before triggering the **Player Counter** device, giving players time to fall down.
- The **Player Counter** device detects players on the floor, and starts the Skilled Interaction device for them at the same time.
- The **Skilled Interaction** device controls the multiplayer QTE.

This failure process repeats for each floor until a team reaches the lava. Above the lava, there’s a volume detecting if the team has lost the game.

With the Verse level, the number of devices is reduced. The flow of the game is controlled by `qte_game_device` and each tower has its own `qte_tower_device`. This setup helps improve the following:

- There is only one **Skilled Interaction** device per tower. This is because the handling of QTE success and failure events for the different floors is implemented in the code.
- There is only one **Timer** device per tower, which is used to delay the start of the **Skilled Interaction** device after a player falls to the next floor.
- The **Player Counter** device for each floor and the **Volume** device near lava to detect when a team has lost the game are removed. The number of floors in the tower and how many are left to the lava is tracked in the Verse code. This information is used to control the game's flow.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# Multiplayer QTEs game logic
qte_game_device := class(creative_device):

    # Timer that allows us to react to the end game with a small time offset
    @editable
    EndGameOffsetTimerDevice : timer_device = timer_device{}

    # Array of towers
    @editable
    Towers : []qte_tower_device = array{}

    var GameStarted : logic = false

    OnBegin<override>()<suspends> : void =
        # Buttons on top of each tower will start multiplayer QTEs game
        for (Tower : Towers):
            Tower.StartGameButton.InteractedWithEvent.Subscribe(StartGame)
        
        # Subscribe function to the end game offset timer
        EndGameOffsetTimerDevice.SuccessEvent.Subscribe(OnEndGameOffsetTimerSuccess)

    # ArrayRace will wait for any tower's event each tower LostEvent
    # In case any of them triggers, it will end the game
    # Idea for improvement:
    #   this device should react to all towers reporting failures and finish the game when there's only one tower left
    WaitForEnd()<suspends> : void =
        ArrayRace(Towers, WaitForTower)
        Print("Someone lost!")
        EndGameOffsetTimerDevice.Start()

    WaitForTower(Tower : qte_tower_device)<suspends> : void =
        Tower.FailedEvent.Await()

    # Should be fired when players push the button at the top of any tower
    StartGame(Agent : agent) : void =
        # Ignore if the game already started
        if (GameStarted?):
            return

        set GameStarted = true

        # Activate all towers
        for (Tower : Towers):
            Tower.Start()

        spawn{WaitForEnd()}

    # Should be fired when the game has ended and towers need to be reset
    EndGame() : void =
        # Ignore if the game already ended
        if (not GameStarted?):
            return

        set GameStarted = false

        # Deactivate all towers
        for (Tower : Towers):
            Tower.Stop()

    OnEndGameOffsetTimerSuccess<private>(Agent : ?agent) : void =
        EndGameOffsetTimerDevice.Reset()
        EndGame()
```

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# Tower logic - a part of multiplayer QTEs game
qte_tower_device := class(creative_device):

    # Button at the top of the tower - starts multiplayer QTEs game for all towers registered in the game's device
    @editable
    StartGameButton : button_device = button_device{}

    # Button near the tower, allowing the player to teleport to the top floor
    @editable
    TeleportToTowerButton : button_device = button_device{}

    # Used to display game status
    @editable
    GameInProgressBillboard : billboard_device = billboard_device{}

    # With Verse we only need one Skilled Interaction Device per tower, because
    # when handling QTE success and failure events, we can affect different floors in the code
    @editable
    SkilledInteraction : skilled_interaction_device = skilled_interaction_device{}

    # With Verse we only need one Timer Device per tower
    # Used to delay start of skilled interaction after falling one floor
    @editable
    NextFloorTimerDevice : timer_device = timer_device{}

    # Player Counter Device - gives us the number of players in the tower
    @editable
    PlayerCounter : player_counter_device = player_counter_device{}

    # Where to move players after the game
    @editable
    EndGameTeleporter : teleporter_device = teleporter_device{}

    # HUD messages for winners and losers
    @editable
    HUDMessageGameWon : hud_message_device = hud_message_device{}
    @editable
    HUDMessageGameLost : hud_message_device = hud_message_device{}
    
    @editable
    TowerFloors : []cinematic_sequence_device = array{}

    FailedEvent<public> : event() = event(){}

    var CurrentFloorIndex : int = 0
    var IsInFailureFlow : logic = false

    # Player to status map:
    # Key: every player that takes part in this tower
    # Value: whether or not player successfully finished QTE
    var CurrentPlayers : [agent]logic = map{}

    OnBegin<override>()<suspends> : void =
        GameInProgressBillboard.HideText()

        NextFloorTimerDevice.SuccessEvent.Subscribe(OnNextFloorTimerSuccess)
        SkilledInteraction.InteractionSucceededEvent.Subscribe(OnInteractionSucceeded)
        SkilledInteraction.InteractionFailedEvent.Subscribe(OnInteractionFailed)
        SkilledInteraction.InteractionCanceledEvent.Subscribe(OnInteractionFailed)

    # Prepares game setup and starts the game
    Start() : void =
        Print("Tower start")

        # Clear players data
        set CurrentPlayers = map{}

        # Initialise the players map data and give a defauly value to the map
        for (Agent : PlayerCounter.GetCountedAgents(), set CurrentPlayers[Agent] = false):

        # Close entrance to the tower and begin game
        StartGameButton.Disable()
        TeleportToTowerButton.Disable()
        GameInProgressBillboard.ShowText()
        BeginQTE()

    # Stops current game and prepares for next round
    Stop() : void =
        Print("Tower stop")

        # Stop the ongoing QTEs
        StopOngoingQTEs()

        # If players are still inside, we can assume they are the winners and move them outside the tower.
        # Losers will be respawned at a checkpoint by falling into the lava
        for (Player->Status : CurrentPlayers):
            # Teleport winners outside of the tower
            EndGameTeleporter.Teleport(Player)
            # Show message about winning the game
            HUDMessageGameWon.Show(Player)

        # Clear players data
        set CurrentPlayers = map{}

        # Open entrance to the tower
        StartGameButton.Enable()
        TeleportToTowerButton.Enable()
        GameInProgressBillboard.HideText()
        NextFloorTimerDevice.Reset()

        # Reset all floors
        for (TowerFloor : TowerFloors):
            TowerFloor.PlayReverse()

        # Set the top floor as the current one
        set CurrentFloorIndex = 0;

    # When players on the floor succeed at multiplayer QTE, we want it to restart after a few seconds
    OnNextFloorTimerSuccess(Agent : ?agent) : void =
        NextFloorTimerDevice.Reset()
        BeginQTE()

    # If everyone succeeds then let's launch another QTE
    OnInteractionSucceeded(Agent : agent) : void =
        if (set CurrentPlayers[Agent] = true):

        if (HasEveryoneSucceeded[]):
            ResetPlayersStatus()
            BeginQTE()

    OnInteractionFailed(Agent : agent) : void =
        if (not IsInFailureFlow?):
            set IsInFailureFlow = true
            ResetPlayersStatus()
            FallOneFloor()

    BeginQTE() : void =
        Print("Begin QTE")
        set IsInFailureFlow = false

        Players := for (Player->Status : CurrentPlayers) {Player}
            
        if (SkilledInteraction.BeginInteraction[Players]):
    
    HasEveryoneSucceeded()<transacts><decides> : void =
        for (Player->Status : CurrentPlayers):
            Status?

    ResetPlayersStatus() : void =
        for (Player->Status : CurrentPlayers, set CurrentPlayers[Player] = false):

    # When players fail at multiplayer QTE, we want them to fall one floor
    FallOneFloor() : void =
        # Stop the ongoing QTEs
        StopOngoingQTEs()

        # Hide the floor players are currently standing on (using a sequence)
        if (TowerFloor := TowerFloors[CurrentFloorIndex]):
            TowerFloor.Play()

            # Check if the next floor exists. If not, players lost the game
            if (CurrentFloorIndex >= TowerFloors.Length - 1):
                # Show message about losing the game
                for:
                    Player->Status : CurrentPlayers
                do:
                    HUDMessageGameLost.Show(Player)

                # Clear players data
                set CurrentPlayers = map{}

                # Send a signal about losing the game after the floor hiding animation ends
                TowerFloor.StoppedEvent.Subscribe(LoseGame)
                return

        # Increment the current floor's index
        set CurrentFloorIndex += 1
        Print("Falling one floor below to floor number {CurrentFloorIndex + 1}")

        # Wait a few seconds before starting a new multiplayer QTE
        NextFloorTimerDevice.Start()

    # Players lost the game
    LoseGame() : void =
        # Multiplayer QTEs game logic should listen to this signal
        FailedEvent.Signal()

    # Stop the ongoing QTEs
    StopOngoingQTEs() : void =
        Players := for (Player->Status : CurrentPlayers):
            Player

        if (SkilledInteraction.EndInteraction[Players]):
            SkilledInteraction.ClearQueue()
```

## Design Tips

Below are additional design considerations:

- Use synchronous to design games like tug of war, skipping games, or dodging an incoming boulder as a team.
- Think of ways to provide opportunities for teams to sabotage one another. They may sacrifice a player who lacks the skills for the quick time event to attack the opposing team.
- Avoid using UI colors that clash, and try to make it clear what type of queue event is happening. You can add extra text to the **Skilled Interaction** device, or use onboarding text to provide players with an overview of the game.
- Use [Verse](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-get-started-in-unreal-editor-for-fortnite) to register players into a **Random queue** while they’re doing something else to surprise them.
- For failed skill checks you can spawn enemies as a consequence.
- The `qte_game_device` waits for one tower to fail and ends the game. You can modify it to count towers that failed, and end the game when there’s just one left. This would allow more towers to participate in the game.
- You can use **Scene Graph** for `qte_tower_device` to generate a tower of any height, with each floor being an instance of a prefab.
- Streamline the floor animation. Currently, the mesh of each floor is referenced by a **level sequence** asset, which is referenced by a separate **Sequence** device. This setup affects each floor’s position absolutely, so moving towers in the scene would require updating all level sequence assets as well. By using different methods, it should be possible to use a single set of animations (fewer assets) and apply them automatically to any floor placed anywhere in the scene.
