# Attribute Evaluator Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-attribute-evaluator-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:47:19.780970

---

The **Attribute Evaluator** only works with signals received from other devices. It acts as [branching logic](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), and checks whether the player that sent the signal passes all of the tests that are set up for this trigger. Then the [trigger](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) sends a signal on either a success channel or a failure channel. With this trigger, you can test whether a player has reached a specific condition, and determine what happens when that occurs.

The attribute evaluator checks against the stats of the player at the point it is activated. If it receives a signal from an event that changes one of the player's stats (for example, if it receives a signal from the Elimination Manager that a player has just eliminated an enemy), the player's stats might not have been updated from that event. See [Loo Roll Rush](https://dev.epicgames.com/documentation/en-us/fortnite/loo-roll-rush-in-fortnite-creative) for an example of this problem.

  For help on how to find the **Attribute Evaluator** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

## Device Options

You can configure this device with the following options.

Default values are in **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Activating Team** | **Any**, Pick or enter a number. | Determines which team can activate the device. This replaces the Affects Team option. |
| **Invert Team Selection** | **Off**, On | If set to **On**, the device will count all teams except the selected team. |
| **Activating Class** | **Any**, Pick or enter a number | Determines which class can activate the device. This replaces the Affects Class option. |
| **Invert Class Selection** | **Off**, On | If set to **On**, the device will count all but the selected class. |
| **Min Player Eliminations** | **0**, Pick or enter a number | Set the minimum amount of eliminations the instigating player must have to pass this check. |
| **Tracked Stat** | **Score**, Select a stat | Determines which statistic this device will track for the **Team Stat** and **Player Stat** options. |
| **Min Player Stat** | **0**, Pick or enter a number | Sets the minimum amount of score the instigating player must have to pass this check. |
| **Min Team Stat** | **0**, Pick or enter a number | Sets the minimum amount of score the instigating player's team must have to pass this check. |
| **Enabled at Game Start** | **On**, Off | Determines whether the device is enabled when the game starts. |
| **Times Can Trigger** | **Infinite**, Pick a number | Determines how many times the device can be triggered before it is disabled. |
| **Trigger Delay** | **Instant**, Pick or enter a number | Determines the length of time the device will wait between being triggered and sending a signal. This option replaces the Delay option. |
| **Reset Delay** | **None**, Pick an amount of time | After the device is activated, it is disabled for this amount of time before being usable again. |
| **Visible In Game** | **On**, Off | Determines whether the device is visible during the game. |
| **Trigger SFX** | **Enabled**, Disabled | Determines if audio effects are played when the device is activated. |
| **Trigger VFX** | **On**, Off | Determines whether visual effects are displayed when the device is activated. |
| **Transmit Every X Trigger** | **1**, Pick or enter a number | Sets the device to only send a signal after being triggered the specific number of times. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) for this device.

### Functions

A [**function**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event and select the event that triggers this function.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. Select the device and event that will enable the device. If more than one device or event can enable the device, you can click the **Add** button for this option, which adds another line. |
| **Disable When Receiving From** | This function disables the device when an event occurs. Select the device and event that will disable the device. If more than one device or event can disable the device, you can click the **Add** button for this option, which adds another line. |
| **Reset Times Triggered When Receiving From** | This function resets the number of times the device has been activated (to reset the **Transmit Every X Triggers** and **Times Can Trigger** options). |
| **Evaluate Player When Receiving From** | This function evaluates players against the list of attributes when receiving an event. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the Add button and repeat.

| Option | Description |
| --- | --- |
| **On Pass Send Event To** | When a player passes a check, the device sends an event to the selected device. |
| **On Fail Send Event To** | If a player fails a check, the device send an event to the selected device. |

## Gameplay Examples Using Attribute Evaluators

- [Tug of War](https://dev.epicgames.com/documentation/en-us/fortnite/tug-of-war-in-fortnite-creative)
- [Loo Roll Rush](https://dev.epicgames.com/documentation/en-us/fortnite/loo-roll-rush-in-fortnite-creative)
- [Top Scorer In Class](https://dev.epicgames.com/documentation/en-us/fortnite/top-scorer-in-class-in-fortnite-creative)
