# Billboard Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-billboard-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:40:53.386868

---

You can use **Billboard** devices to display short messages to players in your game. These are useful for things like [onboarding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) players or providing [in-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) instructions.

Each message can be up to 150 characters long. You can also use multiple billboards throughout your island.

In addition to controlling the content, you can control the text size, font, justification, and text effects. You can also choose the color of the text and the background.

For help on how to find the **Billboard** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite). If you are using this in UEFN, you can find the device in the **Fortnite > Devices** folder.

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

This device has some basic functionality, like what text is displayed, the text size, and which font the text is using. There are also advanced options, like how far away players can read the billboard's text. In its [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) state, a Billboard device shows sample text, with invisible borders and a clear background.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Text** | Enter text | Type the message that you want to display on the billboard. While it is possible to enter up to 512 characters, how much of the text will display is influenced by both text size and the font used. |
| **Show Border** | On, **Off** | Controls whether the billboard's border is visible.  If you set the **Show Border** option to **Off**, the collision properties of the device will also be turned off. That means players will be able to walk through the billboard. If you want the billboard to be solid, set the **Show Border** option to **On**. |
| **Display Mode** | **One Sided**, Two Sided | Controls whether the text shows on one side only or on both sides of the billboard. |
| **Background Color** | **Clear**, Pick a color | Sets the background color. Click to open a color picker, then scroll to select a color or use the search box to filter colors. |
| **Text Justification** | **Left**, Center, Right | Controls the alignment of the text. |
| **Text Size** | **12 (Medium)**, Pick a size | This sets the size of the text on the billboard. Use the arrows to pick a text size, or click in the field to type in a text size. |
| **View Distance** | Pick a distance, **Infinite** | Set how far away in-game the text will be visible. This is measured in [tiles](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |
| **Text Color** | **Alto Gray**, Pick a color | Sets the color of the text. Click to open a color picker, then scroll to select a color or use the search box to filter colors. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Controls when the billboard can be viewed. [Pre-game Only](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) can only be used with [published](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) islands. |
| **Text Font** | Roboto, Burbank, **Notosans** | The font used. |
| **Outline** | **None**, Light, Thick | Sets the thickness of a black outline around the text on the billboard. |
| **Shadow** | **None**, Lower Left, Lower Right, Upper Left, Upper Right | This adds a drop shadow to the text in the direction you choose. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Set Text Hidden When Receiving From** | Sets the text as hidden when an event occurs. |
| **Set Text Visible When Receiving From** | Sets the text as visible when an event occurs. |
| **Update Display When Receiving Text Data When Receiving From** | Sets the billboard to display text that has been updated from another source when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

No events are currently used with this device.

## Gameplay Example Using Billboards

- [Color Switch Challenge](https://dev.epicgames.com/documentation/en-us/fortnite/color-switch-challenge-gameplay-example-in-fortnite-creative)
