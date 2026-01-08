# 5. Set Up Audio and Visual Effects

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/stronghold-05-set-up-audio-and-visual-effects-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:14:31.839286

---

This section will show you how to set up audio, like barks, and visual effects, like camera shakes, to create engaging gameplay.

## Audio Player Device

You can use the **Audio Player** device to set use dialog lines from guards. In game development, these are often referred to as **barks**.

[![Barks](https://dev.epicgames.com/community/api/documentation/image/23511e9f-7d68-4396-9bbb-57490ea34b95?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23511e9f-7d68-4396-9bbb-57490ea34b95?resizing_type=fit)

You can find imported audio in **"Project folder" > Barks**. Click the Play icon to hear the audio file, then drag and drop it onto your island.

[![Audio File](https://dev.epicgames.com/community/api/documentation/image/61165032-237d-44e8-8e7c-d30a115e8b77?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/61165032-237d-44e8-8e7c-d30a115e8b77?resizing_type=fit)

Dropping an audio file onto your island will place an Audio Player device, which is hooked up to a Verse device to play a series of customs guard callouts. These callouts react to different events, like spotting the player or taking damage.

Place one Audio Player for every unique piece of audio that you want to play. This tutorial uses 14 different barks, with 14 different Audio Player devices placed.

To set up these devices, customize the following settings:

[![Leash Audio](https://dev.epicgames.com/community/api/documentation/image/95afa4e3-aa89-49d4-97ce-7a0318654184?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/95afa4e3-aa89-49d4-97ce-7a0318654184?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Volume** | 4.0 | This setting can vary depending on your recording. |
| **Restart Audio when Activated** | True | This audio will play from the beginning when activated. |
| **Play on Hit** | False | This device will not play audio when hit by a player. |
| **Play Location** | Instigating Player | Audio will be played based on the instigating player's loacation instead of the device location. |
| **Enable Volume Attenuation** | False | Changes the volume based on the distance from the device or guard set to play it. For this tutorial, the player can hear the audio no matter how far away they are. |

Next, set up the Verse script to handle the logic for triggering the Audio Player devices during the game, then place the Verse device. For this tutorial, the device is named **Stronghold Bark Manager**.

Paste the following Verse script.

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Game }
using { /Fortnite.com/Characters }
using { /Verse.org/Random }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
# Audio bark that can be played on a NPC
audio_npc_bark := class<concrete>:
    # Audio device to play barks
    @editable
    BarkDevice:audio_player_device := audio_player_device{}
    # Option to allow NPCs to repeat the bark
    @editable
    CanRepeat:logic = true
    # Delay between the event and the beginning of the bark
    @editable
    Delay:float = 0.0
    # Delay before repeating this bark
    @editable
    Cooldown:float = 5.0
    # Bark name for logging
    @editable
    BarkID:string = "Missing ID"
    # Is the cooldown timer elapsed
    var<private> IsInCooldown:logic = false
    # Event to stop the bark
    StopBarkEvent<private>:event() = event(){}
    PlayBark(Agent:agent)<suspends>:void=
        var IsPlaying:logic = false;
        defer:
            if (IsPlaying?):
                set IsPlaying = false
                set IsInCooldown = false
                BarkDevice.Stop(Agent)
        race:
            block:
                StopBarkEvent.Await()
                return
            block:
                AwaitAgentDown(Agent)
                return
            block:
                if (Delay > 0.0):
                    Sleep(Delay)
                if (IsInCooldown?):
                    return
                BarkDevice.Play(Agent)
                set IsPlaying = true
                set IsInCooldown = true
                Sleep(2.0)
                set IsPlaying = false
        if (CanRepeat?):
            Sleep(Cooldown)
            set IsInCooldown = false
    StopBark():void=
        StopBarkEvent.Signal()
    AwaitAgentDown<private>(Agent:agent)<suspends>:void=
        if (Character := Agent.GetFortCharacter[]):
            loop:
                if (Character.GetHealth() <= 0.0):
                    return
                Character.DamagedEvent().Await()
# Script that handles barks from guards
stronghold_bark_manager := class(creative_device):
    # Reference to the Game Manager to monitor perception events
    @editable
    StrongholdGameManager:stronghold_game_manager := stronghold_game_manager{}
    # Audio Player Devices
    @editable
    BarkNPCDown:audio_npc_bark = audio_npc_bark{BarkID := "Man Down", Delay := 0.3}
    @editable
    BarkFallback:audio_npc_bark = audio_npc_bark{BarkID := "Fallback", CanRepeat := false, Delay := 3.0}
    @editable
    BarkNeedBackup:audio_npc_bark = audio_npc_bark{BarkID := "Need Backup", CanRepeat := false, Delay := 2.0}
    @editable
    BarkGoToLeash:audio_npc_bark = audio_npc_bark{BarkID := "Reinforcements En Route", CanRepeat := false, Delay := 4.0}
    @editable
    BarkDamageTaken:audio_npc_bark = audio_npc_bark{BarkID := "Took Damage", Delay := 0.2}
    @editable
    BarkDamagePlayer:audio_npc_bark = audio_npc_bark{BarkID := "Hit Player", Delay := 0.2}
    @editable
    BarkEliminatedPlayer:audio_npc_bark = audio_npc_bark{BarkID := "Eliminated Player", Delay := 0.3}
    @editable
    BarkPlayerSpotted:audio_npc_bark = audio_npc_bark{BarkID := "Spotted Player", CanRepeat := false}
    @editable
    BarkPlayerLost:audio_npc_bark = audio_npc_bark{BarkID := "Lost Player", Cooldown := 10.0}
    @editable
    BarkGuardSuspicious:audio_npc_bark = audio_npc_bark{BarkID := "Suspicious", Cooldown := 10.0}
    @editable
    BarkGuardUnaware:audio_npc_bark = audio_npc_bark{BarkID := "Unaware", Cooldown := 10.0}
    # Variable to store if guards were looking for targets
    var<private> HasLostTarget:logic := false
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        ConfigureBarks()
        sync:
            AwaitReinforcements()
            AwaitFallback()
            PlayAwarenessBarks()
    PlayBark(Bark:audio_npc_bark, Guard:agent):void=
        spawn {Bark.PlayBark(Guard)}
    # Play a bark when reinforcement is called
    AwaitReinforcements<private>()<suspends>:void=
        AlertedGuard := StrongholdGameManager.ReinforcementsCalledEvent.Await()
        PlayBark(BarkNeedBackup, AlertedGuard)
    # Play a bark when guards regroup in the stronghold
    AwaitFallback<private>()<suspends>:void=
        StrongholdGameManager.FallbackEvent.Await()
        if:
            Guard := StrongholdGameManager.AlertedGuards[0]
        then:
            PlayBark(BarkFallback, Guard)
    PlayAwarenessBarks<private>()<suspends>:void=
        loop:
            race:
                PlayGuardsSuspiciousBark()
                PlayPlayerSpottedBark()
                PlayPlayerLostBark()
                PlayGuardsUnawareBark()
    PlayPlayerSpottedBark<private>()<suspends>:void=
        Guard:=StrongholdGameManager.PlayerDetectedEvent.Await();
        set HasLostTarget = false
        PlayBark(BarkPlayerSpotted, Guard)
    PlayPlayerLostBark<private>()<suspends>:void=
        Guard:=StrongholdGameManager.PlayerLostEvent.Await();
        set HasLostTarget = true
        PlayBark(BarkPlayerLost, Guard)
    PlayGuardsSuspiciousBark<private>()<suspends>:void=
        Guard:=StrongholdGameManager.GuardsSuspiciousEvent.Await();
        PlayBark(BarkGuardSuspicious, Guard)
    PlayGuardsUnawareBark<private>()<suspends>:void=
        Guard:=StrongholdGameManager.GuardsUnawareEvent.Await();
        if (HasLostTarget?):
            set HasLostTarget = false
            if (not StrongholdGameManager.FallbackTriggered?):
                PlayBark(BarkGuardUnaware, Guard)
    SubscribeToGuardSpawnerEvents(GuardSpawnerDevice:guard_spawner_device):void =
        GuardSpawnerDevice.DamagedEvent.Subscribe(OnGuardDamaged)
        GuardSpawnerDevice.EliminatedEvent.Subscribe(OnGuardEliminated)
        GuardSpawnerDevice.EliminatingEvent.Subscribe(OnPlayerEliminated)
     # Configure all barks
    ConfigureBarks():void=
        # Subscribe To Player Damage Event
        AllPlayers := GetPlayspace().GetPlayers()
        for (StrongholdPlayer : AllPlayers, StrongholdPC := StrongholdPlayer.GetFortCharacter[]):
            StrongholdPC.DamagedEvent().Subscribe(OnPlayerDamaged)
        # Run through guards spawner list from stronghold manager and subscribe to all key events
        for (GuardSpawner : StrongholdGameManager.GuardsInitialSpawners):
            SubscribeToGuardSpawnerEvents(GuardSpawner)
        for (GuardSpawner : StrongholdGameManager.GuardsReinforcementSpawners):
            SubscribeToGuardSpawnerEvents(GuardSpawner)
        # Have a separate case for when the reinforcements spawn
        if:
            FirstReinforcementSpawner := StrongholdGameManager.GuardsReinforcementSpawners[0]
        then:
            FirstReinforcementSpawner.SpawnedEvent.Subscribe(HandleReinforcementSpawned)
      # Guard is down, try to play a bark on the closest alerted guard
    OnGuardEliminated(InteractionResult:device_ai_interaction_result):void=
        if (EliminatedGuard := InteractionResult.Target?):
            # Find closest alive guard to play this bark
            var ClosestGuard:?agent = false
            if:
                set ClosestGuard = option{StrongholdGameManager.AlertedGuards[0]}
                EliminatedGuardCharacter := EliminatedGuard.GetFortCharacter[]
            then:
                for (AlertedGuard : StrongholdGameManager.AlertedGuards, AlertedGuardCharacter := AlertedGuard.GetFortCharacter[]):
                    if:
                        not ClosestGuard? = AlertedGuard
                        ClosestGuardCharacter := ClosestGuard?.GetFortCharacter[]
                        DistanceSquaredToAlertedGuard := DistanceSquared(AlertedGuardCharacter.GetTransform().Translation, EliminatedGuardCharacter.GetTransform().Translation)
                        DistanceSquaredToClosestGuard := DistanceSquared(ClosestGuardCharacter.GetTransform().Translation, EliminatedGuardCharacter.GetTransform().Translation)
                        DistanceSquaredToAlertedGuard < DistanceSquaredToClosestGuard
                    then:
                        set ClosestGuard = option{AlertedGuard}
            if (Guard := ClosestGuard?):
                spawn {BarkNPCDown.PlayBark(Guard)}
   # Guard is hit, try to play a bark if the guard is not down
    OnGuardDamaged(InteractionResult:device_ai_interaction_result):void=
        if (Guard := InteractionResult.Target?):
            spawn {BarkDamageTaken.PlayBark(Guard)}
    # Player is hit, try to play a bark on the guard that damaged the player
    OnPlayerDamaged(DamageResult:damage_result):void=
        if:
            fort_character[DamageResult.Target].GetHealth() > 0.0
            Guard := DamageResult.Instigator?.GetInstigatorAgent[]
        then:
            spawn {BarkDamagePlayer.PlayBark(Guard)}
    # Player is down, try to play a bark on the guard that eliminated the player
    OnPlayerEliminated(InteractionResult:device_ai_interaction_result):void=
        if (Guard := InteractionResult.Source?):
            spawn {BarkEliminatedPlayer.PlayBark(Guard)}
    HandleReinforcementSpawned(Guard:agent):void=
        spawn {BarkGoToLeash.PlayBark(Guard)}
```

This script stores a reference to each Audio Player device and references the **Stronghold Game Manager** Verse device as a conduit for its references to the Guard Spawners.

## Customizable Lights

[![Customizable Lights](https://dev.epicgames.com/community/api/documentation/image/42ef1e69-d979-4b78-a5db-641af5133d52?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42ef1e69-d979-4b78-a5db-641af5133d52?resizing_type=fit)

In addition to getting audio feedback from AI guards, you can also give players visual feedback from the environment.

This tutorial uses two sets of [**Customizable Light**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-customizable-light-devices-in-fortnite-creative) devices around the stronghold. A red light indicates a detected status while an orange light indicates an alerted status.

To set up these devices, customize the following settings:

| Option | Value | Explanation |
| --- | --- | --- |
| **Initial State** | False | Determines the light’s initial state when the device is enabled. |
| **Light Size** | 100.00 | Determines the size, range, and amplitude of the of the light flare. |
| **Cast Shadows** | True | Allows the light to cast shadows. |
| **Enabled During Phase** | Gameplay Only | Lights will only be enabled during the gameplay. |
| **Light Intensity** | 30.0 | Determines the intensity of the light. |
| **Rhythm Time** | x8 | Determines the time multiplier for the Rhythm Preset. |
| **Dimming Amount** | 100.0 | Determines the amount to dim the light when using the channel controls. |
| **Dimming Time** | 0.1 | Determines the dimming transition duration in seconds. |

## VFX Creator

[![vfxCreator](https://dev.epicgames.com/community/api/documentation/image/8fc8846c-87d9-46e1-acfd-6605c824c7b9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8fc8846c-87d9-46e1-acfd-6605c824c7b9?resizing_type=fit)

This tutorial also uses a [**VFX Creator**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-vfx-creator-devices-in-fortnite-creative) device at the top of the base to act as a signal flare for reinforcements when players are first detected. This flare is controlled by the Verse device and will go off along with the corner lights when guards are alerted to make their states visually clear.

To set up these devices, customize the following settings:

[![VFX Settings](https://dev.epicgames.com/community/api/documentation/image/ef1c4d68-8fee-4483-bd85-5d2fcd21c04f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ef1c4d68-8fee-4483-bd85-5d2fcd21c04f?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Start Effects When Enabled** | False | Determines whether the device will execute the effects when enabled. |
| **Sprite Size** | 2.0 | Sets the Effect Sprite initial size. |
| **Sprite Duration** | 5.0 | Sets how much time each sprite will appear. |
| **Main Color** | Red | Sets the main color for the effects. |
| **Main Color Brightness** | 200.0 | Sets the **Main Color** brightness. |
| **Sprite Speed** | 100.0 | Sets how fast the effects sprites start to move. |
| **Effect Gravity** | 15.0 | Sets how fast the effect sprites can fall. |
| **Randomness** | 100.0 | Determines how random the movement will be and adds variation to size. |
| **Keep Size** | False | Determines whether sprites keep its size or use a custom size that changes over time. |
| **Effect Generation Amount** | 4.0 | Sets how many effect sprites are generated. |
| **Spawn Zone Shape** | Point | Determines the space shape where the sprites initially appear. |
| **Spawn Zone Size** | 0.05 | Sets the size of the spawn shape in tiles. |
| **Enabled During Phase** | Gameplay Only | Determines the game phases during which the device will be enabled. |
| **Loop** | Never | Determines if the effect plays once, loops forever, or by a custom amount of times. |

## Radio Device

This tutorial uses two [**Radio**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-radio-devices-in-fortnite-creative) devices, one for high-alert combat music and the other for cautious music.

The tense player music uses: Radio > Music Loops > **Music\_StW\_Low\_Combat01\_Cue**'.

The player-spotted combat music uses the Radio > Music Loops > **Music\_StW\_High\_Combat01\_Cue**'.

Set up a Verse script that you can call Stronghold\_Alert\_Manager to listen when a guard has detected the player, or when all guards have lost track of the player to alternate between the two states in the stronghold.

Paste the following Verse script.

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Simulation/Tags }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Devices }
# tags for customizable lights
alerted_lights_tag := class(tag){}
combat_lights_tag := class(tag){}
# Script that handles music and turn on lights when guards are alerted
stronghold_alert_manager := class(creative_device):
    # Reference to the Game Manager to monitor perception events
    @editable
    StrongholdGameManager:stronghold_game_manager := stronghold_game_manager{}
    # Reference to Radio that plays combat music
    @editable
    RadioCombat:radio_device := radio_device{}
    # Reference to Radio that plays alerted music
    @editable
    RadioAlerted:radio_device := radio_device{}
    # VFX to play when alarm/flare is shot
    @editable
    FlareAlarmVFXCreator:vfx_creator_device := vfx_creator_device{}
  # Class Data
    var<private> CustomizableLightDevicesAlerted: []customizable_light_device = array{}
    var<private> CustomizableLightDevicesCombat: []customizable_light_device = array{}
  # Change the camp to alerted when player is lost / killed
    WaitForAlerted()<suspends>:void=
        # do not go back to alerted after fallback
        if (StrongholdGameManager.FallbackTriggered?):
            Sleep(Inf)
        StrongholdGameManager.GuardsUnawareEvent.Await()
        Sleep(3.0)
        SetAlertedMood()
    # Change the camp to combat when player is spotted
    WaitForCombat()<suspends>:void=
        race:
            StrongholdGameManager.PlayerDetectedEvent.Await()
            StrongholdGameManager.FallbackEvent.Await()
        Sleep(2.0)
        SetCombatMood()
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        FindLightsWithTag()
        MonitorStrongholdAlertStatus()
    # Main Loop checking if stronghold is in combat or alerted
    MonitorStrongholdAlertStatus()<suspends>:void=
        loop:
            WaitForCombat()
            WaitForAlerted()
     # Sets Base to Combat by toggling lights red and playing high intensity music
    SetCombatMood():void=
        # Loop through Combat Lights and turn them on
        for(LightsToTurnOn: CustomizableLightDevicesCombat):
            LightsToTurnOn.TurnOn()
        # Loop through Alert Lights and turn them off
        for(LightsToTurnOff: CustomizableLightDevicesAlerted):
            LightsToTurnOff.TurnOff()
        # Turn on combat audio and turn off alerted audio
        RadioCombat.Play()
        RadioAlerted.Stop()
        FlareAlarmVFXCreator.Toggle()
    # Sets Base to Alerted by toggling lights yellow and playing  tense music
    SetAlertedMood():void=
        for(LightsToTurnOn: CustomizableLightDevicesAlerted):
            LightsToTurnOn.TurnOn()
        for(LightsToTurnOff: CustomizableLightDevicesCombat):
            LightsToTurnOff.TurnOff()
        RadioCombat.Stop()
        RadioAlerted.Play()
    # Loops through creative devices for the lights with this specific Verse tag and saves them to a list
    FindLightsWithTag() : void=
        TaggedAlertedLightDevices := GetCreativeObjectsWithTag(alerted_lights_tag{})
        TaggedCombatLightDevices := GetCreativeObjectsWithTag(combat_lights_tag{})
        for(AlertedLight : TaggedAlertedLightDevices, CustomizableLight := customizable_light_device[AlertedLight] ):
            CustomizableLight.TurnOff()
            set CustomizableLightDevicesAlerted += array{CustomizableLight}
        for(CombatLight : TaggedCombatLightDevices, CustomizableLight := customizable_light_device[CombatLight] ):
            CustomizableLight.TurnOff()
            set CustomizableLightDevicesCombat += array{CustomizableLight}
```

You have now successfully created a stronghold game.
