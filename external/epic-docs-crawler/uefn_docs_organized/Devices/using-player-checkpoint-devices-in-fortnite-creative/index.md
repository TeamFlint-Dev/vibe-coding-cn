# Player Checkpoint Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:41:55.543280

---

The **Player Checkpoint Pad** sets a player's spawn point when activated and can also be used to clear player inventories.

  For help on how to find the Player Checkpoint device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Device Options

This device has some basic functionality, like playing sound effects and resetting inventories.

The default values are bold.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Visible in Game** | **On**, Off | Determines whether the device is visible during the game. This does affect its collision properties. |
| Reset Inventory | Yes, No | Determines whether the player's inventory is reset when they activate the checkpoint. |
| **Enabled During Phase** | None, **All**, Create Only, Game Countdown Only, Gameplay Only | Determines the game phases during which the device will be enabled. |
| **Activating Team** | **Any**, Pick a team | Determines which team can activate the device. |
| **Play Activate FX** | **On**, Off | Determines whether the device plays VFX and SFX when stepped on. |
| **Allowed Class** | No Class, **Any**, Pick a class | Determines which class can activate the device. |

## Direct Event Binding

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) listens for an event on a device then performs an action.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Activate When Receiving From** | Registers this checkpoint to the activating player when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On First Activation Per Player Transmit On** | Sends an event each time a new player activates the checkpoint for the first time. |
| **On First Activation Transmit On** | Sends an event the first time the checkpoint is activated by any player. |
