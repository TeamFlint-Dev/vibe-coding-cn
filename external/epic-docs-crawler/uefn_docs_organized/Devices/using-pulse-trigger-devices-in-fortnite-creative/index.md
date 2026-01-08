# Pulse Trigger Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-pulse-trigger-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:43:28.022347

---

The **Pulse Trigger** is a device you can use to damage players who collide with it. You can also use it as a trigger to activate other devices.

The device creates a representation of a metronome. Based on the BPM (beats per minute) you select, the activated pulse trigger sends out a pulse that travels down a line and triggers devices within its path.

For help on how to find the **Pulse Trigger** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

The pulse trigger has some basic functionality, like the size of the zone, how many times the pulse trigger loops, the amount of damage it deals to players, and the direction of the pulse. Additionally, there are some advanced options, like which game phase the pulse trigger activates in, the activation type, and whether player information is sent.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Loop Infinitely** | On, ***Off*** | Determines if the device loops infinitely. If this is set to **On**, the **Number of Loops** option is displayed below this one. |
| **Number of Loops** | **1**, Pick or enter a number | This only displays if the **Loop Infinitely** option is set to **Off**. Determines how many times the pulse trigger will loop before stopping. |
| **Tempo (BPM)** | **110**, Pick or enter a number | Determines how fast (in beats per minute or BPM) the pulse travels. |
| **Length** | **4**, Pick or enter a number | Sets the number of tiles long the pulse trigger volume is. |
| **Width** | **1.0**, Pick a number | Sets the number of tiles wide the pulse trigger volume is. |
| **Height** | **1.0**, Pick a number | Sets the number of tiles high the pulse trigger volume is. |
| **Zone Direction** | None, **Forward**, Left, Right, Backwards | Determines the direction the zone lies in relation to the device. |
| **Activation Type** | **Send Pulse**, Toggle Pulse On/Off, Toggle Pulse Play/Pause | Determines whether activating the device sends a new pulse every time, toggles the pulse between running and stopping, or toggles the pulse between playing and pausing. |
| **Zone Visible During Game** | On, **Off** | Determines whether or not the zone is visible during the game. |
| **Disable Activation While Running** | On, **Off** | Determines whether the device can be activated again while a pulse is already in motion. |
| **Active When Paused** | On, **Off** | Determines whether a paused trigger will stay active and trigger anything that walks into it. |
| **Pulse Direction** | **Forward**, Backwards, Bounce Forward, Up, Down, Bounce Up | Determines which direction the pulse will travel when the device is activated. If you choose **Bounce**, the pulse will reverse direction when it reaches the end of the zone. |
| **Damage** | **0.0**, Pick or enter a number | Determines the level of damage the pulse should deal to players it hits. |
| **Use Flashing Warning Signs** | On, **Off** | Determines if flashing warning signs are displayed when a player is damaged by the pulse. |
| **Activate on Phase** | **None**, Waiting for Players, Game Countdown, Game Start | Determines in which phase the pulse trigger is activated. |
| **Send Player Information** | **On**, Off | When the pulse trigger activates another device, this determines whether or not the pulse trigger identifies the activating player as an instigator and sends that information to the other device. |
| **Enabled On Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the phase in which the device is enabled. |
| **Custom Pulse Style** | On, **Off** | If you set this option to **On**, the visual style of the pulse is more solid than the standard translucent pulse. This makes it easier to see the progress of the pulse. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Start Pulse When Receiving From** | This function starts the pulse when an event occurs. |
| **Stop Pulse When Receiving From** | This function stops the pulse when an event occurs. |
| **Resume Pulse When Receiving From** | This function restarts the pulse when an event occurs. |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |  |  |
| --- | --- | --- | --- |
| **On Player Hit Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When a player is hit by the pulse, the device sends an event to the selected device, which triggers the selected function. |

## Gameplay Examples Using the Pulse Trigger

- [Color Switch Challenge](https://dev.epicgames.com/documentation/en-us/fortnite/color-switch-challenge-gameplay-example-in-fortnite-creative)
- [Mix Tape](https://dev.epicgames.com/documentation/en-us/fortnite/mix-tape-in-fortnite-creative)
