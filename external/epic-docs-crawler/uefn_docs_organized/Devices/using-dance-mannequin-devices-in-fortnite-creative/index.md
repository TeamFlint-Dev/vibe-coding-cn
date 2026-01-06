# Dance Mannequin Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-dance-mannequin-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:33:51.278964

---

Use the **Dance Mannequin** device to project a hologram image of a character performing various dance [emotes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

You can create unique dance mannequins by combining a wide selection of character [skins](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), emotes, and device colors.

  To find the **Dance Mannequi**n device,  see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

## Device Options

This device has some basic functionality, like changing the character skin and emote, adding a strobe light, and changing the device color. Additionally, there are some advanced options, like selecting extra character skins and emotes to be swapped after being activated by a channel.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **All**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. Pre-Game includes all phases prior to the game starting. |
| **Character Skin Default Preset** | **Bubblegum**, Pick a character skin | Choose a default preset character outfit. If you choose **Custom Character Cosmetics**, an additional option will display below this one. |
| **Custom Character Cosmetics Default** | Pick a character skin | This option only displays if the **Character Skin Default Preset** option is set to **Custom Character Cosmetics**. This gives you a selection of over 100 Fortnite characters to choose from. |
| **Character Skin Preset 2** | **Bubblegum**, Pick a character skin | Choose a second preset character. This can be activated by an event. |
| **Custom Character Cosmetics Preset 2** | Pick a character skin | This option only displays if the **Character Skin Preset 2** option is set to **Custom Character Cosmetics**. This gives you a selection of over 100 Fortnite characters to choose from. |
| **Character Skin Preset 3** | **Bubblegum**, Pick a character skin | Choose a third preset character. |
| **Custom Character Cosmetics Preset 3** | Pick a character skin | This option only displays if the **Character Skin Preset 3** option is set to **Custom Character Cosmetics**. This gives you a selection of over 100 Fortnite characters to choose from. |
| **Show Pedestal** | **On**, Off | Determines if the pedestal can be seen. |
| **Show Stagelight** | **On**, Off | Turn the hologram lights on or off. |
| **Dance Emote Default Preset** | **A1**, Pick a preset | Choose a default preset dance emote. |
| **Dance Emote 2 Preset** | **A1**, Pick a preset | Choose a second preset dance emote. |
| **Dance Emote 3 Preset** | **A1**, Pick a preset | Choose a third preset dance emote. |
| **Hue Default Preset** | **0.0**, Pick a hue | Adjusts the hue for the device. |
| **Hue Preset 2** | **0.0**, Pick a hue | Choose a second preset hue for the device. |
| **Hue Preset 3** | **0.0**, Pick a hue | Choose a third preset color for the device. |
| **Strobe** | Enabled, **Disabled** | Determines if the device will have the strobe effect. |
| **Pedestal Color** | **Light Steel**, Dark Steel | Choose a color for the pedestal. |
| **Hue Override** | **Off**, Party Mode, Silhouette Mode | When this is enabled, it overrides hue presets. If you choose **Party Mode**, the mannequin uses shifting hues. If you choose **Silhouette Mode**, the mannequin looks like a solid silhouette. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Activate Skin and Emote Capture When Received From** | When an event occurs, the instigator's skin and emotes are used by the mannequin. |
| **Deactivate Skin and Emote Capture When Received From** | When an event occurs, it resets the skin and emote for the mannequin. |
| **Activate Default Preset When Received From** | When an event occurs, the mannequin uses the character selected in the **Character Skin Default Preset** option. |
| **Activate Preset 2 When Received From** | When an event occurs, the mannequin changes to the character selected in the **Character Skin Preset 2** option. |
| **Activate Preset 3 When Received From** | When an event occurs, the mannequin changes to the character selected in the **Character Skin Preset 3** option. |
| **Enable When Receiving From** | Enables this device when an event occurs. |
| **Disable When Receiving From** | Disables this device when an event occurs. |

## Events

 This device has no events.
