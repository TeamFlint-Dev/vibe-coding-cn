# Creature Rush

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/design-a-creature-rush-game-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:57:41.379317

---

This tutorial is a single-player combat game that utilizes **HUD Messages** and **Billboard** devices to create a narrative during gameplay.

Players in this game will experience both internal and external dialogue as they shoot their way to victory, eliminating creatures that become become harder to fight over time,

Currently, only games with multiple players can set win/lose conditions for the end-of-round settings. Since this is a single-player game, players will achieve a victory even if they are eliminated.

Use this template if you want to learn how to use informational devices to creatively communicate game rules, storylines, and internal dialog to players. This template is also good for creating hoard-and-aim training games.

The sample island code for this tutorial is **9100-1332-5260**.

To play through this island, click **CHANGE** in the **Fortnite Lobby** screen. On the Discover screen, click the **Island Code** tab and enter the code for Creature Horde. Once you've seen all the gameplay features, you can explore this tutorial and recreate it on your own island.

## Devices Used

These devices were used for this island tutorial:

- 1 x [Pop-up Dialog device](https://dev.epicgames.com/documentation/en-us/fortnite/using-popup-dialog-devices-in-fortnite-creative)
- 1 x [Class Designer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative)
- 1 x [Conditional Button device](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative)
- 2 x [Creature Spawner devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative)
- 1 x [Timer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative)
- 1 x [Damage Amplifier Powerup device](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-amplifier-powerup-devices-in-fortnite-creative)
- 2 x [Elimination Manager devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-elimination-manager-devices-in-fortnite-creative)
- 1 x [End Game device](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative)
- 1 x [Health Powerup device](https://dev.epicgames.com/documentation/en-us/fortnite/using-health-powerup-devices-in-fortnite-creative)
- 1 x [HUD Controller device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative)
- 4 x [HUD Message devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)
- 4 x [Item Spawner devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative)
- 1 x [Mutator Zone device](https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative)
- 1 x [Player Spawn Pad device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 2 x [Random Number Generator devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-random-number-generator-devices-in-fortnite-creative)
- 5 x [Trigger devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)

## Props, Prefabs, and Galleries

A variety of **Prefab** and **Gallery** items were used to design this island. When recreating this island, test your creativity by envisioning a theme while mixing and matching items from various categories.

Be sure to fill any open areas with appealing props and terrains like grass and trees.

## Overview of Tutorial Steps

Following is an overview of the steps you'll need to recreate this island and their ideal sequence:

1. Create a new island using a [starter island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#starter-island).
2. Customize the island settings.
3. Set up your island structure, such as an [arena](https://dev.epicgames.com/documentation/en-us/fortnite/building-arenas-in-fortnite-creative), using prefabs and galleries.
4. Set up the starting area.
5. Set up the enemy devices.
6. Set up the background devices.
7. Set up the end game devices.

## Create Your Island

To build your island, use the following steps.

1. Find your [personal rift](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#personal-rift) in the main [hub](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hub). Your personal rift will have a golden glow.

   [![Game Creation Window](https://dev.epicgames.com/community/api/documentation/image/da450765-d190-41d5-be5a-70fe39128c8d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da450765-d190-41d5-be5a-70fe39128c8d?resizing_type=fit)
2. Use the console next to your rift to create a new island. Press **E** to enter the **GAME CREATION** screen and select **CREATE NEW**. This displays the **Select Type** dialog.

   [![Select Island Grid](https://dev.epicgames.com/community/api/documentation/image/bb530f6b-8dd6-49c3-862c-12d53fedae91?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb530f6b-8dd6-49c3-862c-12d53fedae91?resizing_type=fit)
3. Under the tab **STARTER ISLAND**, there are three grid islands that vary by memory allocation (GRID ISLAND, LARGE GRID ISLAND, or XL GRID ISLAND). For this tutorial, any of these will do.
4. After you select **CONFIRM**, choose a name for your island, then select **CONFIRM** again.

The portal will automatically load and teleport you into the island.

Check out these short [video tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials) to learn more about the beginning steps to create your island.

## Customize the Island Settings

These settings will create a single-player game where elimination stats are tracked on the HUD.

[![My Island Menus](https://dev.epicgames.com/community/api/documentation/image/6186a5fb-2f36-4d63-8226-7e8b701c8a13?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6186a5fb-2f36-4d63-8226-7e8b701c8a13?resizing_type=fit)

To modify gameplay settings, press the **TAB** key and click **MY ISLAND** at the top of the screen. From here, you can access the **GAME**, **SETTINGS**, and **UI** tabs.

### My Island - Game

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Max Players** | 1 | There will only be one player in this game mode. |
| **Spawn Limit** | 1 | The player can only spawn one time. |
| **Default Class Identifier** | 1 | This sets the class that grants the initial weapon upon spawning. |

### My Island - Settings

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Infinite Ammo** | On | The player will not have to pick up ammo. |
| **Allow Building** | None | There is no building in this game mode. |
| **Environment Damage** | Off | Damage from guns cannot destroy the environment. |
| **Start With Pickaxe** | No | The player will not need pickaxes for this game mode. |
| **Allow Slide** | On | The player can perform the [slide](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#slide) maneuver. |

### My Island - UI

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **HUD Info Type** | AI Enemy Elimination | The HUD will track enemy eliminations. |
| **Max Trackers On HUD** | 3 | There will be three HUD trackers. |
| **Win Condition** | Score | The end-game screen will show the player's ending score. |
| **First Scoreboard Column** | Score | The first HUD tracker will show the player's score. |
| **Second Scoreboard Column** | AI Eliminations | The second HUD tracker will show the creature eliminations. |
| **Third Scoreboard Column** | Time Alive | The third HUD tracker will show the player's time alive. |
| **Map Screen Display** | Scoreboard | The scoreboard is displayed if the player brings up the map screen. |

## Setting Up Your Island Structure

A mixture of Prefab and Gallery pieces were used to create this island. Check out [Building Arenas](https://dev.epicgames.com/documentation/en-us/fortnite/building-arenas-in-fortnite-creative) to learn more about building indoor and open arenas.

Creature Horde is an open outdoor arena with boundaries created by **Barriers**. These barriers were used along with decorative prop pieces to guide the player from one end of the island to another.

## Setting Up the Starting Area

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/cf54345a-1191-46f7-b735-a71f18e0c3e6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf54345a-1191-46f7-b735-a71f18e0c3e6?resizing_type=fit)

*Use this image as a visual reference on device placement and creative possibilities.*

The starting area is where the player will initially spawn onto the island. When the player spawns, a pop-up displays before they can move.

In this section, you will use the following devices:

- **Player Spawn Pad**
- **Pop-Up Dialog**
- **Class Designer**
- **HUD Controller**

### Player Spawn Pad

[![Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/1f76be62-2962-4f03-978d-e71ba47115ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1f76be62-2962-4f03-978d-e71ba47115ae?resizing_type=fit)

The player will initially spawn through the **Player Spawn Pad**. Once spawned, the Player Spawn Pad will transmit a signal to different devices.

To set up this device:

1. Press the **Tab** key to open the **Creative** menu, then click the **Devices** tab.
2. Locate **Player Spawn Pad**. Click **PLACE NOW**, then place the spawn pad onto your island.
3. Customize its options as shown below.

   [![Modified Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/c41a915c-bf40-434d-bc31-84441638ae1f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c41a915c-bf40-434d-bc31-84441638ae1f?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible During Games** | No | This device is not visible during games. |
   | **When Players Spawned Transmit On** | Channel 1 | When players spawn, a signal will be sent to the **Pop Up Dialogue** and **Class Designer** devices to activate. |
4. Click **OK** to save your options.

### Pop-Up Dialog

[![Pop-Up Dialog](https://dev.epicgames.com/community/api/documentation/image/7ec1af57-c930-41a1-8af6-6362316fe162?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7ec1af57-c930-41a1-8af6-6362316fe162?resizing_type=fit)

The **Pop-Up Dialog** displays a custom message when activated by another device. Once the player spawns, this device will display an informative message that directs a player to their objective.

To set up this device:

1. Equip and place the Pop-Up Dialog device on the ground.
2. Customize its options as shown below.

   [![Modified Pop-Up Dialog](https://dev.epicgames.com/community/api/documentation/image/f79a467a-2dec-451a-b4c5-0637833d7430?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f79a467a-2dec-451a-b4c5-0637833d7430?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Title** | Insert text | Write a text to display a title for your message. |
   | **Description** | Insert text | Write the game rules and expectations for the player. |
   | **Timeout Duration** | 5 Seconds | This is how long players will have to interact with the dialog options. |
   | **Response Type** | 1 Button | The player will only have one interaction button, which says "Ok". |
   | **Show When Receiving From** | Channel 1 | The Player Spawn Pad sends a signal for the dialog to pop up. |
3. Click **OK** to save your options.

[![Pop-Up Message](https://dev.epicgames.com/community/api/documentation/image/96020f1c-f0ce-4d4f-8997-03a245b24a04?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96020f1c-f0ce-4d4f-8997-03a245b24a04?resizing_type=fit)

### Class Designer

[![Class Designer](https://dev.epicgames.com/community/api/documentation/image/ad88e1fe-3867-4b2e-b62c-b9cd0643939f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad88e1fe-3867-4b2e-b62c-b9cd0643939f?resizing_type=fit)

You can set the **Class Designer** to assign weapons to players based on their [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class).

To set up this device:

**Dual Fiend Hunters** were used in Creature Horde.

1. Equip and place the Class Designer on the ground.
2. Equip a weapon that fits with your gameplay.
3. Stand beside the Class Designer and drop the weapon on it from your [PLAY inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#play-inventory).
4. Customize its option as shown below.

   [![Modified Class Designer](https://dev.epicgames.com/community/api/documentation/image/aad1321e-ad41-4462-82b3-eb342af6dbad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aad1321e-ad41-4462-82b3-eb342af6dbad?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Class Identifier** | 1 | The device's registered items will be granted to players of this class. |
5. Click **OK** to save your options.

### HUD Controller

[![HUD Controller](https://dev.epicgames.com/community/api/documentation/image/1635f648-4f7c-41eb-b761-8ce86adf5391?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1635f648-4f7c-41eb-b761-8ce86adf5391?resizing_type=fit)

Use the **HUD Controller** to change what information displays for players. This device can remove the minimap so the player can see enemies unobstructed.

To set up this device:

1. Equip and place the HUD Controller on the ground.
2. Customize its options as shown below.

   [![Modified HUD Controller](https://dev.epicgames.com/community/api/documentation/image/f3a0e4a6-2bc3-49f5-b2db-06a18940453f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f3a0e4a6-2bc3-49f5-b2db-06a18940453f?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Show Minimap** | No | The minimap is removed from the player's HUD. |
3. Click **OK** to save your options.

## Designer Tips

You can set the Pop-Up Dialog to send a signal once the player interacts with a dialog button. You can set both buttons to have individual text and transmit signals once interacted with.

## Setting Up Enemy Devices

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/8d4848a1-cf22-4bc1-8b48-6baefb38b705?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8d4848a1-cf22-4bc1-8b48-6baefb38b705?resizing_type=fit)

*Use the image as a visual reference on device placement and creative possibilities.*

There are various creatures that spawn for the player to eliminate. You can set these creatures to also spawn behind where the players walk so that they can battle from various directions.

In this section you will use the following devices:

- **Creature Spawner**
- **Mutator Zone**
- **Timer**

### Creature Spawners 1-2

[![Creature Spawner](https://dev.epicgames.com/community/api/documentation/image/ce4165de-1783-4e9e-b62d-0ae29f045aaf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce4165de-1783-4e9e-b62d-0ae29f045aaf?resizing_type=fit)

Set creatures to initially spawn in small groups with a low spawn limit to match. As the game progresses, spawn creatures with various wave times in larger amounts. You can set spawn limits to control the disbursement of enemies.

To set up these devices:

1. Equip and place the Creature Spawner on the ground.

   Place Creature Spawners with enough space for creatures to spawn in your arena. If your arena has close walls or barriers as a boundary, creatures may spawn outside if placed too close.
2. Customize the first device as shown below.

   [![Modified Creature Spawner](https://dev.epicgames.com/community/api/documentation/image/2f0b8835-702f-456b-9b0f-548d69a7e80a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f0b8835-702f-456b-9b0f-548d69a7e80a?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Creature Type** | Fiend | Pick a creature you want your player to fight. Try using a mixture of creatures as you place these devices. |
   | **Number Of Creatures** | 5 | This is the amount of creatures that can spawn at one time. Try increasing this setting as the player progresses. |
   | **Total Spawn Limit** | 10 | This is the max number of creatures this device can spawn. Try increasing this setting as the player progresses. |
   | **Wave Timer** | 5 Seconds | This is how long the device has to spawn the next round of creatures. Decrease this setting to make a more challenging gameplay. |
   | **Activation Range** | 4 Tiles | This device will activate once the player is four tiles away. Decrease this setting as the gameplay progresses. |
   | **Despawn Range** | 5 Tiles | Once the player is five tiles away, creatures will despawn. Increase this setting as the gameplay progresses. |
   | **Spawner Visibility** | Off | The player will not see the spawner. |
   | **Damage Spawner After Spawn** | Off | Since the **Total Spawn Limit** is set, there is no need to slowly destroy the spawner. |
   | **Destroy Structures at Spawn Location** | Off | Structures will not be affected by creature spawning. |
   | **Spawn Effects Visibility** | Off | The spawner will not display visual effects. |
   | **Max Spawn Distance** | 1 Tile | Creatures can spawn one tile away from the device. |
   | **Spawn Through Walls** | Off | Use this setting for structured arenas with walls from the **Galleries** tab. Creatures will not spawn through walls. Creatures can still spawn through barriers. |
   | **Preferred Spawn Location** | Random | Creatures will spawn in random locations. |
3. Place as many Creature Spawners as your gameplay calls for with various combinations of creature spawns and wave timers.
4. Head to the final location of your arena to place the second Creature Spawner. These creatures will be the boss enemies and drop Cube Monster Parts when eliminated.
5. Customize its settings as shown below.

   [![Modified Creature Spawner Boss](https://dev.epicgames.com/community/api/documentation/image/7cc4f497-1d53-4825-9c46-65038d3b615f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7cc4f497-1d53-4825-9c46-65038d3b615f?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Creature Type** | Megabrute | This is a harder creature for the player to battle. |
   | **Number Of Creatures** | 2 | There will be two creatures that spawn due to their difficulty. |
   | **Total Spawn Limit** | 2 | The device will stop spawning after two creatures. |
   | **Activation Range** | 1 Tile | This device will activate when the player is one tile away. |
   | **Spawner Visibility** | Off | The player will not see this spawner. |
   | **Damage Spawner After Spawn** | Off | Since the **Total Spawn Limit** is set, there is no need to slowly destroy the spawner. |
   | **Destroy Structures at Spawn Location** | Off | Structures will not be affected by creature spawning. |
   | **Spawn Effects Visibility** | Off | The spawner will not display visual effects. |
   | **Max Spawn Distance** | 1 Tile | Creatures can spawn one tile away from the device. |
   | **Spawn Through Walls** | Off | Use this setting for structured arenas with walls from the **Galleries** tab. Creatures will not spawn through walls. |
   | **When a Creature is Eliminated Transmit On** | Channel 7 | Eliminating these creatures will send a signal to the **Elimination Manager**, which will drop an item for players to pick up. |
6. Click **OK** to save your options.

### Mutator Zone

[![Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/c86d22f5-7728-44e1-93e2-5bdac96343b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c86d22f5-7728-44e1-93e2-5bdac96343b1?resizing_type=fit)

You can use the **Mutator Zone** to apply a variety of effects to players and creatures who enter the area. For this gameplay, use Mutator Zones to serve as a trigger that sends a signal to another device once the player enters it.

To set up this device:

1. Locate and place the Mutator Zone on the ground.

   Place the device in a spot where you want players to trigger devices.
2. Customize its options as shown below.

   [![Modified Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/de3ae684-5003-4e51-8bcc-2b16441ac570?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de3ae684-5003-4e51-8bcc-2b16441ac570?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Allow Weapon Fire** | Yes | Players can fire weapons while inside this device's zone. |
   | **Zone Depth** | 5 | Use this setting to create a width wide enough for your players to trigger. |
   | **Affects Creatures** | No | This device does not affect creatures. |
   | **Disable When Receiving From** | Channel 2 | Once the player triggers this device, it will be disabled from further use. |
   | **On Player Exiting Zone Transmit On** | Channel 2 | This device will disable after players leave it's zone. |
3. Click **OK** to save your options.

## Designer Tips

Creature Horde uses internal dialogue that triggers when players reach a certain area. You can set the Mutator Zone to trigger HUD messages to appear on screen for the player. Set a **HUD Message** device to the same channel as the Mutator Zone to display messages or even internal dialogue.

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/e43910d7-84f9-4a1b-97b5-67e5e4ccbcf8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e43910d7-84f9-4a1b-97b5-67e5e4ccbcf8?resizing_type=fit)

### Timer

[![Timer](https://dev.epicgames.com/community/api/documentation/image/2d6f5fa9-fe7d-4ef1-abc3-6e45577d726d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d6f5fa9-fe7d-4ef1-abc3-6e45577d726d?resizing_type=fit)

Set the Mutator Zone to the same channel as a **Timer** to make the creatures to spawn after a certain amount of time. You can set a second Creature Spawner to enable behind the player, spawning seconds after they enter the Mutator Zone. This can be done so the player must battle from multiple directions.

To set up this device:

1. Locate and place the Timer on the ground.
2. Customize its options as shown below.

   [![Modified Timer](https://dev.epicgames.com/community/api/documentation/image/5e256544-65a6-48fb-ab68-1c39000e0077?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5e256544-65a6-48fb-ab68-1c39000e0077?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Duration** | 4 Seconds | After four seconds, a second Creature Spawner will activate. |
   | **Visible During Game** | No | This device should not be visible for this gameplay. |
   | **Show on HUD** | No | The timer should not be visible for this gameplay. |
   | **Start When Receiving From** | Channel 2 | The timer starts after leaving the Mutator Zone, which will automatically disable from triggering this device again. |
   | **On Success Transmit On** | Channel 3 | Once the timer finishes, it will send a signal to activate another Creature Spawner. Set the Creature Spawner to be enabled once receiving a signal on this channel. |
3. Click **OK** to save your options.

Place a combination of the devices from this section to create [gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gameplay) where the player encounters more enemies as they progress forward. These enemies could randomly spawn in various directions after being triggered by the player.

You can also use [Creature Placers](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-placer-devices-in-fortnite-creative) instead of Creature Spawners to place individual enemies.

## Setting Up Background Devices

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/3471fef9-0b08-43f0-b87e-2af393b12796?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3471fef9-0b08-43f0-b87e-2af393b12796?resizing_type=fit)

*Use the image as a visual reference on device placement and creative possibilities.*

The background devices for this gameplay trigger text callouts from an enemy's elimination. Through this device, there is a 33 percent chance that a creature's elimination will trigger a text. When that text appears, four options can be displayed.

Set up these devices in an isolated area where the player cannot see.

In this section, you will use the following devices:

- **Elimination Manager**
- **Random Number Generator**
- **Trigger**
- **HUD Message Device**

### Elimination Managers 1-2

[![Elimination Manager](https://dev.epicgames.com/community/api/documentation/image/cdb60a06-423e-4c18-8821-0cd528e58735?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cdb60a06-423e-4c18-8821-0cd528e58735?resizing_type=fit)

Use the **Elimination Manager** to set the conditions when a player or creature is eliminated. In this gameplay, the Elimination Manager sends a signal to a different device every time a creature is eliminated.

To set up these devices:

1. Locate and place the Elimination Manager on the ground.
2. Customize its options as shown below.

   [![Modified Elimination Manager](https://dev.epicgames.com/community/api/documentation/image/b9d15c36-6aeb-4339-b3c9-c72b3943186c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9d15c36-6aeb-4339-b3c9-c72b3943186c?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Target Type** | All Creatures | Since a variation of creatures may be used in this gameplay, set this setting to affect all creatures. |
   | **When Eliminated Transmit On** | Channel 4 | When creatures are eliminated, a signal will be sent to the Random Number Generator that rolls for if a message will be displayed or not through the HUD Message device. |
3. Place a second Elimination Manager near the Creature Spawner that spawns the boss enemies.
4. Find and equip the [Cube Monster Parts](https://dev.epicgames.com/documentation/en-us/fortnite/using-crafting-items-in-fortnite-creative) item.

   From the **PLAY** inventory, drag and drop the [item](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) onto the Elimination Manager.
5. Customize its settings as shown below.

   [![Second Modified Elimination Manager](https://dev.epicgames.com/community/api/documentation/image/2a8dd5c9-687a-4ac1-ac8a-6b3e7c372e49?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a8dd5c9-687a-4ac1-ac8a-6b3e7c372e49?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Number of Items Dropped** | 1 | One item will drop when a creature is eliminated. |
   | **Target Type** | Megabrute | The settings from this device only affect Megabrute creatures. |
   | **Enable When Receiving From** | Channel 7 | Set the paired Creature Spawner to send a signal upon elimination to this channel. This device will not activate until the last horde and will not affect other Megabrutes if they may spawn earlier. |
6. Click **OK** to save your options.

### Random Number Generators 1-2

[![Random Number Generator](https://dev.epicgames.com/community/api/documentation/image/61b6c1e8-6740-468d-966e-55ac3841ebf6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/61b6c1e8-6740-468d-966e-55ac3841ebf6?resizing_type=fit)

Use the **Random Number Generator** to generate random numbers that can transmit signals to receiving channels. In this gameplay, whenever a creature is eliminated, the Elimination Manager sends a signal to the Random Number Generator. A pair of these devices creates a system that rolls for a 33 percent chance of hitting a trigger that displays one out of four messages.

To set up these devices:

1. Locate and place the Random Number Generator on the ground.
2. Customize its options as shown below.

   [![Modified Random Number Generator](https://dev.epicgames.com/community/api/documentation/image/c55b3e91-0268-45fe-b120-8c6db1cd1bfb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c55b3e91-0268-45fe-b120-8c6db1cd1bfb?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Value Limit 2** | 3 | The device can roll up to three. |
   | **Roll Time** | Instant | The device will instantly calculate the result. |
   | **Zone** | Forward | The device's sequencer will move forward to trigger the winning device. |
   | **Length** | 3 | The device's sequencer will be three spaces long. |
   | **Play Audio** | No | No audio will play from this device. |
   | **Activate When Receiving From** | Channel 4 | When a creature is eliminated, the Elimination Manager sends a signal to this device. |
3. Click **OK** to save your options.

Place a second Random Number Generator to receive a signal when the sequencer lands on a**Trigger**. When the second RNG is activated, it will roll to activate one of the four HUD Messages.

To set up the second device:

1. Place the Random Number Generator beside the existing one.
2. Customize its options as shown below.

   [![Second Modified Random Number Generator](https://dev.epicgames.com/community/api/documentation/image/5558dbe9-8d7b-4ac6-8679-422a1bc701cc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5558dbe9-8d7b-4ac6-8679-422a1bc701cc?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Value Limit 2** | 4 | The device can roll to the maximum number of four. |
   | **Roll Time** | Instant | The device will instantly calculate the result. |
   | **Zone** | Forward | The device’s sequencer will move forward. |
   | **Activate When Receiving From** | Channel 5 | This device will activate when the Trigger from the first Random Number Generator is activated. |
3. Click **OK** to save your options.

### Triggers 1-5

[![Trigger](https://dev.epicgames.com/community/api/documentation/image/cd97e232-ceca-46a9-a2c2-15859b4b4ca5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cd97e232-ceca-46a9-a2c2-15859b4b4ca5?resizing_type=fit)

If the first Random Number Generator's sequencer lands on the third space, it will hit a Trigger that will send a signal to the second RNG device.

To set up this device:

1. Locate and place the trigger in the third space of the first sequencer.
2. Customize its options as shown below:

   [![Modified Trigger](https://dev.epicgames.com/community/api/documentation/image/3aaa7b93-e2eb-4c1a-940a-fdd404692e35?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3aaa7b93-e2eb-4c1a-940a-fdd404692e35?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Trigger Sound** | Disabled | There will be no audio from this device. |
   | **When Triggered Transmit On** | Channel 5 | When the Random Number Generator hits the trigger, it will send a signal to the second Random Number Generator, which will roll for one of the four messages. |
3. Click **OK** to save your options.

For each space on the second Random Number Generator's sequencer, place both a Trigger and a HUD Message device. This is the last part of the system that will display a HUD message whenever a creature is eliminated. Each time the sequencer lands on one of the spaces, a trigger will signal for a customized message to be displayed.

To set up the second through fifth devices:

1. Place a Trigger in each square of the second Random Number Generator.
2. Customize their options as shown below.

   [![Second Modified Trigger](https://dev.epicgames.com/community/api/documentation/image/7a93527a-3b47-42e2-8498-ba01401aadb3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a93527a-3b47-42e2-8498-ba01401aadb3?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Trigger Sound** | Disabled | There will be no audio from this device. |
   | **When Triggered Transmit On** | Channel 6 | Make sure to use an empty channel for each pair of devices. Pair these channeld to be received from a HUD Message device. |
3. Click **OK** to save your options.

### HUD Message Devices 1-4

1. Equip and place a HUD Message device in each square of the second Random Number Generator, beside the triggers.
2. Customize its setting as shown below.

   [![Second Modified HUD Message](https://dev.epicgames.com/community/api/documentation/image/2faee20b-6074-40e9-bbf7-dc128ca0cebb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2faee20b-6074-40e9-bbf7-dc128ca0cebb?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | Insert Text | Type a custom callout for each device. |
   | **Time From Round Start** | Off | This device will have to be triggered to activate. |
   | **Display Time** | 1 Second | This callout will only last one second. |
   | **Text Style** | Large | The text style will be large. |
   | **Play Sound** | None | This device will not have audio. |
   | **Show When Receiving From** | Channel 6 | If the Random Number Generator lands on a trigger, it will play the paired HUD message. For this setting, each channel should match the trigger it's beside. |
3. Click **OK** to save your options.

[![Creature Horde Gameplay](https://dev.epicgames.com/community/api/documentation/image/fd6aaa46-b9d7-4138-9d3d-5a0791a36317?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fd6aaa46-b9d7-4138-9d3d-5a0791a36317?resizing_type=fit)

## Setting Up End Game Devices

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/8886bab7-627d-43ba-a31f-fadad5726b58?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8886bab7-627d-43ba-a31f-fadad5726b58?resizing_type=fit)

*Use the image as a visual reference on device placement and creative possibilities.*

The gameplay ends with the two boss creatures you placed earlier. These creatures will drop **Cube Monster Parts** when eliminated. Players will insert these items into the Conditional button, which will send a signal to the **End Game** device once the items are consumed.

In this section, you will use the following devices:

- **Conditional Button**
- **End Game**

### Conditional Button

[![Conditional Button](https://dev.epicgames.com/community/api/documentation/image/156c047b-90a9-4f33-b8b5-a40b041351e5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/156c047b-90a9-4f33-b8b5-a40b041351e5?resizing_type=fit)

You can modify the **Conditional Button** to activate when players are carrying registered items. When activated, this device can transmit a signal to a receiving device.

To set up this device:

1. Equip and place the device on your island.
2. Customize its settings as shown below.

   [![Modified Conditional Button](https://dev.epicgames.com/community/api/documentation/image/c0cc19ac-fe15-4aa3-92b5-5da776286b5d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c0cc19ac-fe15-4aa3-92b5-5da776286b5d?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Interact Time** | 3 Seconds | It takes three seconds for the player to interact with this device. |
   | **Interaction Text** | Insert Text | Insert a text to display when the player interacts with this device. |
   | **Missing Items Text** | Insert Text | Aid your players by directing them to find the missing items. |
   | **Remain Unlocked After Activation** | On | This device does not need to be locked again. |
   | **Show Key Item** | Key and Icon | Both the necessary item and the icon will display from this device. |
   | **Interaction Target Size** | .75M | The player can interact .75 meters from this device. |
   | **When Activated Transmit On** | Channel 8 | When this device is activated, it send a signal to end the game. |
3. Click **OK** to save your options.

## Designer Tip

[![Designer Tip](https://dev.epicgames.com/community/api/documentation/image/f17e373c-0dba-4f71-a79d-6898ba37b97a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f17e373c-0dba-4f71-a79d-6898ba37b97a?resizing_type=fit)

To strengthen your gameplay design, use props from the **Prefabs** and **Galleries** tabs to blend with the **Conditional Button**. Place the **Conditional Button** inside a prop so that only its image will show.

### End Game Device

[![End Game](https://dev.epicgames.com/community/api/documentation/image/01b59a41-31ec-4cd4-8c3e-191aed42f93c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/01b59a41-31ec-4cd4-8c3e-191aed42f93c?resizing_type=fit)

You can set devices like the Conditional Button to transmit a signal for the End Game device to activate. Once activated, this device can end the game.

To set up this device:

1. Equip and place the End Game device beside the Conditional Button.
2. Customize its settings as shown below.

   [![Modified End Game](https://dev.epicgames.com/community/api/documentation/image/0bd61d7f-a478-4ba1-8e8b-82d0b6b55dd3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0bd61d7f-a478-4ba1-8e8b-82d0b6b55dd3?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Activate When Receiving From** | Channel 8 | This device will activate after receiving a signal from the Conditional Button. |
3. Click **OK** to save your options.

You have successfully designed your own creature rush game.
