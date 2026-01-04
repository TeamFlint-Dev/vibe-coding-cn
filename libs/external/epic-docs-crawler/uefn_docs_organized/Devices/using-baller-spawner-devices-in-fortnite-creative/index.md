# Baller Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-baller-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:35:18.810794

---

A **Baller Spawner** is a device that [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a [Baller](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) vehicle into the level at the spawner's given location and orientation.

Some ideas for using the Baller:

- Use Baller Spawner devices in combination with the [Racing Checkpoint Device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to design a racing game for your players.
- You can place a player directly inside the Baller using a trigger or with event binding.

  To find the Baller Spawner device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **All**, None, Pre-Game Only, Gameplay Only, Create Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) during which the device will be enabled. Pre-Game includes all phases that occur before the game starts. |
| **Enable Respawn** | **On**, *Off* | Determines if the vehicle will respawn after being destroyed. If this is set to **Off**, the **Respawn Time** option will not display. |
| **Respawn Time** | **Instant**, Pick or enter a time | Determines the length of time before a destroyed vehicle is respawned. |
| **Respawn Vehicle when Enabled** | **Yes**, No, Only if Needed | If this is set to **Yes**, a vehicle will spawn when the device is enabled. Choosing **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle when Disabled** | **On**, Off | Destroys a spawned vehicle when the spawner is disabled. |
| **Activating Team** | **Any**, Pick or enter a team | Determines which team can use vehicles spawned from this device. |
| **Allowed Class** | No Class, **All**, Any, Pick or enter a class | Determines what class can use this vehicle. Values for this option are:   - **All**: All classes can use this vehicle, including players with no class. - **Any**: Any player with a class assigned can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick a class**: Pick a class identifier; only players assigned that class can use the vehicle. |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. Hidden devices don't have collision properties. |
| **Supports Wraps** | On, **Off** | Determines whether the spawned vehicle supports wraps. |
| **Grappler Range** | **50M**, Pick or enter a range | Determines the maximum distance, in meters, that the Baller's grappler can reach. |
| **Has Infinite Energy** | **Yes**, *No* | Determines whether the spawned vehicle has infinite energy. If this is set to **No**, additional options are displayed below this one. |
| **Use Random Starting Energy** | Yes, ***No*** | This option only displays if the **Has Infinite Energy** option is set to **No**. Determines if the vehicle has a random amount of energy when it spawns. If this is set to **No** an additional option displays below this one. |
| **Starting Energy** | **100**, Pick or enter an amount | This option only displays if the **Use Random Starting Energy** option is set to **No**. Determines the amount of energy in the vehicle when it spawns. |
| **Boost Energy Use Per Second** | **50**, Pick or enter an amount | Controls how quickly the vehicle will use fuel while boosting. If this is set to **0** then boosting has no effect on fuel usage. |
| **Energy Use Per Second** | **7.0**, Pick or enter an amount | Controls how quickly the vehicle will use energy while driving. |
| **Vehicle Indestructible** | ***Off***, On | Determines if the vehicle can be destroyed by damage. If set to **Off**, an additional option is displayed below this one. |
| **Vehicle Health** | **400**, Pick or enter an amount | This option only displays if the **Vehicle Indestructible** option is set to **Off**. Determines how much damage the vehicle can take before it is destroyed. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | When an event occurs, this function enables the vehicle spawner, allowing it to spawn vehicles. |
| **Disable When Receiving From** | When an event occurs, this function disables the vehicle spawner, stopping it from spawning any more vehicles. |
| **Respawn Vehicle When Receiving From** | When an event occurs, this function spawns the vehicle, which destroys any existing vehicle. |
| **Destroy Vehicle When Receiving From** | When an event occurs, this function destroys the spawned vehicle if it still exists. |
| **Assigns Driver When Receiving From** | When an event occurs, this function seats the instigating player as the spawned vehicle's driver. |
| **Refill Energy When Receiving From** | When an event occurs, this function refills the vehicle's energy to the maximum amount. |
| **Apply Off Road Tires When Receiving From** | When an event occurs, this function applies off-road tires if the vehicle can receive them. |
| **Remove Tire Modification When Receiving From** | When an event occurs, this function removes tire modifications from the spawned vehicle. |
| **Pop All Tires When Receiving From** | This function pops all tires on the spawned vehicle when an event occurs. |
| **Repair All Tires When Receiving From** | This function repairs all the vehicle's tires when an event occurs. |
| **Repair Vehicle When Receiving From** | This function repairs the vehicle when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters the Vehicle Send Event To** | When a player enters the spawned vehicle, an event is sent to the selected device, which triggers the selected function. |
| **On Player Exits the Vehicle Send Event To** | When a player exits the spawned vehicle, an event is sent to the selected device, which triggers the selected function. |
| **On Vehicle Spawns Send Event To** | When a vehicle spawns or respawns, an event is sent to the selected device, which triggers the selected function. |
| **On Vehicle Is Destroyed Send Event To** | When the spawned vehicle is destroyed, an event is sent to the selected device, which triggers the selected function. |
| **On Is Out of Energy Send Event To** | When the spawned vehicle runs out of energy, the spawner sends an event to the selected device, which triggers the selected function. |
