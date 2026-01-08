# Ascender Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-ascender-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:43:57.472497

---

The **Ascender** device is a fast-moving cable mechanism that players can use to travel up or down. You can use it to:

- Provide players with a fast and exciting method of vertical travel.
- Make difficult terrain easier to traverse, particularly on islands that don't allow building.
- Give players a fast way to reach the high ground.
- Give players more tactical choices for gaining advantage over enemies.

For help on how to find the **Ascender** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

**Looking for more inspiration?** See [Ascender Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/ascender-device-design-examples-in-fortnite-creative) for some great ideas to kickstart your own island with this device!

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate. However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the phases in which the device is enabled. **Pre-Game Only** refers to any phases that occur before the game starts. |
| **Ascender Style** | **Ground**, *Wall*, Cable Only | Determines what the Ascender looks like and how it holds the cable. If you select **Wall**, an additional option displays below this one. |
| **Arm Extension Length** | **0**, Pick or enter a number | This option only displays if you select **Wall** for the **Ascender Style** option. This determines the length of the wall-mounted arm that holds the cable. Choose a number between **0** and **160**. |
| **Max Cable Length** | **70**, Pick or enter a number | This determines the length of the ascender cable. Pick a number between **3** and **1000**. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select** **Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Ascend Begin Send Event To** | When a player begins to ascend the cable, an event is sent to the selected device with the ascending player as instigator. |
| **Ascend End Send Event To** | When a player stops ascending the cable, an event is sent to the selected device, with the formerly ascending player as instigator. |
| **Descend Begin Send Event To** | When a player begins to descend the cable, an event is sent to the selected device with the ascending player as instigator. |
| **Descend End Send Event To** | When a player stops descending the cable, an event is sent to the selected device, with the formerly descending player as instigator. |
