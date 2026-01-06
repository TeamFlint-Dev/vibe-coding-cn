# Trick Tile Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-trick-tile-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:41:44.831279

---

A **Trick Tile** is a [trap](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#trap) device that destroys the tile it's placed on when activated.

This trap can be attached to a standard floor, stairs, wall or ceiling tile. You can set it to remove the building piece it's attached to when a player steps on it, or set other conditions by using triggers. You can also set the device so that the removed tile will reset to its initial state in some conditions.

## Device Options

This device has some basic functionality, like setting an activation delay, and triggering on contact with a player. Additionally, there are some advanced options, like making some teams or players safe, or changing the activation and reset times.

When a Trick Tile is placed, it is enabled by [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#default) when the game starts, and it stays invisible. There is a two-second delay before it removes the activated tile, and during this time it bounces, with colored warning effects.

You can configure this device with the following options.

Default values are **bold**.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Activation Delay** | None, **2 seconds**, Pick an amount of seconds | Sets the amount of time between a tile being triggered, and when it is activated to remove the tile. |
| **Trigger on Player Contact** | No, **Yes** | Determines whether or not the device is triggered when a player makes contact with the attached tile. |
| **Reset After** | **Never**, Pick an amount of time | Determines whether the device resets, and if so how much time passes before the tile is restored. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled at Game Start** | No, **Yes** | Determines whether the device is enabled when the game starts. If the device is disabled, it will not respond to triggers until it is enabled. |
| **Safe Team** | Any, **None**, Pick a team number | Players on the selected team will not trigger the device when contacting the attached tile. |
| **Safe Class** | No Class, Any, **None**, Pick a class | Players with the selected class will not trigger the device. If you choose **No Class**, only players without a class will be safe. |
| **Activated at Game Start** | **No**, Yes | Determines whether or not the device is in an activated state when the game starts. If it is activated, the tile will already be removed when the game starts. |
| **Trigger Feedback** | **Bounce & Color**, Bounce Only, Color Only, None | Determines the type of feedback the device displays when it is triggered. This display will last the amount of time set in the Activation Delay option. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/function) listens for an event on a device, and then performs an action.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add**button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable when Receiving From** | If the device is disabled, it becomes enabled when receiving a signal on the selected channel. |
| **Disable when Receiving From** | If the device is enabled, it becomes disabled when receiving a signal on the selected channel. |
| **Reset when Receiving From** | Restores the removed tile when the device receives a signal on the selected channel. |
| **Trigger when Receiving From** | The device is triggered when it receives a signal on the selected channel. |
| **Enable Player Contact Trigger when Receiving From** | The **Trigger on Player Contact** option will be enabled when the device receives a signal on the selected channel. |
| **Disable Player Contact Trigger when Receiving From** | The **Trigger on Player Contact** option will be disabled when the device receives a signal on the selected channel. |
| **Toggle When Receiving From** | When an event occurs, the device is toggled between Enabled and Disabled. |
| **Toggle Player Contact Trigger When Receiving From** | When an event occurs, this toggles the **Trigger on Player Contact** option between Enabled and Disabled. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite-creative/event) tells another device when to perform a function.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Activated Send Event To** | When the device is activated (the tile is removed), an event is sent to the selected device. |
| **On Triggered Send Event To** | When triggered, an event is sent to the selected device. |

## Gameplay Examples

In the gameplay examples below, you can follow along in building a gameplay mode using Trick Tiles. These examples take advantage of the full range of options of the device.

- [Boulder Trap](https://dev.epicgames.com/documentation/en-us/fortnite/boulder-trap-gameplay-example-in-fortnite-creative)
- [Color Switch Challenge](https://dev.epicgames.com/documentation/en-us/fortnite/color-switch-challenge-gameplay-example-in-fortnite-creative)
- [Color Changing Tile Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/using-color-changing-tile-device-design-examples-in-fortnite-creative)
