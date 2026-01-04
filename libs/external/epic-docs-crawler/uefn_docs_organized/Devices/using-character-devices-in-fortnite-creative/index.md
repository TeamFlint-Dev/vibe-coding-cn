# Character Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-character-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:37:54.842468

---

A **Character** is a mannequin that you can use to create [NPC](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) characters that can interact with players in a game. You can tie its appearance or behavior to actions by a player or events caused by other devices.

  To find the Character device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This device has some basic functionality, like selecting a character and pose. There are also some advanced options, like determining the type of interaction.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Character** | **Creative Mannequin**, Pick a character | Determines which character is displayed. You can choose from over 100 different characters. |
| **Use Animated Idle** | On, **Off** | Determines whether the character pose is animated when idle. If this is set to **On**, the **Idle (Animated)** option displays. If this is set to **Off**, the **Idle (Pose)** option displays. |
| **Idle (Pose)** | **Stand Tall**, Pick a pose | This option only displays when **Use Animated Idle** is set to **Off**. Determines the static pose the character uses. |
| **Idle (Animated)** | **Waiting**, Pick a pose | This option only displays when **Use Animated Idle** is set to **On**. Determines the animated pose the character uses. |
| **Emote** | **Beckon**, Pick an emote | Sets the character to use the selected emote when triggered. It plays once when triggered, without looping. |
| **Interact Type** | **Do Not Interact**, *Send Event Only* | Determines whether players can interact with the character. If set to **Send Event Only**, two additional options display below. |
| **Interaction Text** | **Interact**, Enter text in field | Type the text that the player sees into the text field. The default text is **Interact**, but you can use up to 150 characters to customize the message. |
| **Interact Time** | **Instant**, Pick a time in seconds | Determines how long the player must press the interact control in order to activate the character. |
| **Visible During Game** | **On**, Off | Determines whether the character can be seen during the game. If you want the character to appear only if certain things happen, choose **Off** and add **Turn On Visibility When Receiving From** under [Functions](https://dev.epicgames.com/documentation/en-us/fortnite/using-character-devices-in-fortnite-creative#functions). |
| **Character Slot** | **0**, Pick a slot | Assign this device to a Character Slot. If you use this device with a Character Device Controller, the controller can manage all Character devices with the same assigned Character Slot. |
| **Generate Overlap Events** | **On**, Off | Determines whether the character will generate overlap collision events with other devices. |
| **Random Idle Start** | On, ***Off*** | Determines whether the idle should start in a random position. If set to **Off**, additional options will display. |
| **Initial Idle Animation Position** | **0.0**, Select a number between 0.0 and 100.0 | Determines the position the character should start in. This option is only available if **Random Idle Start** is set to **Off**. |
| **Synchronize Animation** | On, **Off** | Determines if the character animation starts at the same time for all players, even if some are out of range when the animation starts. |
| **Enable Character Collision** | **On**, Off | Determines whether a character collide with other objects. |
| **Auto Register with Budget Allocator** | Allows the device to be registered or unregistered with the Animation Budget Allocator. |  |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Turn On Visibility When Receiving From** | Shows the character device and allows interaction when an event occurs. |
| **Turn Off Visibility When Receiving From** | Hides the character device and disables collision when an event occurs. |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Play Emote When Receiving From** | Plays the emote when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Interacted With Send Event To** | When this device is interacted with, either by a player or another device, it sends an event to the selected device and triggers the selected function. |
