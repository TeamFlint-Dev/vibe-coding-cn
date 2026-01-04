# Elimination Game

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-an-elimination-game-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:58:27.528222

---

**Elimination Game** is a 12-player free-for-all where players battle for the most eliminations with a rotating loadout. This tutorial will teach you how to change players’ inventories and health upon elimination.

The island code for this tutorial is **7796-9889-1590**.

To play through this island, click **CHANGE** on the **Fortnite Lobby** screen. On the **Discover** screen, click the **Island Code** tab and enter the code for **Design a Prop Hunt Game**. Once you've seen all the gameplay features, you can explore this tutorial and recreate it on your island.

## Props, Prefabs, and Galleries

A variety of [Prefab](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prefab) and [Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gallery) items were used to design this island. When recreating this island, test your creativity by envisioning a theme while mixing and matching items from various categories.

Be sure to fill open areas with appealing props that match your island's theme.

Read the prerequisite tutorials to learn how to use Gallery pieces to build pre-game lobbies and arenas.

## Overview of Tutorial Steps

The following is an overview of the steps you will need to recreate this island and its ideal sequence:

1. Create a new island using a [starter island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#starter-island).
2. Set up your island structure, such as an [arena](https://dev.epicgames.com/documentation/en-us/fortnite/building-arenas-in-fortnite-creative).
3. Set up the [pre-game lobby](https://dev.epicgames.com/documentation/en-us/fortnite/building-pregame-lobbies-in-fortnite-creative).

## Set up the Team Settings

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/3c9d0f55-81d5-4fdd-ba7e-94aa47bad1bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c9d0f55-81d5-4fdd-ba7e-94aa47bad1bc?resizing_type=fit)

*Use the photo as a visual reference for device placement and creative possibilities.*

You will learn how to set up the devices that rotate weapons for each player as they make eliminations.

In this section, you will use the following devices:

12 x **[Team Settings and Inventory devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-team-settings-and-inventory-devices-in-fortnite-creative)**

12 x **[Item Granter devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)**

12 x **[Health Powerup devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-health-powerup-devices-in-fortnite-creative)**

### Team Settings & Inventory 1-12

[![Team Settings and Inventory](https://dev.epicgames.com/community/api/documentation/image/c77853c2-cb50-4904-ad01-e498486243ee?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c77853c2-cb50-4904-ad01-e498486243ee?resizing_type=fit)

Link a **Team Settings & Inventory** device to each player. Each time a player eliminates another, the Team Settings & Inventory sends a signal to the Item Granter, which cycles through granted weapons.

To set up this device:

1. Equip and place a Team Settings & Inventory in an area unseen by players.
2. Customize its settings as shown below:

   [![Modified Team Settings and Inventory](https://dev.epicgames.com/community/api/documentation/image/af4e2898-88b6-4123-bafd-436c285af3cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/af4e2898-88b6-4123-bafd-436c285af3cb?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Team** | Team 1 - Team 12 | Determines which team each player belongs to. Incrementally increase this setting from Team 1 to Team 12 for each device placed. |
   | **Equip Granted Item** | First Item | Equips the first registered item. |
   | **When Enemy Eliminated By Team Member Transmit On** | Channel 1 - Channel 12 | Causes a unique signal to go out to the Item Granter each time an enemy is eliminated. |
3. Click **OK** to save.
4. Copy and place this device 11 times.

   a. For each device, incrementally increase the setting **Team** so that each device ranges from Team 1 to Team 12.

   b. For each device, incrementally increase the channel for **When Enemy Eliminated By Team Member Transmit On** so that each device ranges from Channel 1 to Channel 12.
5. Drag and drop the player’s first weapon onto the device. The players will load into the game with this weapon.

### Item Granter #1-12

[![Item Granter](https://dev.epicgames.com/community/api/documentation/image/e82996bc-7fb2-46b2-881c-9ce093069a39?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e82996bc-7fb2-46b2-881c-9ce093069a39?resizing_type=fit)

Use a combination of easy-to-use weapons, fun weapons, and challenging weapons to offer players through the **Item Granter**. Offering these combinations of weapons allows for a more extended gameplay due to difficulty. The further a player progresses, the worse the weapons awarded should be. Use the last weapon as an extended challenge, especially for 1-1 fights like pistols.

To set up this device:

1. Equip and place an Item Granter in front of the first Team Settings & Inventory device.
2. Customize its settings as shown below.

   [![Modified Item Granter](https://dev.epicgames.com/community/api/documentation/image/994fd938-f05f-4d9e-acf6-38e58b2572d9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/994fd938-f05f-4d9e-acf6-38e58b2572d9?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Equip Granted Item** | First Item | This device will automatically equip each granted item. |
   | **Cycle To Next Item When Receiving From** | Channel 1 - Channel 12 | When this device receives a signal from an elimination, the device will switch registered weapons and equip it. This setting will increase incrementally for each device, matching the **When Enemy Eliminated By Team Member Transmit On** setting of the Team Settings & Inventory beside it, from Channel 1 to Channel 12. |
3. Click **OK** save.
4. Equip and drop 20 weapons in order of how they will be awarded to players onto the Item Granter.
5. Copy and paste this device 11 times.

   a. For each device, incrementally increase the channel for **Cycle To Next Item When Receiving From** so that each device ranges from Channel 1 to Channel 12. Each device’s setting should match the **When Enemy Eliminated By Team Member Transmit On** setting of the Team Settings & Inventory beside it.

### Health Powerup #1-12

[![Health Powerup](https://dev.epicgames.com/community/api/documentation/image/b4101371-47d3-46b3-aca3-91b51670da17?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b4101371-47d3-46b3-aca3-91b51670da17?resizing_type=fit)

When a player makes an elimination, use a **Health Powerup** to regenerate their shields.

To set up this device:

1. Equip and place a Health Powerup beside the first Item Granter.
2. Customize its settings as shown below.

   [![Modified Health Powerup](https://dev.epicgames.com/community/api/documentation/image/69e13fbc-683d-47ee-b7b0-fd226f57a438?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69e13fbc-683d-47ee-b7b0-fd226f57a438?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Modified Stat** | Shield Only | Only the shields will be modified by this device. |
   | **Effect Magnitude** | 100 | Increases shield by 100. |
   | **Time To Respawn** | Instant | The powerup will instantly respawn when used. |
   | **Ambient Audio** | Off | This device will not have audio. |
   | **Pick Up Audio** | Off | This device will not have audio. |
   | **Pickup When Received From** | Channel 1 - Channel 12 | These powerups are consumed when the Team Settings and Inventory device sends a signal when a player is eliminated. This setting will increase incrementally for each device, matching the channel settings of the Team Settings & Inventory and Item Granter devices beside it, from Channel 1 to Channel 12. |
3. Select **OK** to save.
4. Copy and place this device 11 more times.

   a. For each device, incrementally increase the channel for **Pick Up When Received From** so that each device ranges from Channel 1 to Channel 12. Each device should match the channel settings of the Team Settings & Inventory and Item Granter devices beside it.

## Designer Tips

[![Designer Tips](https://dev.epicgames.com/community/api/documentation/image/2aa45f64-2264-4800-a70d-c5b4dcf5129d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2aa45f64-2264-4800-a70d-c5b4dcf5129d?resizing_type=fit)

To build your arena, use existing prefabs and galleries centered around a theme. You can modify these buildings by opening up the roofs and adding additional walkways to increase the verticality of the level. This allows more three-dimensional gameplay and dynamic fighting for the players.

You can also use invisible [Barriers](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative) around the main arena to prevent players from leaving the battlefield.

## Spawn Players into the Arena

[![Area Overview](https://dev.epicgames.com/community/api/documentation/image/42e8ccd2-a7b6-4fcb-8815-8be7dbe267d1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42e8ccd2-a7b6-4fcb-8815-8be7dbe267d1?resizing_type=fit)

*Use the photo as a visual reference for device placement and creative possibilities.*

Place **Player Spawn Pads** in an area that’s safe to spawn in. These areas should offer visual cover and be out of hot zones likely to be surrounded by combat.

In this section you will use:

12 x [Player Spawner Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)

### Player Spawners #1-12

[![Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/1e519171-cf48-4868-8564-150391edd409?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e519171-cf48-4868-8564-150391edd409?resizing_type=fit)

To set up this device:

1. Equip and place a Player Spawn Pad in an area or room players are unlikely to combat in.
2. Customize its settings as shown below.

   [![Modified Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/1bb5f911-5403-4e76-af81-7bc5f12860f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1bb5f911-5403-4e76-af81-7bc5f12860f6?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible in Game** | Off | This device will not be visible in the gameplay. |
3. Select **OK** to save.
4. Copy and place this device 11 more times in safe areas.

## Customize the Island Settings

These settings will create a 12-player, free-for-all gameplay that is won by having the highest score.

[![My Island Menus](https://dev.epicgames.com/community/api/documentation/image/f8626942-3b44-4ec7-b0e1-bbf7a139c98a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f8626942-3b44-4ec7-b0e1-bbf7a139c98a?resizing_type=fit)

To modify gameplay settings, press the **TAB** key and click **MY ISLAND** at the top of the screen. You can access the **GAME**, **SETTINGS**, and **UI** tabs.

### My Island - Game

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Max Players** | 12 | There can be up to 12 players in this game. |
| **Total Rounds** | 1 | This gameplay will only have one round. |
| **Time Limit** | 30 Minutes | This gameplay will last for 30 minutes. |
| **Game Win Condition** | Most Score Wins | The player with the highest score wins the game. |
| **Eliminations to End** | 20 | The game will end after a player achieves 20 eliminations. |
| **Score to End** | 20 | The game will end after a player reaches a score of 20. |
| **Elimination Score** | 1 | Each elimination will award a player one score point. |
| **Assist Score** | 0 | Assisting an elimination will not give a score point. |

### My Island - Settings

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Time Of Day** | 12:00PM | This determines the sun's position in the sky. |
| **Starting Shields** | 100% | Players will start with a full shield bar. |
| **Max Shields** | 100 | The max shield players will have is 100. |
| **Allow Overshield** | On | Players will have an overshield during the gameplay. |
| **Infinite Ammo** | On | Players will have infinite ammo in their weapons. |
| **Environmental Damage** | Off | Players will not damage the environment with their weapons. |
| **Eliminated Player’s Items** | Keep | Players will keep their loadout after being eliminated. |
| **Allow Item Drop** | No | Prevents players from throwing their weapons on the floor. |
| **Health Granted On Elimination** | 100 | Eliminating a player grants 100 health. |

### My Island - UI

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Game Score Display Time** | 7 Seconds | The game score will display for seven seconds. |
| **Round Score Display Time** | 7 Seconds | The round score is displayed for seven seconds. |
| **HUD Info Type** | Score | This score will be displayed on the players’ HUD. |
| **Max Trackers On HUD** | 1 | There will only be one tracker on players’ HUD. |
| **Round Win Condition** | Score | Score will determine the round’s winner. |
| **First Scoreboard Column** | Eliminations | The first scoreboard column will show eliminations. |
| **Second Scoreboard Column** | Eliminations | The second scoreboard column will show players eliminated. |
| **Third Scoreboard Column** | Eliminations | The third scoreboard column will show the players’ time alive. |
