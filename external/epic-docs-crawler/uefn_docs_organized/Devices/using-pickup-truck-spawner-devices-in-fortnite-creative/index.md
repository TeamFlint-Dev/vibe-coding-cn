# Pickup Truck Spawner Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-pickup-truck-spawner-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:42:27.301011

---

A **Pickup Truck Spawner** is a device that [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) a pickup truck vehicle into your island at the spawner's given location and orientation.

- Use Pickup Truck Spawner devices in combination with the [Race Checkpoint Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-race-checkpoint-devices-in-fortnite-creative) to design a racing game for your players.
- You can place a player directly inside the pickup truck using a trigger.

To find the **Pickup Truck Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like setting boost regen and determining whether the radio is enabled. Additionally, there are some advanced options, like whether the pickup truck vehicle takes damage from collisions, how much damage it can take before being destroyed, and how much damage it deals when it explodes.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | Always, None, Pre-Game Only, Gameplay Only, Create Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) during which the device will be enabled. Pre-Game includes all phases prior to the Game starting (the waiting for players lobby on Featured Islands and the Game Start Countdown). |
| **Enable Respawn** | ***On***, Off | Determines if the vehicle will respawn after being destroyed. If set to **Off**, the **Respawn****Time** option does not display. |
| **Respawn Time** | **Instant**, Never, Pick a time | Respawns a vehicle that's been destroyed after a selected delay. |
| **Respawn Vehicle when Enabled** | **Yes**, No, Only if Needed | If this is set to **Yes**, a vehicle will spawn when the device is enabled. Choosing **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle when Disabled** | **Yes**, No | Destroys a spawned vehicle when the spawner is disabled. |
| **Activating Team** | **Any**, Pick a team | Determines which team can use the spawned vehicle. |
| **Selected Class** | **All**, Any, No Class, Pick or enter a number | Determines what class can use this vehicle.  Values for this option are:   - **All**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with a class assigned can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick or enter a number**: Pick a numerical class identifier; only players assigned that class can use the vehicle. |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. If the device is not visible, it has no collision properties. |
| **Fuel Consumption** | **Off**, *On* | Determines if the spawned vehicle uses fuel. If set to **O****n**, then additional options will be displayed. |
| **Starting Fuel** | **Random**, Pick a percentage | This option only displays when **Fuel Consumption** is set to **On**. Determines the percentage of fuel in the vehicle's fuel tank at spawn. **Random** will spawn the vehicle with a percentage of fuel between 25% and 80%. |
| **Fuel Use** | Slow, **Normal**, Fast | This option only displays when **Fuel Consumption** is set to **On**. Controls how quickly the vehicle will use fuel while driving. |
| **Boost Enabled** | Off, *On* | Determines whether boost is enabled on the vehicle. If this is set to **On**, the following options become available: Unlimited Boost, and Boost Fuel Use |
| **Unlimited Boost** | On, *Off* | This option only displays if the **Boost Enabled** option is set to **On**. Determines whether boost uses fuel. If this is set to **Off**, an additional option displays. |
| **Boost Regen Multiplier** | **Default**, Pick or enter a number | This option only displays if **Unlimited Boost** is set to **Off**. If **Boost Enabled** is set to **On**, this determines how quickly the boost meter fills. |
| **Boost Fuel Use** | **0.5**, Pick or enter a number | This option only displays if the Boost Enabled and **Fuel Consumption** options are set to On. Controls how quickly the vehicle will use fuel while boosting. |
| **Radio Enabled** | **True**, False | Determines whether the spawned vehicle is able to use the [radio](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary). |
| **Tire Selection** | **Road Tires**, Off-Road Tires | Determines the type of tires for the spawned vehicle. |
| **Spawn with Cow Catcher** | Yes, **No** | Determines whether the vehicle has the Cow Catcher equipped when spawned. |
| **Vehicle Indestructible** | *Off*, On | Determines whether the spawned vehicle can be destroyed by damage. If this is set to **Off**, the Vehicle Health option displays. |
| **Vehicle Health** | **1000**, Pick or enter a number | Determines how much damage the vehicle can take before it is destroyed. |
| **Allow Damage Other Vehicles** | Yes, **No** | **Yes** will allow other vehicles to damage this vehicle by colliding with it. |
| **Max Explosion Delay** | **1 second**, Instant, Pick a delay time | The maximum time the vehicle can have zero health, after which it will explode. |
| **Lifetime After Explosion** | **1 second**, Instant, Pick a duration | The duration in seconds that the destroyed vehicle will remain in the world, after which it is removed entirely. |
| **Explosion Damage to Environment** | **800**, None, Pick an amount of damage | The amount of damage dealt to environment objects when the vehicle explodes. |
| **Explosion Damage to Players** | **800**, None, Pick an amount of damage | The amount of damage dealt to players when the vehicle explodes. |
| **Explosion Damage to Vehicles** | **800**, None, Pick an amount of damage | The amount of damage dealt to other vehicles when the vehicle explodes. |
| **Destroy When Stuck Under Water** | On, Off | Determines if the vehicle will destroy itself when it’s stuck under water. |
| **Water Destruction Timer** | **5.0 seconds**, Pick or enter a number | When the vehicle is too deep in water to drive, it is destroyed after the timer interval is met. |

## Direct Event Binding

Below are the direct event binding options for this device.

### Functions

  A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Respawn Vehicle When Receiving From** | This function spawns the vehicle, destroying the existing vehicle if it still exists, when an event occurs. |
| **Destroy Vehicle When Receiving From** | This function destroys the spawned vehicle when an event occurs. |
| **Assigns Driver When Receiving From** | This function seats the instigating player as the spawned vehicle's driver when an event occurs. |

### Events

An event tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters the Vehicle Send Event To** | When a player enters the spawned vehicle, it sends an event to the selected device. |
| **On Player Exits the Vehicle Send Event To** | When a player exits the spawned vehicle, it sends an event to the selected device. |
| **On Vehicle Spawns Send Event To** | When a vehicle spawns or respawns, it sends an event to the selected device. |
| **On Vehicle Is Destroyed Send Event To** | When the spawned vehicle is destroyed, it sends an event to the selected device. |
