# ATK Spawner Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-atk-spawner-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:42:09.476708

---

An **ATK Spawner** is a device that [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) an [ATK](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) golf cart into the level at the spawner's given location and orientation.

You can place a player directly inside the ATK using a trigger, or using functions and events.

  To find the **ATK Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

You can [customize device names](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) when using multiple copies of the same device.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) during which the device will be enabled. **Pre-Game Only** includes all phases prior to the start of the game. |
| **Enable Respawn** | **On**, Off | Determines if the vehicle will respawn after it is destroyed. |
| **Respawn Time** | **Instant**, Pick or enter a time | Respawns a vehicle that's been destroyed after a selected delay. |
| **Respawn Vehicle when Enabled** | **Yes**, No, Only if Needed | If this is set to **Yes**, a vehicle will spawn when the device is enabled. Choosing **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle when Disabled** | **On**, Off | Destroys a spawned vehicle when the spawner is disabled. |
| **Activating Team** | **Any**, Pick or enter a team | Determines which team is able to use vehicles from this spawner. |
| **Allowed Class** | No Class, Any, **All**, Pick or enter a class | Determines what class can use this vehicle. Values for this option are:   - **All**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with a class assigned can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick or enter a class**: Pick a class identifier; only players assigned that class can use the vehicle. |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. This does affect its collision properties. |
| **Supports Wraps** | **Enabled**, Disabled | Determines whether the vehicle supports wraps. |
| **Vehicle Indestructible** | On, ***Off*** | Determines if the vehicle can be destroyed by damage. If this is set to **Off**, an additional option displays below this one. |
| **Vehicle Health** | **150**, Indestructible, Pick a number | This option only displays if the **Vehicle Indestructible** option is set to **Off**. Determines how much damage the vehicle can take before it is destroyed. |
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
| **On Player Enters the Vehicle Send Event To** | When a player enters a spawned vehicle, an event is sent to the selected device, which triggers the selected function. |
| **On Player Exits the Vehicle Send Event To** | When a player exits the spawned vehicle, an event is sent to the selected device, which triggers the selected function. |
| **On Vehicle Spawns Send Event To** | When a vehicle spawns or respawns, an event is sent to the selected device, which triggers the selected function. |
| **On Vehicle Is Destroyed Send Event To** | When the spawned vehicle is destroyed, an event is sent to the selected device, which triggers the selected function. |
