# 3. Add Verse Script to Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/stronghold-03-add-verse-script-to-devices-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:14:45.111549

---

This section will show you how to add the Verse script and place the Verse device to customize gameplay.

[![Verse](https://dev.epicgames.com/community/api/documentation/image/7748a704-c4ed-4edb-8abd-9fdf98c0dbb4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7748a704-c4ed-4edb-8abd-9fdf98c0dbb4?resizing_type=fit)

Navigate to **Verse** >  **Verse Explorer** to create a Verse script.

[![Verse Explorer](https://dev.epicgames.com/community/api/documentation/image/ea93a6e2-cc2e-461f-9a0d-96acdab9ed2c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ea93a6e2-cc2e-461f-9a0d-96acdab9ed2c?resizing_type=fit)

Then, right-click your project file name and select **Add new Verse file to project**.

[![New File](https://dev.epicgames.com/community/api/documentation/image/192d2675-787e-4e48-9720-889604bfa575?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/192d2675-787e-4e48-9720-889604bfa575?resizing_type=fit)

Select **Verse Device** and give it a name then click Create. In this tutorial, the Verse device is named Stronghold\_Game\_Manager.

[![Verse Script](https://dev.epicgames.com/community/api/documentation/image/377256f9-004c-4e50-b7f9-a1d94ae9ee88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/377256f9-004c-4e50-b7f9-a1d94ae9ee88?resizing_type=fit)

Double-click the device’s verse file to bring up the Verse script. Copy and paste the code below.

```verse
using { /Fortnite.com/AI }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Fortnite.com/Game }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Simulation }
using { /Verse.org/Verse }

# The Stronghold is a game mode in which the goal is for players to eliminate all hostile enemies at a heavily guarded Stronghold
# The Stronghold Game Manager Verse device is used to manage, monitor, and control the AIs at the Stronghold

stronghold_game_manager := class(creative_device):
    # Device reference to guard spawner device to keep track of for eliminations
    @editable
    GuardsInitialSpawners:[]guard_spawner_device := array{}
    # Device reference to guard spawner device to keep track of for eliminations for multiplayer scaling
    @editable
    GuardsInitialSpawnersAdditional:[]guard_spawner_device := array{}
    # Device reference to reinforcement guard spawner device to trigger when one of the Stronghold guards is alerted
    @editable
    GuardsReinforcementSpawners:[]guard_spawner_device := array{}
    # Device reference to reinforcement guard spawner device to trigger when one of the Stronghold guards is alerted for multiplayer scaling
    @editable
    GuardsReinforcementSpawnersAdditional:[]guard_spawner_device := array{}
    # Device reference to display and track objectives
    @editable
    ObjectiveTracker:tracker_device := tracker_device{}
    # Device reference to display reinforcement in-game message
    @editable
    MessageDeviceReinforcement:hud_message_device := hud_message_device{}
    # Device reference to display fallback in-game message
    @editable
    MessageDeviceFallback:hud_message_device := hud_message_device{}
    # Device reference to end the game with a victory if the players completed the Stronghold without being detected
    @editable
    EndGameVictoryDeviceUndetected:end_game_device := end_game_device{}
    # Device reference to end the game with a victory if the players completed the Stronghold while being detected
    @editable
    EndGameVictoryDeviceDetected:end_game_device := end_game_device{}
    # Device reference to end the game with a fail if the players ran out of retries
    @editable
    EndGameFailDevice:end_game_device := end_game_device{}
    # Adjustable number of player lives
    @editable
    var PlayerRetries:int = 2
    # Device to reference Stronghold leash position
    @editable
    ReinforcementLeashReference:stronghold_leash_position := stronghold_leash_position{}
    # Device to reference Fallback leash position
    @editable
    FallbackLeashReference:stronghold_leash_position := stronghold_leash_position{}
    # Leashes that must be disabled after fallback
    @editable
    LeashesToDisableForFallback:[]stronghold_leash_position := array{}
    # Device for the explosion
    @editable
    ExplosiveDevice:explosive_device := explosive_device{}
    # Guards perception is monitored by this script, the other scripts can subscribe to those events
    # Event broadcasted when a guard calls for reinforcement
    ReinforcementsCalledEvent:event(agent) = event(agent){}
    # Event broadcasted when guards defend the center of the Stronghold
    FallbackEvent:event() = event(){}
    # Event broadcasted when a guard becomes suspicious
    GuardsSuspiciousEvent:event(agent) = event(agent){}
    # Event broadcasted when all guards become unaware
    GuardsUnawareEvent:event(agent) = event(agent){}
    # Event broadcasted when a player is detected
    PlayerDetectedEvent:event(agent) = event(agent){}
    # Event broadcasted when all guards have lost their target
    PlayerLostEvent:event(agent) = event(agent){}
    # Lists of guards in a specific alert state to monitor perception changes
    # Variable to store reinforcement guards
    var<private> NumGuardsSpawned:int := 0
    # Variable to store all Stronghold guards
    var<private> StrongholdGuards:[]agent := array{}
    # Variable to store reinforcement guards
    var<private> ReinforcementGuards:[]agent := array{}
    # List of guards currently suspicious
    var<private> SuspiciousGuards : []agent = array{}
    # List of guards currently alerted
    var<private> AlertedGuards : []agent = array{}
    # List of guards currently investigating
    var<private> InvestigatingGuards : []agent = array{}
    # Initial guard spawners, will include additional spawners with multiplayer session
    var<private> GuardsInitialSpawnersInternal:[]guard_spawner_device = array{}
    # Reinforcement guard spawners, will include additional spawners with multiplayer session
    var<private> GuardsReinforcementSpawnersInternal:[]guard_spawner_device = array{}
    # Gameplay logic variables
    # Variable to track the number of eliminations from all Stronghold guard spawners
    var<private> GuardsEliminated:int := 0
    # Variable to track if the reinforcement were called or not
    var<private> ReinforcementTriggered:logic := false
    # Variable to track if the fallback was triggered
    var<private> FallbackTriggered:logic := false
    # Variable to store the first player agent that gets detected by the guards
    var<private> DetectedPlayer:?player := false
    # Runs when the device is started in a running game.
    OnBegin<override>()<suspends>:void=
        # Check active player for difficulty scaling
        AllPlayers := GetPlayspace().GetPlayers()
        NumberOfActivePlayers := AllPlayers.Length
        set GuardsInitialSpawnersInternal = GuardsInitialSpawners
        set GuardsReinforcementSpawnersInternal = GuardsReinforcementSpawners
        # Add additional Guard Spawner when there is more than 2 players
        if (NumberOfActivePlayers > 2):
            set GuardsInitialSpawnersInternal += GuardsInitialSpawnersAdditional
            set GuardsReinforcementSpawnersInternal += GuardsReinforcementSpawnersAdditional
        var NumInitialGuards:int = 0
        for (GuardSpawner : GuardsInitialSpawnersInternal):
            GuardSpawner.Enable()
            SubscribeToGuardSpawnerEvents(GuardSpawner);
            set NumInitialGuards += GuardSpawner.GetSpawnLimit()
        ObjectiveTracker.SetTarget(NumInitialGuards)
        for (GuardReinforcementSpawner : GuardsReinforcementSpawnersInternal):
            SubscribeToGuardSpawnerEvents(GuardReinforcementSpawner);
            # Subscribing to reinforcement spawned event
            GuardReinforcementSpawner.SpawnedEvent.Subscribe(OnReinforcementSpawned)
            GuardReinforcementSpawner.AlertedEvent.Subscribe(OnReinforcementAlerted)
            GuardReinforcementSpawner.UnawareEvent.Subscribe(OnReinforcementUnaware)
        # Subscribing to player elimination event
        for (StrongholdPlayer : AllPlayers, StrongholdPC := StrongholdPlayer.GetFortCharacter[]):
            StrongholdPC.EliminatedEvent().Subscribe(OnPlayerEliminated)
        StartGameplay()
    SubscribeToGuardSpawnerEvents(SpawnerDevice:guard_spawner_device):void =
        SpawnerDevice.SpawnedEvent.Subscribe(OnGuardSpawned)
        SpawnerDevice.EliminatedEvent.Subscribe(OnGuardEliminated)
        SpawnerDevice.SuspiciousEvent.Subscribe(OnGuardSuspicious)
        SpawnerDevice.AlertedEvent.Subscribe(OnGuardAlerted)
        SpawnerDevice.TargetLostEvent.Subscribe(OnGuardLostTarget)
        SpawnerDevice.UnawareEvent.Subscribe(OnGuardUnaware)
  # Start tracking eliminated guards and trigger the explosion
    StartGameplay()<suspends>:void =
        ObjectiveTracker.AssignToAll()
        Sleep(3.0)
        if (FirstPlayer:=GetPlayspace().GetPlayers()[0]):
            ExplosiveDevice.Explode(FirstPlayer)
    # Runs when guard spawner receives an alerted event and considers only the first alert event
    OnGuardAlerted(InteractionResult:device_ai_interaction_result):void=
        if:
            not ReinforcementTriggered?
            set DetectedPlayer = option{player[InteractionResult.Target?]}
            Guard:=InteractionResult.Source?
        then:
            var NumGuards:int = ObjectiveTracker.GetTarget()
            # Enabling the reinforcement guard spawner device ensures that we spawn the amount of guards configured in the guard spawner device.
            for (GuardReinforcementSpawner : GuardsReinforcementSpawnersInternal):
                GuardReinforcementSpawner.Enable()
                set NumGuards += GuardReinforcementSpawner.GetSpawnLimit()
            ObjectiveTracker.SetTarget(NumGuards)
            # Displaying in-game message for detection and incoming reinforcement
            MessageDeviceReinforcement.Show()
            set ReinforcementTriggered = true
            # Signal Reinforcement event
            ReinforcementsCalledEvent.Signal(Guard)
        # Add the guard to the list of alerted guards if it hasn't been previously added
        if(Guard:=InteractionResult.Source?):
            if (not AlertedGuards.Find[Guard]):
                set AlertedGuards += array{Guard}
            option {set SuspiciousGuards = SuspiciousGuards.RemoveFirstElement[Guard]}
            option {set InvestigatingGuards = InvestigatingGuards.RemoveFirstElement[Guard]}
           # Broadcast the Player Detected Event when one guard is alerted
            if (AlertedGuards.Length = 1):
                PlayerDetectedEvent.Signal(Guard)
    # Runs when reinforcement guard spawner receives an alerted event
    OnReinforcementAlerted(InteractionResult:device_ai_interaction_result):void=
        if:
            not FallbackTriggered?
            Guard:=InteractionResult.Source?
        then:
            # Clear leash for reinforcement on alerted so they attack their target
            ReinforcementLeashReference.ClearLeashOnGuard(Guard)
    # Runs when reinforcement guard spawner receives an unaware event
    OnReinforcementUnaware(Guard:agent):void=
        if (not FallbackTriggered?):
            # Set back the leash
            ReinforcementLeashReference.ApplyLeashOnGuard(Guard)
    # Runs when guard spawner receives an unaware event
    OnGuardSuspicious(Guard:agent):void=
        if (not SuspiciousGuards.Find[Guard]):
            set SuspiciousGuards += array{Guard}
            # Broadcast the Suspicious Event when one guard is suspicious
            if:
                SuspiciousGuards.Length = 1
                AlertedGuards.Length = 0
                InvestigatingGuards.Length = 0
            then:
                GuardsSuspiciousEvent.Signal(Guard)
    # Runs when guard spawner receives an unaware event
    OnGuardUnaware(Guard:agent):void=
        option {set AlertedGuards = AlertedGuards.RemoveFirstElement[Guard]}
        option {set SuspiciousGuards = SuspiciousGuards.RemoveFirstElement[Guard]}
        option {set InvestigatingGuards = InvestigatingGuards.RemoveFirstElement[Guard]}
        # Broadcast the Unaware Event when no guard is suspicious, alerted or investigating
        if:
            SuspiciousGuards.Length = 0
            AlertedGuards.Length = 0
            InvestigatingGuards.Length = 0
        then:
            GuardsUnawareEvent.Signal(Guard)
    # When a guard loses track of the player, remove it from the alerted guards list, when all guards have lost player, signal the event
    OnGuardLostTarget(InteractionResult:device_ai_interaction_result):void=
        if (Guard := InteractionResult.Source?):
            if (not InvestigatingGuards.Find[Guard]):
                set InvestigatingGuards += array{Guard}
            # Broadcast the Player Lost Event when no guard is alerted
            if (set AlertedGuards = AlertedGuards.RemoveFirstElement[Guard]):
                if (AlertedGuards.Length = 0):
                    PlayerLostEvent.Signal(Guard)
    # Runs when a reinforcement guard is spawned. Each reinforcement guard is forced to attack the player that alerted the Stronghold
    OnReinforcementSpawned(Guard:agent):void=
        set ReinforcementGuards += array{Guard}
        ReinforcementLeashReference.ApplyLeashOnGuard(Guard)
        # Assigns the player that alerted the Stronghold guards as the target
        if (Target := DetectedPlayer?):
            for (GuardReinforcementSpawner : GuardsReinforcementSpawnersInternal):
                GuardReinforcementSpawner.ForceAttackTarget(Target, ?ForgetTime:=30.0)
   # Runs when any guard from the Stronghold is spawned
    OnGuardSpawned(Guard:agent):void=
        set StrongholdGuards += array{Guard}
        set NumGuardsSpawned += 1
   # Runs when initial or reinforcement spawners receive an elimination
    OnGuardEliminated(InteractionResult:device_ai_interaction_result):void=
        set GuardsEliminated += 1
        if (EliminatedAgent := InteractionResult.Target?):
            # Remove eliminated guard from the alerted guards list
            option {set AlertedGuards = AlertedGuards.RemoveFirstElement[EliminatedAgent]}
            option {set SuspiciousGuards = SuspiciousGuards.RemoveFirstElement[EliminatedAgent]}
            option {set InvestigatingGuards = InvestigatingGuards.RemoveFirstElement[EliminatedAgent]}
            option {set StrongholdGuards = StrongholdGuards.RemoveFirstElement[EliminatedAgent]}
        if (EliminationAgent := InteractionResult.Source?):
            # Increasing progress value for tracker device for each elimination
            ObjectiveTracker.Increment(EliminationAgent)
            if (ReinforcementTriggered?):
                if (NumGuardsSpawned - GuardsEliminated = 3):
                    StartFallback()
            # Ends the game mode if all guards were eliminated without the reinforcements
                if (GuardsEliminated >= NumGuardsSpawned):
                   EndGameVictoryDeviceDetected.Activate(EliminationAgent)
            else:
                # Ends the game mode if all guards were eliminated with the reinforcements
                if (GuardsEliminated >= NumGuardsSpawned):
                    EndGameVictoryDeviceUndetected.Activate(EliminationAgent)
    # Assigns a new fallback leash when a few alerted guards are remaining to defend the center of the Stronghold
    StartFallback():void=
        # Displaying in-game message for guards retreating inside the Stronghold building
        MessageDeviceFallback.Show()
        set FallbackTriggered = true
        for (LeashDevice : LeashesToDisableForFallback):
            LeashDevice.DisableLeashAndPatrolPaths()
        FallbackLeashPosition := FallbackLeashReference.GetTransform().Translation
        FallbackEvent.Signal()
        for (Guard : StrongholdGuards):
            FallbackLeashReference.ApplyLeashOnGuard(Guard)
     # Runs when a player elimination event is received
    OnPlayerEliminated(EliminationResult:elimination_result):void=
        set PlayerRetries -= 1
        if (PlayerRetries = 0, Agent := EliminationResult.EliminatedCharacter.GetAgent[]):
            EndGameFailDevice.Activate(Agent)
```

[![Build Code](https://dev.epicgames.com/community/api/documentation/image/b43e70d5-3ca8-4dbd-99bf-44760e2d58db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b43e70d5-3ca8-4dbd-99bf-44760e2d58db?resizing_type=fit)

Next, navigate to **Verse** > **Build Verse Code** to compile the Verse script.

[![Content Drawer](https://dev.epicgames.com/community/api/documentation/image/84e3d8c1-972e-461c-928f-5b28d9a0c6c0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/84e3d8c1-972e-461c-928f-5b28d9a0c6c0?resizing_type=fit)

Navigate to **All/"Project Name"/CreativeDevices/** and select your Verse device.

[![Device Drag](https://dev.epicgames.com/community/api/documentation/image/725ce8a1-2963-4f31-ac39-a925cb54d984?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/725ce8a1-2963-4f31-ac39-a925cb54d984?resizing_type=fit)

Then, drag your Verse device onto your map. This will only appear after compiling the Verse script.

With your Verse device selected, navigate to the **Details** panel and update the **User Options** as shown below.

[![Device Settings](https://dev.epicgames.com/community/api/documentation/image/2b1deac2-0b6a-4d06-a083-b645e5da4ca4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b1deac2-0b6a-4d06-a083-b645e5da4ca4?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible in Game** | True | This device will be visible during the game. |
| **Enabled at Game Start** | True | This device will be enabled when the game begins. |
| **Guards\_InitialSpawners** | 7 Array elements | Click the plus sign to add three elements to this setting. |
| **0** | Guard Spawner Init | This is an array of all the devices used to spawn the initial Guards at the stronghold. |
| **1** | Guard Spawner Sniper Tower 1 | This is an array of all the devices used to spawn the initial Guards at the stronghold. |
| **2** | Guard Spawner Sniper Tower 2 | This is an array of all the devices used to spawn the initial Guards at the stronghold. |
| **3** | Guard Spawner Investigate Crash | This is an array of all the devices used to spawn the crash site Guards. |
| **4** | Guard Spawner Initial Move to Sniper A | This is an array of all the devices used to move a set of Guard spawners. |
| **5** | Guard Spawner Initial Move to Sniper B | This is an array of all the devices used to move a set of Guard spawners. |
| **4** | Guard Spawner Init Patrol | This is an array of all the devices used to move a set of patrol Guards. |
| **GuardsInitialSpawnersAdditional** | Guard Spawner Init Additional | Spawns an additional set of guards. |
| **GuardReinforcementSpawners** | Guard Spawner Reinforcement\_East | Spawns reinforcement guards for a certain area. |
| **GuardReinforcementSpawners** | Guard Spawner Reinforcement\_North | Spawns reinforcement guards for a certain area. |
| **GuardReinforcementSpawners** | Guard Spawner Reinforcement\_West | Spawns reinforcement guards for a certain area. |
| **GuardReinforcementSpawnersAdditional** | Guard Spawner Reinforcement\_East\_Additional | Spawns additional reinforcement guards for a certain area. |
| **GuardReinforcementSpawnersAdditional** | Guard Spawner Reinforcement\_West\_Additional | Spawns additional reinforcement guards for a certain area. |
| **Objective Tracker** | Tracker | Displays the stronghold objectives and elimination count. |
| **MessageDeviceReinforcement** | HUD Message Device Reinforcement | Displays the reinforcement on-screen message. |
| **MessageDeviceFallback** | HUD Message Device Fallback | Displays the fallback on-screen message. |
| **EndGameVictoryDeviceUndetected** | End Game Device Undetected | Displays the victory and undetected end screen. |
| **EndGameVictoryDeviceDetected** | End Game Device Detected | Displays the victory and detected end screen. |
| **EndGameFailDevice** | End Game Device Fail | Displays the failed end screen because the player ran out of lives. |
| **PlayerRetries** | 2 | Determines the number of lives the player has to try to complete the stronghold successfully. If the player runs out of lives, the stronghold is failed. |
| **ReinforcementLeashReferernce** | Leash Position Stronghold | The Leash Position devices use its position as the origin of the reinforcement leash. |
| **FallbackLeashReference** | Leash Position Fallback | The Leash Position device uses its position as the origin of the fallback leash. |
| **LeashesToDisableForFallback** | 5 Array elements | Determines the leashes to disable for guards to fallback. |
| **0** | Guards Leash Position 1 | Determines the outer radius for the stronghold leash. |
| **1** | Guards Leash Position 2 | Determines in centimeters the inner radius for the defend fallback leash. Must be smaller than the outer radius. |
| **2** | Reinforcement Leash Position | Determines the reinforcement leash position. |
| **3** | Sniper tower 1 leash position | Determines the leash position for the first sniper tower. |
| **4** | Spiper tower 2 leash position | Determines the leash position for the second sniper tower. |
| **Explosive Device** | Explosive Device | References the Explosive Barrel device. |

## Next Section

[Set Up Leash Devices](https://dev.epicgames.com/documentation/en-us/uefn/stronghold-04-set-up-leash-devices-in-unreal-editor-for-fortnite)
