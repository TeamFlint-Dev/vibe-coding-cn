# Pop-Up Dialog Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-popup-dialog-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:36:19.389564

---

The **Pop-up Dialog** device is an interface you can use to make boxes of text appear in the [HUD](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hud) that players can interact with. The boxes can contain multiple lines of text. They use multiple choice or Yes-No responses. You can use these boxes in many ways:

- Create a way that players can vote on something.
- Display messages or instructions for the player.
- Display background information for objectives (when used with a Tracker device).
- Connect to invisible Class Selector devices and allow players to choose their class.
- Create dialog between the player and NPCs.

To find the Pop-up Dialog device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the **Description** field for that option.

## Device Options

This device has some basic functionality, like entering a title and description, and deterimning when the text will display. There are also advanced options, like how long the player has to interact with the text, the response type, and what text appears on the displayed buttons.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Title** | Enter text | Type in a title for the text box. The text field is limited to 32 characters. |
| **Content Alignment** | **Centered**, Pick an alignment | Click to open the Alignment Picker. You can pick a position and shape for the pop-up dialog. You can choose either a box, a banner that is the width or height of your screen, or full screen. If you choose a box or banner you can choose the position of the box or banner. |
| **Description** | Enter and format text | Click the **Edit Text** button to open a rich text editor that allows you to format the text that displays in the pop-up dialog.  Click the **Enter Text** tab to display a text field with a 350-character limit. Click **Clear Styles** if you have applied styles and want to remove them. Click **Clear Text** if you want to erase everything and start over.  [Edit Text Tab](https://dev.epicgames.com/community/api/documentation/image/3db3cdc6-3ef5-4bde-910d-3975fa6933f5?resizing_type=fit)  Click the **Format Styles** tab to choose a style for your text. A list of styles available is on the right. Each individual word must be clicked to select, then clicked again to de-select it. When you want to apply a style, click every word you want to have that style. If you want some words to have one style, and other words to have a different style, make sure you de-select previously selected words before selecting new words for the next style.  [Format Styles Tab](https://dev.epicgames.com/community/api/documentation/image/695bd14f-56b7-4fd8-836a-57d9c8975ac5?resizing_type=fit) |
| **Auto Display** | **Never**, Pregame Lobby, Game Start | Displays the text to all valid players that enter the selected phase. It also displays for players joining in progress during this phase. |
| **Use Dialog Timeout** | **Off**, *On* | Determines if the dialog automatically closes after a period of time. If this is set to **On**, two additional options display below this one. |
| **Timeout Duration** | **2.0**, Pick or enter a number | This option only displays if the **Use Dialog Timeout** option is set to **On**. Determines the amount of time the dialog box is displayed before automatically closing. |
| **Timer Options** | None, **Countdown** | This option only displays if the **Use Dialog Timeout** option is set to **On**. Determines if a countdown timer displays on the dialog box. |
| **Response Type** | *1 Button*, **2 Buttons**, *3 Buttons*, *4 Buttons*, *5 Buttons*, *6 Buttons* | Determines how many buttons are shown at the end of your Description text. You can choose up to 6 buttons, and customize the text on these buttons. Depending on how many buttons you choose here, a number of additional options will display below **Button 1 Text**, which allow you to customize the text on those additional buttons. |
| **Default Back Button** | None, Last Button, Button 1, **Button 2**, Button 3, Button 4, Button 5, Button 6 | You can set one of the buttons in the dialog to perform the "back" or "cancel" action. |
| **Button 1 Text** | **OK**, Enter text | Enter the text that displays on Button 1. The default text is "OK" and the text field is limited to 24 characters. |
| **Button 2 Text** | **Cancel**, Enter text | Enter the text that displays on Button 2. The default text is "Cancel" and the text field is limited to 24 characters. |
| **Button 3 Text** | Enter text | Enter the text that displays on Button 3. The text field is limited to 24 characters. |
| **Button 4 Text** | Enter text | Enter the text that displays on Button 4. The text field is limited to 24 characters. |
| **Button 5 Text** | Enter text | Enter the text that displays on Button 5. The text field is limited to 24 characters. |
| **Button 6 Text** | Enter text | Enter the text that displays on Button 6. The text field is limited to 24 characters. |
| **Text Box Opacity** | **100 percent**, Pick a percentage | Determines if the dialog's background is semi-transparent, and how transparent it is. |
| **Mask Background** | **No**, Yes | Determines if the background is darkened when the dialog is displayed. |
| **Enabled During Phase** | None, **All**, Pregame Only, Gameplay Only | Determines in which phases the device is enabled. **Pregame Only** includes all phases that occur before the game starts. |
| **Activating Team** | **Any**, Pick a team | Determines which team can activate the device. |
| **Invert Team Selection** | **False**, True | If you choose **False**, only the team chosen in the **Activating Team** option can activate the device. If you choose **True**, all teams can activate the device except the one chosen in the **Activating Team** option. |
| **Allowed Class** | No Class, **Any**, Pick a class | Determines which classes can activate the device. If you choose **No Class**, only players without an assigned class can activate it. If you choose **Any**, any player with an assigned class can activate it. |
| **Invert Class Selection** | **False**, True | If you choose **False**, only the class chosen in the **Allowed Class** option can activate the device. If you choose **True**, all classes are affected except the one chosen in the **Allowed Class** option. |

## Direct Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Show When Receiving From** | This function displays the pop-up dialog to valid players when an event occurs. |
| **Hide When Receiving From** | This function hides the dialog from valid players when an event occurs. |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Show To All When Receiving From** | This function displays the dialog to all players when an event occurs. |
| **Hide From All When Receiving From** | This function hides the dialog from all players when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Dismissed Send Event To** | When the dialog is dismissed, the device sends an event to the selected device, which triggers the selected function. |
| **On Time Out Send Event To** | When the dialog times out, the device sends an event to the selected device, which triggers the selected function. |
| **On Responding Button 1 Send Event To** | When a player responds using Button 1, the device sends an event to the selected device, which triggers the selected function. |
| **On Responding Button 2 Send Event To** | When a player responds using Button 2, the device sends an event to the selected device, which triggers the selected function. |
| **On Shown Send Event To** | When the dialog is shown, the device sends an event to the selected device, which triggers the selected function. |
| **On Responding Button 3 Send Event To** | When a player responds using Button 3, the device sends an event to the selected device, which triggers the selected function. |
| **On Responding Button 4 Send Event To** | When a player responds using Button 4, the device sends an event to the selected device, which triggers the selected function. |
| **On Responding Button 5 Send Event To** | When a player responds using Button 5, the device sends an event to the selected device, which triggers the selected function. |
| **On Responding Button 6 Send Event To** | When a player responds using Button 6, the device sends an event to the selected device, which triggers the selected function. |
