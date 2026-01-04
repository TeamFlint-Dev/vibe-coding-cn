# Surfboard Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-surfboard-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:34:27.882590

---

A **Surfboard Spawner** is a device that [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) a Surfboard vehicle into the level at the spawner's given location and orientation. Use Surfboard Spawner devices in combination with the [Racing Checkpoint Device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#race-checkpoint) to design a racing game for your players. You can place a player directly inside the Surfboard using a trigger.

To access the **E** key to open the CUSTOMIZE panel, you have to point your phone to the tip of the board. If you point it in the center, you'll only get the option to **RIDE** the board.

For help on how to find the **Surfboard Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

This device has some basic functionality, like whether it is visible in game, or whether it supports [wraps](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#wrap). Additionally, there are some advanced options, like which [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) and team can use the vehicle, and whether enabling or disabling the device spawns or despawns the vehicle.

You can configure this device with the following options.

Default values are **bold**.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. This does affect its collision properties. |
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
| **Vehicle Health** | **800**, Indestructible, Pick a number | Determines how much damage the vehicle can take before it is destroyed. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/function) listens for an event on a device, and then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Respawn Vehicle When Receiving From** | Spawns a new vehicle when an event occurs. The existing vehicle will be destroyed before a new vehicle spawns. |
| **Destroy Vehicle When Receiving From** | When an event occurs, the spawned vehicle is destroyed if it exists. |
| **Assigns Driver When Receiving From** | Sets the player that [instigated](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#instigator) the signal as the spawned vehicle's rider |
| **Repair Vehicle When Receiving From** | When an event occurs, the spawned vehicle is restored to full health. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite-creative/event) tells another device when to perform a function.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters Vehicle Send Event To** | When a player enters the vehicle, an event is sent to the selected device. |
| **On Player Exits Vehicle**Send Event To | When a player exits the vehicle, an event is sent to the selected device. |
| On **Vehicle Spawns****Send Event To** | When a vehicle spawns, an event is sent to the selected device. |
| **On****Vehicle is Destroyed**Send Event To | When a vehicle is destroyed, an event is sent to the selected device. |
