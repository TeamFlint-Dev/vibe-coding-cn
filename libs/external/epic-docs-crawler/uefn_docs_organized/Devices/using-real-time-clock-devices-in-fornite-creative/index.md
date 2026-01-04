# Real Time Clock Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-real-time-clock-devices-in-fornite-creative
> **爬取时间**: 2025-12-26T23:44:53.660534

---

The **Real Time Clock** can be used to connect things that happen in the game to time periods in the real world. Here are some things you can use this for in your game:

- Events in the game can be linked to time periods in the real world, so those things are only available to players during the day or at night.
- You can have the device display as a countdown timer to an event in your game, or it can show the real-world time.
- You can have tasks the player must do within a certain time period, such as feed a pet or grow a plant.
- You can keep players from entering an event until a certain time, with a countdown displaying how much time is left before the event starts.

For help on how to find the **Real Time Clock** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the **Description** field for that option.

## Device Options

This device has some basic functionality, like choosing the style of the clock face, and setting the time, date and year. Additionally, there are some advanced options, like choosing a time zone and setting the display mode.

You can configure this device with the following options.

Default values are **bold**. Values affected by contextual filtering are in *italic*.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Clock Face Style** | **Default**, Flat | Determines what the clock face looks like. |
| **Minute** | **0**, Pick an amount | Determines the minute this device triggers. |
| **Hour** | **0**, Pick an amount | Determines the hour this device triggers. |
| **Day** | **1**, Pick a day | Determines the day this device triggers. |
| **Month** | **1**, Pick a month | Determines the month this device triggers. |
| **Year** | **2021**, Pick a year | Determines the year this device triggers. |
| **Duration Type** | **Instant**, *Minutes*, *Hours*, *Days* | This option allows the clock to send a second signal after a period of time has passed. If a unit of time is selected, the **Duration Value** option displays and can be customized. |
| **Duration Value** | **1**, Pick a value | This option only displays if the **Duration Type** option is set to **Minutes**, **Hours** or **Days**. Determines the number of the selected time units that will pass before the second signal is sent. For example, if the Duration Type is Minutes, and the Duration Value is 2, the second signal will be sent after 2 minutes have passed. |
| **Number of Repeats** | **Don't Repeat**, *Pick a number* | Determines how many times the signal will repeat. If a number of repeats is selected, the **Repeat Type** and **Repeat Frequency** options display and can be customized. |
| **Repeat Type** | Hours, **Days**, Weeks, Months | This option only displays if the **Number of Repeats** option is set to a number. Determines the unit of time used in the cadence of repeated signals. |
| **Repeat Frequency** | **1**, Pick a number | This option only displays if the **Number of Repeats** option is set to a number. Determines how many times the signal repeats, based on the unit of time chosen in the **Repeat Type** option. For example, if the Repeat Type is set to **Days** and the Repeat Frequency is set to **2**, the signal will repeat every 2 days. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled At Game Start** | **Enabled**, Disabled | Determines whether the device is enabled when the game starts. |
| **Display Mode** | **Countdown**, Date | Shows a countdown to a date, or just the date. |
| **Time Zone** | **GMT** | Only Greenwich Mean Time is available. |
| **Instigator for Event** | **No Instigator**, Random Instigator, Send Event for All Players | Determines who is sent as the instigator for this device's On Time Reached and On Duration Elapsed events. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/function) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

|  |  |
| --- | --- |
| Enable When Receiving From | Enables the device on receiving a signal. |
| Disable When Receiving From | Disables the device on receiving a signal. |
| Respawn Vehicle When Receiving From | This function spawns the vehicle when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| On Time Reached Send Event To | When the target time is reached, transmit. |
| On Enabling After Time Reached Send Event To | When the device becomes enabled, if the target time has been reached, transmit. |
| On Enabling Before Time Reached Send Event To | When the device becomes enabled, if the target time has not been reached, transmit. |
| On Duration Elapsed Send Event To | Sends a signal when the specified duration has elapsed. Does nothing if Duration Type is set to **INSTANT**. |
