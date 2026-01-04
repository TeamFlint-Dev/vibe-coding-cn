# Designing a Speedway Race

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/designing-a-speedway-race-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:58:59.285547

---

Ready to make your own racetrack? The **Design A Speedway Race** template island is the perfect place to start! With a small track, you can see how the race was set up and configured to create your very own racetrack island. This tutorial is a companion to the template.

The Island Code for the Design A Speedway Race Template is **8331-9445-9319**

To play through this [island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#island), click **CHANGE** on the [Fortnite Lobby](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) screen. On the [Discover](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) screen, click the [Island Code](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#island-code) tab and enter the code for **Design A Speedway Race**. You can look around the tutorial zone before running a race. This tutorial follows the island’s tutorial zone, and walks you through the [devices](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#device) used, as well as offering design tips for customizing your own racetrack experience.

[![high level view of speedway race template in fly mode](https://dev.epicgames.com/community/api/documentation/image/3fe63a6c-2a28-44a9-b336-b9ef2d67f702?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3fe63a6c-2a28-44a9-b336-b9ef2d67f702?resizing_type=fit)

For information on how to set up your own racetrack course from scratch (create the track, place barriers, and so on), check out the [Car Racing Game tutorial](https://dev.epicgames.com/documentation/en-us/fortnite/design-a-car-racing-game-in-fortnite-creative).

## Using The Template

Use the **Design A Speedway Race** template to create your own racing game.

- Use the **Change Destination** console, then click **Create New**.
- Switch to the **Templates** tab, search for and select **Design A Speedway Race**, then click **Confirm**.
- Wait for the destination to update, then enter.

[![Select the Design A Speedway Race template](https://dev.epicgames.com/community/api/documentation/image/ff202f96-822f-422b-9315-1f1cc0f86638?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ff202f96-822f-422b-9315-1f1cc0f86638?resizing_type=fit)

When you spawn onto the island, you’ll begin in the tutorial zone. This is where you can learn about the devices used to develop the racetrack. The devices are grouped by [game mechanic](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-mechanics) in display areas along the pathway. Follow using the guiding arrows on the floor.

[![guiding arrows on the floor](https://dev.epicgames.com/community/api/documentation/image/f817757c-3c34-4716-a1f4-35c264e2c1e2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f817757c-3c34-4716-a1f4-35c264e2c1e2?resizing_type=fit)

To exit the tutorial zone and go to the racetrack, double-press the spacebar to enable [Fly mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#fly-mode). Move upward or forward from the spawn area. On the [minimap](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#minimap) you will see that the tutorial zone is under and adjacent to the race starting area.

[![minimap of tutorial zone location underneath the racetrack](https://dev.epicgames.com/community/api/documentation/image/755f09b5-639d-4954-beda-336f3325ebbf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/755f09b5-639d-4954-beda-336f3325ebbf?resizing_type=fit)

### Disabled Devices

As you explore the tutorial zone, you will find that some of the devices are disabled and are in the display as examples. That means the devices will not automatically work if copied and pasted from the tutorial zone. Instead, find the same device in the racetrack and copy it from there to make sure your new device is enabled with the appropriate settings.

As you go through the tutorial zone, each disabled device is labeled in the device list.

[![example of list of disabled devices in billboard](https://dev.epicgames.com/community/api/documentation/image/3a66d0e2-73ae-470e-860c-5c93a3383e34?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a66d0e2-73ae-470e-860c-5c93a3383e34?resizing_type=fit)

## Copying from the Tutorial Zone to Your Island

If you want to use the Tutorial Zone for your own island rather than using the Design A Speedway Race template directly, you can copy parts of the tutorial zone, including the devices and their settings, by using multi-select.

1. Hold down the **R** key while in [Build](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#build) mode to select multiple [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop) and devices.
2. Save them to your [Quick bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-bar) using a number key.
3. Travel back to the [hub](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hub), and switch to your island to place the copied props and devices.
4. Place the props and devices you selected as a group.
5. Customize the props and devices for your own use.

## Tutorial Spawn Pads

Players spawning into the island appear in the tutorial zone before the race starts from a set of 8 [Player Spawn Pads](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative). These are disabled by a [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) when the race starts.

### Player Spawn Pad Modified Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Disable When Receiving From** | Channel 31 | These spawn pads are disabled when receiving a signal on this channel. |

### Trigger Modified Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Triggered By Player** | Off | The trigger can’t be activated by players. |
| **Triggered By Vehicles** | Off | The trigger can’t be activated by vehicles. |
| **Triggered By Sequencers** | Off | The trigger can’t be activated by sequencers. |
| **Triggered By Water** | Off | The trigger can’t be activated by water. |
| **Activate on Game Phase** | Game Start | The trigger activates when the race begins. |
| **Trigger Sound** | Disabled | The trigger does not produce a sound when activated. |
| **Trigger VFX** | Disabled | The trigger does not produce visual effects when activated. |
| **When Triggered Transmit On** | Channel 31 | When the trigger is activated, it sends a signal on this channel. |

## Player and Car Spawn

Inside the **Player & Car Spawn** display are the following devices:

- [Player Spawn Pad device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- [Sports Car Spawner device](https://dev.epicgames.com/documentation/en-us/fortnite/using-sports-car-spawner-devices-in-fortnite-creative)
- [Player Counter device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-counter-devices-in-fortnite-creative)
- [Barrier device](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative)

All of the devices in this display are disabled.

With these devices, you can set up each player’s spawn and designated car and counter. When players spawn into the game, they are automatically assigned a car and a number with the Player Counter. The barrier device restricts the car movement until the start of the race. Each Player Spawner, Counter, and Sports Car device runs on [channels](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) 1-8 for each of the 8 players.

[![player and car spawn display](https://dev.epicgames.com/community/api/documentation/image/efcb9473-0d89-4297-be25-ab21702a3390?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/efcb9473-0d89-4297-be25-ab21702a3390?resizing_type=fit)

[![high level shot of the cars at the starting line](https://dev.epicgames.com/community/api/documentation/image/c929200c-ae4f-46ff-bcf3-d505999a3553?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c929200c-ae4f-46ff-bcf3-d505999a3553?resizing_type=fit)

### Player Spawn Pad Modified Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Player Team** | Team 1-8 | Designates which player is assigned to which spawn pad. |
| **Priority Group** | 1-8 | Determines the numerical order players are assigned spawn pads. |
| **Use as Island Start** | Off | This is not the spawn pad where players spawn into the island during the pre-game phase. |
| **Visible in Game** | Off | Players cannot see the spawn pad. |
| **When Player Spawned Transmit On** | Channel 1-8 | The channel number is intended to match the Spawn Pad number. This carries through multiple devices. |

### Sports Car Spawn Modified Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Visible During Game** | OFF | The spawner is not visible to players. |
| **Boost Regen** | Unlimited | Players can boost in an unlimited duration. |
| **Radio** | Disabled | The radio is off. |
| **Color and Style** | Pick a color | Choose a different color for each spawner. |
| **Assigns Driver When Receiving From** | Channels 1-8 | The channel number should match the Spawn Pad number. This carries through multiple devices. |
| **Disable When Receiving From** | Channel 10-17 | Despawns the car when receiving a signal on this channel. Starts at 10, and is incremented by 1 for each additional car. |
| **When Player Enters Vehicle Transmit On** | Channel 20-27 | Transmits a signal when the player enters the car. Starts at 20, and is incremented by 1 for each additional car. |
| **When Player Exits Vehicle Transmit On** | Channel 40-47 | Transmits a signal when the player exits the car. Starts at 40, and is incremented by 1 for each additional car. |
| **When Vehicle is Destroyed Transmit On** | Channel 36 | Optional, transmits a signal when the car is destroyed. |

### Player Counter Modified Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Target Player Count** | 1 Player | Assigns 1 player per counter. |
| **Compare at Game Start** | Yes | Counter automatically starts at the game start. |
| **Compare on Count Charge** | No | Does not compare each time the player is counted. |
| **Info Panel Visible** | Off | Counter is not visible by players. |
| **Use Zone** | In Zone | Counter is restricted to a specific region. |
| **Disable When Receiving From** | Channel 30 | Disables the player counter when the race starts. |
| **Compare Players to Target when Receiving From** | Channel 20 | Checks when a player enters or exits a car. |
| **When Count Fails Transmit On** | Channel 10 | Despawns cars not used by players. |

### Barrier Modified Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Barrier Style** | Invisible | Barrier is not visible to players. |
| **Zone Shape** | Box (Hollow) | Sets the barrier shape. |
| **Barrier Height** | 2 | Sets the barrier height. |
| **Disable When Receiving From** | Channel 30 | Disables the barrier when the race starts. |

### Design Tips

You can change up the feel and theme of the race by changing the vehicle spawner.

For example, for this race we used the Sports Car spawner, but if your racetrack is a dirt road, you could use the **Quadcrash** four-wheeler instead.

If you want a demolition derby instead of a simple race, you can send a signal when a car is destroyed to trigger other effects like eliminations, score awards, or accolades.

## Race Mechanics

Inside the Race Mechanics display are the following devices:

- [Race Checkpoint device](https://dev.epicgames.com/documentation/en-us/fortnite/using-race-checkpoint-devices-in-fortnite-creative)
- [Race Manager device](https://dev.epicgames.com/documentation/en-us/fortnite/using-race-manager-devices-in-fortnite-creative)
- [Accolades device](https://dev.epicgames.com/documentation/en-us/fortnite/using-accolades-devices-in-fortnite-creative)

The Race Checkpoint device is disabled.

The Race Checkpoint device provides checkpoints throughout the track, and makes sure players cannot go through the checkpoint outside of their car. For more information on restricting players outside of vehicles, see [Exiting Car Mechanics](https://dev.epicgames.com/documentation/en-us/fortnite/designing-a-speedway-race-in-fortnite-creative).

The Race Manager is preset for 4 laps to race completion, to start the race after a countdown, and to display the directional arrow on the [HUD](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hud).

It is also configured to transmit on channels 31, 33, and 34 for when to initiate the race start, lap completion, and race completion.

The Accolades device is set to award Large [XP](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#xp) on lap completion and Extra Large XP when a player completes the race.

[![race mechanics display](https://dev.epicgames.com/community/api/documentation/image/ea9fb39f-0983-492e-b5e2-caa1c8f217b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ea9fb39f-0983-492e-b5e2-caa1c8f217b2?resizing_type=fit)

### Race Checkpoint Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Checkpoint Number** | Checkpoint 150 | The checkpoints on the track use sequential numbers from 1-10. |
| **Allow Pass Without Vehicle** | No | Players can only pass the checkpoint while driving a vehicle. |
| **Current Checkpoint Color** | Sky Blue | The color set for a checkpoint not yet completed. |
| **Completed Checkpoint Color** | Red-Orange | The color set for a completed checkpoint. |
| **Visible Before Race Start** | Yes | Checkpoints are visible from the start. |
| **Enabled During Phase** | Pre-Game Only | Checkpoints are enabled in the pre-game phase. |
| **Disable When Receiving From** | Channel 100 | The checkpoint is disabled when it receives a signal on this channel. |

### Race Manager Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Race Circuit Name** | Crazy 8 | The name of your racetrack. |
| **Number of Laps** | 4 | Sets the number of laps for the race. |
| **Start Race on Game Start** | No | The race does not immediately start when the game starts. |
| **Start Race When Receiving From Channel** | Channel 31 | Starts the race when receiving a signal on this channel. |
| **On Lap Completion Transmit on Channel** | Channel 33 | Transmits a signal on this channel when a lap is completed. |
| **On Race Completion Transmit on Channel** | Channel 34 | Transmits a signal on this channel when the race is completed. |

### Accolade 1 Options: Lap Complete

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Name** | Lap Complete | The accolade name. |
| **XP Award** | Large | The relative amount of XP awarded. |
| **Triggering Player Only** | Yes | Awarded when a player completes a lap. |
| **Award When Receiving From** | Channel 33 | The device awards XP when receiving a signal on this channel. |
| **Would Have Awarded Transmit On** | Channel 33 | This option is for testing, and only works before you publish your island. |

### Accolade 2 Options: Race Complete

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Name** | Race Complete | The accolade name. |
| **XP Award** | Very Large | The relative amount of XP awarded. |
| **Triggering Player Only** | Yes | Awarded when a player completes the race. |
| **Award When Receiving From** | Channel 34 | The device awards XP when receiving a signal on this channel. |
| **Would Have Awarded Transmit On** | Channel 34 | This option is for testing, and only works before you publish your island. |

### Design Tips

If you want to encourage your players to engage in other activities during the race, you can set up accolades that reward them for actions other than completing laps or the race, like completing an optional high jump or collecting all the collectibles you placed around the track.

You can also combine these with score rewards as described below to make these activities even more compelling to players.

## End Game Mechanics

Inside the End Game Mechanics display are the following devices:

- [Timer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative)
- [End Game device](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative)

Both devices are configured and ready to be used.

The Timer and End Game devices work together to trigger the end of the race. The Timer is set to allow players to finish the race within a certain time after the race has been won. Once that time ends, the Timer transmits a signal to the End Game device to end the race.

[![end game mechanics display](https://dev.epicgames.com/community/api/documentation/image/23c4010e-cda3-461a-83d5-2d476ea8bd4f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23c4010e-cda3-461a-83d5-2d476ea8bd4f?resizing_type=fit)

### Timer Device Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Duration** | 10 Seconds | How long the game will continue after the winner finishes the race. Other players can try to finish the race or reach a checkpoint to improve their standing in this time. |
| **Timer Name** | Game End | The name of this timer. |
| **Completion Behavior** | Disable | Disables the device when the timer countdown ends. |
| **Display Time In** | Seconds Only | Displays time in seconds. |
| **Timer Label Text Style** | Extra Large | The size of the timer display in the player HUD. |
| **Urgency Mode Time** | 10 Seconds | The timer is in urgency mode immediately when it starts. |
| **Urgency Text** | 10 Seconds to Finish the Race | The timer displays this message immediately. |
| **If Instigating Player is Not Present** | Use Empty Instigator | If the player that instigated the timer is no longer in the game, it will use an empty instigator. |
| **Start When Receiving From** | Channel 34 | Starts when the timer receives a signal on this channel transmitted by a player completing the race. |
| **On Success Transmit On** | Channel 37 | Transmits a signal on this channel when the timer countdown ends. |

### End Game Device Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Custom Victory Callout** | Winner! | The message displayed to the player that won the race. |
| **Custom Defeat Callout** | Better Luck Next Time | The message displayed to the players that did not win the race. |
| **Completion Behavior** | Channel 37 | Ends the game when receiving a signal on this channel. |

### Design Tips

If you are an advanced user and want to provide a more compelling end-of-race experience, you could set up your race so that once all the players cross the finish line, triggers and teleport devices move the winner, second-place, and third-place players onto a podium (and constrained with invisible barriers), and the other players are teleported in front as an audience (again constrained by an invisible barrier). You can then use the Timer to give the players on the podium 15 or 30 seconds to emote and cheer, before ending the game.

## Lap Display Tower

Inside the Lap Display Tower are the following devices:

- [Player Reference device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-reference-devices-in-fortnite-creative)
- [Score Manager device](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative)

Both devices are configured and ready to be used.

The Player Reference tracks a player’s score in relation to the amount of laps they completed. The Reference device is assigned through the Player Spawn Pad number, which ties to the car and Player Counter channel assignments as well.

On the racetrack, there are two Score Manager devices. The first gives players a +1 score increment when they complete a lap. The second gives a +1 score for completing the race. Neither device increments the score, and the score value remains the same at 1.

[![lap display tower display](https://dev.epicgames.com/community/api/documentation/image/42435e3f-68a3-4970-b23b-bd807f81292c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42435e3f-68a3-4970-b23b-bd807f81292c?resizing_type=fit)

[![lap tower on the racetrack](https://dev.epicgames.com/community/api/documentation/image/2c612e4a-f622-42c1-aec4-333e1d351024?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2c612e4a-f622-42c1-aec4-333e1d351024?resizing_type=fit)

### Score Manager Device Options: Lap Complete

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Score Value** | 1 | How much score is awarded for completing a lap. |
| **Increment Score on Awarding** | Off | The score manager does not update the score value when activated. |
| **Play Audio** | No | No audio is played when awarding score. |
| **Activate When Receiving From** | Channel 33 | Awards score to the activating player when the score manager receives a signal on this channel. |

### Score Manager Device Options: Race Complete

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Score Value** | 1 | How much score is awarded for completing the race. |
| **Increment Score on Awarding** | Off | The score value does not increment when awarded, instead the new value replaces the old value. |
| **Score Change When Activated** | 1 | The score awarded increases by 1 after every activation. |
| **Play Audio** | No | No audio is played when awarding score. |
| **Activate When Receiving From** | Channel 34 | Awards score to the activating player when the score manager receives a signal on this channel. |

### Player Reference Device Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Color** | Team Color | Matches the color set on the Team & Inventory Settings device for the team. |
| **Hologram Effect Strength** | 30% | Controls the brightness of the hologram effect. |
| **Show Base** | Off | Hides the device base. |
| **Show Player Details** | Below Player | Determines where to show the player details. |
| **Player Details Curve Amount** | No Curve | Player details are not shown on a curve. |
| **Stat to Track** | Score | Tracks player score. |
| **Allow Activate Without Player Reference** | Yes | Allows the player reference to send an activation signal without a player locked into the device. |
| **Register Player When Receiving From** | Channel 1-8 | Each of the player reference devices listens on a separate channel, for each of the 8 players. |

### Design Tips

Try altering the scores based on different variables within the race track. This can be combined with hard-to-reach optional checkpoints, or gathering items or collectibles on the track to award more points.

You can combine these with Accolades to provide further incentive for players to seek these options.

## Starting Sequence

Inside the Starting Sequence display are the following devices:

- [Sequencer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-pulse-trigger-devices-in-fortnite-creative)
- [Customizable Light device](https://dev.epicgames.com/documentation/en-us/fortnite/using-customizable-light-devices-in-fortnite-creative)
- **[Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)**
- [HUD Message device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)

The Customizable Light and HUD Message devices are disabled.

The starting sequence is the countdown for when the race begins. When the sequencer triggers, the lights and accompanying HUD messages also kick off in the following Order:

- Red Light, "Ready"
- Yellow Light, "Set"
- Green Light, "Go!"

The Trigger devices activate the lights and HUD messages within the sequence. A final Trigger device then disables the green light so it disappears from the game as the race begins.

[![starting sequence display](https://dev.epicgames.com/community/api/documentation/image/92f8fffa-d1bc-496c-b0d8-555a12acb5a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/92f8fffa-d1bc-496c-b0d8-555a12acb5a5?resizing_type=fit)

The Starting Sequence setup in the tutorial zone then transmits to the Customizable Lights on the actual racetrack. When the race begins, the sequence kicks off and the Lights turn on while the text displays in the HUD. On the racetrack, the Customizable Lights individually flash with each color for the countdown, while the Lights light up the finish line with the color.

[![The starting sequence lights](https://dev.epicgames.com/community/api/documentation/image/fff513f5-ea35-4b9c-8115-ddade68f86e7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fff513f5-ea35-4b9c-8115-ddade68f86e7?resizing_type=fit)

### Sequencer Device Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Tempo (BPM)** | 20 | How fast the sequence travels (in Beats Per Minute). |
| **Length** | 3 | The length of the sequencer device. |
| **Width** | 0.5 | The width of the sequencer device. |
| **Activate on Game Phase** | Game Start | Activates when the game starts. |

### Customizable Light Options (All 3 Lights)

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Initial State** | Off | The lights all begin the game off. |
| **Light Color** | #FF0100 #FFB000 #419501 | The hex values of the red, yellow, and green lights. |
| **Light Intensity** | 100% | The light intensity is set to maximum. |
| **Light Reflection Intensity** | 0% | The light does not reflect from nearby shiny surfaces. |
| **Light Type** | Spot Light | The type of light. |
| **Light Size** | Huge | The size of the light. |
| **Dimming Time** | 0.5 Seconds | The time for light to dim from on to off in seconds. |
| **Turn On When Receiving From** | Channel 28 Channel 29 Channel 30 | Each of the lights turns on when receiving a signal on the respective channel. |
| **Turn Off when Receiving From** | Channel 29 Channel 30 Channel 32 | Each of the lights turns off when receiving a signal on the respective channel. |

### Trigger Device Options: Red Light

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Times Can Trigger** | 1 | Can only trigger once per race. |
| **Trigger Sound** | Disabled | Does not play a sound when triggered. |
| **Trigger VFX** | Disabled | Does not display a visual effect when triggered. |
| **Disable When Receiving From** | Channel 29 | Disables the trigger when it receives a signal on this channel. |
| **When Triggered Transmit On** | Channel 28 | When the trigger is activated, it sends a signal on this channel. |

### Trigger Device Options: Yellow Light

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Times Can Trigger** | 1 | Can only trigger once per race. |
| **Trigger Sound** | Disabled | Does not play a sound when triggered. |
| **Trigger VFX** | Disabled | Does not display a visual effect when triggered. |
| **Disable When Receiving From** | Channel 30 | Disables the trigger when it receives a signal on this channel. |
| **When Triggered Transmit On** | Channel 29 | When the trigger is activated, it sends a signal on this channel. |

### Trigger Device Options: Green Light

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Times Can Trigger** | 1 | Can only trigger once per race. |
| **Trigger Sound** | Disabled | Does not play a sound when triggered. |
| **Trigger VFX** | Disabled | Does not display a visual effect when triggered. |
| **When Triggered Transmit On** | Channel 30 | When the trigger is activated, it sends a signal on this channel. |

### Trigger Device Options: Disable Green Light

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Trigger Sound** | Disabled | Does not play a sound when triggered. |
| **Trigger VFX** | Disabled | Does not display a visual effect when triggered. |
| **When Triggered Transmit On** | Channel 32 | When the trigger is activated, it sends a signal on this channel. |

### HUD Message Device Options (All 3)

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Message** | Ready… Set… GO | Each line is the message on a separate HUD Message device. |
| **Time From Round Start** | Off | The messages only trigger when they receive a signal on their respective channels. |
| **Display Time** | 1 Second 1 Second 2 Seconds | The respective display times for the HUD messages. |
| **Text Style** | Extra Large | The size of the message in the player’s HUD. |
| **Message Priority** | Priority | The messages are displayed with priority over Normal messages. |
| **Play Sound** | Round Count Down Round Count Down Round Start | Each of the HUD messages also plays the respective sound. |
| **Placement** | Top Center | Centers the message at the top of the screen. |
| **Show When Receiving From** | Channel 28 Channel 29 Channel 30 | The respective channels that signal the HUD messages to show. |
| **Hide When Receiving From** | Channel 29 Channel 30 Channel 32 | The respective channels that signal the HUD messages to hide. |

### Design Tips

You can add visual effects to the start of the race. Imagine fireworks going off as your racers start out, or explosions behind the racers.

If you want to make your race really interesting, you can add temporary [buffs](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#buff) or debuffs that trigger when the race begins.

## Exiting Car Mechanics

Inside the Exiting Car Mechanics display are 8 **Trigger** devices. The devices are configured and ready to be used.

Because the ability to exit the car cannot be turned off, you can use trigger devices instead to restrict player movement. The triggers are set to channels 1-8 and transmit signals to each Sports Car device. If a player exits their car, they will be put back into the car after 3 seconds.

[![exiting car mechanics display](https://dev.epicgames.com/community/api/documentation/image/6835b893-ef4d-447a-9ee9-ca1099a9e63d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6835b893-ef4d-447a-9ee9-ca1099a9e63d?resizing_type=fit)

### Trigger Device Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Delay** | 3 Seconds | How long it takes to trigger the player being placed back in the car. |
| **Trigger Sound** | Disabled | No sound plays when the trigger activates. |
| **Trigger VFX** | Disabled | No visual effects play when the trigger activates. |
| **Visible in Game** | No | The trigger is not visible in-game. |
| **Trigger When Receiving From** | Channels 40-47 | The respective channels that signal to activate each of the triggers. |
| **When Triggered Transmit On** | Channel 1-8 | The respective channels that each of the triggers send a signal on when activated. |

### Design Tips

You can use this effect to create a hybrid experience between racing and exploring, where the players have a longer time before they are returned to their cars. You could then have them do a timed scavenger hunt for collectibles, or have them explore a junkyard with hidden upgrades for their cars.

## Visual Devices

Inside the Visual Devices display are thefollowing devices:

- [HUD Controller device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative)
- [VFX Spawner device](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative)
- [Skydome device](https://dev.epicgames.com/documentation/en-us/fortnite/using-skydome-devices-in-fortnite-creative)

The VFX Spawner device is disabled.

The HUD Controller manages what does and does not display on the HUD. Since this is a very specific kind of experience, the usual Fortnite HUD elements like the minimap, the resources, build, and equipment bars are not needed and are hidden.

The VFX device adds some fun and flavor to your racetrack by celebrating the winner at the end of the race with balloons and confetti.

The Skydome device is specifically used within the tutorial zone to add light to the area.

[![visual devices display](https://dev.epicgames.com/community/api/documentation/image/d8364627-2493-4fd5-ad3c-2f18dc580bfc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d8364627-2493-4fd5-ad3c-2f18dc580bfc?resizing_type=fit)

### HUD Controller Device Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Show HUD** | Yes | The players have a HUD. |
| **Show Minimap** | No | The minimap is not shown in the HUD. |
| **Show HUD Info Box** | No | The HUD info box is not shown in the HUD. |
| **Show Build Menu** | No | The [Build menu / Build bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#build-bar) is not shown in the HUD. |
| **Show Player Inventory** | No | The player [inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#inventory) is not shown in the HUD. |
| **Show Health** | No | The player’s [health](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#health) is not shown in the HUD. |
| **Show Shields** | No | The player’s [shields](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#shield) are not shown in the HUD. |
| **Show Crafting Resources** | No | The crafting [resources](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#resource) are not shown in the HUD. |
| **Show Wood Resource** | No | The [wood](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#wood) resource is not shown in the HUD. |
| **Show Stone Resource** | No | The [stone resource](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#stone) is not shown in the HUD. |
| **Show Metal Resource** | No | The [metal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#metal) resource is not shown in the HUD. |
| **Show Gold Resource** | No | The [gold](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gold) resource is not shown in the HUD. |
| **Show Map / Scoreboard Prompt** | No | The [map](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) / scoreboard prompt is not shown in the HUD. |

### VFX Device Options: Confetti

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Visual Effect** | Confetti | This device produces a confetti visual effect. |
| **Spawn Tempo** | Fast | How fast the device spawns the visual effect. |
| **Enabled During Phase** | None | This effect is only enabled by a channel signal. |
| **Enable when Receiving From** | Channel 34 | This effect is enabled when receiving a signal on this channel. |

### VFX Device Options: Fireworks

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Visual Effect** | Large Fireworks | This device produces a large fireworks visual effect. |
| **Spawn Tempo** | Slow | How fast the device spawns the visual effect. |
| **Enabled During Phase** | None | This effect is only enabled by a channel signal. |
| **Sound Effect** | Fireworks | This device produces a sound effect as well as producing a visual effect. |
| **Enable when Receiving From** | Channel 34 | This effect is enabled when receiving a signal on this channel. |

### VFX Device Options: Balloons

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Visual Effect** | Balloons | This device produces a large balloons visual effect. |
| **Spawn Tempo** | Fast | How fast the device spawns the visual effect. |
| **Enabled During Phase** | None | This effect is only enabled by a channel signal. |
| **Enable when Receiving From** | Channel 34 | This effect is enabled when receiving a signal on this channel. |

### Design Tips

If you want your race to have a specific theme, you can use different visual effects, like sparkles or bubbles for a more magic-themed race, laser beams or floating rocks for a science-fiction-themed race, or spooky ghosts or eyes for a halloween-themed race.

## Team Names and Colors

Inside the Team Names and Colors display are 8 [Team Settings and Inventory devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-team-settings-and-inventory-devices-in-fortnite-creative).

All the devices are configured and ready to be used.

The Team Settings and Inventory devices operate on channels 1-8 and transmits to a specific Player Spawn Pad. The color and names help distinguish between different players when on the racetrack.

[![team names and colors display](https://dev.epicgames.com/community/api/documentation/image/2be47eba-0c52-40e4-91c8-97b8dcf310de?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2be47eba-0c52-40e4-91c8-97b8dcf310de?resizing_type=fit)

### Team Settings and Inventory Device Options

| Option Name | Value | Explanation |
| --- | --- | --- |
| **Team Name** | Team 1-8 | Each team is named in order, Team 1, Team 2, and so on, to Team 8. |
| **Team** | Team 1-8 | The team number corresponds to the team name. |
| **Team Color** | Pick a color | Each team has a different color. |

### Design Tips

Setting team names and colors is another way you can customize your race to have a specific theme.

## Customize the Island Settings

These settings will create a racing game won by the player who completes all the laps fastest.

To modify gameplay settings, press the **TAB** key and click **MY ISLAND** at the top of the screen. From here, you can access the **GAME**, **SETTINGS**, and **UI** tabs.

### My Island - Game Options

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Max Players** | 8 |  |
| **Matchmaking Type** | Flexible Teams | Allows party members to be on any team to matchmake quickly and keep games full. |
| **Spawn Limit** | 1 | Players will only spawn once. |
| **Team Visuals Determined At** | Game Start | Teams will not change from round to round. |
| **Time Limit** | 20 minutes | Determines the maximum time your race will last, it will usually finish much faster than this. |
| **Fastest Time Wins** | Enabled | The team that wins the round fastest wins the overall match. |
| **All Teams Must Finish** | Yes | The race ends when the last team finishes the race, unless ended earlier by an End Game device. |
| **Game Start Countdown** | Off | No countdown to game start. |
| **Vehicle Trick Score Multiplier** | 0.0 | Players do not gain a Score multiplier for vehicle tricks. |
| **Player Collision** | Off | Player’s don’t collide with each other. |
| **Vehicle Impact Damage Objects** | No | Vehicles don’t damage objects they collide with. |

### My Island - Settings Options

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Time of Day** | 12:00 PM | The time of day for the race is always noon. |
| **Starting Health** | Invincible | Players don’t take damage. |
| **Maximum Health** | 1 | Players have only 1 health. |
| **Max Shields** | No Shields | Players have no shields. |
| **Infinite Resources** | Off | Players do not have infinite resources. |
| **Maximum Building Resources** | 0 | Players do not collect building resources. |
| **Allow Building** | None | Players can’t build. |
| **Environment Damage** | Off | Environment objects don’t take damage. |
| **Structure Damage** | None | Structures don’t take damage. |
| **Weapon Destruction** | None | Weapons don’t do damage to objects or structures. |
| **Pickaxe Destruction** | None | Pickaxes don’t do damage to objects or structures. |
| **PVP Pickaxe Damage** | Off | Players can’t damage each other with pickaxes. |
| **Start With Pickaxe** | No | Players don’t start with a pickaxe. |
| **Eliminated Player’s Items** | Delete | Player’s items are deleted when they are eliminated. |
| **Allow Item Drop** | No | Items don’t drop. |
| **Allow Item Pick Up** | No | Items can’t be picked up. |
| **Respawn Time** | 1 second | Player respawn time is 1 second. |
| **Jump Fatigue** | Off | Players don’t become fatigued from jumping. |
| **Allow Mantling** | Off | Players can’t mantle. |

### My Island - UI Options

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **HUD Info Type** | Score | Displays Score information on player’s HUD. |
| **Round Win Condition** | Time | The winning player is determined by the fastest time to complete the race. |
| **Tiebreaker 1** | Lap Time | In case of a tie, the player with the fastest lap time wins. |
| **First Scoreboard Column** | Race Time | The first scoreboard column shows the race time. |
| **Second Scoreboard Column** | Score | The second scoreboard column shows the player score. |
| **Show Individual Scores** | Yes | Individual player scores are shown. |
| **Victory Sound** | Magic | The Magic sound plays for the race winner. |
| **Custom Victory Callout** | Winner! | The text shown to the race winner. |
| **Custom Defeat Callout** | Better Luck Next Time | The text shown to the players who didn’t win the race. |
