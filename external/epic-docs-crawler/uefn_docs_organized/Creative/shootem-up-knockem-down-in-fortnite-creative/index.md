# Shoot'em Up, Knock'em Down

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/shootem-up-knockem-down-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:53:57.373709

---

This **target-shooting [free-for-all](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#freeforall)** game tutorial guides you through the process of planning and placing [prefabs](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prefab), [gallery](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gallery) items, and devices, as well as creating player [classes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class), and using [chests](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#chest) and [loot llamas](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#llama) for a fast-paced, incredibly fun, free-for-all, target-shooting experience.

The gameplay features five 5-minute [rounds](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#round) for up to twelve players. The player with the highest score at the end of the final round wins the game.

The island features hidden chests and loot llamas with [higher-tier](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#high-tier) [weaponry](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#weapon) and items. Different target types award points depending on the target dummy's difficulty level. Play through with friends to get a feeling for the competitive nature of the game.

The sample island code for Shoot'em Up, Knock'em Down is **2661 3872 5705**. Head to the **Fortnite lobby** to take a look!

From the [Fortnite lobby](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), click **CHANGE** above the PLAY! button, then select **ISLAND CODE** on the top navigation bar. Enter the code above, and press **Enter**. The window displays information about the island. Click **PLAY** to launch the game.

Note the different features of the island, then come back and explore this tutorial to see how you can recreate it on your own island.

## Devices Used

These devices were used for this gameplay example:

- 12 X [Player Spawn Pad](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 120 X targets from the [Target Dummy](https://dev.epicgames.com/documentation/en-us/fortnite/using-target-dummy-devices-in-fortnite-creative) device
- 48 X [Customizable Light](https://dev.epicgames.com/documentation/en-us/fortnite/using-customizable-light-devices-in-fortnite-creative) devices
- 1 X [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative)device
- 1 X [Barrier](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative) device

## Overview of Tutorial Steps

Following is an overview of the steps you'll need to recreate this island and the ideal sequence:

1. Create a new island using a [starter island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#starter-island).
2. Add roads and scenery from the [Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gallery) in the Creative menu.
3. Add buildings from the [Prefabs](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
4. Add 12 [Player Spawn pads](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
5. Add 1 [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class-designer) device.
6. Add 120 [Target Dummy](https://dev.epicgames.com/documentation/en-us/fortnite/using-target-dummy-devices-in-fortnite-creative) device targets.
7. Add a [barrier](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#barrier) around the battle arena.
8. Edit the **My Island** options.

## Create Your Island

[![Creating your free-for-all target shooting game](https://dev.epicgames.com/community/api/documentation/image/2c5b3526-4ff4-4e4e-9484-c69eb67bb4b3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2c5b3526-4ff4-4e4e-9484-c69eb67bb4b3?resizing_type=fit)

Start with any [starter Island](building-your-first-island-in-fortnite-creative). The Meadow Island was used in this example. If you have an aesthetic in mind for your game, you can also build your own terrain on a [grid island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grid).

1. Approach the console next to your [golden rift](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#golden-rift) and press **E**.
2. Click **+Create New**.
3. Select the **Meadow Island** and click **Confirm**.
4. Name your island and click **Confirm**. You'll be transported to your new island through the golden rift.

The prefabs used in this example include:

- Houses from **Pleasant Park**
- Stores, arcades, and restaurants from **Retail Row**, **Paradise Palms**, and **Roadside**

  [![(Retail Row Prefabs)](https://dev.epicgames.com/community/api/documentation/image/0df2a205-408a-4ebc-8c59-08d64f4c3738?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0df2a205-408a-4ebc-8c59-08d64f4c3738?resizing_type=fit)

  *Click image to enlarge.*

It also has items from the [gallery](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gallery), such as:

- Streets and roads from **Street Gallery B**
- Trees and bushes from **Variant Foliage Gallery A**

  [![(Road Gallery)](https://dev.epicgames.com/community/api/documentation/image/dba9e308-f69f-4214-82d8-10cd9ce91811?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dba9e308-f69f-4214-82d8-10cd9ce91811?resizing_type=fit)

  *Click image to enlarge.*

## Plan and Place Prefabs and Gallery Pieces

Before building your arena, set your [Grid Snap](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grid-snap) level to 8. Begin by placing your buildings before the gallery road pieces. Once you've laid out your structures, add the road pieces around your buildings.

Adding road pieces around your buildings is easier than trying to fit buildings within the streets you create because buildings will have different depths and widths, which makes street planning difficult. Try to keep the space between your buildings two tiles wide to accommodate the road pieces.

Watch the memory bar as you lay out your arena. Prefabs use a lot of memory and could potentially slow the [frame rate](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#frame-rate) on your island. Don't crowd buildings together — players should be able to discover each other easily. Part of the fun in the game is for players to shoot each other to delay their opponents from collecting more points.

## Add Player Spawn Pads

Where you place the spawn pad is important because a player might spawn in a wall or a prop and fall out of the game. Place Player Spawn Pads inside buildings, and be sure the pad is placed in the middle of a [tile](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#tile) to ensure that the player can successfully join the game.

[![(Player Spawn Pad)](https://dev.epicgames.com/community/api/documentation/image/036c57b1-e1e6-42b0-ac34-b0e71e5cb911?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/036c57b1-e1e6-42b0-ac34-b0e71e5cb911?resizing_type=fit)

1. Press the **Tab** key to open the **Creative Menu**, then click **Devices > Customizable Light device > EQUIP** to add the Player Spawn Pad Device to your [Quick Bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-bar).
2. Also add the following devices:

   - Barrier device
   - Shooting Gallery device
   - Class Designer device
   - Player Spawn Pad device
3. Click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) your first spawn pad.
4. Edit the Player Spawn Pad **Visible during games** option to **No**.

   [![Player Spawn Pad options](https://dev.epicgames.com/community/api/documentation/image/6ece7f6b-f2c8-4b9a-93d7-e3027affda42?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6ece7f6b-f2c8-4b9a-93d7-e3027affda42?resizing_type=fit)

There's no need to modify any other settings on this device to make the game work.

Copy the spawn pad and paste 11 more on your island for a total of 12 Player Spawn Pads.

## Add Class a Designer Device

[![Place a Class Designer device](https://dev.epicgames.com/community/api/documentation/image/eb925813-84bc-4ce3-ac67-5698f99033e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb925813-84bc-4ce3-ac67-5698f99033e0?resizing_type=fit)

By adding a player class, you can provide a weapon to players who respawn so they don't have to find one when they reenter the game.

1. Place the Class Designer in the corner of your arena.
2. Press **Tab > Weapons**.
3. Select a Ranged Burst Assault Rifle, then click **EQUIP**.
4. Click, hold, and drag the item out of the [Equipment bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) until you see a [backpack icon](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#backpack-icon), then release. The item will automatically register in the Class Designer.
5. Customize the Class Designer options as shown below:

   [![Class Designer options](https://dev.epicgames.com/community/api/documentation/image/b198f1a4-c4fa-40ec-a9c2-393ea4cab65b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b198f1a4-c4fa-40ec-a9c2-393ea4cab65b?resizing_type=fit)

   | Options | Value | Explanation |
   | --- | --- | --- |
   | **Class Identifier** | 1 | Creates a new class. |
   | **Grant Items on Respawn** | Yes | Players will respawn with a weapon. |
   | **Equip Granted Item** | First Item | Players automatically equipped the first registered weapon, which is the Ranged Burst Assault Rifle. |
   | **Grant Ammo With Weapons** | No | There's no need to add ammo because you will set the Unlimited Ammo option to On. |
   | **Unlimited Ammo** | On | Weapons will have unlimited ammo. |

Make sure you click **OK** after changing your settings. Otherwise, your customized options will not be saved.

## Place Target Devices

Make shooting the targets more interesting by having a variety of target types for players to shoot at, and place them in a variety of places — out in the open, in windows, and partially hidden. On this island, there are three types of targets: standing still, hopping, and moving side to side.

Get the Shooting Target Gallery device from the **Devices** tab, then placing the device in the arena and edit the options for the first target. Next, place the target in your arena so you can copy and paste that model around, making small settings adjustments to create targets that are harder or easier to hit.

Repeat the process described above with the hopping and moving targets you create.

Make sure harder targets award more points.

[![(Targets)](https://dev.epicgames.com/community/api/documentation/image/d0220e0a-3f51-4ef0-9763-a849038cacfe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0220e0a-3f51-4ef0-9763-a849038cacfe?resizing_type=fit)

### Standing-Still Targets

[![Standing Still Target](https://dev.epicgames.com/community/api/documentation/image/1f159657-7d75-4faf-ad8f-4c7b41865293?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1f159657-7d75-4faf-ad8f-4c7b41865293?resizing_type=fit)

1. Press the **Tab** key to open the **Creative Menu**.
2. Click **Devices > Shooting Target Gallery** device to add the targets to your **Quick Bar**.
3. Click **Place Now** to go into **Create mode** on your island.
4. Use the following options for a standing-still target:

   [![Basic target options](https://dev.epicgames.com/community/api/documentation/image/70fd485b-438d-4303-ae8f-0d28eed804b4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/70fd485b-438d-4303-ae8f-0d28eed804b4?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Target Type** | Dancing | A variety of target faces were used for the standing targets in this game. |
   | **Score Value** | 2 | These targets have a lower point value because they are easy targets to hit and require the least amount of skill. |
   | **Score Bullseye Multiplier** | 2 | Multiplies the hit score by two. |
   | **Bullseye Size** | Small | Make the still targets challenging with a small bullseye. |
   | **Reset Time** | 30 Seconds | For this game, 30 seconds was the optimum reset time because the game lasts 5 minutes, so the targets are down long enough to encourage players to move on to another target rather than sit on one target to collect points. |

Use the same option settings below on all target types except Score Value.

### Hopping Targets

[![Hopping Target](https://dev.epicgames.com/community/api/documentation/image/cd418659-d801-4fb9-9e5e-78fb16b18b25?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cd418659-d801-4fb9-9e5e-78fb16b18b25?resizing_type=fit)

Set the following options for your hopping targets.

[![Hopping target options](https://dev.epicgames.com/community/api/documentation/image/b3c29107-4991-478d-9b60-1fcf36878ce4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3c29107-4991-478d-9b60-1fcf36878ce4?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Score Value** | 3 | Set to 3 because the hopping target requires a bit more skill to hit than the standing-still target. |
| **Bullseye** | Small | Smaller bullseye targets were added to make the hopping targets harder to shoot. |
| **Hopping Frequency Time** | 1 Second | Make the target more difficult to hit by setting the hopping frequency to 1 second. |

### Moving Targets

[![Moving Target](https://dev.epicgames.com/community/api/documentation/image/fc1dfeb5-ed2d-49f2-948b-48ea17966bb5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc1dfeb5-ed2d-49f2-948b-48ea17966bb5?resizing_type=fit)

Set the following options for your moving targets.

[![Moving target options](https://dev.epicgames.com/community/api/documentation/image/f770b684-457c-4cdf-a0c3-c9221ed66084?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f770b684-457c-4cdf-a0c3-c9221ed66084?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Length** | 2 | The number represents the number of tiles the target rail stretches across. |
| **Movement Start Range** | 1/2 | Sets the target's movement range to half a tile. |
| **Score Value** | 10 | Awards 10 points when knocked down. |

Place an equal amount of targets for each player within their area. You want players to discover each other while finding new targets.

## Place Customizable Light

It is pretty dark inside the buildings, which can make it hard to find targets. Place four lights per building near where you've placed targets that are partially hidden or are in dark corners of the structure.

[![Placing Customizable Light devices](https://dev.epicgames.com/community/api/documentation/image/61fad3f0-6eca-4dae-bdae-3ce83fa50c9e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/61fad3f0-6eca-4dae-bdae-3ce83fa50c9e?resizing_type=fit)

1. Place the first Customizable Light on the ceiling over a target.
2. Edit this light option:

   [![Customizable LIght options](https://dev.epicgames.com/community/api/documentation/image/521bdd87-5db4-4e4f-83de-ff00d512fbd0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/521bdd87-5db4-4e4f-83de-ff00d512fbd0?resizing_type=fit)

   | Options | Value | Explanation |
   | --- | --- | --- |
   | **Light Intensity** | 5% | 5% intensity provides enough light without being too bright for players. |

3. Copy the light and add 47 more in buildings where lighting is needed.

## Place the Barrier Device

The Barrier device keeps players within the boundaries of the arena. Without the Barrier device, players could potentially leave the game arena and get lost, causing them to lose the game.

[![(Barrier Device)](https://dev.epicgames.com/community/api/documentation/image/e198093e-0e94-4466-a545-75f39017a956?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e198093e-0e94-4466-a545-75f39017a956?resizing_type=fit)

1. Place the [Barrier device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) in the center of your arena.
2. Edit the barrier options.

   [![Barrier device options](https://dev.epicgames.com/community/api/documentation/image/c2dea9bb-bc4b-4fda-92e8-8e2cf769171b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c2dea9bb-bc4b-4fda-92e8-8e2cf769171b?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Style** | Invisible | Allows players to look around your island beyond the arena. |
   | **Zone Shape** | Box (Hollow) | If you don’t select the hollow box option, players will not be able to leave their spawn pads during the game. |
   | **Barrier Width** | 30 | 30 represents the number of tiles in the width of the barrier area. Your game can be wider, or slimmer depending on the map you create. |
   | **Barrier Depth** | 30 | 30 represents the number of tiles deep the barrier area is. |
   | **Barrier Height** | 20 | 20 represents the number of tiles tall the barrier area is. |

Press the **Spacebar** twice to fly up to where you can view the entire barrier to ensure it surrounds the area you intend to cover.

## Create a Chest and Loot Llama

Provide players with the opportunity to find better weapons by adding chests and loot llamas to the arena.

Go to the [Weapons](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) category of the Creative tools. To add weapons to a chest, do the following:

1. Go to the **Weapons** tab in the **Creative Inventory**.
2. Select the Rare **Tactical Assault Rifle** and click **Add to Chest.**
3. Continue to add the following weapons to your chest:

   - Epic Striker Pump Shotgun
   - Uncommon Makeshift Submachine Gun
4. Go to the **Items** tab in the **Creative Inventory**.
5. Select the **Small Shield Potion** and click **Add to Chest**.
6. Continue to add the following items to your chest:

   - Med Kit
   - Boogie Bomb
7. Click the **Chest > Create Chest** tab from the **Creative Inventory**.
8. Click **Back** to return to Create mode on your island. The chest you created will be in front of you.
9. Copy and paste your chest into buildings and partially hidden areas for players to find.

   [![Create a chest](https://dev.epicgames.com/community/api/documentation/image/8cdcdd84-4d6f-4d7f-af0a-d237c7f306b0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8cdcdd84-4d6f-4d7f-af0a-d237c7f306b0?resizing_type=fit)

To create a loot llama, do the following:

1. Select a **Legendary MK Seven Assault Rifle** and click **Add to Chest**.
2. Continue to add the following weapons to your loot llama:

   - Legendary Auto Shotgun
   - Legendary Machine Pistol
3. Click the **Items** tab in the **Creative Inventory**.
4. Select the **Med Mist** item then click **Add to Chest**.
5. Add the **Chug Splash** item to the llama next.
6. Click **Chest > Create Llama** from the **Creative Inventory**.
7. Click **Back**, you'll be in **Create mode** on your island and the loot llama you created will be in front of you.
8. Copy and paste your loot llama in between buildings and partially hidden areas for players to find.

   [![(Loot Llama)](https://dev.epicgames.com/community/api/documentation/image/6b4bb8f6-2cf5-476f-9389-a1f208b938bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b4bb8f6-2cf5-476f-9389-a1f208b938bc?resizing_type=fit)

## My Island Settings

Change the following settings in My Island to ensure that all players can enter the game, respawn, and experience a smooth transition from one round to the next.

### Game Menu

[![My Island Game menu](https://dev.epicgames.com/community/api/documentation/image/748eb45a-fcaa-4ec2-873f-93eb7a0aa0d8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/748eb45a-fcaa-4ec2-873f-93eb7a0aa0d8?resizing_type=fit)

| Options | Value | Explanation |
| --- | --- | --- |
| **Max Players** | 12 | Allows up to twelve players to enter the game. |
| **Default Class Identifier** | 1 | Identifies the class you created with the class designer device as the default class in the game. |
| **Total Rounds** | 5 | Create five rounds to complete one game. |
| **Join in Progress** | Spawn | Players can join a game in progress when a spawn pad is available. If a spawn pad isn’t available, the player will fall from the sky instead. |
| **Autostart** | Immediate | Starts the game immediately for all players. |
| **Elimination Score** | 5 | Players who eliminate another player receive five points. |

### Settings Menu

[![My Island Settings menu](https://dev.epicgames.com/community/api/documentation/image/921f0a24-08a0-4873-9d7e-68cd0c4bbe1c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/921f0a24-08a0-4873-9d7e-68cd0c4bbe1c?resizing_type=fit)

| Options | Value | Explanation |
| --- | --- | --- |
| **Time of Day** | 2:00 PM | Makes it daylight throughout the game. |
| **Fog Thickness** | 0% | No fog will be generated during gameplay. |
| **Enable Fire** | No | Weapons will not cause fire damage to structures and buildings. |
| **Infinite Resources** | Off | Resources are turned off for the game since there is no building happening. |
| **Show Wood Resources** | No | Does not show wood resource amounts in the Equipment Bar. |
| **Show Brick Resources** | No | Does not show brick resource amounts in the Equipment Bar. |
| **Show Metal Resources** | No | Does not show metal resource amounts in the Equipment Bar. |
| **Allow Building** | None | Prevents players from building structures in-game. |
| **Pickaxe Destruction** | None | Prevents players from doing damage to the environment and structures with their pickaxe. |
| **Spawn Immunity Time** | 5 Seconds | Give players who respawn into the game five seconds of immunity. |
| **Allow Sliding** | On | Allows players to slide and shoot during gameplay. |
| **Player Flight Sprint** | Off | Prevents players from using flight sprint. |

### UI Options

[![My Island UI options](https://dev.epicgames.com/community/api/documentation/image/2d806f52-0d18-4437-9d26-f117c0a3c38d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d806f52-0d18-4437-9d26-f117c0a3c38d?resizing_type=fit)

| Options | Value | Explanation |
| --- | --- | --- |
| **Game Score Display Time** | 6 Seconds | Displays the game score for 6 seconds. |
| **Round Winner Display Time** | Don’t Show | Does not show the round winner at the end of the round. |
| **Round Score Display Time** | Don’t Show | Does not show the round score at the end of the round. |
| **HUD Information Type** | Score | Shows the score on the HUD. |
| **Max Trackers on HUD** | 3 | Tracks three different types of information on the HUD device. |
| **Show Cumulative Stat Value on HUD** | Yes | Shows the cumulative points scored for each individual player in their HUD devices across all rounds. |
| **Win Condition** | Score | The highest score is the winning score condition. |
| **Tiebreaker 1** | Eliminated | How many opponents were eliminated by the players will be the tie-breaking condition. |

## Designer Tips

Here are some tips for changing or adding things to your island to change how the island plays out, or to create new games based on this island by changing various devices or settings.

### Create Teams

Use **Player Spawn Pads** to create teams, and add **Score Manager** devices to award points to teams based on which targets they eliminate.

1. Assign four Player Spawn Pads to Team One.
2. Set the **On Knock Down Transmit** option of the target to a channel that corresponds to the Score Manager device for Team One.
3. Copy and paste the target around the map.
4. Repeat the above steps for two more teams, and make sure there’s an equal amount of targets for each team to find and eliminate.

Using teams in the free-for-all playstyle would be great on a larger map. You might also want to think about adding a domination factor to the gameplay by adding [Capture Area devices](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
