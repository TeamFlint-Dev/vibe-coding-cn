# Stat Counter Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-counter-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:44:09.764881

---

Use the **Stat Counter** device to set statistic (stats) limits that can trigger events when met. This device can set and compare stats for individual players and across teams.

Pair this device with the [Stat Creator](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-creator-devices-in-fortnite-creative) to create games where players can harvest items to gain in-game XP and increase stat levels.

For help on how to find the Stat Counter device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs, we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, a note about that will be in the Description field for that option.

## Device Options

This device has some basic functionality, like tracking set statistics. This device can also continuously track and compare the stat value over time.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

## Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Tracked Stat** | **Score**, Select a stat | Determines which statistic this device will track. |
| **Enabled During Game** | **Yes**, No | Determines if the device will start when the game begins. |

## All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Compare Type** | Fewer Than, Equal or Fewer, Not Equal To, Equal To, **Equal or More**, More Than | Determines how the tracked stat needs to be compared against the **Comparison Value**. This determines if either the success or fail events are activated. |
| **Comparison Value** | **1**, Select or enter a value | Determines what value the tracked stat needs to be for comparison against **Compare Type**. |
| **Broadcast Events on Stat Change** | True, **False** | If set to **Yes**, this will broadcast the OnValueChanged event whenever a valid player's tracked stat changes. It will also broadcast the OnCompareSuccess or OnCompareFailure events when the stat comparison result changes. |
| **Compare Per Player** | **Yes**, No | If set to **Yes**, the device will track individual stats per player. If unset, this device will track the accumulated stat value of all valid players. |
| **Value Override Type** | Add, Subtract, **Set** | Determines if this device sets, adds to, or subtracts from the stat value when calling the **OverrideValue** function. |
| **Value Override** | **0**, Pick or enter a value | Determines the value of the **Value Override** option. |
| **Visible in Game** | Yes, **When Valid**, No | Determines whether or not the device is visible during gameplay. |
| **Value to Show** | **Comparison**, Value, Target, Override | Determines what number is shown on the device. |
| **Show Icon** | **Yes**, No | Determines whether or not to show the device's stat icon. |
| **Show Background** | **Yes**, No | Determines whether or not to show the device's background. |
| **Number Length** | **2**, Pick or enter a number | Determines how many numbers show on the device's readout. If dynamic, the size will update based on the displayed value. |
| **Selected Team** | **Any**, Pick or enter a team number | Determines which team will have their stats changed and compared by this device. |
| **Invert Team Selection** | Yes, **No** | Determines if the device will be valid for all but the selected team. |
| **Selected Class** | **Any**, Pick or enter a class number | Determines which class will have their stats changed and compared by this device. |
| **Invert Class Selection** | Yes, **No** | Determines if the device will be valid for all but the selected class. |
| **Registered Player Behavior** | **Add Registered**, Require Registered, Ignored Registered | Determines how players that are registered are tracked by the device. When set to **Add Registered**, players can either be registered or selected by the other requirements. When set to **Require Registered**, players must be both registered and selected by the device. When set to **Ignore Registered**, players must be selected by the other restrictions but are not registered. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device and then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the device's function.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Override Value** | Overrides the instigator's value for their tracked stat based on the settings of ValueOverrideType and ValueOverride. |
| **Compare Stat** | Tests whether the instigating player succeeds or fails the comparison. This will always activate success or fail events. |
| **Enable** | Enables the device to immediately trigger any stat change events if a stat has changed and is set to compare through the **Stat Change** option. |
| **Disable** | Disables the device to not be visible or compare stats. |
| **Register Player** | Registers the instigating player to be added or removed from the counted players depending on the **Track Registered Players** setting. |
| **Unregister Player** | Removes the instigating player from the registered list. Registered players may be added or removed from the counted players depending on the **Track Registered Players** option. |
| **Unregister All Players** | Clears all players from the registered list. Registered players may be added or removed from the counted players depending on the **Track Registered Players** setting. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to that device's function.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Compare Success** | When the device attempts to compare, an event is sent if it passes the comparison requirements. |
| **On Compare Failure** | When the device attempts to compare, an event is sent if it fails the compare requirements. |
| **On Value Changed** | Transmits a signal on the selected channel when the stat value changes. |
