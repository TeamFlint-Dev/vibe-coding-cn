# Message Feed Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-message-feed-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:45:10.514890

---

The **Message Feed** device gives you the ability to send a short message to the player's message feed. In an [elimination confirmed](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#elimination-confirmed) [game mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-mode), this could be used to broadcast when eliminations are confirmed or when points are granted. For other game modes, such as [capture the flag](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#capture-the-flag) or [domination](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#domination), the feed could include messages about flags captured or returned, areas that change teams, or other events in a game. In fast-paced game modes, this device gives you the ability to provide players with an on-screen stream of information about rapidly changing conditions.

  For help finding the Helicopter Spawner device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

This device has some basic functionality, like creating a custom message, and choosing the color of the message. Additionally, there are some advanced options, like choosing which class or team generates messages in the feed.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| Enabled at Start | On, Off |  |
| **Message** | **Default Message**, enter text | Determines the message to display. The field is limited to 150 characters. Custom tags such as {Player Name} and {Icon} are supported. |
| **Message Color** | **Default**, Team Affinity, Team Color, Pick a color | Determines what color the message text displays in. You can match this to a team color or just pick different colors. |
| **Player Highlight Color** | **Default**, Team Affinity, Team Color, Pick a color | If you have used **{PlayerName}** in your message, this option determines if the message has a different color for an instigating player, compared to the other messages in the feed. |
| **Message Icon** | **None**, Pick an icon | Click the arrow to open the Icon Library Picker. You can select an icon by scrolling through the library, or by typing a word into the Search bar.  If you use **{Icon}** in your message, the icon selected here will be displayed in the message.  [Icon Library Picker opened](https://dev.epicgames.com/community/api/documentation/image/0900da1d-c6f2-4749-a58c-e4858270b8c8?resizing_type=fit) |
| **Message Visibility** | **All**, Friendlies, Enemies, Triggering Players, Pick or enter a team | Determines who can see the message feed. Make visible to all players, specify a team, choose Friendlies or Enemies, or make the message only available to the Triggering Player. |
| **Invert Message Visibility** | **Off**, On | If this is set to **On**, the value of the **Message Visibility** option determines who is **not** able to see the message feed. |
| Message Visibility by Class | Any, Pick or enter a class | Determines if the message feed is only visible to players assigned a specific class. |
| Invert Message Visibility by Class | Off, On | If this is set to On, the value of the Message Visibility by Class option determines who is not able to see the message feed. |
| Activating Team | Any, Pick or enter a team | Instigating players must be on the selected team to generate a message in the feed. |
| Invert Team | Off, On | If this is set to On, the value of the Activating Team option determines who does not generate a message in the feed. |
| Activating Class | Any, Pick or enter a class | Instigating players must be assigned the selected class to generate a message in the feed. |
| Invert Class | Off, On | If this is set to On, the value of the Activating Class option determines who does not generate a message in the feed. |

## Direct Event Binding

Below are the [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/function) listens for an event on a device then performs an action.

1. For any function option, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add**button and repeat.

| Option | Description |
| --- | --- |
| **Activate When Receiving From** | This function generates a message for the message feed when an event occurs. |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |

### Events

This device has no events.
