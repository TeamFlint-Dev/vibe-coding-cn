# Prop Manipulator Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-manipulator-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:42:44.521921

---

With the **Prop Manipulator** device, you can customize a set of options for individual props or groups of props, just like you would [customize options](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#customize-options) for a device. You can select an area, and choose options for all props in that area. Some options include:

- Whether props in the [volume](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#volume) are visible or hidden
- The amount of [health](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#health) props in the volume have

To find the Prop Manipulator device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This device has some basic functionality, like determining whether props in the volume are hidden or shown. Additionally, there are some advanced options, like determining the priority this device has when multiple devices overlap a single device.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled At Game Start** | **On**, Off | Determines if the device is enabled at Game Start. |
| **Start Hidden** | On, **Off** | Hide or show props within this device’s volume at the start of the game. |
| **Override Resources** | *On*, **Off** | When this option is set to **On**, additional options display. Setting this option to **On** indicates that props provide resources according to this device's options rather than the prop's default behavior. |
| **Resource Node Available** | **25**, Pick an amount | This option only displays if the **Override Resources** option is set to **On**. Sets the total amount of resource available on each prop in the volume. |
| **Resource Node Given** | **1**, Pick an amount | This option only displays if the **Override Resources** option is set to **On**. Sets the amount of resource a player receives each time the prop is hit. |
| **Resource Node Type** | Wood, Stone, Metal, Gold, Item, **Do Not Override** | This option only displays if the **Override Resources** option is set to **On**. Sets the type of resource players can harvest from props affected by this device. **Do Not Override** sets the resource type to the one normally associated with the prop. |
| **Resource Node Depletion Mode** | Destroy, **Restock On Delay**, Restock Over Time, Stay Empty | This option only displays if the **Override Resources** option is set to **On**. Determines what happens to the resource mode once it is empty. If you choose **Restock On Delay**, the node will be fully stocked again after a delay. If you choose **Restock Over Time**, the node will gradually fill over a time period and will be full at the end of that time period. |
| **Resource Node Restock Time** | **15 Seconds**, Pick an amount of time | This option only displays if the **Override Resources** option is set to **On** and the **Resource Node Depletion Mode** option is set to either **Restock On Delay** or **Restock Over Time**. This sets the delay period if **Resource Node Depletion Mode** is set to **Restock On Delay**. This sets the amount of time it takes the node to gradually restock if **Resource Node Depletion Mode** is set to **Restock Over Time**. |
| **Priority** | **0**, Pick or enter a number | When multiple Prop Manipulator device zones overlap a single prop, the device with the highest Priority number take precedence. |
| **Affects All Objects In a Zone** | *On*, **Off** | If this is set to **On**, a Zone is created and the device affects all props within that zone. Additionally, three more options are displayed, that set the width, depth and height of the created zone. |
| **Zone Width (Tiles)** | **1.0**, Pick or enter a number of tiles | This option only displays if the **Affects All Objects In a Zone** option is set to **On**. Determines the width of the zone, in tiles. |
| **Zone Depth (Tiles)** | **1.0**, Pick or enter a number of tiles | This option only displays if the **Affects All Objects In a Zone** option is set to **On**. Determines the depth of the zone, in tiles. |
| **Zone Height (Tiles)** | **1.0**, Pick or enter a number of tiles | This option only displays if the **Affects All Objects In a Zone** option is set to **On**. Determines the height of the zone, in tiles. |
| **Modify Prop Health** | *Yes*, **No** | Determines if the health amount is changed for any prop manipulated by this device. Setting this option to **Yes** displays additional options. |
| **Is Prop Invulnerable** | Yes, ***No*** | Determines if the prop can be damaged or destroyed. By default, the prop can be damaged. Setting this option to **Yes** will hide the **Prop Health** option. |
| **Prop Health** | **50**, Pick an amount | This option only displays if the **Is Prop Invulnerable** option is set to **No**. Determines the amount of health a prop has. |

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
| **Show Props When Receiving From** | This function shows props within the device's volume when an event occurs. |
| **Hide Props When Receiving From** | This function hides props within the device's volume when an event occurs. |
| **Set Resource Overrides Active When Receiving From** | This function sets props in the volume as overriden resource nodes when an event occurs. |
| **Disable Resource Node Overrides When Receiving From** | This function resets the props in the volume back to their default resource behavior when an event occurs. |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Restore Health When Receiving From** | This function restores health to props controlled by this device that have not been destroyed, when an event occurs. |
| **Exhaust Resources When Receiving From** | This function completely drains all resource nodes when an event occurs. |
| **Restock Resources When Receiving From** | This function restocks all resource nodes when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Harvesting Send Event To** | When controlled props are harvested for resources, an event is sent to the selected device. |
| **On Resource Depletion Send Event To** | When a controlled prop that has resources is depleted, an event is sent to the selected device. |
| **On Damaged Send Event To** | When a controlled prop is damaged, an event is sent to the selected device. |
| **On Destroyed Send Event To** | When a controlled prop is destroyed, an event is sent to the selected device. |
