# D-Launcher Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-d-launcher-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:25:31.878595

---

With the **D-Launcher**, you can launch players in specific directions at angles you set. Place them as aids to [traversal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) in multi-level islands, or place them as hazards to obstruct players' progress.

Each type of launcher has a device option you can use to apply a low-gravity effect to whatever is launched. If this setting is active, movement is slower during launch so players can continue combat while moving.

The D-Launcher comes in three forms: **Standard**, **Primal**, and **Invasion**. This page describes the device options for all three forms. If a specific form isn't mentioned in an option description, it means the option values and defaults are the same for all three forms.

Looking for more inspiration? See [D-Launcher Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/dlauncher-device-design-examples-in-fortnite-creative) to kick off your imagination!

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

This device has some basic functionality, like setting the launch speed and angle. Additionally, there are some advanced options, like choosing which things can be launched by the device and whether visual and sound effects play during a launch.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Visible During Game** | **Yes**, No | Determines if the launcher is visible or invisible during the game. All forms default to being visible during the game. |
| **Activating Team** | **Any**, Pick a team | Determines which team can activate the device. If you select a specific team, ability to activate can be reversed using the **Invert Team Selection** option. |
| **Invert Team Selection** | **No**, Yes | If you select **Yes**, the team selected in the **Activating Team** option is the only team that **cannot** activate the launcher. |
| **Activating Class** | No Class, **Any**, Pick a class | Determines which class can activate the device. If you select a specific class, the ability to activate the device can be reversed using the **Invert Class Selection** option. If you select **No Class**, only players without a class assigned can activate the device. If you select **Any**, all players with an assigned class can activate the device. |
| **Invert Class Selection** | **No**, Yes | If you select **Yes**, the class selected in the **Activating Class** option is the only class that **cannot** activate the launcher. |
| **Allow Players** | **Yes**, No | Determines whether players can activate the launcher device while on foot. This can be restricted for players in teams or classes selected in **Activating Team** or **Activating Class**. |
| **Allow Creatures** | **Yes**, No | Determines whether [creatures](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) can activate the launcher device. |
| **Allow Wildlife** | **Yes**, No | Determines whether [wildlife](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) can activate the device. While ridden, wildlife can be restricted by riders in teams or classes selected in **Activating Team** or **Activating Class**. |
| **Allow Guards** | **Yes**, No | Determines whether [guards](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) can activate the launcher device. Hired guards can be restricted if they are in teams or classes selected in **Activating Team** or **Activating Class**. |
| **Allow Vehicles** | **Yes**, No | Determines whether vehicles can activate the launcher device. When driven, vehicles can be restricted by drivers in teams or classes selected in **Activating Team** or **Activating Class**. |
| **Launch FX** | **On**, Off | Determines whether the device plays [VFX](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) on anything launched by the device. This also affects [controller rumble](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |
| **Device FX** | **On**, Off | Determines whether the launcher plays visual and sound effects. |
| **Enabled at Game Start** | **Enabled**, Disabled | Determines whether the device is [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) when the game starts. |
| **Launch Speed** | 50 Meters/Second, Pick a speed | Determines the speed the device applies when launching. |
| **Launch Angle** | - Standard and Primal: 38 Degrees, Pick an angle  - Invasion: 90 Degrees, Pick an angle | Determines the angle of launch. If you choose 0 degrees, the player is launched along the ground. If you choose 90 degrees, the player is launched straight up. |
| **Low Gravity** | - Standard: Yes, No  - Primal and Invasion: No, Yes | Determines whether low gravity is applied on launch. |

### Physics-Enabled Options

  The following options become available when [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) are enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Impulse** **or Velocity** | **Velocity,** Impulse | Whether to apply an impulse to or directly set the velocity of an object. |
| **Allow Physics Objects** | **On**, Off | Determines whether the device launches objects that are not vehicles or projectiles.  Objects are unaffected by Activating Team and Activating Class. |

## Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event and select the event that triggers this function.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | The device is enabled when an event occurs. |
| **Disable**When Receiving From | The device is disabled when an event occurs. |

### Events

Transmitters send a signal on the selected channel when triggered.

An [event](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Launched Send Event To** | When a player is launched an event is sent to the selected device. |
| **On Non-Player Launched**Send Event To | When a non-player is launched an event is sent to the selected device. |
