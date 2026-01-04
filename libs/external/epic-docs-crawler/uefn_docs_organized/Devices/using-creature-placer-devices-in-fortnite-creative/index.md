# Creature Placer Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-placer-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:44:59.184305

---

The **Creature Placer** device does exactly what you'd expect it to do—it provides a way to set an exact location for where a creature will [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). You can also specify which type of creature will spawn, when it will spawn, and when it will despawn.

**Looking for more inspiration?** See **[D-Launcher Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/dlauncher-device-design-examples-in-fortnite-creative)** to kick off your imagination!

For help finding the **Creature Placer** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Device Options

In its [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) state, when you place a Creature Placer on your island, a fiend will spawn immediately at game start. When the fiend is eliminated, a new fiend will not spawn.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Creature Type** | **Fiend**, Pick a creature | Determines the type of creature that will spawn. |
| **Activation Range** | **7 tiles**, Pick or enter an amount | Determines how close a player has to be to this device for it to activate. |
| **Spawn Effects Visibility** | **On**, Off | Determines whether device-related effects are played while spawning. |
| **Enable on Game Phase** | Never, Game Countdown, **Game Start** | Determines which [game phase](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the device activates in. |
| **Despawn Type** | **Distance To Enemy**, Distance To Spawner, Do Not Despawn | Whether creatures should despawn when far away from the spawner, or when far away from any player. |
| **Despawn Range** | **9 tiles**, Pick a distance | Determines how far away (distance in tiles) creatures need to be to despawn, based on the Despawn Type. |
| **Spawn Only If Needed** | **On**, Off | Determines whether the spawner will wait for a previous spawned creature to be destroyed before spawning another one. |
| **Restore Player Shield on Elimination** | **On**, Off | Determines whether a player's shield is restored when that player eliminates a creature spawned by this device. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** **dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Eliminated Send Event To** | When a creature is eliminated, an event is sent to the selected device, which triggers the selected function. |
| **On Spawned Send Event To** | When a creature is spawned, an event is sent to the selected device, which triggers the selected function. |

## Gameplay Examples Using Creature Placer

- [5 Rounds Of Econ Lessons](https://dev.epicgames.com/documentation/en-us/fortnite/5-rounds-of-econ-lessons-gameplay-example-in-fortnite-creative)
- [Dungeon Crawler](https://dev.epicgames.com/documentation/en-us/fortnite/dungeon-crawler-gameplay-example-in-fortnite-creative)
- [End of Round Team Swapping](https://dev.epicgames.com/documentation/en-us/fortnite/end-of-round-team-swapping-in-fortnite-creative)
- [Spawner 123](https://dev.epicgames.com/documentation/en-us/fortnite/spawner-123-in-fortnite-creative)
- [Top Scorer In Class](https://dev.epicgames.com/documentation/en-us/fortnite/top-scorer-in-class-in-fortnite-creative)
