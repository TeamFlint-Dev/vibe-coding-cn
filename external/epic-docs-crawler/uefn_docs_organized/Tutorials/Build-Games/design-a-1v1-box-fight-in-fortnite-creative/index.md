# 1v1 Box Fight

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/design-a-1v1-box-fight-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:57:56.980946

---

This Box Fight 1v1 tutorial is based on the [Box Fight tutorial video](https://www.kaltura.com/index.php/extwidget/preview/partner_id/2501632/uiconf_id/43819872/entry_id/1_rxvpknx6/embed/dynamic). As you follow along with this tutorial, you will build your own Box Fight 1v1 from scratch. The tutorial will explain each element you build and why it is included.

There is a new template island called **Design a 1v1 Box Fight**. That template island is slightly different from the one used in this tutorial, but you can use it to quickly build a box fight island.

## Island Description

The Box Fight 1v1 tutorial shows you how to create a game where two players try to eliminate each other in a very limited space. There are barriers that separate the players before the game starts, and the player can quickly build some defenses before the barriers are removed.

A custom [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) provides each player with the same [loadout](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#loadout) of weapons, ammo, building [resources](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#resource), and [item](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) items.

Each [round](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#round) ends with one player [eliminating](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#eliminate) the other, and you can set how many rounds are in a [match](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#match).

## Devices Used

These devices were used for this island:

- 2 x [Player Spawn Pad devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 3 x [Barrier devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative)
- 1 x [Timed Objective device](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)
- 2 x [Class Designer devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative)
- 1 x [HUD Controller device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative)

## Overview of Tutorial Steps

Following is an overview of the steps you'll need to recreate this island, and the ideal sequence:

1. Create your island.
2. Build the area for your box fight, including a lower level underneath the main play area.

   1. Build the lower level where the barriers and other devices will be placed.
   2. Build the main play area.
3. Add and set up Player Spawn Pad devices in the main play area.
4. Add and set up the three Barrier devices.
5. Add and set up the Timed Objective device.
6. Add and set up the Class Designer device.
7. Add and set up the HUD Controller device.
8. Change the My Island settings to set up the game.

## Create Your Island

The Box Fight [game type](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-type) generally takes place in a very limited enclosed area. Because of this, the specific island you choose is not important. However, if you are not very experienced in building, you might want to choose an island that has a flat surface and no grass. Those two features will make it easier for you to place the floor and wall pieces and line them up.

### Build the Lower Level

[![Finding the Galleries](https://dev.epicgames.com/community/api/documentation/image/13bbd910-7a1a-4c51-8b66-fbdf4266f6ad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13bbd910-7a1a-4c51-8b66-fbdf4266f6ad?resizing_type=fit)

*Click image to enlarge.*

To build the box for your Box Fight, you will need to find wall, floor and roof pieces that match the theme you want for your game. You can find these in collections called [galleries](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gallery).

Press the **Tab** key to open the [CREATIVE inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) screen. Click the **GALLERIES** tab. In the list on the left, select **Castle** and **Haunted**. This will display a variety of castle and haunted castle floors, walls, roofs, and props. If you want to look at the individual pieces included in a gallery, select the gallery and click the **OPEN** button below the [Quick Bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-bar). You can select individual pieces in the gallery, and drag them to your Quick Bar.

You aren't limited to choosing pieces from just one gallery. You can open several galleries, view pieces, and drag pieces you like into your Quick Bar. When you have selected the pieces you want to use, build your lower level with these dimensions:

- Height: 1 tile
- Width: 3 tiles
- Length: 5 tiles
- Roof: None

### Build the Main Play Area

Using the same building pieces you used for the lower level, build your main play area. You will stack this directly on top of the lower level. The floor tiles for your main play area will become the ceiling for the lower level. Build the main play area with these dimensions:

- Height: 2 tiles
- Width: 3 tiles
- Length: 5 tiles
- Roof: Whatever roof you want to use

Now that you have built the play area, you can start adding the devices.

Any options that are not listed in the device sections below are meant to stay at their [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#default) values.

## Add and Set Up Player Spawn Pads

[![Player Spawner Device](https://dev.epicgames.com/community/api/documentation/image/a27ab8f8-0bd1-424a-9c2f-631bfeab036c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a27ab8f8-0bd1-424a-9c2f-631bfeab036c?resizing_type=fit)

1. Press the **Tab** key to open the **Creative inventory**, then click the **Devices** tab.
2. Locate the **Player Spawn Pad** device. Click **PLACE NOW**, and [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) your first spawn pad.
3. Customize the options as shown below.

   [![Customize Player Spawner Options](https://dev.epicgames.com/community/api/documentation/image/5c91a827-bf6c-4fd5-ae6d-c53db235ec50?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c91a827-bf6c-4fd5-ae6d-c53db235ec50?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Team** | 1 | You will need to assign a team to each spawn pad that you place on your island. Any player that spawns on this pad automatically belongs to the team that you set for it. Since this is a one versus one (1v1) game, you will need two Player Spawn Pads. |
   | **Priority Group** | Primary | You want these Player Spawn Pads to be the highest priority. |
   | **Use as Island Start** | Yes | There isn't a pre-game lobby in this game, so you want the players to spawn directly in the play area. |
   | **Visible during games** | No | You don't need the spawn pad visible during gameplay, so set this to **No**. |

4. Click **OK** to save your options.

   Click **OK** after changing your settings. Otherwise, your customized options will not be saved.
5. Click the Player Spawn Pad device to copy it, then click again to place it. Move the second spawn pad across the room so it is opposite the first spawn pad.

## Add and Set Up the Barrier Devices

[![Hollow Barrier Device](https://dev.epicgames.com/community/api/documentation/image/fca13547-7d16-4567-bea7-335036496c9d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fca13547-7d16-4567-bea7-335036496c9d?resizing_type=fit)

Two of the Barrier devices will keep the players on their own sides of the room until the game begins. The third Barrier will be styled with an opaque color and go in the middle of the room, to keep each player from seeing what the other player is doing.

### Hollow Barriers

1. Find the **Barrier** device by pressing the **Tab** key to open the **Creative inventory**. To make it easier to find, you can type "barrier" in the **Search** box, or click the **Volume** or **Environment** categories in the list on the left.
2. Place the Barrier in your Quick Bar by selecting it and pressing the **1** key.
3. Press the **Tab** key to return to your island. Double-tap the space bar to activate [Fly mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#fly-mode), then press the **N** key to turn on [Phase](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#phase). Go through the floor, down to the lower level.
4. Place the Barrier device in the row of tiles immediately in front of the first spawn pad.
5. Customize this Barrier's options as shown in the table below.

   [![Hollow Barrier Options](https://dev.epicgames.com/community/api/documentation/image/0fdb6b59-cef2-4693-9417-5e28287ec4dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0fdb6b59-cef2-4693-9417-5e28287ec4dd?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Style** | Blue Forcefield | You should choose a style that is transparent so players can see through it. Other than that, the style you pick isn’t important. This tutorial uses the Blue Forcefield style. |
   | **Enabled During Phase** | All | The Barriers will be removed by signals on channels, so it’s okay to have the Barrier enabled in all [game phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase). |
   | **Zone Shape** | Box (Hollow) | Make the Barrier a hollow box, so that players can build structures in the tiles in front of them before the Barriers drop. |
   | **Barrier Depth** | 3 tiles | This makes the Barrier go all the way across the room from left to right. |
   | **Barrier Height** | 3 tiles | Since the Barrier device is placed in the lower level, setting the Barrier to 3 tiles high means it extends from the lower level all the way to the ceiling of the play area. |
   | **Barrier Width** | 1 tiles | The Barrier should take up only one tile in front of the player. |
   | **Disable When Receiving From** | Channel 1 | The Barrier drops when the device receives a signal on Channel 1. |

6. Click **OK** to save your options.
7. Once you have the first Barrier customized, point at it with your phone and click to copy it. Place the copied Barrier in the row of tiles in front of the second spawn pad.

All the options will be the same for both Barriers. That means both Barriers will drop when they receive a signal on Channel 1.

### Opaque Barrier

[![Opaque Barrier Device](https://dev.epicgames.com/community/api/documentation/image/c666826c-286a-4e43-ada1-7e8ffa9533c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c666826c-286a-4e43-ada1-7e8ffa9533c5?resizing_type=fit)

The third Barrier will be placed on the lower level, in the exact middle of the play area. This is an opaque barrier that keeps the players from seeing each other before the game starts.

1. Find the Barrier in the Creative inventory and click **Place Now**. If you previously placed a Barrier device in your Quick Bar, press the **1** key to create a new Barrier device.
2. Activate **Fly mode** and turn on **Phase**. Go through the floor, down to the lower level.
3. Place this Barrier in the exact middle row of the play area.
4. Customize this third Barrier as shown in the table below.

   [![Opaque Barrier Options](https://dev.epicgames.com/community/api/documentation/image/4325725c-4ff7-40c5-97fa-c7d58bc268fb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4325725c-4ff7-40c5-97fa-c7d58bc268fb?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Style** | Gloss Black | This barrier should be a solid color, so players can’t see through it. This lets the players build structures without the other player knowing exactly what they are doing. |
   | **Enabled During Phase** | All | The Barriers will be removed by signals on channels, so it’s okay to have the Barrier enabled in all game phases. |
   | **Zone Shape** | Box | No need to make this hollow, so the Box shape works fine. |
   | **Barrier Depth** | 3 tiles | This makes the Barrier go all the way across the room. |
   | **Barrier Height** | 3 tiles | Since the Barrier device is placed in the lower level, setting the Barrier to 3 tiles high means it extends from the lower level all the way to the ceiling of the play area. |
   | **Barrier Width** | .5 tile | This Barrier doesn’t need to be very wide, because its only purpose is to keep players from seeing each other. |
   | **Disable When Receiving From** | Channel 1 | This Barrier drops when the device receives a signal on Channel 1, just like the Barriers in front of the players. |

5. Click **OK** to save your options.

## Add and Set Up the Timed Objective Device

[![Timed Objective Device](https://dev.epicgames.com/community/api/documentation/image/bfecde8e-87cf-47ca-a5e0-770d55470393?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bfecde8e-87cf-47ca-a5e0-770d55470393?resizing_type=fit)

You will use this device to create a timer that counts down at the beginning of each round, letting the players know how long before the barriers drop. This device is invisible during the game, so you can place it anywhere. For convenience, this tutorial places it in the lower level area where the Barrier devices are located.

1. Find the **Timed Objective** device by pressing the **Tab** key to open the **Creative inventory**. The easiest way to find it is to type "time" into the Search bar to filter the devices shown.
2. Place the Timed Objective device on the floor in the lower level.
3. Customize the options as shown below.

   [![Timed Objective Options](https://dev.epicgames.com/community/api/documentation/image/c586c2b2-a421-4d7f-bcbe-3bfcef0a00b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c586c2b2-a421-4d7f-bcbe-3bfcef0a00b2?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Start When Round Starts** | Yes | The timer starts as soon as the round begins. The timer will count down the time until the barriers fall and the players can fight. |
   | **Timer Label Text** | Barrier Drops In: | This message tells the players how much time they have before the barriers drop. |
   | **Visible During Game** | No | This device is invisible to players. You can put it in the lower level for convenience, just to have all your invisible devices together. |
   | **Urgency Mode** | Disabled | You can enable Urgency Mode on a timer if there is something the player needs to do before the timer ends. But it isn’t needed here, so disable it. |
   | **When Completed, Transmit On** | Channel 1 | When the timer finishes counting down (completes), it sends a signal on the selected channel. You want to select Channel 1 here, because all three Barrier devices are listening for a signal on that channel. When they receive the signal, the Barriers all drop. |

4. Click **OK** to save your options.

## Add and Set Up the Class Designer Device

[![Class Designer Device](https://dev.epicgames.com/community/api/documentation/image/8f678694-13ef-4740-8e9a-81e86330a184?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f678694-13ef-4740-8e9a-81e86330a184?resizing_type=fit)

Find and place the Class Designer device. As with the other devices, this will be invisible to players and can be placed anywhere. However, for convenience you can place the Class Designer devices with the other invisible devices in the lower level area.

1. Locate the Class Designer device by pressing **Tab** to open the **Creative inventory**, and clicking the **Devices** tab. Scroll to find it, or type "class" in the Search bar to filter the displayed items so you can find the Class Designer more quickly.
2. Before customizing options for the Class Designer, you need to choose the weapons and items you are going to grant to the player at the beginning of the game. Make sure you are standing right in front of the Class Designer, then press **Tab** to open the **Creative inventory** and click the **Weapons** tab.

   [![Weapons Tab in Inventory](https://dev.epicgames.com/community/api/documentation/image/666574b9-a2d5-41a6-b9fe-7c5f5257405f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/666574b9-a2d5-41a6-b9fe-7c5f5257405f?resizing_type=fit)

   *Click image to enlarge.*
3. Select the **Epic (purple) Assault Rifle**. Drag it to the first slot in your [Equipment bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#equipment-bar).
4. Select the **Rare (blue) Pump Shotgun**. Drag it to the second slot in your Equipment bar.
5. Click the **Items** tab. Check the **Healing** category in the list on the left.

   [![Items: Healing](https://dev.epicgames.com/community/api/documentation/image/72b9765e-b509-4e10-b982-d69dc4cd39a8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/72b9765e-b509-4e10-b982-d69dc4cd39a8?resizing_type=fit)

   *Click image to enlarge.*
6. Drag two **Small Shield Potions** into your Equipment bar.
7. Drag a **Slurp Fish** into your Equipment bar.
8. Next you want to equip some ammunition. Uncheck the Healing category, then check the **Ammo** category.

   [![Items: Ammo](https://dev.epicgames.com/community/api/documentation/image/3f69ee31-eb14-411f-9b2d-f26207e2c5a4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f69ee31-eb14-411f-9b2d-f26207e2c5a4?resizing_type=fit)

   *Click image to enlarge.*
9. Click **Ammo: Medium Bullets**. This is the ammo for the Assault Rifle. In this example, the player will get 300 rounds for the Assault Rifle. Medium Bullets are in bundles of 100 rounds, so click the **Equip** button three times to get **300 rounds**.
10. Click **Ammo: Shells**. This is the ammo for a shotgun. In this example, the player will get 60 rounds for the shotgun. The shells are in bundles of 20, so click the **Equip** button three times to get **60 rounds**.
11. Unclick the Ammo category, and ckick the **Materials** category. This displays the resources players can use to build structures in the game.

    [![Items: Materials](https://dev.epicgames.com/community/api/documentation/image/53cd4050-b104-4d05-8a62-168a7b5f3b30?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/53cd4050-b104-4d05-8a62-168a7b5f3b30?resizing_type=fit)

    *Click image to enlarge.*
12. Click **Wood**, then click the **Equip** button once. This equips 500 wood in the player inventory.
13. Click **Play** in the [top navigation bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to switch to the [PLAY inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#play-inventory). The Equipment bar on the right should show all the weapons, items, resources, and ammo you selected in the previous steps.

    [![Player Inventory](https://dev.epicgames.com/community/api/documentation/image/cd4ca402-e6f6-46d1-8bc3-1f574329c11f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cd4ca402-e6f6-46d1-8bc3-1f574329c11f?resizing_type=fit)

    *Click image to enlarge.*
14. Drag the **Assault Rifle** equipped in **slot 1** over to the Class Designer.

    [![Drag Items to Class Designer](https://dev.epicgames.com/community/api/documentation/image/671627fc-9bb7-48ad-bc44-f8b452e79b88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/671627fc-9bb7-48ad-bc44-f8b452e79b88?resizing_type=fit)

    *Click image to enlarge.*

    It is important that you register the Assault Rifle first because when you customize the options you will designate this weapon as the one that is equipped for each player when the game starts.
15. Drag the **Pump Shotgun** over to the Class Designer to register it, then the **Small Shield Potions** and the **Slurp Fish**. Then drag the ammo and wood to the Class Designer. Except for the first item, it doesn’t matter what order you use to drop the items onto the Class Designer.
16. Click **CREATIVE** in the top navigation bar to return to the Creative inventory. Then press **Tab** or **Esc** to close the inventory window and return to Create mode. The items registered to the Class Designer will now display in the hologram above the device, rotating from item to item.
17. Customize the Class Designer options as shown below.

    [![Class Designer Options](https://dev.epicgames.com/community/api/documentation/image/13e84771-0363-4a0b-861c-dec281c021c6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13e84771-0363-4a0b-861c-dec281c021c6?resizing_type=fit)

    | Option | Value | Explanation |
    | --- | --- | --- |
    | **Class Identifier** | 1 | In this tutorial, you only define one class, and both players will use the same class. So choose the number 1 for this option. |
    | **Grant Items on Respawn** | Yes | You want players to have the same weapons and other items every time they respawn in a new round. |
    | **Equip Granted Item** | First Item | This is why we dropped the Assault Rifle on the Class Designer first. All items registered to the Class Designer are put in a list. Here, you choose **First Item** to equip players with the Assault Rifle when the game starts. |
    | **Grant Ammo With Weapon** | No | You don’t want players to spawn with the default amount of ammo. Instead you want the players to spawn with the exact amount of ammo you placed in the Class Designer device. So set this option to **No**. |
    | **Starting Health** | 100% | Each player will start with full health. |
    | **Max Health** | 100 | The Box Fight is designed to be fast, so you don’t want to set the players’ health too high. 100 is a good place to start. |
    | **Starting Shields** | 100% | Each player will start with full shields. |
    | **Max Shields** | 100 | Like the Health setting, 100 shields is a good place to start. It’s enough to give the player a little time before they start taking damage, but not enough that it will take a long time to eliminate a player. |
    | **Infinite Ammo** | Off | You defined how much ammo each player has when you set up the Class Designer, so this is set to **Off**. |
    | **Infinite Items** | Off | You defined how many items each player has when you set up the Class Designer, so this is set to **Off**. |
    | **Infinite Resources** | Off | You defined how much wood each player has when you set up the Class Designer, so this is set to **Off**. |

18. Click **OK** to save your options.

When you've set up the first Class Designer and customized its options, you can point your phone at it and click to create a copy. This copy will have the same items and customized options as the first device. Click to paste the second device for Player 2. Since you are making one for each player, you can put each player's device on that player's side of the lower level, to make it easier for you to remember which device is for which player.

## Add and Set Up the HUD Controller Device

[![HUD Controller Device](https://dev.epicgames.com/community/api/documentation/image/2db34503-2368-4a57-9625-3eed62334955?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2db34503-2368-4a57-9625-3eed62334955?resizing_type=fit)

Next, find and place the HUD Controller device. As with the Barrier and Class Designer devices, this will be invisible to players. For convenience, you can place this in the lower level with the other invisible devices. Customize the HUD Controller options as shown below.

[![HUD Controller Options](https://dev.epicgames.com/community/api/documentation/image/d2f50ac1-d4f5-4838-b815-9c7d0e03365b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d2f50ac1-d4f5-4838-b815-9c7d0e03365b?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Show Mini Map** | No | The Box Fight takes place in such a small enclosed area, no minimap is needed. |
| **Show Elimination Counter** | Yes | You want players to be able to see how many eliminations they have achieved. |
| **Show Round Timer** | Yes | You want the players to know how much time is left in the round. |

## Change My Island Settings

You need to change some settings in the My Island settings. Press the **Tab** key to open the Creative menu. Click **My Island** in the top navigation bar, and the **Game** tab opens by default. Customize the My Island settings as shown in the sections below.

Any settings that are not listed in the following sections are meant to stay at the default value.

### Game Tab

Here are the settings on the **Game** tab that need to be customized.

| Setting | Value | Explanation |
| --- | --- | --- |
| **Max Players** | 2 | This is a 1v1 Box Fight, so there will only be 2 players total in a match. |
| **Teams** | 2 | Each player is on their own team, so with 2 players there are 2 teams. |
| **Team Size** | 1 | Each player is on their own team. |
| **Default Class Identifier** | 1 | There is one class for both players. You used class identifier 1 for the defined class, so here you are also making it the default class. |
| **Spawn Limit** | 1 | This setting controls how many times a player can spawn or [respawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#respawn) while the game is in progress. By setting this to **1**, it means each player will spawn once at the beginning of the game, and when one player is eliminated, the round is over. |
| **Total Rounds** | Pick a number | You can decide how many rounds you want to occur in the game. It is usually best to pick an odd number to avoid ties. A player would have to win more than half the rounds (2 out of 3, 3 out of 5, and so on). |
| **Time Limit** | 15 minutes | This is how long the round is if neither player is eliminated. So in this example, the round ends after 15 minutes if neither player is eliminated. |
| **Eliminations to End** | 1 | The round ends when one player or the other is eliminated. |
| **Join In Progress** | Spawn on the Next Round | If a player attempts to join the game after it starts, they will be a spectator until the next round. At the start of the round, they will spawn into the game. |
| **Elimination Score** | 1 | When one player eliminates the other, they get one point added to their score. |

### Settings Tab

Here are the settings on the **Settings** tab that need to be customized.

| Setting | Value | Explanation |
| --- | --- | --- |
| **Time of Day** | 12:00 PM | This setting affects the light and its brightness. Setting the time to noon ensures the maximum amount of light and brightness. |
| **Infinite Resources** | Off | Because the Class Designer grants a specific amount of resources, you want to turn this setting to **Off**. |
| **Allow Building** | No Traps | This gives players the ability to create structures, but not to make traps. |
| **Building Can Destroy Environment** | No | This ensures that player-built structures do not damage or destroy anything in the environment. |
| **Environment Damage** | Player-Built Only | This ensures that players can damage player-built structures, but can’t damage any creator-built structures or natural features in the environment. |
| **Structure Damage** | All | Players can destroy any player-built structure including both structures built by the other player and structures they built themselves. |
| **Glider Redeploy** | Off | Fall Damage is set to **Off** by default; Glider Redeploy is set to **Off** too, because the play area is small and the players won’t be able to climb high enough to need this. |
| **Wood Granted on Elimination** | 0 | This setting (along with other "resource granted on elimination" settings) should be set to 0 by default. But if they are set to something else, change the setting to **0** for wood, stone, metal, and gold. |

### UI Tab

Here are the settings on the **UI** tab that you need to customize.

| Setting | Value | Explanation |
| --- | --- | --- |
| **Game Winner Display Time** | 3 seconds | This is how long the name of the winner is displayed after the game ends. |
| **Game Score Display Time** | 5 seconds | This is how long the final scoreboard displays the game score after the game ends. |
| **Round Winner Display Time** | 3 seconds | This is how long the name of the round winner is displayed after the round ends. |
| **Round Score Display Time** | 5 seconds | This is how long the scoreboard is displayed after the round ends. |
| **Scoreboard Win Condition** | Eliminations | The scoreboard tracks how many eliminations each player has, and determines the winner based on how many eliminations each player achieved. |
| **Scoreboard Tie Breaker** | Damage Dealt | If both players have the same score, the winner is chosen based on which player dealt the highest amount of damage to the other player. |
| **Custom Victory Callout** | Write a victory message (80 character limit) | You can write a custom message that is displayed for the winning player. |
| **Custom Defeat Callout** | Write a defeat message (80 character limit) | You can write a custom message that is displayed for the losing player. |
