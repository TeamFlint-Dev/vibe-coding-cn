# Rift Point Volume Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-rift-point-volume-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:30:18.520098

---

The Rift Point Volume is a large-detonation bomb that can be planted, defused and detonated in various locations around your island. **You need to use the Rift Point Device item along with this device**, as players need that item to plant the bomb.

Place the Rift Point Volume at the point where you want players to plant the bomb. Then decide on how you want the players to acquire or receive the Rift Point Device item--through event binding, an Item Granter, or some other way. During the game, the Rift Point Device item will look like the image below when they have it in their player inventory.

[![Rift Point Device item equipped](https://dev.epicgames.com/community/api/documentation/image/21eb8829-9e55-43a5-86d8-e4d0894f679e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21eb8829-9e55-43a5-86d8-e4d0894f679e?resizing_type=fit)

Rift Point Device item equipped

When the player approaches the area defined by the Rift Point Volume, they will see the Hotkey menu pop up with the control for planting the Rift Point, as shown in the image below.

[![Control displayed for planting the Rift Point](https://dev.epicgames.com/community/api/documentation/image/bc378632-1bc4-49e4-8860-1fc47e6e1901?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bc378632-1bc4-49e4-8860-1fc47e6e1901?resizing_type=fit)

Control displayed for planting the Rift Point

For help on how to find the **Rift Point Volume** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the **Customize** panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

### Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Values | Description |
| --- | --- | --- |
| **Plant Time** | **4.0 Seconds**, Pick an amount | Determines how long it takes for a player to plant the Rift Point. |
| **Defuse Time** | **7.0 Seconds**, Pick an amount | Determines how long it takes a player to defuse the Rift Point. |
| **Detonation Time** | **45.0 Seconds**, Pick an amount | Determines how long it takes for the Rift Point to detonate. |
| **Planting Team** | Any, Pick a team | Determines which team can plant the Rift Point. |
| **Defusing Team** | Any, Pick a team | Determines which team can defuse the Rift Point. |
| **Planting Class** | No Class, **Any**, Pick a class | Determines which class can plant the Rift Point. **No Class** means only players with no assigned class can defuse the Rift Point. **Any** means any player can defuse the Rift Point, regardless of class. |
| **Defusing Class** | No Class, Any, Pick a class | Determines which class can defuse the Rift Point. No Class means only players with no assigned class can defuse the Rift Point. Any means any player can defuse the Rift Point, regardless of class. |
| **Explosion Radius** | **10.0 M**, Pick a size | Distance from the Rift Point within which the detonation will do enough damage to eliminate players. |
| **Damage** | **1,000**, Pick an amount | Determines how much damage the Rift Point detonation does to players who are within the distance set in the **Explosion Radius** option. |
| **Volume Height** | 4.0 M, Pick a size | Determines the height of the volume. |
| **Volume Depth** | 5.0 M, Pick a size | This option only displays if you have selected **Box** in the **Volume Shape** option. Determines the depth of the volume. |
| **Volume Width** | **5.0 M**, Pick a size | This option only displays if you have selected Box in the Volume Shape option.  Determines the width of the volume. |
| **Volume Radius** | 5.0 M, Pick a size | This option only displays if you have selected **Cylinder** or **Sphere** in the **Volume Shape** option. Determines the radius of the volume. |
| **Volume Shape** | **Box**, *Cylinder*, *Sphere* | Determines the shape of the volume containing the explosion. Depending on which shape you pick, the options specifying the dimensions of the volume will change. |

### Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/function) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/event) tells another device when to perform a function.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Plant Started Send Event To** | When the Rift Point starts to be planted, an event is sent to the selected device, passing in the planting player. |
| **On Plant Canceled** | When the planting process is interrupted, an event is sent to the selected device passing in the planting player. |
| **On Planted Send Event To** | When the Rift Point is successfully planted, an event is sent to the selected device passing in the planting player. |
| **On Defuse Started Send Event To** | When the Rift Point starts to be defused, an event is sent to the selected device passing in the defusing player. |
| **On Defuse Canceled Send Event To** | When the defusing process is interrupted, an event is sent to the selected device passing in the defusing player. |
| **On Defused Send Event To** | When the Rift Point is successfully defused, an event is sent to the selected device passing in the defusing player. |
| **On Detonated Send Event To** | When the Rift Point detonates, an event is sent to the selected device passing in the planting player. |
| **On Agent Entered** | Sends a signal when the agent enters the volume. |
| **On Agent Exited** | Sends a signal when the agent exits the volume. |
