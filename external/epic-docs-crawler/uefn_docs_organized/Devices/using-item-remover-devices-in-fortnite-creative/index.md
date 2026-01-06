# Item Remover Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-item-remover-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:31:19.078483

---

The **Item Remover** gives gives you the ability to designate events in your games that will cause players to [drop](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#drop) or lose items from their [inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#inventory). For example, if a player is [Down But Not Out](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#down-but-not-out), they could drop items from their inventory, and other players could then pick up those items.

To find the Item Remover device, see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

**Looking for more inspiration?** See the [Item Remover Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/item-remover-device-design-example-in-fortnite-creative) to kick off your imagination!

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **All**, Pre-Game Only, Gameplay Only | Determines the [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) in which the device is enabled. **Pre-Game** includes all phases that occur before the game starts. |
| **Affected Objects** | All Objects, Building Materials, World Resources, **Objects in Device**, Weapons and Items, Weapons, Items | Determines what items in the player's inventory are considered for removal. |
| **Amount to Remove** | **Amount in Device**, *Percentage* | Determines the amount of affected items that are removed from the player. If you choose **Percentage**, an additional option displays. |
| **Percentage to Remove** | **100%**, Pick a percentage | This option only displays if the **Amount to Remove** option is set to **Percentage**. Determines the percentage of a player's affected items that are removed. |
| **Removal Method** | **Remove Items**, Drop Items, Drop Items On Previous Ground Location | Determines how items are removed. If you choose **Remove Items**, the items are removed from the player's inventory. If you choose **Drop Items**, the player's items drop and other players can pick them up. |
| **Remove All Variations of the Selected Item** | **Off**, On | When turned on, all variations and rarities of the selected item will be removed from the player. |
| **Allowed Team** | **Any**, Pick a team | Determines which team can activate the device. |
| **Allowed Class** | No Class, **Any**, Pick a class | Determines which [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) can activate the device. If you choose **No Class** only players without an assigned class can activate the device. If you choose **Any**, all players can activate it. |
| **Apply To** | **Player**, Players of Team, Players of Class, All Players | Determines which players have items removed from their inventory. |
| **Play Audio** | **On**, Off | Determines whether the device plays a sound when items are removed. |

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
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Remove When Receiving From** | This function removes items from a player when an event occurs. |

### Events

This device has no events.
