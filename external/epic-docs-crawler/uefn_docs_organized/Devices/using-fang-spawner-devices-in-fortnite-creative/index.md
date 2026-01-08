# Fang Spawner Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-fang-spawner-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:46:15.470148

---

Use the **Fang Spawner** to place any of three variants of the Fang car on your island. Choose which variant you want to use with the **Vehicle Type** option:

- **Nitro Fang:** Make each spawned vehicle have a random color, or set a specific color that is applied to all vehicles spawned from the device.
- **Pizza Pit Fang:** A pizza-delivery vehicle that can also be used as a getaway car.
- **Thorne's Fang:** A cool car for a tough boss!

The cars spawned from the Fang Spawner handle similarly to the Nitro Drifter sedan. They have:

- Better traction
- Higher acceleration, particularly in the lower gears
- Higher top speed than the basic sedan
- Ability to [drift](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) (engage handbrake to slide sideways while moving forward)

  For help on how to find the **Fang Spawne**r device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like choosing a visual type, and setting the car's color to be either random or a specific color. Additionally, there are some advanced options, like which teams and [classes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) can use the cars spawned by this device.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Vehicle Type** | ***Nitro Fang***, Pizza Pit Fang, Thorne's Fang | Determines what kind of Fang car spawns from this device. If you choose **Nitro Fang**, another option is displayed below this one. |
| **Color and Style** | **Random**, Pick a color | This option only displays if the **Vehicle Type** is set to **Nitro Fang**. If this is set to **Random**, each vehicle spawned will have a randomly chosen color. You can also pick a specific color that all spawned vehicles will have. |
| **Visible During Game** | **On**, Off | Determines whether the spawner is visible during the game. If this is set to **Off** the device will not have collision. |
| **Fuel Consumption** | *On*, **Off** | Determines whether the spawned vehicle uses fuel. If this is set to **On**, an additional option is displayed below this one. |
| **Random Starting Fuel** | **On**, Off | This option only displays if the **Fuel Consumption** option is set to **On**. Determines whether the spawned vehicle has a randomly selected amount of fuel. The amount will be between 25\% and 80\% of the maximum possible fuel. If this is set to **Off**, an additional option is displayed below this one. |
| **Starting Fuel** | **100**, Pick or enter an amount | This option only displays if the **Random Starting Fuel** option is set to **Off**. Determines how much fuel a vehicle has when spawned. |
| **Fuel Use Multiplier** | **1.0**, Pick an amount | Determines how quickly the vehicle uses fuel while driving. |
| **Radio Enabled** | **True**, False | Determines whether the spawned vehicle is able to use the radio. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines in which phases the device is enabled. |
| **Enable Respawn** | ***On***, Off | Determines if a vehicle is respawned after it is destroyed. If this is set to **On**, another option displays below this one. |
| **Respawn Time** | **Instant**, Pick or enter an amount | This option only displays if the **Enable Respawn** option is set to **On**. Determines the delay between a vehicle being destroyed and being respawned. |
| **Respawn Vehicle When Enabled** | No, Only If Needed, **Yes** | Determines whether a new vehicle will be spawned when the device is enabled. |
| **Destroy Vehicle When Disabled** | **On**, Off | Determines whether spawned vehicles are destroyed when the device is disabled. |
| **Activating Team** | **Any**, Pick or enter a number | Determines which teams can drive the cars spawned from this device. |
| **Allowed Class** | No Class, **All**, Any, Pick or enter a number | Determines which classes can drive the cars spawned from this device.   - **No Class**: only players with no assigned class can use cars from this device. - **All**: all players, including those with no class assigned, can use cars from this device. - **Any**: any player with an assigned class can use cars from the device. | |
| **Boost Enabled** | ***On***, Off | Determines if boost is enabled on spawned vehicles. If this is set to **On**, two additional options display below this one. |
| **Unlimited Boost** | On, **Off** | Determines if using boost consumes fuel. |
| **Boost Fuel Use** | **0.5**, Pick or enter an amount | If the **Unlimited Boost** option is set to **Off**, this determines how much fuel is used each time boost is engaged. |
| **Tire Selection** | **Road Tires**, Off-Road Tires | Determines what type of tires the vehicle spawns with. |
| **Spawn With Cow Catcher** | On, **Off** | Determines if the vehicle spawns with the Cow Catcher attached. |
| **Vehicle Indestructible** | *On*, **Off** | Determines if the vehicle can be destroyed by damage. If this is set to **Off**, another option displays below this one. |
| **Vehicle Health** | **800**, Pick or enter an amount | This option only displays if the **Vehicle Indestructible** option is set to **Off**. Determines how much damage the vehicle can take before it is destroyed. |
| **Damage Friendly Fire** | On, **Off** | If this is set to **On**, cars driven by players or AI that are friendly can damage each other when colliding. |
| **Damage Other Vehicles** | On, **Off** | If this is set to **On**, cars spawned by this device can damage other vehicles when colliding with them. |
| **Allow Damage From Other Vehicles** | On, **Off** | If this is set to **On**, other vehicles can damage cars spawned by this device when colliding with them. |
| **Damage Own Vehicle** | On, **Off** | If this is set to **On**, cars spawned from this device can be damaged by colliding with other vehicles or the environment. |
| **Max Explosion Delay** | **1.0**, Pick or enter an amount | When a car reaches zero health, this determines the maximum amount of delay before the car explodes. This does not precisely determine when the car will explode. |
| **Lifetime After Explosion** | **1.0**, Pick or enter an amount | After a car explodes, this determines the delay before the car is removed from the world. |
| **Explosion Damage to Environment** | **800**, Pick or enter an amount | Determines the amount of damage dealt to the environment when a car explodes. |
| **Explosion Damage to Players** | **800**, Pick or enter an amount | Determines the amount of damage dealt to players when a car explodes. |
| **Explosion Damage to Vehicles** | **800**, Pick or enter an amount | Determines the amount of damage dealt to other vehicles when a car explodes. |
| **Destroy When Stuck Underwater** | ***On***, Off | Determines if the car will destroy itself when it gets stuck underwater. If this is set to **On**, an additional option displays below. |
| **Water Destruction Timer** | **5.0**, Pick or enter an amount | This option only displays if the **Destroy When Stuck Underwater** option is set to **On**. Determines how long a car is stuck underwater before it destroys itself. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the Add button to add a line and repeat these steps.

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

An [event](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters Vehicle Send Event To** | When a player enters a vehicle, the spawner sends an event to the selected device, which triggers the selected function. |
| **On Player Exits Vehicle Send Event To** | When a player exits a vehicle, the spawner sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Spawns Send Event To** | When a vehicle spawns, the spawner sends an event to the selected device, which triggers the selected function. |
| **On Vehicle Is Destroyed Send Event To** | When a vehicle is destroyed, the spawner sends an event to the selected device, which triggers the selected function. |
