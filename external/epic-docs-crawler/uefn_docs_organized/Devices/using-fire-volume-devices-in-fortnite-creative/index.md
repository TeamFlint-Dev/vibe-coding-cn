# Fire Volume Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-fire-volume-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:37:43.881491

---

The **Fire Volume** device specifies where things can be set on fire. You can use this to limit which objects, terrain, or buildings can be set on fire and which can't. You can also ignite or extinguish fires in this [volume](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) using channels. This device can override [My Island settings](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to create specific areas where fires are allowed or not allowed.

  To find the **Fire Volume** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

This device has some basic functionality, like whether the zone is visible, and setting the size of the volume. Additionally, there are some advanced options, like whether or not objects in the volume can be ignited.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled at Game Start** | **Yes**, No | Determines whether the device is automatically enabled when the game starts. |
| Zone Visible During Game | No, Yes | Determines whether the device's zone is visible to players during the game. If it is visible, a particle effect similar to embers will display in the zone. |
| Zone Width | 1, Pick a size | Determines the width of the volume in tiles. |
| Zone Depth | 1, Pick a size | Determines the depth of the volume in tiles. |
| Zone Height | 1, Pick a size | Determines the height of the volume in tiles. |
| Allow Objects to Ignite | Use Island Settings, Yes, No | The default value uses the Island Settings to determine whether objects can ignite. This option can be set to Yes or No to override the  sland settings. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event and select the event that triggers this function.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | The device is enabled when an event occurs. |
| **Disable When Receiving From** | The device is disabled when an event occurs. |
| **Ignite When Receiving From** | Objects inside the volume are ignited when an event occurs. |
| **Extinguish When Receiving From** | Objects on fire inside the volume are extinguished when an event occurs. |

### Events

This device has no events.
