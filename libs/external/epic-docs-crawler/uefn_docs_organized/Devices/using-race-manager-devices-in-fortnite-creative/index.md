# Race Manager Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-race-manager-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:32:49.554561

---

When used with the [Race Checkpoint device](https://dev.epicgames.com/documentation/en-us/fortnite/using-race-checkpoint-devices-in-fortnite-creative), **Race Manager** provides a way for designers to create more advanced racing modes, including the following race management features.

- Tracks and displays the number of complete laps (or checkpoints)
- Tracks and displays lap and race times, including the record time

For help on how to find the **Race Manager** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, such as setting up the number of laps. Advanced functionality gives developers ways to customize display checkpoint markers, customize navigation arrows, and more.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Number of Laps** | **1**, Pick a Number | Specifies how many times the player needs to complete the active Race Checkpoints to complete the race. |
| **Start Race on Game Start** | **Yes**, No | Determines whether to immediately start the race when the game starts. |
| **Navigation Arrow On HUD** | **Visible**, Hidden | Makes the display arrow visible on the [heads-up display](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hud) (HUD). |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Race Circuit Name** | Enter Text | Displays this race name for players. |
| **Number Of Laps** | **1 Lap**, Pick a Number | How many times that player must complete the active sequence of Race Checkpoints to complete the race. |
| **Start Race On Game Start** | **Yes**, No | Determines whether or the not the race will immediately start when the game is started. |
| Navigation Arrow On HUD | **Visible**, Hidden | Determines whether or not to display the navigation arrow on the HUD during gameplay. |
| **Display Checkpoint Markers** | **Yes**, No | Displays markers [in-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#in-game) and on the map, showing players the location of active Race Checkpoints. |
| **Display Race HUD** | **Yes**, No | Determines whether the race progress is displayed during the race. |
| **Display Race Progress on HUD** | **Yes**, No | If set to **Yes**, the HUD displays how many laps the player has completed and the total number of laps in the race. If there are no laps in the game, the HUD displays the total number of Checkpoints instead. |
| **Display Race Time on HUD** | **Yes**, No | If set to **Yes**, the HUD displays the amount of time since the race started, as well as the player's most recent lap time. |
| **Display Best Lap Time on HUD** | **Yes**, No | If set to **Yes**, the HUD displays the player's best lap time. |
| **Update Lap Time Stat Each Lap** | **On**, Off | Determines if the Lap Time stat is updated per lap (if better than previous lap) or only at game end. |
| **Use Lap Time Stat As Initial Lap Time** | **Off**, On | When starting the race, determines if your existing lap time stat (if not **0**) is used for lap time. This allows players to carry lap times between multiple races. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/function) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Start Race When Receiving From** | Starts the race. |
| **Enable When Receiving From** | Turns on the device. |
| **Disable When Receiving From** | Turns off the device. |
| **End Race When Receiving From** | Ends the race. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Race Completed Send Event To** | Event that occurs when a player finishes a race. |
| **On Race Started by Manager Send Event To** | Event that occurs when a race is started by the Race Manager. |
| **On Lap Completed Send Event To** | Event that occurs when a player finishes a lap. |
| **On First Lap Completed Send Event To** | Event that occurs when a player finishes their first lap. |
