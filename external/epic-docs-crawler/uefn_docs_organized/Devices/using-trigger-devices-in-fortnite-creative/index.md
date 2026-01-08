# Trigger Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:43:15.696297

---

When a **Trigger** device is triggered by a player, vehicle or [sequencer](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), it can send a signal to another device that will initiate a specific action.

This device can be used with other devices, or alone.

For help on how to find the **Trigger** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Device Options

In its default state, the trigger is set to be activated by any player, vehicle, or Sequencer. Its trigger effect is to play a sound, and by default it is not set up to trigger on a channel. However, all of this can be configured with the following options.

Default values are **bold**.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Trigger Sound** | **Enabled**, Disabled | Determines whether a sound is played when the device is triggered. |
| **Visible in Game** | **Yes**, No | Determines whether the device is visible during the game. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Activating Team** | **Any**, Pick a team | Can only be activated by this team. |
| **Activating Class** | No Class, **Any**, Pick a class | Determines which [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) can activate the device. |
| **Invert Class Selection** | On, **Off** | If set, the device will count all but the selected class. |
| **Triggered by Player** | **On**, Off | Determines whether to trigger this channel when the player gets within the proximity of the device. |
| **Triggered by Damage** | **Off**, On | Determines whether to trigger this channel when the object is damaged. |
| **Triggered by Items** | **Off**, On | Determines whether to activate the trigger when an item hits it. This includes dropped items and projectiles. |
| **Triggered by Vehicles** | **On**, Off | Determines whether to activate the trigger when a Vehicles gets within proximity of the device. |
| **Triggered by Creatures** | On, **Off** | Determines whether or not to trigger this channel when a Creature or Wildlife gets within proximity of the device. |
| **Triggered by Sequencers** | **On**, Off | Determines whether to activate the trigger when it is touched by Sequencer or RNG device pulse. |
| **Triggered by Water** | **On**, Off | Determines whether or not to activate the trigger when it is touched by a Water device. |
| **Triggered by Carryable Objects** | On, **Off** | Determines whether or not carriable objects activate the trigger. |
| **Activate on Game Phase** | **None**, Game Countdown, Game Start | Sets the device to activate in the selected game phase. |
| **Times Can Trigger** | **Off**, On, Pick a number | The number of times this device can trigger before being disabled. |
| **Trigger Delay** | Pick a time interval | Determines the length of time the device will wait between being triggered and sending a signal. |
| **Transmit Every X Triggers** | **1**, Pick a number | Sets the device to only send a signal after being triggered the specified number of times. |
| **Reset Delay** | **None**, Pick a length of time | Specifies the length of time the device must wait after sending a signal before it can be triggered again. |
| **Trigger Sound** | Disabled, **Enabled** | Determines whether a sound is played when the device is triggered. |
| **Delayed Trigger Instigator Choice** | First, **Last**, Queue | Determines what happens when another player activates this trigger after it has already been activated and is waiting on a delay.  **First** will always send the first player that triggered this trigger.  **Last** will always send the most recent player that triggered the trigger.  **Queue** will send all players that have triggered this trigger from first to last. |
| **Receive Damage While Invisible** | **Do Not Take Damage**, Take Damage | Determines whether this object will take damage while it is hidden in a game. This will block projectiles from hitting things behind it. |
| **Enabled on Game Start** | **On**, Off | Determines whether the device is enabled when the game starts. |

### Physics-Enabled Options

The following options become available when [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) are enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Triggered by Physics Props** | On, **Off** | Determines whether to trigger events when a physics prop gets within range of the device. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/function) listens for an event on a device, and then performs an action.

| Option | Description |
| --- | --- |
| **Enable** | Enables the device. |
| **Disable** | Disables the device. |
| **Reset Times Triggered** | Resets the number of times the Trigger has been activated. |
| **Trigger** | Activates the trigger. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#event) tells another device when to perform a function.

| Option | Description |
| --- | --- |
| **On Triggered** | Sends an event to linked devices when the Trigger is activated. |

## Gameplay Examples Using Triggers

- [Color Switch Challenge](color-switch-challenge-in-fortnite-creative)
- [Loo Roll Rush](loo-roll-rush-in-fortnite-creative)
- [Storm Wars](https://dev.epicgames.com/documentation/en-us/fortnite/storm-wars-in-fortnite-creative)
- [Timed Door](timed-door-in-fortnite-creative)
