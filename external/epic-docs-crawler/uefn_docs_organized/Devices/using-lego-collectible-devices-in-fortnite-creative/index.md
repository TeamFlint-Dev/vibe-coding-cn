# Collectible Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-lego-collectible-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:27:56.936558

---

Snap the pieces of your island experience together by awarding players with LEGO® Collectible studs.

These are collectible studs that can be displayed on a HUD when picked up. Players can then use these collectibles to fulfill device or score requirements.

Check out the [LEGO ® Action Adventure template](https://dev.epicgames.com/documentation/en-us/fortnite/lego-action-adventure-in-unreal-editor-for-fortnite) for a glimpse of how to include this device to create a rewarding gameplay experience. In this template, studs are awarded throughout the game to unlock areas, assemble props, and fulfill quest requirements.

You can find the device in the following locations:

1. **Creative**: **Creative Menu** > **Content** > **LEGO® Content** > **Devices** > **LEGO® Collectible**
2. **UEFN**: **Content Drawer** > **LEGO® Content** > **Devices** > **LEGO® Collectible**

To learn the fundamentals of how to access, place, and adjust settings for a device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the **[Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative)**.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the **Customize** panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in italics.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the **Description** field for that option.

## Device Options

By default, each collectible stud will be visible to all players. When a player touches it, they gain a score of 1, and the stud disappears. The collectible stud is only hidden for players who have already picked it up. Other players will still see the collectible stud and be able to pick it up.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Collectible Object** | **Gold Stud**, Blue Stud, Purple Stud, Silver Stud | Determines the visual element of the collectible object. |
| **Score** | **1**, Enter an amount | Sets the amount of score awarded when the object is collected. |
| **Ambient Audio** | **True**, False | Determines whether the object plays ambient audio when players are nearby. |
| **Consume if Collected By** | **Self**, Anyone, Team | Determines when the object is removed from the world. |
| **Collecting Team** | Team Index, **All** | Sets which team can collect the object. |
| **Allowed Class** | Class Slot, No Class, **Any** | Determines which class can collect the object. |
| **Visible to Opposing Players** | **Never**, Always, Until Collected | Determines whether the object is visible to players who cannot collect it. |
| **Visible on Game Start** | **True**, False | Determines whether the object is visible when the game starts. |
| **Show Pickup Effects** | Off, Only Audio, Only Visuals, **On** | Determines what effects will play when a player picks up the item. |
| **Display Score Update on HUD** | *True*, **False** | Determines if a player score event is displayed on the HUD. |
| **Reset HUD Message Score** | True, **False** | Sets if this device displays a score message on HUD. |
| **HUD Message** | **Enter text** | Sets the message to display on the HUD with the score. |
| **HUD Message Score Color** | **#BFEBFFFF**, Pick a color | Sets the color of the score text displayed on the HUD. |
| **HUD Message Color** | **#00BAFFFF**, Pick a color | Determines the text color on the message displayed on the HUD. |
| **Custom Mesh** | *True*, **False** | Determines whether to use a custom mesh instead of the collectible defined by the collectible object. Custom meshes will not have a visual movement. |
| **Manually Set Collider** | True, **False** | Changes the collision properties of this device. |
| **Play Ambient VFX** | **True**, False | Determines the visibility of the ambient glow effect on the collectible. |
| **Custom on Collected VFX** | True, **False** | Defines the custom particle to use. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device and then performs an action.

1. For any function, click the related option, then **Select Device** to access and select from the **Device** dropdown menu.

1. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.

1. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Turn Visibility On** | Makes this object visible when an event occurs. |
| **Turn Visibility Off** | Makes this object invisible when an event occurs. |
| **Respawn** | Immediately respawns the object for the instigating player. This will be affected by Consume if Collected By when an event occurs. |
| **Respawn for All** | Immediately respawns the object for all players when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any function, click the relevant option, then **Select Device** to access and select from the **Device** dropdown menu.

1. Once you've selected a device, click **Select Function** to bind this event to a function for that device.

1. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Collected** | Sends an event when the object is collected by a player. |
