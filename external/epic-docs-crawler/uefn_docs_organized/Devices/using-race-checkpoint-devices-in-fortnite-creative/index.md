# Race Checkpoint Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-race-checkpoint-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:39:39.654531

---

You can use the **Race Checkpoint** to place a series of [checkpoints](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#checkpoint) on a map for ground, air, and even foot-race games.

For help on how to find the **Race Checkpoint** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite-creative/rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like allowing players to pass through the checkpoint without a vehicle, or allowing specific vehicles to pass.

You will find ways to customize things like checkpoint color and visibility under advanced functionality.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

### Basic

| Option | Value | Description |
| --- | --- | --- |
| **Allow Players to Pass without Vehicle** | **Yes**, No | If [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), allows players not in vehicles to pass through this checkpoint. |
| **Allowed Vehicles** | **All**, None, Ground Vehicles, Air Vehicles, Water Vehicles | If enabled, allows either all vehicles or certain vehicle types to pass through this checkpoint. |

### Advanced

| Option | Value | Description |
| --- | --- | --- |
| **Set Checkpoint to Highest Value** | **No**, *Yes* | If **YES**, makes the checkpoint the last in the race when the device is saved. |
| **Checkpoint Number** | Select a Checkpoint Number | Passing this checkpoint unlocks the next one, which has a higher sequence number. |
| **Inactive Checkpoint Color Type** | Direct Color, *Team Color*, *Team Relationship Color* | Determines a checkpoint's color when it's not the current target and not yet passed. If set to **TEAM RELATIONSHIP**, the color a player sees will be based on whether their Team can pass this. |
| **Inactive Checkpoint Color** | **White**, Pick a Color | The checkpoint's color when it isn't the current target and not yet passed. |
| **Current Checkpoint Color Type** | **Direct Color**, *Team Color*, *Team Relationship Color* | Determines a checkpoint's color when it's the current target. If set to **TEAM RELATIONSHIP**, the color a player sees will be based on whether their Team can pass this. |
| **Current Checkpoint Color** | **Apple Green**, Pick a color | Sets the color value while the checkpoint is the player's current target. |
| **Completed Checkpoint Color Type** | **Direct Color**, *Team Color*, *Team Relationship Color* | Determines a checkpoint's color once it's been passed. If set to **TEAM RELATIONSHIP**, the color a player sees will be based on whether their Team could have passed this. |
| **Completed Checkpoint Color** | **Sky Blue**, Pick a color | Determines the Direct Color used for a completed checkpoint. |
| **Visible Prior to Race Start** | **First Only**, No, Yes | Determines if the checkpoint is visible prior to the start of the race. |
| **Checkpoint Visible when Passed** | **No**, Yes | After a player passes the checkpoint, determine if the checkpoint should remain visible. |
| **Activating Team** | **Any**, Pick a Number | The team that can activate the checkpoint. |
| **Allowed Class** | No Class, **Any**, Pick a number | Determines which [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class-identifier) can activate the device. |
| **Play Audio** | **Yes**, No | When a checkpoint changes state (like pass or fail), play an audio cue. |
| **Enabled During Phase** | **Always**, None, Pre-Game Only, Gameplay Only, Create Only | Enable the device during a specific [phase](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase). The Pre-Game phase includes all phases before the Game starts, including *Waiting for players in the lobby for Featured Islands* and *The Game Start countdown* |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/direct-event-binding) options for this device

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/function) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Set as Current Checkpoint When Receiving From** | Sets this checkpoint as the current target for the player. Will start the race if it's not currently active. This ignores checks for Vehicles. Will only function if the players is not already past this point in the race. |
| **Disable When Receiving From** | Disables the device. |
| **Enable When Receiving From** | Enables the device. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Checkpoint Becomes Current For The First Time Send Event To** | Sends an Event to linked devices when this checkpoint becomes the next checkpoint players need to pass for the first time. |
| **On Checkpoint Becomes Current Send Event To** | Sends an Event to linked devices when this checkpoint becomes the next checkpoint players need to pass. |
| On Checkpoint Completed Send Event To | Sends an Event to linked devices when a player passes this checkpoint. |
