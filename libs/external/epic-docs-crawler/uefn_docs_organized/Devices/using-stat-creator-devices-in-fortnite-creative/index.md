# Stat Creator Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-creator-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:47:56.652128

---

Use the **Stat Creator** device to create custom statistics (stats) with a set value and level to drive your gameplay. These stats are in-game data that can fulfill win/lose conditions and even scoreboard requirements.

With this device, you can create your own in-game XP leveling systems. Pair this device with a [Stat Powerup](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-powerup-devices-in-fortnite-creative) to create a custom stat that continuously decreases in value such as "Heat" to create systems where players must seek shelter or a campfire to replenish.

Within the [Island Settings'](understanding-island-settings-in-fortnite-creative) **Mode** tab, you can then navigate to **Victory Condition** > **Round Win Condition** to set your custom status as a win requirement. Navigate to the **Scoreboard Column** options within the **User Interface** tab to set your custom stat within the gameplay's scoreboard.

Through **Unreal Editor for Fortnite** (UEFN), you can even use widget blueprints to further customize your stat's UI.

For help on how to find the Stat Creator device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, such as setting the value's parameters and determining who the stat will apply to. Additionally, there are some advanced options like broadcasting events for all players and using persistence.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

## Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Stat Name** | **Stat**, Insert stat name | Displays the name of the stat. |
| **Max Value** | **No Limit**, *Pick or enter a value* | Determines the stat value that is needed to surpass the first level. If set to **No Limit**, the first level will never be completed. |
| **Max Level** | **1**, Pick or enter a value number | Determines the maximum level players can reach during the game. Starting at 1, players will progress through all proceeding levels and then complete the stat when reaching that level. |
| **Per Level Points Multiplier** | **1.0x**, Pick or enter a multiplier value | Determines how many points are required to reach each level in the stat. |
| **Can Lose Level from Point Loss** | Yes, **No** | If set to **No**, when points are removed from the stat it will never revert to the previous level. |
| **Scope** | **Player**, Team, Match | Determines who the stat will apply to. If set to either **Team** or **Match**, all players in that scope will share the same stat value. |
| **Selected Team** | **Any**, Pick or enter a team number | Determines which team can activate the device. |
| **Invert Team Selection** | On, **Off** | If set to **On**, this device will apply to all but the selected team. |
| **Selected Class** | No Class, **Any**, Pick or enter a class number | Determines which class can activate the device. |
| **Invert Class Selection** | On, **Off** | If set to **On**, this device will apply to all but the selected class. |
| **Stat Color** | **White**, Select a color | Determines the color of the stat, which is used for the UI and other effects. |
| **Stat Bar Show on HUD** | **Yes**, Non-Zero, No, *For Duration* | Determines if the status bar is visible during the game. If set to **For Duration**, the UI will show after the player gains or loses points then hide after a duration set by **Stat Bar Duration**. If set to **Non-Zero**, the stat bar will only show when the player has a non-zero value in the stat. |
| **Stat Bar Duration** | **5 Seconds**, Pick or enter a duration | Determines how long the stat bar is shown on the HUD after its value changes. |

## All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled Phase** | None, **Always** | Determines the game phases during which the device will be enabled. |
| **User Widget** | **Default**, Compact, Tiny | Determines what UI to show for this stat. |
| **Hud Priority** | **1**, Pick or enter a number | Determines the order in which this stat will appear on the HUD. Higher numbers show first on the list. |
| **Stat Icon** | **None**, Pick or enter an icon name | Determines which icon to use with this statistic. |
| **Broadcast Events for All Players** | On, **Off** | Determines if the level and value change events broadcast for all players or just the triggering player. |
| **Use Persistence** | *On*, **Off** | Determines if this device should save or load any data from the backend. |
| **Resolve Conflicts** | First Player, Highest, Lowest, Average, **Median** | Determines what value is chosen for the stat when loading multiple players that have the same scope. |
| **Auto Save** | Yes, **No** | If set to **Yes**, when the player leaves or the round ends, player data is saved automatically. If not, it will need to be saved manually through a receiver. |
| **Auto Load** | Yes, **No** | If set to **Yes**, when the round or game starts, all players will have any saved data they have loaded. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device and then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the device's function.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when receiving a signal from the specified channel. If the player had any points stored when disabled, they will be restored when the device is enabled. |
| **Disable When Receiving From** | Disables the device when receiving a signal from a specified channel. |
| **Save When Receiving From** | Saves the stat to persistent inventory, allowing the stat to be carried over between games. If **Auto-Save** is off, this is the only way to save data to the persistent record. |
| **Load When Receiving From** | Loads stats from persistent inventory. |
| **Reset Stat When Receiving From** | Returns the stat to a 0 value when triggered. |
| **Clear Player Persistence Data When Receiving From** | Clears any saved data for the instigating player when receiving a signal from the selected channel. |
| **Clear Player Persistence Data for All When Receiving From** | Clears saved data for all players on the island when receiving a signal from the selected channel. |
| **Increase Level When Receiving From** | Increases stat to the next level and resets the value if the stat has levels. |
| **Decrease Level When Receiving From** | Decreases the stat to the previous level and resets the value if the stat has levels. |
| **Load for All When Receiving From** | Loads the previously saved stat values for all players. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to that device's function.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Level Up Send Event To** | Transmits a signal on the selected channel on player level up. |
| **On Reached Maximum Send Event To** | Transmits a signal on the selected channel when players reach max level. |
| **On Level Down Send Event To** | Transmits a signal on the selected channel when a player loses a level. |
| **On Value Changed Send Event To** | Transmits a signal on the selected channel whenever the stat value changes. |
