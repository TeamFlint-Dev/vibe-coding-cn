# Loo Roll Rush

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/loo-roll-rush-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:27:44.723021

---

[![Loo Roll Rush Gameplay Example](https://dev.epicgames.com/community/api/documentation/image/bf37a0b3-afbe-4827-b8f5-3c917f640530?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bf37a0b3-afbe-4827-b8f5-3c917f640530?resizing_type=fit)

Our intrepid racer readies herself as she runs through the door. As soon as she steps inside Flush Factory, the Toilet rolls spawn. Grabbing them in order, she takes as many shortcuts as she can, using her jet-pack to help. When she grabs the last roll, the game is over and the victory screen shows with her time displayed prominently. Was it good enough to beat her friends?

*Loo Roll Rush Video*

## Ingredients

**You will need:**

- **7 Collectible Item devices**
- **1 Attribute Trigger device**
- **1 Round Settings device**
- **1 Trigger device**
- **1 Timer device**

## Method

Set up the Collectible Items along a route for the player to pick up. They're initially hidden and are switched on with the Trigger, which also sets the Timer running. When the player has picked up all of the collectibles, the Attribute Trigger will pass its check and set a lap time on the timer and then end the game using the Round Settings device.

## Modified Options

### Collectible Item Device Options

| Modified Options - collectible Item |  |
| --- | --- |
| Collectible Object | Toilet Paper |
| Visible on Game Start | Off |

By setting the **Visible on Game Start** option to **Off**, you hide the collectibles until a player enters the area. When setting the same option on multiple devices, it's a good idea to set them all on one device, and then copy that device for the others. This means you only have to change the options once.

### Timer Device Options

| Modified Options - Timer |  |
| --- | --- |
| Auto Start | Off |
| Lap Time Style | Count Up |

The **Auto-Start** option is set to **Off** because you will be starting this manually. The **Lap Time Style** option is used to show the time elapsed from the start of the game on the scoreboard, rather than showing the time left when you set a player's lap time.

### Attribute Trigger Device Options

| Modified Options - Attribute Trigger |  |
| --- | --- |
| Min Player Score | 6 |

The Attribute Trigger needs to activate when a player has a Score value, because you want to activate this Trigger directly when the collectibles are picked up. You need to set the score to one less than the number you want, because the Attribute Trigger will receive its message before the stat updates for the player.

### Message Setup

| Message Setup - Channel 1 |  |  |
| --- | --- | --- |
| Trigger |  |  |
| 1 | [Transmit] | When Triggered Transmit On |
| Collectible Object (x7) |  |  |
| 1 | [On Receive] | Turn Visibility On When Receiving From |
| Timer |  |  |
| 1 | [On Receive] | Start when Receiving From When Receiving From |

The **Trigger** starts the match. When the player walks over it, the Loo Rolls appear and can be picked up, and our Timer starts counting.

| Message Setup - Channel 2 |  |  |
| --- | --- | --- |
| Collectible Object (x7) |  |  |
| 2 | [Transmit] | When Collected Transmit On |
| Attribute Trigger |  |  |
| 2 | [On Receive] | Listen to Channel |

Each time a Collectible Item is picked up, the Attribute Trigger checks to see if the player that picked up the collectible has a score of 6 or higher. When the seventh item is picked up, this will be active because the message on the collectible is sent before the score is added to the player.

| Message Setup - Channel 3 |  |  |
| --- | --- | --- |
| Attribute Trigger |  |  |
| 3 | [Transmit] | If all Checks are Valid Transmit On |
| Timer |  |  |
| 3 | [On Receive] | Set Lap TimeWhen Receiving From |
| Round Settings |  |  |
| 3 | [On Receive] | End Round When Receiving From |

When the Attribute Trigger passes its check, the timer sets a lap time for the player. That time will appear on the scoreboard, and can be used for determining the winner of the match. At the same time, the Round Settings device will end the round.
