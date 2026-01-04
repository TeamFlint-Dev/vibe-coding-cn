# Nitro Drifter Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-nitro-drifter-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:32:55.559794

---

The **Nitro Drifter Spawner** is a fast, stylish car that seats four to encourage social play. The visual look of the vehicle is themed around Cyber-City and fits well with a cyberpunk or Neo-Tokyo aesthetic. This car also has unique handling, with the ability to [drift](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#drift). This works particularly well with racing games, but can add style to any game mode where vehicles are available.

  For help on how to find the Nitro Barrel device, see [Using Devices](https://dev.epicgames.com/documentation/assets/using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like whether the device is visible during a game, and whether the vehicle uses fuel. Additionally, there are some advanced options, like whether the vehicle can use boost and what happens when the vehicle explodes.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Visible During Game** | **On**, Off | Determines if the spawner is visible during the game. This affects its collision properties. |
| **Fuel Consumption** | **Off**,*On* | Determines if the spawned vehicle uses fuel. If you choose **On**, two additional options are displayed below this one. |
| **Random Starting Fuel** | **On**, *Off* | This option only displays if the **Fuel Consumption** option is set to **On**. By default, this spawns the vehicle with a random amount of fuel, between 25% and 80% of maximum capacity. If you choose **Off**, another option is displayed below this one. |
| **Starting Fuel** | **100%**, Pick or enter a percentage | This option only displays if the Random Starting Fuel option is set to **Off**. This determines how much fuel the vehicle has when spawned. |
| **Fuel Use Multiplier** | **1.0**, Pick or enter a multiplier | Determines how quickly the vehicle consumes fuel, as expressed by a multiple of the default rate. |
| **Radio Enabled** | **True**, False | Determines whether the spawned vehicle can use the radio. |
| Enabled During Phase | None, Always, Pre-Game Only, Gameplay Only, Create Only | Determines the phases the device will be enabled in. If you choose **Create Only**, the device will only be enabled when you are editing your island. |
| Enable Respawn | *On*, Off | Determines if the vehicle will be respawned after it is destroyed. If you choose Off, the Respawn Time option is not displayed. |
| Respawn Time | Instant, Pick or enter an amount of time | After a vehicle is destroyed, this determines the amount of delay before another vehicle spawns. |
| Respawn Vehicle When Enabled | Yes, Only if Needed, No | Determines whether a vehicle spawns when the device is enabled. If you choose Only If Needed, a vehicle only spawns if there is no active spawned vehicle already. |
| Destroy Vehicle When Disabled | On, Off | Determines whether any existing spawned vehicle is destroyed when the device is disabled. |
| Activating Team | Any, Pick or enter a team | Determines which team can use this device. |
| Allowed Class | No Class, All, Any, Pick or enter a class | Determines which classes can use this device.   - No Class: Only players without an assigned class can use the vehicle. - All: All players, with an assigned class or with no class, can use the vehicle. - Any: Players with any assigned class can use the vehicle, but players without an assigned class cannot. |
| Boost Enabled | Off, *On* | Determines if the spawned vehicle can use boost. If you choose On, the four additional options are displayed. |
| Boost Fuel Use | 0.5, Pick or enter a number | This option is only displayed if the Boost Enabled option is set to On. This determines how fast boost uses fuel. |
| Unlimited Boost | Off, On | This option is only displayed if the Boost Enabled option is set to On. This determines if the spawned vehicle has unlimited boost. |
| Boost Regen Multiplier | Default (1.0), Pick or enter a number | This option is only displayed if the Boost Enabled option is set to On. This determines how quickly the boost meter regenerates. |
| Tire Selection | Road Tires, Pick a tire type | Determines what kind of tires the spawned vehicle uses. |
| Spawn with Cow Catcher | Off, On | Determines if the vehicle spawns with a Cow Catcher attached. |
| Vehicle Indestructible | Off, On | Determines if the spawned vehicle can be destroyed by damage. |
| Damage Friendly Fire | On, Off | Determines if spawned vehicles can damage other vehicles that are friendly to it. |
| Damage Other Vehicles | Off, On | Determines if the spawned vehicle can damage other vehicles when it collides with them. |
| Allow Damage From Other Vehicles | Off, On | Determines if the spawned vehicle can be damaged by other vehicles that collide with it. |
| Damage Own Vehicle | Off, On | Determines whether the player can damage their own vehicle. |
| Max Explosion Delay | 1.0, Pick or enter an amount | If a spawned vehicle has zero health, this determines the delay before the vehicle explodes. |
| Lifetime After Explosion | 1.0, Pick or enter an amount | If a spawned vehicle is destroyed by exploding, this determines the time the destroyed vehicle stays in the world before it is removed from the game. |
| Explosion Damage to Environment | 800.0, Pick or enter a number | If a spawned vehicle explodes, this determines how much damage it deals to the environment. |
| Explosion Damage to Players | 800.0, Pick or enter a number | If a spawned vehicle explodes, this determines how much damage it deals to players. |
| Explosion Damage to Vehicles | 800.0, Pick or enter a number | If a spawned vehicle explodes, this determines how much damage it deals to other vehicles. |
| Destroy When Stuck Underwater | *On*, Off | Determines whether a spawned vehicle is destroyed when it is stuck underwater. If you choose Off, the Water Destruction Timer option does not display. |
| Water Destruction Timer | 5.0, Pick or enter an amount | If spawned vehicles are destroyed when stuck underwater, this determines the delay before the vehicle is destroyed. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving On** | This function enables the device when an event occurs. |
| **Disable When Receiving On** | This function disables the device when an event occurs. |
| **Respawn Vehicle When Receiving On** | This function respawns the vehicle when an event occurs. |
| **Destroy Vehicle When Receiving On** | This function destroys the vehicle when an event occurs. |
| **Assigns Driver When Receiving On** | This function assigns a driver to the vehicle when an event occurs. |

### Events

An event tells another device when to perform a function.

1. For any event, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters Vehicle Send Event To** | When a player enters the spawned vehicle, it sends an event to the selected device, which triggers the selected function. |
| **On Player Exits Vehicle Send Event To** | When a player exits the spawned vehicle, it sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Spawns Send Event To** | When the vehicle spawns, it sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Destroyed Send Event To** | When the spawned vehicle is destroyed, it sends an event to the selected device, which triggers the selected function. |
