# Parkour Elimination Race

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-a-parkour-elimination-race-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:58:52.174790

---

In **Parkour Elimination Race**, players will use their parkour skills to race through an obstacle course before battling in a final free-for-all.

This tutorial teaches you the [game mechanics](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-mechanics) to create your parkour free-for-all using unique devices like the [Prop Mover](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative). By the end of this tutorial, you will create a gameplay with moving pieces and puzzles for players to master before they battle for victory.

The sample island code for this tutorial is **7132-0029-6163**.

To play through this island, click **CHANGE** on the **Fortnite Lobby** screen. On the **Discover** screen, click the **Island Code** tab and enter the code for Parkour free-for-all. Once you've seen all the gameplay features, you can explore this tutorial and recreate it on your island.

## Props, Prefabs, and Galleries

A variety of [Prefab](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prefab) and [Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gallery) items were used to design this island. When recreating this island, test your creativity by envisioning a theme while mixing and matching items from various categories.

Be sure to fill any open areas with appealing props that matches your gameplay's theme.

Read the prerequisite tutorials to learn how to use Gallery pieces to build pre-game lobbies and arenas.

## Overview of Tutorial Steps

Following is an overview of the steps you'll need to recreate this island, and its ideal sequence:

1. Create a new island using a [starter island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#starter-island).
2. Set up your island structure, such as an [arena](https://dev.epicgames.com/documentation/en-us/fortnite/building-arenas-in-fortnite-creative).
3. Set up the [pre-game lobby](https://dev.epicgames.com/documentation/en-us/fortnite/building-pregame-lobbies-in-fortnite-creative).
4. Set up the starting area.
5. Set up the race area.
6. Set up the background devices.
7. Set up the free-for-all arena.
8. Set up the respawn rooms.
9. Customize the island settings.

## Create Your Island

To build your island use the following steps.

1. Find your personal rift in the hub by locating the golden glow.

   [![Game Creation Window](https://dev.epicgames.com/community/api/documentation/image/e442b8d9-c883-4a45-a1e2-8ad5ff975a32?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e442b8d9-c883-4a45-a1e2-8ad5ff975a32?resizing_type=fit)
2. Use the console next to your rift to create a new island. Press **E** to enter the **GAME CREATION** screen and select **CREATE NEW**. This displays the **Select Type** dialog.

   [![Select Island Grid](https://dev.epicgames.com/community/api/documentation/image/c8b1e7b4-a0d2-4615-b8b2-014d3bc83c47?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c8b1e7b4-a0d2-4615-b8b2-014d3bc83c47?resizing_type=fit)
3. Under the tab **STARTER ISLAND**, there are three grid islands that vary by memory allocation (GRID ISLAND, LARGE GRID ISLAND, and XL GRID ISLAND). For this tutorial, choose **LARGE GRID ISLAND**.
4. After you click **CONFIRM**, type a name for your island, then click **CONFIRM** again.

The portal will automatically load and teleport you into the island.

Be sure to check out our short [video tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials) to learn more about the beginning steps to creating your island.

## Setting Up the Pre-Game Lobby

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/596c1a26-3f98-4ac0-b69c-e1b9d5e9f485?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/596c1a26-3f98-4ac0-b69c-e1b9d5e9f485?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

The pre-game lobby is where players will initially spawn into the gameplay. They will then learn the game rules while collecting [Gold](https://dev.epicgames.com/documentation/en-us/fortnite/using-gold-items-in-fortnite-creative) to begin the race.

In this section, you will use the following devices:

- 4 x [Player Spawner devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 4 x [Item Spawner devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative)
- 4 x [Teleporter devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative)
- 4 x [HUD Message devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)

### Player Spawn Pads #1-4

[![Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/6be78efd-4549-4598-a4bd-e3b8dac38303?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6be78efd-4549-4598-a4bd-e3b8dac38303?resizing_type=fit)

Use **Player Spawn Pads** to spawn players into the pre-game lobby. In your pre-game lobby, set up four spawn rooms, one for each player.

To set up this device:

1. Press the **Tab** key to open the **Creative** inventory, then click the **Devices** tab.
2. Equip **Player Spawn Pad**, then click **PLACE NOW**, and place your spawn pad.
3. Customize its options as shown below.

   [![Modified Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/3dd6e0f5-659d-4551-acf1-f3fe4992a3b3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3dd6e0f5-659d-4551-acf1-f3fe4992a3b3?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Priority Group** | Primary | This setting sets this device as the primary spawn pad. |
   | **Visible During Games** | No | This setting hides the device during gameplay. |
   | **Disable When Receiving From** | Channel 30 | After the 30-second countdown to start the free-for-all portion of the game, these devices will be disabled. |
   | **When Player Spawned Transmit On** | Channel 1 | This signal will register players in the **Player Register Device**. This setting will increase incrementally for each device, from Channel 1 to Channel 4. |
4. Select **OK** to save and exit.
5. Place a **Player Spawn Pad** in each spawn room.

   a. Incrementally increase the setting for **When Player Spawned Transmit On** from Channel 1 to Channel 4.

### Item Spawners #1-4

[![Item Spawner](https://dev.epicgames.com/community/api/documentation/image/cb11df01-1e4e-4537-adbc-e085deb3961a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cb11df01-1e4e-4537-adbc-e085deb3961a?resizing_type=fit)

Use the **Item Spawner** to spawn Gold onto the map for your players. Players will use Gold to purchase weapons in the free-for-all arena.

To set up this device:

1. Equip and place the **Item Spawner** in an area immediately visible by players when they spawn into the game.
2. Customize its options as shown below.

   [![Modified Item Spawners](https://dev.epicgames.com/community/api/documentation/image/50f2c616-585d-4a13-b582-f10ca878dc74?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/50f2c616-585d-4a13-b582-f10ca878dc74?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Items Respawn** | Off | The registered Gold will not respawn. |
   | **Base Visible During Game** | Off | The base will not be visible during gameplay. |
   | **Time Before First Spawn** | Instant | The registered Gold will instantly spawn when the round begins. |
   | **Run Over Pickup** | On | Players will automatically pick up the registered Gold when they get near it. |
   | **Item Scale** | 2X | The registered Gold will have a larger display. |
3. Select **OK** to save and exit.
4. Copy the customized device and place it in each spawn room.

### Teleporters #1-4

[![Teleporter](https://dev.epicgames.com/community/api/documentation/image/fc449989-644e-4ae8-aaa2-9a46a0ec72ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc449989-644e-4ae8-aaa2-9a46a0ec72ff?resizing_type=fit)

Use **Teleporters** to move players from one area to another. Once the players retrieve their Gold, they will teleport to the central starting location of the race.

To set up this device:

1. Equip and place the **Teleporter** onto your island.
2. Customize its setting as shown below.

   [![Modified Teleporter](https://dev.epicgames.com/community/api/documentation/image/49b33077-3007-4671-b9c3-571ffc9ba6aa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/49b33077-3007-4671-b9c3-571ffc9ba6aa?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Teleporter Group** | None | This device does not need a teleporter group since it sends to one other target group. |
   | **Teleport Target Group** | Group D | Entering this teleporter will send players to the starting room teleporter, set to Group D. |
3. Select **OK** to save and exit
4. Copy the customized device and place it in each spawn room behind the Item Spawner.

### HUD Message #1-4

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/a35c2385-0342-4a74-8b42-57d62254af32?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a35c2385-0342-4a74-8b42-57d62254af32?resizing_type=fit)

Use the **HUD Message** device to communicate game rules during your pre-game lobby.

To set up this device:

1. Equip and place the **HUD Message** device in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Hud Message](https://dev.epicgames.com/community/api/documentation/image/8bd129ef-0f8b-45b6-8db1-75e3de896f93?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8bd129ef-0f8b-45b6-8db1-75e3de896f93?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | Grab the Coin, enter the Teleporter, and race to the finish! | This will be the message that's played upon spawning. |
   | **Message Recipient** | Triggering Player | Only the triggering player can see the message. |
   | **Time From Round Start** | Off | This device will not activate until receiving a signal from the Player Spawn Pad. |
   | **Show When Receiving From** | Channel 1 | The Player Spawn Pad will send a signal to this device on Channel 1. This setting will increase incrementally for each device, matching the Player Spawn Pad’s setting **When Player Spawned Transmit On**, from Channel 1 to Channel 4. |
3. Select **OK** to save and exit.
4. Copy the customized device and place them beside each other.

   a. Incrementally increase the **Show When Receiving From** setting from Channel 1 to Channel 4.

## Setting Up the Starting Area

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/55b46efc-a735-43d1-b8f9-17e3aa4ab19a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/55b46efc-a735-43d1-b8f9-17e3aa4ab19a?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

The starting area is where players will teleport in and begin the race.

In this section, you will use the following devices:

- 1 x Teleporter
- 1 x Player Checkpoint

### Teleporter #5

Use this Teleporter as the connecting location to the Teleporters placed in the spawn room. All players will move through this Teleporter to meet in a centralized location.

To set up this device:

1. Equip and place a **Teleporter** in your arena's central hub, where the race begins.
2. Customize its settings as shown below.

   [![Modified Central hub teleporter](https://dev.epicgames.com/community/api/documentation/image/d7a3a028-5317-4ece-ab61-bfb7343f91b4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d7a3a028-5317-4ece-ab61-bfb7343f91b4?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Teleporter Group** | Group D | This is the connecting group for the spawn room teleporters. |
   | **Teleporter Target Group** | None | Players will not teleport from this device. |
   | **Teleporter Rift Visible** | No | The teleporter is invisible. |
   | **Play Visual Effects** | No | There will be no visual effects from this device. |
   | **Play Sound Effects** | No | There will be no audio from this device. |
   | **Conserve Momentum** | No | Teleporting players will not be affected by running or jumping. |
   | **Face Player In Teleporter Direction** | Yes | Players will be faced towards the tunnel leading to the race. |
3. Select **OK** to save and exit.

### Player Checkpoint Pad #1

[![Player Checkpoint Pad](https://dev.epicgames.com/community/api/documentation/image/b84ff15b-710f-4e86-8458-39c4e24bb5be?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b84ff15b-710f-4e86-8458-39c4e24bb5be?resizing_type=fit)

Use the **Player Checkpoint Pad** to create a save point for players during the race. When players are eliminated, they will return to their last checkpoint.

To set up this device:

1. Equip and place a **Player Checkpoint** pad in the tunnel of your central starting area.
2. With the device’s blueprint selected, hold the right mouse button to grow its width until it fits the entire floor tile.

   a. Make sure the device is slightly raised to prevent players from spawning through the floor and eliminating themselves.
3. Customize its settings as shown below.

   [![Modified Player Checkpoint](https://dev.epicgames.com/community/api/documentation/image/d35721ac-65a3-4bfe-a5d3-d369ef14884d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d35721ac-65a3-4bfe-a5d3-d369ef14884d?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible During Game** | Off | This device will not be visible during gameplay. |
   | **Disable When Receiving From** | Channel 30 | After the 30-second timer to start the free-for-all round, Player Checkpoints and the original Player Spawn Pads will be disabled. |
4. Select **OK** to save and exit.

## Setting Up the Race Area

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/098eadad-3186-4525-bc3d-ddfc7d1e75dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/098eadad-3186-4525-bc3d-ddfc7d1e75dc?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

The race area is where players will use their parkour skills to traverse the arena. Design a parkour arena for players to perform long jumps, sprints, and mantling to get from one area to another.

In this section, you will use the following devices:

- 1 x [Damage Volume device](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative)
- ~ x [Prop Mover devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative)
- 1 x [Player Checkpoint device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative)
- 1 x [Teleporter device](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative)
- 1 x [Mutator Zone device](https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative)

### Damage Volume

[![Damage Volume](https://dev.epicgames.com/community/api/documentation/image/3661de96-2f71-44d7-8267-9bde4b04eaff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3661de96-2f71-44d7-8267-9bde4b04eaff?resizing_type=fit)

Use the **Damage Volume** to create a zone that instantly eliminates players. Eliminated players will return to the last checkpoint they reached.

To set up this device:

1. Equip and place a **Damage Volume** in a lower area of your arena to create a floor.
2. Customize its settings as shown below.

   [![Modified Damage Volume](https://dev.epicgames.com/community/api/documentation/image/cf99dcf7-114f-4a58-aaaf-bec4521eb90f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf99dcf7-114f-4a58-aaaf-bec4521eb90f?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Width** | 100 | This device will be wide enough to cover the map. |
   | **Barrier Depth** | 100 | The device will be long enough to cover the map. |
   | **Barrier Height** | 0.05 | This device will be thin enough to eliminate players as they touch the ground. |
   | **Damage Type** | Elimination | Players will be instantly eliminated when making contact with this device. |
3. Select **OK** to save and exit.

## Designer Tips

Use **Lava blocks** from the **Prefabs** tab to give your floors a hazardous appearance. Place these blocks below the Damage Volume so that it can instantly eliminate players who fall.

[![Lava Blocks](https://dev.epicgames.com/community/api/documentation/image/14280a02-ad85-4321-9c19-5bed801e4d58?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/14280a02-ad85-4321-9c19-5bed801e4d58?resizing_type=fit)

### Prop Mover

[![Prop Mover](https://dev.epicgames.com/community/api/documentation/image/0520c0dd-d1d2-4933-a695-357001f2f364?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0520c0dd-d1d2-4933-a695-357001f2f364?resizing_type=fit)

Create a puzzle using moving pieces with the **Prop Mover**. Use this device to add an extra challenge to long jumps throughout your arena.

To set up this device:

1. Equip and place a **Prop Mover** onto a prop wall or floor piece.

   a. Position the device’s arrow to point in the direction of your choice.
2. Customize its settings as shown below.

   [![Modified Prop Mover](https://dev.epicgames.com/community/api/documentation/image/d56d5f9f-7a06-4902-9dd0-190a4f2caa5d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d56d5f9f-7a06-4902-9dd0-190a4f2caa5d?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Distance** | 5 Meters | This is the prop’s total distance moved. |
   | **Speed** | 1 Meter/Second | This is the prop’s total speed. |
   | **On Player Collision Behavior** | Continue | If the device contacts a player, it ignores them and continues moving. |
   | **Player Damage On Collision** | None | There will be no damage if players touch the prop. |
   | **On Prop Collision Behavior** | Reverse | If the prop touches another prop or wall, it will reverse direction. |
   | **Path Complete Action** | Ping Pong | At the end of the prop’s distance, it will reverse in the opposite direction. |
3. Select **OK** to save and exit.
4. Copy and place the customized device on other props of your choice.

   a. You can alter the distance and orientation to add variety.

### Player Checkpoint #2

Copy and paste the **Player Checkpoint** from the [previous section](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-parkour-elimination-race-in-fortnite-creative) and place it halfway to the race’s end. Players will touch this checkpoint to save their progress.

## Designer Tips

Add **[Damage Rails](https://dev.epicgames.com/documentation/en-us/fortnite/damage-rail)** to your arena as an extra obstacle for players as they race.

[![Damage Rail Tip](https://dev.epicgames.com/community/api/documentation/image/a7fc9a18-2a1f-4479-b66f-1ce24999fa2b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a7fc9a18-2a1f-4479-b66f-1ce24999fa2b?resizing_type=fit)

### Teleporter #6

Place this Teleporter at the end of your race, large enough for players to jump into. Players who enter this Teleporter will be sent to the free-for-all arena.

To set up this device:

1. Equip and place a **Teleporter** at the end of your race.
2. Customize its settings as shown below.

   [![Modified Teleporter 6](https://dev.epicgames.com/community/api/documentation/image/e86c4958-2933-44e6-9ce9-12dc73bd740f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e86c4958-2933-44e6-9ce9-12dc73bd740f?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Teleporter Group** | None | This teleporter does not belong to any groups. |
   | **Conserve Momentum** | No | When jumped into, the player will be teleported from a full stop, avoiding any fall damage. |
   | **When Entered Transmit On** | Channel 60 | When entered, a signal will be sent to a Trigger, which will show a HUD Message as discussed in the next section. This signal also triggers the 30-second countdown that forces players to teleport into the free-for-all arena. |
3. Select **OK** to save and exit.

[![Teleporter Example](https://dev.epicgames.com/community/api/documentation/image/0b3dea45-a035-4848-b8f1-ea1c60ebbebf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0b3dea45-a035-4848-b8f1-ea1c60ebbebf?resizing_type=fit)

### Mutator Zone #1

[![Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/f27f0a5e-8565-4bfa-971d-6bf2262bbd6d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f27f0a5e-8565-4bfa-971d-6bf2262bbd6d?resizing_type=fit)

Use the **Mutator Zone** to send a signal that will teleport players to the free-for-all arena once the timer expires.

To set up this device:

1. Equip and place the **Mutator Zone** on the ground level, below the lava and damage volume.
2. Customize its settings as shown below.

   [![Modified Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/ada0a9a6-46e0-4945-a678-3b2eb3b6b54f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ada0a9a6-46e0-4945-a678-3b2eb3b6b54f?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Zone Width** | 100 | This device’s zone will be wide enough to cover the parkour arena. |
   | **Zone Depth** | 100 | This device’s zone will be deep enough to cover the parkour arena. |
   | **Zone Height** | 13 | Alter this setting so that this device’s zone stops before the free-for-all arena. |
   | **Enabled During Phase** | None | This device will not activate until it receives a signal from a channel. |
   | **Enable When Receiving From** | Channel 30 | When the free-for-all timer finishes, the Mutator Zone is turned on and encompasses the parkour arena. |
   | **On Player Entering Zone Transmit On** | Channel 5 | When a player is in the zone, a signal is broadcast to teleport everyone of Class ID 1 to the free-for-all arena. Players who have already completed the race will be Class ID 2 and will not be affected. |

## Designer Tips

Like the Mutator Zone, the **Campfire** device can also be used to send a signal that pushes players to teleporters. Use the Campfire device as either an alternative or as a backup to the Mutator Zone.

## Setting Up the Background Devices

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/ee952c86-4158-4901-b94b-ab083290f406?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee952c86-4158-4901-b94b-ab083290f406?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

The background devices for this section are what drive the free-for-all portion of this gameplay. You can place these background devices near each other in an area that players cannot see like the arena’s roof.

In this section, you will use the following devices:

- 4 x Item Granter
- 3 x Trigger
- 1 x HUD Message
- 1 x Timed Objective
- 4 x Player Reference

### Item Granter #1-4

[![Item Granter](https://dev.epicgames.com/community/api/documentation/image/70a85732-40a7-43f2-9b86-5e04733e084b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/70a85732-40a7-43f2-9b86-5e04733e084b?resizing_type=fit)

Use the **Item Granter** to grant players their chosen weapon in the free-for-all arena.

To set up this device:

1. Equip and place an Item Granter in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Item Granter](https://dev.epicgames.com/community/api/documentation/image/f6b6d55a-c8be-4dc0-bb97-ffd7fd210410?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f6b6d55a-c8be-4dc0-bb97-ffd7fd210410?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **On-Grant Action** | Keep All | There will be no change to the player’s inventory once granted. |
   | **Equip Granted Item** | First Item | The shotgun will automatically equip once granted. |
   | **Grant Item When Receiving From** | Channel 20 | When players use their Gold, a signal will be sent to this channel, which will then grant the corresponding weapon. This setting will increase incrementally for each device, from Channel 20 to Channel 23. |
3. Select **OK** to save and exit.
4. Copy the customized device and place 3 more **Item Granters** adjacent to the first Item Granter.

   a. Incrementally increase the **Grant Item When Receiving From** setting from Channel 20 to Channel 23.
5. Equip four shotguns of various qualities.
6. Stand beside an **Item Granter**. Drag and drop a weapon to register the item. Repeat for each Item Granter.

### Trigger #1

[![Trigger](https://dev.epicgames.com/community/api/documentation/image/88ccaf2f-488d-4186-a0a5-f7f8db77bed8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88ccaf2f-488d-4186-a0a5-f7f8db77bed8?resizing_type=fit)

When players teleport to the free-for-all arena, it will send a signal to a **Trigger**, which will activate a HUD Message to display for players. A Trigger is also used to make sure players are only teleported once.

To set up this device:

1. Equip and place a **Trigger** in an area unseen by players.
2. Customize its options as shown below.

   [![Modified Trigger](https://dev.epicgames.com/community/api/documentation/image/ebd92ff3-84bc-43e4-ad77-5d5035aae1c0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ebd92ff3-84bc-43e4-ad77-5d5035aae1c0?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Trigger Sound** | Disabled | This device will make no sound during gameplay. |
   | **Trigger VFX** | Disabled | This device will not have visual effects during gameplay. |
   | **Visible in Game** | No | This device will be invisible during gameplay. |
   | **Trigger When Receiving From** | Channel 60 | When players jump in Teleporter #6, it will trigger this device. |
   | **When Triggered Transmit On** | Channel 52 | HUD Message #5 will trigger to show the in-game instructions. |
3. Select **OK** to save and exit.

### Trigger #2

Use a second Trigger to serve as a buffer so that players can only teleport once.

To set up this device:

1. Equip and place a **Trigger** in an area unseen by players.
2. Customize its settings as shown below

   [![Modified Trigger 2](https://dev.epicgames.com/community/api/documentation/image/0b088391-6416-40f7-b718-4a6c26b0018c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0b088391-6416-40f7-b718-4a6c26b0018c?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Times Can Trigger** | 1 | This device can only trigger a single time, ensuring the end round only happens once. |
   | **Trigger Sound** | Disabled | There will be no sound when this device is triggered. |
   | **Trigger VFX** | Disabled | There will be no VFX when this device is triggered. |
   | **Visible in Game** | No | This device will not be visible during gameplay. |
   | **Trigger when Receiving From** | Channel 60 | When Teleporter #6 starts the arena countdown, it will also trigger this device. |
   | **When Triggered Transmit On** | Channel 55 | This signal goes to a Timed Objective to begin the free-for-all’s countdown. It is then disabled to avoid further triggering. |
3. Select **OK** to save and exit.

### Trigger #3

Use a Trigger to send a signal to the **Class Selector** after the timer ends. After a 10-second delay, this trigger will send a signal to deactivate the Class Selector, which enables players to teleport only one time to the free-for-all arena.

To set up this device:

1. Equip and place a **Trigger** in the same area as the previous Triggers.
2. Customize its settings as shown below.

   [![Modified Trigger 3](https://dev.epicgames.com/community/api/documentation/image/d6bf1254-f3fb-4dd6-8f61-9e1be514fb48?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d6bf1254-f3fb-4dd6-8f61-9e1be514fb48?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Delay** | 10 Seconds | This device will trigger after 10 seconds of being activated. |
   | **Trigger Sound** | Disabled | This device will not have audio during gameplay. |
   | **Trigger VFX** | Disabled | This device will not have VFX during gameplay. |
   | **Visible in Game** | No | This device will not be visible during gameplay. |
   | **Trigger When Receiving From** | Channel 30 | This device will receive a signal from the Timer when it ends. |
   | **When Triggered Transmit On** | Channel 35 | After a 10-second delay from when this device is triggered, it will send a signal to the Class Selector to deactivate. |
3. Select **OK** to save and exit.

### HUD Message #5

Use a HUD Message device to display the free-for-all instructions.

1. Equip and place a **HUD Message** device beside the Trigger you just placed.
2. Customize its settings as shown below.

   [![Modified HUD Message 5](https://dev.epicgames.com/community/api/documentation/image/6eb79be3-3e49-45bf-8f6d-8f44257ed739?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6eb79be3-3e49-45bf-8f6d-8f44257ed739?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | Buy the best weapon! No firing until the timer elapses. | The device will show this message. |
   | **Time From Round Start** | Off | This device will have to be triggered to send the HUD message. |
   | **Display Time** | Permanent | The HUD message will remain until another trigger deactivates it. |
   | **Message Priority** | Priority | This message will have priority over other messages. |
   | **Show When Receiving From** | Channel 52 | Trigger #1 will send a signal to activate this device’s message. |
   | **Hide When Receiving From** | Channel 30 | When the countdown is finished, this device’s message is hidden. |
3. Select **OK** to save and exit.

### Timed Objective

[![Timed Objective](https://dev.epicgames.com/community/api/documentation/image/193f1229-99b7-4c54-a573-494c7294b10b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/193f1229-99b7-4c54-a573-494c7294b10b?resizing_type=fit)

Use the **Timed Objective** device to send a signal that starts the free-for-all portion of the gameplay.

To set up this device:

1. Equip and place a **Timed Objective** device in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Timed Objective](https://dev.epicgames.com/community/api/documentation/image/0821d639-d0c5-4473-a459-e2d3eef34a52?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0821d639-d0c5-4473-a459-e2d3eef34a52?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Time** | 30 Seconds | The timer’s duration will be 30 seconds. |
   | **Timer Label Text** | Battle Starts In… | This is the display that will show on the HUD during the timer countdown. |
   | **Visible During Game** | No | This device is not visible during gameplay. |
   | **Start When Receiving From** | Channel 55 | Trigger #5 will activate this timer when the first player goes through the Teleporter at the end of the parkour race. |
   | **When Completed Transmit On** | Channel 30 | This is the signal that transmits to the Mutator Zone that will teleport players to the free-for-all arena. This signal will also disable multiple devices. |
3. Select **OK** to save and exit.

### Player Reference #1-4

[![Player Reference](https://dev.epicgames.com/community/api/documentation/image/8952c8fd-e22e-4a76-bb4b-01e8d0cbd476?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8952c8fd-e22e-4a76-bb4b-01e8d0cbd476?resizing_type=fit)

Use the **Player Reference** to serve as a middleman between devices and players. Since players cannot send signals on their own, the Player Reference serves as a representative to send signals to devices like the Teleporter.

To set up this device:

1. Equip and place a **Player Reference** in an area unseen by players.
2. Customize its settings as shown below.

   [![Modified Player Reference](https://dev.epicgames.com/community/api/documentation/image/1dd73953-cf5c-4573-b5dd-8669bddef1b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1dd73953-cf5c-4573-b5dd-8669bddef1b2?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible During Game** | Off | This device will not be visible in-game. |
   | **Play Audio** | No | This device will not play audio. |
   | **Register Player When Receiving From** | Channel 1 | The Player Spawn Pads placed in the beginning will send signals from Channel 1 to Channel 4. This channel will be incrementally increased for all four devices. This will also store the Player ID as an instigator to reference devices like the Teleporter. |
   | **Activate When Receiving From** | Channel 5 | Players who have not completed the race in time will be moved into the free-for-all arena after receiving a signal from this channel. |
   | **When Activated Transmit On** | Channel 6 | In the free-for-all arena, each player will have a teleporter that will move them to the arena from this channel if they have not completed the race. This setting will increase incrementally for each device, from Channel 6 to Channel 9. |
3. Select **OK** to save and exit.
4. Copy this device and place three more **Player Reference** devices adjacent to the first device.

   a. Incrementally increase the settings for **Register Player When Receiving From** from Channel 1 to Channel 4.

   b. Incrementally increase the settings for **When Activated Transmit On** from Channel 6 to Channel 9.

## Setting Up the free-for-all Arena

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/17cb7347-fcfe-4971-8cfe-8e30875ec28e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17cb7347-fcfe-4971-8cfe-8e30875ec28e?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

Players will either finish the race or spawn directly into the free-for-all arena. Players who finish the race first can use their Gold to get the best weapon. Teleported players who did not finish the race will have to purchase the lower-quality weapons left over.

In this section, you will use the following devices:

- 4 x Conditional Button
- 1 x Mutator Zone
- 1 x Class Selector
- 5 x Teleporter

### Conditional Button #1-4

[![Conditional Button](https://dev.epicgames.com/community/api/documentation/image/e3042a0a-6826-4e32-8e2c-b046aa8778c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3042a0a-6826-4e32-8e2c-b046aa8778c2?resizing_type=fit)

Use the **Conditional Button** to require Gold that triggers weapons from the Item Granter. The Conditional Button will require one Gold and deactivate immediately after use.

To set up this device:

1. Equip and place a **Conditional Button** in an area where players can purchase weapons.
2. Customize its settings as shown below.

   [![Modified Conditional Button](https://dev.epicgames.com/community/api/documentation/image/8768dd7a-b857-4a81-b7c1-47a677a2c74c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8768dd7a-b857-4a81-b7c1-47a677a2c74c?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Disable After Use** | Yes | The device will disable immediately after being used. |
   | **When Activated Transmit On** | Channel 20 | When this device is successfully activated, it will send a signal to one of the four Item Granters set up in the previous section. Each Conditional Button will have a unique channel from 20 to 23 that pairs with an Item Granter’s **Grant When Receiving From** channel. |
3. Select **OK** to save and exit.
4. Copy this device and place three more **Conditional Buttons** near the first device.

   a. Incrementally increase the settings for **When Activated Transmit On** from Channel 20 to Channel 23.

## Designer Tips

You can use **Vending Machines** as a way to display what the Conditional Button gives. These devices should be disabled while displaying a registered weapon. Give this device an impossible cost like 999 Metal to prevent usage.

[![Vending Machine Tip](https://dev.epicgames.com/community/api/documentation/image/4e8aa80d-3c87-45f5-ba17-27c58ffe4b30?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e8aa80d-3c87-45f5-ba17-27c58ffe4b30?resizing_type=fit)

### Mutator Zone #2

Use the Mutator Zone to prevent weapons from firing while it’s active. This device will be active until the free-for-all begins.

To set up this device:

1. Equip and place a **Mutator Zone** on the ground in the free-for-all arena’s center.
2. Customize its settings as shown below.

   [![Modified Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/fbafd45c-e056-4aaa-adec-3680f3c2ebe5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fbafd45c-e056-4aaa-adec-3680f3c2ebe5?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Zone Width** | 5 | This device’s zone will be large enough to cover the free-for-all arena. |
   | **Zone Depth** | 5 | This device’s zone will be large enough to fill the free-for-all arena. |
   | **Zone Height** | 13 | This device’s zone will be tall enough to fill the free-for-all arena. |
   | **Enable During Phase** | All | This device is active during any game phase. |
   | **Disable When Receiving From** | Channel 30 | This device will be disabled by the Timed Objective device in the previous section once the 30-second timer ends. |
3. Select **OK** to save and exit.

### Class Selector

[![Class Selector](https://dev.epicgames.com/community/api/documentation/image/844b796b-a1c2-4290-8303-2db6719dec33?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/844b796b-a1c2-4290-8303-2db6719dec33?resizing_type=fit)

Use the Class Selector as a zone to change the players’ class during the free-for-all arena. Changing the player’s class will allow them to teleport only once to the free-for-all arena.

To set up this device:

1. Equip and place a **Class Selector** on top of the second **Mutator Zone**.
2. Customize its settings as shown below.

   [![Modified Class Selector](https://dev.epicgames.com/community/api/documentation/image/18dd0428-38b8-4c95-8164-677430ee1ea0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/18dd0428-38b8-4c95-8164-677430ee1ea0?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Class to Switch to** | 2 | Players will be switched to Class ID 2. |
   | **Time to Switch** | Instant | There will be no delay in class switching. |
   | **Size of Volume** | 5 Meters | This device’s zone will be large enough to cover players as they teleport into the arena. |
   | **Volume Visible in Game** | Off | The volume VFX will not be seen during gameplay. |
   | **Visible During Game** | Off | This device will not be visible during gameplay. |
   | **Activation Audio** | Off | There will be no SFX made when the class is changed. |
   | **Zone Audio** | Off | There will be no SFX made from this device. |
   | **Display VFX On Activation** | No | There will be no visual element for players when Class IDs are swapped. |
   | **Disable When Receiving From** | Channel 35 | When players are teleported, teams will only be assigned once. There is a 10-second timer that teleports everyone who failed the race, changing them to Class ID 2. |
3. Select **OK** to save and exit.

### Teleporter #7

This teleporter is linked to the race arena as players teleport after finishing the race.

To set up this device:

1. Equip and place a **Teleporter** above the **Class Selector**, so players can fall into it.
2. Customize its settings as shown below.

   [![Modified Teleporter](https://dev.epicgames.com/community/api/documentation/image/4d27fb2e-9b97-47be-91e0-f9091b8ddcf1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d27fb2e-9b97-47be-91e0-f9091b8ddcf1?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Teleporter Target Group** | None | This device will not teleport players. |
   | **Teleporter Rift Visible** | No | The teleporter rift will not be visible in-game. |
   | **Play Visual Effects** | No | There will be no visual effects from this device. |
   | **Play Sound Effects** | No | This device will play no audio. |
   | **Conserve Momentum** | No | As players fall into the linked teleporter, their momentum will restart when exiting this teleporter. |
3. Select **OK** to save and exit.

### Teleporter #8-11

For players who have not finished the race, use four teleporters to manually transport them to the free-for-all arena. Each of these teleporters will be linked to the Player Reference device placed in the [Setting Up Background Devices](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-parkour-elimination-race-in-fortnite-creative) section.

To set up these devices:

1. Equip and place the **Teleporter** beside the one you last placed, inside the **Class Selector**’s volume.
2. Customize its settings as shown below.

   [![Modified Teleporter](https://dev.epicgames.com/community/api/documentation/image/c0bf2e70-0bff-4ef0-8600-69b3a23e2197?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c0bf2e70-0bff-4ef0-8600-69b3a23e2197?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Teleporter Group** | None | This device will not teleport players by entering. |
   | **Teleporter Target Group** | None | This device will not teleport players by entering. |
   | **Teleporter Rift Visible** | No | The teleporter rift will not be visible in-game. |
   | **Play Visual Effects** | No | There will be no visual effects from this device. |
   | **Play Sound Effects** | No | This device will play no audio. |
   | **Conserve Momentum** | No | The player’s momentum will restart when exiting this teleporter. |
   | **Affects Class** | Only Selected | Only the intended players assigned can use this teleporter. |
   | **Selected Class** | 1 | The assigned player can only teleport when their Class ID is set to 1. Entering the Class Selector in the free-for-all arena will switch players to Class ID 2. |
   | **Teleport to When Receiving From** | Channel 6 | Pair the Player Reference device’s **When Activated Transmit On** to this channel. This setting will increase incrementally for each device, from Channel 6 to Channel 9. |
3. Select **OK** to save and exit.
4. Copy and paste this device three more times inside the Class Selector's volume.

   a. Incrementally increase the settings for **Teleport to When Receiving From** from Channel 6 to Channel 9.

   [![free-for-all Arena](https://dev.epicgames.com/community/api/documentation/image/d7c5d7cb-3c49-49e1-8be0-afbfd255aa38?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d7c5d7cb-3c49-49e1-8be0-afbfd255aa38?resizing_type=fit)

## Setting Up the Respawn Rooms

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/8d5d4c0e-ac66-496e-888b-f8f18deb99e3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8d5d4c0e-ac66-496e-888b-f8f18deb99e3?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

When players are eliminated in the free-for-all portion of the gameplay, they will respawn in an area outside of battle. Create individual respawn rooms in an area immediately beside the free-for-all arena so players can quickly return to battle.

The respawn room is a safe zone for players before they return to battle. Players will respawn with their weapons and leave the respawn room to immediately return to the free-for-all.

In this section, you will use the following devices:

- 4 x Player Spawn Pad
- 8 x Trigger
- 4 x Lock

### Player Spawn Pad #5-8

Use Player Spawn Pads to respawn your players after elimination.

To set up this device:

1. Equip and place a **Player Spawn Pad** in the center of your respawn room.
2. Customize its settings as shown below.

   [![Modified Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/90b6727a-c1fe-424c-ba64-9330d9323e28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/90b6727a-c1fe-424c-ba64-9330d9323e28?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Priority Group** | 2 | These pads will not be used when one of a higher priority is enabled. When the countdown timer deactivates the first, Priority 1 pads, these will activate. |
   | **Visible in Game** | Off | This device’s base will not be visible in the game. |
3. Select **OK** to save and exit.
4. Copy this device and paste it three more times behind each door to the respawn room.

### Trigger#3-6

When players step in front of the door, it will swing open when triggered by this device.

To set up this device:

1. Equip and place a **Trigger** behind each door to the players’ respawn rooms.
2. Customize its settings as shown below.

   [![Modified Trigger](https://dev.epicgames.com/community/api/documentation/image/9b91e69b-1d3d-483e-a5f3-9ea9bbfa623c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9b91e69b-1d3d-483e-a5f3-9ea9bbfa623c?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Reset Delay** | 2 Seconds | This is the time that must pass before the trigger can be activated again. |
   | **Trigger Sound** | Disabled | There will be no audio from this device. |
   | **Trigger VFX** | Disabled | There will be no VFX from this device. |
   | **Visible in Game** | No | This device will not be visible during gameplay. |
   | **When Triggered Transmit On** | Channel 40 | This channel sends a signal to open and unlock the door when stepped on. This setting will increase incrementally for each device, from Channel 40 to Channel 43. |
3. Select **OK** to save and exit.
4. Copy this device and paste it three more times behind each door to the respawn room.

   a. Incrementally increase the settings for **When Triggered Transmit On** from Channel 40 to Channel 43.

### Trigger #7-10

These Triggers will automatically close and lock the respawn room doors once activated.

To set up this device:

1. Equip and place a **Trigger** anywhere in the respawn room.
2. Customize its settings as shown below.

   [![Modified Trigger](https://dev.epicgames.com/community/api/documentation/image/c58105c5-c34e-4ece-a0b4-13d07dca80c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c58105c5-c34e-4ece-a0b4-13d07dca80c7?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Trigger by Player** | Off | The player cannot activate this device, only a channel can. |
   | **Delay** | 2 Seconds | There will be a two-second delay before this device is triggered. |
   | **Reset Delay** | 2 Seconds | There will be a two-second delay before this device is activated again. |
   | **Trigger Sound** | Disabled | There will be no audio from this device. |
   | **Trigger VFX** | Disabled | There will be no VFX from this device. |
   | **Visible in Game** | No | This device will not be visible during gameplay. |
   | **Trigger when Receiving From** | Channel 40 | After a delay, the Triggers to open the door will send a signal to also close and lock the door. This setting will increase incrementally for each device, from Channel 40 to Channel 43. |
   | **When Triggered Transmit On** | Channel 44 | After a two-second delay, this sends a signal to close and activate the **Lock** device. This setting will increase incrementally for each device, from Channel 44 to Channel 47. |
3. Select **OK** to save and exit.
4. Copy this device and paste it three more times anywhere in the respawn room.
5. Each pair of Trigger devices assigned to a door will use two channels, one to open the door and one to close it. For each door, increment the settings for the pair of channels. For example, the next respawn room will use Channel 42 and Channel 45.

   a. Incrementally increase the settings for **Trigger when Receiving From** from Channel 40 to Channel 43.

   b. Incrementally increase the settings for **When Triggered Transmit On** from Channel 44 to Channel 47.

### Lock #1-4

[![Lock](https://dev.epicgames.com/community/api/documentation/image/30550ffd-6aef-4284-8fbc-8e249d23dbf2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/30550ffd-6aef-4284-8fbc-8e249d23dbf2?resizing_type=fit)

Use a Lock to automatically unlock and open, then close and lock, the respawn room doors. This will prevent spawn camping outside the free-for-all arena.

To set up this device:

1. Equip and place a **Lock** directly beside the door.

   a. The Lock will turn blue when it's correctly placed beside the door.
2. Customize its settings as shown below.

   [![Modified Lock](https://dev.epicgames.com/community/api/documentation/image/95cefe83-37b6-45c0-aab2-de907099db94?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/95cefe83-37b6-45c0-aab2-de907099db94?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible During Game** | Off | This device will not be visible during the gameplay. |
   | **Unlock when Receiving From** | Channel 40 | This device will unlock when stepping on the trigger in front of the door. |
   | **Lock when Receiving From** | Channel 41 | The delayed trigger will close and lock the door again. |
   | **Open When Receiving From** | Channel 40 | The door will open when stepping on the trigger. This setting will increase incrementally for each device, from Channel 40 to Channel 43. |
   | **Close When Receiving From** | Channel 41 | The delayed trigger will close the door. This setting will increase incrementally for each device, from Channel 44 to Channel 47. |
3. Select **OK** to save and exit.
4. Copy this device and paste it three more times directly beside the other doors in the respawn room.

   a. Incrementally increase the settings for **Open When Receiving From** from Channel 40 to Channel 43.

   b. Incrementally increase the settings for **Close When Receiving From** from Channel 44 to Channel 47.

## Customize the Island Settings

These settings will create a multi-round game that is won through 10 eliminations.

[![My Island Menus](https://dev.epicgames.com/community/api/documentation/image/0872a248-8dce-4594-8048-04b93199e865?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0872a248-8dce-4594-8048-04b93199e865?resizing_type=fit)

To modify gameplay settings, press the **TAB** key and click **MY ISLAND** at the top of the screen. From here, you can access the **GAME**, **SETTINGS**, and **UI** tabs.

### My Island - Game

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Teams** | Free For All | Every player will fight all other players. |
| **Team Size** | 4 | A maximum of four players can play this game mode. |
| **Default Class Identifier** | 1 | Sets the class for the teleportation check for players who have not cleared the map. |
| **Total Rounds** | 3 | There are three rounds for this game. |
| **End Game On Match Point Win** | Yes | If a player wins twice, they win overall gameplay. |
| **TIme Minute** | 10 Minutes | Each round will last 10 minutes. |
| **Win Condition** | Most Rounds Win | The player who wins the most rounds wins the game. |
| **Eliminations to End** | 10 | It takes 10 eliminations to win the free-for-all portion of the gameplay. |
| **Autostart** | 60 Seconds | The game will wait 60 seconds after at least two people join the game. |

### My Island - Settings

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Starting Shields** | 100% Shields | Players will spawn with full shields. |
| **Allow Overshield** | On | Players will have 50 Overshield. |
| **Infinite Ammo** | On | Players will have infinite ammo. |
| **Infinite Items** | Off | Players will not have infinite items. |
| **Allow Building** | None | Players cannot build on the map. |
| **Environmental Damage** | Off | Players cannot damage the environment. |
| **Start With Pickaxe** | No | Players will not be able to use their pickaxes to damage each other during the race. |
| **Eliminated Player’s Items** | Keep | Players will not lose their equipped weapons upon elimination. |
| **Allow Item Drop** | No | Players cannot drop items. |
| **Respawn Time** | 1 Second | It takes 1 second to respawn on elimination. |
| **Spawn Immunity Time** | 5 Seconds | Players are invulnerable for five seconds, or until they shoot after respawning. |
| **Allow Mantle** | On | Players can [mantle](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#mantle) during this gameplay. |
| **Allow Sprint** | On | Players can [sprint](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#sprint) during this gameplay. |
| **Allow Slide** | On | Players can [slide](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#slide) during this gameplay. |
| **Allow Shoulder Bashing `** | On | Players can [shoulder bash](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#shoulder-bash) during this gameplay. |
| **Glider Redeploy** | Off | The glider can not be used during this gameplay. |
| **Show Wood** | No | Wood resources will not be seen on the UI. |
| **Show Stone** | No | Stone resources will not be seen on the UI. |
| **Show Metal** | No | Metal resources will not be seen on the UI. |
| **Show Gold Resource Count** | On | Gold that players pick up will be shown. |

### UI

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Game Winner Display Time** | 3 Seconds | The winner's display time will be three seconds. |
| **Game Score Display Time** | 7 Seconds | The scoreboard will display for seven seconds. |
| **Round Winner Display Time** | 3 Seconds | The round winner will display for three seconds. |
| **HUD Info Type** | Score | The HUD tracks score to show progress, and displays the top three players. |
| **Max Trackers on HUD** | 1 | Only one HUD element is needed to show the score. |
| **Win Condition** | Eliminations | The round is won by achieving 10 eliminations. |
| **Tiebreaker 1** | Damage Dealt | The first tiebreaker will be the damage players have dealt. |
| **Tiebreaker 2** | Health | The second tiebreaker will be a player’s remaining health. |
| **Tiebreaker 3** | Damage Taken | The third tiebreaker will count the damage the players received. |
| **First Scoreboard Column** | Eliminations | The first scoreboard column will show a player’s eliminations. |
| **Second Scoreboard Column** | Eliminated | The second scoreboard column will show a player's elimination ratio. |

You have now completed recreating Parkour free-for-all.
