# Search and Destroy Bomb

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/search-and-destroy-bomb-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:28:19.343593

---

[![image alt text](https://dev.epicgames.com/community/api/documentation/image/03b54b06-6a25-4ca5-a5bc-64bf77215015?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/03b54b06-6a25-4ca5-a5bc-64bf77215015?resizing_type=fit)

**Search and Destroy** is a round-based game mode in which a team of attackers pairs off against a team of defenders, swapping sides at the halfway point. The attackers’ goal is to plant the explosives at one of two objectives; after planting the bomb, and once the timer counts down, the explosive detonates which grants a win to the attackers.

The defenders’ goal is to protect the objectives, and prevent or defuse any bombs planted. Either team can secure a round victory by eliminating the entire enemy team, unless the attackers have planted the bomb—in which case the defenders will still need to defuse the explosive.

*Search And Destroy Bomb Video*

## Ingredients

**You will need:**

- **8 Explosive Barrel devices (4 for each Bomb)**
- **2 Timed Objective devices (1 for each Bomb)**
- **4 Beacon devices (2 for each Bomb)**
- **8 Trigger devices (4 for each Bomb)**

## Method

Each Bomb will consist of a Timed Objective for the device itself, four Explosive Barrels to provide the explosion on completion, a Beacon to tell players to Arm/Defend Site, and a Beacon for Disarming/Protecting an Armed bomb. There will also be a number of Triggers to act as relays for messages.

## Modified Options

### Timed Objective Device Options (for Bomb A)

| Modified Options - Timed Objective |  |
| --- | --- |
| Timer Label Text | Bomb A |
| Time | 30 Seconds |
| Timer Label Text Style | Bold Orange |
| Start Team Filter | Team 1 |
| Start Interact Text | Arm Bomb |
| Start Interact Time | 5 Seconds |
| Start Score | 2 |
| Stop Team Filter | Team 2 |
| Stop Interact Text | Disarm Bomb |
| Stop Interact Time | 5 Seconds |
| Stop Score | 5 |
| Completed Score | 3 |
| Timer Sound Distance | Whole Map |

The Time Objective device handles logic for the bomb itself. In this example, Team 1 is the attacking team and Team 2 is the defending team. Each team will receive a total of 5 points if they win the round, with the attacking team's score split between arming the bomb and planting it.

### Explosive Barrel Device Options

| Modified Options - Explosive Barrel |  |
| --- | --- |
| Health | Indestructible |

You don't want players to destroy the explosive barrels, so set them to be indestructible.

### Beacon (Arming/Defend) Device Options

| Modified Options - Beacon (Arm/Defend) |  |
| --- | --- |
| Beacon Style | Badge Style |
| Hide HUD Icon At | 500M |
| Clamp to Screen | Yes |
| Show Offscreen Arrow | Yes |
| HUD Icon Identifier | A |
| Requires Line of Sight | No |
| Friendly Team | 2 |
| Friendly Icon Text | Defend Bomb A |
| Hostile Icon Text | Arm Bomb A |
| HUD Text Size | 1.5X |

The Arming Beacons are enabled at the start of the game, and they let everyone know where the bomb sites are. Since they're important objectives, they should be visible at all times.

### Beacon (Defend/Disarming) Device Options

| Modified Options - Beacon (Defend/Disarm) |  |
| --- | --- |
| Enabled During Phase | None |
| Beacon Style | Badge Style |
| Hide HUD Icon At | 500M |
| Clamp to Screen | Yes |
| Show Offscreen Arrow | Yes |
| HUD Icon Identifier | A |
| Requires Line of Sight | No |
| Friendly Team | 1 |
| Friendly Icon Text | Defend Bomb A |
| Hostile Icon Text | Disarm Bomb A |
| HUD Text Size | 1.5X |

The Defend/Disarm Beacon will be shown once the bomb is armed. It is friendly towards Team 1, and lets them know to defend the bomb, while Team 2 is now given the objective to disarm.

### Trigger Device Options

| Modified Options - Triggers (All) |  |
| --- | --- |
| Triggered by Player | Off |
| Visible in Game | No |

The triggers in this example are all relays. This means they listen for a channel, and transmit on another channel when they receive signals. Because of this, turn off the **Visible In Game** option to **No**, and the **Triggered by Player** option to **Off** so triggers can't be activated by players.

### Map Indicator Device Options (Before Arming)

| Modified Options - Map Indicator (Team 1 Attack) |  |
| --- | --- |
| Team | Team 1 |
| Icon Color | Orange |
| Text | Bomb A |
| Text Color | Orange |

| Modified Options - Map Indicator (Team 2 DEFEND) |  |
| --- | --- |
| Team | Team 2 |
| Icon Color | Blue |
| Text | Bomb A |
| Text Color | Blue |

Blue is used in Fortnite to define targets we want the player to defend, while orange/red is used for targets the player should attack. As such, the game wants to start with the bombs showing as blue to Team 2, and orange to Team 1.

### Map Indicator Device Options (After Arming)

| Modified Options - Map Indicator (Team 1 DEFEND) |  |
| --- | --- |
| Enabled on Game Start | No |
| Team | Team 1 |
| Icon Color | Blue |
| Text | Bomb A |
| Text Color | Blue |

| Modified Options - Map Indicator (Team 2 Attack) |  |
| --- | --- |
| Enabled on Game Start | No |
| Team | Team 2 |
| Icon Color | Orange |
| Text | Bomb A |
| Text Color | Orange |

The second set of Map Indicators are disabled when the game starts (they'll be enabled when the bomb is armed). They're the opposite colors as the first set, showing blue (defend) for Team 1 and orange (attack) for Team 2.

### Message Setup

| Message Setup - Channel 1 (Bomb A Armed) |  |  |
| --- | --- | --- |
| Timed Objective (Bomb A) |  |  |
| 1 | [Transmit] | When Started Transmit On |
| Beacon (Arm/Disarm BomB A Beacon) |  |  |
| 1 | [On Receive] | Enable When Receiving From |
| Map Indicator (Team 1 Defend A) |  |  |
| 1 | [On Receive] | Enable When Receiving From |
| Map Indicator (Team 2 Attack A) |  |  |
| 1 | [On Receive] | Enable When Receiving From |
| Trigger (Disable Arm Beacons when A Armed) |  |  |
| 1 | [On Receive] | Trigger When Receiving From |
| Trigger (Disable Bomb B When A Armed) |  |  |
| 1 | [On Receive] | Trigger When Receiving From |

Channel 1 is activated when Bomb A is armed. When this occurs, we enable our beacon and map indicators to arm/disarm the bomb, then activate two triggers. These are acting as relays to allow for information to be passed through. This is done as there will be multiple actions that will be disabling bombs/beacons, and each action can only be triggered by a single channel. As such we have multiple triggers listening on different channels, with each sending on the disable channel.

| Message Setup - Channel 2 (Bomb A Defused) |  |  |
| --- | --- | --- |
| Timed Objective (Bomb A) |  |  |
| 2 | [Transmit] | When Stopped Transmit On |
| Trigger (Disable A On Defuse A) |  |  |
| 2 | [On Receive] | Trigger When Receiving From |

This channel acts as a relay, with triggers listening for the bomb being defused and activating when this occurs.

| Message Setup - Channel 3 (Bomb A Exploding) |  |  |
| --- | --- | --- |
| Timed Objective (Bomb A) |  |  |
| 3 | [Transmit] | When Completed Transmit On |
| Explosive Device (Bomb A, X4) |  |  |
| 3 | [On Receive] | Enable When Receiving From |
| Trigger (Disable A On Explode A) |  |  |
| 3 | [On Receive] | Trigger When Receiving From |

When the Timed Objective completes, all of the explosives at Bomb A detonate, and another relay listens and disables the bomb.

| Message Setup - Channel 4 (Disable Bomb A) |  |  |
| --- | --- | --- |
| Trigger (Disable A ON Arm B) |  |  |
| 4 | [Transmit] | When Triggered Transmit On |
| Trigger (Disable A On Explode A) |  |  |
| 4 | [Transmit] | When Triggered Transmit On |
| Timed Objective (Disable A On Defuse A) |  |  |
| 4 | [Transmit] | When Triggered Transmit On |
| Timed Objective (Bomb A) |  |  |
| 4 | [On Receive] | Disable When Receiving From |
| 4 | [On Receive] | Hide When Receiving From |
| Map Indicator (Team 1 Defend A) |  |  |
| 4 | [On Receive] | Enable When Receiving From |
| Map Indicator (Team 2 Attack A) |  |  |
| 4 | [On Receive] | Enable When Receiving From |
| Beacon (Defend/Disarm BomB A) |  |  |
| 4 | [On Receive] | Disable When Receiving From |

This channel disables Bomb A. It triggers when either Bomb B is armed or Bomb A is either Disabled or Triggered.

| Message Setup - Channel 5 (Bomb B Armed) |  |  |
| --- | --- | --- |
| Timed Objective (Bomb B) |  |  |
| 5 | [Transmit] | When Started Transmit On |
| Beacon (Arm/Disarm BomB B Beacon) |  |  |
| 5 | [On Receive] | Enable When Receiving From |
| Map Indicator (Team 1 Defend B) |  |  |
| 1 | [On Receive] | Enable When Receiving From |
| Map Indicator (Team 2 Attack B) |  |  |
| 1 | [On Receive] | Enable When Receiving From |
| Trigger (Disable Arm Beacons when B Armed) |  |  |
| 5 | [On Receive] | Trigger When Receiving From |
| Trigger (Disable Bomb A When B Armed) |  |  |
| 5 | [On Receive] | Trigger When Receiving From |

Same as Channel 1, but for Bomb B. Channel 6 matches Channel 2, Channel 7 matches Channel 3, and Channel 8 matches Channel 4.

| Message Setup - Channel 10 (Disable Arm Markers) |  |  |
| --- | --- | --- |
| Trigger (Disable Arm Markers on Arm B) |  |  |
| 10 | [Transmit] | When Triggered Transmit On |
| Trigger (Disable Arm Markers on Arm A) |  |  |
| 10 | [Transmit] | When Triggered Transmit On |
| Map Indicator (Team 2 Defend A) |  |  |
| 1 | [On Receive] | Disable When Receiving From |
| Map Indicator (Team 1 Attack A) |  |  |
| 1 | [On Receive] | Disable When Receiving From |
| Map Indicator (Team 2 Defend B) |  |  |
| 1 | [On Receive] | Disable When Receiving From |
| Map Indicator (Team 1 Attack B) |  |  |
| 1 | [On Receive] | Disable When Receiving From |
| Beacon (Arm/Defend Bomb A) |  |  |
| 10 | [On Receive] | Disable when Receiving From |
| Trigger (Arm/Defend Bomb B) |  |  |
| 10 | [On Receive] | Disable when Receiving From |

When any bomb is armed, both of the initial **Arm Bomb/Defend Bomb** HUD markers are disabled. The Map Indicators for initially attacking/defending the bombs are also disabled.
