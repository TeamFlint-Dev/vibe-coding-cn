# Biplane Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-biplane-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:37:33.884677

---

A **Biplane Spawner** is a device that [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a biplane vehicle onto your island at the spawner's given location and orientation.

Use Biplane Spawner devices in combination with a [Race Checkpoint device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to design a flying racing game. You can also place a player directly inside the Biplane using a [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative), or a [Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative).

To find the **Biplane Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs, we use italic for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **Always**, None, Pre-Game Only, Gameplay Only, Create Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) during which the device will be enabled. Pre-Game includes all phases prior to the start of the game. |
| **Enable Respawn** | **On**, Off | Determines whether the vehicle will respawn after it is destroyed. |
| **Respawn Time** | **Instant**, Pick an amount of time | Determines how much time it takes a vehicle to respawn after it is destroyed. |
| **Respawn Vehicle when Enabled** | **Yes**, No, Only if Needed | If this is set to **Yes**, a vehicle will spawn when the device is enabled. Choosing **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle when Disabled** | **On**, Off | Destroys a spawned vehicle when the spawner is disabled. |
| **Vehicle Indestructible** | ***Off***, On | Sets whether the vehicle can take any damage. |
| **Vehicle Health** | **800**, Pick a number | This option only displays when **Vehicle Indestructible** is set to **Off**. Determines how much damage the vehicle can take before it is destroyed. |
| **Activating Team** | **Any**, Pick a number | Set the team this vehicle belongs to. |
| **Allowed Class** | No Class, **All**, Any, Pick a number between 1 and 16 | Determines what class can use this vehicle. Values for this option are:   - **All**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with an assigned class can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick a class**: Pick a numeric class identifier; only players assigned that class can use the vehicle. |
| **Override Battle Royale Boosted Health Threshold** | **Off**, *On* | Provides a way to override the default BR thresholds for boosted health. |
| **Boosted Health Threshold** | **Everything**, Pick a health amount | This option only displays when **Override Battle Royale Boosted Health Threshold** is set to **On**. Determines the health threshold the object must be below for a boosting biplane to crash through. |
| **Override Battle Royale Direct Hit Health Threshold** | **Off**, On | Provides a way to override the default BR thresholds for the direct hit health threshold. |
| **Direct Hit Health Threshold** | Battle Royal, **Everything**, Pick a health amount | This option only displays when **Override Battle Royale Direct Hit Threshold** is set to **On**. Determines the health threshold the object must be below for a boosting biplane to crash through. |
| **Override Battle Royale Breakthrough Health Threshold** | **Off**, On | Provides a way to override the default BR thresholds for the breakthrough health threshold. |
| **Breakthrough Health Threshold** | **0**, Battle Royal, Everything, Pick a health amount | This option only displays when **Override Battle Royale Boosted Health Threshold** is set to **On**. Determines the health threshold the object must be below for a non-boosting biplane to crash through. |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. If the device is not visible, it has no collision properties. |
| **Supports Wraps** | **Enabled**, Disabled | Determines whether the vehicle supports wraps. |
| **Fuel Consumption** | **Off**, *On* | Determines if the spawned vehicle uses fuel. |
| **Random Starting Fuel** | , *On* | This option only displays when **Fuel Consumption** is set to **On**. Randomly selects a value between 25 and 80 percent of a full tank and assigns that much fuel to the vehicle when it spawns. |
| **Starting Fuel** | **100**, Pick or enter a number | This option only displays when **Fuel Consumption** is set to **On**. Determines the amount of fuel the vehicle starts with, between 0 and 100\% of a full tank. |
| **Min Random Starting Fuel** | **0**, Pick or enter a number | This option only displays if the **Fuel Consumption** and **Random Starting Fuel** options are set to **On**. Determines the minimum random fuel percentage the vehicle will spawn with. |
| **Max Random Starting Fuel** | **0**, Pick or enter a number | This option only displays if the **Fuel Consumption** and **Random Starting Fuel** options are set to **On**. Determines the maximum random fuel percentage the vehicle will spawn with. |
| **Fuel Use** | **1.0**, Pick a number | This option only displays when **Fuel Consumption** is set to **On**. Controls how quickly the vehicle uses fuel while driving. |
| **Destroy When Stuck Underwater** | ***On***, Off | Determines whether the vehicle will self-destruct if left underwater for too long. |
| **Water Destruction Timer** | **5.0 seconds**, Pick a time | This option only displays when **Destroy When Stuck Underwater** is set to **On**. Determines how long the biplane is stuck underwater before it is destroyed. |
| **Explosion Damage to Vehicles** | **None**, Pick or enter an amount | Determines the amount of damage dealt to other vehicles when the vehicle explodes. |
| **Explosion Damage to Players** | **None**, Pick or enter an amount | Determines the amount of damage dealt to players when the vehicle explodes. |
| **Explosion Damage to Environment** | **None**, Pick or enter an amount | Determines the amount of damage dealt to environment objects when the vehicle explodes. |
| **Max Explosion Delay** | **Instant**, Pick or enter an amount | Determines the maximum time the vehicle has zero health, before it explodes. |
| **Lifetime Ater Explosion** | **Instant**, Pick or enter an amount | The duration in seconds that the destroyed vehicle will remain in the world, after which it is removed. |
| **Allow Glider Redeploy** | On, **Off** | Determines whether the player can deploy their glider when exiting the biplane. |

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
| **Disable When Receiving From** | Stops the spawner from spawning when an event occurs. |
| **Respawn Vehicle When Receiving From** | When an event occurs, the vehicle will respawn. This also destroys the existing vehicle if there is one. |
| **Destroy Vehicle When Receiving From** | If the vehicle this spawner spawned still exists, it will be destroyed when an event occurs. |
| **Assigns Driver When Receiving From** | This assigns the instigating player as the driver for this vehicle when an event occurs. |
| **Apply Off Road Tires When Receiving From** | If the vehicle is set up for off road tires, they will be applied when an event occurs. |
| **Remove Tire Modification When Receiving From** | When an event occurs, this will revert the vehicle to road tires. |
| **Pop All Tires When Receiving From** | If vehicle still has tires, this will pop all of them when an event occurs. |
| **Repair All Tires When Receiving From** | If the vehicle has damaged tires, they will be repaired when an event occurs. |
| **Repair Vehicle When Receiving From** | Restore full health for the vehicle when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters Vehicle Send Event To** | When a player enters the spawned vehicle, this sends an event to the selected device, which triggers the selected function. |
| **On Player Exits Vehicle Send Event To** | When a player exits the spawned vehicle, this sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Spawns Send Event To** | When a vehicle is spawned or respawned, this sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Is Destroyed Send Event To** | When a vehicle is destroyed, this sends an event to the selected device, which triggers the selected function. |
