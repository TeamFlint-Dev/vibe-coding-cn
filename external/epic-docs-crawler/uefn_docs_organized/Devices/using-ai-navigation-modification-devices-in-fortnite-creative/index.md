# AI Navigation Modification Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-ai-navigation-modification-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:33:38.211440

---

The **AI Navigation Modification** device creates a volume or zone that defines where [AI](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) enemies cannot access.

You can use this device to control which areas AI enemies can enter and which they are excluded from. You can even dynamically change spaces where AI enemies can enter or patrol. This device can also help you route paths around complex geometry that AIs have difficulty navigating.

Some examples of how you might use this device are:

- You have AI enemies patrolling where there is a hazardous area, and you want the AI to avoid that hazard so they don't take damage from it.
- You want to give or take away AI enemy access to a particular area in your island based on a specific event or other trigger.

  For help on how to find the **AI Navigation Modificatio****n**device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

This device has some basic functionality, like selecting the height, width and depth of the [volume](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Additionally, there are some advanced options, like choosing the shape for the volume and deciding when the device is enabled.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Barrier Depth** | **1.0**, Pick or enter a number | Determines the depth of the volume, in [tiles](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |
| **Barrier Width** | **1.0**, Pick or enter a number | Determines the width of the volume, in tiles. |
| **Barrier Height** | **1.0**, Pick or enter a number | Determines the height of the volume, in tiles. |
| **Navigation Modification Type** | **Block**, Avoid | Determines how the volume modifies AI navigation:   - **Block**: All navigation data is removed from the volume. - **Avoid**: AI can leave the volume, but cannot move into the volume. This results in AI avoiding the space defined by the volume. |
| Zone Shape | Box, Cylinder | Determines the shape of the volume. |
| Enabled on Game Start | Enabled, Disabled | Determines whether the device is enabled when the game starts. |

## Direct Event Binding System

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

This device has no events or functions.
