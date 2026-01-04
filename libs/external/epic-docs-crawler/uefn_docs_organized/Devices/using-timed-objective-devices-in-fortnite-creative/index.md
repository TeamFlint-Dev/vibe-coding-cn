# Timed Objective Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:35:54.470177

---

The Timed Objective device is for [game modes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-mode) where players can start or stop timers to advance [gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gameplay) [objectives](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#objective), such as Attack/Defend Bomb objectives.

For help on how to find the **Timed Objective** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

When the device is placed, any player can [enable](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#enable) or disable it. It is in its holographic state until initially started, then will appear and count down. Any team can pause the timer and interact with it. The timer will appear on the HUD.

Default values are **bold**.

### Basic Options

| Options | Value | Description |
| --- | --- | --- |
| **Time** | **10 Seconds**, Pick a time | Sets the length of the timer for the objective. |
| **Start Score** | **None**, Pick a score | Sets the amount of score awarded for successfully starting an unstarted timer. |
| **Stop Score** | **None**, Pick a score | Sets the amount of score to be awarded for successfully stopping an active timer. |
| **Completed Score** | **None**, Pick a score | Sets the amount of score to be awarded when the timer is complete. |

### All Options (Additional)

| Options | Value | Description |
| --- | --- | --- |
| **Start When Round Starts** | **No**, Yes | Determines whether the timer should start automatically at the beginning of each round. |
| **Timer Label Text** | Enter Text | Specifies custom text to be displayed along with the timer countdown. The text field has an 80 character limit. |
| **Timer Label Text Style** | Default, **Bold**, Pick a style | Sets the style for the countdown display and custom text. |
| **Hologram Until Activated** | No, **Yes** | Determines whether the objective device appears as a hologram until activated. |
| **Visible During Game** | No, **Yes** | Determines whether the device is visible during the game. |
| **Countdown Visible on HUD** | No, **Yes** | Determines whether the timer countdown is displayed on the player's HUD. |
| **Completion Behavior** | **Disable**, Reset, Restart | Determines what the device should do when the timer completes.   - **Disable**: The device is disabled and cannot be used again until reset. - **Reset**: The timer is reset and the device can be used again immediately. - **Restart**: The timer is reset and the countdown begins again immediately. |
| **Urgency Mode** | Disabled, **Enabled** | Determines whether the device will enter Urgency mode when the timer gets close to the end. Urgency mode changes the timer's audio and visual effects to reflect the short time remaining. |
| **Urgency Mode Start Time** | **5**, Pick a time | Sets the remaining counter time at which the device will enter Urgency mode. |
| **Start Team Filter** | None, **All**, Pick a team | Determines which team can start an unstarted timer. |
| **Start Interact Text** | Insert Text | Defines custom text to be displayed as a prompt for a player who can start an unstarted timer. The text field has an 80 character limit. |
| **Start Interact Time** | Instant, **3 Seconds**, Pick a time | Determines the length of interaction required to start an unstarted timer. |
| **Stop Team Filter** | None, **All**, Pick a team | Determines which team can stop an active timer. |
| **Stop Interact Text** | Insert Text | Defines custom text to be displayed as a prompt for a player who can stop an active timer. The text field has an 80 character limit. |
| **Stop Interact Time** | Instant, **3 Seconds**, Pick a time | Determines the length of interaction required to stop an active timer. |
| **Restart Team Filter** | None, **All**, Pick a team | Determines which team can restart a stopped timer. |
| **Restart Interact Text** | Insert Text | Defines custom text to be displayed as a prompt for a player who can restart a stopped timer. |
| **Restart Interact Time** | Instant, **3 Seconds**, Pick a time | Determines the length of interaction required to restart a stopped timer. |
| **Restart Score** | **None**, Pick a score | Sets the amount of score to be awarded for successfully restarting a stopped timer. |
| **Pausing Team Filter** | **None**, All, Pick a team | Determines which team can pause an active timer. |
| **Pause Interact Text** | Insert Text | Defines custom text to be displayed as a prompt for a player who can pause an active timer. The text field has an 80 character limit. |
| **Pause Interact Time** | Instant, **3 Seconds**, Pick a time | Determines the length of interaction required to pause an active timer. |
| **Pause Score** | **None**, Pick a score | Sets the amount of score to be awarded for successfully pausing an active timer. |
| **Resuming Team Filter** | **None**, All, Pick a team | Determines which team can resume a paused timer. |
| **Resume Interact Text** | Insert Text | Defines custom text to be displayed as a prompt for a player who can resume a paused timer. |
| **Resume Interact Time** | Instant, **3 Seconds**, Pick a time | Determines the length of interaction required to resume a paused timer. |
| **Resume Score** | **None**, Pick a score | Sets the amount of score to be awarded for successfully resuming a paused timer. |
| **Show Time On Maps** | **Off**, Both, Minimap, Overview Map | Determines whether the timer should be displayed on the Minimap or Overview Map. |
| **Mesh Options** | **None**, Explosive Attachment | Selects any visual additions to the device. |
| **Audio Effects** | Off, **On** | Determines whether the device will play audio effects during the game. |
| **Activation Sound** | Off, **On** | Determines whether the device will play a sound when activated. |
| **Activation Sound Distance** | Whole Map, **Nearby** | Determines whether the activation sound is localized or audible anywhere on the map. |
| **Deactivation Sound** | Off, **On** | Determines whether the device will play a sound when deactivated. |
| **Deactivation Sound Distance** | Whole Map, **Nearby** | Determines whether the deactivation sound is localized or audible anywhere on the map. |
| **Completion Sound** | Off, **On** | Determines whether the device will play a sound when complete. |
| **Completion Sound Distance** | Whole Map, **Nearby** | Determines whether the completion sound is localized or audible anywhere on the map. |
| **Timer Sound** | Off, **On** | Determines whether the device will play a sound to represent the timer. |
| **Timer Sound Distance** | Whole Map, **Nearby** | Determines whether the timer sound is localized or audible anywhere on the map. |
| **Maintain Interaction While Looking Around** | **Off**, On | Allows players who are interacting with this device to look around without cancelling interaction. |
| **If Instigating Player Is Not Present** | **Use Empty Instigator**, Pick A Random Player | This determines what player instigated the signal when the instigating player is no longer in the game. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/function) listens for an event on a device, and then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the Add button to add a line and repeat these steps.

| Options | Description |
| --- | --- |
| **Start When Receiving From** | Starts the timer when an event occurs. |
| **Stop When Receiving From** | Stops the timer when an event occurs. |
| **Resume When Receiving From** | Resumes the timer when an event occurs. |
| **Complete When Receiving From** | Completes the timer when an event occurs. |
| **Show When Receiving From** | Makes the device visible when an event occurs. |
| **Hide When Receiving From** | Makes the device invisible when an event occurs. |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Pause When Receiving From** | Pauses the timer when an event occurs. |
| **Restart When Receiving From** | Restarts the device when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite-creative/event) tells another device when to perform a function.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Options | Description |
| --- | --- |
| **On Paused Send Event To** | When the timer is paused, an event is sent to the selected device. |
| On **Stopped** Send Event To | When the timer is stopped, an event is sent to the selected device. |
| On **Resumed** Send Event To | When the timer is resumed, an event is sent to the selected device. |
| On **Completed** Send Event To | When the timer has completed., an event is sent to the selected device. |
| On **Started** Send Event To | When the timer is started, an event is sent to the selected device. |
| On **Restarted** Send Event To | When the timer has restarted, an event is sent to the selected device. |

