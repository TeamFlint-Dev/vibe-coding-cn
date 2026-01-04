# Giftbox Device for Hiding and Teleportation

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-giftbox-device-for-hiding-and-teleportation-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:12:58.760602

---

Provide the opportunity for players to hide or teleport between areas using the **Squid Game** themed **Giftbox** device. The giftbox doesn't need to signal the end; it could be an escape.

[![Squid Game Giftbox Device in UEFN](https://dev.epicgames.com/community/api/documentation/image/186f16de-c181-4beb-86f9-f7585638b6e3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/186f16de-c181-4beb-86f9-f7585638b6e3?resizing_type=fit)

Giftbox Device

The [Social Deduction](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-social-deduction-template-in-unreal-editor-for-fortnite) template explores the use of the Giftbox device to create a game of hide and seek.

## Giftbox Device

The Giftbox device is a cosmetic version of the **Hiding Prop Gallery** device. This means the settings are the same, but this prop is designed to fit the aesthetic of the Squid Game brand and connect fans to iconic props seen in the show. For example, the giftbox can act as a refuge for players as they hide from passing guards.

To learn more about the settings, see [Using Hiding Prop Gallery Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-hiding-prop-gallery-devices-in-fortnite-creative).

The Giftbox device is available only in Squid Game islands for Creative and Unreal Editor for Fortnite (UEFN). In the template, you can find the device in the **Content Drawer**, from the **All > Squid Game > Devices** folder.

[![Squid Game Giftbox Device in UEFN](https://dev.epicgames.com/community/api/documentation/image/bd4d1942-f7db-4ae7-a019-7118aa577ff4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd4d1942-f7db-4ae7-a019-7118aa577ff4?resizing_type=fit)

Giftbox Device

## Gameplay Setup

The gameplay example takes on the concept of hide and seek. Hiders have a set time to choose a giftbox to hide in before the seekers are released.

The template includes two levels for different room setups. One uses only devices, and the other incorporates Verse. The level with **\_Verse** appended to the end of the level name includes the Verse example. To see how the two levels compare, see the [Verse Level](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-giftbox-device-for-hiding-and-teleportation-in-unreal-editor-for-fortnite#verse-level) section on this page.

[![Squid Game Giftbox Device Gameplay in UEFN](https://dev.epicgames.com/community/api/documentation/image/e47fc29e-c78f-4bcc-9e48-e8947d66ce9b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e47fc29e-c78f-4bcc-9e48-e8947d66ce9b?resizing_type=fit)

Giftbox Device Gameplay

### Device-Only Level

Devices Used:

- Giftbox x 6
- [Audio Player](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-fortnite-creative) x 6
- [Mutator Zone](https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative) x 6
- [Billboard](https://dev.epicgames.com/documentation/en-us/fortnite/using-billboard-devices-in-fortnite-creative) x 10
- [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) x 24
- [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) x 1
- [Elimination Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-elimination-manager-devices-in-fortnite-creative) x 1
- [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative) x 2
- [Class Selector](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-selector-devices-in-fortnite-creative) x 2
- [Team Settings and Inventory](https://dev.epicgames.com/documentation/en-us/fortnite/using-team-settings-and-inventory-devices-in-fortnite-creative) x 2
- [Barrier Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative) x 3
- [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)  x 1
- [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) x 1
- [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative) x 9
- [Player Checkpoint Pad](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative) x 1
- [Player Counter](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-counter-devices-in-fortnite-creative) x 1
- [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) x 7
- [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) x 5
- [Teleporter](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative) x 2

The game begins when players choose their role as a seeker or hider. There must be at least one player for each role for the game to begin.

The trigger sets the following in motion:

- Hiders are spawned into the starting room through the **Class Selector** device.
- Seekers are spawned into the seeker room on **Player Spawners** through the **Class Selector** device. A weapon is added to the inventory through the **Item Granter** device.
- For either role, two **Button** devices are present with the option to start the game or return to the start.
- A conditional is set to disable the start button if there isn't at least 1 seeker and 1 hider.
- The **Timer** devices begin when the start button is activated. Hiders have a set time to find a spot, and they win by not getting caught during the seeker's time limit.

[![Squid Game Hide and Seek Arena in UEFN](https://dev.epicgames.com/community/api/documentation/image/d9abf9c8-16ba-4759-96de-a09572a7dec6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d9abf9c8-16ba-4759-96de-a09572a7dec6?resizing_type=fit)

Hide and Seek Arena

The **Class Selector**, **Class Designer**, and **Team Settings and Inventory** devices are used together to define the two teams.

Each Giftbox device has the following devices attached: **Audio Player**, **Button**, and **Mutator Zone**. Multiple players can hide in a giftbox. This game uses a max of 3 players per giftbox.

[![Squid Game Giftbox Device Settings in UEFN](https://dev.epicgames.com/community/api/documentation/image/ed6d05f1-540c-4311-a3dd-c1baf8e0ff2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ed6d05f1-540c-4311-a3dd-c1baf8e0ff2e?resizing_type=fit)

Giftbox Device Settings

### Verse Level

The Verse level for the room has the same gameplay but slightly different setup to control the interaction with the giftboxes. The device setup removes some **Button** devices and adds the custom `coffin_controller` Verse device for each giftbox.

[![](https://dev.epicgames.com/community/api/documentation/image/78a8075a-b94d-4402-9031-1f0b531dbeff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/78a8075a-b94d-4402-9031-1f0b531dbeff?resizing_type=fit)

Coffin\_Controller User Options

In the device-only level, each Giftbox device needs two separate buttons to handle the seeker's interaction.

- One button activates if someone hides inside the giftbox.
- The second button activates when the giftbox is empty.
- If the giftbox is empty, then the seeker is penalized by the **Mutator Zone** device, which freezes them for a short period.
- If the giftbox is occupied, then the seeker ejects everyone hidden in the coffin.

 This flow required the manual setup of several bindings, which could be prone to errors. Using the Verse API of the **Hiding Prop Gallery** device reduces the number of devices and event bindings needed for each hiding prop.

- Uses one **Button** device per giftbox instead of two.
- Event binding is handled with Verse.
- Success and failure conditions are tracked in Verse.
- Requires less manual setup; you only have to assign devices.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/Diagnostics }

CoffinCategory<public><localizes>:message := "Coffin settings"
GameplayCategory<public><localizes>:message := "Gameplay"
FailureCategory<public><localizes>:message := "Failure"

CoffinTooltip<public><localizes>:message := "Reference to coffin device managed by this device."
RandomTravelTargetTooltip<public><localizes>:message := "If enabled, coffin will transport the player to another random coffin."
InspectButtonTooltip<public><localizes>:message := "Button placed nearby the coffin. Can be used by seeker to check if someone is hiding inside."
ResetTooltip<public><localizes>:message := "Trigger that resets experience."
CueTooltip<public><localizes>:message := "Audio player that will be played when seeker inspects empty coffin."
MessageTooltip<public><localizes>:message := "Message that will be displayed when seeker inspects empty coffin."
FreezeTooltip<public><localizes>:message := "Mutator zone that will freeze seeker when they inspect empty coffin."
FreezeTimeTooltip<public><localizes>:message := "For how long seeker will be frozen."

coffin_controller := class(creative_device):

    @editable:
        Categories := array{CoffinCategory}
        ToolTip := CoffinTooltip
    Coffin : hiding_prop_device = hiding_prop_device{}

    @editable:
        Categories := array{CoffinCategory}
        ToolTip := RandomTravelTargetTooltip
    ShouldRandomizeTravelTarget : logic = false

    @editable:
        Categories := array{GameplayCategory}
        ToolTip := InspectButtonTooltip
    Inspect : button_device = button_device{}

    @editable:
        Categories := array{GameplayCategory}
        ToolTip := ResetTooltip
    Reset : trigger_device = trigger_device{}

    @editable:
        Categories := array{FailureCategory}
        ToolTip := MessageTooltip
    Message : hud_message_device = hud_message_device{}

    @editable:
        Categories := array{FailureCategory}
        ToolTip := CueTooltip
    Cue : audio_player_device = audio_player_device{}

    @editable:
        Categories := array{FailureCategory}
        ToolTip := FreezeTooltip
    FreezeZone : mutator_zone_device = mutator_zone_device{}

    @editable_slider(float):
        Categories := array{FailureCategory}
        ToolTip := FreezeTimeTooltip
        MinValue := option{0.0}
        MaxValue := option{60.0}
        SliderDelta := option{1.0}
    FreezeTime : float = 5.0

    var NumberOfPlayers : int = 0

    OnBegin<override>()<suspends>:void=
        Coffin.BeginPlayerHideEvent.Subscribe(OnPlayerEnter)
        Coffin.EndPlayerHideEvent.Subscribe(OnPlayerExit)
        Inspect.InteractedWithEvent.Subscribe(OnInspect)
        Reset.TriggeredEvent.Subscribe(OnReset)

        # Toggle mutator zone - looks like it needs "warm up" for the first time
        FreezeZone.Enable()
        FreezeZone.Disable()

        if (ShouldRandomizeTravelTarget?):
            RandomizeTravelTarget()

    OnPlayerEnter(Player : player):void=
        set NumberOfPlayers += 1

    OnPlayerExit(Player : player):void=
        set NumberOfPlayers -= 1

    OnReset(Agent : ?agent):void=
        set NumberOfPlayers = 0
        Coffin.EjectAllHiddenPlayers()
        FreezeZone.Disable()

    OnInspect(Agent : agent):void=
        if (IsCoffinOccupied[]):
            Coffin.EjectAllHiddenPlayers()
        else:
            Cue.Play(Agent)
            Message.Show(Agent)
            spawn{FreezeSeeker()}

    FreezeSeeker()<suspends>:void=
        FreezeZone.Enable()
        Sleep(FreezeTime)
        FreezeZone.Disable()

    IsCoffinOccupied()<transacts><decides>:void=
        NumberOfPlayers > 0

    RandomizeTravelTarget():void=
        if (not Coffin.HiddenTravelGroup?):
            set Coffin.HiddenTravelGroup = option{GetRandomInt(0, 5)}

        loop:
            TravelTargetGroup := GetRandomInt(0, 5)
            if (TravelTargetGroup <> Coffin.HiddenTravelGroup?):
                set Coffin.HiddenTravelTargetGroup = option{TravelTargetGroup}
                break
```

## Design Tips

Below are additional design considerations:

- Traveling between different areas on the map could be useful for performance.
- Create secret portals to another location for player engagement.
- Pull from themes of the Squid Game show and use the device as an escape route off an island.
- Use the device to force players into a giftbox when they fail a minigame and transport them somewhere else. You can use the Verse [hiding\_prop\_device](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hiding_prop_device) class to create this interaction.
- Adjust the max number of players who can hide in a single giftbox, or limit the total number of giftboxes available to heighten the stakes. Incorporate the [Shove item](https://dev.epicgames.com/documentation/en-us/fortnite/shove-gameplay-item-in-fortnite) to give players an advantage.

## Next

Learn to add a custom Squid Game UI to your island.

[![Squid Game Custom UI](https://dev.epicgames.com/community/api/documentation/image/18de718c-5135-4d4c-bf8a-cea12201f813?resizing_type=fit&width=640&height=640)

Squid Game Custom UI

Lean to add the Squid Game custom UI to your island.](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-custom-ui-in-unreal-editor-for-fortnite)
