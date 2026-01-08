# Stat Powerup Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-powerup-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:37:00.876635

---

Place **Stat Powerup** devices within your game to grant and adjust in-game statistics (stats). You can either use custom statistics created in the [Stat Creator](using-stat-creator-devices-in-fortnite-creative) device or pre-made stats such as:

- **Score**
- **Collect Items**
- **Objectives**
- **AI Eliminations**
- **Eliminations**
- **Elimination Assists**
- **Eliminated**
- **Damage Dealt**
- **Damage Taken**
- **Spawns Left**
- **Lap Time**

These powerups can either be manually picked up by players or activated through device triggers.

You can pair this device with the [**Stat Creator**](using-stat-creator-devices-in-fortnite-creative) and [Timed Objective](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative) to create a game where players compete to place the most bombs that are tracked through a custom stat such as "Bombs Planted".

For help on how to find the Stat Powerup device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like adjusting the value of stats applied and their duration.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

## Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Stat To Apply** | **Score**, Select a stat | Determines which stat this powerup adds or removes value from. |
| **Magnitude** | **1**, Pick or enter a value | Determines how much of the stat’s value will be added or removed. |
| **Infinite Effect Duration** | Yes, ***No*** | Determines if the effect will stay active infinitely or not. If set to **No**, an additional option to set a custom amount of time will appear. |
| **Effect Duration** | **3 Seconds**, Pick or enter a duration | Determines the amount of time the applied effect will stay active. |
| **Respawn** | ***Yes***, No | Determines if the powerup will respawn after being picked up. |
| **Time To Respawn** | **15 Seconds**, Pick or enter an amount | Sets the amount of time this powerup will respawn after pick up. |
| **Ambient Audio** | **On**, Off | Determines whether the powerup will play ambient audio when players are nearby. |

## All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Disables Effect On Pickup** | Yes, **No** | If set to **Yes**, the powerup effect will be canceled when collected. |
| **Pickup Radius** | **On Touch**, Pick or enter a radius | Sets the distance in meters the player needs to be from the powerup to collect it. |
| **Spawn on Minigame Start** | **Yes**, No | Determines if the powerup is spawned when the minigame starts. |
| **Pick Up Audio** | **On**, Off | Determines if audio is played when the powerup is collected. |
| **Selected Class** | **Any**, Pick or enter a class number | Specifies which class can interact with this powerup. |
| **Selected Team** | **Any**, Pick or enter a team number | Specifies which team can interact with this powerup. |
| **Apply To** | **Player**, Player's Team, Player's Class, Same Class In Player's Team, All Players | Determines which players can see the powerup. |
| **Who Can See This Powerup** | None, All, Only Players That Can Pick Up | Determines who can see the powerup when activated. |
| **Persist on Elimination** | On, **Off** | Determines if the powerup will continue to apply when the player has been eliminated and on their next spawn. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device and then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the device's function.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Spawn When Receiving From** | Immediately spawns the powerup when the event occurs. |
| **Despawn When Receiving From** | Immediately despawns the powerup when the event occurs. The powerup will not spawn again until triggered. |
| **Pickup When Receiving From** | Collects the powerup when the event occurs, allowing the effect to apply through other devices. |
| **Clear When Receiving From** | Clears the powerup's active effect when the event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to that device's function.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Item Picked Up Send Event To** | Sends an event to linked devices when the powerup is picked up. |
