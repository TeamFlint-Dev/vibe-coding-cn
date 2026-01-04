# Color Changing Tile Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-color-changing-tile-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:42:56.311418

---

The **Color Changing Tile** device creates a tile that changes colors when players interact with it.

When this device is first [placed](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), it is a neutral color. When a player steps on the tile or drives a vehicle over it, the tile switches to the color of the player’s team, and remains that color until a player in another team steps on it or drives over it.

This tile can be rotated in all three [axes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), but [traps](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [trick tiles](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) cannot be attached to it.

For help on how to find the **Color Changing Tile** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

**Looking for more inspiration?** See the [Color Changing Tile Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/using-color-changing-tile-device-design-examples-in-fortnite-creative) to jumpstart your imagination!

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device reference documents we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled At Game Start** | **Enabled**, Disabled | Defines whether the device is [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) with color change functionality when the game starts. |
| **Starting Team** | **Neutral**, Pick a team | Defines the initial team this tile is assigned to. |
| **Revert Tile** | **Off**, *On* | A tile that changes to the team color when stepped or driven on by a team player, then reverts to its original color. When set to **On**, the **Time Until Reverting** option displays. |
| **Time Until Reverting** | **1 Second**, Pick or enter an amount | Defines the amount of time (in seconds, minutes and hours) until the tile reverts back to the initial color. |
| **Score** | **0**, Pick or enter a score amount | Defines the amount of score awarded when ownership is taken by a team. |
| **Steal Score** | Yes, **No** | Defines whether the score awarded to the previous owning team will be removed. If set to **Yes**, the previous team will lose their score for this tile. |
| **Appearance** | **Concrete**, Disco | Sets the appearance of the tile. |
| **Visible During Game** | **Yes**, No | Determines if the tile is visible during the game. |
| **Collision During Games** | Off, **On**, Only When Visible | Determines whether the tile has collision properties during the game. If you choose **Only When Visible**, the tile only has collision when the **Visible During Game** option is set to **Yes**. |
| **Display Score Update on HUD** | **Off**, *On* | Determines whether score updates are displayed as a HUD message. If you choose **On**, several additional options display below this one. |
| **Reset HUD Message Score** | **Off**, On | This option only displays if the **Display Score Update on HUD** option is set to **On**. If this optino is set to **On**, the device resets the score to **0** when it displays a score message on the HUD. |
| **HUD Message** | **Score!**, Enter text | This option only displays if the **Display Score Update on HUD** option is set to **On**. Determines what message is displayed on the HUD with the score. Use the default, or enter custom text. The text field has a limit of 150 characters. |
| **HUD Message Score Color** | **#BFEBFFFF**, Pick a color | Determines the color of the score displayed on the HUD. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a hex code in the search bar to find that color. |
| **HUD Message Color** | **#00BAFFFF**, Pick a color | Determines the color of the text in the message you set in the **HUD Message** option. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a hex code in the search bar to find that color. |
| **Alternate Tile Shape** | **Don't Override**, *Flat Hexagon*, *Short Hexagon Column*, *Tall Hexagon Column* | By default, this is turned off and the tile is square. If you choose **On**, additional options display below this one. |
| **Alternate Tile Shape Icon** | **None**, Pick an icon | This option only displays if you have selected a shape in the **Alternate Tile Shape** option. Determines the icon displayed on top of the tile. Click the arrow to open the Icon Picker. You can click to select an icon, or enter the name in the **search bar** to find that icon. |
| **Icon visible at Game Start** | Off, **On** | This option only displays if you have selected a shape in the **Alternate Tile Shape** option. Determines whether the icon on the tile is visible at the start of the game. |
| **Alternate Tile Shape Starting Primary Color** | **#FFFFFF**, Pick a color | This option only displays if you have selected a shape in the **Alternate Tile Shape** option. Determines the starting primary color of the tile. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a hex code in the **search bar** to find that color. |
| **Alternate Tile Shape Starting Top Color** | **#FFFFFF**, Pick a color | This option only displays if you have selected a shape in the **Alternate Tile Shape** option. Determines the starting color of the top of the tile. Click the swatch to open the Color Picker. You can click to select a swatch, or enter a hex code in the **search bar** to find that color. |
| **Change Color on Player Contact** | **On**, Off | This option only displays if you have selected a shape in the **Alternate Tile Shape** option. Determines whether the tile changes color when a player touches it. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to choose an event that will trigger the selected function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the color changing tile when an event occurs. |
| **Disable When Receiving From** | Disables the color changing tile when an event occurs. |
| **Reset When Receieing From** | When an event occurs, resets the color changing tile. |
| **Set Team When Receiving From** | Sets the color of the tile to the team of the player when an event occurs. |
| **Show When Receiving From** | Makes the device visible when an event occurs. |
| **Hide When Receiving From** | Makes the device invisible when an event occurs. |
| **Activate Glow When Receiving From** | Sets the top of the tile to glow when an event occurs. |
| **Deactivate Glow When Receiving From** | Turns off the glow when an event occurs. |
| **Show Icon When Receiving From** | Shows the alternative icon when an event occurs. |
| **Hide Icon When Receiving From** | Hides the alternative icon when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to choose a function triggered for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Activate Send Event To** | Sends an event when a tile changes color. |
