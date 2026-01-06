# Sports Car Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-sports-car-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:44:03.622453

---

A **Sports Car Spawner** is a device that [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) a sports car vehicle onto your island at the spawner's given location and orientation.

## Vehicle Skin Options

Players have full control over their own car [cosmetics](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#cosmetics) through their [lockers](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#locker). Any cosmetics a player is awarded or purchases for Rocket Racing is available in the player's locker. The RR vehicle will spawn with the selected car cosmetics when a player drives the vehicle.

The selected [skin](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#outfit) has no effect on the vehicle's performance.

For help on finding the **Sports Car Spawner** device, see [**Using Devices**](using-devices-in-fortnite-creative).

- Use Sports Car Spawner devices in combination with the [Race Checkpoint Device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#race-checkpoint) to design a racing game for your players.
- You can place a player directly inside the sports car using event binding.

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use italic for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

Configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) during which the device will be enabled. Pre-Game includes all phases prior to the game starting. |
| **Enable Respawn** | **On**, Off | Determines if the vehicle will respawn after being destroyed. |
| **Respawn Vehicle when Enabled** | **Yes**, No, Only if Needed | If this is set to **Yes**, a vehicle will spawn when the device is enabled. Choosing **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle when Disabled** | **On**, Off | Destroys a spawned vehicle when the spawner is disabled. |
| **Activating Team** | **Any**, Pick or enter a team | Sets the team the device belongs to. |
| **Activating Class** | No Class, **All**, Any, Pick or enter a class | Determines what class can use this vehicle.  Values for this option are:   - **All**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with a class assigned can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick or enter a class**: Pick a [class identifier](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class-identifier); only players assigned that class can use the vehicle. |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. This does affect its collision properties. |
| **Fuel Consumption** | On, **Off** | Determines if the spawned vehicle uses fuel. |
| **Boost Enabled** | **On**, Off | Determines if the vehicle can use boost. |
| **Radio Enabled** | **True**, False | Determines whether the spawned vehicle is able to use the [radio](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#radio). |
| **Color and Style** | **Random**, Pick a color and style | Choose a specific color or style option, or leave it random. |
| **Tire Selection** | **Road Tires**, Off-Road Tires | Determines the type of tires used on the spawned vehicle. |
| **Spawn With Cow Catcher** | On, **Off** | Determines whether the vehicle has the Cow Catcher equipped when spawned. |
| **Vehicle Indestructible** | On, **Off** | Determines whether the vehicle can take damage and be destroyed. |
| **Damage Friendly Fire** | **On**, Off | Determines whether friendly driven vehicles will damage each other on collision. |
| **Damage Other Vehicles** | On, **Off** | Determines whether vehicles will damage each other on collision. |
| **Allow Damage From Other Vehicles** | On, **Off** | Setting this option to **On** will allow other vehicles to damage this vehicle by colliding with it. |
| **Damage Own Vehicle** | On, **Off** | Determines whether a collision will damage the player's own vehicle. |
| **Max Explosion Delay** | **1 second**, Instant, Pick or enter a delay time | The maximum time the vehicle can have zero health, after which it will explode. |
| **Lifetime After Explosion** | **1 second**, Pick or enter a duration | The duration in seconds that the destroyed vehicle will remain in the world, after which it is removed entirely. |
| **Explosion Damage to Environment** | **800**, Pick or enter an amount of damage | The amount of damage dealt to environment objects when the vehicle explodes. |
| **Explosion Damage to Players** | **800**, Pick or enter an amount of damage | The amount of damage dealt to players when the vehicle explodes. |
| **Explosion Damage to Vehicles** | **800**, Pick or enter an amount of damage | The amount of damage dealt to other vehicles when the vehicle explodes. |
| **Destroy When Stuck Underwater** | **On**, Off | Determines if the vehicle is destroyed when it is too deep in water to drive. |
| **Vehicle Speed Tunings** | **Ch 4 Battle Royale**, Current Battle | Determines which speed tunings are used for vehiles spawned by this device. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these step

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Respawn Vehicle When Receiving From** | Spawns a new vehicle when an event occurs. The existing vehicle will be destroyed before a new vehicle spawns. |
| **Destroy Vehicle When Receiving From** | Destroys the spawned vehicle when an event occurs. |
| **Assigns Driver When Receiving From** | Sets the [instigating](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#instigator) player as the driver when an event occurs. |
| **Apply Off Road Tires When Receiving From** | Applies off-road tires to the spawned vehicle when an event occurs. |
| **Remove Tire Modification When Receiving From** | Reverts the vehicle to road tires when an event occurs. |
| **Pop All Tires When Receiving From** | Pops all tires on the spawned vehicle when an event occurs. |
| **Repair All Tires When Receiving From** | Repairs all tires on the spawned vehicle when an event occurs. |
| **Repair Vehicle When Receiving From** | Repairs all damage to a vehicle when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Player Enters Vehicle Send Event To** | Sends an event when a player enters the spawned vehicle. |
| **On Player Exits Vehicle Send Event To** | Sends an event when a player exits the spawned vehicle. |
| **On Vehicle Spawns Send Event To** | Sends an event when a vehicle is spawned or respawned. |
| **On Vehicle is Destroyed Send Event To** | Sends an event when a vehicle is destroyed. |
