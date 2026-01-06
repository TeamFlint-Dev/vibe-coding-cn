# Movement Modulator Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-movement-modulator-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:31:41.906965

---

The **Movement Modulator** is a device you can use to apply speed increases or decreases to players or vehicles. Players can physically stand on or drive over the device to activate it for their character or vehicle. The duration of the effect can be adjusted.

You can also use this device to bounce a player or vehicle into the air, or reverse their direction.

For vehicles, the device increases the top speed of the vehicle, so it has a minimal effect on vehicles that rarely reach maximum speed.

The device changes color based on its state.

- **Green** means it provides a speed boost.
- **Red** provides a speed decrease.
- **Gray** indicates that the device is disabled.

A pulsing effect over the device shows how fast the effect applied will be. Faster pulses mean it will apply a faster speed to the player or vehicle.

When applied to a player, the player has a colored effect around their legs to show the speed change. This effect will be green if it's a speed boost, and red if it's a decrease.

To find the Movement Modulator device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

When you use [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#default) settings, a player who steps on a Movement Modulator will receive a 3-second movement speed increase. Vehicles entering this will have their maximum speed increased.

You can customize this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Affect Movement Speed** | **On**, Off | Sets whether the device affects a player's speed when triggered. |
| **Speed** | **1.5**, Pick a number | Determines the movement effect applied by the device. A value of **1.0** has no effect, and a value of **less than 1.0** slows the player down. |
| **Infinite Duration** | True, ***False*** | Determines if the speed applied by the device is infinite, or limited. If set to False, you can set the duration in the next option, **Effect Duration**. |
| **Effect Duration** | **3.0**, Pick a duration | This option only displays if the **Infinite Duration** option is set to **False**. Determines how long the effect lasts. |
| **Apply Impuse** | **Off**, *On* | Determines if the target is launched when the device is triggered. If set to **On**, more options appear below. |
| **Forward Impuse** | **2,000.0**, Pick a number | Sets the forward thrust when launching a target with this device. This option only applears when **Apply Impuse** is set to **On**. |
| **Upward Impuse** | **600.0**, Pick a number | Determines whether an upward motion is applied when when launching a target. Launching a target off the ground reduces friction and helps the boost last longer. This option only applears when **Apply Impuse** is set to **On**. |
| **Apply Upward Impulse to Non-Characters** | **On**, Off | Determines whether the upward motion is applied to all objects or just players. Based on the physics of Fortnite, vehicles and physics objects, like [boulders](https://dev.epicgames.com/documentation/en-us/fortnite/using-physics-boulder-devices-in-fortnite-creative) or [trees](https://dev.epicgames.com/documentation/en-us/fortnite/using-physics-tree-devices-in-fortnite-creative), tend to roll when launched across the ground, while players quickly stop. Applying an upward impulse can keep objects from rolling. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the initial state, or allows the device to be initially [disabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#disable) and only become enabled when it bound to an [event](https://dev.epicgames.com/documentation/en-us/fortnite/using-movement-modulator-devices-in-fortnite-creative#events). |
| **Reset Delay** | **0.0**, Pick a time in seconds | Determines the amount of time it takes for the device to reset after being activated. |
| **Visible During Game** | No, **Only FX**, Yes | Determines whether the device is visible in the game. If set to **No**, the device has no collision properties. |
| **Activating Team** | **Any**, Pick a team number | Determines which team can activate the device. |
| **Invert Team Selection** | **Off**, On | When this is set to **On**, the team selected in the **Activating Team** option is not able to activate the device, while everyone else can activate it. |
| **Activating Class** | **Any**, Pick a class | Determines which class can activate the device. If this is set to **Any**, any player with an assigned class can activate the device. |
| **Invert Class Selection** | **Off**, On | When this is set to **On**, the class selected in the **Activating Class** option is not able to activate the device but all other classes can. |
| **Use Custom Color** | **Off**, On | Determines the color of the arrows on the device. By default the device will use the color for Movement Speed if set, or the Impulse color is not. If this is set to **On**, an additional option displays below this one. |
| **Color** | **White**, Pick a color swatch | This option only displays if the **Use Custom Color** option is set to **On**. Determines the color of the device's VFX. Click the swatch to open the Color Picker. This is similar to the Color Picker for other devices, but has names for colors rather than Hex Codes. Select a color, then click the checkmark to close the Color Picker. |
| **Pad Has Collision** | **On**, Off | Determines if the device has collision properties during the game. This option only applies to the device if the **Visible During Game** is set to **Yes**. |
| **Apply Remote Impulse Relative to Player Direction** | **On**, Off | When the impulse is applied from a remote activation, this determines if the impulse uses the direction of the device or the direction the player is facing. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Activate When Receiving From** | This function activates the device when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.
4. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
5. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
6. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Activation Send Event To** | When the device is activated, it sends an event to the selected device, which triggers the selected function. |
