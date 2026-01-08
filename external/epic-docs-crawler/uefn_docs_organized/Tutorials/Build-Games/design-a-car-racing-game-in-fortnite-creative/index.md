# Car Racing Game

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/design-a-car-racing-game-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:59:05.905376

---

This [tutorial](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) shows you how to set up a car race that uses checkpoints and a scoring system to determine the winner. It also features some [designer tips](https://dev.epicgames.com/documentation/en-us/fortnite/design-a-car-racing-game-in-fortnite-creative) that can improve the overall [gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

The sample island code for this tutorial is **0740-7456-4290**. Head to the **Fortnite lobby** to take a look!

Note the different features of the island, then come back and explore this tutorial to see how you can recreate it on your own island.

## Devices Used

These devices were used for this island tutorial:

- 4 x [Player Spawners](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 4 x [Pickup Truck Spawners](https://dev.epicgames.com/documentation/en-us/fortnite/using-pickup-truck-spawner-devices-in-fortnite-creative)
- 15 x [Race Checkpoints](https://dev.epicgames.com/documentation/en-us/fortnite/using-race-checkpoint-devices-in-fortnite-creative)
- 1 x [Score Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative)
- ~ x [Barriers](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative)
- 1 x [Timed Objective](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)
- 4 x [Triggers](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)
- 1 x [Race Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-race-manager-devices-in-fortnite-creative)
- 1 x [End Game Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative)

## Overview of Tutorial Steps

Here's a quick overview of the steps you'll need to recreate this island, in ideal sequence:

1. Create a new island using a [starter island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
2. Add Player Spawners.
3. Add vehicles.
4. Add and set up the Race [Checkpoints](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
5. Add and set up the scoring system using the Score Manager.
6. Add barriers at the starting line.
7. Add and set up the Timed Objective devices and triggers to monitor player progress and movement.
8. Add the Race Manager device.
9. Add more barriers to set up boundaries.
10. Adjust the My Island Settings to configure the [pre-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) [lobby](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

## Create Your Island

Choose Arid Island as your starter island.

If you're placing multiple identical devices, best practice is to place the first device, customize it as needed, then copy and place the additional devices. Even if each device needs further customization, such as setting up a different team number for each, this can still save you time.

## Add Player Spawners

1. Access your island, then add a **Player Spawner** device. Where you place this spawn pad isn't important because at game start, the player will be teleported from the pre-game lobby (covered later in this tutorial) to this spawner, then immediately teleported again to the driver's seat of their vehicle.
2. Once you [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) your first spawner, you can customize its options as shown below.

   [![customize spawn pad options](https://dev.epicgames.com/community/api/documentation/image/89d2dc7d-376c-43bf-ba80-ab3bd6851dc2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/89d2dc7d-376c-43bf-ba80-ab3bd6851dc2?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Team** | Pick a number | You will need to assign a team number for each spawner. Each team has only one player, so each spawner needs a unique number. Any player that spawns on this spawner automatically belongs to the team that you set for this spawner. Since this is a four-player game, you will need four spawners, with each one having its own team number between 1 and 4. |
   | **Use as Island Start** | No | You will be using a different spawner for your pre-game lobby. |
   | **Visible during games** | No | You don't need the spawner visible during gameplay. |
   | **When Player Spawned Transmit On** | Channel 1 | Assign a [channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to this spawn pad. When the player spawns, the channel you select will be [triggered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). This channel is used later to assign the player as a driver to a vehicle. It's very important to match your team and channel numbers, so Team 1 will transmit on Channel 1, Team 2 on Channel 2, and so on. |

3. Click **OK** to save your options.

   Always click **OK** after changing device options settings or they will not save.
4. Copy the spawner, then place three copies for a total of four player spawners.
5. Customize each new spawner with a different team and channel number.

You should now have four spawners. Each pad should have a unique team number, and **When Player Spawned Transmit On** should be set to a unique channel number.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them — in this case, based on the team.

## Add Vehicles

While in [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), open the [Quick Menu](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) (on a PC, do this by pressing the **B** key). Locate the **Building as Prop** option, and set it to **Off**. This will cause devices to snap to the grid when you're placing them, and it helps to quickly and accurately position devices.

1. Press the **M** key, then click **Content** to open the **Creative** inventory. Click the **Devices** category and locate the **Pickup Truck Spawner** device.
2. Place the Pickup Truck Spawner in the location you want for the race starting position.
3. Open the **Customize** panel for the vehicle spawner you just placed.
4. Modify the following options.

   [![Customize vehicle spawner options.](https://dev.epicgames.com/community/api/documentation/image/f6120824-e734-46cb-8636-f10cc772a085?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f6120824-e734-46cb-8636-f10cc772a085?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Activating Team** | Team 1 | Each vehicle will need to match a team that corresponds with the teams you set up on the player spawners. |
   | **Visible During Game** | Off | This refers to the base the vehicle spawns on, not the vehicle. To hide the base during gameplay, set to Off. |
   | **Boost Regen** | 6.0 | As the creator of the island, it's up to you to determine how much [boost](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) your vehicle has, but for this tutorial, set it to Slow. |
   | **Color and Style** | Random | You can set this to random, or to any of the different options available. |

5. Copy the vehicle three times, incrementing the **team number** and **Assigns Driver When Receiving From** channel number for each. Also increment the **When Player Exits Vehicle Transmit On** channel for each vehicle.

### Force a Player into the Driver's Seat

Now that the spawners for players and vehicles are set up, it's time to make sure your channel settings are correct. The easiest way to do this is to have the spawn pad transmit a channel number when a player spawns on it at the same time a vehicle has **Assigns Driver When Receiving From**, and on the same channel that was entered on the spawn pad.

You can see the spawn pad and corresponding vehicle spawner, along with their options. Each vehicle and spawn pad should have a matching channel assigned to **When Player Spawned Transmit On** and **Assigns Driver When Receiving From**.

[![matching channels for spawn pad and vehicle](https://dev.epicgames.com/community/api/documentation/image/ba8a3ea9-938d-4901-b6ed-dbfe73d7b66f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba8a3ea9-938d-4901-b6ed-dbfe73d7b66f?resizing_type=fit)

Check each player and vehicle spawn pad to ensure there's a vehicle for each team and their channel numbers match.

If you ever need to check which channels have been set up and for which devices, press the **Tab** key, then select **My Island** from the top navigation bar.

[![Channel browser button](https://dev.epicgames.com/community/api/documentation/image/4365716c-d3f7-4439-9b6a-a74f7df58b23?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4365716c-d3f7-4439-9b6a-a74f7df58b23?resizing_type=fit)

The **Channel Usage** screen will show which channels are transmitting or receiving, along with the associated devices. You can also use this screen to debug channel behavior.

[![Channel usage screen](https://dev.epicgames.com/community/api/documentation/image/68d12120-de0f-429d-a23a-7f15837a41a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/68d12120-de0f-429d-a23a-7f15837a41a2?resizing_type=fit)

### Exit the Vehicle

Next, you'll need a [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) device. You'll set this trigger to reassign the player as the driver of their vehicle 5 seconds after they exit the vehicle. You can change the amount of time the player can exit the vehicle, or even force them to never leave the vehicle.

With devices like triggers, or any other devices where players cannot interact with the device directly, it doesn't matter where you place them. Experienced Island Creators like to group them together in an out-of-the-way corner for convenience, ease of access, and easy tracking of the devices they've added.

1. This tutorial game is designed for the player to be able to leave the vehicle for 5 seconds, so the triggers will have the following settings.

   [![trigger options](https://dev.epicgames.com/community/api/documentation/image/d4f1b409-44ae-4cd2-9a2d-94e4386b4836?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d4f1b409-44ae-4cd2-9a2d-94e4386b4836?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Delay** | 5 Seconds | After 5 seconds, player will be returned to their vehicle. |
   | **Visible in Game** | No | The trigger will not be visible in-game. |
   | **Trigger When Receiving From** | Channel 13 | This matches the channel set for the Team 1 vehicle. You will need to increment it (14, 15, 16) for each additional trigger. |
   | **When Triggered Transmit On** | Channel 1 | You will need to increment this setting for each additional trigger to match the team and vehicle numbers. |

   The vehicle spawner for Team 1 will transmit on Channel 13 as soon as a player exits the vehicle. This trigger will activate when it receives a signal on Channel 13, will count for 5 seconds, then will transmit on Channel 1. If you look at your Team 1 vehicle spawner, when it receives a signal on Channel 1, the player is automatically assigned as the driver.
2. Copy and place the trigger three more times. For each copy, modify the **When Triggered Transmit on** and **Trigger When Receiving From** to match the team number for each team.

## Set Up Checkpoints

From the Devices tab, add a **Race Checkpoint** device and place it where you want the race to start.

When you place this checkpoint, it is automatically labeled as checkpoint **Number 1**. When you add more checkpoints, you will need to increment the checkpoint numbers by 1 for each additional checkpoint.

It's important to customize **When Checkpoint Completed Transmit On**. This will send a [signal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) on the channel you select (for this tutorial, Channel 8) whenever a vehicle passes through the checkpoint. The checkpoint will then automatically turn off for that vehicle, and the next checkpoint in the sequence will turn on, as determined by the **Checkpoint Number**. All checkpoints must be on the same channel.

Use these values for the first checkpoint:

[![checkpoint options](https://dev.epicgames.com/community/api/documentation/image/9345f2ef-a05c-4755-beda-e931d41359ed?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9345f2ef-a05c-4755-beda-e931d41359ed?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Checkpoint Number** | Checkpoint 1 | This number will automatically show for first checkpoint. For each checkpoint you add, increase the number by 1. |
| **Allow Players to Pass without Vehicle** | No | This prevents a player from abandoning a vehicle and finishing the race on foot. |
| **Visible Prior To Race Start** | No | Not making the checkpoints visible prior to race start is used by lots of designers, but you can set this to a different value if you want. |
| **Enabled During Phase** | Gameplay Only | Players must wait until the race starts to pass a checkpoint. |
| **When Checkpoint Completed Transmit On** | Channel 8 | This signal goes to the Score Manager, so only one channel is needed. |

## Add a Scoring System

After you set up each checkpoint to send a signal when a vehicle passes through, set up a **Score Manager** device to count the points. Place the device and set the following options:

[![scoring options](https://dev.epicgames.com/community/api/documentation/image/0cb73d8c-37ea-453f-a231-1bced650139b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0cb73d8c-37ea-453f-a231-1bced650139b?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Score Value** | 1 | Each checkpoint awards 1 score. |
| **Increment Score on Awarding** | Off | You don't need the Score Manager to update the amount of score incrementally. |
| **Activate When Receiving From** | Channel 8 | This must be the same channel the checkpoints transmit on. |

When the Score Manager receives a signal on Channel 8, it will add a **Score Value** for the player passing through the checkpoint.

Since there are 15 checkpoints on the island and each checkpoint awards 1 point, a score of 15 will win the race.

## Add a Win Condition

Now you can set the win condition with a score of 15 winning the round.

1. Press the **M** key to open the **Island Settings**, then click **Game**.

You will need to scroll down the Game tab to find all of the options.

1. Set the following options to the following values:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **All Teams Must Finish** | No | This is the default value, but make sure it's set to No. Since the win condition is based on score, it can be met without all players completing the race. |
   | **Win Condition** | Most Round Wins | Since the race is based on score, and since only the winning team needs to finish a round to collect the winning score, the game ends as soon as a player finishes the round. Since the win condition is based on points, there is only one round. |
   | **Score to End** | 15 | This causes the round to end as soon as a player gets a score of 15 — in this case, when the player passes through 15 checkpoints. |

   [![My Island game options](https://dev.epicgames.com/community/api/documentation/image/08c55411-0b80-4ccb-adb3-2e4f0b0bd8ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/08c55411-0b80-4ccb-adb3-2e4f0b0bd8ea?resizing_type=fit)
2. Next, select the **Settings** tab.
3. Scroll down to **Environment Damage**, and set to Off. This keeps players from using their pickaxes or vehicle to destroy anything during gameplay.

## Cover Vehicles with Barriers

Placing **Barrier** devices over the vehicles prevents players from starting the race before the devices are deactivated.

1. Go to the [Creative inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and in the [Devices category](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), find and equip the **Barrier device**.
2. Place the Barrier device so it completely encloses the first truck.

   [![barriers around cars at the starting line](https://dev.epicgames.com/community/api/documentation/image/fb5aa4e7-c5e3-469c-8614-d68633798613?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fb5aa4e7-c5e3-469c-8614-d68633798613?resizing_type=fit)
3. Use the following values to customize the first barrier before copying and placing over each of the remaining trucks:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Enabled During Phase** | All | This prevents the vehicle from driving out before the race starts. |
   | **Zone Shape** | Box (Hollow) | If the box were not hollow, it would force the vehicle out of the box instead of acting as a cage to hold the vehicle in place until start of race. |
   | **Disable When Receiving From** | Channel 7 | When this channel is triggered, it will turn off the Barrier devices. |

   [![barrier device options](https://dev.epicgames.com/community/api/documentation/image/5a210796-172d-4539-8695-7295251205c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a210796-172d-4539-8695-7295251205c4?resizing_type=fit)

## Set Up the Timed Objective

To start the race, you will set up a **Timed Objective** device. This will give a countdown to the start, then display a HUD message announcing the start of the race.

1. Find and place the Timed Objective device.
2. Customize as follows:

   [![race start options](https://dev.epicgames.com/community/api/documentation/image/961c5426-4900-48c3-af48-d04759502f9b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/961c5426-4900-48c3-af48-d04759502f9b?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Start When Round Starts** | Yes | The timer will begin the countdown as soon as the round starts. |
   | **Time** | 10 Seconds | You can set this to any number, and after that number is reached, the timer will send a signal to disable the barriers. |
   | **Timer Label Text** | Race Start | This is the text that displays on the HUD while the timer is counting down. Use Any text you want, up to 80 characters. |
   | **Visible During Game** | No | The Timed Objective device will not be visible during gameplay. |
   | **When Completed Transmit On** | Channel 7 | When the timer reaches 0, it transmits on Channel 7. This is the same channel that you set to receive a signal for the barriers over the vehicles. This signal turns off the Barrier devices. |

   [![timed objective race start example](https://dev.epicgames.com/community/api/documentation/image/d0ad09f7-360a-48a1-b41b-023d32d98b12?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0ad09f7-360a-48a1-b41b-023d32d98b12?resizing_type=fit)

   *How the text and timer should look on the screen.*

In-game, once the Barrier devices are disabled, the player can take off down the track and the race is on!

## Add the Race Manager Device

You'll use the Race Manager to set how many laps it takes to finish a race, and set the channel for the Timed Objective device. By default, this device will also add waypoints and show arrows that point to the next checkpoint unless disabled.

[![Race manager options](https://dev.epicgames.com/community/api/documentation/image/53e05e28-e6c0-4ecd-8be1-432e4ecf7a08?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/53e05e28-e6c0-4ecd-8be1-432e4ecf7a08?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Number of Laps** | 1 | One lap is the default. If you change this to more than one, you will need to modify the score on **My Island > Game > Score To End** to match the score now possible. For example, if you want the race to go for 2 rounds, this would require 30 score to win. |
| **Start Race on Game Start** | No | The race will start when a signal is received. |
| **Start Race When Receiving From Channel** | Channel 7 | This signal will come from the Timed Objective device. |

## Define Boundries with Barriers

You can add barriers to prevent players from driving off the island. It's a good idea to place barriers in any spot where a player might do this, as shown in the example below, and you can also place them in strategic spots to keep the vehicles from leaving the racetrack.

[![barrier placement example](https://dev.epicgames.com/community/api/documentation/image/a6430fa5-ed5f-4bcf-b704-eec675e61fd1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a6430fa5-ed5f-4bcf-b704-eec675e61fd1?resizing_type=fit)

1. Once you place your first Barrier device, set the following options:

   [![customized barrier options](https://dev.epicgames.com/community/api/documentation/image/2fffc9a1-78c4-4b49-89dc-9fa00ace7e0d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2fffc9a1-78c4-4b49-89dc-9fa00ace7e0d?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Style** | Invisible | This protects the players without making it obvious. |
   | **Enabled During Phase** | All | This makes sure the barriers are always there, even in the pre-game lobby. |
   | **Zone Shape** | Box | Either shape will work for setting up boundaries. |
   | **Barrier Width** | Pick a number | You will want to adjust the size of the barriers to fit your terrain. It's good to start with 5 as a width, and resize from there. |
   | **Barrier Depth** | .05 | A thinner barrier will fit more easily, and the depth (thickness) does not affect the effectiveness of the barrier. |
   | **Barrier Height** | 1 | Again, start with a height that will be manageable when placing. You can always increase the height if it isn't high enough. |

2. Copy and place barriers along the edge of the island, and along the racetrack. Adjust the barrier dimensions to fit your terrain as needed.

## Add a Pre-Game Lobby

Adding a **pre-game lobby** gives players a place to wait until the race starts.

This is where the players will enter your island, so you will need four spawn pads to accommodate up to four players.

1. Pick an area on the island that is not going to be used for gameplay, or make a separate room where you can set up your pre-game lobby.
2. Place a player spawner, then customize with the following options:

   [![customized player spawner options](https://dev.epicgames.com/community/api/documentation/image/cabe746d-ab5b-4df1-a38b-93d4f634b65b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cabe746d-ab5b-4df1-a38b-93d4f634b65b?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Enabled During Phase** | All | This should be the default value. If it isn't, then set to All to ensure that the spawn pads are enabled for pre-game. |
   | **Priority Group** | Secondary | Keeps players from being blocked from spawning if there are still open pads. |
   | **Use As Island Start** | Yes | Also a default value, this allows players to spawn onto the island before the game starts. |

3. Copy and place three more spawners. No additional customization is needed.

You can add some fun things for players to do while waiting in the lobby, such as providing [Driftboards](https://dev.epicgames.com/documentation/en-us/fortnite/using-driftboard-spawner-devices-in-fortnite-creative) or [Baller vehicles](https://dev.epicgames.com/documentation/en-us/fortnite/using-baller-spawner-devices-in-fortnite-creative)that are available only during pre-game. You can set this by customizing the **Enabled During Phase** option to **PreGame Only** for that vehicle spawner device.

[![enabled during phase option changes](https://dev.epicgames.com/community/api/documentation/image/d91d84ca-8fb6-4c84-9e88-dfdbb72e0400?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d91d84ca-8fb6-4c84-9e88-dfdbb72e0400?resizing_type=fit)

[![pre-game lobby example](https://dev.epicgames.com/community/api/documentation/image/c3d83cf0-2b41-4e9f-a547-ca8362325b1b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c3d83cf0-2b41-4e9f-a547-ca8362325b1b?resizing_type=fit)

*What the pre-game lobby for this island looks like.*

Depending on how you set up your island, you might also want to add barriers around the lobby area to prevent vehicles from getting into the pre-game lobby. In the Barrier device options, set **Enabled During Phase** to **Gameplay Only**.

[![lobby barrier custom options](https://dev.epicgames.com/community/api/documentation/image/e9ff4efd-801c-4100-bf68-f5fe3fd5aa7a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9ff4efd-801c-4100-bf68-f5fe3fd5aa7a?resizing_type=fit)

### Modify More My Island Settings

The final step for setting up your pre-game lobby is to return to **Island Settings > Game** and do some final changes.

You will need to scroll down this tab to find all of the options.

| Option | Value | Explanation |
| --- | --- | --- |
| **Spawn Location** | Spawn Pads | This sends the players directly to their spawn pads in the pre-game lobby instead of having them fall from the sky. |
| **Post-Game Spawn Location** | Island Start | This sends the players back to the lobby at end of game. |
| **Autostart** | 60 Seconds | After 60 seconds, the race will automatically start again. Note that this only works for published islands. |
| **Game Start Countdown** | 10 Seconds | This controls how long the pre-game lobby stays open before the game begins. |
| **Vehicle Trick Score Multiplier** | 0.0 | Set this to 0.0 as this feature isn't used in this tutorial. |

## Designer Tips

Here are some tips that can improve how your island plays.

### Modifying Vehicles

There are lots of customization options available for the vehicles, and here are some that can influence gameplay.

| Option | Explanation |
| --- | --- |
| **Boost Regen** | One of the easiest ways to modify a vehicle is to adjust the Boost Regen, which controls how quickly a [boost](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) meter fills, or [regenerates](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Options Include No boost, Slow, Default, Fast, and Unlimited. Changing this parameter has the biggest effect on vehicle performance. |
| **Tire Selection** | There are road tires and off-road tires. The tires you select will influence how the vehicle handles. |

### Adding Traps (Boosters)

Another good way to spice up your island is to use [trap](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) devices such as the Speed Boost or [Bouncer](https://dev.epicgames.com/documentation/en-us/fortnite/using-bouncer-gallery-devices-in-fortnite-creative). Putting these traps in key locations can make your races even more challenging.

Check out this video to see some samples of how a vehicle could be affected by a trap device.

### Invisible Barriers

There may be cases where you want to block off certain parts of the island with invisible barriers like out-of-bounds areas, or to make small walls impregnable. The barrier device is perfect for these scenarios.

## Video Tutorial
