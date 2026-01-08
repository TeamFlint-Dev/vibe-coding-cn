# Placeable Ledge Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-placeable-ledge-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:42:15.411216

---

**Ledge launching** is a variation of mantling. While [mantling](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#mantle) is a way to scale a vertical or almost vertical surface, ledge launching is a way a player can push off from a suspended horizontal surface.

**Player-built walls**, or **PBWs**, can be used to ledge launch if the **PBWs Generate Ledges** setting is set to **On** under **[Player Settings](https://dev.epicgames.com/documentation/en-us/fortnite/player-settings-in-fortnite-creative)**.

With the **Placeable Ledge** device, you have the option of placing ledge-launching devices on any surface, or even placing them midair, whether or not the island setting for **PBWs Generate Ledges** is enabled. **Allow Mantling** must be enabled for it to work.

Once placed, a player can mantle to the ledge, then launch off by holding down the **Jump** button.

You can place the Placeable Ledge device anywhere, but it makes the most sense to place it against a wall or other vertical surface.

For help on how to find the Placeable Ledge device, see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

Before placing the device, go to the **Quick Menu** (press the **B** key) and make sure that under **Object Placement**, **Drops** is set to **Off**.

[![Set Drops to Off on the Quick Menu.](https://dev.epicgames.com/community/api/documentation/image/5c9314a6-96f9-4c16-b51d-67215ec37a75?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c9314a6-96f9-4c16-b51d-67215ec37a75?resizing_type=fit)

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the **[Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative)**.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the **Customize** panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering. If they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

If you are using this device with UEFN, you can also use a custom mesh to determine the visual style of the ledges.

| Option | Value | Description |
| --- | --- | --- |
| **Enable During Game** | **On**, Off | Determines if the ledge is enabled and visible during the game. |
| **Ledge Mesh Selection** | **Wood Beam**, Metal Ring | Determines the visual style of the ledge. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Enable When Receiving From** | Enables the device when an event occurs. |

### Events

This device has no events.
