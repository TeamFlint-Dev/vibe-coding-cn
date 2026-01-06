# Using Analytics

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-analytics-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:30:21.053913

---

The Analytics device is designed to work with other devices by registering when players interact with devices on your island. This includes stepping on a trigger, entering a volume, eliminating an enemy, or pressing a button. The Analytics device records this data and sends it to the [Creator Portal](https://dev.epicgames.com/documentation/en-us/fortnite/creator-portal) every day.

For a list of the Analytics device best practices, see the [Analytics Dashboard](https://dev.epicgames.com/documentation/en-us/fortnite/analytics-device-dashboard-in-fortnite-creative) document.

## Analyzing Gameplay

The following are suggested ways to use the Analytics device in popular game types.

### Deathrun

To capture data on the number of levels players complete in a deathrun, set the Analytics device to listen for players who activate the [Player Checkpoint device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative).

Configure the user options for the Player Checkpoint device on your island, then add **[Mutator Zones](https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative)** to all the level entrances.

Next, add the Analytics devices to receive information when the checkpoints are activated and to submit the checkpoint data when players enter the Mutator Zone on the next level.

**DIRECT EVENT BINDING**

| Device A | Function | Device B | Event |
| --- | --- | --- | --- |
| **Analytics Device** | Submit | **Mutator Zone** | On Player Entering Zone |

Name the events clearly so you know what the device is monitoring, and number the events according to the number of levels in your deathrun. Notice in the example below that the name of the event is tied to the placement of the first checkpoint.

[![](https://dev.epicgames.com/community/api/documentation/image/6b88510a-2856-42ae-98e8-fd64cfd59f53?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b88510a-2856-42ae-98e8-fd64cfd59f53?resizing_type=fit)

You can place up to 50 Analytics devices on an island at once.

### Prop Hunt

Use the Analytics devices to determine whether hunters in a prop hunt game are evenly matched to the hidden players. Set up the necessary devices for the prop hunt gameplay. In this instance you’ll use two Analytics devices to track the number of players in the game versus the number eliminations.

Set one Analytics device to track the number of players that join a game, then set another Analytics device to track the number of eliminations in a game.

#### Direct Event Binding

| Device A | Function | Device B | Event |
| --- | --- | --- | --- |
| **Analytics Device** - Players\_Spawn | Submit | **Player Spawner** | On Player Spawned |
| **Analytics Device** - Players\_Eliminated | Submit | **Elimination Manager** | On Eliminated |

### Capture the Flag

Determine the number of times a flag is captured by monitoring how many times the flag is taken to the capture area. Once you’ve set the flag and capture areas, add an analytics device for each team. Set each device to monitor the capture event for one of the teams.

#### Direct Event Binding

| Device A | Function | Device B | Event |
| --- | --- | --- | --- |
| **Analytics Device** - Team 1 | Submit | **Capture Area** - Team 1 | On Control Change |
| **Analytics Device** - Team 2 | Submit | **Capture Area** - Team 2 | On Control Change |

## Analyzing Events Using Verse

Ensure the devices you intend to monitor with the Analytics device have a **Player Agent function**. Without a player-led action, the Analytics device will not record any data. Use the **Verse API** **Reference** to search for Player Agent functions on the device.

Set up the basic options for the devices to ensure they behave the way you want them to.

Create a Verse script following the directions in [Create Your Own Verse Device](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).

You can follow the example code for the [Analytics Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-analytics-devices-in-fortnite-creative) from the device page in Fortnite Creative documentation.
