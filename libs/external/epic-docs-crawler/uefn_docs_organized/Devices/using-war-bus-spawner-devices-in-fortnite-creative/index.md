# War Bus Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-war-bus-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:37:15.377061

---

The **War Bus Spawner** device creates a more rugged, low-tech version of the Battle Bus suited to desert and wasteland islands. Unique features include:

- Instead of turrets, the War Bus has **nautical cannons** mounted on top that shoot a powerful linear shot that explodes on impact, with a large damage radius.
- Players can use the **Horn** input to deploy a powerful electromagnetic pulse (EMP) that damages player shields and disables other vehicles.

For help on how to find the [**War Bus Spawner**] device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [**Event Browser**](event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the game phases during which the device will be enabled. **Pre-Game Only** includes all phases that occur before the game starts. |
| **Enable Respawn** | ***On***, Off | Determines if the vehicle respawns after being destroyed. If this is set to **Off**, the **Respawn Time** option is hidden. |
| **Respawn Time** | **Instant**, Pick or enter an amount | When a spawned vehicle is destroyed, this is the amount of delay before the vehicle respawns. |
| **Respawn Vehicle When Enabled** | No, Only if Needed, **Yes** | Determines whether the device spawns a vehicle when it is enabled. If you select **Yes**, it will always spawn a vehicle; if you select **Only if Needed** the device will not spawn another vehicle if one already exists. |
| **Destroy Vehicle When Disabled** | **On**, Off | Determines if spawned vehicles are destroyed when the device is disabled. |
| **Activating Team** | **Any**, Pick or enter a team | Determines which team is able to use the vehicle spawned from this device. If you select **Any**, all players can use the vehicle. |
| **Allowed Class** | No Class, **All**, Any, Pick or enter a class | Determines which classes are able to use the vehicle spawned from this device.  **No Class**: only players without an assigned class can use the vehicle. **All**: all players can use the vehicle (even those with no assigned class). **Any**: any player with an assigned class can use the vehicle. **Class Number**: only players who are assigned the selected class can use the vehicle. | |
| **Visible During Game** | **On**, Off | Determines if the spawner is visible during the game. If the device is hidden, it has no collision properties. |
| **Fuel Consumption** | *On*, **Off** | Determines whether the vehicle requires fuel. If this is set to **On**, additional options display. |
| **Random Starting Fuel** | **On**, *Off* | If this is set to **On**, the vehicle spawns with a random amount of fuel between 25 and 80 percent. If this is set to **Off**, the **Starting Fuel** option displays. |
| **Starting Fuel** | **100%**, Pick or enter an amount | Determines how much fuel a vehicle has when it spawns, as a percentage of the vehicle's total fuel. |
| **Fuel Use Multiplier** | **1.0x**, Pick a number | Determines how quickly the vehicle consumes fuel. |
| **Boost Enabled** | **On**, Off | Determines if boost is enabled on the spawned vehicle. |
| **Unlimited Boost** | On, ***Off*** | Determines whether the vehicle has unlimited boost. If this is set to **On**, the **Boost Regen Multiplier** option is hidden. |
| **Boost Regen Multiplier** | **10**, Pick or enter a number | Determines how quickly the boost meter fills. |
| **Boost Fuel Use** | **0.5**, Pick a number | Determines how quickly the vehicle uses fuel while boosting. |
| **Radio Enabled** | **True**, False | Determines if the vehicle can use the radio. |
| **Spawn with Cow Catcher** | **On**, Off | Determines if the vehicle spawns with the Cow Catcher attached. |
| **Vehicle Indestructible** | On**,** ***Off*** | Determines if the spawned vehicle can be damaged and destroyed. If you set this to **On**, the **Vehicle Health** option is hidden. |
| **Vehicle Health** | **2250**, Pick or enter a number | Determines how much damage the vehicle can take before it is destroyed. |
| **Max Explosion Delay** | **1.0**, PIck or enter a number | Determines the amount of time a vehicle can stay at zero health before it explodes. |
| **Lifetime After Explosion** | **1.0**, Pick or enter a number | Determines the amount of seconds an exploded vehicle remains in the world before it is removed entirely. |
| **Explosion Damage to Environment** | **800**, Pick or enter a number | Determines the amount of damage an exploding vehicle does to the environment. |
| **Explosion Damage to Player** | **800**, Pick or enter a number | Determines the amount of damage an exploding vehicle does to players. |
| **Explosion Damage to Vehicles** | **800**, Pick or enter a number | Determines the amount of damage an exploding vehicle does to other vehicles. |
| **Destroy When Stuck Underwater** | ***On***, Off | Determines if the vehicle will destroy itself if it gets stuck underwater. If this is set to **Off**, the **Water Destruction Timer** option is hidden. |
| **Water Destruction Timer** | **5.0 seconds**, Pick or enter an amount | When the vehicle is stuck in water too deep to drive through, this is the amount of time before it destroys itself. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Respawn Vehicle When Receiving From** | This function respawns a vehicle when an event occurs. |
| **Destroy Vehicle When Receiving From** | This function destroys the spawned vehicle when an event occurs. |
| **Assigns Driver When Receiving From** | This function assigns the instigating player as driver of the spawned vehicle when an event occurs. |
| **Apply Off Road Tires When Receiving From** | This function applies off road tires to the spawned vehicle when an event occurs. |
| **Remove Tire Modification When Receiving From** | This function removes tire modifications from the spawned vehicle when an event occurs. |
| **Pop All Tires When Receiving From** | This function pops all tires on the spawned vehicle when an event occurs. |
| **Repair All Tires When Receiving From** | This function repairs all tires on the spawned vehicle when an event occurs. |
| **Repair Vehicle When Receiving From** | This function repairs the spawned vehicle when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters Vehicle Send Event To** | When a player enters the vehicle, an event is sent to the selected device. |
| **On Player Exits Vehicle Send Event To** | When a player exits the vehicle, an event is sent to the selected device. |
| **On Vehicle Spawns Send Event To** | When the device spawns a vehicle, an event is sent to the selected device. |
| **On Vehicle Is Destroyed Send Event To** | When the spawned vehicle is destroyed, an event is sent to the selected device. |
