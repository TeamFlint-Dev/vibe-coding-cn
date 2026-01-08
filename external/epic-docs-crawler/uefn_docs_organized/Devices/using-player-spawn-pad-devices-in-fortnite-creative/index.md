# Player Spawner Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:39:46.505575

---

The **Player Spawn Pad** spawns the player at any location on their island.

This device can only spawn one player. You will need to place individual spawners for islands with multiple players. Otherwise, they will always fall from the sky and have to parachute down.

For help on how to find the **Player Spawner** device, see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **Always**, None, Create Only, Game Countdown Only, Gameplay Only | Determines the [game phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) during which this device will be [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) during which the device will be enabled. |
| **Player Team** | None, **Any**, Pick a team | Determines which team [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) on this pad. |
| **Player Class** | **Any**, No Class, Pick a team | Determines which class can activate the device. |
| **Priority Group** | **Don't Override**, Pick a number | Determines the priority order in which spawn pads will be used. Use the arrows to pick a number, or click in the field and type in a number. If all Primary pads are unavailable, players will spawn on Secondary pads and the Tertiary. |
| **Use as Island Start** | **On**, Off | Determines whether or not a spawn pad can be used when players are spawning in to the island during the [Pre-Game phase](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#pre-game-phase). |
| **Visible in Game** | **On**, Off | Determines whether the spawn pad is visible during games. |
| **Play Audio** | **No**, Yes, Only If Visible | Determines whether the device should play audio effects. |
| **Enemy Range Check** | **None**, Pick a range | If an enemy is within this radius, you can prefer not to spawn at this location. If no other locations are suitable, the player may still spawn here. |
| **Display Enemy Range** | Off, On, **When Near** | Visualizes the **Enemy Range Check** option value. The location sphere will never show while playing, only during Create mode. |
| **Respawn Alive Players** | **Yes**, No | If a **Respawn at Player Spawner** function is triggered, this determines if players who are alive are also respawned. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Spawn Player When Receiving From** | Spawns a player at this spawner, or respawns an existing player, when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Player Spawned Send Event To** | When a player spawns or respawns from this spawner, this sends an event to the selected device, which triggers the selected function. |
| **On Spawn Failed Send Event To** | When a player would spawn or respawn from this spawner, but the spawner is invalid or ineligible for spawning, this sends an event to the selected device, which triggers the selected function. |

## Gameplay Examples

- [Loadout Lobby](loadout-lobby-in-fortnite-creative)
- [Tug of War](tug-of-war-in-fortnite-creative)
