# Armored Battle Bus Spawner Device

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-armored-battle-bus-spawner-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:33:13.787298

---

The **Armored Battle Bus** is a battle-hardened addition to available vehicles. Creators can [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) an Armored Battle Bus on the island to a specific location and orientation. This vehicle has unique features, including:

- Up to 3 players can man the vehicle — one driver and two players on turrets mounted in the front and rear of the bus.
- It can instantly destroy vegetation, rocks, and most buildings when a player drives the bus into them.
- Turrets mounted on the Armored Battle Bus are equipped with scopes.
- It can interact with the Fuel Pump Device for refueling.

For help on how to find the Armored Battle Bus Spawner device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) during which the device will be enabled. Pre-Game includes all phases prior to the start of the game. |
| **Enable Respawn** | ***On***, Off | Determines if the vehicle respawns after being destroyed. If this is set to **On**, an additional option displays below this one. |
| **Respawn Time** | **Instant**, Pick or enter an amount | This option only displays if the **Enable Respawn** option is set to **On**. Determines the delay after a vehicle is destroyed, before it respawns. |
| **Respawn Vehicle When Enabled** | No, Only If Needed, **Yes** | If this is set to **Yes**, a vehicle will spawn a vehicle when the device is enabled. **Only if needed** will not reset an existing vehicle. |
| **Destroy Vehicle When Disabled** | **On**, Off | Destroys a spawned vehicle when the device is disabled. |
| **Activating Team** | **Any**, Pick or enter a number | Determines which team the device belongs to. |
| **Allowed Class** | No Class, **All**, Any, Pick or enter a number | Determines what class can use this vehicle. Values for this option are:   - **All**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with a class assigned can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick or enter a number**: Pick a [class identifier](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary); only players assigned that class can use the vehicle. |
| **Visible During Game** | **On**, Off | Determines whether the vehicle is visible during the game. This does affect its collision properties. |
| **Fuel Consumption** | *On*, **Off** | Determines if the spawned vehicle uses fuel. If this is set to **On** is selected, two additional options are displayed. |
| **Random Starting Fuel** | **On**, *Off* | This option only displays if the **Fuel Consumption** option is set to **On**. If this is set to **On**, the vehicle spawns with a random amount of fuel, between 25\% and 80\% of the maximum amount. If this is set to **Off**, an additional option displays below this one. |
| **Min Random Starting Fuel** | **0**, Pick an amount | Determines the minimum random fuel percentage the vehicle spawns with. |
| **Max Random Starting Fuel** | **0**, Pick an amount | Determines the maximum random fuel percentage the vehicle spawns with. |
| **Fuel Use Multiplier** | **1.0**, Pick or enter a number | This option only displays if the **Fuel Consumption** option is set to **On**. Determines how quickly the vehicle uses fuel while driving. |
| **Boost Enabled** | ***On***, Off | Determines whether boost is enabled on the vehicle. If this is set to **On**, additional options display. |
| **Unlimited Boost** | ***Off***, On | This option only displays if the **Boost Enabled** option is set to **On**. Determines whether boost uses fuel. If this is set to **Off**, an additional option displays. |
| **Boost Regen Multiplier** | **Default**, Pick or enter a number | If boost is enabled, this determines how quickly the boost meter fills. |
| **Boost Fuel Use** | **0.5**, Pick or enter a number | This option only displays if the **Fuel Consumption** option is set to **On**. Controls how quickly the vehicle uses fuel while boosting. |
| **Radio Enabled** | **True**, False | Determines whether the spawned vehicle is able to use the [radio](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |
| **Spawn with Cow Catcher** | **On**, Off | Determines whether the spawned vehicle has a cow catcher. |
| **Vehicle Indestructible** | ***Off***, On | Determines whether the spawned vehicle can be destroyed by damage. |
| **Vehicle Health** | **2250**, Pick or enter a number | Determines how much damage a vehicle can take before destruction. |
| **Max Explosion Delay** | **1 Second**, Pick or enter an amount | Determines the maximum time the vehicle can have zero health before it will explode. |
| **Lifetime After Explosion** | **1 Second**, Pick or enter an amount | Determines the amount of time the destroyed vehicle remains in the world before being removed entirely. |
| **Explosion Damage To Environment** | **800**, Pick or enter a number | Determines the amount of damage to deal to environment objects when the vehicle explodes. |
| **Explosion Damage to Players** | **800**, Pick or enter a number | Determines the amount of damage to deal to players when the vehicle explodes. |
| **Explosion Damage to Vehicles** | **800**, Pick or enter a number | Determines the amount of damage to deal to other vehicles when the vehicle explodes. |
| **Destroy When Stuck Underwater** | **On**, Off | Determines whether the vehicle will destroy itself when it is stuck underwater. |
| **Water Destruction Timer** | **5.0 seconds**, Pick or enter a number | Determines how long a vehicle can be stuck in underwater before it destroys itself. |
| **Allow Damage from Other Vehicles** | On, **Off** | If this is set to **On**, the spawned vehicle can be damaged by other vehicles. |

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
| **Respawn Vehicle When Receiving From** | This function spawns the vehicle when an event occurs. |
| **Destroy Vehicle When Receiving From** | This function destroys the vehicle when an event occurs. |
| **Assigns Driver When Receiving From** | This function seats the instigating player as the vehicle's driver. |
| **Apply Off Road Tires When Receiving From** | This function applies off-road tires when an event occurs. |
| **Remove Tire Modification When Receiving From** | This function removes tire modifications when an event occurs. |
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
