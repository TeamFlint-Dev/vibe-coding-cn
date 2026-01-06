# Save Point Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-save-point-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:40:47.509667

---

The **Save Point** device provides a way for creators to add elimination tracking persistence, inventory and resource tracking across multiple game sessions, and more.

Think of it as saving a snapshot of where the player is at any given time.

For example:

- In racing games, players can track their best lap times.
- In adventure games, players can save their progress toward objectives.
- In skillrun games, players can pick up where they left off instead of having to start over every time they leave the game and come back.

If players are on an island using Save Point devices when a new version of that island is published, those players can continue their session and their progress will be saved. However, if a player matchmakes into an older, non-current version of an island, a HUD message displays stating that the island is not current, their save data will not be loaded, and their save game will not be modified.

To find the Save Point device, see [Finding and Placing Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This device has some basic functionality, like autosaving and saving checkpoint data. Additionally, there are some advanced options, like saving a player's shield and health data.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Gameplay Only** | Determines whether the device is enabled during a specific [game phase](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |
| **Auto Save** | **Yes**, No | Determines whether the player's data is automatically saved while they play. |
| **Auto-Load** | **Yes**, No | Determines whether to autoload the player's data. If this is set to **Yes**, the **Auto-Load Behavior** option displays below. If it is set to **No** that option does not display. |
| **Auto-Load Behavior** | **Initial Spawn**, Game Start, Round Start, Every Spawn | Determines when the player's saved data is loaded. |
| **Save Health and Shields** | Yes, **No** | Determines whether the player's health and shield data is saved. |
| **Save Loadout** | **Yes**, No | Determines whether the player's current loadout is saved. |
| **Save Full Ammo Magazines** | **Yes**, No | Restores full ammo magazines on loading player data. If **No**, restores the exact amount of ammo the player had when saving. |
| **Save Resources** | **Yes**, No | Determines whether the player's current resources are saved. |
| **Save Gold** | **Yes**, No | Determines whether the player's current gold is saved. |
| **Save Scoreboard Stats Behavior** | Round, Career, **Both** | This determines what kind of scoreboard stats are saved. Values are:   - **Round**: Only the current round's scoreboard stats are saved between rounds. - **Career**: Only the player's career scoreboard stats are saved. - **Both**: Both the current round's stats and the player's career stats are saved. |
| **Save All Scoreboard Stats** | No, **Yes**, Only If Lower, Only If Higher | Determines whether the device saves all of the player's current stat data that appears on the scoreboard. |
| **Save Score** | No, **Yes**, Only If Lower, Only If Higher | Determines whether the player's current score data is saved. |
| **Save Round Wins** | No, **Yes**, Only If Lower, Only If Higher | Determines whether the player's current round wins are saved. |
| **Save Eliminations** | No, **Yes**, Only If Lower, Only If Higher | Determines whether the player's current eliminations count is saved. |
| **Save Assists** | No, **Yes**, Only If Lower, Only If Higher | Determines whether the player's current assists count is saved. |
| **Save Collected Items** | **Yes**, Only If Lower, Only If Higher, No | Determines whether the player's collected items are saved. |
| **Save Creature Eliminations** | **Yes**, Only If Lower, Only If Higher, No | Determines whether the player's current creature eliminations count is saved. |
| **Save Checkpoint** | **Yes**, No | Determines whether the player's [checkpoint](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) data is saved. If set to **Yes**, the player will [respawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) at the last checkpoint they activated. |
| **Save Player Location** | **Yes**, No | Determines whether the player's location is saved. If set to **Yes**, the player will respawn at the last position they saved. |
| **Save Team** | Yes, **No** | Determines whether the player's team number is saved. If set to **Yes**, the player will load with that team assigned, [triggering](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) any related Team Settings & Inventory device. |
| **Save Class** | **Yes**, No | Determines whether the player's [class number](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) is saved. If set to **Yes**, the player will load with that class assigned, triggering the related [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) device. |
| **Allow Player to Clear Data** | Yes, **No** | Determines whether players can clear their progress data from the Game (Sidebar) menu. |

## Direct Event Binding System

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the functions and events for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Save Player When Receiving From** | This function saves player data when an event occurs. |
| **Load Player When Receiving From** | This function loads player data when an event occurs. |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Clear Data for Player When Receiving From** | This function clears player data when an event occurs. |
| **Clear Data for All Players When Receiving From** | This function clears all player data when an event occurs. |
| **Save All Players When Receiving From** | This function saves data for all players when an event occurs. |
| **Load All Players When Receiving From** | This function loads data for all players when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Activation Send Event To** | When the device is activated, it sends an event to the selected device, which triggers the selected function. |
| **On Player Loaded Send Event To** | When a player's save data is loaded, the device sends an event to the selected device, which triggers the selected function. |
| **On Cleared Send Event To** | When a player clears data, the device sends an event to the selected device, which triggers the selected function. |
