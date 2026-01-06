# SUV Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-suv-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:33:57.087581

---

The **SUV Spawner** spawns a rugged and stylish sport utility vehicle (SUV) that players can use to [traverse](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#traverse) your island – whether they are driving around town, need protection while moving to an objective, or are in an off-road race.

For help on how to find the SUV Spawner device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines in which phases the device is enabled. |
| **Enable Respawn** | ***On***, Off | Determines if a vehicle is respawned after it is destroyed. If this is set to **On**, another option displays below this one. |
| **Respawn Time** | **Instant**, Pick or enter an amount | This option only displays if the **Enable Respawn** option is set to **On**. Determines the delay between a vehicle being destroyed and being respawned. |
| **Respawn Vehicle When Enabled** | No, Only If Needed, **Yes** | Determines whether a new vehicle will be spawned when the device is enabled. |
| **Destroy Vehicle When Disabled** | **On**, Off | Determines whether spawned vehicles are destroyed when the device is disabled. |
| **Activating Team** | **Any**, Pick or enter a number | Determines which teams can drive the cars spawned from this device. |
| **Allowed Class** | No Class, **All**, Any, Pick or enter a number | Determines which classes can drive the cars spawned from this device.  Values include:   - **No Class**: only players with no assigned class can use cars from this device. - **All**: all players, including those with no class assigned, can use cars from this device. - **Any**: any player with an assigned class can use cars from the device. |
| **Visible During Game** | **On**, Off | Determines whether the spawner is visible during the game. If this is set to **Off** the device will not have collision. |
| **Fuel Consumption** | *On*, **Off** | Determines whether the spawned vehicle uses fuel. If this is set to **On**, an additional option is displayed below this one. |
| **Random Starting Fuel** | **On**, Off | This option only displays if the **Fuel Consumption** option is set to **On**. Determines whether the spawned vehicle has a randomly selected amount of fuel. The amount will be between 25% and 80% of the maximum possible fuel. If this is set to **Off**, an additional option is displayed below this one. |
| **Fuel Use Multiplier** | **1.0**, Pick an amount | Determines how quickly the vehicle uses fuel while driving. |
| **Boost Enabled** | ***On***, Off | Determines if boost is enabled on spawned vehicles. If this is set to **On**, two additional options display below this one. |
| **Unlimited Boost** | On, ***Off*** | Determines if using boost consumes fuel. |
| **Boost Regen Multiplier** | **10.0**, Pick or enter a number | If the **Unlimited Boost** option is set to **Off**, this determines how quickly the boost meter refills. |
| **Boost Fuel Use** | **0.5**, Pick or enter an amount | If the **Unlimited Boost** option is set to **Off**, this determines how much fuel is used each time boost is engaged. |
| **Radio Enabled** | **True**, False | Determines whether the spawned vehicle is able to use the radio. |
| **Spawn With Cow Catcher** | On, **Off** | Determines if the vehicle spawns with the Cow Catcher attached. |
| **Vehicle Indestructible** | On, ***Off*** | Determines if the vehicle can be destroyed by damage. If this is set to **Off**, another option displays below this one. |
| **Vehicle Health** | **2000**, Pick or enter an amount | This option only displays if the **Vehicle Indestructible** option is set to **Off**. Determines how much damage the vehicle can take before it is destroyed. |
| **Max Explosion Delay** | **1.0**, Pick or enter an amount | When a car reaches zero health, this determines the maximum amount of delay before the car explodes. This does not precisely determine when the car will explode. |
| **Lifetime After Explosion** | **1.0**, Pick or enter an amount | After a car explodes, this determines the delay before the car is removed from the world. |
| **Explosion Damage to Environment** | **800**, Pick or enter an amount | Determines the amount of damage dealt to the environment when a car explodes. |
| **Explosion Damage to Players** | **800**, Pick or enter an amount | Determines the amount of damage dealt to players when a car explodes. |
| **Explosion Damage to Vehicles** | **800**, Pick or enter an amount | Determines the amount of damage dealt to other vehicles when a car explodes. |
| **Destroy When Stuck Underwater** | ***On***, Off | Determines if the car will destroy itself when it gets stuck underwater. If this is set to **On**, an additional option displays below. |
| **Water Destruction Timer** | **5.0**, Pick or enter an amount | This option only displays if the **Destroy When Stuck Underwater** option is set to **On**. Determines how many seconds a car is stuck underwater before it destroys itself. |
| **Allow Damage From Other Vehicles** | On, **Off** | If this is set to **On**, other vehicles can damage cars spawned by this device when colliding with them. |
| **Damage Friendly Fire** | **On**, Off | If this is set to **On**, cars driven by players or AI that are friendly can damage each other when colliding. |
| **Damage Other Vehicles** | On, **Off** | If this is set to **On**, cars spawned by this device can damage other vehicles when colliding with them. |
| **Damage Own Vehicle** | On, **Off** | If this is set to **On**, cars spawned from this device can be damaged by colliding with other vehicles or the environment. |
| **Tire Selection** | **Road Tires**, Off-Road Tires | Determines what type of tires the vehicle spawns with. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to select an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Respawn Vehicle When Receiving From** | This function respawns the vehicle when an event occurs. |
| **Destroy Vehicle When Receiving From** | This function destroys the vehicle when an event occurs. |
| **Assigns Driver When Receiving From** | This function assigns a driver when an event occurs. |
| **Apply Off Road Tires When Receiving From** | This function applies off-road tires to the vehicle when an event occurs. |
| **Remove Tire Modification When Receiving From** | This function removes tire modifications from the vehicle when an event occurs. |
| **Pop All Tires When Receiving From** | This function pops all tires on the vehicle when an event occurs. |
| **Repair All Tires When Receiving From** | This function repairs all tires on the vehicle when an event occurs. |
| **Repair Vehicle When Receiving From** | This function repairs the vehicle when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters Vehicle Send Event To** | When a player enters a vehicle, the spawner sends an event to the selected device, which triggers the selected function. |
| **On Player Exits Vehicle Send Event To** | When a player exits a vehicle, the spawner sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Spawns Send Event To** | When a vehicle spawns, the spawner sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Is Destroyed Send Event To** | When a vehicle is destroyed, the spawner sends an event to the selected device, which triggers the selected function. |
