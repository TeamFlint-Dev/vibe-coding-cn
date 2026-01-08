# Sportbike Spawner Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-sportbike-spawner-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:36:54.337281

---

The **Sportbike Spawner** device spawns a Neo-Tokyo themed racing motorcycle. Speedy and stylish, players riding on this two-person motorcycle can engage in both [melee](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#melee) and ranged combat. Because it seats two, it can enhance social play by encouraging players to ride with friends.

For help on how to find the Sportbike Spawner device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines which phases the device is enabled in. **Pre-Game Only** includes all phases that occur before the game starts. **Create Only** means it is only enabled while you are editing your island. |
| **Enable Respawn** | **On**, Off | Determines whether the vehicle will respawn after it is destroyed. |
| **Respawn Time** | **Instant**, Pick or enter an amount of time | Determines how long it takes for a vehicle to be respawned after it is destroyed. |
| **Respawn Vehicle When Enabled** | **Yes**, Only If Needed, No | Determines if a new vehicle is spawned when the device is enabled. Values for this option include:   - **Yes**: When the device is enabled, a new vehicle is spawned. - **Only When Needed**: When the device is enabled, it will spawn a new vehicle only if there is no existing vehicle. - **No**: When the device is enabled, no vehicle is spawned. |
| **Destroy Vehicle When Disabled** | **On**, Off | By default, the active vehicle spawned from this device is destroyed when the device is disabled. If you choose **Off**, any spawned vehicle is still usable. |
| **Activating Team** | **Any**, Pick or enter team number | Determines which team owns this device and can use its vehicles. |
| **Allowed Class** | No Class, **All**, Any, Pick a class | Determines which classes are able to use vehicles spawned by this device. Values for this option include:   - **No Class**: Only players without an assigned class can use the vehicle. - **All**: All players, with an assigned class or with no class, can use the vehicle. - **Any**: Players with any assigned class can use the vehicle, but players without an assigned class cannot. |
| **Visible During Game** | **On**, Off | Determines whether the spawner is visible during the game. |
| **Vehicle Indestructible** | ***Off***, On | Determines whether the vehicle can be damaged. By default, this option is set to **Off** and the **Vehicle Health** option is displayed below it. If you choose **On**, the vehicle cannot be destroyed or take damage and the **Vehicle Health** option does not display. |
| **Vehicle Health** | **550**, Pick or enter an amount | This option only displays if the **Vehicle Indestructible** option is set to **Off**. This option sets the amount of Health the vehicle has when spawned. |
| **Destroy When Stuck Underwater** | ***On***, Off | Determines if the vehicle will destroy itself if it gets stuck underwater. By default, it is set to **On**, and the **Water Destruction Timer** option is displayed below it. If you choose **Off**, the **Water Destruction Timer** option does not display. |
| **Water Destruction Timer** | **5.0 seconds**, Pick or enter a number | This option only displays if the **Destroy When Stuck Underwater** option is set to **Off**. If the vehicle becomes stuck underwater, this determines how long it lasts before it destroys itself. |
| **Fuel Consumption** | *On*, **Off** | Determines whether the vehicle requires fuel. If this is set to **On**, additional options display. |
| **Fuel Use Multiplier** | **1.0**, Pick or enter a number | This option only displays if the **Fuel Consumption** option is set to **On**. Determines how fast the vehicle uses fuel, as expressed by a multiple of the default rate. Lower numbers mean the vehicle uses fuel more slowly; higher numbers mean the vehicle uses fuel more quickly. |
| **Random Starting Fuel** | **On**, *Off* | Determines whether the vehicle spawns with a random amount of fuel, between 85%-95% of its maximum fuel. |
| **Min Random Starting Fuel** | **0**, Pick or enter an amount | This option only displays if the **Random Starting Fuel** is set to **On**. Determines the minimum random percentage of starting fuel the spawned vehicle can have. |
| **Max Random Starting Fuel** | **0**, Pick or enter an amount | This option only displays if the **Random Starting Fuel** is set to **On**. Determines the maximum random percentage of starting fuel the spawned vehicle can have. |
| **Starting Fuel** | **100**, Pick or enter a percentage | This option only displays if the **Random Starting Fuel** option is set to **Off**. Determines how much fuel the vehicle spawns with. |
| **Boost Enabled** | ***On***, Off | Determines if boost is enabled on the spawned vehicle. If this is set to **On**, more options display. |
| **Unlimited Boost** | *On*, **Off** | This option only displays if the **Boost Enabled** option is set to **On**. Determines if using boost consumes fuel. |
| **Boost Fuel Use** | **0.5**, Pick or enter a number | This option only displays if the **Boost Enabled** option is set to **On**. Determines how much fuel the vehicle uses when boosting. |
| **Boost Regen Multiplier** | **10.0**, Pick or enter a number | This option only displays if both the **Boost Enabled** option is set to **On** and the **Unlimited Boost** option is set to **Off**. Determines how quickly the boost meter fills. |
| **Visual Variant** | **Random**, Red, Blue, Gray, White | Determines which visual variant is applied to the spawned vehicle. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving On** | This function enables the device when an event occurs. |
| **Disable When Receiving On** | This function disables the device when an event occurs. |
| **Respawn Vehicle When Receiving On** | This function respawns the vehicle when an event occurs. |
| **Destroy Vehicle When Receiving On** | This function destroys the vehicle when an event occurs. |
| **Assigns Driver When Receiving On** | This function assigns a driver to the vehicle when an event occurs. |
| **Apply Off Road Tires When Receiving From** | If the vehicle is set up for off road tires, they will be applied when an event occurs. |
| **Remove Tire Modification When Receiving From** | When an event occurs, this will revert the vehicle to road tires. |
| **Pop All Tires When Receiving From** | If vehicle still has tires, this will pop all of them when an event occurs. |
| **Repair All Tires When Receiving From** | If the vehicle has damaged tires, they will be repaired when an event occurs. |
| **Repair Vehicle When Receiving From** | Restore full health for the vehicle when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters Vehicle Send Event To** | When a player enters the spawned vehicle, it sends an event to the selected device, which triggers the selected function. |
| **On Player Exits Vehicle Send Event To** | When a player exits the spawned vehicle, it sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Spawns Send Event To** | When the vehicle spawns, it sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Destroyed Send Event To** | When the spawned vehicle is destroyed, it sends an event to the selected device, which triggers the selected function. |
