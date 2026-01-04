# Fuel Pump Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-fuel-pump-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:45:04.937730

---

A **Fuel Pump** device is a way to provide a fuel source for vehicles. They can also be used to deal considerable damage to players and the environment when destroyed.

These devices can provide infinite amounts of fuel, or have a limited amount of fuel available.

You can set the device to be indestructible during gameplay, or deal damage to a certain team or [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) of player. For example:

- In racing games, players can refuel their cars like drivers do in Nascar or the Grand Prix.
- For team matches or games that use classes, players can have their own fuel pumps.
- In [skillrun](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) games, players have to complete a task before they can use the device.

For help on how to find the **Fuel Pump** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, any values that trigger contextual filtering are in *italic*. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like choosing whether to provide players with infinite fuel, or whether the pump can be destroyed by weapons and collisions. Additionally, there are advanced options that you can use to determine which teams or class of players can access the device and which teams or classes are affected by the device.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Infinite Fuel** | **On**, *Off* | Determines if the vehicle has unlimited fuel. If this is set to **Off**, another option displays below this one. |
| **Fuel Capacity** | **1000**, Pick an amount | This option only displays if the **Infinite Fuel** option is set to **Off**. This sets the maximum amount of fuel that the pump can contain. |
| **Indestructible** | **Yes**, *No* | Determines whether the device can take damage and be destroyed. If you set this to **No**, another options is displayed below this one. |
| **Health** | **5**, Pick or enter an amount | This option only displays if the **Indestructible** option is set to **No**. Determines how much damage the Fuel Pump can receive before it is destroyed. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Explosion Deals Damage** | **Yes**, No | Determines whether the pump deals damage and spreads fire if it explodes. |
| **Enabled At Game Start** | **Enabled**, Disabled | Determines whether this device is enabled when the game is started. This option is used with transmitter and receiver channel options. |
| **Allowed Team** | None, **All**, Pick or enter a team | Determines which team can activate the device. |
| **Invert Team Selection** | On, **Off** | If this is set to **On**, all teams can activate the device except the one selected in the **Allowed Team** option. |
| **Selected Class** | No Class, **Any**, Pick or enter a class | Players with the selected class assigned can activate the device. If you choose **No Class**, only players who are not assigned a class can activate it. If you choose **Any**, all players with an assigned class can activate it. |
| **Invert Class Selection** | On, **Off** | If this is set to **On**, all classes can activate the device except the one selected in the **Selected Class** option. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, making your workflow more intuitive, and giving you more freedom to focus on your design ideas.

Below are the functions and events for this device.

### Functions

Direct event binding uses functions as receivers. A function listens for one device's event to tell another device to perform a function.

| Option | Select Device | Select Event | Description |  |
| --- | --- | --- | --- | --- |
| **Enable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function enables the device when an event occurs. | This function enables the device when an event occurs. |
| **Disable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function enables the device when an event occurs. | This function disables the device when an event occurs. |
| **Empty When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function enables the device when an event occurs. | This function empties the fuel pump when an event occurs. |
| **Restock Fuel When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function enables the device when an event occurs. | This function restocks the fuel pump when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

| Option | Select Device | Select Function | Description |
| --- | --- | --- | --- |
| **On Empty Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When the fuel pump is emptied, an event is sent to the selected device, which triggers the selected function. |
