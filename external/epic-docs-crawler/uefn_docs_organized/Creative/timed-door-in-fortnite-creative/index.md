# Timed Door

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/timed-door-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:26:24.828074

---

[![Timed Door Gameplay Example](https://dev.epicgames.com/community/api/documentation/image/832941db-5185-4d64-beef-c94e0e4cc326?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/832941db-5185-4d64-beef-c94e0e4cc326?resizing_type=fit)

A long corridor lies ahead of our adventurer, cloaked in near darkness. As she moves forward, the door opens, and torches to the sides burst into life. A ticking sound indicates that she only has a short window before the door closes. She hurries forward, but not fast enough, just as she reaches the door it slams shut and the torches go out. Better try again…

*Timed Door Video*

## Ingredients

**You will need:**

- **1 Trigger device**
- **1 Timer device**
- **1 Lock device**
- **2 Customizable Light devices (Burning Torches)**

## Method

Create a corridor with a door at the end. Embed a Lock Device into the wall with the door. The Lock can control the door, so it stays locked unless the Timer is running. Place the Trigger at the start of the corridor to open the door, switch on the torches, and start the timer. Set the Timer anywhere, and give the player just enough time to get through the door. When the Timer completes, it sends a signal to close the door, switch off the torches, and resets itself.

## Modified Options

### Trigger Device Options

| Modified Options - Trigger |  |
| --- | --- |
| Visible in Game | No |

We don't want the player to know that they'll be touching the trigger, so set the **Visible In Game** option to **No** so that the Trigger is hidden from players.

### Timer Device Options

| Modified Options - Timer |  |
| --- | --- |
| Duration | 3 Seconds |
| Auto Start | Off |
| Alarm Audio | Off |

Set the **Duration** to be just enough to get through the door in time. Set the **Auto Start** option to **Off** (the Trigger will be activating it) and set the **Alarm Audio** option to **Off**.

### Customizable Light Device Options

| Modified Options - Customizable Light (both) |  |
| --- | --- |
| Initial State | Off |
| Turn On Team Filter | None |
| Turn Off Team Filter | None |

Initially, we want the Burning Torches to be switched off, so set their **Initial State** to **Off**. Also, switch both their **Team Filters** to **None** to keep players from interacting with the torches directly.

### Lock Device Options

| Modified Options - Lock Device |  |
| --- | --- |
| Visible In Game | Off |

Set the **Visible In Game** option for the Lock to **Off**, as it doesn't fit particularly well with our medieval theme.

### Message Setup

| Message Setup - Channel 1 |  |  |
| --- | --- | --- |
| Trigger |  |  |
| 1 | [Transmit] | When Triggered Transmit On |
| Customizable Light x2 (Burning Torch) |  |  |
| 1 | [On Receive] | Turn On When Receiving From |
| Lock Device (Door Lock) |  |  |
| 1 | [On Receive] | Open When Receiving From |
| Timer |  |  |
| 1 | [On Receive] | Start When Receiving From |

When players step on the Trigger, turn on the lights, open the door, and start the timer.

| Message Setup - Channel 2 |  |  |
| --- | --- | --- |
| Timer |  |  |
| 2 | [Transmit] | When Complete Transmit On |
| 2 | [On Receive] | Reset When Receiving From |
| Customizable Light x2 (Burning Torch) |  |  |
| 2 | [On Receive] | Turn Off When Receiving From |
| Door Lock(Burning Torch) |  |  |
| 2 | [On Receive] | Turn Off When Receiving From |
