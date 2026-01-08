# Free For All Tutorial

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/create-a-free-for-all-game-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:58:08.514076

---

This [Free For All](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tutorial is based on the Deathmatch tutorial. As you follow along with this tutorial, you will build your own Free For All Deathmatch game from scratch. The tutorial will explain each element you build and why it is included.

The [island code](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#island-code) for the example island used for this tutorial is **1048-0110-6379**. To take a look, from the Fortnite Lobby click **CHANGE** (above the **PLAY** button) to open the [Discover screen](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Click the **ISLAND CODE** tab, then enter the code **104801106379** in the box and press **Enter**. The window will display information about the island. Click **PLAY** to launch the game.

There is a [template island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#template-island) called **Free For All Deathmatch Tutorial**. This tutorial shows you how to create a deathmatch island from the ground up, but you can use the template island to quickly build a deathmatch and get it up and running. When you open the Create Island screen, click the **Template** tab and scroll down to find the Free For All Deathmatch Tutorial template island.

## Island Description

The **Deathmatch** tutorial shows you how to set up an 8-player Deathmatch game on your island. In this game mode, players try to eliminate as many other players as possible, gaining a point for each elimination. After elimination, players respawn into the play area and continue until the round or match is over. This mode is fast-paced and competitive, requiring players to think fast and make use of the randomly [spawned](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) weapons and items placed around the play area. Unlike some [player vs. player](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#pvp) modes, Deathmatch does not allow player building. Instead, it requires players to think strategically, using features in the existing environment to give themselves advantages such as high ground or cover.

## Devices Used

These devices were used for this island tutorial:

- 16 x [Player Spawner devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) (8 for respawning inside the play area, 8 for the pre-game lobby)
- 19 x [Item Spawner devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative)
- 1 x [Class Designer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative)
- 1 x [Elimination Manager device](https://dev.epicgames.com/documentation/en-us/fortnite/using-elimination-manager-devices-in-fortnite-creative)
- 1 x [HUD Controller device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative)
- [Billboard devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-billboard-devices-in-fortnite-creative)

## Overview of Tutorial Steps

The following is an overview of the steps you'll need to recreate this island, listed in the ideal Order:

1. Create a new island using a Grid [starter island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#starter-island).

   1. Draw out your design for the play area, based on the [Level Design Tips](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-free-for-all-game-in-fortnite-creative) provided.
   2. Build your play area on your island, based on your drawing.
2. Add and set up Player Spawner Pads in the play area, one for each player.
3. Add and set up the Class Designer to create a custom loadout that players receive at the start of the game and each time they respawn.
4. Add and set up the Item Spawners.
5. Add and set up the Elimination Manager.
6. Add and set up the HUD Controller.
7. Change the My Island settings to set up the game.
8. Build the Pre-Game Lobby for the game.

## Create Your Island

### Draw Your Play Area

When you are designing a complex play area for your game, it's a good idea to draw out the design first. You can do this the old-fashioned way, with paper and pencil, or you can use a digital drawing tablet and your PC, or a stylus and a mobile device. However you draw, sketching out your ideas for the play area first gives you a chance to examine the design and make adjustments before you actually start building. This can save you a lot of time! As you are considering your play area, keep in mind the following level design tips.

### Level Design Tips

- **Determine how many players you want in the game**. A play area for two players is very different from a play area for eight. The number of players not only affects how large the play area should be, but can impact how you design the play area and how many items and weapons you need to place.
- **Create separate and protected areas for players to spawn in**. Spawn areas should be isolated enough that a respawning player can quickly find a weapon and cover. Spawn areas should also be designed in a way that discourages players from [spawn camping](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawn-camping). Spawn camping is when a player locates a spawn point and waits there for a player to respawn, taking the respawned player out before they can arm themselves. There are also settings you can use to discourage spawn camping; these will be highlighted in the sections that tell you how to customize your devices.
- **Minimize chokepoints (also known as control points or bottlenecks)**. Chokepoints are spots on your island where the area narrows, and where one or two players can hide behind cover while a large number of enemies is funnelled toward the defending players. This grants an enormous advantage to a defending player, and an enormous disadvantage to anyone who has to pass through that narrow chokepoint. In a game mode like Deathmatch, you don't want the environment to grant some players a large advantage over others. All players should have the same advantages and disadvantages, depending on how they use the environment around them.
- **Add verticality to your areas**. Verticality means providing some high areas and some low areas. Varying the height of features and structures in your play area (using things such as stairs, balconies, scaffolding, and other raised areas) provides players with many strategic options. For players who prefer long-range weapons, high ground is preferred. Moving underneath raised areas protects players from long-range weapons, gives cover and might help players use ambush tactics.
- **Add plenty of objects for cover**. Providing cover is essential in this game mode. There are plenty of props that can be used as cover; you can also use building elements to provide cover (such as a balcony with a railing that players can crouch behind).
- **Vary the space available in different areas**. Don't have too many large open areas or too many tight corridors. Find a balance between open spaces and tight spaces. Mix up the size and shape of the rooms in your play area to add more variety and present more strategic choices for players.
- **Make sure there are always at least two exits from a room or area**. This prevents players from using a dead end to gain an unfair advantage by using the dead end as a trap or ambush point.
- **Think carefully about where you place the Item Spawners**. There should be a weapon near each player spawn point, so respawning players can quickly grab a weapon and find cover. Also, it is a good idea to place certain weapons in an area where that weapon is advantageous. For example, if you have a balcony or scaffold, place a sniper rifle there. Consider placing healing items or shields behind cover to protect players while they are healing.

### Build the Play Area

Once you have sketched out a design for your play area based on the level design tips provided, you are ready to start building!

Which building pieces you use depends on the visual style of game you want to build, so there is a lot of room for creativity here. The example island used galleries in the **Castle** category, so you can use those to start with. Remember that you can place an entire gallery, but you can also open a gallery to view the individual pieces it contains. With the gallery open, you can select an individual piece and put it in your [Quick Bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-bar).

When you are building, open the [Quick Menu](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-menu) (on PC, do this by pressing the **B** key). Locate the **Building as Prop** option, and set it to **Off**. When you do this, all building pieces will automatically snap to the grid, and automatically snap together with other pieces. These settings help you build structures very quickly.

## Add Player Spawn Pads to Play Area

[![Adding the Player Spawner Pads](https://dev.epicgames.com/community/api/documentation/image/f8d5b13f-2806-4cc5-b9e9-61c3be1e2e59?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f8d5b13f-2806-4cc5-b9e9-61c3be1e2e59?resizing_type=fit)

Once your play area is in place, add your first Player Spawn Pad. Because all spawn pads will use the same customized options, you can set up the first one and then use **Copy** and **Paste** to create the rest. These Player Spawn Pads should be located in the actual play area, and will be where players respawn after they are eliminated, so you will set up a total of 8 Player Spawn Pads in this section.

1. Press the **Tab** key to open the **Creative** menu, then click the **Devices** tab.
2. Locate **Player Spawn Pad**, then click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) your first spawn pad.
3. When standing near the Player Spawn Pad, press **E** to open the **Customize** panel. Customize the spawner options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Priority Group** | Primary | Players respawn on these pads during gameplay. |
   | **Use As Island Start** | No | Players do not spawn here initially, instead they spawn into the game for the first time into the lobby you set up. |
   | **Visible during games** | No | Spawn pads aren’t visible during gameplay, this is one of the ways spawn camping is discouraged. |

4. Click **OK** to save your options.
5. Next, copy the spawn pad and place seven copies, for a total of eight Player Spawn Pads. Place the spawn pads around the play area, using the suggestions in the [Level Design Tips](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-free-for-all-game-in-fortnite-creative) section.

Make sure you click **OK** after changing your settings. Otherwise, your customized options will not be saved.

## Create the Default Class

[![Add the Class Designer](https://dev.epicgames.com/community/api/documentation/image/9ddf0e03-34ba-4f6b-8f0b-8df8736c6847?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9ddf0e03-34ba-4f6b-8f0b-8df8736c6847?resizing_type=fit)

Once your player spawners are in place, add the Class Designer. The reason you assign a class with the Class Designer device is so that you can control the starting loadout for each player in the game. The Class Designer device will be invisible during the game, so just place it somewhere convenient.

1. Press the **Tab** key to open the **CREATIVE** inventory, then click the **DEVICES** tab.
2. Locate the **Class Designer**, then click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) it in your play area.
3. Make sure you are standing right in front of the Class Designer. Press **Tab** to open the **CREATIVE** inventory and click the **WEAPONS** tab.
4. Select the weapon you want players to equip with at the start of the game and when they respawn after elimination. This example uses a sawed-off shotgun. Drag the selected weapon to your [Equipment bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#equipment-bar).
5. Click the **CONSUMABLES** tab. Under the search bar on the left, click the **Ammo** category. Locate and select the **Ammo: Shells** item, then click the **EQUIP** button twice to add 40 shells to your Player inventory.
6. Press the **Esc** or **Tab** key to close the Creative inventory. Stand in front of the **Class Designer**. Press the **Tab** key to reopen the Creative inventory, and click **PLAY** in the [top navigation bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). This displays your [Player inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#play-inventory) and Equipment bar.
7. Drag the starting weapon from your Equipment bar onto the Class Designer.

   It is important that you register this weapon first, because when you customize the options you will designate this weapon as the one that is equipped for each player when the game starts.
8. Drag the shells from your Player inventory onto the Class Designer.
9. Press the **Esc** or **Tab** key to return to Create mode. The items registered to the Class Designer will now display in the hologram above the device, rotating from item to item.
10. When standing near the **Class Designer**, press **E** to open the **CUSTOMIZE** panel. Customize the Class Designer's options as shown below.

    | Option | Value | Explanation |
    | --- | --- | --- |
    | **Class Identifier** | 1 | In this tutorial, only one class is defined, and all players will use the same class. So choose the number 1 for this option. |
    | **Grant Items On Respawn** | Yes | When a player respawns, they are automatically granted the weapons and items registered to the Class Designer, regardless of what they had when they were eliminated. |
    | **Equip Granted Item** | First Item | This is why you drop the starting weapon on the Class Designer first. All items registered to the Class Designer are put in a list. Here, you choose **First Item** to equip players with the starting weapon when the game starts or they respawn. |
    | **Starting Health** | 100% | Players spawn with full health. |
    | **Max Health** | 100 | Players have 100 maximum health. |
    | **Starting Shields** | 50% | Players spawn with half maximum shields. |
    | **Max Shields** | 200 | Players have 200 maximum shields. |
    | **Infinite Building Resources** | Off | This game mode does not allow player building, so this option is set to **Off.** |
    | **Eliminated Player’s Items** | Delete | When a player is eliminated, all weapons and items in their inventory are deleted. That way all players respawn with the same weapons and items, and no player can gain an advantage by picking up the eliminated player’s inventory. |
    | **Eliminated Player’s Resources** | Delete | A player’s resources are deleted on elimination. |
    | **Fall Damage** | On | Players will take damage when they fall. |
    | **Gravity** | Normal | Players experience normal gravity and their jump height is normal. |
    | **Spawn Limit** | Infinite | Players can respawn after elimination an infinite number of times. |
    | **Spawn Location** | Spawn Pads | Players only respawn on Player Spawner pads. |
    | **Health Granted on Elimination** | 50 | Players are granted 50 health when they eliminate another player. |
    | **Wood Granted on Elimination** | 0 | Player building is not allowed in this game mode, so no resources are granted for eliminating another player. |
    | **Stone Granted on Elimination** | 0 | Player building is not allowed in this game mode, so no resources are granted for eliminating another player. |
    | **Metal Granted on Elimination** | 0 | Player building is not allowed in this game mode, so no resources are granted for eliminating another player. |
    | **Gold Granted on Elimination** | 0 | Player building is not allowed in this game mode, so no resources are granted for eliminating another player. |
    | **Maximum Building Resources** | 0 | Player building is not allowed in this game mode, so this is set to 0. |
    | **Spawn Immunity Time** | 2 seconds | Players are immune to damage for 2 seconds after spawning and respawning. |

11. Click **OK** to save your options.

    Make sure you click **OK** after changing your settings. Otherwise, your customized options will not be saved.

## Add and Set Up the Item Spawners

[![Add the Item Spawners](https://dev.epicgames.com/community/api/documentation/image/edd8bb65-60eb-4bcd-8fbf-fa2f5448d9e1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/edd8bb65-60eb-4bcd-8fbf-fa2f5448d9e1?resizing_type=fit)

Next, add your first Item Spawner. You should have determined how many Item Spawners you needed when you built your play area. Each Item Spawner will be slightly different, but you can still save some time by customizing one and then using **Copy** and **Paste** to create the rest.

1. Press the **Tab** key to open the **CREATIVE** inventory, then click the **DEVICES** tab.
2. Locate the **Item Spawner**, then click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) the device.
3. When standing near the first Item Spawner, press **E** to open the **Customize** panel. Customize the Item Spawner's options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Random Spawns** | No Repeats | Every item in the item spawner must spawn and be picked up once before any duplicate items can spawn. |
   | **Visible During Games** | Off | Only the spawned items are visible during the game, not the item spawners. |
   | **Time Before First Spawn** | Instant | Items will spawn immediately on game start. Note: this example has set this option to different values for each Item Spawner, so that the devices are all spawning different items at different times. |
   | **Time Between Spawns** | 1 minute | This is the amount of time it takes for the device to spawn another item. Note: this example has set this option to different values for each Item Spawner, so that the devices are all spawning different items at different times. |
   | **Run Over Pickup** | On | Players can pick up spawned items by running over them. |

4. Click **OK** to save your options.
5. You can add weapons, ammo, health items, or powerups to the Item Spawner. Stand close to the device. Press the **Tab** key to open the **CREATIVE** inventory, and add the items you picked to your Player inventory or Equipment bar.
6. Click **PLAY** in the top navigation bar. Drag the weapons or other items you selected from your Player inventory onto the Item Spawner.
7. Next, use **Copy** and **Paste** to create as many Item Spawners as you need for your play area.
8. For each Item Spawner after the first one, press **E** to open the **CUSTOMIZE** panel.
9. Click the **Settings (gear)** icon and select **CLEAR ITEMS** to remove the items you registered to the first Item Spawner.
10. Follow steps 5-6 to add weapons or other items to each Item Spawner.
11. Place the Item Spawners around your play area, using the suggestions in the Level Design Tips section.

## Add and Set Up the Elimination Manager

[![Add the Elimination Manager](https://dev.epicgames.com/community/api/documentation/image/f335c1af-95cd-44a5-b5de-9b85a6792047?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f335c1af-95cd-44a5-b5de-9b85a6792047?resizing_type=fit)

Next, place and set up the Elimination Manager. Elimination Manager devices can determine what a player drops when eliminated. In this example, instead of dropping their inventory when eliminated, players will drop a set amount of ammo.

1. Press the **Tab** key to open the **CREATIVE** inventory, then click the **DEVICES** tab.
2. Locate **Elimination Manager**, then click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) it somewhere convenient.
3. When standing near the Elimination Manager, press **E** to open the **Customize** panel. Customize the Elimination Manager’s options as shown below. Any options not listed should be left at the default setting.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Initial Movement of Item** | Gravity | The items dropped from an eliminated player should drop as close to the eliminated player as possible, to make it easy for the eliminating player to pick them up. |

4. Click **OK** to save your options.
5. Add the types and amounts of ammo that you want players to drop when they are eliminated. Stand close to the device. Press the **Tab** key to open the **CREATIVE** inventory, and add these items to your Player inventory.

   [![Add Ammo to the Elimination Manager](https://dev.epicgames.com/community/api/documentation/image/88af0146-4975-468f-a707-0993ce474c17?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88af0146-4975-468f-a707-0993ce474c17?resizing_type=fit)
6. Click **PLAY** in the top navigation bar to open the Player inventory. Drag the ammo from your Player inventory onto the Elimination Manager. Because the Class Designer is set to delete a player's inventory when they are eliminated, they will now only drop the ammo that you registered to the Elimination Manager.

## Set Up the HUD Controller

[![Add the HUD Controller](https://dev.epicgames.com/community/api/documentation/image/f1c8f3b6-7b74-40df-9178-1a55e8b3c08a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f1c8f3b6-7b74-40df-9178-1a55e8b3c08a?resizing_type=fit)

The HUD Controller lets you edit the Fortnite HUD to eliminate unnecessary information that you don’t want to show during your island’s deathmatch games, like the [minimap](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#minimap) and [crafting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#crafting) resources.

1. Press the **Tab** key to open the **CREATIVE** inventory, then click the **DEVICES** tab.
2. Locate **HUD Controller**, then click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) it.
3. When standing near the HUD Controller, press **E** to open the **Customize** panel. Customize the HUD Controller's options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Show Mini Map** | No | Hides the mini map during your game. |
   | **Show Crafting Resources** | No | Hides the crafting resources HUD elements during your game. |
   | **Show Wood Resource** | No | Hides the wood resource HUD element during your game. |
   | **Show Stone Resource** | No | Hides the stone resource HUD element during your game. |
   | **Show Metal Resource** | No | Hides the metal resource HUD element during your game. |

4. Click **OK** to save your options.

Make sure you click **OK** after changing your settings. Otherwise, your customized options will not be saved.

## Change My Island Settings

There are some things in the [My Island settings](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) you need to customize to create this game experience.

### Game Tab

[![My Island Game Tab](https://dev.epicgames.com/community/api/documentation/image/1b7b2d3f-7ac4-4921-8311-9fc04574846d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1b7b2d3f-7ac4-4921-8311-9fc04574846d?resizing_type=fit)

*Click to enlarge*

Any settings not mentioned in the table below should be left at their default settings.

| Option | Value | Explanation |
| --- | --- | --- |
| **Max Players** | 8 | This sets the maximum number of Players who can join the game. You can customize this to make smaller or larger matches, just make sure you have enough Player Spawners for the number you choose. |
| **Teams** | Free For All | Every Player is on their own team, and every team is against every other team. |
| **Matchmaking Type** | Off | Turned off because there are no teams. |
| **Default Class Identifier** | 1 | All players are assigned the default class. |
| **Spawn Limit** | Infinite | No limit to respawns during the game. |
| **Total Rounds** | 100 | You can set this value to whatever value you want. In this example it is set to 100 rounds. |
| **Time Limit** | 15 minutes | If there are not enough player eliminations to end the round, it will end after this amount of time. You can change this value to make longer or shorter rounds. |
| **Win Condition** | Most Round Wins | The Player that wins the most rounds wins the game. |
| **Eliminations to End** | 30 | Rounds end when a Player gets this many eliminations. You can change this value to make longer or shorter rounds. |
| **Join In Progress** | Spawn | Lets players spawn directly into the game while a round is in session. |
| **Autostart** | 60 seconds | If a match is not in progress, players spend 60 seconds in the pre-game lobby, then the game automatically starts. |
| **Game Start Countdown** | 5 seconds | When the game starts, the countdown lasts this amount of time. Players can control their character once the countdown finishes. |
| **Elimination Score** | 1 | Eliminating another player gives a player 1 point. |

### Settings Tab

[![My Island Settings Tab](https://dev.epicgames.com/community/api/documentation/image/82400c19-c194-4280-9c83-1a73f0366c81?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82400c19-c194-4280-9c83-1a73f0366c81?resizing_type=fit)

*Click to enlarge*

Any settings not mentioned in the table below should be left at their default settings.

| Option | Value | Explanation |
| --- | --- | --- |
| **Time of Day** | 12:00 PM | Sets the general light level during the game. Setting it to noon ensures the highest level of brightness. |
| **Infinite Building Resources** | Off | Player building is not allowed in this game mode, so this is set to **Off**. |
| **Maximum Building Resources** | 0 | Player building is not allowed in this game mode, so this is set to **0**. |
| **Allow Building** | None | There is no player building in this game mode. |
| **Environment Damage** | Off | This is set to **Off**, so players cannot damage the environment with pickaxes or weapons. |
| **Weapon Destruction** | None | Weapons only damage players. |
| **Pickaxe Destruction** | None | Pickaxes only damage players. |
| **Eliminated Player’s Items** | Delete | You can set this here or in the Class Designer. |
| **Respawn Time** | 5 seconds | Players will respawn 5 seconds after being eliminated. You can change this to whatever value you want, to adjust the pace of the game. |
| **Spawn Immunity** | 5 seconds | How long a Player is invulnerable after respawning. |
| **Glider Redeploy** | Off | When falling, players are not able to deploy their gliders. |
| **Player Flight** | Off | Players can’t fly. |
| **Health Granted on Elimination** | 50 | You can set this here or in the Class Designer. |

### UI Tab

[![My Island UI Tab](https://dev.epicgames.com/community/api/documentation/image/1f79872f-edad-4653-bf3d-5555391f894f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1f79872f-edad-4653-bf3d-5555391f894f?resizing_type=fit)

*Click to enlarge*

Any settings not mentioned in the table below should be left at their default settings.

| Option | Value | Explanation |
| --- | --- | --- |
| **Game Winner Display Time** | 3 seconds | How long the winner’s name is displayed at the end of the game. |
| **Game Score Display Time** | 15 seconds | How long a player’s score is displayed at the end of the game. |
| **Round Winner Display Time** | 3 seconds | How long the winner’s name is displayed at the end of the round. |
| **Round Score Display Time** | 15 seconds | How long a player’s score is displayed at the end of the round. |
| **HUD Info Type** | Score | Displays the score in the HUD, which is tied to the number of eliminations a player has achieved. |
| **Scoreboard Win Condition** | Eliminations | Determines the win condition for the scoreboard, in this case the number of eliminations a player has achieved. |
| **Map Screen Display** | Scoreboard | The Map Screen shows the Scoreboard. |

## Build the Pre-Game Lobby

A pre-game lobby is a space outside the play area of the game, where players spawn when a match is not already in progress. Often the pre-game lobby has instructions on how to play the game.

You can build the pre-game lobby space wherever you want, as long as it is separate from the regular play area. Place Player Spawner pads in the room, along with Billboard devices that give players instructions on how your game works and what they need to do. In this example, there are 8 Player Spawner pads in the pre-game lobby. Customize the Player Spawner pad options as shown below.

1. Press the **Tab** key to open the **Creative inventory**, then click the **DEVICES** tab.
2. Locate the Player Spawner, then click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) your first spawn pad.
3. When standing near the Player Spawner, press **E** to open the **Customize** panel Customize the Player Spawner's options as shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Priority Group** | Secondary | You don’t want the players to spawn here after the game starts, so this is set to Secondary. The Player Spawner pads in the Spawn Rooms are set to Primary, so that eliminated players will spawn there and not in the Pre-Game Lobby. |
   | **Visible During Games** | No | Just like the Player Spawner pads in the Spawn Room, we don’t want the devices to be visible during the game. |
   | **Use as Island Start** | Yes (default) | This is where the players arrive when they get to the island. After the game starts, when players are eliminated they will spawn in the Spawn Rooms you set up. |

4. Click **OK** to save your options.
5. Next, copy the spawn pad, then place seven copies for a total of eight spawn pads.
6. Use Billboard devices to give players information on how to play your game. Place the Billboards in prominent places near the spawn pads, and make the instructions short and clear so players can read them quickly.

## Final Tips

- Create a schedule for doing map updates. Stick to your schedule!
- Make a small change to your island every week to keep the gameplay fresh.
- Create larger updates like new classes or mechanics over a longer period of time.
- Don’t be afraid to add new areas or modify existing areas to make the game better than it was in the first release.
- Keep an eye out for new items that are added into Creative that you can use to improve your island.
