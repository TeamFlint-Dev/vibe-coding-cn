# Tank Spawner Device

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-tank-spawner-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:39:28.049468

---

The **Tank** is a heavy-weight vehicle with 2 turrets and room for up to 3 players. [Place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) a tank in a specific location and orientation to create the ultimate experience. This vehicle has unique features, such as:

- Infrared zoom on the main turret scope.
- Easily destroys buildings and vegetation.
- Damages smaller vehicles (boats, cars, etc.).
- Interacts with the Fuel Pump device for refueling.

For help on how to find the **Tank Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite-creative/rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Removing the Device

You can remove this device by aiming at the device with your phone and pressing **\*\*X**\*\*. Doing so will cause both the device and the foundation where it’s attached to be removed.

You can remove the device by destroying the foundation piece it is attached to.

## Device Options

This device has the basic function of being visible in-game or not. Additionally, there are some advanced options, like saving a player’s shield and health data.

You can configure this device with the following options.

Default values are **bold**.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. This does affect its collision properties. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **All**, None, Pre-Game Only, Gameplay Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) during which the device will be enabled. Pre-Game includes all phases prior to the Game starting (the waiting for players lobby on Featured Islands and the Game Start Countdown). |
| **Respawn Time** | **Instant**, Never, Pick a Time | Respawns a vehicle that's been destroyed after a selected delay (the first vehicle spawned does not use this delay). |
| **Respawn Vehicle When Enabled** | **Yes**, No, Only If Needed | If this is set to Yes, a vehicle will spawn when the device is enabled. “Only if needed” will not reset an existing vehicle. |
| **Destroy Vehicle When Disabled** | **Yes**, No | Destroys a spawned vehicle when the spawner is disabled. |
| **Owning Team** | **Any**, Pick a Team | Sets the team the device belongs to. |
| **Selected Class** | **None**, Any, No Class, Pick a Number | Determines what class can use this vehicle.  Values for this option are:   - **None**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with a class assigned can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick a class**: Pick a [class identifier](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class-identifier); only players assigned that class can use the vehicle. |
| **Vehicle Health** | **2500 (Default)**, Indestructible, Pick a Number | Determines how much damage the vehicle can take before it is destroyed. |
| **Fuel Consumption** | **Has Infinite Fuel**, *Uses Fuel* | Determines if the spawned vehicle uses fuel. |
| **Starting Fuel** | **Random**, Pick a percentage | Sets the percentage of fuel in the vehicle's fuel tank at spawn. "Random" will spawn the vehicle with a percentage of fuel between 25% and 80%. |
| **Fuel Use** | Slow, **Normal**, Fast | Controls how quickly the vehicle will use fuel while driving. |
| **Water Destruction Delay** | **5 Seconds**, Never, Instant, Pick a Time | When the vehicle becomes too deep in water to drive, destroy it after this delay. |

## Channels

When one device needs to "talk" to another device, it does so by [transmitting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a [signal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) on a specific [channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). The receiving device needs to be set up to [receive](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#receive) the signal on the same channel.

A channel is identified by a number, and channel numbers are customized for a device under the option that uses the channel. Most devices will also pass the identity of the player who [triggered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the device with the signal.

This device has receivers that perform a variety of functions when receiving a signal over a channel. Also, this device can transmit signals when certain conditions are met.

### Receivers

Receivers listen for a channel and perform an action when they hear any device (including themselves) send a signal on that channel.

| Option | Value | Description |
| --- | --- | --- |
| **Assigns Driver When Receiving From** | **No Channel**, Pick a Channel Number | Seats the player that instigated the message as the spawned vehicle’s driver. |
| **Respawn Vehicle When Receiving From** | **No Channel**, Pick a Channel Number | Spawns the vehicle (destroying the existing vehicle if it still exists). |
| **Destroy Vehicle When Receiving From** | **No Channel**, Pick a Channel Number | If the vehicle that this spawner created still exists, destroy it. |
| **Enable When Receiving From** | **No Channel**, Pick a Channel Number | Enable the vehicle spawner, allowing it to spawn vehicles. |
| **Disable When Receiving From** | **No Channel**, Pick a Channel Number | Disables the vehicle spawner, stopping it from spawning any more vehicles. |

### Transmitters

Transmitters send a signal on the selected channel when triggered.

| Option | Value | Description |
| --- | --- | --- |
| **When Player Enters Vehicle Transmit On** | **No Channel**, Pick a Channel Number | Transmit a signal when a player enters the spawned vehicle. |
| **When Player Exits the Vehicle Transmit On** | **No Channel**, Pick a Channel Number | Transmit a signal when a player exits the spawned vehicle. |
| **When Vehicle Spawns Transmit On** | **No Channel**, Pick a Channel Number | Transmits a signal when a vehicle is spawned or respawns. |
| **When Vehicle Is Destroyed Transmit On** | **No Channel**, Pick a Channel Number | Transmits a signal when a vehicle is destroyed. |
