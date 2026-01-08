# Voting HUB

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/party-game-1-voting-hub-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:21:28.224126

---

Voting HUBs are a lot like a pre-game lobby; they’re themed spaces where potential players spawn before a game begins. A voting HUB differs from an on-boarding lobby in a few key areas:

- There is no on-boarding for each mini-game.
- Additional devices are placed in the lobby to handle the player voting structure.
- The reusable game manager has a number of functions in a party game:

  - Teleports players to mini-games and brings them back to the HUB.
  - Tracks players’ scores.
  - Resets devices.
  - Reveals the winner.

## Spawn Area

Players spawn together into a common area where they receive a HUD message welcoming them to the game and instructing players to start the vote.

[![An example of a spawn area.](https://dev.epicgames.com/community/api/documentation/image/5be4311b-e27a-4ad7-ba33-40ce1a19a790?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5be4311b-e27a-4ad7-ba33-40ce1a19a790?resizing_type=fit)

**Devices used**:

- [**1 x Barrier**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-barrier-devices-in-fortnite-creative) device
- [**2 x HUD Message**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative) devices
- [**6 x Player Spawner**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-spawn-pad-devices-in-fortnite-creative) devices

### Barrier

| Option | Value | Explanation |
| --- | --- | --- |
| **Barrier Material** | None | Creates a see-through box around the teleporter. |

### HUD Message 1&2

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | **HUD #1**:   - Welcome to the Arcade!   **HUD #2**:   - Stand in a zone to vote for a specific game! | Welcomes players to the party games HUB. |

### Player Spawner 1-6

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible in Game** | False | Spawn pads are invisible in the game. |

#### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Player Spawner** | Disable | **Success Trigger** | On Triggered | The spawn pads are disabled when the Success Trigger is triggered. |

## Voting Structure

Players activate the button starting the vote. The button device signals the Pulse Trigger into starting an infinite looping sequence. Once the button is activated, players vote on which game to play by standing in a Player Counter’s volume that represents the mini-game they want to play.

The looping sequence ends only when a mini-game successfully wins the vote.

Each mini game has a miniature version of the game next to the Player Counter.

|  |  |
| --- | --- |
|  |  |
| Tilt N Boom | Race |

The Pulse Trigger periodically triggers the Decrement Vote Count Trigger and Zone Triggers in its volume. The Zone Triggers signal the Player Counter to compare the number of players in the Player Counter volume to the target number required to select the mini-game.

Every player that enters a Player Counter volume causes the target number to decrement. When the Decrement Vote Count Trigger is signaled by the Pulse Trigger, it causes the Player Counter to recount the number of players subtracting the number of required players until the target number is reached.

The first Player Counter to reach the required number of players sends a signal to a Success Trigger. The Success Trigger sends three signals; one to the Pulse Trigger stopping the looping sequence, the second to reset the Player Counters, and a third to Teleporter devices causing players to teleport to the winning mini-game.

**Devices used**:

- [**1 x Button**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-button-devices-in-fortnite-creative) device
- [**1 x Pulse Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-pulse-trigger-devices-in-fortnite-creative) device
- [**7 x Teleporter**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-teleporter-devices-in-fortnite-creative) devices
- [**2 x Player Counter**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-counter-devices-in-fortnite-creative) devices
- [**5 x Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative) devices

### Button

| Option | Value | Explanation |
| --- | --- | --- |
| **Interaction Text** | START VOTE | Informs players that the vote has started. |
| **Visible during games** | No | The button doesn't need to be visible during gameplay. |
| **Interaction Radius** | 0.5 | One player must be close enough to interact with the button. |

### Pulse Trigger

| Option | Value | Explanation |
| --- | --- | --- |
| **Loop Infinitely** | True | The device loops infinitely. |
| **Tempo (Bpm)** | 50.0 | The loop pulses forward indefinitely at 50 beats per minute. |

#### Direct Event Binding

| \*Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Pulse Trigger** | Start Sequence | **Start Vote Button** | On Interact | The button starts the pulse trigger when the player starts the voting. |
| **Pulse Trigger** | Stop Sequence | **Success Trigger** | On Triggered | The Trigger stops the pulse trigger from looping infinitely. |

### Teleporter 1-7

Drag the first Teleporter out of the [Content Browser](unreal-editor-for-fortnite-glossary#content-browser) and modify its options.

Afterward, duplicate the device and place the **Tilt N Boom Teleporter Receive** and **TNB Non-Game Teleporters** to their respective mini-game game areas. Keep the **Send Teleporters** and **HUB Teleporter** at the voting HUB.

Name the teleporters after their function:

- **HUB Teleporter**
- **Tilt N Boom Teleporter Receive**
- **Tilt N Boom Teleporter Send**
- **TNB Non-Game Teleporter**
- **Race Teleporter Receive**
- **Race Teleporter Send**
- **Race Non-Game Teleporter**

| Option | Value | Explanation |
| --- | --- | --- |
| **Teleporter Group** | **HUB Teleporter**:   - Group None   **Tilt N Boom Teleporter Receive**:   - Group B   **Tilt N Boom Teleporter Send**:   - Group None   **TNB Non-Game Teleporter**:   - Group U   **Race Teleporter Receive**:   - Group O   **Race Teleporter Send**:   - Group None   **Race Non-Game Teleporter**:   - Group W | Devices that have the Teleport Group set to Group None do not target a specific teleporter. The teleporters are controlled by the game manager to send players to and from the mini-games. |
| **Teleporter Target Group** | **HUB Teleporter**:   - Group None   **Tilt N Boom Teleporter Receive**:   - Group None   **Tilt N Boom Teleporter Send**:   - Group B   **TNB Non-Game Teleporter**:   - Group None   **Race Teleporter Receive**:   - Group None   **Race Teleporter Send**:   - Group W   **Race Non-Game Teleporter**:   - Group None | Devices that have the Target Group set to Group None do not target a specific teleporter. The teleporters are controlled by the game manager to send players to and from the mini-games. |
| **Teleporter Rift Visible** | False | The teleporter rift is invisible. |

### Player Counter

Drag the first Player Counter out of the [Content Browser](unreal-editor-for-fortnite-glossary#content-browser) and modify its options. Afterward, duplicate the device to match the number of mini-games your Party Games island will have.

Name the Player Counters after their respective mini-game.

| Option | Value | Explanation |  |
| --- | --- | --- | --- |
| **Compare Player Count** | Equal or More | Determines the number of players against the Target Player Count to transmit a Success or Failure trigger to other devices. |  |
|  | **Target Player Count** | 2 | You need at least 4 players to play any of the mini-games. |
| **Zone Visible During Game** | True | Players need to see the zone to know whether the count was successful or not. |  |

#### Direct Event Binding

| \*Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Player Counter** | Compare Players To Target | **Zone 2 Trigger** | On Triggered | If the player counter has a successful player count, the Zone 2 Trigger starts the affiliated mini-game. |
| **Player Counter** | Decrement Target Player Count | **Decrement Vote Count Trigger** | On Triggered | If the player counter has a failed player count, the Decrement Vote Count Trigger disables the affiliated mini-game devices. |
| **Player Counter** | Reset Target Player Count | **Success Trigger** | On Triggered | If the player counter has a successful player count, the Success Trigger enables the affiliated mini-game devices. |

### Triggers 1-5

For the voting structure, you need five triggers. Create the first [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative) and copy it until you have five.

Rename the Triggers **Success Trigger**, **Decrement Vote Count Trigger**, **Zone 1 Trigger**, **Zone 2 Trigger**, and **Zone 3 Trigger**.

These names let you know which Trigger is responsible for signaling the Player Counters and sending players to the mini-games, activating the mini-games, and restarting the vote.

Place all the Zone Triggers inside the Pulse Trigger’s volume.

Use the following option on the **Decrement Vote Count Trigger**.

| Option | Value | Explanation |
| --- | --- | --- |
| **Times Can trigger** | 3 | This trigger is linked to 3 Player Counter devices. |

## Winner’s Circle

A Player Reference device displays the winning player and their score in the HUB when the mini-game is finished, allowing the winning player to revel in their victory.

**Devices used**:

- [**1 x Player Reference**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-reference-devices-in-fortnite-creative) device
- [**2 x Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative)  devices

### Player Reference

| Option | Value | Explanation |
| --- | --- | --- |
| **Show Player Details** | True | When a winner is found in a mini-game, their character appears on the Player Reference device. |
| **Start To Track** | Score | The device tracks the scores of the winning players. |
| **Activated By Sequencers** | False | The device is activated by the Verse device. |
| **Registered By Sequencers** | False | The device is registered by the Verse device. |

### Triggers

For the voting structure, you need two triggers. Create the first Trigger and copy it until you have two.

Rename the Triggers **Activate Trigger** and **End Game Trigger**.

These names let you know which Trigger is responsible for activating the mini-game and which Trigger ends the game. Lasty, change the second Trigger’s options, to the ones below:.

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible in Game** | False | Triggers don’t need to be visible. |
| **Triggered by Player** | False | Trigger isn’t activated by players. |
| **Triggered by Vehicle** | False | Trigger isn’t activated by vehicles. |
| **Triggered by Sequencers** | False | Trigger isn’t activated by sequencers. |
| **Triggered by Water** | False | Trigger isn’t activated by water. |
| **Timer Label Text** | Large | Text uses the Large label to display the text on the HUD. |
| **Trigger VFX** | False | VFX are not necessary. |
| **Trigger SFX** | False | SFX are not necessary. |

#### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Activate Trigger** | Trigger | **Intro Cinematic Sequence** | On Stopped | The stopped animation triggers the device. |

## Next Section

[![Targeted Camera Gameplay](https://dev.epicgames.com/community/api/documentation/image/6ab8ff27-d78c-4f0b-94b1-600b4ce6a307?resizing_type=fit&width=640&height=640)

Targeted Camera Gameplay

Add item spawners to the raft that spawn different weapons at different times.](<https://dev.epicgames.com/documentation/en-us/fortnite/party-game-2-targeted-camera-gameplay-in-unreal-editor-for-fortnite>)
