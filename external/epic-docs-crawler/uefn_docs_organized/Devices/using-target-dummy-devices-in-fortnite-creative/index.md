# Target Dummy Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-target-dummy-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:35:24.238300

---

The **Target Dummy** is a customizable stationary target that players can use to practice shooting ranged weapons. It has a variety of target types, and you can customize the target's behavior in many ways:

- The target can stand up or knock itself down on a timer.
- The target can stand up or knock itself down randomly.
- The target can hop up from its standing position, or hop up and drop down randomly.

If you are looking for moving targets, see [Target Dummy Track](https://dev.epicgames.com/documentation/en-us/fortnite/using-target-dummy-track-devices-in-fortnite-creative). Combine multiple copies of the Target Dummy and Target Dummy Track devices to create fun minigames for your players!

For help on how to find the **Target Dummy** device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [**Event Browser**](event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options, depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled at Minigame Start** | **On**, Off | Determines whether this is enabled at the start of the game, or if it must be enabled using event binding. |
| **Target Type** | **Standing**, Pick a target type | Choose which target to use. |
| **Score Value** | **1**, Pick or enter a number | Sets the amount of score awarded to a player for a normal hit on the target. Values range from **-1000** to **1000**, including **0**. |
| **Score Bullseye Multiplier** | **1**, Pick or enter a multiplier | Sets a multiplier to be applied to the score value if the player hits the bullseye. |
| **Bullseye Size** | Small, **Medium**, Large | Determines the size of the bullseye area on the target. |
| **Infinite Health** | Invulnerable, ***Off*** | Determines if the target has infinite health. If this is set to **On**, only a bullseye hit can knock it down. If this is set to **Off** (the default), the **Starting Health** option does not display. |
| **Starting Health** | **1**, Pick or enter an amount | Determines how much damage the target must take before it is knocked down. |
| **Show Health Bar** | **Yes**, No | Determines whether the target will display a health bar while it is active. |
| **Reset Time Type** | ***On Timer***, Never, *Random* | Determines if and when a target is reset after being knocked down. Depending on the value of this option, additional options may display or be hidden. |
| **Reset Time** | **2 seconds**, Pick a number | This option only displays if the **Reset Time Type** option is set to **On Timer**. Determines how long the target will wait after being knocked down before it resets. |
| **Random Reset Minimum Time** | **1 second**, Pick a number | This option only displays if the **Reset Time Type** option is set to **Random**. Determines the minimum amount of time the target will wait before resetting after it is knocked down. If this is set to a value higher than the **Random Reset Maximum Time** option's value, this option will default to one second. |
| **Random Reset Maximum Time** | **10 seconds**, Pick a number | This option only displays if the **Reset Time Type** option is set to **Random**. Determines the maximum amount of time the target will wait before resetting after it is knocked down. If this is set to a value lower than the **Random Reset Minimum Time** option's value, this option will default to 10 seconds. |
| **Pop Up Delay Type** | ***On Timer***, Never, *Random* | If the **Time Before Hiding Type** option is set to **Infinite** or **Random**, the target can knock itself down (hide). This option determines if and when the target will pop up after hiding. Depending on the value of this option, additional options may display or be hidden. |
| **Time Before Pop Up** | **2 seconds**, Pick a number | This option only displays if the **Pop Up Delay Type** option is set to **On Timer**. Determines how long the target will wait after being knocked down before it resets. |
| **Random Pop Up Minimum Time** | **1 second**, Pick a number | This option only displays if the **Pop Up Delay Type** option is set to **Random**. Determines the minimum amount of time the target will wait after hiding before popping back up. If this is set to a value higher than the **Random Pop Up Maximum Time** option's value, this option will default to one second. |
| **Random Pop Up Maximum Time** | **10 seconds**, Pick a number | This option only displays if the **Pop Up Delay Type** option is set to **Random**. Determines the maximum amount of time the target will wait after hiding before popping back up. If this is set to a value lower than the **Random Pop Up Minimum Time** option's value, this option will default to 10 seconds. |
| **Time Before Hiding Type** | On Timer, **Infinite**, *Random* | Determines if and when the target will hide. If this is set to **Infinite**, the target will never hide. Depending on the value of this option, additional options may display or be hidden. |
| **Random Hide Minimum Time** | **1 second**, Pick a number | This option only displays if the **Time Before Hiding Type** option is set to **Random**. Determines the minimum amount of time the target will wait before hiding. If this is set to a value higher than the **Random Hide Maximum Time** option's value, this option will default to one second. |
| **Random Hide Maximum Time** | **10 seconds**, Pick a number | This option only displays if the **Pop Up Delay Type** option is set to **Random**. Determines the maximum amount of time the target will wait before hiding. If this is set to a value lower than the **Random Hide Minimum Time** option's value, this option will default to 10 seconds. |
| **Infinite Pop Ups** | **On**, Off | Determines if the target has an infinite number of times it can pop up after hiding. If this is set to **Off**, another option displays. |
| **Maximum Pop Ups** | **0**, Pick a number | Determines the number of times a target can pop up after hiding. Values range from 1 to 10. |
| **Infinite Resets** | **On**, Off | Determines if the target has an infinite number of times it can reset after being knocked down. If this is set to **Off**, another option displays. |
| **Maximum Resets** | **0**, Pick a number | Determines the number of times a target can reset after being knocked down. Values range from 1 to 10. |
| **Starting Position** | **Up**, Down | Determines whether the target is in the standing or knocked down position when the game starts. |
| **Proximity Pop Up Range** | **Off (0.0)**, Pick a number | Determines how far the player must be before the target stands up. |
| **Hinge From Center** | On, **Off** | Determines where the target is hinged for standing up. |
| **Bullseye Knockdown** | On, **Off** | Determines whether the target is knocked down by a bullseye. If this is set to **On**, the target will be knocked down by a bullseye hit, regardless of the target's health value. |
| **Hopping Frequency Type** | *On Timer*, **No Hopping**, *Random* | Determines if and when the target will hop up. If this is set to **No Hopping**, the target will never hop up. Depending on the value of this option, additional options may display or be hidden. |
| **Hopping Frequency Time** | **1 second**, Pick or enter a number | This option only displays if the **Hopping Frequency Type** option is set to **On Timer**. Determines how often a standing target will hop up. |
| **Random Hop Minimum Time** | **0.5 seconds**, Pick or enter a number | This option only displays if the **Hopping Frequency Type** option is set to **Random**. Determines the minimum amount of time the target will wait before hopping up. If this is set to a value higher than the **Random Hop Maximum Time** option's value, this option will default to 0.5 seconds. |
| **Random Hop Maximum Time** | **3.0 seconds**, Pick or enter a number | This option only displays if the **Hopping Frequency Type** option is set to **Random**. Determines the minimum amount of time the target will wait before hopping up. If this is set to a value lower than the **Random Hop Minimum Time** option's value, this option will default to 3.0 seconds. |
| **Hop Length Type** | On Timer, **Infinite**, *Random* | Determines if and when the target will drop down after hopping up. If this is set to **Infinite**, the target will never drop down. Depending on the value of this option, additional options may display or be hidden. |
| **Random Hopped Minimum Time** | **0.5 seconds**, Pick or enter a number | This option only displays if the **Hop Length Type** option is set to **Random**. Determines the minimum amount of time the target will wait before dropping down from a hop. If this is set to a value higher than the **Random Hopped Maximum Time** option's value, this option will default to 0.5 seconds. |
| **Random Hopped Maximum Time** | **3.0 seconds**, Pick or enter a number | This option only displays if the **Hop Length Type** option is set to **Random**. Determines the maximum amount of time the target will wait before dropping down from a hop. If this is set to a value lower than the **Random Hopped Minimum Time** option's value, this option will default to 3.0 seconds. |
| **Damage Type** | **Object**, Player | Determines whether weapons treat the target dummy as an object or a player when calculating damage values. |
| **Number Display** | Off, **Show Damage**, Bullseye Only, Score | Determines if numbers are displayed on the screen. The default displays the damage done to the target. **Bullseye Only** displays when a player hits the bullseye. **Score** displays the player's score instead of damage. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Pop Up When Receiving From** | This function stands the target up when an event occurs. |
| **Pop Down When Receiving From** | This function knocks the target down when an event occurs. |
| **Hop Up When Receiving From** | This function makes the target hop up from a standing position when an event occurs. |
| **Hop Down When Receiving From** | This function makes the target drop down from a hop when an event occurs. |
| **Reset When Receiving From** | This function resets the target to standing when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Hit Send Event To** | When the target is hit, an event is sent to the selected device. This event will not trigger if either the **On Knockdown** or **On Bullseye Hit** events are set. |
| **On Knockdown Send Event To** | When a target is knocked down by damage, an event is sent to the selected device. This event will not trigger if the knockdown was caused by a bullseye and the **On Bullseye Hit** event is set. |
| **On Bullseye Hit Send Event To** | When the target's bullseye is hit, an event is sent to the selected device. |
| **On Pop Up Send Event To** | When the target changes from Down to Up status, an event is sent to the selected device. |
| **On Pop Down Send Event To** | When the target changes from Up to Down status, an event is sent to the selected device. |
| **On Hop Up Send Event To** | When the target hops up, an event is sent to the selected device. |
| **On Hop Down Send Event To** | When the target drops down from a hop, an event is sent to the selected device. |
