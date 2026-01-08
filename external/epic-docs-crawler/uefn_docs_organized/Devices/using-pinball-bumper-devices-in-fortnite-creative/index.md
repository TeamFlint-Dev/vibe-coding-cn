# Pinball Bumper Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-pinball-bumper-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:48:33.593844

---

When the **Pinball Bumper Device** is placed, any players that touch it will bounce backward and slightly upward with moderate force. You can use this with the [Pinball Flipper](https://dev.epicgames.com/documentation/en-us/fortnite/using-pinball-flipper-devices-in-fortnite-creative) device to create pinball-like mechanics.

For help on how to find the **Pinball Bumper** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

The Pinball Bumper device will activate when players on the correct team touch it on the top or the sides (depending on the options set). When the Pinball Bumper is activated, it makes a noise and knocks players back. The section on top of the Pinball Bumper will retract into the body until it is ready to activate again. If set to a non-glowing color, the Pinball Bumper will also briefly glow when activated.

You can control how much damage players take when knocked back by the Pinball Bumper, and whether it activates from both the top and the sides.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

### User Options

| Option | Value | Description |
| --- | --- | --- |
| **Knockback Player** | Pick an amount | How much force is applied to objects next to the Pinball Bumper when it is activated. |
| **Knockback Vehicle** | Pick an amount | How much force is applied to vehicles next to the Pinball Bumper when it is activated. |
| **Activating Team** | **Any**, Pick a team | The Pinball Bumper can only be activated by members of this team. |
| **Allow Side Bounce** | **On**, Off | Whether the device will activate when the player touches the side of the Pinball Bumper. Activating the device this way knocks players backward and away from the Pinball Bumper. |
| **Custom Side Lift Strength** | On, **Off** | If set, this option uses a separate set of values for bouncing when touching the side of the bumper. |
| **Side Bounce Lift Player** | Pick a distance | How much to knock the player in the air when the player hits the side of the bumper. Players stop quickly when in contact with the ground due to friction unless they have a slippery effect such as a Chiller trap or a [Grind Powerup](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grind-powerup) applied to them. Because of this, **Side Bounce Lift** plays a major part in how far the players are knocked back. |
| **Side Bounce Lift Vehicle** | Pick a distance | When knocked sideways, how much a vehicle gets knocked up.  Requires **Allow Side Bounce** to be set to On. |
| **Allow Top Bounce** | **On**, Off | Whether the Pinball Bumper activates when an object touches the top. Activating the device this way knocks objects directly upwards. With Side Bounce disabled, creators can use this to configure the bumper as a bounce pad with customizable strength. |
| **Bumper Color** | **Blue**, Blue Glow, Red, Silver, Pink Glow, Green Glow, Orange Glow, Gold | Determines the color of the bumper. |
| **Object Direction Importance** | **100%**, Pick a percentage from 0% to 100% | By default, the bumper takes the direction the object was moving when it hits the bumper, and uses that to determine the force it applies back. You can use Object Direction Importance to determine how much this is taken into account. At 0%, the direction of the object is ignored entirely and the object is always thrown directly away from the Pinball Bumper. |
| **Enabled At Game Start** | **Yes**, No | Determines whether the device is automatically enabled at game start, or if it needs to be enabled manually. |
| **Affects Creatures** | Yes, **No** | Determines whether this device can affect creatures and wildlife. |
| **Display Score Update on HUD** | **Off**, *On* | Determines whether score updates are displayed as a HUD message. If you choose **On**, several additional options are displayed below this one in the Customize panel. |
| **Reset HUD Message Score** | **Off**, On | When the device displays a score message on the HUD, this determines whether it starts at zero. |
| **HUD Message** | **Score!**, Enter text | Determines what message is displayed on the HUD with the score. Use the default, or enter custom text. The text field has a limit of 150 characters. |
| **HUD Message Score Color** | **#BFEBFFFF**, Pick a color | Determines the color of the score displayed on the HUD. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/5f2071bf-ed0c-4992-8cea-7cc1b0569195?resizing_type=fit) |
| **HUD Message Color** | **#00BAFFFF**, Pick a color | Determines the color of the text in the message you set in the **HUD Message** option. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color. |
| **Fall Damage** | **On**, Off | Whether any objects knocked back by the bumper receive fall damage. |
| **Damage** | **None**, Pick an amount | How much damage to apply to objects hit by the Pinball Bumper. |
| **Reset Time** | **0.25 Seconds**, Pick a duration | Once activated, the device enters a dormant state for the selected amount of time. |
| **Bumper Color** | **Blue**, Pick a color | Sets the color of the Pinball Bumper. |
| **Score Value** | **0**, Pick an amount | How much score to give any player that activates the bumper. |

### Physics-Enabled Options

The following options become available when [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) are enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Knockback Physics Prop** | Pick an amount | Determines the force applied by the bumper when it knocks a physics prop back. |
| **Impulse or Velocity** | **Velocity**, Impulse | Whether to apply an impulse to or directly set the velocity of an object. |
| **Affects Physics Props** | **On,** Off | Determines if the device can affect physics props. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device, allowing it to be activated by objects that touch it. When activated the Pinball Bumper will knock back any objects that touch it. |
| **Disable When Receiving From** | Disables the device, preventing it from being activated by objects that touch it. |
| **Activate when Receiving From** | Activates the Pinball Bumper directly, knocking back any nearby objects. |

### Events

An event tells another device when to perform a function.

1. For any event, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Activated Send Event To** | When the Pinball Bumper is activated, it sends an event to the selected device, with the player (if any) that activated it as the instigator. |

## Gameplay Examples and Island Tutorials using Pinball Bumper Devices

- [Lava Bounce](lava-bounce-in-fortnite-creative)
- [Pinball Wizard](pinball-wizard-in-fortnite-creative)
- [Pinbrawl Island Tutorial](pinbrawl-in-fortnite-creative)
