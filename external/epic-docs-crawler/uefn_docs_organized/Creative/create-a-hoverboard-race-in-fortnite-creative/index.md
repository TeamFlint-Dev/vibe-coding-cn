# Hoverboard Race

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-a-hoverboard-race-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:58:34.947025

---

This tutorial is based on an island you can load in Creative, called Hoverboard Racing Island. The [island code](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#island-code) for this tutorial island is [1544-4420-3963](https://www.epicgames.com/fortnite/en-US/creative/island-codes/hover-race-island-1544-4420-3963).

This is an advanced tutorial, and it assumes you have basic knowledge of creating islands in Fortnite Creative. It is a more advanced version of the [Car Racing Tutorial](https://dev.epicgames.com/documentation/en-us/fortnite/design-a-car-racing-game-in-fortnite-creative).

## Island Description

The Hoverboard Racing Island is a race for up to eight players that are all riding hoverboards. The players cannot get off the hoverboards, and must complete 20 checkpoints (4 laps) to win the race. The track is enclosed. Players can leave the track, but to prevent players from accidentally driving off the edge of the island, [damage volumes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#damage-volume) placed around the edge of the island will eliminate them.

While racing on the track, the players are able to collect random [power-ups](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#power-up) that can be used to help the player win the race. There are also Speed Boost tiles that increase the player's speed and Bouncer tiles that propel the player high into the air.

## Devices Used

These devices were used for this gameplay example:

- [Player Spawner Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- [Barrier Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative)
- [Score Manager Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative)
- [Timed Objective Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)
- [Trigger Device](https://dev.epicgames.com/documentation/en-us/fortnite/trigger-device-design-examples)
- [Race Manager Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-race-manager-devices-in-fortnite-creative)
- [Driftboard Spawner Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-driftboard-spawner-devices-in-fortnite-creative)
- [Race Checkpoint Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-race-checkpoint-devices-in-fortnite-creative)
- [Tracker Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative)
- [Item Granter Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)
- [HUD Message Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)
- [Visual Effect Powerup Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-visual-effect-powerup-devices-in-fortnite-creative)
- Speed Boost
- [Bouncer Gallery Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-bouncer-gallery-devices-in-fortnite-creative)
- [Damage Volume Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative)
- [VFX Spawner Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative)

## Overview of Tutorial Steps

Here is an overview of the steps you'll need to take to recreate the Hoverboard Racing Island:

1. Create a new island using a [starter island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#starter-island).
2. Build the racetrack (not demonstrated in this tutorial).
3. Create the island boundaries.
4. Build the starting grid for the race (this includes Player Spawners).
5. Add and set up the race [checkpoints](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#checkpoint).
6. Add and set up the [Score Manager](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#score-manager) device.
7. Add and set up the [Race Manager](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#race-manager) device.
8. Add and set up the power-ups and special tiles.
9. Change My Island settings to set up the game.
10. Build the Pre-Game Lobby for the game.

There is a section with [Designer Tips](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-hoverboard-race-in-fortnite-creative#designer-tips) at the end of this tutorial that gives you advice, more ideas for building your game, and even other islands you can make based on this one.

## Create Your Island

In this tutorial, you won't learn how to build the layout of the racetrack. Instead, you will learn which specific devices and settings you need to add to recreate the Hoverboard Racing Tutorial Island. If you completed the [Car Racing Tutorial](design-a-car-racing-game-in-fortnite-creative), you can build your racetrack using the same materials and methods you used in building that Island.

If you haven't completed the Car Racing Tutorial, you can look for **Galleries** in the **Creative Inventory** that have elements you can use, such as ones with the **Racetrack** or **Parkour** Category tags. You can also use the **Street Galleries**, the **Pressure Plant Gallery**, or some of the **Shape Galleries** (like the **Primitive Shape Gallery**, **Cube Gallery**, and so on). Use these to build your track layout.

Like the Car Racing Island, this island is built with a racetrack. However, regular vehicles (such as the ones used in the Car Racing Island) are not able to use power-ups. The only vehicle that allows a player to use a power-up while driving on land is the Hoverboard (also known as the **Driftboard Spawner** device), so that's the vehicle used for this race. You can also use powerups with the Surfboard vehicle; see the **Designer Tips** section for ideas on creating a Surfboard Race that takes place on water.

## Create the Island Boundaries

The island you are creating is for a race. You don't want players to drive off the edge of the island by accident. Because the race is outdoors on the island, you need to create a boundary around the race area to prevent players from accidentally falling off the island. You can use **Barrier** and **Damage Volume** devices to create this boundary.

### Place the Barriers

[![An Image of the Barrier Device](https://dev.epicgames.com/community/api/documentation/image/c81950a5-3008-4d37-a46f-9d5989095650?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c81950a5-3008-4d37-a46f-9d5989095650?resizing_type=fit)

Follow these steps to place the Barrier devices and customize their options.

When you are positioning the boundary [Barrier](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) devices, you may want to keep the style as Translucent, and set a smaller size. If the Barrier is translucent, you can see what objects and props are being cut off by the Barrier and remove them. The smaller size makes moving the Barrier easier. Once you have it placed properly, you can open the Customize panel again to increase the size and change the style.

1. Place Barrier devices around the play area, completely enclosing it on all four sides. Create an invisible ceiling for the play area by placing a Barrier above the play area.
2. Once the Barrier devices are placed, modify the following options on the devices. To save time, you can customize the options on the first device, then copy and paste that customized device for the other Barrier devices you need.

   [![Barrier Device Options](https://dev.epicgames.com/community/api/documentation/image/5276bb21-b7e3-43f6-bd84-17fc1b53a571?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5276bb21-b7e3-43f6-bd84-17fc1b53a571?resizing_type=fit)

   *Click image for full size.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Style** | Nebula | This sets the visual style of the Barrier devices to look like a nebula in space that surrounds the island. |
   | **Enabled During Phase** | All | The Barriers need to be active throughout the game, because the purpose of the Barriers is to keep players from accidentally driving off the edge of the island. |
   | **Block Weapon Fire** | No | Blocking weapon fire is not part of the purpose for the Barriers, so set it to No. |
   | **Zone Shape** | Box | This creates a cube-shaped Barrier that is completely solid. |
   | **Barrier Width** | 80 | Each device you place uses memory, so by making each Barrier device as wide as possible, you can surround the island with the smallest number of devices. |
   | **Barrier Height** | 50 | Each device you place uses memory, so by making each Barrier device as tall as possible, you can surround the island with the smallest number of devices. |

   You can change the Barrier Style option to have a wide variety of visual effects. In this tutorial, it has been set to Nebula, which makes it look like the island is floating in space. You can experiment with this option and see which visual effect appeals to you the most.
3. Once you have customized the device options and placed the Barriers, the result should look something like the image below.

   [![Boundary Placement for Hoverboard Race](https://dev.epicgames.com/community/api/documentation/image/a53feec9-72ee-4fb6-baaa-1d7975b4e5db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a53feec9-72ee-4fb6-baaa-1d7975b4e5db?resizing_type=fit)

### Place the Damage Volumes

[![Image of Damage Volume](https://dev.epicgames.com/community/api/documentation/image/40a8c618-bd34-49ef-9759-257a1904e84a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40a8c618-bd34-49ef-9759-257a1904e84a?resizing_type=fit)

If a player crashes into the nebula Barrier or bounces off, the players will know the island isn't actually floating in space. That would ruin the fun! To prevent this, you can place Damage Volumes which will eliminate the players before they crash into the Barrier. Follow these steps to place and set up the Damage Volumes.

1. Place the Damage Volumes a distance of one square in front of the Barrier. You will set this to damage players enough to eliminate them as soon as they hit the Barrier.
2. The options you need to change on the Damage Volume plates are shown below.

   [![Damage Volume Options](https://dev.epicgames.com/community/api/documentation/image/d50f3e13-ee1f-4619-a7d3-ef597ed131ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d50f3e13-ee1f-4619-a7d3-ef597ed131ea?resizing_type=fit)

   *Click image for full size.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Damage Type** | Elimination | This setting will eliminate the player as soon as they touch the Damage Volume. We want to make sure the player respawns after being eliminated, and those settings are explained later. |
   | **Zone Visible During Game** | No | This makes the Damage Volumes invisible so players don't know they are there. |
   | **Base Visible During Game** | No | This makes the device base invisible also. |

## Build the Starting Grid for Player Spawning

[![Image of Starting Grid](https://dev.epicgames.com/community/api/documentation/image/9976f6d9-d6ee-49b0-9397-6e0328b7d0b4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9976f6d9-d6ee-49b0-9397-6e0328b7d0b4?resizing_type=fit)

### Build the Starting Grid Boxes

You will need to create a starting place where the players and hoverboards will spawn. The race is for 8 players, so use wall and floor pieces to build a line of 4 boxes, with another 4 boxes stacked on top to create a grid of 8 boxes. Each individual box should be large enough to hold a Player Spawn device and a Driftboard Spawner device.

### Add Barrier Devices to Front and Back of Starting Grid

Now you can add Barriers for the front and back. The front Barrier will be transparent, the back Barrier will be black so the players can't see through it.

#### Place the Front Barrier

[![Image of Starting Grid Front Barrier](https://dev.epicgames.com/community/api/documentation/image/efe6509b-ceae-4f70-a302-b80c786aa149?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/efe6509b-ceae-4f70-a302-b80c786aa149?resizing_type=fit)

For the front Barrier, modify the following options. Instead of the plain Transparent style, you can choose a red or blue forcefield to make it look interesting (the example uses the Blue Forcefield style). When you have finished customizing the options, click **OK** to save your changes.

[![Starting Grid Front Barrier Options](https://dev.epicgames.com/community/api/documentation/image/2f92cad9-9bf7-4017-b957-75e958bc8d33?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f92cad9-9bf7-4017-b957-75e958bc8d33?resizing_type=fit)

*Click image for full size.*

You may want to temporarily move the front Barrier out of the way while placing the Player Spawn Pads and Driftboard Spawners. Once you have those placed, you can reposition the front Barrier.

| Option | Value | Explanation |
| --- | --- | --- |
| **Barrier Style** | Blue Forcefield | The Barrier is translucent (see-through) and looks like a blue forcefield. |
| **Enabled During Phase** | All | The Barrier will be enabled during all [game phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase). |
| **Zone Shape** | Box (Hollow) | Instead of the Barrier being solid, this creates a hollow box. This way the players can spawn inside of it. |
| **Barrier Width** | 4 | The Barrier is 4 tiles wide, to match the width of the starting grid. |
| **Barrier Depth** | 1 | The Barrier is 1 tile deep, so the Barrier zone covers all the boxes and has room for the Player Spawn Pad, the Driftboard Spawner, and the player. |
| **Barrier Height** | 2 | The Barrier is 2 tiles high, to match the height of the starting grid. |
| **Disable When Receiving From** | Channel 150 | When the Barrier receives a signal on Channel 150 from the starting Timed Objective (see below), the Barrier is disabled and the players can move onto the track. |

#### Place the Rear Barrier

[![Image of Starting Grid Rear Barrier](https://dev.epicgames.com/community/api/documentation/image/16de1cb0-332c-40ca-aa6f-8e29ba003029?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/16de1cb0-332c-40ca-aa6f-8e29ba003029?resizing_type=fit)

For the rear Barrier, modify the following options. Instead of the style used on the front Barrier, select the Gloss Black style. This will make the back solid and keep the players from seeing what is behind the Starting Grid. When you have finished customizing the options, click **OK** to save your changes.

[![Starting Grid Rear Barrier Options](https://dev.epicgames.com/community/api/documentation/image/ae71d88a-8bad-4961-b4c2-85eab7111376?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ae71d88a-8bad-4961-b4c2-85eab7111376?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Barrier Style** | Gloss Black | This style is a solid black color, so the players can't see through it. |
| **Enabled During Phase** | All | The Barrier will be enabled during all Game Phases. |
| **Zone Shape** | Box (Hollow) | Instead of the Barrier being solid, this creates a hollow box. This way the players can spawn inside of it. |
| **Barrier Width** | 4 | The Barrier is 4 tiles wide, to match the width of the starting grid. |
| **Barrier Depth** | .05 | The rear Barrier doesn't need to be as deep, because its main purpose is to block the players' view of what is behind the starting grid. This small depth allows you to place it at the back of the boxes without overlapping the front Barrier. |
| **Barrier Height** | 2 | The Barrier is 2 tiles high, to match the height of the starting grid. |

### Add Player Spawners to Starting Grid Boxes

[![Image of Player Spawn Pads](https://dev.epicgames.com/community/api/documentation/image/aa5fe669-3ba5-4dd9-bb88-3d1f48713098?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aa5fe669-3ba5-4dd9-bb88-3d1f48713098?resizing_type=fit)

Next, add a Player Spawn Pad to each box in the Starting Grid (8 total). Customize the Player Spawn devices by modifying the options shown below. When you have finished customizing the options, click **OK** to save your changes.

[![Player Spawn Pad Options](https://dev.epicgames.com/community/api/documentation/image/4c10154a-5290-485f-a509-b020118f62f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c10154a-5290-485f-a509-b020118f62f7?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Team** | Teams 1-8 | Assign a Team to each Player Spawn Pad (Team 1, Team 2, and so on to Team 8). |
| **Priority Group** | Primary | This determines the priority of the Spawn Pads, and in what order they will be used. This is the only group of Spawn Pads used during the game, so they are the Primary group. |
| **Use As Island Start** | No | This tutorial includes instructions for building a pre-game lobby, which is where players will spawn into the Island. |
| **Visible During Games** | No | This device must be invisible during the game. |
| **When Player Spawned Transmit On** | Pick a channel | Choose a channel the Player Spawn Pad will transmit on when a player spawns. To make it simple, choose a channel that is the same as the Player Spawn Pad's Team number (Channel 1 for Team 1, and so on). |

### Add the Triggers

[![Image of Trigger Device](https://dev.epicgames.com/community/api/documentation/image/01fe1c27-a981-486d-b46b-05fb10147318?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/01fe1c27-a981-486d-b46b-05fb10147318?resizing_type=fit)

Place 8 Trigger devices behind the Starting Grid. These will be invisible to the players and can be placed anywhere, but placing them behind the Starting Grid is convenient. Customize the Triggers by modifying the options shown below. When you have finished customizing the options, click **OK** to save your changes.

[![Trigger Options](https://dev.epicgames.com/community/api/documentation/image/09da509c-fb79-4f39-a027-45c840011af7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/09da509c-fb79-4f39-a027-45c840011af7?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Delay** | 1 second | This is the amount of time between the Trigger receiving a signal, and transmitting a signal. |
| **Visible During Game** | No | The device must be invisible during the game. |
| **Trigger When Receiving From** | Pick a channel | Each Trigger is associated with a Player Spawn Pad, so Trigger 1 is for Player Spawn Pad 1, Trigger 2 is for Player Spawn Pad 2, and so on. For this option, select the channel that the paired Player Spawn Pad transmits on when a player spawns. |
| **When Triggered Transmit On** | Pick a channel | Each Trigger is associated with a Player Spawn Pad, so Trigger 1 is for Player Spawn Pad 1, Trigger 2 is for Player Spawn Pad 2, and so on. For this option, select the next channel after the channel selected in the **Trigger When Receiving From** option. So for Trigger 1, it receives on channel 1 and transmits on channel 2. |

### Add Driftboard Spawners to Starting Grid Boxes

[![Image of Driftboard Spawner](https://dev.epicgames.com/community/api/documentation/image/d4b47e4a-6f87-4792-be75-5ca383e6fd52?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d4b47e4a-6f87-4792-be75-5ca383e6fd52?resizing_type=fit)

Add a Driftboard Spawner device to each box in the Starting Grid (8 total). Customize the Driftboard Spawner devices by modifying the options shown below. When you have finished customizing the options, click **OK** to save your changes.

[![Driftboard Spawner Options](https://dev.epicgames.com/community/api/documentation/image/8c627dc5-a113-48c9-9e09-c835c52df32f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c627dc5-a113-48c9-9e09-c835c52df32f?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Enabled During Phase** | None | The Driftboard will be enabled by a signal, so we don't need to use this setting. |
| **Owning Team** | Teams 1-8 | Assign each Driftboard to the Team number assigned to its matching Player Spawn Pad. For example, if the Player Spawn is assigned Team 1, assign the Driftboard in that box to Team 1 also. |
| **Visible In Game** | Off | Each device has a base, but for the Driftboard (and other vehicles) you don't want the players to see it so this makes it invisible. |
| **Vehicle Health** | Indestructible | This setting makes sure that the vehicle does not get destroyed by damage. Instead, the vehicle will be destroyed when the player is eliminated. This is done using a channel signal. |
| **Assign Driver When Receiving From** | Pick a channel | Each Player Spawn and Driftboard will have a corresponding Tracker device and Trigger device. For this option, select the channel this Driftboard's Trigger is transmitting on. So for Driftboard 1, if Trigger 1 is transmitting on Channel 2, you would set this option to Channel 2. |
| **Destroy Vehicle When Receiving From** | Pick a channel | This option works with the Tracker's **When Complete Transmit On** option. The channel selected for this option must match the channel for the **When Complete Transmit On** option. Each Tracker and Driftboard will have a different channel. For example, for Driftboard 1 and Tracker 1, it is channel 17; for Driftboard 2 and Tracker 2, it is channel 18, and so on. This option makes sure that when the player is eliminated, the Driftboard is also destroyed. They will both respawn together at the Starting Grid. |
| **Enable When Receiving From** | Pick a channel | Each Driftboard Spawner is listening for a signal from its own Player Spawner. For example, when Player Spawner 1 sends a signal on Channel 1, Driftboard 1 receives the signal and is enabled. For this option, pick the channel that this Driftboard's matching Player Spawner transmits on. |
| **When Player Exits Vehicle, Transmit On** | Pick a channel | This option goes with the **Assign Driver When Receiving From** option. When a player tries to get off the Driftboard (exits the vehicle), this option transmits on the channel for the **Assign Driver When Receiving From** option. In our example, if Player 1 tries to get off Driftboard 1, the Driftboard sends a signal on Channel 2, and when Driftboard 1 receives a signal on Channel 2 it assigns the player to itself. This loop keeps players on the Driftboard until the game is finished. |

### Add the Tracker Devices

[![Image of Tracker](https://dev.epicgames.com/community/api/documentation/image/e85134f6-ac3c-47cf-9c7b-75631e8bc51d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e85134f6-ac3c-47cf-9c7b-75631e8bc51d?resizing_type=fit)

The Tracker device tracks whether the player is eliminated, so if the player is eliminated by a damage volume, the Tracker completes and sends a signal to the Driftboard Spawner to destroy the player's driftboard. Then the player will respawn with a new driftboard at the starting area.

Place 8 Tracker devices behind the Starting Grid. These will be invisible to the players and can be placed anywhere, but for convenience you can place them right behind the Starting Grid. Customize the Tracker Devices by modifying the options shown below. When you have finished customizing the options, click **OK** to save your changes.

[![Tracker Device Options](https://dev.epicgames.com/community/api/documentation/image/7ac87521-8235-43dc-8198-6fc8df216274?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7ac87521-8235-43dc-8198-6fc8df216274?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Stat to Track** | Eliminations | The trackers are used to track if a player is eliminated. |
| **Target Value** | 1 | This determines the number of eliminations that are required for the Tracker to complete. |
| **Valid Team** | Teams 1-8 | Assign each Tracker the same Team number assigned to its matching Player Spawner. For example, if Player Spawner 1 is assigned Team 1, the Tracker for that Player Spawner is also assigned Team 1. |
| **Assign on Game Start** | No | The device is assigned by a channel signal. |
| **Assign When Joining In Progress** | No | The device is assigned by a channel signal. |
| **Target Team** | Team 1 | This should match the value for the **Valid Team** option. |
| **Show on HUD** | No | The player doesn't need to have this displayed. |
| **Tracker Title** | Eliminated | You can enter any label you want in this field; this is the title used in this example. |
| **Tracker Completion Ceremony** | No | This tracker is working together with other devices, and could complete multiple times. The completion ceremony isn't needed here. |
| **Self-Eliminations Count** | Yes | This is the key setting, as the tracker is being used to determine whether the player was eliminated by the damage volume at the edge of the play area. |
| **Assign When Receiving From** | Pick a channel | This assigns each Tracker to a player. Each Tracker will have a corresponding Player Spawner. For this option, select the channel the matching Player Spawner is transmitting on. For example, if Player Spawner 1 is transmitting on channel 1, you would set this option to channel 1, which then assigns Tracker 1 to Player 1. |
| **Reset Progress When Receiving From** | Pick a channel | This resets the Tracker when its assigned player respawns. For this option, select the channel the matching Player Spawner is transmitting on. |
| **When Complete Transmit On** | Pick a channel | When the Tracker is complete (in other words, when the player assigned this Tracker is eliminated), it transmits a signal on the selected channel. This option works with the Driftboard's **Destroy Vehicle When Receiving From** option. The channel selected for this option must match the channel for the **Destroy Vehicle When Receiving From** option. Each Tracker and Driftboard will have a different channel. For example, Tracker 1 transmits on channel 17 when Player 1 is eliminated by a damage volume; Driftboard 1 receives the signal on Channel 17 and destroys the spawned Driftboard. |

### Add the VFX Spawners

[![Image of VFX Spawner](https://dev.epicgames.com/community/api/documentation/image/ac6812d1-e250-485a-8bb8-25e2bd57d151?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ac6812d1-e250-485a-8bb8-25e2bd57d151?resizing_type=fit)

Place 2 VFX Spawner devices in front of the Starting Grid, one on each side. These devices will shoot fireworks when the race starts. The second Timed Objective will transmit a signal to turn off the fireworks after 10 seconds. Customize the VFX Spawners by modifying the options shown below. When you have finished customizing the options, click OK to save your changes.

[![VFX Spawner Options](https://dev.epicgames.com/community/api/documentation/image/5e3098dd-9166-4f2c-b1b2-3539ecadbb19?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5e3098dd-9166-4f2c-b1b2-3539ecadbb19?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Enabled During Phase** | None | The VFX Spawner will be enabled by a signal, so this is set to **None**. |
| **Enable When Receiving From** | Channel 150 | The signal to disable the Barrier transmits on this channel. When the VFX Spawner receives the signal, the device is enabled. When it is enabled, the device will begin looping the default effect, which is Fireworks. |
| **Disable When Receiving From** | Channel 149 | Timed Objective 2 will send a signal on Channel 149 when it completes its countdown. That will disable the VFX Spawner and end the Fireworks effect. |

### Add the Timed Objectives

[![Image of Timed Objective](https://dev.epicgames.com/community/api/documentation/image/2850100d-2f75-4b5c-99a8-0676a9055e15?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2850100d-2f75-4b5c-99a8-0676a9055e15?resizing_type=fit)

Place 2 Timed Objective devices behind the Starting Grid. Like the Tracker devices, these will be invisible to the players. Placing these behind the Starting Grid allows you to modify all of these devices at one time without going all over the island.

#### Timed Objective 1 (Start the Race)

Timed Objective 1 is used to start the race. Customize Timed Objective 1 by modifying the options shown below. When you have finished customizing the options, click **OK** to save your changes.

[![Timed Objective 1 Options](https://dev.epicgames.com/community/api/documentation/image/8b10c343-20a6-45e8-8eba-990396298b74?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b10c343-20a6-45e8-8eba-990396298b74?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Start When Round Starts** | Yes | As soon as the round starts, this timed objective is activated and starts counting. |
| **Time** | 10 seconds | The device counts for 10 seconds, then completes. When the device completes the count, it transmits a signal. |
| **Timer Label Text** | "Race Starts In:" | This displays text the player can see, showing the number of seconds until the game starts. |
| **Hologram Until Activated** | No | The device must be invisible during the game. |
| **Visible During Game** | No | The device must be invisible during the game. |
| **When Completed Transmit On** | Channel 150 | When the timer completes the count, it transmits on Channel 150. The Barrier device in front of the Starting Grid is disabled when it receives a signal on Channel 150. When the Barrier is disabled, the players can move onto the track and start racing. |

#### Timed Objective 2 (End Fireworks)

Timed Objective 2 is used to turn off the fireworks that go off at the start of the race. Customize Timed Objective 2 by modifying the options shown below. When you have finished customizing the options, click **OK** to save your changes.

[![Timed Objective 2 Options](https://dev.epicgames.com/community/api/documentation/image/b4325148-453a-4d3b-801b-80c9d64e429b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b4325148-453a-4d3b-801b-80c9d64e429b?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Time** | 10 seconds | This is the amount of time on the countdown timer. |
| **Hologram Until Activated** | No | The device must be invisible during the game. |
| **Visible During Game** | No | The device must be invisible during the game. |
| **Countdown Visible on HUD** | No | The device must be invisible during the game. |
| **Start When Receiving From** | Channel 150 | Timed Objective 1 transmits on this channel when it reaches 0. This device starts counting down when it receives a signal on this channel. |
| **When Completed Transmit On** | Channel 149 | When the device ends its countdown (10 seconds), it transmits a signal to the VFX Spawner device to turn off the fireworks. |

## Add and Set Up Race Checkpoints

[![Image of Race Checkpoints](https://dev.epicgames.com/community/api/documentation/image/1c90d761-5179-4216-81b0-d2e109dbe873?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c90d761-5179-4216-81b0-d2e109dbe873?resizing_type=fit)

Add 5 Race Checkpoint devices to your racetrack, as shown in the image. Customize the checkpoints by modifying the options shown below. When you have finished customizing the options, click **OK** to save your changes.

[![Race Checkpoint Options](https://dev.epicgames.com/community/api/documentation/image/120a2ee0-9745-4a61-b1a8-afc65b4945a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/120a2ee0-9745-4a61-b1a8-afc65b4945a9?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Checkpoint Number** | Checkpoint 1–5 | Each checkpoint number is incremented when you place them down. Make sure the Checkpoint numbers are in order that you want them to be driven through for the race. |
| **Allow Players to Pass without Vehicle** | No | Even though the devices are set up to keep players on their hoverboards, it's best to set this to No. |
| **Enabled During Phase** | Gameplay Only | The checkpoint appears only when the game starts, not in the pre-game lobby. |
| **When Checkpoint Completed Transmit On** | Channel 25 | Use this channel for scoring. Whenever players pass through the checkpoint, it transmits on this channel and the Score Manager receives the signal and assigns a score. |

## Add and Set Up the Score Manager

[![Image of Score Manager](https://dev.epicgames.com/community/api/documentation/image/585a2661-ba82-403b-8b71-14e5c6726713?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/585a2661-ba82-403b-8b71-14e5c6726713?resizing_type=fit)

Add a Score Manager device. It defaults to being invisible, so you can place it anywhere. But it is more convenient to place it with the other devices behind the Starting Grid. Customize the Score Manager by modifying the options shown below. When you have finished customizing the options, click **OK** to save your changes.

[![Score Manager Options](https://dev.epicgames.com/community/api/documentation/image/2f820749-87ff-43d0-8c16-263b38607ae5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f820749-87ff-43d0-8c16-263b38607ae5?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Score Value** | 1 | This grants 1 score to players as they pass through each checkpoint. |
| **Activate When Receiving From** | Channel 25 | This channel matches the channel the checkpoints transmit on. |

## Add and Set Up the Race Manager

[![Image of Race Manager](https://dev.epicgames.com/community/api/documentation/image/cc83b4ce-a40b-4339-9de8-c340bc96b59c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cc83b4ce-a40b-4339-9de8-c340bc96b59c?resizing_type=fit)

Add a Race Manager device. Again, you can place this with the other devices behind the Starting Grid. Customize the Race Manager by modifying the options shown below. When you have finished customizing the options, click **OK** to save your changes.

[![Race Manager Options](https://dev.epicgames.com/community/api/documentation/image/49e3c6e2-997f-45b5-b940-56c7ac159a9f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/49e3c6e2-997f-45b5-b940-56c7ac159a9f?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Number of Laps** | 4 | Players must complete 4 laps to win the race. |
| **Start Race on Game Start** | No | The race will start under certain conditions, so set this to No. |
| **Start Race When Receiving From Channel** | Channel 149 | The second Timed Objective will transmit on Channel 149 when it completes, and this will start the race. |

## Add and Set Up the Powerups and Special Tiles

There are multiple devices that you need to place on the racetrack. There are special powerup tiles on certain parts of the track, and there are also visual effects (VFX) powerups that grant items to players when driven over.

### Speed Boost Tiles

[![Image of Speed Boost Tile](https://dev.epicgames.com/community/api/documentation/image/b1bfa787-34d6-4e80-83ad-2e9089339e3a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1bfa787-34d6-4e80-83ad-2e9089339e3a?resizing_type=fit)

If you look at the tutorial Island, you'll notice that there are Speed Boost tiles on several parts of the racetrack. You don't have to place them exactly like the track in the example Island. You could place them before a powerup or Bouncer tile, to make it either easier or harder to get that powerup or special tile effect. Or you could place them right before a checkpoint, to help improve the player's overall time.

The Speed Boost tile has one option you can modify. Customize the option as shown below, then click **OK** to save your changes. Remember, you can customize one and then copy-paste as many tiles as you need.

| Option | Value | Explanation |
| --- | --- | --- |
| **Impulse** | High | This setting determines how much the tile boosts the player's speed. Setting this to High is a suggestion; depending on the kind of racetrack you have built and how you want to use the tiles, you can experiment with the values on each tile until you get the effects you want. |

### Bouncer Tiles

[![Image of Bouncer Tile](https://dev.epicgames.com/community/api/documentation/image/35c32e2c-198d-49e5-bd8a-25aa558ee038?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/35c32e2c-198d-49e5-bd8a-25aa558ee038?resizing_type=fit)

The Bouncer tile causes the player to be launched into the air. It can be placed to either benefit the player, or make the race more challenging. Bouncer tiles are traps, which means you cant customize any options for them.

### Visual Effects Powerup

[![Image of VFX Powerup](https://dev.epicgames.com/community/api/documentation/image/16b4a3b4-b311-4efc-919e-5a3e9dd064c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/16b4a3b4-b311-4efc-919e-5a3e9dd064c1?resizing_type=fit)

The VFX powerup works together with the Item Granter, to give players certain items when they drive over the VFX powerup. Customize the VFX powerups by modifying the options shown below. When you have finished customizing the options, click **OK** to save your changes. Then place the VFX powerups all over the racetrack, so the players have many opportunities to drive over them.

You can see a video example for how to connect the VFX powerup to the Item Granter below.

You can modify the first powerup, and then copy-paste that one to make a lot more. That way you won't have to customize the options for each one.

[![VFX Powerup Options](https://dev.epicgames.com/community/api/documentation/image/eb58e461-b7f2-42e4-aa63-2d8c8d7bd7c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb58e461-b7f2-42e4-aa63-2d8c8d7bd7c1?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Color** | Gold | Sets the color of the glow around the powerup. |
| **Pickup Radius** | .75 | How close the player needs to be to collect the powerup. |
| **Time to Respawn** | 5 seconds | The amount of time it takes for the powerup to respawn after a player collects it. |
| **When Item Picked Up Transmit On** | Channel 26 | When it is picked up, the powerup transmits a signal on this channel. |

### Item Granter

[![Image of Item Granter](https://dev.epicgames.com/community/api/documentation/image/309b545a-fb8c-4604-942d-48ce54553a4f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/309b545a-fb8c-4604-942d-48ce54553a4f?resizing_type=fit)

The players will get items when they drive over the VFX powerup. These items are actually stored and granted by the Item Granter device. Register the items you want the players to receive by dropping them on the Item Granter. Customize the Item Granter by modifying the options shown below. When you have finished customizing the options, click **OK** to save your changes.

[![Item Granter Options](https://dev.epicgames.com/community/api/documentation/image/7eed4c1d-3ef3-4bcd-967c-d02fd0c65da8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7eed4c1d-3ef3-4bcd-967c-d02fd0c65da8?resizing_type=fit)

*Click image for full size.*

| Option | Value | Explanation |
| --- | --- | --- |
| **On-Grant Action** | Keep All | When the device grants an item to a player, everything in the player's inventory will be kept. |
| **Grant Condition** | Only If Space | The device will only grant an item to the player if they have space in their inventory. |
| **Spare Weapon Ammo** | 0 | If the item granted is a weapon, the device will not give the player bonus ammunition. |
| **Cycle Behavior** | Wrap | When the device gets to the end of the list of items registered, it will start over at the beginning of the list and grant that item. |
| **Cycle to Random Item When Receiving From** | Channel 26 | The device randomly chooses a registered item to grant when the device receives a signal on this channel. This is the same channel that the VFX powerup transmits on when the player picks it up. |
| **Restock Items When Receiving From** | Channel 26 | The device restocks all registered items when it receives a signal on this channel. This is the same channel that the VFX powerup transmits on when the player picks it up. |

## Change Island Settings

There are some island-level settings that need to be customized to make this race game work. Press **M** to get to the Island Settings screen. Any setting that is not listed in the sections below should be left at the default value.

### Mode Settings

#### Structure Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Max Players** | 8 | Sets the maximum number of players for the game. The race is set up for 8 players. |
| **Teams** | 8 | Each player is their own team, so there are 8 teams. |
| **Team Size** | 1 | Team size is 1 player. |
| **Matchmaking Type** | Off | Turning this off means each player joining is assigned to any open team. Since Team Size is set to 1, each player is assigned one player to a team. |
| **Total Rounds** | 1 | Right now the game is set to end after a player goes through a certain number of checkpoints and there is only one round. But you can decide how many rounds the game will run. |

#### Game Start Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Autostart** | 30 seconds | This determines whether the game will automatically start after a set amount of time. This only applies to published Islands. |
| **Game Start Countdown** | 5 seconds | When the game starts, players have to wait this amount of time before they can do something. |

#### Spawning Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Join In Progress** | Spectate | You don’t want players joining in the middle of a race, so this makes them a spectator until the next race starts. |

#### Eliminations Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Down But Not Out** | Off | Because this is primarily a racing game and not a typical combat game, Down But Not Out isn’t needed. |
| **Eliminated Player's Items** | Drop | This setting determines what happens to a player’s items when that player is eliminated. Setting it to Drop means eliminated players drop all their items on the ground. |
| **Health Granted on Elimination** | 25 | This sets the amount of health a player receives when eliminating another player. If the amount of health gained goes over the maximum health amount, the excess is applied to the player’s shields. |

#### Scoring Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Vehicle Trick Score Multiplier** | 0.0 | There aren’t any tricks in this game, so this is set to 0. |

#### Victory Condition

| Option | Value | Explanation |
| --- | --- | --- |
| **Game Win Condition** | Most Rounds Wins | The devices end the round when a certain number of checkpoints are passed by a player. Since we have Rounds set to 1, the player that goes through the right number of checkpoints first wins the round, and wins the game. |

### Round Category > Victory Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Round Win Condition** | Score | This setting determines what players need to do to win the game. Setting this to Score means the player with the highest score at the end of the round wins that round and wins the game. This is shown in the first column of the Scoreboard. |
| **Tie Breaker 1** | Time | If two players have the same score at the end of the round, they are tied. This setting determines what will break the tie. Setting it to Time means that when two players are tied, whichever player has the lowest time will win the round and the game. |

### Player Category

#### Locomotion Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Glider Redeploy** | Off | This prevents players from deploying their glider when they are in the air, unless they use an item. |

#### Health Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Starting Health** | 100% | This sets how much health a player has when they spawn on the Island. |
| **Max Health** | 100 | This sets the maximum amount of health the character can gain in the game. |

#### Shields Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Starting Shields** | 100% | This sets the player’s Shield value when they spawn on the Island. |
| **Max Shields** | 50 | This sets the maximum amount of Shield the player can gain in the game. |

#### Pickups Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Allow Item Pick Up** | Yes | This setting allows players to pick up the powerups in the game, as well as picking up any items dropped by eliminated players. |
| **Auto Pickup Pickups** | Yes | Auto Pickup is when players automatically collect items. Players will automatically collect Pickups. |
| **Auto Pickup Ammo** | Yes | Auto Pickup is when players automatically collect items. Players will automatically collect ammo. |
| **Auto Pickup Items** | Yes | Auto Pickup is when players automatically collect items. Players will automatically collect items. |
| **Auto Pickup Gadgets** | Yes | Auto Pickup is when players automatically collect items. Players will automatically collect Gadgets. |
| **Auto Pickup Traps** | No | Building is turned off in this game, so players won’t be able to pickup or place traps. |
| **Auto Pickup Weapons** | Yes | Auto Pickup is when players automatically collect items. Players will automatically collect weapons. |

#### Build Mode Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Allow Building** | None | This racing game doesn’t need players to build, so building is turned off for this game. Choosing None also means players can’t place traps in the game. |

#### Inventory Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Maximum Building Resources** | 0 | Building is not part of the game design for this Island, so players will not be able to collect building resources. |
| **Allow Item Drop** | No | Once a player picks up an item, they can’t drop it from their inventory during the game. |

#### Equipment Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Environment Damage** | Off | Setting this to Off means the players won't be able to damage the environment of the Island. |
| **Structure Damage** | None | Setting this to None means the players aren't able to damage any structures you build on the Island. |
| **Weapon Destruction** | Percentage | This setting modifies how much damage is done to buildings and the environment during games. |
| **Weapon Destruction Percentage** | None | This setting ensures that players' weapons won't destroy the environment or structures on the island. |
| **Pickaxe Destruction** | None | This setting ensures that players can't use their pickaxe to destroy the environment or structures on the island. |
| **Pickaxe Damage** | No Damage | This racing game doesn't include combat, so you can turn off the ability to use a pickaxe to damage another player. |

### World Category > Ambiance Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Time of Day** | Pick a time of day | The example Island is set to 10:00 PM, but you can set this to any time. Setting the time here gives you more control over the lighting in the game. |

### User Interface Category

#### HUD Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **HUD Info Type** | Score | This setting determines what information is tracked in the players' HUD. Selecting Score means the HUD will track a player's score. |

#### Scoreboard Subcategory

| Option | Value | Explanation |
| --- | --- | --- |
| **Display Scoreboard** | Yes | When the player presses the **M** key this determines if they will see the Scoreboard. |

## Build the Pre-Game Lobby

All games should have a pre-game lobby, where the players wait until the start of the game. Follow these steps to create a pre-game lobby for your race game.

1. Pick an area on the island that is not being used for playing the game, and build a room where you can set up the pre-game lobby.
2. In the room, place 8 Player Spawn Pads (to match the 8-player Starting Grid you built).
3. Customize each Player Spawn Pad by modifying the following options. You can also customize one, then copy-paste it to create the other devices you need.

   [![Pre-Game Lobby Player Spawn Pad Options](https://dev.epicgames.com/community/api/documentation/image/2f83107b-4e9c-4844-aee6-ad4a637f874b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f83107b-4e9c-4844-aee6-ad4a637f874b?resizing_type=fit)

   *Click image for full size.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Enabled During Phase** | All | The pre-game lobby is enabled in all game phases. |
   | **Priority Group** | Secondary | This determines the priority order in which spawn pads are used. If all Primary spawn pads are not available, players will be spawned on Secondary spawn pads. |
   | **Use As Island Start** | Yes | This determines if this spawn pad can be used when players are spawning into the Island during the Pre-Game Phase. |
   | **Visible During Game** | No | Spawn pads should not be visible during the game. |
4. Press **M** and click **Island Settings** at the top of the screen. Modify the following options in the **Game** category.

   If you have completed all the previous sections, some of these settings have already been modified. However you can use these steps and this list of My Island setting modifications to create a pre-game lobby in any game you build in Fortnite Creative.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Join In Progress** | Spectate | You don't want players joining in the middle of a race, so this makes them a spectator until the next race starts. |
   | **Spawn Location** | Spawners | This is where the players will spawn when the game starts. |
   | **Respawn Type** | Individual | Eliminated players respawn one at a time, not as a group. |
   | **Post-Game Spawn** | Island Start | This is where the players will respawn when the game ends. |
   | **Only Allow Respawn if Spawn Pads Found** | No | Players are always allowed to respawn. |
   | **Autostart** | 60 seconds | This determines whether the game will automatically start after a set amount of time. This only applies to published Islands. |
   | **Game Start Countdown** | Off | There is no countdown before the start of the game. |
   | **Keep Player Built Structures Between Rounds** | Off | Player-built structures are not kept between rounds. |

## Designer Tips

Here are some tips for changing or adding things to your island in order to change how the island plays out, or how to create new games based on this island by changing various devices or settings.

### Create a Surfboard Race

The same steps used to create this Hoverboard island can be used to create a surfboard racing island. The things you need to change are listed below.

1. You may need to change how you build the Starting Grid. Try using column supports or building a platform to put the Starting Grid on.
2. Change the **Driftboard Spawners** to **Surfboard Spawners**.
3. Create the racing route on water instead of using a racetrack on land. You'll also place the **Race Checkpoints** in the water.
4. You may need to change the items registered in the Item Granter, because some powerups or other items work differently for vehicles than they do for individual players. Some items may work differently on water than they do on land.

Here's a video example of a Surfboard Race.

### Variations for the Hoverboard Race

- Using the lessons learned in this tutorial, you can create other game modes. For example, giving everyone weapons changes the game play, because players will want to go slowly and shoot each other instead of just racing.
- Using additional or different types of traps can change the driving experience for players. Putting traps in strategic locations, such as a speed boost in a tight area, can make the driving experience more challenging.
- You can create Barriers to keep players on a track instead of just on a map. The Barriers can be made invisible or be visible depending on the look the creator is going for.
- You can change the powerups or items granted to players:

  - You can change the Visual Effect powerup to have a longer or shorter delay before it respawns.
  - You can create a combat game mode, and use the Item Granter to grant weapons and ammunition.
  - You can change the Item Granter to grant a set amount of items, grant items in sequence instead of randomly, and even force players to equip an item granted by the Item Granter.
  - You can use the Item Granter to replace the player’s items instead of adding to the player's items.
  - You can set the Item Granter grant items to a team, a class, or to all players. These choices give you the ability to create different types of powerups, which can benefit the players or challenge them.

### Create a Copy of Your Race Island

When you have an Island you like, but want to experiment by adding or changing things, you can make a duplicate of your Island. That way you can experiment and make changes without messing up your current Island.

When you open the console and click **Create New**, the **Game Creation** screen displays. To duplicate your Island, select it in the list and click the **Duplicate** button below the list. A copy of your original Island will appear in the list, and you can set the portal to take you there.

[![image alt text](https://dev.epicgames.com/community/api/documentation/image/c8ba33c1-57bb-4d4e-8787-1c0340638134?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c8ba33c1-57bb-4d4e-8787-1c0340638134?resizing_type=fit)

Once you have experimented and changed things, if you like the new island you can change the name of the island by going to **My Island** and clicking the **Description** tab.
