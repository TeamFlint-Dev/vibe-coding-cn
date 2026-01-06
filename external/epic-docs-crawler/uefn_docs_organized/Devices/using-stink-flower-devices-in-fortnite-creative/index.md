# Stink Flower Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-stink-flower-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:39:21.201090

---

**Stink Flowers** can launch projectiles that act like stink grenades, and give you a new way to provide stink resources for players so you have a broader selection of items to place on your island.

There are lots of ways this can enhance your island experience:

- Provide a more dynamic and interactive environment for players.
- Give players more ways to interact with your game mechanics.
- Give players additional tools to play strategically.
- Establish that there are multiple ways to locate and use resources.

## Finding and Placing the Device

1. From [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode), press the **Tab** key to open the [CREATIVE inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) screen.
2. Click the **DEVICES** tab. You can scroll to select the device, use the **Search** box to look up the device by name, or the **Categories** in the panel on the left.
3. Click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) immediately, or put the device in the [QUICK BAR](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-bar) to place later.
4. Press **Esc** to return to your island in Create mode. Use your [phone](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#phone) to position the device, then click to place it. Press **Esc** to detach the device from your phone.
5. Point at the device with your phone. If the **Customize** popup doesn't open immediately, move closer until it does, then press **E** to open the Customize panel.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like whether the pod launches when hit. Additionally, there are some advanced options, like whether the pod regrows automatically and whether it can regrow infinitely.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Launch on Hit** | **On**, Off | Determines if hitting the plant launches a projectile explodes on impact. If this is set to **Off** the plant will explode immediately upon being hit. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **Always**, None, Pre-Game Only, Gameplay Only, Create Only | Enable the device during a specific phase. The Pre-Game phase includes all phases before the Game starts. If the device is enabled when you are editing your island in Create mode, launching or exploding the plant will not cause damage. |
| **Grow Automatically** | **True**, Initial Only, Regrowth Only, False | Determines if the plant regrows automatically, or if it only grows when the device receives a signal. This doesn't apply while you are editing the island.   - **True**: The plant regrows automatically. - **Initial Only**: The plant automatically grows once. - **Regrowth Only**: The plant only automatically regrows after launching a projectile or being destroyed. - **False**: The plant only grows when the device receives a signal. |
| **Initial Delay** | **None**, Pick or enter a number | Determines the time delay before the plant grows for the first time. The timer resets if the device is disabled. |
| **Regrowth Delay** | None, **15 Seconds**, Pick or enter a number | When the plant launches a projectile or is destroyed, this determines the time delay before the plant regrows. The timer resets if the device is disabled. |
| **Infinite Regrowths** | **On**, *Off* | Determines if the plant can regrow indefinitely after launching a projectile or being destroyed. If you set this to **Off**, another option displays below this one. |
| **Maximum Regrowths** | **10**, Pick or enter a number up to 100 | This option only displays if you have set the **Infinite Regrowths** option to **Off**. Determines the number of times a plant can regrow after launching a projectile or being destroyed. This applies across the device's lifetime, and is not affected by whether the device is enabled or disabled. |
| **Can Grow in Storm** | **On**, Off | Determines if the plant regrows while it is in a storm. |
| **Hide when Disabled** | **True**, False, Show Leaves | Determines if the device is visible when disabled.   - **True**: The device is not visible when disabled. - **False**: The device is visible when disabled. - **Show Leaves**: When the device is disabled, only the leaves will be displayed. |

## Direct Event Binding System

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) for this device.

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
