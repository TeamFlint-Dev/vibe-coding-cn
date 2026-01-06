# Random Number Generator Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-random-number-generator-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:29:41.902837

---

The **Random Number Generator** device randomly rolls a number in the range between two numbers you choose. The result can then be [transmitted](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to other devices to activate them.

You also have an option to use a [volume](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#volume) to trigger other devices placed within the volume.

For help on how to find the **Random Number Generator (RNG)** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

The device options determine the value limits for the number rolled, the winning value, and other details of the device's appearance and behavior.

In its [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#default) state, this device rolls a number from 1 to 6 when the player steps onto it. Its default outcome does nothing, since no signals are transmitted unless options are set.

Default values are in **bold**. Values that trigger contextual filtering are *italic*.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Value Limit 1** | **0**, Pick a number | Defines the minimum number the device can roll. |
| **Value Limit 2** | **6**, Pick a number | Defines the maximum number the device can roll. |
| **Winning Value** | **4**, Pick a number | If the device rolls a number equal to or higher than this value, it's a win. |
| **Pick Each Number Once** | **No**, Yes (Reset on Game Start), Yes (Reset on Round Start) | Once a number is chosen. don't choose it again until there are no more numbers to pick. The numbers will reset either on round start or game start, depending on the value set in this option. |
| **Activating Team** | **Any,** Pick a number | Determines which Team can activate the device. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Roll Time** | Instant, **3 seconds**, Pick an amount of seconds | How long the device takes after it starts calculating to determine a result. |
| **Reset After Use** | **On**, *Off* | Determines if the device will reset after it has been used. If false, the device will disable itself after use, and must be enabled to use again. |
| **Reset Delay** | Never Reset, **Instant**, Pick an amount of time | The amount of time it takes for the device to be ready after it is activated. If you select **Never Reset**, the device will be disabled after it has been activated once. |
| **Award Score** | **Never**, *Always*, *On Win*, *On Loss* | Defines when [score](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#score) is awarded. |
| **Result Multiplier** | **1**, Pick a number | Multiplies the roll's result by the selected value. This is mainly used for awarding a Score. |
| **Score Type** | **Add**, Subtract, Set | Defines how score is awarded. |
| **Score Value** | **Roll Amount**, Pick a number | Defines the amount of score awarded. |
| **Zone Direction** | **None**, *Forward*, *Left*, *Right*, *Backwards* | Determines if there is a zone associated with the device, and if there is which direction the zone lies. |
| **Length** | **4**, Pick a number | Sets the length of the volume in tiles. This length will be split into a number of equal sections based on the number of potential outputs. |
| **Width** | **Normal (1.0)**, Pick a number | Sets the width of the volume in tiles. |
| **Height** | **Normal (1.0)**, Pick a number | Sets the height of the volume in tiles. |
| **Visible During Game** | **Yes**, No | Determines whether or not the device is visible during the game. |
| **Play Audio** | **Yes**, No | Determines whether or not the device plays a sound. |
| **Activating Team** | **Any**, Pick a number | Determines which team can activate this device. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines which phases in which the device will be enabled. Pre-Game includes all phases prior to the game starting. |
| **Activate on Game Phase** | **None**, Waiting for Players, Game Countdown, Game Start | Activates the device during the selected game phase. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/function) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device, allowing it to generate numbers. |
| **Disable When Receiving From** | Disables the device, stopping it from being able to generate numbers, and cancelling any active rolls. |
| **Cancel When Receiving From** | Cancels any in progress generation. |
| **Activate When Receiving From** | Starts generating a random number. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Win Send Event To** | Sends an event to any linked devices when a winning score is rolled. |
| **On Lose Send Event To** | Sends an event to any linked devices when a losing score is rolled. |
| **On Rolled Max Send Event To** | Sends an event to any linked devices when the maximum score is rolled. |
| On Rolled Min Send Event To | Sends an event to any linked devices when the minimum score is rolled. |
