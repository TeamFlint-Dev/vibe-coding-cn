# Dirt Bike Spawner Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-dirt-bike-spawner-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:45:16.118734

---

The **Dirt Bike** is a fast and agile vehicle, fun for races or combat games! Players can shoot weapons while speeding down a straightaway or cornering curves or just go for the finish line.

  To find the Dirt Bike Spawner device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like determining whether the spawner is visible during the game. Additionally, there are some advanced options, like determining whether the vehicle is indestructible and whether it destroys itself when it is stuck underwater.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines in which phases the device is enabled. **Pre-Game Only** includes all phases that occur before the game starts. |
| **Enable Respawn** | **On**, Off | Determines if the dirt bike will respawn after it is destroyed. |
| **Respawn Time** | **Instant**, Pick or enter an amount of time | Determines how much time it takes for a new vehicle to spawn when the previous one is destroyed. |
| **Respawn Vehicle When Enabled** | **Yes**, No, Only If Needed | By default, the spawner destroys any existing vehicles and spawns a new one. If you choose **No**, enabling the device will not spawn a vehicle. If you choose **Only If Needed** the spawner will only spawn a new vehicle if there is no existing vehicle. |
| **Destroy Vehicle When Disabled** | **On**, Off | Determines whether any spawned vehicles are destroyed when the spawner is disabled. |
| **Activating Team** | **Any**, Pick or enter a team number | Determines which team owns this spawner and can use its vehicles. If you choose **Any**, all players can use the vehicle from this spawner. |
| **Allowed Class** | No Class, **All**, Any, Pick or enter a class | This determines which [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) is allowed to use the vehicle from this spawner. **No Class** means only players without an assigned class can use it; **All** means all players can use it (even those without a class assigned); **Any** means any player with an assigned class can use it. |
| **Visible During Game** | **On**, Off | Determines whether the spawner device is visible during a game. |
| **Vehicle Indestructible** | ***Off***, On | Determines whether the vehicle can be damaged. By default, this is set to **Off**, and the **Vehicle Health** option is displayed. If you choose **On**, the **Vehicle Health** option is not displayed. |
| **Vehicle Health** | **550**, Pick or enter a number | This only displays if the **Vehicle Indestructible** option is set to **Off**. This is the amount of damage a vehicle can take before being destroyed. |
| **Destroy When Stuck Underwater** | ***On***, Off | Determines whether the vehicle destroys itself when it is stuck underwater. By default, this is set to **On**, and the **Water Destruction Timer** option is displayed. If you choose **Off**, the **Water Destructions Timer** option is not displayed. |
| **Water Destruction Timer** | **5.0 seconds**, Pick or enter an amount of time | This only displays if the **Destroy When Stuck Underwater** option is set to **On**. When the vehicle is stuck underwater, this is the amount of time before it destroys itself. |
| **Fuel Consumption** | **Off**, *On* | Determines whether the vehicle requires fuel to operate. If set to **On**, more options appear. |
| **Fuel Use Multiplier** | **1.0**, Pick or enter a number | If the vehicle requires fuel, this determines how quickly the vehicle uses that fuel. If you want the fuel to run out faster, increase the multiplier. If you want the fuel to last longer, reduce the multiplier. This option only shows if **Fuel Consumption** is set to **On**. |
| **Random Starting Fuel** | **On**, *Off* | If the vehicle requires fuel and this is set to **On**, the vehicle will spawn with a random amount of fuel between 85% and 95% of its full capacity. This option only shows if **Fuel Consumption** is set to **On**. If set to **Off**, you can also set the amount of **Starting Fuel** in the next option. |
| **Starting Fuel** | **100**, Pick an amount | The percentage of fuel in the tank at spawn based on total capacity. **100** means that the tank is full. |
| **Visual Variants** | **Random**, Green, Orange, Red, Dark Blue, Pink, Purple, Yellow | Determines the visual variant applied to the spawned vehicle. |
| **Vehicle Speed Tunings** | **Ch 4 Battle Royale**, Current Battle Royale | Determines what set of speed tunings should be used for spawned vehicles. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Respawn Vehicle When Receiving From** | This function respawns the vehicle when an event occurs. |
| **Destroy Vehicle When Receiving From** | This function destroys the vehicle when an event occurs. |
| **Assigns Driver When Receiving From** | This function assigns a driver to the vehicle when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters a Vehicle Send Event To** | When a player enters the spawned vehicle, it sends an event to the selected device. |
| **On Player Exits Vehicle Send Event To** | When a player exits the spawned vehicle, it sends an event to the selected device. |
| **On Vehicle Spawns Send Event To** | When the vehicle spawns, it sends an event to the selected device. |
| **On Vehicle Is Destroyed Send Event To** | When the spawned vehicle is destroyed, it sends an event to the selected device. |
