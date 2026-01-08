# Sedan Spawner Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-sedan-spawner-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:31:36.364157

---

The **Sedan Spawner** is a device that [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) a sedan vehicle your island at the spawner's given location and orientation.

- Use Sedan Spawner devices in combination with the [Race Checkpoint Device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#race-checkpoint) to design a racing game for your players.
- You can place a player directly inside the sedan using a trigger.

For help on how to find the **Sedan Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like boost [regen](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#regen) and whether the radio is [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#enable). Additionally, there are some advanced options, like whether the sedan vehicle takes damage from [collisions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), how much damage it can take before being destroyed, and how much damage it deals when it explodes.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. This does affect its collision properties. |
| **Boost Regen** | **No Boost**, Slow, Default, Fast, Unlimited | Only displayed when **Fuel Consumption** is set to **Has Infinite Fuel**. Determines if the vehicle is able to boost, and how quickly the [boost](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#boost) meter fills. |
| **Radio** | **Enabled**, Disabled | Determines whether the spawned vehicle is able to use the [radio](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#radio). |
| **Color and Style** | **Random**, Pick a color | Choose a color option or leave it random. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **All**, None, Pre-Game Only, Gameplay Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) during which the device will be enabled. Pre-Game includes all phases prior to the Game starting (the waiting for players lobby on Featured Islands and the Game Start Countdown). |
| **Respawn Time** | **Instant**, Never, Pick a time | Respawns a vehicle that's been destroyed after a selected delay. |
| **Respawn Vehicle when Enabled** | **Yes**, No, Only if Needed | If this is set to **Yes**, a vehicle will spawn when the device is enabled. Choosing **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle when Disabled** | **Yes**, No | Destroys a spawned vehicle when the spawner is disabled. |
| **Owning Team** | **Any**, Pick a team | Sets the team the device belongs to. |
| **Selected Class** | **None**, Any, No Class, Pick a class | Determines what class can use this vehicle.  Values for this option are:   - **None**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with a class assigned can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick a class**: Pick a class identifier; only players assigned that class can use the vehicle. |
| **Fuel Consumption** | **Has Infinite Fuel**, *Uses Fuel* | Determines if the spawned vehicle uses fuel. |
| **Starting Fuel** | **Random**, Pick a percentage | Only displayed when **Fuel Consumption** is set to **Uses Fuel**. The percentage of fuel in the vehicle's fuel tank at spawn. **Random** will spawn the vehicle with a percentage of fuel between 25% and 80%. |
| **Fuel Use** | Slow, **Normal**, Fast | Only displayed when **Fuel Consumption** is set to **Uses Fuel**. Controls how quickly the vehicle will use fuel while driving. |
| **Boost Fuel Use** | **No Boost**, Slow, Default, Fast, None | Only displayed when **Fuel Consumption** is set to **Uses Fuel**. Controls how quickly the vehicle will use fuel while boosting. **No Boost** will disable boosting. **None** will make boosting have no effect on fuel usage. |
| **Tire Selection** | **Road Tires**, Off-Road Tires | Determines the type of tires for the spawned vehicle. |
| **Spawn With Cow Catcher** | Yes, **No** | Determines whether the vehicle has the Cow Catcher equipped when spawned. |
| **Vehicle Health** | **800**, Indestructible, Pick a number | Determines how much damage the vehicle can take before it is destroyed. |
| **Damage Friendly Fire** | **Yes**, No | Determines whether friendly driven vehicles will damage each other on collision. |
| **Damage Other Vehicles** | Yes, **No** | Determines whether vehicles will damage each other on collision. |
| **Allow Damage From Other Vehicles** | Yes, **No** | **Yes** will allow other vehicles to damage this vehicle by colliding with it. |
| **Damage Own Vehicle** | Yes, **No** | Determines whether a collision will damage the player’s own vehicle. |
| **Max Explosion Delay** | **1 second**, Instant, Pick a delay time | The maximum time the vehicle can have zero health, after which it will explode. |
| **Lifetime After Explosion** | **1 second**, Instant, Pick a duration | The duration in seconds that the destroyed vehicle will remain in the world, after which it is removed entirely. |
| **Explosion Damage to Environment** | **800**, None, Pick an amount of damage | The amount of damage dealt to environment objects when the vehicle explodes. |
| **Explosion Damage to Players** | **800**, None, Pick an amount of damage | The amount of damage dealt to players when the vehicle explodes. |
| **Explosion Damage to Vehicles** | **800**, None, Pick an amount of damage | The amount of damage dealt to other vehicles when the vehicle explodes. |
| **Water Destruction Delay** | Never, Instant, **5 seconds**, Pick a time | When the vehicle is too deep in water to drive, destroy it after this delay. |

## Channels

When one device needs to "talk" to another device, it does so by [transmitting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a [signal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) on a specific [channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). The receiving device needs to be set up to [receive](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#receive) the signal on the same channel.

A channel is identified by a number, and channel numbers are customized for a device under the option that uses the channel. Most devices will also pass the identity of the player who [triggered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the device with the signal.

When the Sedan Spawner device receives a signal on a channel, it can be enabled or disabled, can spawn or destroy a vehicle, and assign a driver. It can transmit a signal on a channel when a player enters or exits the vehicle, and when the vehicle is spawned or destroyed.

### Receivers

Receivers listen for a channel and perform an action when they hear any device (including themselves) send a signal on that channel.

| Option | Value | Description |
| --- | --- | --- |
| **Assigns Driver When Receiving From** | **No Channel**, Pick a channel | Sets the player that [instigated](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#instigator) the signal as the spawned vehicle's driver |
| **Respawn Vehicle When Receiving From** | **No Channel**, Pick a channel | Spawns a new vehicle after receiving a signal on the selected [channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). The existing vehicle will be destroyed before a new vehicle spawns. |
| **Destroy Vehicle When Receiving From** | **No Channel**, Pick a channel | When receiving a signal on the selected channel, the spawned vehicle is destroyed if it exists. |
| **Enable When Receiving From** | **No Channel**, Pick a channel | When a signal is received on the selected channel, the Sedan Spawner is enabled. |
| **Disable When Receiving From** | **No Channel**, Pick a channel | When a signal is received on the selected channel, the Sedan Spawner is disabled. |

### Transmitters

Transmitters send a signal on the selected channel when triggered.

| Option | Value | Description |
| --- | --- | --- |
| **When Player Enters Vehicle Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a player enters the spawned vehicle. |
| **When Player Exits Vehicle Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a player exits the spawned vehicle. |
| **When Vehicle Spawns Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a vehicle is spawned or respawned. |
| **When Vehicle is Destroyed Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a vehicle is destroyed. |
