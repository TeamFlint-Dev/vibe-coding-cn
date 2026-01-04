# Score Manager Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:47:43.943781

---

With the **Score Manager** device, creators can manipulate scores using triggers. By using channel messages, the Score Manager can communicate with a variety of devices. Creators can use this to award scores in many ways, creating many varieties of gameplay.

For help on how to find the **Score Manager** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the Event [Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

In its default state, the Score Manager does nothing. It must be activated by receiving a signal from a specific channel.

You can configure this device with the following options.

Default values are bold. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Score Value** | **1**, Pick or enter a number | When this device is triggered, award the selected amount of score to the player. Values range from -2 billion to +2 billion. |
| **Score Award Type** | None, **Add**, Subtract, Set | Determines how score is awarded to players. |
| **Activating Team** | **Any**, Pick or enter a team | Defines which team can activate this device. |
| **Times Can Trigger** | **Infinite**, Pick a number | Determines how many times this device can trigger before it is disabled. |
| **Increment Score on Awarding** | **On**, Off | Determines if the device uses the Score Increment to update the Score amount when the the device awards the player a score. |
| **Score Change when Activated** | **0**, -200 to 200 | After the first activation of this device, adjust the score awarded by the selected value for each activation. |
| **Minimum Score** | **No Limit**, Pick or enter a number | Determines the minimum amount of score this device can award in a single instance. Values range from -2 billion to +2 billion. |
| **Maximum Score** | **No Limit**, Pick or enter a number | Determines the maximum amount of score this device can award in a single instance. Values range from -2 billion to +2 billion. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the phase in which the device is enabled. |
| **Visible In Game** | **No**, Yes, Only Number | Determines whether or not the device is visible in the game. |
| **Use Static Hologram** | On, **Off** | If this is set to **On**, the Score Hologram will stay in place instead of always facing the player. |
| **Send Event On Score** | **999**, Pick or enter a number | When this device awards the specified score, send an event to devices linked to the **On Score Output event**. |
| **Play Audio** | **On**, Off | Determines whether the device should play audio effects. |
| **Display Score Update on HUD** | *On*, **Off** | Determines whether score updates are displayed as a HUD message. If you choose **On**, several additional options are displayed below this one in the Customize panel. |
| **Reset HUD Message Score** | **Off**, On | When the device displays a score message on the HUD, this determines whether it starts at zero. |
| **HUD Message** | **Score!**, Enter text | Determines what message is displayed on the HUD with the score. Use the default, or enter custom text. The text field has a limit of 150 characters. |
| **HUD Message Score Color** | **#BFEBFFFF**, Pick a color | Determines the color of the score displayed on the HUD. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/6d608ccb-879a-4a1d-8502-604d718c0bfc?resizing_type=fit) |
| **HUD Message Color** | **#00BAFFFF**, Pick a color | Determines the color of the text in the message you set in the **HUD Message** option. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a Hex code in the Search bar to find that color. |
| \*\*Display Score Update if Score is 0 | On, **Off** | Determines if the Score Update still displays if the output score is 0. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Activate When Receiving From** | Activates the device when an event occurs. |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Reset When Receiving From** | Resets the device when an event occurs. |
| **Increment When Receiving From** | Activate without sending score, and increment (increase) the score value when an event occurs. |
| **Decrement When Receiving From** | Activate without sending score, and decrement (decrease) the value when an event occurs. |
| **Set To Player Score When Receiving From** | Sets the score on the device to the score of the activating player when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Max Triggers Transmit To** | When this device reaches its maximum number of triggers as defined by the **Times Can Trigger** option, it sends an event to the selected device. |
| **On Score Output Transmit To** | When this device awards the score defined by the **Send Event on Score** option, it sends an event to the selected device. |

## Gameplay Examples Using Score Manager Devices

[![Dungeon Crawler Example](https://dev.epicgames.com/community/api/documentation/image/4fb5d247-2083-431e-9864-f750140f0b9f?resizing_type=fit&width=640&height=640)

Dungeon Crawler Example

Use Capture Areas to create zones that teams must capture and hold to gain points.](https://dev.epicgames.com/documentation/en-us/fortnite/dungeon-crawler-gameplay-example-in-fortnite-creative)[![Top Scorer In Class](https://dev.epicgames.com/community/api/documentation/image/782e9cbf-5056-400c-8660-03a565fdd808?resizing_type=fit&width=640&height=640)

Top Scorer In Class

Use the Class Designer and other devices to create player classes with different abilities.](https://dev.epicgames.com/documentation/en-us/fortnite/top-scorer-in-class-in-fortnite-creative)

[**Event Browser**](https://dev.epicgames.com/edc/manage/assets/event-browser-in-fortnite-creative)
