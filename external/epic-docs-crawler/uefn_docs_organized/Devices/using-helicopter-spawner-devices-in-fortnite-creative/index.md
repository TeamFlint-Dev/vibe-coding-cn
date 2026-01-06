# Helicopter Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-helicopter-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:30:13.074565

---

A **Helicopter Spawner** is a device that [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) a Helicopter vehicle into the level at the spawner's given location and orientation.

- Use Helicopter Spawner devices in combination with the [Race Checkpoint Device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#race-checkpoint) to design a racing game for your players.
- You can place a player directly inside the Helicopter using a trigger.

For help finding the Helicopter Spawner device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

It’s helpful to [customize device names](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) when you use multiple copies of the same device.

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use italic for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like whether it is visible in game, or whether it supports [wraps](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#wrap). Additionally, there are some advanced options, like which [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) and team can use the vehicle, and whether [enabling](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#enable) or disabling the device spawns or [despawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#despawn) the vehicle.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | Always, None, Pre-Game Only, Gameplay Only, Create Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) during which the device will be enabled. Pre-Game includes all phases prior to the Game starting (the waiting for players lobby on Featured Islands and the Game Start Countdown). If set to **Create Only**, the device will only be enabled while you are editing your island. |
| **Vehicle Indestructible** | On,*Off* | Determines if the vehicle can be destroyed by damage. If this is set to On, the Vehicle Health does not display. |
| **Vehicle Health** | **1500 (Default)**, Pick or enter a number | This option only displays if the **Vehicle Indestructible** option is set to **Off**. Determines how much damage the device can take before it is destroyed. |
| **Destroy When Stuck Under Water** | On, Off | Determines if the vehicle will destroy itself when it’s stuck under water. |
| **Water Destruction Timer** | Pick or enter a number | When the vehicle becomes too deep in water to drive, destroy it after the set amount of time has passed. |
| **Respawn Time** | **Instant**, Never, Pick a time | Respawns a vehicle that's been destroyed after a selected delay. |
| **Respawn Vehicle when Enabled** | **Yes**, No, Only if Needed | If this is set to **Yes**, a vehicle will spawn when the device is enabled. Choosing **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle when Disabled** | **Yes**, No | Destroys a spawned vehicle when the spawner is disabled. |
| **Enable Respawn** | *On*, Off | Determines if the vehicle will respawn after being destroyed. If set to Off, the **Respawn Time** option is not displayed. |
| **Fuel Consumption** | Off, *On* | Determines if the spawned vehicle uses fuel. If this is set to On, then the following options will display: Random Starting Fuel, and Fuel Uses Multiplier. |
| **Random Starting Fuel** | On, *Off* | Only displayed when **Fuel Consumption** is set to **On**. The percentage of fuel in the vehicle's fuel tank at spawn. **Random** will spawn the vehicle with a percentage of fuel between 25% and 80%. If this is set to **Off**, the Starting Fuel option is displayed. |
| **Starting Fuel** | On, Off | This option only displays when Fuel Consumption is set to On. Determines the amount of fuel the vehicle starts with, between 0 and 100\% of a full tank. |
| **Fuel Uses Multiplier** | 1.0, Pick a number | This option only displays when Fuel Consumption is set to On. Controls how quickly the vehicle uses fuel while driving. |
| **Activating Team** | Any, Pick or enter a team | Determines which team can use this vehicle. |
| **Allowed Class** | All, Any, No Class, Pick or enter a class ID | Determines what class can use this vehicle.  Values for this option are:   - **All**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with a class assigned can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick a class**: Pick a class identifier; only players assigned that class can use the vehicle. |
| **Visible During Game** | On, Off | Determines whether the device is visible during the game. If the device is hidden, it has no collision properties. |
| **Supports Wraps** | Enabled, Disabled | Determines whether the vehicle supports wraps. |

## Direct Event Binding

Below are the direct event binding options for this device.

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Respawn Vehicle When Receiving From** | This function respawns the vehicle when an event occurs. |
| **Destroy Vehicle When Receiving From** | This function destroys the vehicle when an event occurs. |
| **Assigns Driver When Receiving From** | This function seats the instigating player in the vehicle when an event occurs. |

### Events

An event tells another device when to perform a function.

1. For any event, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters Vehicle Send Event To** | When the player enters the vehicle, an event is sent to the selected device. |
| **On Player Exits the Vehicle Send Event To** | When the player exits the vehicle, an event is sent to the selected device. |
| **On Vehicle Spawns Send Event To** | When the vehicle is spawned, an event is sent to the selected device. |
| **On Vehicle Is Destroyed Send Event To** | When the vehicle is destroyed, an event is sent to the selected device. |
