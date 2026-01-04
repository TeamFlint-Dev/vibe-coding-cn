# Boat Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-boat-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:45:30.239260

---

A **Boat Spawner** is a device you can use to [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a motorboat onto an island. You can use Boat Spawner devices in combination with the [Racing Checkpoint Device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to design a racing game on the water.

You can place a player directly inside the boat using a [function](https://dev.epicgames.com/documentation/en-us/fortnite/using-boat-spawner-devices-in-fortnite-creative#functions).

You can only place a Boat Spawner device on water. You won't be able to place it on dry land, and you can't place it in a Water volume either.

For help on how to find the **Boat Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, any values that trigger contextual filtering are in *italic*. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Alwways**, Pre-Game Only, Gameplay Only, Create Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) during which the device is enabled. Pre-Game includes all phases prior to the start of the game. **Create Only** enables the device only when you are editing your island in Create mode. |
| **Enable Respawn** | **On**, *Off* | Determines if the vehicle will respawn after being destroyed. If set to **Off**, the **Respawn Time** option becomes hidden. |
| **Respawn Time** | **Instant**, Pick or enter an amount | Determines how long it takes for a vehicle to respawn after it is destroyed. |
| **Respawn Vehicle when Enabled** | **Yes**, No, Only if Needed | If this is set to **Yes**, a vehicle will spawn when the device is enabled. Choosing **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle when Disabled** | **On**, Off | Destroys a spawned vehicle when the spawner is disabled. |
| **Activating Team** | **Any**, Pick a team | Sets the team the device belongs to. |
| **Allowed Class** | No Class, **All**, Any, Pick a class | Determines what class can use this vehicle. Values for this option are:   - **No Class**: Only players with no class assigned can use the vehicle. - **All**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with a class assigned can use the vehicle. - **Pick a class**: Pick a class identifier; only players assigned that class can use the vehicle. |
| **Vehicle Indestructible** | **Off**, On | Determines how much damage the vehicle can take before it is destroyed. |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. This does affect its collision properties. |
| **Supports Wraps** | **On**, Off | Determines whether the vehicle supports wraps. |
| **Vehicle Health** | **800**, Pick a value | Determines how much damage the vehicle can take before it is destroyed. |
| **Vehicle Weapon Enabled** | **Enabled**, Disabled | Determines whether the spawned boat has weapons enabled. |
| **Fuel Consumption** | **Off**, *On* | Determines if the spawned vehicle uses fuel. If set to **On**, the **Fuel Use Multiplier** option will also display. |
| **Random Starting Fuel** | **On**, Off | If **On**, the vehicle will spawn with a percentage of fuel between 25\% and 80\%. |
| **Fuel Use Multiplier** | **1.0**, Pick a number | Only displayed when **Fuel Consumption** is set to **On**. Controls how quickly the vehicle will use fuel while driving. The lower the number, the slower the consumption. The higher the number, the faster the consumption. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the vehicle spawner when an event occurs, allowing it to spawn vehicles. |
| **Disable When Receiving From** | Disables the vehicle spawner when an event occurs, allowing it to spawn vehicles. |
| **Respawn Vehicle When Receiving From** | When an event occurs, spawns a new vehicle (and destroys the existing vehicle if it still exists.) |
| **Destroy Vehicle When Receiving From** | When an event occurs, if the vehicle that this spawner created still exists, destroy it. |
| **Assigns Driver When Receiving From** | Seats the instigating player as the spawned vehicle's driver when an event occurs. |
| **Apply Off Road Tires When Receiving From** | Does not impact the behavior of this vehicle since boats don't have tires. |
| **Remove Tire Modifications When Receiving From** | Does not impact the behavior of this vehicle. |
| **Pop All Tires When Receiving From** | Does not impact the behavior of this vehicle. |
| **Repair Vehicle When Receiving From** | Restores a respawned vehicle with full health. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters the Vehicle Send Event To** | When a player enters the spawned vehicle, this sends an event to the selected device, which triggers the selected function. |
| **On Player Exits the Vehicle Send Event To** | When a player exits the spawned vehicle, this sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Spawns Send Event To** | When a vehicle spawns or respawns, this sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Is Destroyed Send Event To** | When a spawned vehicle is destroyed, this sends an event to the selected device, which triggers the selected function. |
