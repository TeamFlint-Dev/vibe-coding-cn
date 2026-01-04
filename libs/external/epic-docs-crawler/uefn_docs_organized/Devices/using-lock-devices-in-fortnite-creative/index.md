# Lock Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:46:54.560979

---

The **Lock** device allows you to customize the state and accessibility of a door using signals sent by other devices. This device only works with assets that have a door attached.

## Device Options

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Initial Door Position** | Open, **Closed** | Determines whether the door is open or closed at Game Start. |
| **Visible in Game** | **On**, Off | Determines whether or not the lock is visible in the game. |
| **Color** | **White**, Pick a color | Changes the color of the device to help players tell them apart. |
| **Starts Locked** | Unlocked, **Locked** | Determines whether the door is locked or unlocked at the start of the game. |
| **Hide Interaction When Locked** | Yes, **No** | Determines whether or not the player can see the interaction prompt when the door is locked. |

## Direct Event Binding

Below are the following direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Unlock When Receiving From** | This function unlocks the door when an event occurs. |
| **Lock When Receiving From** | This function locks the door when an event occurs. |
| **Toggle Locked When Receiving From** | This function toggles the lock between locked and unlocked when an event occurs. |
| **Open When Receiving From** | This function opens the door when an event occurs. |
| **Close When Receiving From** | This function closes the door when an event occurs. |
| **Toggle Open When Receiving From** | This function toggles the door between open and closedwhen an event occurs. |

### Events

This device has no events.

## Gameplay Examples Using Locks

- [Dungeon Crawler](https://dev.epicgames.com/documentation/en-us/fortnite/dungeon-crawler-gameplay-example-in-fortnite-creative)
- [Timed Door](https://dev.epicgames.com/documentation/en-us/fortnite/timed-door-in-fortnite-creative)