## Design Examples

Here are some examples of how you can use the Timed Objective device.

- [Door Open](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)
- [Switch Delay](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)

### Door Open

One of the most useful functions of the Timed Objective is using it to send signals after a preset period of time.

**Devices used**:

- 1 x **Timed Objective**
- 2 x [Prop Mover](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative)

1. Create a simple enclosed arena. Use two props for the doors in a closed position.
2. Attach a **Prop Mover** device to each of the movable doors. Make sure to orient the movement arrow so each door opens in the appropriate direction. Customize them both to the following settings:

   [![Door Prop Movers](https://dev.epicgames.com/community/api/documentation/image/8efb751b-dd4b-4293-8dff-ecf10907d8f1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8efb751b-dd4b-4293-8dff-ecf10907d8f1?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Distance | 2 Meters | The doors will move 2 meters. |
   | Speed | 1 Meter/Second | The doors will move at 1 m/s. |
   | Time From Start | Off | The Prop Movers will not automatically activate after an amount of time has elapsed from the start of the round. |
   | On Prop Collision Behavior | Continue | Any contact with other props that the doors make while moving will be ignored. |
   | Prop Damage On Collision | None | Props impacted by the doors will not take damage. |
3. Place a **Timed Objective** device anywhere on the island. Customize it to the following settings:

   [![Door Timed Objective Settings](https://dev.epicgames.com/community/api/documentation/image/335cf03a-d9cf-4485-ac07-9b78a51d1336?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/335cf03a-d9cf-4485-ac07-9b78a51d1336?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Timer Label Text | Doors Open In... | This HUD message is shown during the timer countdown. |
   | Urgency Mode Start Time | 3 | The countdown sounds become more noticeable with 3 seconds left. |
4. Set the direct event bindings of the Timed Objective to the following:

   [![Door Timed Objective Events](https://dev.epicgames.com/community/api/documentation/image/a974185f-864b-4845-9b69-44666ee9b5f8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a974185f-864b-4845-9b69-44666ee9b5f8?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Completed Send Event To | DoorPropMover1, DoorPropMover2 | Start | When the Timed Objective completes, the doors will begin moving. |

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **DoorPropMover1, DoorPropMover2** | Start | **TimedObjective** (w:95) | On Completed Send Event To | When the Timed Objective completes, the doors will begin moving. |

You now have the basic functionality for sending delayed signals from the Timed Objective device.

There are countless ways to take advantage of the Timed Objective device to delay signals anywhere from seconds to minutes. From causing events to take place at a predetermined time after the start of the game to starting the countdown from a separate signal, it’s an essential part of the Creative toolset that's easy to use and offers a lot of flexibility.

Use direct event binding to start your countdowns on a signal from another device, and make sure **Completion Behavior** is set to **Reset** or **Restart** if you want it to be usable more than once.

### Switch Delay

Another form of gameplay you can explore is creating switches that will start an interruptible countdown after a brief interaction, allowing players to try to control a point long enough to end a round in their favor.

**Devices used**:

- 1 x **Timed Objective**
- 1 x [**Switch**](using-switch-devices-in-fortnite-creative)
- 1 x [**End Game Device**](using-end-game-devices-in-fortnite-creative)

1. Create a small arena with a place for a Switch device where it can be contested.
2. Place a **Switch** and customize it to the following settings:

   [![Switch Delay Switch Settings](https://dev.epicgames.com/community/api/documentation/image/5313516e-1a43-45a5-beca-469fbe51f8c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5313516e-1a43-45a5-beca-469fbe51f8c7?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Initial State | On | The Switch will begin in the on position. |
   | Turn On Text | Activated Counter! | This text is shown when the device is in the on state. |
   | Turn Off Text | Deactivated Counter! | This text is shown when the device is in the off state. |
   | Device Model | Antique Lever | The Switch will appear as an Antique Lever in game. |
   | Interact Time | 3 Seconds | It will take 3 seconds of interaction to change the state of the Switch. |
3. Place a **Timed Objective** device anywhere on the map and customize it to the following settings:

   [![Switch Delay Timed Objective Settings](https://dev.epicgames.com/community/api/documentation/image/1633772e-bc2e-4575-aa82-ec8dbae1600c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1633772e-bc2e-4575-aa82-ec8dbae1600c?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Time | 15 Seconds | The timer will take 15 seconds to complete. |
   | Timer Label Text | Team A wins in... | The HUD will display this text during the timer countdown. |
   | Timer Sound Distance | Whole Map | The timer can be heard throughout the entire map regardless of player proximity. |
4. Place an **End Game Device** anywhere on the island. Customize it to the following settings:

   [![Switch Delay End Game Device](https://dev.epicgames.com/community/api/documentation/image/2ab7ea34-71da-4ce2-9386-d78841b97194?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2ab7ea34-71da-4ce2-9386-d78841b97194?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Custom Victory Callout | Team A wins via timeout! | If the timer concludes, then Team A is the victor and this message will be shown. |
5. Set the direct event bindings of the Switch to the following:

   [![Switch Delay Switch Events](https://dev.epicgames.com/community/api/documentation/image/aee79acb-e86a-4ed9-a069-db9ee58ed2ba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aee79acb-e86a-4ed9-a069-db9ee58ed2ba?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Turned On Send Event To | TimedObjective | Start | When the Switch is turned on, the Timed Objective will start. |
   | On Turned Off Send Event To | TimedObjective | Stop | When the Switch is turned off, the Timed Objective will stop. |
6. Set the direct event bindings of the Timed Objective to the following:

   [![Switch Delay Timed Objective Events](https://dev.epicgames.com/community/api/documentation/image/c47dc329-2b0a-4f7e-ba85-89a553278442?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c47dc329-2b0a-4f7e-ba85-89a553278442?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Completed Send Event To | EndGameDevice | Activate | When the Timed Objective successfully completes, the End Game Device will end the game. |

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **TimedObjective** (w:95) | Start | **Switch** | On Turned On Send Event To | When the Switch is turned on, the Timed Objective will start. |
| **TimedObjective** (w:95) | Stop | **Switch** | On Turned Off Send Event To | When the Switch is turned off, the Timed Objective will stop. |
| **EndGameDevice** | Activate | **TimedObjective** (w:95) | On Completed Send Event To | When the Timed Objective successfully completes, the End Game Device will end the game. |

You now have the basic functionality to create an interruptible countdown with a Timed Objective device.

It is very common to use the **Start** function and **On Completed Send Event To** event when connecting a Timed Objective to other devices. The method shown here can be an alternative to point-building [domination](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#domination)-style games, where a point only needs to be held for 15 seconds without the player who's interacting getting eliminated.

There could be multiple places unlocked before the End Game Device is triggered, with high-speed gameplay based around more competition on the Switch than other devices.

## Gameplay Examples Using Timed Objective

- [Loadout Lobby](loadout-lobby-in-fortnite-creative)
- [Random Sentry Fight](random-sentry-fight-in-fortnite-creative)
- [Search and Destroy Bomb](search-and-destroy-bomb-in-fortnite-creative)
