# Target Dummy Track Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-target-dummy-track-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:48:52.784511

---

The **Target Dummy Track** is a customizable moving target that players can use to practice shooting [ranged weapons](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#ranged-weapon). It has a variety of target types, and you can customize the target's behavior in many ways:

- The target can move along the track at varying speeds.
- The target can stand up or knock itself down on a timer.
- The target can stand up or knock itself down randomly.
- The target can hop up from its standing position, or hop up and drop down randomly.

If you are looking for stationary targets, see [**Target Dummy**](using-target-dummy-devices-in-fortnite-creative). Combine multiple copies of the Target Dummy and Target Dummy Track devices to create fun minigames for your players!

For help on how to find the **Target Dummy Track** device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [**Event Browser**](event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Length** | **1.0**, pick or enter a number | Determines the length of the track the target dummy moves on, measured in tiles. |
| **Active at Game Start** | **On**, Off | Determines if the target dummy is already moving when the game starts. |
| **Speed** | Super Slow, Very Slow, Slow, **Medium**, Fast, Very Fast, Super Fast | Determines how fast the target dummy moves on the track. |
| **Target Facing Direction** | Forward, Left, **Right**, Backward | Determines which direction the target faces while moving on the track. |
| **Continuous Movement** | **On**, Off | Determines whether the target moves to the end of the track and stops, or if it keeps moving continuously. |
| **Movement Hold Time** | **Don't Stop**, pick a number | If **Continuous Movement** is set to **On**, this determines how long the target dummy waits at the end of the track before continuing to move. |
| **Move on Proximity** | ***On***, Off | Determines whether the player needs to get close to the target dummy before it starts to move. If this is set to **Off**, the **Movement Start Range** option does not display. |
| **Movement Start Range** | **1.0 Tile**, pick a number | Determines how close a player must get, measured in tiles, before the target dummy starts moving. |
| **Movement Start Delay** | **1.0 Second**, pick or enter a number | Determines how much time passes before the target starts moving. |
| **Target Type** | **Standing**, Loser, Dancing, Husk, Crouching, Teddy Bear, Panda Head, Hands on Hips, Tomato Head, Llama, Pumpkin Head, Husky, Tall Round, Round | Determines what the target looks like. |
| **Score Value** | **1**, pick or enter a positive or negative number | Determines how much to add to a player's score for a normal hit. |
| **Score Bullseye Multiplier** | **1**, pick a number | Applies a multiplier to the score award if a player hits the bullseye. |
| **Bullseye Knockdown** | On, **Off** | Determines if a bullseye hit knocks down a target dummy, regardless of the target dummy's health. |
| **Bullseye Size** | Small, **Medium**, Large | Determines the size of the area that counts as a bullseye hit. |
| **Infinite Health** | On, ***Off*** | Determines if the target dummy has infinite health. If this is set to **On**, the **Starting Health** option does not display. Also, if the target dummy has infinite health, the only way to knock it down is to hit the bullseye. |
| **Starting Health** | **1**, pick a number | Determines how much health the target dummy has. |
| **Show Health Bar** | **On**, Off | Determines whether to show the health bar for the target dummy. |
| **Scores for Team** | **All**, pick or enter a team | Determines which teams can earn a score award by shooting this target. |
| **Start Position** | **Up**, Down | Determines whether the target is in the up or down position when the game starts. |
| **Hinge from Center** | On, **Off** | Determines where the target is hinged for standing up. |
| **Infinite Pop-ups** | **On**, *Off* | Determines how many times the target can stand back up after it knocks itself down (hides). If this is set to **Off**, the **Maximum Pop-ups** option displays. |
| **Maximum Pop-ups** | **0**, pick a number | Determines the maximum number of times the target will stand back up, excluding resetting after being knocked down. |
| **Infinite Resets** | **On**, Off | Determines if the target has an infinite number of times it can reset after being knocked down. If this is set to **Off**, another option displays. |
| **Maximum Resets** | **0**, Pick a number | Determines the number of times a target can reset after being knocked down. Values range from 1 to 10. |
| **Reset Time Type** | ***On Timer***, Never, *Random* | Determines if and when a target is reset after being knocked down. Depending on the value of this option, additional options may display or be hidden. |
| **Reset Time** | **2 seconds**, Pick a number | This option only displays if the **Reset Time Type** option is set to **On Timer**. Determines how long the target will wait after being knocked down before it resets. |
| **Random Reset Minimum Time** | **1 second**, Pick a number | This option only displays if the **Reset Time Type** option is set to **Random**. Determines the minimum amount of time the target will wait before resetting after it is knocked down. If this is set to a value higher than the **Random Reset Maximum Time** option's value, this option will default to one second. |
| **Random Reset Maximum Time** | **10 seconds**, Pick a number | This option only displays if the **Reset Time Type** option is set to **Random**. Determines the maximum amount of time the target will wait before resetting after it is knocked down. If this is set to a value lower than the **Random Reset Minimum Time** option's value, this option will default to 10 seconds. |
| **Pop Up Delay Type** | ***On Timer***, Never, *Random* | Determines if and when the target dummy target can stand back up after it hides. |
| **Time Before Pop Up** | **2 seconds**, Pick a number | This option only displays if the **Pop Up Delay Type** option is set to **On Timer**. Determines how long the target will wait to pop-up after it hides. |
| **Random Pop Up Minimum Time** | **1 second**, Pick a number | This option only displays if the **Pop Up Delay Type** option is set to **Random**. Determines the minimum amount of time the target will wait after hiding before popping back up. If this is set to a value higher than the **Random Pop Up Maximum Time** option's value, this option will default to one second. |
| **Random Pop Up Maximum Time** | **10 seconds**, Pick a number | This option only displays if the **Pop Up Delay Type** option is set to **Random**. Determines the maximum amount of time the target will wait after hiding before popping back up. If this is set to a value lower than the **Random Pop Up Minimum Time** option's value, this option will default to 10 seconds. |
| **Time Before Hiding Type** | On Timer, **Infinite**, *Random* | Determines if and when the target will hide. If this is set to **Infinite**, the target will never hide. Depending on the value of this option, additional options may display or be hidden. |
| **Random Hide Minimum Time** | **1 second**, Pick a number | This option only displays if the **Time Before Hiding Type** option is set to **Random**. Determines the minimum amount of time the target will wait before hiding. If this is set to a value higher than the **Random Hide Maximum Time** option's value, this option will default to one second. |
| **Random Hide Maximum Time** | **10 seconds**, Pick a number | This option only displays if the **Pop Up Delay Type** option is set to **Random**. Determines the maximum amount of time the target will wait before hiding. If this is set to a value lower than the **Random Hide Minimum Time** option's value, this option will default to 10 seconds. |
| **Hopping Frequency Type** | *On Timer*, **No Hopping**, *Random* | Determines if and when the target will hop up. If this is set to **No Hopping**, the target will never hop up. Depending on the value of this option, additional options may display or be hidden. |
| **Hopping Frequency Time** | **1 second**, Pick or enter a number | This option only displays if the **Hopping Frequency Type** option is set to **On Timer**. Determines how often a standing target will hop up. |
| **Random Hop Minimum Time** | **0.5 seconds**, Pick or enter a number | This option only displays if the **Hopping Frequency Type** option is set to **Random**. Determines the minimum amount of time the target will wait before hopping up. If this is set to a value higher than the **Random Hop Maximum Time** option's value, this option will default to 0.5 seconds. |
| **Random Hop Maximum Time** | **3.0 seconds**, Pick or enter a number | This option only displays if the **Hopping Frequency Type** option is set to **Random**. Determines the minimum amount of time the target will wait before hopping up. If this is set to a value lower than the **Random Hop Minimum Time** option's value, this option will default to 3.0 seconds. |
| **Hop Length Type** | On Timer, **Infinite**, *Random* | Determines if and when the target will drop down after hopping up. If this is set to **Infinite**, the target will never drop down. Depending on the value of this option, additional options may display or be hidden. |
| **Random Hopped Minimum Time** | **0.5 seconds**, Pick or enter a number | This option only displays if the **Hop Length Type** option is set to **Random**. Determines the minimum amount of time the target will wait before dropping down from a hop. If this is set to a value higher than the **Random Hopped Maximum Time** option's value, this option will default to 0.5 seconds. |
| **Random Hopped Maximum Time** | **3.0 seconds**, Pick or enter a number | This option only displays if the **Hop Length Type** option is set to **Random**. Determines the maximum amount of time the target will wait before dropping down from a hop. If this is set to a value lower than the **Random Hopped Minimum Time** option's value, this option will default to 3.0 seconds. |
| **Damage Type** | **Object**, Player | Determines whether weapons treat the target dummy as an object or a player when calculating damage values. |
| **Number Display** | Off, **Show Damage**, Bullseye Only, Score | Determines if damage numbers are displayed on the screen. The default displays the damage done to the target. **Bullseye Only** displays when a player hits the bullseye. **Score** displays the player's score instead of damage. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Move to End When Receiving From** | This function starts moving the target to the end of the track when an event occurs. |
| **Move to Start When Receiving From** | This function starts moving the target to the start of the track when an event occurs. |
| **Enable Track Movement When Receiving From** | This function enables movement on the track when an event occurs. This does not restart movement. |
| **Disable Track Movement When Receiving From** | This function disables movement on the track when an event occurs. This prevents movement from occurring on the track until it is enabled again. |
| **Pop Up When Receiving From** | This function stands the target up when an event occurs. |
| **Pop Down When Receiving From** | This function hides the target when an event occurs. |
| **Hop Up When Receiving From** | This function makes the target hop up from a standing position when an event occurs. |
| **Hop Down When Receiving From** | This function makes the target drop down from a hop when an event occurs. |
| **Reset When Receiving From** | This function resets the target to standing when an event occurs. |
| **Activate Track When Receiving From** | This function activates movement on the track when an event occurs. |
| **Deactivate Track When Receiving From** | This function deactivates movement on the track when an event occurs. |

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
