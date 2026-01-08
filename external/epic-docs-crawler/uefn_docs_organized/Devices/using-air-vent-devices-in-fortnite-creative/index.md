# Air Vent Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-air-vent-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:32:13.277225

---

An **air vent** is primarily used as a method of moving characters in game modes. By standing on it, players are projected upward by the gust of air coming from the vent. It can also knock other objects (such as vehicles, balls, or projectiles) up into the air. If the air vent is placed on a wall, it will knock players or objects in the direction the gust blows.

To find the **Air Vent** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

The geothermal variants of the Air Vent have been moved to the **Galleries** category in the Creative inventory, and can be found in the **Geothermal Vent Gallery**. These geothermal vents are props and not devices, so they cannot be customized.

Looking for more inspiration? See [Air Vent Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/using-air-vent-device-design-examples-in-fortnite-creative) to boost your imagination!

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. This affects the device's collision properties. |
| **Knockup Force Multiplier** | None, Low, **Medium**, High, Very High, Super High, Mega High | Determines how hard the player is pushed when they enter the gust. |
| **Gust Range (Meters)** | **3.0M**, Pick or enter a distance | Determines how many meters from the device the gust reaches. |
| **Enable on Phase** | None, **Alway**s, Pre-Game Only,  Gameplay Only, Create Only | Determines the game phase during which the device will be enabled.  Pre-Game includes all phases prior to the Game starting (the lobby on Featured islands and the Game Start Countdown). |
| **Min Knockup Percentage** | **100%**, Pick or enter a percentage | Determines the amount of Knockup force applied to players if they enter the gust at the farthest point of its range. |
| **Skydive After Launch** | On, **Off** | When the player is launched into the air, this determines whether the player will enter the skydiving state. |
| **Enable SFX** | **On**, Off | Determines whether audio effects are turned on for this device. |
| **Enable VFX** | **On**, Off | Determines whether visual effects are turned on for this device. |

### Physics-Enabled Options

The following options become available when Physics are enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Allow Physics Props** | **On**, Off | Allow physics prop to be triggered by the air vent. |
| Impulse or Velocity | Velocity, Impulse | Determines whether to apply impulse to or directly set the velocity of an object. |
| **Prop Launch Value** | **10.0**, Select an launch value | How much impulse or velocity to apply to a physics prop triggered by the air vent. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, making your workflow more intuitive, and giving you more freedom to focus on your design ideas.

Below are the Functions and Events options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disables When Receiving From** | This function disables the device when an event occurs. |
| **Activate When Receiving From** | This function activates the air vent when an event occurs. |

### Events

This device has no events.
