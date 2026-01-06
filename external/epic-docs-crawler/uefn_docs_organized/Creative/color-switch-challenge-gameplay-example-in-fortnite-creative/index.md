# Color Switch Challenge

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/color-switch-challenge-gameplay-example-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:26:47.998867

---

Landing on a battlefield with multiple colorful tiles, you have to stay away from the dangerous ones, or else you will fall and be eliminated. Nobody knows which color will be picked! Good luck, and have fun surviving.

## Ingredients

**You will need:**

- **1 Teleporter device**
- **16 Trick Tile devices**
- **1 Random Number Generator device**
- **1 Sequencer device**
- **1 Trigger device**
- **1 Billboard device**
- **1 Grind Powerup**
- **1 Damage Volume device**

## Method

The color switch challenge is randomly picking a predefined set of tiles and asking players to stay away from them. Otherwise, the tiles will be removed randomly resulting in the players falling to their deaths and losing the match. After a while, the removed tiles will be reset if players have successfully survived.

This challenge could be built using various different approaches, including destroying all the other tiles except for the picked ones instead. Here the example is showing a straightforward approach but it can be built in other ways.

You can use Trick Tiles to remove the attached tiles and then bring them back after the player has survived for a while. The Random Number Generator is used to introduce randomness to the game while Triggers are used to communicate with different devices. The Grind Powerup is an optional choice, but it is recommended to have it to create more fun and challenge.

## Modified Options

### My Island Settings

| Option | Value |
| --- | --- |
| ALLOW BUILDING | None |
| ENVIRONMENT DAMAGE | Off |
| STRUCTURE DAMAGE | None |
| SHOW WOOD RESOURCE COUNT | NO |
| SHOW STONE RESOURCE COUNT | NO |
| SHOW METAL RESOURCE COUNT | NO |

In **My Island -> Settings**, it is best if you set **Allow Building** to **None** and **Environment Damage** to **Off** for this gameplay. Otherwise it would interfere with the Trick Tile devices and their attached tiles.

### Teleporter Device Options

| Option | Value |
| --- | --- |
| Teleporter Rift Visible | NO |
| Play Visual Effects | NO |
| Play Sound Effects | NO |
| Conserve Momentum | NO |
| Teleport to When Receiving From | CHANNEL 90 |
| When Teleported to Transmit On | CHANNEL 100 |

The **Teleporter** is used to teleport players to the gameplay area, so we don't need **Play Visual Effects** or **Play Sound Effects** enabled. However, we want to make sure that when players are teleported, we are sending a message for initialization on a channel.

### Trick Tile Device Options

| Option | Value |
| --- | --- |
| Activation Delay | 3 SECONDS |
| Trigger on Player Contact | NO |
| Trigger when Receiving From | CHANNEL (1 / 2 / 3) |
| Reset when Receiving From | CHANNEL 100 |

We have tiles in three different colors: Red, Yellow, and White. The tiles are manually activated and removed when receiving a signal, so set the **Trigger on Player Contact** option to **No** and set the channels for transmitting. The reset signal is the same as the initialization sent from the Teleporter.

### Random Number Generator Device Options

| Option | Value |
| --- | --- |
| Value Limit 2 | 3 |
| Roll Time | 5 SECONDS |
| Zone | FORWARD |
| Length | 3 |
| Activate when Receiving From | CHANNEL 100 |

The **Random Number Generator** is used to trigger three different signals randomly, with triggers placed inside the associated zone. It is used to pick a random set of the color tiles.

| Option | Value |
| --- | --- |
| When Triggered Transmit On | CHANNEL (1 / 2 / 3 / 80) |

Set triggers to send out on channels for three different colors. For each of the triggers, place a new one to send a message to Channel 80 in order to start the Sequencer for resetting the Trick Tiles.

### Sequencer Device Options

| Option | Value |
| --- | --- |
| Tempo (bmp) | 10 |
| Length | 3 |
| Zone Direction | FORWARD |
| Start Sequence When Receiving From | CHANNEL 80 |

The **Sequencer** is used as a delay before resetting the Trick Tiles, and it could be played for different lengths of time depending on the creator's need.

| Option | Value |
| --- | --- |
| When Triggered Transmit On | CHANNEL (100) |

Set the **When Triggered Transmit On** option to a channel. This will reset the Trick Tiles and the Random Number Generator after a delay.

### Billboard Device Options

| Option | Value |
| --- | --- |
| Set Text Visible When Receiving From | CHANNEL (1 / 2 / 3) |
| Set Text Hidden When Receiving From | CHANNEL 100 |

Set the above options to toggle text hint visibility when the Billboard device receives a signal on the selected channel.

### Grind Powerup Device Options

| Option | Value |
| --- | --- |
| Effect Duration | INFINITE |
| Time to respawn | NEVER |
| Ambient Audio | OFF |
| Pick Up Audio | OFF |
| Pickup when received from | CHANNEL 100 |

Once initialized, this powerup will apply the grind effect to players so they will be slipping and sliding, which increases the challenge for the players.

### Damage Volume Device Options

| Option | Value |
| --- | --- |
| Zone Width | 8 |
| Zone Depth | 8 |

Sets a **Zone** shape where players receive enough damage to be immediately eliminated once falling down from the missing tiles.

## Message Setup

| Message Setup - Channel 1 |  |  |
| --- | --- | --- |
| Trigger |  |  |
| 1 | [Transmit] | When Triggered Transmit On |
| Billboard |  |  |
| 1 | [On Receive] | Set Text Visible When Receiving From |
| Trick Tile |  |  |
| 1 | [On Receive] | Trigger When Receiving From |

The settings for Channel 1 show the Billboard text, and trigger removing the Trick Tile once the Trigger is picked. These settings are also applied to Channels 2 and 3.

| Message Setup - Channel 80 |  |  |
| --- | --- | --- |
| Trigger (In Random Number Generator) |  |  |
| 80 | [Transmit] | When Triggered Transmit On |
| Sequencer |  |  |
| 2 | [On Receive] | Start Sequence When Receiving From |

The settings for Channel 80 re-trigger the Sequencer after the Random Number Generator has picked a new result.

| Message Setup - Channel 100 |  |  |
| --- | --- | --- |
| Trigger (In Sequencer) |  |  |
| 100 | [Transmit] | When Triggered Transmit On |
| Teleporter |  |  |
| 100 | [Transmit] | When Teleported Transmit On |
| Trick Tile |  |  |
| 100 | [On Receive] | Reset When Receiving From |
| Billboard |  |  |
| 100 | [On Receive] | Set Text Hidden When Receiving From |

The settings for Channel 100 initialize the Trick Tile and Billboard devices once they receive signals from a trigger, or from being teleported to the gameplay area.
