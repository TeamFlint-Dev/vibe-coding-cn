# Customizable Light Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-customizable-light-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:32:01.508663

---

The Customizable Light device can be configured in a way that might trigger seizures for people with photosensitive epilepsy.

There are three different kinds of Customizable Lights in Creative:

- **Customizable Light Device**: This is a light source that can be turned on or off by the player interacting with it, or by signals sent on channels. You can choose a **point light** or a **spotlight**. With this device, there is no associated prop (like a streetlamp or overhead light) that represents the source of the light.
- **Military Light Gallery**: This gallery is a collection of customizable lights that are integrated with props such as street lights, overhead lamps, and so on.
- **Customizable Light Gallery**: This gallery contains three customizable lights integrated with props. You can choose a torch, a spotlight, or a row of spotlights. For the row of spotlights, you can only customize one light (the rest of the row duplicates that one light).

The Military Light Gallery and Customizable Light Gallery are both found in the **Galleries** category in the Creative inventory. The **Customizable Light** device is in the **Devices** category in the Content browser. This document only documents the Customizable Light device.

To find the **Customizable Light** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

You can configure this device with the following options.

Default values are **bold**.

| Option | Values | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **All**, Pre-Game Only, Gameplay Only, Create Only | Determines in which phases the device is enabled. **Pre-Game Only** includes all phases that occur before the game starts. |
| **Initial State** | **On**, Off | Determines whether the light is on or off at the start of the game. |
| **Light Color** | **#FFFFFF**, Pick a color | Determines the color of the light shining from the device. Click the color swatch to open the Color Picker. Select a color, then click the checkmark.  [Color Picker Swatches](https://dev.epicgames.com/community/api/documentation/image/16683073-286c-4e94-8797-748d28293bcf?resizing_type=fit) |
| **Light Intensity** | **50\%**, Pick a percentage | Determines the intensity of the light, as a percentage of its maximum intensity. |
| **Light Reflection Intensity** | **100\%**, Pick a percentage | Determines the intensity of the highlights when the light reflects off shiny surfaces. |
| **Light Type** | **Point Light**, Spot Light | A **Point Light** shines from the device in all directions. A **Spot Light** shines from the device in a cone shape. |
| **Light Size** | Tiny, Small, **Medium**, Big, Huge | Determines the size of the light flare, range and amplitude. |
| **Rhythm Preset** | **Constant**, Flicker, Wave, Short Circuit, Party, Windy, Flash | Determines whether the light plays a Light Rhythm, and if so what type it plays. |
| **Rhythm Time** | **x4**, Pick a multiplier | Determines the time multiplier for the Rhythm Preset. |
| **Cast Shadows** | Yes, **No** | Determines whether the light casts shadows. Casting shadows impacts graphics performance. |
| **Dimming Amount** | **70\%**, Pick a percentage | Determines how much to dim the light when using channel controls. |
| **Dimming Time** | **1 second**, Pick an amount of time | How much time it takes, in seconds, for the dimming transition to complete. |

## Direct Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Turn On When Receiving From** | This function turns on the light when an event occurs. |
| **Reset When Receiving From** | This function resets the light when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Turn Off When Receiving From** | This function turns off the light when an event occurs. |
| **Dim Light When Receiving From** | This function dims the light when an event occurs. |
| **Undim Light When Receiving From** | This function undims the light when an event occurs. |
| **Toggle When Receiving From** | This function toggles the light off or on when an event occurs. |

### Events

This device has no events.

## Gameplay Examples Using Customizable Lights

- [Timed Door](https://dev.epicgames.com/documentation/en-us/fortnite/timed-door-in-fortnite-creative)
