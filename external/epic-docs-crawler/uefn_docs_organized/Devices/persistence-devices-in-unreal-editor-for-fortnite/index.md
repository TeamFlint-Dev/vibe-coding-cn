# Persistence Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/persistence-devices-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:30:00.629624

---

Using persistent data in Unreal Editor for Fortnite (UEFN) provides a way for you to make game mechanics that persist across multiple game sessions. This is done by saving and uploading, then downloading saved data based on player statistics. This saved data can be applied to individual players when the player is online.

This means that a player who reaches a save point can leave the island, come back later and pick up where they left off with the same inventory, class and team level, and health stats, without having to restart the game from the beginning.

Islands with persistence tend to retain players more because the players have incentive to return to the island and continue progressing.

You can use persistence in progressional game modes like survival and tycoon. These types of game modes require players to accumulate items that satisfy long-term goals that drive gameplay.

[![The Save Point device icon.](https://dev.epicgames.com/community/api/documentation/image/13d0472a-fa52-4b95-9148-5974c74371e5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13d0472a-fa52-4b95-9148-5974c74371e5?resizing_type=fit)

Player data will not transfer from your Creative island to a UEFN project. If you revert your island back to its Creative state, your player data is retained, but you will lose any changes you made in UEFN.

You can create persistent data using the following devices:

- [**Switch**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-switch-devices-in-fortnite-creative)
- [**Tracker**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-tracker-devices-in-fortnite-creative)
- [**Timer**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-timer-devices-in-fortnite-creative)
- [**Save Point**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-save-point-devices-in-fortnite-creative)

## Persistence Options

The devices mentioned above have options that can be used to create persistent data. Below are a series of tables outlining the additional functionality for each device.

Below are a series of tables outlining the additional functionality for each device.

There are no additional properties for the Save Point device. However, you can use the Save Point device to act like an Item Granter by using its properties to create an inventory of Player items, resources, and weapons.

### Switch Properties

| Basic Options | Value | Explanation |
| --- | --- | --- |
| **Use Persistence** | **Yes**, No | Use persistence to track player data. |
| **Auto-Save State** | **Yes**, No | Select whether the device automatically saves the player’s state. |
| **Auto-Load State** | **Yes**, No | Select whether the device automatically loads the player’s and the island’s data. |
| **Store State Per Player** | **Yes**, No | Select whether to store persistent player state. |
| **Resolve Conflicts** | **Yes**, No | Resolves conflicts between the player data and island states. |
| **User Options - Functions** |  |  |
| **Save State When Receiving From** |  | Saves the player and island state when receiving a signal from another device. |
| **Load State When Receiving From** |  | Loads the player and island state when receiving a signal from another device. |
| **Clear Player Persistence Data When Receiving From** |  | Clears the player’s persistent data when receiving a signal from another device. |
| **Clear All Persistence Data When Receiving From** |  | Clears all persistent data when receiving a signal from another device. |
| **User Options - Events** |  |  |
| **On State Save Transmit On** |  | Transmits a signal when using the On State Save event. |

### Tracker Properties

| Option | Value | Explanation |
| --- | --- | --- |
| **Use Persistence** | Yes, No | Use persistence to track player data. |
| **Auto-Save** | **Yes**, No | Select whether the device automatically saves the player’s state. |
| **Auto-Load** | **Yes**, No | Select whether the device automatically loads the player’s state. |

### Timer Properties

| Option | Value | Explanation |
| --- | --- | --- |
| **Save Timer** | **Yes**, No | Save the timer data. |
| **Auto-Save** | **Yes**, No | Select whether the device automatically saves the player’s state. |
| **Auto-Load Saved Data** | **Yes**, No | Select whether the device automatically loads the player’s or island’s saved data. |

## Persistence Functionality

Creating persistent data is easy, use the steps below to create a simple data capture system:

1. Select the devices you want to use to create persistent data for your island, and the player data you want to capture, making sure to use the Save Point device as well.
2. Rename the **Save Point** device in the Outliner.
3. Select the **Save Point** device in the viewport or the Outliner, and define the persistent behavior in the Details panel.
