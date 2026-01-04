# Quadcrasher Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-quadcrasher-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:40:04.368980

---

A **Quadcrasher Spawner** is a device that [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) a Quadcrasher vehicle onto your island at the spawner's given location and orientation.

You can place a player directly inside the Quadcrasher using a trigger.

For help on how to find the **Quadcrasher Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite-creative/rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite-creative/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use italic for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like whether it is visible in game, or whether it supports [wraps](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#wrap). Additionally, there are some advanced options, like which [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) and team can use the vehicle, and whether enabling or disabling the device spawns or despawns the vehicle.

You can configure this device with the following options.

Default values are **bold**.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. This does affect its [collision](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) properties. |
| **Supports Wraps** | **Enabled**, Disabled | Determines whether the vehicle supports wraps. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **All**, None, Pre-Game Only, Gameplay Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) during which the device will be enabled. Pre-Game includes all phases prior to the Game starting (the waiting for players lobby on Featured Islands and the Game Start Countdown). |
| **Respawn Time** | **Instant**, Never, Pick a time | Respawns a vehicle that's been destroyed after a selected delay. |
| **Respawn Vehicle when Enabled** | **Yes**, No, Only if Needed | If this is set to **Yes**, a vehicle will spawn when the device is enabled. Choosing **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle when Disabled** | **Yes**, No | Destroys a spawned vehicle when the spawner is disabled. |
| **Owning Team** | **Any**, Pick a team | Sets the team the device belongs to. |
| **Selected Class** | **None**, Any, No Class, Pick a class | Determines what class can use this vehicle.  Values for this option are:   - **None**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with a class assigned can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick a class**: Pick a [class identifier](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class-identifier); only players assigned that class can use the vehicle. |
| **Vehicle Health** | **150**, Indestructible, Pick a number | Determines how much damage the vehicle can take before it is destroyed. |
| **Fuel Consumption** | **Has Infinite Fuel**, *Uses Fuel* | Determines if the spawned vehicle uses fuel. |
| **Starting Fuel** | **Random**, Pick a percentage | Only displayed when **Fuel Consumption** is set to **Uses Fuel**. The percentage of fuel in the vehicle's fuel tank at spawn. **Random** will spawn the vehicle with a percentage of fuel between 25% and 80%. |
| **Fuel Use** | Slow, **Normal**, Fast | Only displayed when **Fuel Consumption** is set to **Uses Fuel**. Controls how quickly the vehicle will use fuel while driving. |
| **Water Destruction Delay** | Never, Instant, **5 seconds**, Pick a time | When the vehicle is too deep in water to drive, destroy it after this delay. |

## Channels

When one device needs to "talk" to another device, it does so by [transmitting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a [signal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) on a specific [channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). The receiving device needs to be set up to [receive](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#receive) the signal on the same channel.

A channel is identified by a number, and channel numbers are customized for a device under the option that uses the channel. Most devices will also pass the identity of the player who [triggered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the device with the signal.

When the Quadcrasher Spawner device receives a signal on a channel, it can be enabled or disabled, can spawn or destroy a vehicle, and assign a driver. It can transmit a signal on a channel when a player enters or exits the vehicle, and when the vehicle is spawned or destroyed.

### Receivers

Receivers listen for a channel and perform an action when they hear any device (including themselves) send a signal on that channel.

| Option | Value | Description |
| --- | --- | --- |
| **Assigns Driver When Receiving From** | **No Channel**, Pick a channel | Sets the player that [instigated](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#instigator) the signal as the spawned vehicle's driver |
| **Respawn Vehicle When Receiving From** | **No Channel**, Pick a channel | Spawns a new vehicle after receiving a signal on the selected [channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). The existing vehicle will be destroyed before a new vehicle spawns. |
| **Destroy Vehicle When Receiving From** | **No Channel**, Pick a channel | When receiving a signal on the selected channel, the spawned vehicle is destroyed if it exists. |
| **Enable When Receiving From** | **No Channel**, Pick a channel | When a signal is received on the selected channel, the Quadcrasher spawner is enabled. |
| **Disable When Receiving From** | **No Channel**, Pick a channel | When a signal is received on the selected channel, the Quadcrasher spawner is disabled. |

### Transmitters

Transmitters send a signal on the selected channel when triggered.

| Option | Value | Description |
| --- | --- | --- |
| **When Player Enters Vehicle Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a player enters the spawned vehicle. |
| **When Player Exits Vehicle Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a player exits the spawned vehicle. |
| **When Vehicle Spawns Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a vehicle is spawned or respawned. |
| **When Vehicle is Destroyed Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a vehicle is destroyed. |
