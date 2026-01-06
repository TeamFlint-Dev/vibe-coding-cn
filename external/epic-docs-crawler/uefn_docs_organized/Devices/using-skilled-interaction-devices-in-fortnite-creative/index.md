# Skilled Interaction Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-skilled-interaction-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:39:33.839554

---

Use the **Skilled Interaction** device to create skill-based interactions as mini-games for your players. Customize this device's settings to create good, perfect, or bad zones for players to target, which can trigger individual events attached to other devices.

## Interaction Types

You can alter this device's settings to create charge and release, timed, and quick press interactions.

### Charge and Release

The following settings were altered to create a skilled interaction where players can press and hold a command to target good and perfect zones that grant success when hit.

[![Modified Settings](https://dev.epicgames.com/community/api/documentation/image/06758608-184c-4299-a688-1179a096b13e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06758608-184c-4299-a688-1179a096b13e?resizing_type=fit)

*Click image to expand.*

### Timed

The following settings were altered to create an interaction where players must hit a set target at the correct time.

[![Modified Settings](https://dev.epicgames.com/community/api/documentation/image/7890cff0-12a9-4225-8eb5-0c0022348519?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7890cff0-12a9-4225-8eb5-0c0022348519?resizing_type=fit)

### Quick Press

[![](https://dev.epicgames.com/community/api/documentation/image/edbf0582-80fe-4d3f-9a21-ea41e3bff6f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/edbf0582-80fe-4d3f-9a21-ea41e3bff6f4?resizing_type=fit)

The following settings were altered to create an interaction to target moving zones.

[![Modified Settings](https://dev.epicgames.com/community/api/documentation/image/393301bc-e868-4dba-a110-e29af4ee45d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/393301bc-e868-4dba-a110-e29af4ee45d7?resizing_type=fit)

For help on how to find the Skilled Interaction device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

## Single and Multiplayer

The Skilled Interaction device includes the options for single and multiplayer skill checks.

Activating one of the **Queue Execution Type** options enables multiplayer quick time events. For multiplayer, if there is no room for that round, players are placed in a queue based on the order that they join. You set the queue limit with the **Maximum Queued Players** option. If there are no active players at the time of the call for interaction, then the player skips to the interaction.

[![Multiplayer quick time event diagram](https://dev.epicgames.com/community/api/documentation/image/d3920d18-880b-4fb7-9536-a0f34cc4caf3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d3920d18-880b-4fb7-9536-a0f34cc4caf3?resizing_type=fit)

Multiplayer quick time event diagram

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs, we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like setting the text position and orientation. You can also adjust the device's timer and the number of tries shown for players.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Header Text** | Enter text | Displays the main text for the interaction. |
| **Description Text** | Enter text | Sets the text for the interaction. |
| **Text Position** | **Top**, Bottom, Left, Right | Displays the text position relative to the meter. |
| **Interaction Type** | **Normal**, Charge and Release | Displays the type of interaction for the device. **Normal** is an automatic animation, which triggers upon button press. **Charge and Release** animates while holding down the button and triggers upon release. |
| **UI Type** | **Circular**, Pulsing, *Bar* | Sets the type of user interface to display. |
| **Widget Orientation** | Vertical, **Horizontal** | Determines whether the meter displayshorizontally or vertically. |
| **Movement Speed** | **50%**, Pick or enter a value | Determines how fast the meter moves across the interaction in percent per second. |
| **Good Zone Size** | **50%**, Pick or enter a value | Sets the good zone's size as a percent of the total meter. |
| **Good Zone Position** | **50%**, Pick or enter a value | Sets the position of the good zone. |
| **Position Zone Randomly** | *On*, **Off** | Determines whether the good zone positions itself randomly. |
| **Perfect Zone Size** | **25%**, Pick or enter a value | Determines the perfect zone's size as a percent of the good zone. |
| **Perfect Zone Position** | **50%**, Pick or enter a value | Determines the position of the perfect zone. |
| **Allowed Team** | **Any**, Pick or enter a team number | Determines which team can activate the device. |
| **Allowed Class** | **Any**, Pick or enter a class number | Determines which class can activate the device. |
| **Invert Team Selection** | On, **Off** | If set to **Off**, only the selected team can activate the device. If set to **On**, all teams except the selected team can activate the device. |
| **Invert Class Selection** | On, **Off** | If set to **Off**, only the selected class can activate the device. If **True**, all classes except the selected class can activate the device. |
| **Interaction Label** | Enter text | Determines the text label shown on the input panel. |

|  |  |  |
| --- | --- | --- |
| **Meter Thickness** | **40**, Pick or enter a value | Determines the thickness in pixels for the circular type. |
| **Set Custom Size** | *On*, **Off** | If set to **On**, the meter will use the custom width and height. |
| **Meter Custom Width** | **72**, Pick or enter a value | Determines the width of the meter. |
| **Meter Custom Height** | **72**, Pick or enter a value | Determines the height of the meter. |
| **Movement Type** | **Linear**, Pingpong, *Wiggle* | Determines the different movement patterns for the meter. |
| **Wiggle Time Min** | **0.5 Seconds**, Pick or enter a value | Sets the minimum wiggle time before movement. |
| **Wiggle Time Max** | **1.0 Second**, Pick or enter a value | Sets the maximum wiggle time before movement. |
| **Perfect Input Behavior** | **Instant Success**, Counts For Two, No Special Behavior | Determines what should happen when a perfect input occurs. |
| **Speed Up on Subsequent Interacts** | **Off**, Pick or enter a value | Determines how much to speed up on subsequent successful interactions. Resets when the device is retriggered. |
| **Shrink Zones on Subsequent Interacts** | **Off**, Pick or enter a value | Determines how much to shrink the zone on subsequent interactions. Resets when the device is retriggered. |
| **Success Target** | *None*, **1**, 2, 3, 4, 5 | Sets how many successful inputs are required for the minigame to complete. |
| **Show Successes** | *On*, **Off** | Determines whether to display the success counter on screen. |
| **Success Counter Icon** | **Checkmark**, Select an Icon | Determines the icon to use for the **Success Target** indicator. |
| **Success Counter Color** | **White**, Pick a color | Determines the color of the **Success Target** indicator. |
| **Failure Limit** | *None*, **1**, 2. 3, 4, 5 | Determines how many times a bad input can be provided before failing the minigame. |
| **Show Failures** | On, **Off** | Determines whether to display the fail counter on screen. |
| **Fail Counter Icon** | **X**, Pick an icon | Determines the icon to use for the **Fail Limit** indicator. |
| **Clear Successes on Fail** | On, **Off** | If set to **On**, the **Interaction Success Count** resets on a bad input. |
| **Lock Out on Fail Time** | **1.0 Seconds**, Pick or enter a value | If a bad input is provided, the interact will lock for the amount of time set. Set to **0** to disable this function. |
| **Interact Time Limit** | **Off**, Pick or enter a value | Sets how long the player has to complete the interaction. Taking too long will result in failure. |
| **Show Timer** | ***On***, Off | If set to **On**, the timer will display on the screen. |
| **Timer Position** | **Top**, Bottom | Sets the timer's position. |
| **Timer Color** | **White**, Pick a color | Determines the timer's color. |
| **Timer Size** | **Normal**, Large | Determines the timer's size. |
| **Timer Background Type** | None, **Transparent**, Opaque | Sets the transparency level of the timer's background. |
| **Starts Enabled** | **On**, Off | Determines whether or not the device is enabled automatically. |
| **Custom Widget** | **Don't Override**, Pick a widget | Select a custom widget to use for the interaction. |
| **Screen Anchor** | **Center**, Pick a position | Determines where on the screen the UI will align and anchor to. |
| **Placement Horizontal** | **0.0**, Pick or enter a position | Determines how far away from the anchor the widget will be. Negative numbers will move to the left. |
| **Placement Vertical** | **0.0**, Pick or enter a position | Determines how far away from the anchor the widget will be. Negative numbers will move upwards. |
| **Background Color** | **Black**, Pick a color | Sets the background color. |
| **Background Opacity** | **80%**, Pick or enter an amount | Sets the background opacity as a percentage. If **0%**, there will be no background shown. |
| **Background Corners Type** | Square, **Round** | Sets the type of background color to apply. |
| **Meter Color** | **Blue**, Pick a color | Determines the meter's color. |
| **Good Zone Color** | **Blue**, Pick a color | Determines the good zone's color. |
| **Perfect Zone Color** | **Blue**, Pick a color | Determines the color of the perfect zone. |
| **Scrubber Color** | **White**, Pick a color | Determines the color of the meter scrubber. |
| **Hide HUD** | **On**, Off | If set to **On**, the HUD will be hidden when the interaction is active. |
| **Interact Complete Sound** | Pick a sound | Sets the sound that plays when the minigame is completed successfully. |
| **Interact Failure Sound** | Pick a sound | Sets the sound that plays when the minigame is completed unsuccessfully. |
| **Interact Interrupted Sound** | Pick a sound | Sets the sound that plays when the minigame is interrupted. |
| **Good Input Sound** | Pick a sound | Sets the sound that plays when a player hits within the success zone. |
| **Perfect Input Sound** | Pick a sound | Sets the sound that plays when a player hits within the perfect zone. |
| **Bad Input Sound** | Pick a sound | Sets the sound that plays when a player hits outside the success zone. |
| **Minigame Start Sound** | Pick a sound | Sets the sound that plays when the minigame starts. |
| **Minigame Looping Sound** | Pick a sound | Sets a looping sound that plays during the interaction. |
| **Looping Audio Pitch Multiplier** | **1.0**, Pick or enter a multiplier | Sets a pitch multiplier for the looping sound. This will increase by the selected amount each time a player gets a successful or perfect interaction. It will reset when the minigame is restarted. |
| **Allow Duplicate Player Entries** | On, Off | Determines if a player can make duplicate entries in the queue. Useful for re-initiating skill checks without restarting the quick time event. |
| **Next in Queue Delay** | 3 | Sets the time between a player finishing an interaction and starting a new skill check with players from the queue. |
| **Queue Execution Type** | None, Synchronous, Random, Sequential | Sets the order for completing the quick time event.   - **Synchronous**: Plays the skill check at the same time. - **Random:**Plays the skill check for one player. - **Sequential**: Plays the skill check in the order players joined. |
| **Synchronous Player Limit** | 5 | Sets the max number of players completing the skill check at the same time. This skips any duplicate entries. |
| **Maximum Queued Players** | 20 | Sets the total number of players that can join the queue for the event. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device and then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the device's function.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Begin Interaction for Instigator** | Activates the interaction for the instigating player. |
| **End Interaction for Instigator** | Deactivates the interaction for the instigating player. |
| **Enable** | Enables the device on triggered. |
| **Disable** | Disables the device on triggered. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to that device's function.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Interact Success Transmit on Event** | Sets the event when the interaction is successful. |
| **On Interact Fail Transmit on Event** | Sets the event when the interaction is failed, either because of bad inputs or timeout. |
| **On Interact Bad Input Transmit on Event** | Sets the event when the player provides abad input. |
| **On Interact Good Input Transmit on Event** | Sets the event when the player provides a good input. |
| **On Interact Perfect Input Transmit on Event** | Sets the event when the player provides a perfect input. |
| **On Interact Interrupted Transmit on Event** | Sets the event when the interaction is interrupted, either due to player elimination, manual deactivation, or disabled. |
