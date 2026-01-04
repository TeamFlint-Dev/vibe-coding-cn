# Player Reference Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-player-reference-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:40:10.148905

---

You can use the **Player Reference** device to relay player statistics to other devices and even to other players. Statistics such as the number of enemies the player has eliminated, the number of times the player is eliminated, or the player's scores can be transmitted by the device when certain conditions are met. The Player Reference can also project a hologram of the player and display text that can be altered in various positions and curvatures.

  For help on how to find the Vault device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite-creative/rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

This device has some basic functionality and can be customized to change the hologram animation and select which channel the device will register and clear data on.

You can configure this device with the following options.

Default values are **bold**.

### Device Options

| Option | Value | Description |
| --- | --- | --- |
| **Show Hologram** | **On**, Off | Determines if the hologram of the player's character will be shown in game. Only valid if the **Visible in Game** option is set to **On**. |
| **Color** | ***Direct Color***, Team Color, Team Relationship Color | Determines the color of the displayed text. If you choose **Team Relationship**, the text is red if it's hostile to your team, green if it's neutral, and blue if it's friendly. |
| **Custom Color** | **White**, Select a color | Sets a custom color for the hologram and player details. |
| **Visible in Game** | ***On***, Off | Determines if the device is visible during the game. This affects the device's collision properties. |
| **Show Player Details** | On, **Off** | Determines where to display the player's details on the device and the position it displays in. Only valid if the **Visible in Game** option is set to **On**. |
| Hologram Animation | Idle, Hands on Hips, Flex | Determines the animation that the hologram will play. Only valid if the Show Hologram and Visible in Game options set to On. |
| **Hologram Effect Strength** | Off, **100%**, Pick a percentage | Determines the brightness of the Hologram Effect. Only valid if the **Visible in Game** option is set to **On**. |
| **Show Base** | **On**, Off | Determines whether the device is visible during the game. This will always show during creation if everything else is disabled. |
| **Stat to Track** | **None**, Eliminations, Score, Eliminated | Determines which stats display if the **Show Player Details** option is not set to **Off**. This is also used to determine when the **Track Stat Changed** transmitter option triggers. |
| **Player Details Height** | **115CM**, Pick or enter a number | Determines if the player's details are displayed on the device and how high they are shown. This option is only valid if **Visible During Game** and **Shown Player Details** are both set to **On**. |
| **Player Details Curve Amount** | No Curve, Small Curve, Medium Curve, **Large Curve** | Determines the curvature degree that the player details will display. |
| **Track Game Total for Stats** | On, **No** | Selects if the tracking stats will come from the game total rather than the current round’s value. |
| **Update Registered Player** | **Always**, When No Registered Player, If Stat Is Higher, If Stat Is Higher Or Equal, If Stat Equal, If Stat Not Equal, If Stat Equal Or Lower, If Stat Is Lower | If there is a registered player, and the device receives a request to register a new player, this option determines if that update is successful. If there is no registered player, the update is always successful. |
| **Activated by Sequencers** | **On**, Off | Determines whether or not to activate the device when it is touched by a Sequencer or RNG Device pulse. |
| **Registered by Sequencers** | **On**, Off | Determines if this device uses the activating player of the Sequencer or the RNG Device as the registered instigator. |
| **Allow Activate without Player Reference** | Yes, **No** | Determines if the signal will be transmitted if you send an Activate signal without a player being locked into the device.  Several devices will only function with a valid instigator. |
| **Play Audio** | **Yes**, No | Determines if the device will play audio effects. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive and gives you more freedom to focus on your design ideas.

Below are the [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) for this device.

### Functions

A [**function**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) listens for an event on a device and then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event and select the event that triggers this function.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

### Receivers

Receivers listen for a channel and perform an action when they hear any device (including themselves) send a signal on that channel.

| Option | Description |
| --- | --- |
| **Register Player When Receiving From** | Registers the instigating player when the device receives a signal on the selected channel. This player will be used when transmitting. |
| **Activate When Receiving From** | Ends the round/game when the device receives a signal on the selected channel. |
| **Clear Player When Receiving From** | Clears the device when the device receives a signal on the selected channel. |
| **Enable When Receiving From** | Enables the device when the device receives a signal on the selected channel. |
| **Disable When Receiving From** | Disables the device when the device receives a signal on the selected channel. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the Add button and repeat.

| Option | Description |
| --- | --- |
| **On Activated Send Event To** | When the device is activated, it transmits a signal on the selected channel. Uses the stored player as the instigator. |
| **On Tracked Stat Changed**Send Event To | When a tracked stat is updated, the device transmits a signal on the selected channel. Uses the stored player as the instigator. |
| **On Player Updated**Send Event To | When the registered player is updated, the device transmits a signal on the selected channel. |
| **On Player Update Fails**Send Event To | When the device attempts to update but fails, the device transmits a signal on the selected channel with the player that attempted to register as the instigator. |
| **On Player Replaced**Send Event To | When the registered player is replaced, the device transmits a signal on the selected channel with the replaced player as the instigator. |
