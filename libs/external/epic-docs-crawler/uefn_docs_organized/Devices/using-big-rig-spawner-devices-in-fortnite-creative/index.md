# Big Rig Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-big-rig-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:49:10.322287

---

A **Big Rig Spawner** is a device that [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a semi truck onto an island at the spawner's given location and orientation.

Use Big Rig Spawner devices in combination with [Race Checkpoint devices](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to design a racing game worthy of open freeways.

Place a player directly inside the Mudflap at any point in the game using a [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative).

**Looking for a fun idea?** See **[Big Rig Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/big-rig-device-design-example-in-fortnite-creative)** to jumpstart your imagination!

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

  To find the **Big Rig Spawner** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).  Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) during which the device will be enabled. Pre-game includes all phases prior to the game starting, including waiting for other players in the lobby and the countdown to start of game. |
| **Enable Respawn** | **On**, Off | Determines whether the vehicle will respawn after it is destroyed. |
| **Respawn Time** | **Instant (0.0)**, Pick a time between .25 and 300 seconds | If Respawn is enabled, determines the interval between destruction and respawning. |
| **Respawn Vehicle when Enabled** | **Yes**, No, Only if Needed | If this is set to **Yes**, a vehicle will spawn when the device is enabled. Choosing **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle when Disabled** | **On**, Off | Destroys a spawned vehicle when the spawner is disabled. |
| **Activating Team** | **Any**, Pick a number | Set the team this vehicle belongs to. |
| **Allowed Class** | No Class, **All**, Any, Pick a number between 1 and 16 | Determines what class can use this vehicle. Values for this option are:   - **All**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with an assigned class can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick a class**: Pick a numeric class identifier; only players assigned that class can use the vehicle. |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. If set to **Off**, the device has no collision. |
| **Fuel Consumption** | On, **Off** | Determines whether the vehicle uses fuel. Setting this to **Off** means the vehicle has infinite fuel. If this option is set to **On**, additional options display below this one. |
| **Random Starting Fuel** | **On**, Off | This option only displays when **Fuel Consumption** is set to **On**. Randomly selects a value between 25 and 80 percent of a full tank and assigns that much fuel to the vehicle when it spawns. |
| **Starting Fuel** | **On**, Off | This option only displays when **Fuel Consumption** is set to **On**. Determines the amount of fuel the vehicle starts with, between 0 and 100\% of a full tank. |
| **Fuel Use Multiplier** | **1.0**, Pick a number | This option only displays when **Fuel Consumption** is set to **On**. Controls how quickly the vehicle uses fuel while driving. |
| **Boost Enabled** | **On**, Off | This option only displays if the **Fuel Consumption** option is set to **On**. |
| **Unlimited Boost** | On, **Off** | This option only displays when **Boost Enabled** is set to **On**. Determines whether using Boost consumes fuel. |
| **Boost Fuel Use** | **0.5**, Pick a number | This option only displays when **Boost Enabled** is set to **On**. Controls how quickly the vehicle uses fuel while [boosting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |
| **Radio Enabled** | **True**, False | Determines whether the spawned vehicle is able to use the [radio](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |
| **Color and Style** | **Random**, Pick a color | Choose a color option or leave it random. |
| **Tire Selection** | **Road Tires**, Off-Road Tires | Determines the type of tires the spawned vehicle has. |
| **Spawn With Cow Catcher** | On, **Off** | Determines whether the vehicle has the Cow Catcher equipped when spawned. |
| **Vehicle Indestructible** | **Off**, On | Sets whether the spawned vehicle can be damaged or destroyed. |
| **Vehicle Health** | **1200**, Pick a number | This option only displays when **Vehicle Indestructible** is set to **Off**. Determines how much damage the vehicle can take before it is destroyed. |
| **Damage Friendly Fire** | **On**, Off | Setting this option to **On** means friendly vehicles can damage this device's spawned vehicles when they collide. |
| **Allow Damage from Other Vehicles** | On, **Off** | Determines whether other vehicles cause damage when colliding with vehicles spawned by this device. |
| **Damage Own Vehicle** | On, **Off** | Determines whether a collision caused by the driver will damage the spawned vehicle. |
| **Max Explosion Delay** | **1 second**, Instant, Pick a delay time | Determines the maximum time the vehicle has zero health, before it explodes. |
| **Lifetime After Explosion** | **1 second**, Instant, Pick a duration | Determines how long the destroyed vehicle remains in the world after it explodes, before it is removed. |
| **Explosion Damage to Environment** | **800**, None, Pick an amount of damage | Determines the amount of damage a spawned vehicle deals to environment objects when it explodes. |
| **Explosion Damage to Players** | **800**, None, Pick an amount of damage | Determines the amount of damage a spawned vehicle deals to players when it explodes. |
| **Explosion Damage to Vehicles** | **800**, None, Pick an amount of damage | Determines the amount of damage a spawned vehicle deals to other vehicles when it explodes. |
| **Boost Regen Multiplier** | **10.0**, select a value | Sets how quickly the boost meter fills. |

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
