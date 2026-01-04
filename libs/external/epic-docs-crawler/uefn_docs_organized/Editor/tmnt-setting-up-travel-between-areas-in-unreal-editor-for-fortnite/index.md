# TMNT Travel Between Areas

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-setting-up-travel-between-areas-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:08:54.999768

---

Setting up mechanics that allow players to travel between areas maintains the game's flow and excitement. Whether it’s unlocking the next stage after defeating a boss or transitioning to a new environment, level travel keeps players engaged and immersed. This page covers the fundamental steps to setting up travel mechanics for your arcade game, ensuring smooth transitions while preserving the energy and pacing of the gameplay.

## Lobby to Game Start

**Devices used:**

- **1 x [Timer device](https://dev.epicgames.com/documentation/fortnite-creative/using-timer-devices-in-fortnite-creative)**
- **1 x [HUD Message device](https://dev.epicgames.com/documentation/fortnite-creative/using-hud-message-devices-in-fortnite-creative)**
- **1 x [Teleporter device](https://dev.epicgames.com/documentation/fortnite-creative/using-teleporter-devices-in-fortnite-creative)**
- **1 x [Trigger device](https://dev.epicgames.com/documentation/fortnite-creative/using-trigger-devices-in-fortnite-creative)**
- **1 x [Cinematic Sequence device](https://dev.epicgames.com/documentation/uefn/cinematic-sequence-device-in-unreal-editor-for-fortnite)**
- **1 x [Verse Multiplayer Handler device](https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-setting-up-travel-between-areas-in-unreal-editor-for-fortnite)**

The lobby **Timer** device is responsible for setting off multiple events:

1. To hide elements loading in and out, when the timer gets down to 1 second (Urgency Mode), it triggers a black screen Fade in UI Widget.

   [![UI Fade Widget](https://dev.epicgames.com/community/api/documentation/image/53113fe4-a1c2-4426-808e-053589633c4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/53113fe4-a1c2-4426-808e-053589633c4e?resizing_type=fit)

   Since this template has streaming enabled to save on memory costs, only the elements around a player will be loaded in. The player needs to be teleported to the sidescroller section first. Otherwise, the intro cinematic will display assets that are not fully loaded.
2. The first player is teleported into the start of the level, which activates a **Trigger**.
3. This trigger activates a **Verse Multiplayer Handler** device that brings all remaining players to the start of the level.
4. The intro cinematic starts, accompanied by background music from the **Radio** device.

## Verse Multiplayer Handler

This custom Verse device was made to facilitate multiplayer gameplay. The basic idea is to leave no player behind. When One player gets teleported to the start of the map, the rest of the players follow. Once a player begins an enemy encounter, all players are teleported to his location to assist, and to avoid being kept out of the arena by the barriers in place.

The device uses the Trigger device as the initial cue for teleporting the players. It designates the triggering player’s location as the coordinates for teleporting the remaining players, and applies an offset in the X axis.

The entire code block is available below for copy-pasting into your own experience:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Characters }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/Diagnostics }

# This device is used to handle teleporting players around the map to ensure all players are always in the action!
multiplayer_teleporter := class(creative_device):

    #The trigger device used to initiate teleporting players
    @editable
    TriggerDevice : trigger_device = trigger_device{}

    # The world axis in which the offset is applied to the teleporting character i.e. X: 0 Y:1 Z:0 will apply the offset in the Y axis
    @editable
    TeleportOffsetAxis : vector3 = vector3{X := 0.0, Y := 1.0, Z := 0.0}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends> : void=
        TriggerDevice.TriggeredEvent.Subscribe(TeleportPlayers)
    TeleportPlayers(TriggeringAgent : ?agent)<transacts> : void =

        # Check if the triggering player's agent is valid and then use it's FortCharacter to set TriggeringCharacter
        if (TriggeringCharacter := TriggeringAgent?.GetFortCharacter[]):
            var TeleportOffset : float = 0.0
            CurrentPlayers := GetPlayspace().GetPlayers()

            # Iterate through all of the players, checking to make sure they aren't the triggering player, then teleport them to the triggering player
            for (Player : CurrentPlayers, Player.GetFortCharacter[] <> TriggeringCharacter, CharacterToTeleport := Player.GetFortCharacter[]):
                set TeleportOffset += 100.0

                # Teleport PlayerToTeleport to TriggeringPlayer's position, if the teleport fails to find the required space, players will remain where they are
                if (CharacterToTeleport.TeleportTo[TriggeringCharacter.GetTransform().Translation + (TeleportOffsetAxis * TeleportOffset),
                TriggeringCharacter.GetTransform().Rotation]):
```

## Street Level to Sewer

**Devices used:**

- **1 x [TMNT Sewer device](https://dev.epicgames.com/documentation/fortnite-creative/using-hiding-prop-gallery-devices-in-fortnite-creative)**

This is a simple way to let players travel to the sewers at their own pace. Each player can freely walk up to the sewer grate and be teleported into the sewers with a cool tunnel animation.

## Back to Street Level

**Devices used:**

- **2 x [Trigger device](https://dev.epicgames.com/documentation/fortnite-creative/using-trigger-devices-in-fortnite-creative)**
- **1 x [Timer device](https://dev.epicgames.com/documentation/fortnite-creative/using-timer-devices-in-fortnite-creative)**
- **1 x Verse Multiplayer Teleporter**

At the exit of the sewer, a Leave sign and point light are used to indicate to the player that this is the end of the sewer section.

[![Sewer exit](https://dev.epicgames.com/community/api/documentation/image/29c400af-e793-4867-88d0-d379f604e813?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/29c400af-e793-4867-88d0-d379f604e813?resizing_type=fit)

In order to give time for the street level to load in, the Fade to Black UI widget used between the lobby and the game start is set off by the player stepping on the first **Trigger** device. This starts the one-second **Timer** device, at the end of which the players are teleported to the street level using the **Verse Multiplayer Teleporter**.
