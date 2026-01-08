# Slurp Plant Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-slurp-plant-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:46:20.823986

---

**Slurp Plants** give you a new way to provide healing resources to players so you have a broader selection of items to place on your island.

There are lots of ways this can enhance your island experience:

- Provide a more dynamic and interactive environment for players.
- Give players more ways to interact with your [game mechanics](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-mechanics).
- Give players additional tools to play strategically.
- Establish that there are multiple ways to locate and use healing resources.

For help on how to find the **Slurp Plant** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite-creative/rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like whether the pod launches when hit. Additionally, there are some advanced options, like whether the pod regrows automatically and whether it can regrow infinitely.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Launch on Hit** | **On**, Off | Determines if hitting the plant launches a projectile explodes on impact. If this is set to **Off**, the plant will explode immediately upon being hit. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **Always**, None, Pre-Game Only, Gameplay Only, Create Only | Enable the device during a specific phase. The pre-game phase includes all phases before the Game starts. If the device is enabled when you are editing your island in Create mode, launching or exploding the plant will not cause damage. |
| **Grow Automatically** | **True**, Initial Only, Regrowth Only, False | Determines if the plant regrows automatically, or if it only grows when the device receives a signal. This doesn't apply while you are editing the island.   - **True**: The plant regrows automatically. - **Initial Only**: The plant automatically grows once. - **Regrowth Only**: The plant only automatically regrows after launching a projectile or being destroyed. - **False**: The plant only grows when the device receives a signal. |
| **Initial Delay** | **None**, Pick or enter a number | Determines the time delay before the plant grows for the first time. The timer resets if the device is disabled. |
| **Regrowth Delay** | None, **15 Seconds**, Pick or enter a number | When the plant launches a projectile or is destroyed, this determines the time delay before the plant regrows. The timer resets if the device is disabled. |
| **Infinite Regrowths** | **On**, Off | Determines if the plant can regrow indefinitely after launching a projectile or being destroyed. If you set this to **Off**, another option displays below this one. |
| **Maximum Regrowths** | **10**, Pick or enter a number up to 100 | Determines the number of times a plant can regrow after launching a projectile or being destroyed. This applies across the device's lifetime, and is not affected by whether the device is enabled or disabled. |
| **Can Grow in Storm** | **On**, Off | Determines if the plant regrows while it is in a storm. |
| **Hide when Disabled** | **True**, False, Show Leaves | Determines if the device is visible when disabled.   - **True**: The device is not visible when disabled. - **False**: The device is visible when disabled. - **Show Leaves**: When the device is disabled, only the leaves will be displayed. |

## Direct Event Binding System

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below you can find the [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) for this device.

### Functions

| Option | Select Device | Select Event | Description |
| --- | --- | --- | --- |
| **Enable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function enables the device when an event occurs. If more than one device or event can enable this device, click **Add** to add a new line. |
| **Disable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function disables the device when an event occurs. If more than one device or event can disable this device, click **Add** to add a new line. |
| **Grow When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function causes the plant to grow when an event occurs. If more than one device or event can make the plant grow, click **Add** to add a new line. |
| **Explode When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function causes the plant to explode when an event occurs. If more than one device or event can make the plant explode, click **Add** to add a new line. |

### Events

| Option | Select Device | Select Function | Description |
| --- | --- | --- | --- |
| **On Grow Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When the plant grows, the device sends an event to the selected device, which triggers the selected function. |
| **On Explode Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When the plant explodes, the device sends an event to the selected device, which triggers the selected function. |
| **On Launch Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When the plant launches a projectile, the device sends an event to the selected device, which triggers the selected function. |
