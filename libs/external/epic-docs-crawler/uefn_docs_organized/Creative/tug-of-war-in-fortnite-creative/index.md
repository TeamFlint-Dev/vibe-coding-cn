# Tug of War

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/tug-of-war-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:27:39.542526

---

[![Tug of War Gameplay Example](https://dev.epicgames.com/community/api/documentation/image/b3b85043-aa80-4609-b74a-b679856facdc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3b85043-aa80-4609-b74a-b679856facdc?resizing_type=fit)

The game consists of five Capture Points, with each team owning two locked points, and the central point being neutral. Once the central point is captured, the next Capture Area in the sequence is unlocked. From here, each team has a control point to defend and one to attack. If you successfully capture a point, it becomes your new defend area while the next one along becomes the enemy team's new defend area. Players spawning in are teleported to their defending area, and fighting continues until one team has their final Capture Point taken.

*Tug of War Video*

## Ingredients

**You will need:**

- **5 Capture Area devices**
- **30 Attribute Trigger devices (6 for each Capture Area)**
- **10 HUD Message Devices (2 for each Capture Area)**
- **10 Teleporter devices (2 for each Capture Area owned by each Player)**
- **2 Player Start devices (1 for each player)**

## Method

Each Capture Point consists of a Capture Area, six Attribute Triggers, two Teleporters (for each Player), and 2 HUD Message Devices. When Captured, the Capture Point sends a message on a channel that all the Capture Triggers for that point listen to. These Attribute triggers do the following:

1. Disable the old teleporter for Team 1.
2. Disable the old teleporter for Team 2.
3. Enable the new teleporter for Team 1.
4. Enable the new teleporter for Team 2.
5. Disable the Capture Area that is now too far away from the newly captured area.
6. Enable the Capture Area that is now close enough from the newly captured point.

In this way if Team 1 Captures area C, it will open area D and close area B. If they Capture Area D, it will open area E and close area C. Due to the number of devices required for this, this example will focus on a single point and let you extrapolate the options for the remaining points.

## Modified Options

### My Island Settings

| My Island - Game |  |
| --- | --- |
| Teams | 2 |
| Objectives to End | 5 |

| My Island - UI |  |
| --- | --- |
| HUD Info Type | Objectives |
| Scoreboard Win Condition | Objectives |

In this mode each Capture Area will count as an Objective. Setting the **Objectives to End** option to **5** will cause the game to end when one team wins all the points. By setting the **Scoreboard Win Condition** option to **Objectives**, the team with the most Objectives will win and then the game ends.

### Player Spawn Device Options (at Team Base)

| Modified Options - Player Spawn (Team 1 / Team 2) |  |
| --- | --- |
| Team | 1 / 2 |

Each team should have a base somewhere in the map (likely next to their final Capture Point). These should have one Player Spawn device for each player. When a player spawns, the Player Spawn devices send a message on either Channel 1 or Channel 2, which will teleport that player to the currently active point.

### Player Spawn Device Options (at Capture Point)

| Modified Options - Capture Area C |  |
| --- | --- |
| Starting Team | All |
| Accent Color | Team Relationship |
| Can be Captured by Team | All |
| Control Time | 10 Seconds |
| Take Control Faster Per Player | x1.25 |
| Partial Progress Decay Speed | 50% |
| Count as Objective | On |
| Show in Objective HUD | On |
| HUD Elements | Badge |
| Requires Line of Sight | No |
| Hide HUD Icon at | 50m |
| Objective Identifier | C |
| HUD Text Size | 2x |

Our Capture Area acts as a control point like this, being taken over by a team if they stay within it for 10 seconds, with more players in the point making the capture go faster. All the other control points will start as either Team 1 or Team 2, but the central point will start with the **Starting Team** option set to **All**, making it neutral and providing an initial unlocked point (all the other points should have the **Capture Allowed on Game Start** option set to **No**). We count the Capture Area as an Objective and show it on the HUD, so it can be tracked by the game state and shown to players on their HUD.

### Attribute Trigger Device Options

| Modified Options - Attribute Trigger (x6) |  |
| --- | --- |
| Check for Team | 1 |

Attribute Triggers are listening for a signal from the capture item spawner, checking whether it's Team 1, and then running logic based on that.

### HUD Message Device Options

| Modified Options - HUD Message Device (Friendly Team) |  |
| --- | --- |
| Message | Your Team now Controls point C |
| Message Recipient | Friendlies |
| Time from Round Start | Off |
| Text Style | Bold Blue |
| Placement | Top Center |

| Modified Options - HUD Message Device (Enemy Team) |  |
| --- | --- |
| Message | The Enemy Team has Captured point C |
| Message Recipient | Enemies |
| Time from Round Start | Off |
| Text Style | Bold Orange |
| Placement | Top Center |

The HUD Message devices listen for the capture of the point and will play a message to each player based on whether they are friendly, or an enemy of the capturing player.

### Teleporter Device Options

| Modified Options - Teleporters |  |
| --- | --- |
| Teleporter Group | None |
| Teleporter Target Group | None |
| Enabled During Phase | None |
| Text Teleporter Rift Visible | No |
| Play Visual Effects | No |
| Play Sound Effects | No |
| Face player in teleporter direction | Yes |

The teleporters pull players to the front lines when they spawn. All but one are switched off by default and will be enabled or disabled by messages as teams capture the points. For the one that you want players to start at, set that to be **Enabled Always**. This would be Point B for Team 1 and Point D for Team 2.

### Message Setup

#### General Channel Setup

| Channels - Player Spawn (Team 1) |  |
| --- | --- |
| When Player Spawned Transmit On | Channel 80 (81/82/83… per Player) |

| Channels - Player Spawn (Team 2) |  |
| --- | --- |
| When Player Spawned Transmit On | Channel 90 (9/92/93… per Player) |

Player Spawn devices at the team's bases will send messages on either Channel 80 or 90 when a player spawns. All the teleporters are listening to this, and players will be teleported based on which teleporter is currently enabled. There should be one Player Spawn device and one teleporter for each potential player in the match, with matching signals (so the second Team 1 Player Spawn/Teleporter pair should be on Channel 81, the third on Channel 82, and so on).

#### Capture Point Channel Setup

Each area to capture is given a band of 10 channels to work with. This makes it easier to keep track of how they should interact with each other. So, Point A gets channels 1-10, Point B gets channels 11-20, Point C gets channels 21-30, and so on. These are set up with the following convention:

- Disable Team 1 Spawn - **X1**
- Enable Team 1 Spawn - **X2**
- Lock the Capture Area - **X4**
- Area has been Captured - **Transmit on X5**
- Unlock the Capture Area - **X6**
- Disable Team 2 Spawn - **X7**
- Enable Team 2 Spawn - **X8**

Capturing each point should do the following:

1. Lock the previous Capture Area for your team.
2. Disable the previous Player Spawn device for your team.
3. Enable the current Player Spawn for your team.
4. Disable the current Player Spawn for the enemy team.
5. Enable the next Player Spawn for the enemy team.
6. Unlock the next Capture Area.

If you're Team 1 Capturing point C, this would be Locking point B, moving your Player Spawn to point C, pushing the enemy Player Spawn back to point D and unlocking point D for potential capture.

| Channel Options - Capture Area C |  |
| --- | --- |
| When Control Change Transmit On | Channel 25 |
| Enable When Receiving From | Channel 23 |
| Disable When Receiving From | Channel 24 |

The Capture Area will send on Channel 25 when it changes possession.

| Channel Options - Teleporter (Team 1) |  |
| --- | --- |
| Teleport To When Receiving From | Channel 80 (81/82/83… per player) |
| Enable When Receiving From | Channel 23 |
| Disable When Receiving From | Channel 24 |

| Channel Options - Teleporter (Team 2) |  |
| --- | --- |
| Teleport To When Receiving From | Channel 90 (91/92/93… per player) |
| Enable When Receiving From | Channel 28 |
| Disable When Receiving From | Channel 27 |

The Teleporters are listening for players to spawn, and will teleport the spawning players to them if they are enabled. You are using Teleporters instead of Player Spawn Plates to avoid a couple of limitations of the Player Spawn Plates.

- The spawn point for players is chosen when they are eliminated, so we cannot disable spawn points for players that are currently awaiting spawn.
- Teleporters can be placed precisely, and direction can be chosen/edited more easily. Player Spawn Plates are traps and can only be placed on the grid.

| Channel Options - Hud Message Device (Friendly / Enemy) |  |
| --- | --- |
| Show When Receiving From | Channel 25 (Point C Captured) |

Both HUD Message Devices are listening for the Capture Area changing control. When that happens, they will display a message to players either friendly ("Your team has captured point C") or enemy ("The enemy team has captured point C") to the player that captured the point.

| Channel Options - Attribute Trigger (Disable Team 1 Spawn) |  |
| --- | --- |
| Listen to Channel | Channel 25 (Point C Captured) |
| If all Checks are Valid Transmit On | Channel 12 (Disable Team 1 Teleporter. Point B) |
| If a Check is Invalid Transmit On | Channel 22 (Disable Team 1 Teleporter. Point C) |

All our Attribute Triggers are checking against Team 1, so if Team 1 captures point C it will turn off the Teleporter for Team 1 at Capture Point B, and if Team 2 captures point C it will turn off the point C Teleporter for Team 1.

| Channel Options - Attribute Trigger (Disable Team 2 Spawn) |  |
| --- | --- |
| Listen to Channel | Channel 25 (Point C Captured) |
| If all Checks are Valid Transmit On | Channel 27 (Disable Team 2 Teleporter. Point C) |
| If a Check is Invalid Transmit On | Channel 37 (Disable Team 2 Teleporter, Point D) |

| Channel Options - Attribute Trigger (Enable Team 1 Spawn) |  |
| --- | --- |
| Listen to Channel | Channel 25 (Point C Captured) |
| If all Checks are Valid Transmit On | Channel 23 (Enable Team 1 Teleporter. Point C) |
| If a Check is Invalid Transmit On | Channel 13 (Enable Team 1 Teleporter, Point B) |

| Channel Options - Attribute Trigger (Enable Team e Spawn) |  |
| --- | --- |
| Listen to Channel | Channel 25 (Point C Captured) |
| If all Checks are Valid Transmit On | Channel 38 (Enable Team 2 Teleporter. Point D) |
| If a Check is Invalid Transmit On | Channel 28 (Enable Team 2 Teleporter, Point C) |

| Channel Options - Attribute Trigger (Unlock Next Area) |  |
| --- | --- |
| Listen to Channel | Channel 25 (Point C Captured) |
| If all Checks are Valid Transmit On | Channel 36 (Unlock Capture Area D) |
| If a Check is Invalid Transmit On | Channel 16 (Unlock Capture Area B) |

| Channel Options - Attribute Trigger (lock Previous Area) |  |
| --- | --- |
| Listen to Channel | Channel 25 (Point C Captured) |
| If all Checks are Valid Transmit On | Channel 14 (Lock Capture Area B) |
| If a Check is Invalid Transmit On | Channel 34 (Lock Capture Area D) |
