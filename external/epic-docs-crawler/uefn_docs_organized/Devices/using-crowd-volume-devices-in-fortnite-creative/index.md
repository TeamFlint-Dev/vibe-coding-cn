# Crowd Volume Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-crowd-volume-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:48:02.258523

---

The **Crowd Volume** device spawns a group of [NPCs](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) that you can use for crowd scenes, concert audiences, or anywhere else you want a group of NPCs focused on a particular event. Create a race game and put cheering crowds in the stands, or a musical experience using this device to pack the audience.

This device can also improve island performance by generating a crowd without the need for placing individual characters.

  To find the Crowd Volume device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

This device has some basic functionality, like choosing the crowd density, and the size of the volume. Additionally, there are some advanced options, like making the size and facing direction of characters vary randomly.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Character Angle Randomness** | **0%**, Pick a percentage | If you want characters in the volume to randomly face different directions, this determines to what degree the character angle deviates from the direction the device is facing. |
| **Character Scale Randomness** | **0%**, Pick a percentage | If you want the characters in the volume to vary in size, this determines to what degree the size of each character deviates from the normal size. |
| **Crowd Density** | **100%**, Pick or enter a percentage | Determines how full the volume is with characters. |
| **Character Alignment** | **100%**, Pick or enter a percentage | Determines how precisely spawned characters are aligned on a grid. |
| **Zone Width** | **1 Tile**, Pick or enter a number | Determines the width of the zone, in tiles. |
| **Zone Depth** | **1 Tile**, Pick or enter a number | Determines the depth of the zone, in tiles. |
| **Zone Height** | **1 Tile**, Pick or enter a number | Determines the height of the zone, in tiles. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) when the device is enabled. **Pre-Game Only** includes all phases prior to the game starting. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. Select the device and event that will enable the device. If more than one device or event can enable the device, you can click the **Add** button for this option, which adds another line. |
| **Disable When Receiving From** | This function disables the device when an event occurs. Select the device and event that will disable the device. If more than one device or event can disable the device, you can click the **Add** button for this option, which adds another line. |

### Events

This device has no events.
