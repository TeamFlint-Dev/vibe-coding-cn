# Armored Transport Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-armored-transport-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:36:06.547516

---

The Armored Transport Spawner gives you an armored truck, similar to what security companies use to move money from customers to banks. Spawned armored transports contain an embedded vault that works similarly to the Bank Vault device.

The armored transport can be driven by both players and AI characters, such as those created by Guard Spawner and NPC Spawner devices. The armored transport drives similarly to the Big Rig semi-truck vehicle, and holds a driver and one passenger.

Other things to keep in mind with this vehicle and its embedded vault:

- You can determine which teams and classes are able to drive the armored transport, and which are able to break open the vault.
- You can use most of the standard vehicle options to customize things like:

  - How much damage the vehicle does when it collides with players, other vehicles, or the environment
  - Whether the vehicle is destroyed when stuck underwater
  - Whether the vehicle spawns with modifications
- You can determine whether your players need thermite to interact with the vault, or not.
- You can manipulate the vault through functions and events.
- You can manipulate the difficulty for opening the vault by increasing or decreasing the weakpoints' health, whether weapons can damage the weakpoints, and how quickly the weakpoints passively lose health.

For help with finding the **Armored Transport Spawne**r device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering In Creative

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in italic.All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the **Description** field for that option.Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Values | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the game phases during which the device will be enabled. **Pre-Game** includes all phases prior to the start of the game. |
| **Enable Respawn** | ***On***, Off | Determines if the vehicle respawns after being destroyed. If this is set to **On**, an additional option displays below this one. |
| **Respawn Time** | **Instant**, Pick or enter an amount | In Creative, this option only displays if the **Enable Respawn** option is set to **On**. Determines the delay after a vehicle is destroyed, before it respawns. |
| **Respawn Vehicle When Enabled** | No, Only If Needed, **Yes** | If this is set to **Yes**, a vehicle will spawn a vehicle when the device is enabled. **Only if Needed** will not reset an existing vehicle. |
| **Destroy Vehicle When Disabled** | **On**, Off | Destroys a spawned vehicle when the device is disabled. |
| **Allowed Class** | No Class, **All**, Any, Pick or enter a number | Determines what class can use this vehicle. Values for this option are:   - **All**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with a class assigned can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick or enter a number**: Pick a class identifier; only players assigned that class can use the vehicle. |
| **Visible During Game** | **On**, Off | Determines whether the vehicle is visible during the game. This does affect its collision properties. |
| **Fuel Consumption** | On, **Off** | Determines if the spawned vehicle uses fuel. If this is set to On is selected, two additional options are displayed. |
| **Random Starting Fuel** | ***On***, Off | In Creative, this option only displays if the **Fuel Consumption** option is set to **On**. If this option is set to **On**, the vehicle spawns with a random amount of fuel, between 25% and 80% of the maximum amount, and two additional options display below this one. If this is set to Off, an additional option displays below this one. |
| **Min Random Starting Fuel** | **0**, Pick an amount | In Creative, this option only displays if the **Random Starting Fuel** option is set to **On**. Determines the minimum random fuel percentage the vehicle spawns with. |
| **Max Random Starting Fuel** | **0**, Pick an amount | In Creative, this option only displays if the Random Starting Fuel option is set to On. Determines the maximum random fuel percentage the vehicle spawns with. |
| **Starting Fuel** | **100**, Pick a percentage | In Creative, this option only displays if the **Fuel Consumption** option is set to **On** and the Random Starting Fuel option is set to **Off**.  The percentage of fuel in the tank at spawn based on total capacity. **100** means that the tank is full. |
| **Fuel Use Multiplier** | **1.0**, Pick or enter a number | In Creative, this option only displays if the **Fuel Consumption** option is set to **On**. Determines how quickly the vehicle uses fuel while driving. |
| **Boost Enabled** | ***On***, Off | Determines whether boost is enabled on the vehicle. If this is set to **On**, additional options display. |
| **Unlimited Boost** | On, ***Off*** | In Creative, this option only displays if the **Boost Enabled** option is set to **On**. Determines whether boost uses fuel. If this is set to **Off**, an additional option displays. |
| **Boost Fuel Use** | **0.5**, Pick or enter a number | In Creative, this option only displays if the **Fuel Consumption** and **Boost Enabled** options are set to **On**. Controls how quickly the vehicle uses fuel while boosting. |
| **Boost Regen Multiplier** | **Default**, Pick or enter a number | In Creative, this option only displays if the **Boost Enabled** option is set to **On**. If boost is enabled, this determines how quickly the boost meter fills. |
| **Radio Enabled** | **True**, False | Determines whether the spawned vehicle is able to use the radio. |
| **Spawn with Cow Catcher** | On, **Off** | Determines whether the spawned vehicle has a cow catcher. |
| **Vehicle Indestructible** | On, Off | Sets whether the spawned vehicle can be damaged or destroyed. |
| **Vehicle Health** | **800**, Pick a number | In Creative, this option only displays when **Vehicle Indestructible** is set to **Off**. Determines how much damage the vehicle can take before it is destroyed. |
| **Damage Friendly Fire** | On, **Off** | Setting this option to **On** means friendly vehicles can damage this device's spawned vehicles when they collide. |
| **Damage Other Vehicles** | On, Off | Setting this option to **On** means this device's spawned vehicles can damage other vehicles when they collide. |
| **Allow Damage from Other Vehicles** | On, **Off** | Determines whether other vehicles cause damage when colliding with vehicles spawned by this device. |
| **Damage Own Vehicle** | On, Off | Determines whether a collision caused by the driver will damage the spawned vehicle. |
| **Max Explosion Delay** | **1.0**, Instant, Pick a delay time | Determines the maximum amount of seconds the vehicle has zero health, before it explodes. |
| **Lifetime After Explosion** | **1.0**, Instant, Pick an amount of time | Determines how long the destroyed vehicle remains in the world after it explodes, before it is removed. |
| **Explosion Damage to Environment** | **800**, None, Pick an amount of damage | Determines the amount of damage a spawned vehicle deals to environment objects when it explodes. |
| **Explosion Damage to Players** | 800, None, Pick an amount of damage | Determines the amount of damage a spawned vehicle deals to players when it explodes. |
| **Explosion Damage to Vehicles** | **800**, None, Pick an amount of damage | Determines the amount of damage a spawned vehicle deals to other vehicles when it explodes. |
| **Destroy When Stuck Underwater** | ***On***, Off | Determines whether the vehicle destroys itself when it is stuck underwater. By default, this is set to **On**, and the **Water Destruction Time**r option is displayed. If you choose **Off**, the **Water Destructions Timer** option is not displayed. |
| **Water Destruction Timer** | **5.0 seconds**, Pick or enter an amount of time | In Creative, this only displays if the **Destroy When Stuck Underwater** option is set to **On**. When the vehicle is stuck underwater, this is the amount of time before it destroys itself. |
| **Spawn with Vault** | **Yes**, No | Determines if the vehicle has a vault onboard when it spawns. |
| **Activating Team** | **Any**, Pick a team | Determines the team this vehicle spawner belongs to. |
| **Allow Driving with Ready Vault** | Yes, **No** | Determines if players are allowed to drive the vehicle while the Vault is ready to be interacted with.  If too many vehicles are driving with ready Vaults, it can cause lag. |
| **Invulnerable While Active** | **Yes**, No | Determines if the vehicle is invulnerable when the Vault is active. |
| **Spawn With Vault Enabled** | Yes, **No** | By default, the Vault is not enabled when the vehicle spawns. If this is set to Yes, spawned vehicles will have the Vault active and ready to be interacted with. |
| **Loot Pool Reset** | Small, Medium, **Large** | If you are using the default loot pool, this determines what size loot pool will drop from the Vault. |
| **Requires Thermite** | **On**, Off | Determines if the player needs to have thermite when interacting with the Vault door to start the vault-opening process. |
| **Weakpoint Passive Damage Per Second** | **Don't Overrid****e**, 0, Pick or enter an amount | Determines how much damage the vault's weakpoints take each second. If set to the default **Don't Override**, the damage per second will start low and increase over time. |
| **Weakpoint Health** | **750.0**, Pick or enter an amount | Determines how much damage a weakpoint can take before being destroyed and activating the next weakpoint. |
| **Weakpoints Take External Damage** | On, Off | Determines if weakpoints take damage from weapons or items. |
| **Number of Weakpoints** | **5**, Pick an amount | Determines how much damage a weakpoint can take before being destroyed and activating the next weakpoint. |
| **Vault Interacting Team** | **Any**, Pick a team | Determines which team can interact with the device. |
| **Invert Vault Interacting Team Selection** | On, **Off** | If this is set to **On**, all teams except the team selected in the **Vault Interacting Team** option can interact with the device. |
| **Vault Interacting Class** | No Class, All, **Any**, Pick a class | Determines which class can interact with the device. **No Class** means only players with no assigned class can interact. **All** means all players can interact regardless of class. **Any** means any player with an assigned class can interact. |
| **Invert Vault Interacting Class Selection** | On, Off | If this is set to **On**, all classes except the class selected in the **Vault Interacting Class** option can interact with the device. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

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
| **Force Vault Open When Receiving From** | Destroys the remaining weakpoints and opens the vault when an event occurs. |
| **Activate Vault Door When Receiving From** | Begins the vault opening sequence without thermite when an event occurs. |
| **Deactivate Vault Door When Receiving From** | Disables the weakpoint vulnerability and freezes the progress on all of them when an event occurs. |
| **Reset Vault When Receiving From** | Resets the vault when an event occurs. |
| **Enable Vault When Receiving From** | Enables the device when an event occurs. |
| **Disable Vault When Receiving From** | Disables the device when an event occurs. |
| **Destroy Current Weakpoint When Receiving From** | Destroys the currently active weakpoint when an event occurs. |
| **Restore Current Weakpoint Health When Receiving From** | Restores the health of the currently active weakpoint when an event occurs. |

### Events

An event tells another device when to perform a function.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Options | Description |
| --- | --- |
| **On Player Enters the Vehicle** | When a player enters the spawned vehicle, an event is sent to the selected device, which triggers the selected function. |
| **On Player Exits the Vehicle** | When a player exits the spawned vehicle, an event is sent to the selected device, which triggers the selected function. |
| **On Vehicle Spawns** | When a vehicle spawns or respawns, an event is sent to the selected device, which triggers the selected function. |
| **On Vehicle Is Destroyed** | When the spawned vehicle is destroyed, an event is sent to the selected device, which triggers the selected function. |
| **On Vault Sequence Started Send Event To** | When the vault sequence is started by a player or event, an event is sent to the selected device. |
| **On Vault Opened Send Event To** | When the vault is opened, an event is sent to the selected device. |
| **On Weakpoint Activated Send Event To** | When a weakpoint becomes active, an event is sent to the selected device. |
| **On Weakpoint Vulnerable Send Event To** | When a weakpoint becomes vulnerable (such as after being frozen), an event is sent to the selected device. |
| **On Weakpoint Destroyed Send Event To** | When a weakpoint is destroyed, an event is sent to the selected device. |
