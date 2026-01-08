# Shopping Cart Spawner Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/usingshoppingcartspawnerdevicesinfortnitecreative>
> **爬取时间**: 2025-12-26T23:41:50.025228

---

The **Shopping Cart Spawner** is a type of [vehicle spawner](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#vehicle-spawner) that can [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) one vehicle per device. Use the shopping carts for navigation challenges, cart racing, or any kind of vehicle-related gameplay.

For help on how to find the **Shopping Cart Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

This device has some basic functionality, like whether the device is visible during the game. Additionally, there are some advanced options, like what happens when the device is enabled or disabled, and how long a spawned vehicle can be in deep water before it is destroyed.

You can configure this device with the following options.

Default values are **bold**.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Visible During Game** | **On**, Off | Determines whether the Shopping Cart Spawner device is visible during the game. If it is visible, it has collision properties. If it is not visible, it does not have collision properties. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **All**, None, Pre-Game Only, Gameplay Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) during which the device will be enabled. Pre-Game includes all phases prior to the Game starting (the waiting for players lobby on Featured Islands and the Game Start Countdown). |
| **Respawn Time** | Never, **Instant**, Pick a time | When a vehicle spawned by this device is destroyed, this determines the length of time before the vehicle [respawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#respawn). |
| **Respawn Vehicle When Enabled** | No, Only If Needed, **Yes** | When the device is enabled, this determines whether it will immediately spawn a vehicle. If you choose **Only If Needed** the device spawns a vehicle if there is no existing vehicle, but will not reset an existing vehicle. |
| **Destroy When Disabled** | **Yes**, No | When the device is disabled, this determines whether an existing spawned vehicle is destroyed. |
| **Owning Team** | **Any**, Pick a team | Determines which team this device belongs to. |
| **Selected Class** | **None**, Any, No Class, Pick a class | The selected [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) is used to determine **Affects Class** effects. If you choose **None**, all players are affected. If you choose **Any**, all players with an assigned class are affected. If you choose **No Class**, only players without an assigned class are affected. |
| **Vehicle Health** | **150**, Indestructible, Pick an amount | Determines how much damage the vehicle can take before it is destroyed. |
| **Water Destruction Delay** | Never, Instant, **5 seconds**, Pick a time | When the vehicle is in water too deep to drive through, this determines how much time passes before the vehicle is destroyed. |

## Channels

When one device needs to "talk" to another device, it does so by [transmitting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a [signal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) on a specific [channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). The receiving device needs to be set up to [receive](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#receive) the signal on the same channel.

A channel is identified by a number, and channel numbers are customized for a device under the option that uses the channel. Most devices will also pass the identity of the player who [triggered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the device with the signal.

This device has receivers that perform a variety of functions when receiving a signal over a channel. Also, this device can transmit signals when certain conditions are met.

### Receivers

Receivers listen for a channel and perform an action when they hear any device (including themselves) send a signal on that channel.

| Option | Value | Description |
| --- | --- | --- |
| **Assigns Driver When Receiving From** | **No Channel**, Pick a channel | When the device receives a signal on the selected channel, the instigating player is seated as the driver of the spawned vehicle. |
| **Respawn Vehicle When Receiving From** | **No Channel**, Pick a channel | When the device receives a signal on the selected channel, it respawns the vehicle. |
| **Destroy Vehicle When Receiving From** | **No Channel**, Pick a channel | When the device receives a signal on the selected channel, it destroys the spawned vehicle. |
| **Enable When Receiving From** | **No Channel**, Pick a channel | The device is enabled when it receives a signal on the selected channel. |
| **Disable When Receiving From** | **No Channel**, Pick a channel | The device is disabled when it receives a signal on the selected channel. |

### Transmitters

Transmitters send a signal on the selected channel when triggered.

| Option | Value | Description |
| --- | --- | --- |
| **When Player Enters Vehicle Transmit On** | **No Channel**, Pick a channel | The device transmits a signal on the selected channel when a player enters a vehicle spawned by this device. |
| **When Player Exits Vehicle Transmit On** | **No Channel**, Pick a channel | The device transmits a signal on the selected channel when a player exits a vehicle spawned by this device. |
| **When Vehicle Spawns Transmit On** | **No Channel**, Pick a channel | The device transmits a signal on the selected channel when a vehicle is spawned by this device. |
| **When Vehicle Is Destroyed Transmit On** | **No Channel**, Pick a channel | The device transmits a signal on the selected channel when a spawned vehicle is destroyed. |
