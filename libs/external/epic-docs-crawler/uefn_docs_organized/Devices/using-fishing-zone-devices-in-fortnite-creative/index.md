# Fishing Zone Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-fishing-zone-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:48:15.525279

---

Fortnite Creative is converting many devices in the Fortnite Creative toolset to improve user experience across devices. These improvements include things like a better way for selecting colors or numeric values, more options for better device control and customization, and, for some devices, new functionality!

Currently, a public beta version of the upgraded devices is available for you to try. You can opt into using the beta toolset with both existing islands and new experiences. To learn how to implement the changes, refer to the [Upgrade Devices section](https://dev.epicgames.com/documentation/en-us/fortnite/using-fishing-zone-devices-in-fortnite-creative) at the bottom of the document.

The **Fishing Zone** device provides a way for creators to add various fishing elements to their games, such as:

- Fishing competitions between players
- Collecting fish as a resource
- A fun [minigame](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) with its own rewards

You can place a fishing pool in water, or you can place it in more unusual places like an artificial container or in lava. You can drop [items](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) onto the device, similar to an [Item Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) or [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), so players can catch things besides fish.

To find the Dirt Bike Spawner device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device creates an area in the water (or in other areas) populated with fish and other items that the player can catch using a fishing pole. You can configure this device with the following options.

Default values are **bold**.

### Basic Options

| Option | Value | Description |  |
| --- | --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Enables the device during a specific phase. **Pre-Game Only** refers to all phases that occur before the game starts. |  |
| **Usage Type** | **Infinite**, Battle Royale, *Limited* | Determines how many times the Fishing Zone can be used before it is disabled,depending on the type. If you choose **Battle Royale**, the device's behavior matches the behavior in the current Battle Royale. If you choose **Limited**, another option displays below this one. |  |
| **Number of Uses** | **1**, Pick or enter a number | This option only displays if the **Usage Type** option is set to **Limited**. Determines how many times the zone can be used before it is disabled. |  |
| **Pool Type** | **Battle Royale**, *Device Inventory*, Trigger Only, Fish Only | Determines the type of fishing pool this is, and what loot can be gained from it. If you choose **Device Inventory** another option displays.  Values for this option are:   - **Battle Royale**: Zone uses the current Battle Royale loot pool. - **Device Inventory**: Loot is determined by the items you drop onto the device when editing your island. - **Trigger Only**: No loot spawned, but sends the **On Caught** event. - **Fish Only**: Only fish spawn from this zone. |  |
| **Zone FX** | **On**, Off | Determines whether the zone has water visual FX. |  |
| **Disable When Empty** | On, **Off** | This option only displays if the **Pool Type** option is set to **Device Inventory**. Determines whether the device is [disabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) when all items have been caught. |  |
| **Extra Ammo** | On, **Off** | Determines whether the device grants extra ammunition when a weapon is caught. |  |
| **Remove Caught Items** | On, **Off** | This option only displays if the **Pool Type** option is set to **Device Inventory**. Determines whether caught items are removed from the pool inventory. |  |
| **Offset to Water** | **On**, Off | Determines if the device will attempt to intersect any nearby Water volumes. |  |
| **Ripple FX** | **On**, Off | Determines if the zone has a water ripple visual effect. |  |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Restock When Receiving From** | If the pool type is set to **Device Inventory**, this function restocks the device inventory when an event occurs. |
| **Reset Uses When Receiving From** | Resets the **Number of Uses** option when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to choose a function that is triggered by the event.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Caught Send Event To** | When a fish is caught, an event occurs. |
| **On Empty Send Event To** | When all items have been caught and removed, an event occurs. |
