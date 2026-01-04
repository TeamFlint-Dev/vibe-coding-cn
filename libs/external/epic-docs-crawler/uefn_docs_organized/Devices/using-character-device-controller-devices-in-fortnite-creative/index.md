# Character Device Controller Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-character-device-controller-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:46:32.075747

---

**Character Device Controllers** can change a group of [Character devices](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to use the same [outfits](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), have matching poses and animations, and have identical [emotes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Use the same slot settings for multiple [Character devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-character-devices-in-fortnite-creative), then associate that slot on the Character Device Controller. Each Character Device Controller can control a different group, so you can create multiple groups of Character devices, with each group looking or acting differently from the other groups.

You can also use multiple Character Device Controllers with one Character device if you want the character to look different or perform different emotes in response to events in the game.

For help finding the Character Device Controller device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

## Device Options

This device has some basic functionality, like setting the Character outfit, the pose, or the emote. There are also advanced options, like setting the Character Slot number associated with this device.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Character** | **Creative Mannequin**, Pick a character | When this device is triggered, it sets all associated Character devices to this character. You can choose from over 100 different characters. |
| **Idle (Pose)** | **Jazz Hands 1**, Pick a pose | When triggered, it sets all associated Character devices to this idle pose. |
| **Idle (Animated)** | **Cry**, Pick an animation | When triggered, it sets all associated Character devices to to perform this idle animation. This option only works if the associated Character devices have the **Use Animated Idle** option set to **Yes**. See [Character Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-character-devices-in-fortnite-creative) for more info. |
| **Emote** | **Sit in Chair**, Pick an emote | When this device is triggered, it sets all associated Character devices to perform this emote. |
| **Character Slot** | **0**, Pick a slot | Determines which Character Slot this device controls. All Character devices that are assigned this slot will be affected by this device. Any Character devices that are assigned to different slots will not be affected. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Change Character Appearance When Receiving From** | Changes the character's appearance when an event occurs. |
| **Perform Emote When Receiving From** | Characters controlled by this device perform an emote when an event occurs. |
| **Change Character Idle (Pose) When Receiving From** | Changes the character's idle pose when an event occurs. |
| **Change Character Idle (Animation) When Receiving From** | Changes the character's idle animation when an event occurs. |
| **Reset Characters When Receiving From** | Reset all Characters that are assigned to this device's Character Slot when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

This device currently has no events.
