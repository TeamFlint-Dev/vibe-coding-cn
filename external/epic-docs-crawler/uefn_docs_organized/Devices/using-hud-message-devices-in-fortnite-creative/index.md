# HUD Message Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:45:49.421340

---

The **HUD Message** device displays messages to all players or specific ones, either through a trigger from another device or through a timer from the start of a [round](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the **Description** field for that option.

## Device Options

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Message** | Enter text and format text | Click the **Format Styles** tab to choose a style for your text. A list of styles available is on the right. Each individual word must be clicked to select, then clicked again to de-select it. When you want to apply a style, click every word you want to have that style. If you want some words to have one style, and other words to have a different style, make sure you de-select previously selected words before selecting new words for the next style.  [Format Styles Tab](https://dev.epicgames.com/community/api/documentation/image/17ede5c8-d00e-44e0-81af-7570027b0d1e?resizing_type=fit) |
| **Show on Round Start** | **Off**, *On* | Determines if the message automatically appears at the start of a round. If you set this to **On**, another option displays below this one. |
| **Time From Round Start** | Off, **10 seconds**, Pick an amount of time | This only displays if the **Show on Round Start** option is set to **On**. Displays the message based on the length of time after the round starts. |
| **Background Opacity** | **0\%**, Pick or enter a percentage | Determines the opacity of the message's background. By default, the background is transparent. |
| **Background Color** | **#2600CE**, Pick a color swatch | If you have set a background opacity in the **Background Opacity** option, this determines the color of the background. Click the color swatch to open the Color Picker. Each color swatch has its Hex Code next to the swatch. You can also type a Hex Code into the Search bar to find a specific color. Select a color, then click the checkmark.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/3a50c2ac-ce34-47ba-8695-692507abfebf?resizing_type=fit) |
| **Message Recipient** | All, [Friendlies](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), [Enemies](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), Triggering Player, Pick or enter a team number | Determines which players receive the HUD message. |
| **Show for Duration** | *Timed*, Permanent | Determines whether the device shows the message for a specific period of time. If you choose Timed, the Display Time option displays below this one. |
| **Display Time** | 5 seconds, Permanent, Pick an amount of time | This option only displays if the Show for Duration option is set to Timed. Determines how long the message id displayed. |
| **Text Style** | Default, Pick a style | Determines the style applied to the message text when it is displayed. |
| **Play Sound** | Message - Important, Pick a sound | Determines which sound should accompany the message when it is displayed. |
| **Placement** | Bottom Center, Top Center, Center Right, *Custom* | Choose where in the HUD the message displays. If you choose Custom, several additional options are displayed below this one. |
| **Screen Anchor** | Top Left, Top Center, Top Right, Center Left, Center, Center Right, Bottom Left, Bottom Center, Bottom Right | This option is only displayed if you have the Placement option is set to Custom. Determines where on the screen the message is anchored, as well as the alignment of the message itself. |
| **Placement Horizontal** | **0**, Pick a positive or negative number | This option is only displayed if you have the Placement option is set to Custom. Determines how far away, in pixels, the message is from the anchor point set in the Screen Anchor option. Positive numbers move it to the right, negative numbers move it to the left. |
| **Placement Vertical** | **0**, Pick a positive or negative number | This option is only displayed if you have the Placement option is set to Custom. Determines how far away, in pixels, the message is from the anchor point set in the Screen Anchor option. Positive numbers move it upward, negative numbers move it downward. |
| **HUD Widget** | Basic, Critical | Determines the visuals of the HUD message. |
| **Layer** | **0**, Pick a layer number | Determines what layer the message displays on. Only one message at a time will display on a layer, and any other messages set to that layer will be queued. Setting messages to different layers causes multiple messages to be displayed simultaneously. |
| **Priority** | **5**, Display Immediately, Pick or enter a priority number | Determines the priority for this message. Messages with a lower number (such as 1) are a higher priority, and will move any displayed message on the same layer to a queue. If you choose Display Immediately the message will display immediately and ignore any other messages. |
| **Allow Multiple in Queue** | **Off**, On | By default, a message will only be queued if the device doesn't already have a message in the queue, or a message already displayed. If you choose On, you can have multiple messages queued on this device. |
| **Show Behavior If Showing** | **Reset Display Time**, Replay, Ignore | Determines what happens if the device is directed to display a message when that message is already displayed. |
| **Queue Timeout** | **Don't Queue**, Pick an amount of time | If a message is queued because a higher priority message is being displayed, this determines how long the message remains in the queue. |
| **Queue Message for Join In Progress Players** | **On**, Off | Determines if this message is queued and then displayed to players that join the game while it is in-progress. This takes into account the value set for the Queue Timeout option. |
| **Re-Evaluate Messages On Show** | **Off**, On | When a message is ready to be displayed, this determines if it is checked to make sure it is still relevant. This is useful if players can change class or team during the game, or otherwise become ineligible to see a message. |
| **Intro Animation** | **None**, Zoom, Fade and Zoom, Fade, Reverse Zoom, Bounce, Slow Zoom, Slow Fade and Zoom, Slow Fade, Slow Reverse Zoom, Slide From Top, Slide From Bottom, Slide From Left, Slide From Right | Determines how the HUD Message is animated as it displays. |
| **Outro Animation** | **None**, Zoom, Fade and Zoom, Fade, Reverse Zoom, Bounce, Slow Zoom, Slow Fade and Zoom, Slow Fade, Slow Reverse Zoom, Slide From Top, Slide From Bottom, Slide From Left, Slide From Right | Determines how the HUD Message is animated as it is removed. |
| **Text Style Set** | **Don't Override**, Default, Legacy HUD | Determines the style set for the text.   - Don't Override: This uses the text style set in the My Island settings. - Default: This uses the new default style for the HUD Message device. - Legacy HUD: This uses the text style from the old HUD Message device. |
| **Override Default Text Style** | On, **Off** | Determines if the device uses the text style set in the Text Style Set option, or if you can customize the text style. If this is set to On, multiple additional options are displayed that allow you to customize the text style. |
| **Text Color** | **White**, Pick a color swatch | This option is only displayed if Override Default Text Style is set to On. Determines the color of the text in the HUD Message. Click the swatch to open the Color Picker. This is similar to the Color Picker for Background Color, but has names for colors rather than Hex Codes. Select a color, then click the checkmark to close the Color Picker. |
| **Shadow Offset** | **1**, Pick or enter a number | This option is only displayed if Override Default Text Style is set to On. Determines the drop-shadow offset amount. |
| **Outline Strength** | 1, Pick or enter a number | This option is only displayed if Override Default Text Style is set to On. Determines the outline strength on the text. |
| **Size** | **18**, Pick or enter a size | This option is only displayed if Override Default Text Style is set to On. Determines the font size of the text. |
| **Text Justification** | Left, Center, Right, Invariant Left, Invariant Right | Determines which side the text is aligned to. If you choose **Invariant Left** or **Invariant Righ**t, the text aligns to that side no matter what language the text is displayed in. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the functions and events for this device.

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Even**t to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Show When Receiving From** | This function displays the HUD message when an event occurs. If more than one device or event can display message, you can click the **Add** button for this option, which adds another line. |
| **Hide When Receiving From** | This function hides the message. If more than one device or event can hide the message,you can click the **Add** button for this option, which adds another line. |
| **Clear Layer When Receiving From** | This function clears all text layers when an event occurs. If more than one device or event can clear all layers, click the **Add** button to add another line. |

### Events

This device has no events.
