# Round Settings Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-round-settings-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:39:53.164477

---

The **Round Settings** device is used for any round-based game that has customized gameplay within specific rounds. It generally defines what happens to the player’s inventory and rewards in each round. An example of a game mode that uses Round Settings extensively is [Search and Destroy](https://dev.epicgames.com/documentation/en-us/fortnite/search-and-destroy).

For help on how to find the **Round Settings** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

This device lets you manage your players' inventory and rewards between rounds, for example classes, weapons, items, and building resources.

In its default state, this device does nothing. It grants no resources and does not decide what happens to resources between rounds.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

The Round Settings device can override My Island settings. Refer to the following documents for more information about My Island settings:

- [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-uefn-and-fortnite-creative)
- [Island Settings in Fortnite Creative](https://dev.epicgames.com/documentation/en-us/fortnite/understanding-island-settings-in-fortnite-creative)
- [User Interface Settings](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-settings-in-fortnite-creative)

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Round** | **All**, 1 to 100 | Defines the specific round to be customized. |
| **Override Keep Items Between Rounds** | **Don't Override**, *Override* | Override whether players should keep items between rounds. |
| **Keep Items Between Rounds** | **No**, Yes | Only visible when **Override Keep Items Between Rounds** is set to **Override**.  Sets whether players should keep items between rounds. |
| **Reset Class Each Round** | **No**, Yes | Determines whether or not the player's class is reset in this round. |
| **Wood Given Per Round** | **None**, Pick a number | The amount of wood resource the player receives each round. |
| **Metal Given Per Round** | **None**, Pick a number | The amount of metal resource the player receives each round. |
| **Stone Given Per Round** | **None**, Pick a number | The amount of stone resource the player receives each round. |
| **Gold Given Per Round** | **None**, Pick a number | The amount of gold the player receives each round. |
| **Override Last Standing Wins** | **Don't Override**, *Override* | Only visible when Override Last Standing Wins is set to Override.  Override whether to set the winner of the round to the last one standing. |
| **Last Standing Wins** | **No**, Yes | Determines whether set the winner of the round to the last one standing. |

### All Options

| Option | Value | Description |
| --- | --- | --- |
| **Enabled On Minigame Start** | **Enabled**, Disabled | Determines whether or not the device is enabled at the start of a minigame. |
| **Override Keep Items Between Rounds** | **Don't Override**, *Override* | Only visible when Override Keep Items Between Rounds is set to Override.  Override whether players should keep items between rounds. |
| **Keep Items Between Rounds** | **No**, Yes | Sets whether players should keep items between rounds. |
| **Keep Resources Between Rounds** | **Don't Override (-1.0f)**, Pick a percentage amount | Defines what percent of resources acquired in the previous round can be brought over to the current round. |
| **Override Reload & Restock Weapons Each Round** | **Don't Override**, *Override* | Override whether to reload and restock weapons between rounds. |
| **Reload & Restock Weapons Each Round** | **No**, Yes | Only visible when **Override Reload & Restock Weapons Each Round** is set to **Override**.  Determines whether or not weapons are reloaded and restocked in the current round. |
| **Respawn Player On Class Reset** | **No**, Yes | Determines whether or not players are forced to respawn when their class is reset. |
| **Clear All Items On Class Reset** | No, **Yes** | Determines whether or not a player's inventory is cleared when their class is reset. |
| **Reset Current Vitals On Class Reset** | No, **Yes** | Determines whether or not the player's health and shields are reset when their class is reset. |
| **Wood Given To Winners Per Round** | **None**, Pick a number | The amount of wood given to the winner in each round. |
| **Metal Given To Winners Per Round** | **None**, Pick a number | The amount of metal given to the winner in each round. |
| **Stone Given To Winners Per Round** | **None**, Pick a number | The amount of stone given to the winner in each round. |
| **Gold Given To Winners Per Round** | **None**, Pick a number | The amount of gold given to the winner in each round. |
| **Disable Matchmaking on Round End** | On, **Off** | At the end of the round, this disables the ability for matchmaking to spawn players into the island, or the ability to join in-progress games that have matchmaking. |

Disabling Matchmaking on Round End may not occur instantly if an Enable Matchmaking request has recently been made.

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/function) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device. |
| **Disable When Receiving From** | Disables the device. |
| **Enable Matchmaking When Receiving From** | Enables the ability for players to Matchmake into the Island. Only applies to published games that have matchmaking turned on in the Island settings. |
| **Disable Matchmaking When Receiving From** | Disables the ability for players to Matchmake into the Island. Only applies to published games that have matchmaking turned on in the Island settings. |
| **Disable End Round Conditions When Receiving From** | Disables all end round conditions. Round must be ended by sending a trigger. |
| **End Round When Receiving From** | Ends the round. If triggered by a player, then the player's team is set as the winner. |
| **Toggle Matchmaking When Receiving From** | Toggles the ability for players to Matchmake into the Island. Only applies to published games that have matchmaking turned on in the Island settings. |

Enabling, disabling and toggling matchmaking will not occur instantly if a conflicting matchmaking request has recently been made. For example, toggling matchmaking will be delayed if a **Enable Matchmaking** request has been made recently.

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Round Start Send Event To** | Transmit when the rounds starts. |
