# Pinball Wizard

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/pinball-wizard-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:27:49.879790

---

[![image alt text](https://dev.epicgames.com/community/api/documentation/image/f5ceae72-acf9-4f16-910e-af52a58d0aaa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f5ceae72-acf9-4f16-910e-af52a58d0aaa?resizing_type=fit)

The player is tasked with reaching a score of 10 as fast as possible. They are fired into an arena at the start of the game and have the Grind Power-up applied to make their feet slippery. The large green pinball bumper is worth 3 points, the blue bumpers are worth 1 point, and the red bumpers are worth minus one (-1) point, so they need to be avoided. With limited ability to adjust their own movement, players are propelled around the arena.\*

*Pinball Wizard Video*

## Ingredients

**You will need:**

- **Pinball Bumper devices** (as many as you want)
- **4 Pinball Flipper devices**
- **4 Barrier devices**
- **1 Mutator Zone device**
- **1 Player Spawn device**
- **1 Speed Boost device**
- **Full Damage Rails** (lots, enough to fully surround your arena)

## Method

Full Damage Rails are used to lock off an area because they provide knock-back and some danger. Barriers surround the area on 3 sides to keep the players from jumping over the Full Damage Rails. The Grind Power-up is applied to the player on spawn. Additionally, a Mutator Zone covers the entrance to the area and toggles a Barrier to spawn behind the player on the fourth side when the player enters the area. Each of the bumpers has a score value associated with it and each is color-coded to show players which ones they want to hit.

## Modified Options

### My Island Settings

| Modified Options - Game |  |
| --- | --- |
| Spawn Limit | 1 |
| Score to End | 10 |

The Player only spawns once and needs to gain 10 points to win.

| Modified Options - UI |  |
| --- | --- |
| HUD Info Type | Score |
| Scoreboard Win Condition | Score |
| Scoreboard Tiebreaker 1 | Time |

Show the players their score, along with how long it took them to win.

### Grind Powerup Device Options

| Modified Options - Grind Powerup |  |
| --- | --- |
| Effect Duration | Infinite |

The Grind effect on players should last for the whole game. It is applied with a signal when players spawn.

### Mutator Zone Device Options

| Modified Options - Mutator Zone |  |
| --- | --- |
| Allow Weapon Fire | No |

Our Mutator Zone checks for a player moving through it, so set the **Allow Weapon Fire** option to **No** (It is **Yes** by default).

### Barrier Device Options

| Modified Options - Barrier |  |
| --- | --- |
| Barrier Style | Translucent |
| Base Visible During Game | Yes |
| Enabled During Phase | None |
| Barrier Depth | Size of Edge / 1 |
| Barrier Width | Size of Edge / 1 |

The Barriers are enabled when the player leaves the Mutator Zone. Each Barrier should be placed in the center of each side of the arena and each should have a matching depth and width so together they encompass the arena.

### Pinball Bumper Device Options

| Modified Options - Pinball Bumpers |  |
| --- | --- |
| Knockback | Various |
| Side Bounce Lift | None |
| Allow Top Bounce | Off |
| Bumper Color | Various |
| Score Value | Various |

For the Pinball Bumpers, switch off **Side Bounce Lift** and **Top Bounce** to keep things at ground level (this means the bumpers won't knock players upwards). The color, knockback, and score are set individually on each Pinball Bumper device, to provide an interesting challenge to players.

### Pinball Flipper Device Options

| Modified Options - Pinball Flipper |  |
| --- | --- |
| Flip Direction | Same |
| On Bump Knockback | Medium |
| Bounce Angle Percentage | 0% (Off) |
| Knockup Amount | None |

The Pinball Flippers are placed at the edge of the player area. Here we've set the bounce angle percentage to 0% to ensure the player is always knocked in the same direction each time they touch the flipper, rather than have their direction determined by where they touch the flipper.

### Message Setup

| Message Setup - Channel 1 |  |  |
| --- | --- | --- |
| Player Spawn |  |  |
| 1 | [Transmit] | When Player Spawned Transmit On |
| Grind Powerup |  |  |
| 1 | [On Receive] | Pickup When Receiving From |

When the player spawns, we apply a Grind Power-up to them. This gives them slippery feet.

| Message Setup - Channel 2 |  |  |
| --- | --- | --- |
| Mutator Zone |  |  |
| 2 | [Transmit] | On Player Leaving Zone Transmit On |
| Barriers |  |  |
| 2 | [On Receive] | Enable When Receiving From |

The Mutator Zone is placed in the mouth of the arena, in the same line as the Barrier, and the player is fired through the Mutator Zone by the Speed Boost. When the player leaves the Mutator Zone, the barriers are raised which locks the players within the arena.
