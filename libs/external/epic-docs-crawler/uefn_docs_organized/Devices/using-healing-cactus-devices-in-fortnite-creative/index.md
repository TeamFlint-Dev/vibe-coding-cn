# Healing Cactus Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-healing-cactus-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:33:26.719214

---

The **Healing Cactus** is full of Healing Fruit, and can be found spread around a desert environment. Players can hit a cactus to "burst" the cactus fruit, which heals players that are near the cactus. After a period of time, the cactus springs back up from the ground and can be used again.

Players can interact with these cacti even when in a vehicle – they can shoot the cactus or hit it with their vehicle to trigger the healing effect. Here are some examples of how you can use this device:

- You want to include healing plants on your island but it is a desert environment, and the other healing plants don't fit with the biome.
- Loot containers are limited or not used on your island, and you want to offer a novel method for players to get healing.
- You want to give players a healing option but want something that has a built-in limit (the cactus needs time to respawn its fruit).

For help on how to find the **Healing Cactus** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the **[Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative)**.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines which phases the device is enabled in. **Pre-Game Only** includes all phases that occur before the game starts. |
| **Heal Targets** | Instigator Only, Same Team, **Everyone** | Determines which nearby players are healed when the cactus bursts. Values for this are:   - **Instigator Only**: Only the player that hit the cactus is healed. - **Same Team**: Nearby players that are on the same team as the player that hit the cactus are healed. - **Everyone**: Every player near the cactus is healed (or all players in the vehicle that hit the cactus are healed). |
| **Grow Automatically** | **True**, Initial Only, Regrow Only, False | Determines if the cactus can automatically regrow, or if it can only regrow using event binding. Values for this are:   - **True**: The cactus automatically regrows. - **Initial Only**: The cactus can automatically grow the first time. - **Regrow Only**: The cactus can only automatically regrow after bursting. - **False**: The cactus can only regrow using event binding. |
| **Initial Delay** | **None**, Pick or enter a number of seconds | Determines the amount of time it takes the cactus to grow the first time during the game. The timer is reset if the device is disabled before the first growth. |
| **Regrowth Delay** | None, **15 seconds**, Pick or enter a number of seconds | Determines the amount of time it takes the cactus to regrow after it has burst. |
| **Infinite Regrowths** | **True**, *False* | Determines whether the cactus can always regrow after bursting. If you select **False**, an additional option displays. |
| **Maximum Regrowths** | **10**, Pick or enter a number | This option only displays if the **Infinite Regrowths** option is set to **False**. Determines the number of times the cactus can regrow after bursting. This applies across the device's entire lifetime and is not affected by enabling or disabling. |
| **Can Grow in Storm** | True, **False** | Determines if a burst cactus can regrow if it is within the storm. |
| **Hide When Disabled** | True, **False** | Determines if the device is hidden when disabled. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Grow When Receiving From** | This function causes the cactus to grow when an event occurs. |
| **Burst When Receiving From** | This function causes the cactus to burst when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Grow Send Event To** | When the cactus grows or regrows, an event is sent to the selected device. |
| **On Burst Send Event To** | When the cactus bursts, an event is sent to the selected device. |
