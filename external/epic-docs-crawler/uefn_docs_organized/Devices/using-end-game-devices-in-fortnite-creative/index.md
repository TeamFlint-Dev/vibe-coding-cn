# End Game Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:44:21.206223

---

You can set the **End Game** device to end either the current [round](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) or the entire game, and determine which team met the conditions for the [win condition](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

This device can be activated by another device using [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

  To find the End Game device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device reference documents we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like displaying custom victory callouts and determining which team wins the game as well as more advanced functions.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

Use the options below to customize this device.

| Option | Value | Description |
| --- | --- | --- |
| **What to End** | End Round, **End Game** | When activated, it determines whether the round ends or the entire game ends. |
| **Winning Team** | **Winning Team**, Activating Team, Pick a team | Determines which team will win when the device is activated. Requires the selected team to have at least one player. Use the arrows to choose a team, or click in the field to type in a team number. |
| **Custom Victory Callout** | Enter text | Enter a message to be displayed on victory or cooperative game end. The field has a 150-character limit. |
| **Custom Defeat Callout** | Enter text | Enter a message to be displayed on the defeat screen. The field has a 150-character limit. |
| **Game End Callout** | **You Win/Lose**, Placement, Cooperative | This determines what displays on the game-end screen. By default, it displays **You Win** or **You Lose**. If you choose **Cooperative**, everyone is shown the same game-end screen, which uses the sound selected in the **Victory Sound** setting and the text entered in the **Custom Victory Callout** setting. |
| **Enabled at Game Start** | **Enabled**, Disabled | Determines if this device is enabled when the game is started. |
| **Activating Team** | **Any**, Pick a team | Determines which team can activate the device. Use the arrows to choose a team, or click in the field to type in a team number. |
| **Allowed Class** | No Class, **Any**, Pick a class | Determines which class can activate the device. Use the arrows to choose a class, or click in the field to type in a class number. |
| **Post Game Type** | **Classic**, Battle Royale, *Custom* | **Classic** uses the Creative game-end screen. If you choose **Battle Royale**, your game uses the Fortnite Battle Royale game-end screen. If you choose **Custom**, more options display that you can use to customize the game-end screen. |
| **Custom Show Scoreboard** | **Off**, On | Determines whether the scoreboard is displayed at the end of the game. This option only displays if you set the **Post Game Type** as **Custom**. |
| **Custom Victory Animation Style** | **Lightning Bolts**, Pick a style | Determines the style used for the custom victory game-end animation. Only displays if **Post Game Type** is **Custom**. |
| **Custom Victory Animation Color Set** | **Golden Yellow**, Pick a color | Determines the color set used for the custom Victory game-end animation. Only displays if **Post Game Type** is **Custom**. |
| **Custom Victory Animation Text** | Enter text | Type in the text you want displayed at game-end for the ictory condition. The text field is limited to 15 characters. Only displays if **Post Game Type** is **Custom**. |
| **Custom Victory Animation Sub Text** | Enter text | Type in [flavor text](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) displayed at game end for the victory condition. The text field is limited to 84 characters. |
| **Custom Defeat Animation Style** | **Lightning Bolts**, Pick a style | Determines the style used for the custom defeat game-end animation. |
| **Custom Defeat Animation Color Set** | **Golden Yellow**, Pick a color | Determines the color set used for the custom defeat game-end animation. |
| **Custom Defeat Animation Text** | Enter text | Type in the text you want displayed at game end for the Defeat condition. The text field is limited to 15 characters. |
| **Custom Defeat Animation Sub Text** | Enter text | Type in flavor text displayed at game end for the Defeat condition. The text field is limited to 84 characters. |
| **Custom Tie Animation Style** | **Lightning Bolts**, Pick a style | Determines the style used for the custom tie game-end animation. Only displays if **Post Game Type** is **Custom**. |
| **Custom Tie Animation Color Set** | **Golden Yellow**, Pick a color | Determines the color set used for the custom tie game-end animation. Only displays if **Post Game Type** is **Custom**. |
| **Custom Tie Animation Text** | Enter text | Type in the text you want displayed at game end for the tie condition. The text field is limited to 15 characters. Only displays if **Post Game Type** is **Custom**. |
| **Custom Tie Animation Sub Text** | Enter text | Type in flavor text to display at game end for the tie condition. The text field is limited to 84 characters. Only displays if **Post Game Type** is **Custom**. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listns for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Activate When Receiving From** | Ends the round or game when an event occurs. |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |

### Events

This device has no events.
