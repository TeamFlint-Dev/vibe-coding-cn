# Cannon Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-cannon-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:38:00.473922

---

The **Cannon Spawner** creates a cannon that players can use in interesting ways:

- They can aim and shoot the cannon against structures, buildings, [NPCs](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), or other players.
- They can move it around, although it is hard to steer.
- They can even use the cannon to launch themselves!

For help on how to find the **Cannon Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) during which the device will be enabled. Pre-Game includes all phases prior to the start of the game. |
| **Enable Respawn** | **On**, Off | Determines whether the vehicle will respawn after it is destroyed. |
| **Respawn Time** | **Instant**, Pick or enter an amount | This option only displays if the **Enable Respawn** option is set to **On**. Determines how much time it takes a vehicle to respawn after it is destroyed. |
| **Respawn Vehicle When Enabled** | **Yes**, Only If Needed, No | Determines whether the cannon respawns when the device is enabled. If you choose **Only If Needed**, an existing cannon will not respawn. |
| **Destroy Vehicle When Disabled** | **Yes**, No | If you choose **Yes**, any existing cannon will be destroyed when the device is disabled. |
| **Activating Team** | **Any**, Pick a number | Set the team this vehicle belongs to. |
| **Allowed Class** | No Class, **All**, Any, Pick a number between 1 and 16 | Determines what class can use this vehicle. Values for this option are:   - **All**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with an assigned class can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick a class**: Pick a numeric class identifier; only players assigned that class can use the vehicle. |
| **Visible During Game** | **On**, Off | Determines whether the cannon is visible during the game. If this is set to **Off**, it affects the [collision](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) properties of the device. |
| **Supports Wraps** | **Enabled**, Disabled | Determines whether players can use [wraps](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) on the cannon. |
| **Vehicle Indestructible** | ***Off***, On | Sets whether the vehicle can take any damage. |
| **Vehicle Health** | **150**, Pick or enter a number | This option only displays when **Vehicle Indestructible** is set to **Off**. Determines how much damage the vehicle can take before it is destroyed. |
| **Destroy When Stuck Underwater** | ***On***, Off | Determines if a vehicle will destroy itself when stuck underwater. If this is set to **On**, an additional option displays below this one. |
| **Water Destruction Timer** | Instant, **5 seconds**, Pick or enter a time | This option only displays if the **Destroy When Stuck Underwater** option is set to **On**. Determines how much time elapses before a vehicle stuck underwater destroys itself. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Respawn Vehicle When Receiving From** | Spawns the vehicle when an event occurs. This destroys the existing vehicle, if there is one. |
| **Destroy Vehicle When Receiving From** | If the vehicle that this spawner created still exists, it is destroyed when an event occurs. |
| **Assigns Driver When Receiving From** | When an event occurs, the instigating player is seated as the spawned vehicle's driver. |
| **Apply Off Road Tires When Receiving From** | This function applies off-road tires when an event occurs (if the vehicle can receive them). |
| **Remove Tire Modification When Receiving From** | This function removes tire modifications when an event occurs. |
| **Pop All Tires When Receiving From** | This function pops all tires on the vehicle when an event occurs. |
| **Repair All Tires When Receiving From** | This function repairs all tires on the vehicle when an event occurs. |
| **Repair Vehicle When Receiving From** | This function repairs the vehicle when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters the Vehicle Send Event To** | When a player enters the spawned vehicle, an event is sent to the selected device which triggers the selected function. |
| **On Player Exits the Vehicle Send Event To** | When a player exits the spawned vehicle, an event is sent to the selected device which triggers the selected function. |
| **On Vehicle Spawns Send Event To** | When a vehicle spawns or respawns, an event is sent to the selected device which triggers the selected function. |
| **On Vehicle Is Destroyed Send Event To** | When the spawned vehicle is destroyed, an event is sent to the selected device which triggers the selected function. |
