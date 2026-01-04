# 10. Customize the Gameplay

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-10-customizing-the-gameplay-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:22:55.966229

---

This section will show you how to add devices that will customize the game and device settings as well as add in-game audio. You will then test your gameplay and iterate on improvements.

**Devices used:**

- 1 x [Round Settings](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-round-settings-devices-in-fortnite-creative)
- 1 x [Prop-O-Matic-Manager](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-prop-o-matic-manager-devices-in-fortnite-creative)
- 2 x [Radio Player](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-radio-devices-in-fortnite-creative)

## Round Settings Device

[![Round Settings](https://dev.epicgames.com/community/api/documentation/image/eaeb6915-8f9f-425b-8a6a-253e54e3ddb7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eaeb6915-8f9f-425b-8a6a-253e54e3ddb7?resizing_type=fit)

Use this device to end the round when the last prop is eliminated. There are no modifications to this device. Further changes to this device are added in Verse.

## Prop-O-Matic Manager Device

[![Prop-O-Matic Manager Device](https://dev.epicgames.com/community/api/documentation/image/87799ae2-7fea-40bc-8686-5dbca914c568?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/87799ae2-7fea-40bc-8686-5dbca914c568?resizing_type=fit)

Use this device to customize the Prop-O-Matic weapon’s settings, which will be granted to prop players in Verse.

To set up this device, configure the **User Options** as shown in the table below.

[![Modified Prop-o-Matic](https://dev.epicgames.com/community/api/documentation/image/8f1b6fee-7238-4d68-bf5c-2a7dbf7f4876?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f1b6fee-7238-4d68-bf5c-2a7dbf7f4876?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Ping Hidden Props on Interval** | False | Determines if the device pings the position of players that are hidden. |
| **Should Show Props Remaining** | False | This device will not show which props are remaining in the gameplay. |
| **Prop Health Behavior** | Don’t Override | These settings are altered in the Team Settings and Inventory device. |
| **Show Prop Ping Cooldown** | False | Determines whether the prop ping countdown should be displayed or not. |

## Radio Player Device

[![Radio Player](https://dev.epicgames.com/community/api/documentation/image/8dfba07f-53f6-476c-8b78-46da6f20d2a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8dfba07f-53f6-476c-8b78-46da6f20d2a9?resizing_type=fit)

Use the Radio Player device to add relevant sounds and thematic music to enhance your gameplay.

This tutorial uses two radio devices, one as a heartbeat sound effect registered to players of the prop team and another one that adds ambient background music.

The first radio player will aid hunters in locating players of the prop team who haven’t moved for a duration of time. Players of the prop team are unregistered from this device when they move.

To set up this device, configure the **User Options** as shown in the table below.

[![Heartbeat Audio](https://dev.epicgames.com/community/api/documentation/image/4d03d535-d6f0-413e-9ee4-7c2ccbfc25e5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d03d535-d6f0-413e-9ee4-7c2ccbfc25e5?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Audio** | HeartBeatLooping | Determines what audio is played when the device is activated. |
| **Volume** | 4.0 | Sets the volume for the selected audio. |
| **Play During Waiting for Players** | False | Determines whether the radio should be heard during the Waiting for Players phase. |
| **Play During Game Countdown** | False | Determines whether the radio should be heard during the Game Countdown phase. |
| **Play During Round End** | False | Determines whether the radio should be heard between rounds. |
| **Play During Game End** | False | Determines whether the radio should be heard during the post-game results phase. |
| **Audio Distance** | 50.0 | Sets the range at which the radio can be heard. |
| **Play at Location** | Device | Determines if the audio should be played from the device’s location or the instigator’s location. |
| **Update State when Players Registered** | True | Audio starts playing when at least one player is registered and automatically stops playing when the last player unregisters. |

The next audio device will provide ambient music for the game.

To set up this device, configure the **User Options** as shown in the table below.

[![Modified Radio Device](https://dev.epicgames.com/community/api/documentation/image/7d603306-35c7-4c7b-a57f-fb9f0146350e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d603306-35c7-4c7b-a57f-fb9f0146350e?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Audio** | Music\_HipHop\_Cue | Determines what audio is played when the device is activated. |
| **Volume** | 2.0 | Sets the volume for the selected audio. |
| **Play During Waiting for Players** | False | Determines whether the radio should be heard during the Waiting for Players phase. |
| **Play During Game Countdown** | False | Determines whether the radio should be heard during the Game Countdown phase. |
| **Play During Round End** | False | Determines whether the radio should be heard between rounds. |
| **Play During Game End** | False | Determines whether the radio should be heard during the post-game results phase. |
| **Limited Audio Distance** | False | Determines if the audio should be heard globally or if it should have a falloff distance. |
| **Visualization** | False | Determines whether this radio can affect objects from the visualization gallery. |
| **Play at Location** | Device | Determines if the audio should be played from the device’s location or the instigator’s location. |

You have now set up the key mechanics to recreate Prop Hunt.

Take your recreation even further by adding cinematics to your gameplay. The Prop Hunt template uses a cinematic as an opening scene. You can read our [Animation and Cinematics](https://dev.epicgames.com/documentation/en-us/fortnite/animation-and-cinematics-in-unreal-editor-for-fortnite) section to create your own unique cinematic.
