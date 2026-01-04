# Pinball Flipper Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-pinball-flipper-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:34:22.129332

---

The **Pinball Flipper** device can move, [damage](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#damage), and give score to players that interact with it. By default, it is activated by any player touching its front face, which rotates it counterclockwise and knocks those players away from it and slightly upward.

The Pinball Flipper can be set to activate when objects of the correct team touch it on either side (depending on the options selected). It can also be configured to [trigger](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) when taking any damage.

When activated, the device makes a noise and [knocks players back](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#knockback), then the top of the Pinball Flipper retracts into the body until it is ready to activate again. If set to a non-glowing color, the Pinball Flipper will also glow briefly when activated.

For help on how to find the **Pinball Flipper** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

### Device Options

The device options let you configure the Pinball Flipper's appearance. You can also determine the effects that occur when interacting with the flipper (knockback, damage, and score), and how strong those effects are.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

### User Options

| Option | Value | Description |
| --- | --- | --- |
| **Activating Team** | **Any**, Pick a team | The Pinball Flipper is only activated by members of this team. |
| **Trigger on Proximity** | **Yes**, No | Determines whether or not the flipper activates when touched. |
| **Trigger on Damage** | **Yes**, No | Determines whether or not the flipper activates when it takes damage. |
| **Bounce Angle Percentage** | **100%**, Pick a percentage | The angle of the knockback the flipper applies to objects depends on what part of the Pinball Flipper the object hits. Objects hitting the middle of the flipper are knocked directly backward, and those hitting at either end are knocked in either direction. This option allows the device to be configured to decrease or increase this effect. |
| **Damage** | **None**, Pick an amount of damage | How much damage is applied to objects hit by the Pinball Flipper. |
| **Enabled At Game Start** | **Yes**, No | Whether the device is automatically [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#enable) at the start of the game, or if it needs to be enabled manually. |
| **Hit on Backswing** | Yes, **No** | When the flipper activates, it will rotate and hit objects in front of it before returning to its resting state. This setting determines whether it will also hit and knock back players that are standing behind it. |
| **Affects Creatures** | Yes, **No** | Determines whether the flipper affects creatures. |
| **Display Score Update on HUD** | **Off**, *On* | Determines whether score updates are displayed as a HUD message. If you choose **On**, several additional options are displayed below this one in the Customize panel. |
| **Reset HUD Message Score** | **Off**, On | When the device displays a score message on the HUD, this determines whether it starts at zero. |
| **HUD Message** | **Score!**, Enter text | Determines what message is displayed on the HUD with the score. Use the default, or enter custom text. The text field has a limit of 150 characters. |
| **HUD Message Score Color** | **#BFEBFFFF**, Pick a color | Determines the color of the score displayed on the HUD. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/d13537fe-a5b6-43dc-936a-cc660d65a56c?resizing_type=fit) |
| **HUD Message Color** | **#00BAFFFF**, Pick a color | Determines the color of the text in the message you set in the **HUD Message** option. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color. |
| **Flip Direction** | Counter-Clockwise, Clockwise, Off, Opposite, Same, Flip-Flop | Determines which direction the flipper turns, and which sides it will activate from. |
| **On Triggered Knockback Player** | Pick a height | How much force is applied by the flipper when it's triggered through damage or a transmitter. |
| **On Triggered Knockback Vehicle** | Pick a height | How much force is applied by the flipper when it's triggered through damage or a transmitter. |
| **On Bump Knockback Player** | Pick a height | How much force is applied by the flipper when it's triggered by proximity. |
| **On Bump Knockback Vehicle** | Pick a height | How much force is applied by the flipper when it's triggered by proximity. |
| **Fall Damage** | **On**, Off | Whether or not any objects knocked back by the flipper receive fall damage. |
| **Reset Time** | **0.25 seconds**, Pick an amount of time | Once activated, the device enters a dormant state for the chosen amount of time. |
| **Flipper Color** | Blue, Pick a color | This sets the color of the Pinball Flipper. |
| **Knockup Amount Player** | Pick a height | How much the object is knocked up. |
| **Knockup Amount Vehicle** | Pick a height | How much the object is knocked up. |
| **Score Value** | Pick a value | How much score to give any player that activates the flipper. |

### Physics-Enabled Options

The following options become available when [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) are enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Flipper Velocity** | 0.0 - 200.0 m/s (**25.0** default) | Determines how fast the flipper rotates when triggered or activated. |
| **Swing Arc** | 0.0° - 359.0° (**90.0**° default) | Determines the width of the flipper rotation. |
| **Return Strength** | 0.0 - 200.0 N (**50.0 N** default) | Determines the force at which the flipper returns to its initial position. |
| **Flipper Mass** | 1.0 Kg - 1000.0 Kg (**10.0 Kg** default) | Determines how heavy the flipper is to apply different amounts of force when moving and colliding with other physically-simulated objects. |

## Direct Event Binding

Following are the direct event binding options for this device.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Activate When Receiving From** | Activates the device when an event occurs. |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |

### Event

An event tells another device when to perform a function.

1. For any event, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Value | Description |
| --- | --- | --- |
| **When Activated Transmit On** | **No Channel**, Pick a channel or enter a channel number | When the Pinball Flipper is activated, it sends a signal on the selected channel. |

## Gameplay Examples Using Pinball Flipper Devices

- [Boulder Trap](boulder-trap-in-fortnite-creative)
- [Pinball Wizard](pinball-wizard-in-fortnite-creative)
- {Pinbrawl Island Tutorial](pinbrawl-in-fortnite-creative)
