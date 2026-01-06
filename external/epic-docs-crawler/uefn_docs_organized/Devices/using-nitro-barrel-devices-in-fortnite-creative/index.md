# Nitro Barrel Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-nitro-barrel-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:43:21.987262

---

The **Nitro Barrel** applies Nitro to players and vehicles around it when it is destroyed. Players can destroy it with a pickaxe, any weapon (ranged or melee) or using a vehicle. The Nitro temporarily increases the movement speed of a player or vehicle.

For help on how to find the **Nitro Barrel** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the **[Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative)**.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Start Enabled** | **On**, Off | Determines whether the Nitro barrel is visible and enabled when the game starts. |
| **Launch Force Multiplier** | **1.0**, Pick a number between 0.25 - 3.0 | Determines the multiplier applied to the amount of force when the Nitro Barrel is launched. |
| **Should Respawn** | **On**, Off | Determines whether the Nitro Barrel respawns after it has exploded. |
| **Respawn Delay** | **Instant (0)**, Pick a number between 0 - 60 | Determines how many seconds it takes for the Nitro Barrel to respawn. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable Device When Receiving From** | Enables the device when an event occurs. |
| **Disable Device When Receiving From** | Disables the device when an event occurs. |
| **Disallow Barrel Respawn When Receiving From** | When an event occurs, the barrel is not allowed to respawn. |
| **Allow Barrel Respawn When Receiving From** | When an event occurs, the barrel is allowed to respawn. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select** **Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Barrel Exploded Send Event To** | When the barrel explodes, an event is sent to the selected device which triggers the selected function. |
| **On Barrel Launched Send Event To** | When the barrel is launched, an event is sent to the selected device which triggers the selected function. |
