# PinBrawl Island Tutorial

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/pinbrawl-island-tutorial-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:28:31.323279

---

PinBrawl is not a solo game and is meant to be played with two to four players.

In this three-part tutorial, you will create an angled pinball stage along with a brawl arena and a pre-game lobby. Players will use the **Baller Device** to run over coins and collect as much gold as they can. This gold can be used to purchase weapons for the final brawl.

Players will start their gameplay in the pre-game lobby and learn the rules of the game while they wait. After the autostart, players will respawn on the pinball arena and automatically teleport into their Baller vehicles. They can then use the vehicle to collect as many coins as they can.

The pinball round will last for two minutes. After the round ends, players will be teleported out of their vehicles and into the brawl arena. In the brawl arena, players will rush to purchase weapons and then battle for victory.

The [island code](playing-games-in-fortnite-creative) for this tutorial is **5433-9518-6615**.

To play through this island, click **CHANGE** in the **Fortnite Lobby** screen. On the Discover screen, click the **Island Code tab** and enter the code for the Hoverboard Racing Island. Once you've seen all the gameplay features, you can explore this tutorial and recreate it on your own island.

## Devices Used

The following devices were used to create this gameplay:

- 8 x [Player Spawn Pad](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 4 x [Player Reference](using-player-reference-devices-in-fortnite-creative)
- 4 x [Baller Spawner](using-baller-spawner-devices-in-fortnite-creative)
- 20 x [Pinball Bumper](https://dev.epicgames.com/documentation/en-us/fortnite/using-pinball-bumper-devices-in-fortnite-creative)
- 20 x [Pinball Flipper](https://dev.epicgames.com/documentation/en-us/fortnite/using-pinball-flipper-devices-in-fortnite-creative)
- 50 x [Collectibles Gallery](using-collectible-object-devices-in-fortnite-creative)
- 4 x [Teleporter](using-teleporter-devices-in-fortnite-creative)
- 5 x [Barrier](using-barrier-devices-in-fortnite-creative)
- 1 x [Timed Objective](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)
- 5 x [Item Granter](using-item-granter-devices-in-fortnite-creative)
- 1 x [HUD Controller Device](using-hud-controller-devices-in-fortnite-creative)
- 2 x [HUD Message Device](using-hud-message-devices-in-fortnite-creative)
- 4 x [Vending Machine](https://dev.epicgames.com/documentation/en-us/fortnite/using-vending-machine-devices-in-fortnite-creative)
- 2 x [Item Spawner](using-item-spawner-devices-in-fortnite-creative)

## Props, Prefabs, and Galleries

A variety of props and Gallery items were used to design this island. When recreating this island, test your creativity by envisioning a theme while mixing and matching items from various categories.

Be sure to fill any open areas with appealing props and terrains like grass and trees.

## Overview of Tutorial Steps

1. Create a new island using a [starter island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#starter-island).
2. Customize the island settings.
3. Setting up the pre-game lobby.
4. Setting up the pinball arena.
5. Setting up background devices.
6. Set up the brawl arena devices.
7. Set up the brawl devices.

## Create Your Island

To [build your island](https://mediaspace.unrealengine.com/media/Creating+an+Island/1_mi1aqt1y/208434573), use the following steps.

1. Find your personal rift in the main HUB. Your personal rift will be indicated by a golden glow.

   [![Game Creation Window](https://dev.epicgames.com/community/api/documentation/image/ebb9b580-2f1d-4c63-a4fb-a4e3f1f91a2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ebb9b580-2f1d-4c63-a4fb-a4e3f1f91a2e?resizing_type=fit)
2. Use the console next to your rift to create a new island. Press **E** to enter the **GAME CREATION** screen and select **CREATE NEW**.

   [![Select Island Grid](https://dev.epicgames.com/community/api/documentation/image/7bf94f62-7f22-476b-b112-cd6802e2a556?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7bf94f62-7f22-476b-b112-cd6802e2a556?resizing_type=fit)
3. Under the tab **STARTER ISLAND**, there are three grid islands that vary by memory allocation (GRID ISLAND, LARGE GRID ISLAND, or XL GRID ISLAND).
4. For this tutorial, choose GRID ISLAND.
5. After you select **CONFIRM**, choose a name for your island, then select **CONFIRM** again.

The portal will automatically load and teleport you into the island.

Be sure to check out our short [video tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-video-tutorials) to learn more about the beginning steps to create your island.

## Customize the Island Settings

You can increase the numbers for **Max Players** to add more players. If you increase the player size, you will have to also increase the size of the pinball arena. In addition, you will have to increase the number of **Player Spawn Pads**, **Baller Devices**, **Teleporters**, and **Vending Machines** to match.

To modify gameplay settings, press the **TAB** key. From the upper **MY ISLAND** tab, you can access the tabs GAME, SETTINGS and UI.

[![My Island Menus](https://dev.epicgames.com/community/api/documentation/image/357c4457-57a8-4cc9-88e3-154b7a38a63a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/357c4457-57a8-4cc9-88e3-154b7a38a63a?resizing_type=fit)

### My Island - Game

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Max Players** | 4 | Only four players can join the game. |
| **Spawn Limit** | 1 | Players can not respawn after elimination. |
| **Last Standing Ends Game** | On | Sets it so the last player standing wins the game. |
| **Autostart** | 60 Seconds | Sets the amount of time players will stay in the Pre-Game lobby. Only applies to Published islands. |
| **Game Start Countdown** | 10 Seconds | Sets the start countdown to 10 seconds. |
| **Vehicle Trick Score Multiplier** | 0.0 | Disables vehicle scores. |
| **Vehicle Impacts Damage Objects** | No | Disables the Baller Device from destroying structures. |
| **Vehicle Impacts Damage Vehicles** | No | Disables the Baller Devices from damaging each other. |

### My Island - Settings

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Infinite Ammo** | On | Players will not have to restock on ammo during gameplay. |
| **Infinite Resources** | Off | Players will only have the resources they collect during gameplay. |
| **Allow Building** | None | Disables players from building during gameplay. |
| **Building Can Destroy Environment** | No | Disables player-built structures from destroying the environment. |
| **Environment Damage** | Off | Disables players from destroying the environment. |
| **Allow Item Drop** | No | Players can not drop items from their inventories. |
| **Always Show Name Plates** | Always Hide | Player locations will be hidden during gameplay. |
| **Allow Manual Respawning** | No | Players can not respawn into the game. |
| **Show Wood Resource Count** | No | Wood resources will not be shown on the HUD. |
| **Show Stone Resource Count** | No | Stone resources will not be shown on the HUD. |
| **Show Metal Resource Count** | No | Metal resources will not be shown on the HUD. |
| **Show Gold Resource Count** | Yes | The player's Gold amount will be shown on the HUD. |

### My Island - UI

| Modified Setting | Option | Explanation |
| --- | --- | --- |
| **Round Win Condition** | Time Alive | The last player alive wins the game. |

## Setting Up Pinball Devices

[![Pinball Arena Device Overview](https://dev.epicgames.com/community/api/documentation/image/b8f63215-68ab-42f8-979a-ba4148789fd2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b8f63215-68ab-42f8-979a-ba4148789fd2?resizing_type=fit)

*Use the photo as a visual reference on device placement and creative possibilities.*

In this section, you will use the following devices:

- **Player Spawn Pad**
- **Baller Device**
- **Pinball Bumper**
- **Pinball Flipper**
- **Collectibles Gallery**
- **Barrier Device**

### Player Spawn Pad

Begin by placing and customizing the spawn pads for the pinball’s spawn area.

[![Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/800aee67-3842-419e-8646-d3539fb22850?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/800aee67-3842-419e-8646-d3539fb22850?resizing_type=fit)

1. Press the **Tab** key to open the **Creative** menu, then click the **Devices** tab.
2. Locate **Player Spawn Pad**, then click PLACE NOW, and [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) it in front of your billboards.

   1. Customize its options as shown below.

   [![Player Spawn Settings](https://dev.epicgames.com/community/api/documentation/image/fec97a56-cf5c-479b-99dc-ba1425d4b983?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fec97a56-cf5c-479b-99dc-ba1425d4b983?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Priority Group** | Primary | Once the game countdown finishes, players will spawn on the pads set as primary. |
   | **Use As Island Start** | No | Players will not initially spawn on these pads. They will instead spawn in the pre-game lobby. |
   | **Visible During Games** | No | This device will be invisible during gameplay. |
   | **When Player Spawned Transmit On** | Channel 1 | A signal will be sent to another device that will receive the signal and then trigger an action. Each pad will have a different channel number. |
3. With your phone tool equipped, right-click to copy the spawn pads and place them a good distance apart from each other.

   a. For each pad, change the setting **When Player Spawned Transmit On** to a new, unused channel. For example, the second spawn pad will be set to Channel 2 and the third pad will be set to Channel 3.

In the bottom right corner of the **My Island** tab, click **Channel Browser** to view used channels.

This step is important as it sets the device to send a signal to the baller vehicle that automatically pushes players into it. After the game countdown, players will automatically sit in the device.

### Baller Spawner

You will now place and customize the **Baller Spawner**.

[![Baller Device](https://dev.epicgames.com/community/api/documentation/image/be08e886-bca6-4e4b-8a0e-fe793e171d60?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/be08e886-bca6-4e4b-8a0e-fe793e171d60?resizing_type=fit)

1. Customize its options as shown below.

   [![Baller Device Modified Settings](https://dev.epicgames.com/community/api/documentation/image/eca6718a-2e69-4124-90e8-b91d7e9baa57?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eca6718a-2e69-4124-90e8-b91d7e9baa57?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Assigns Driver When Receiving From** | Channel 1 | Players will be pushed into the vehicle after receiving the signal sent from the Player Spawn Pad. The channels should match the corresponding spawn pad. |
   | **Disable When Receiving From** | Channel 5 | Players will be pushed into the vehicle after receiving the signal sent from the Player Spawn Pad. The channels should match the corresponding spawn pad. |
   | **When Players Exit Vehicle Transmit On** | Channel 1 | Players will be pushed back into the vehicle if they try to exit. |

### Designer Tips

For **Assigns Driver When Receiving From**, each Baller spawner should have a channel number corresponding to its Player Spawn Pad’s **When Player Spawned Transmit On** option.

When a player spawns from the pad it will transmit a signal that will be sent to the receiving device, the Baller Spawner.

### Pinball Bumper

You will next locate and place the Pinball Bumper.

[![Pinball Bumper Device](https://dev.epicgames.com/community/api/documentation/image/391503f3-04f6-4b9b-8927-edab42c9bf2d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/391503f3-04f6-4b9b-8927-edab42c9bf2d?resizing_type=fit)

1. Equip the **Pinball Bumper** and hold the right mouse button to change the Quick Menu options.
2. Press **Tab** to select **Resize Axis [All]** if not already selected and then hold **R** to grow the item to its maximum size.

   1a. Hold the right mouse button again to change the sidebar options again.

   [![Pinball Bumper Rotation](https://dev.epicgames.com/community/api/documentation/image/9637a6e8-268d-4a68-9362-ce251ff08462?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9637a6e8-268d-4a68-9362-ce251ff08462?resizing_type=fit)

   b. Press **Tab** to change the **Rotation Axis** to **[Roll]** and angle the piece to match your floor.
3. Customize its options as shown below.

   [![Pinball Bumper](https://dev.epicgames.com/community/api/documentation/image/132e3120-f78e-4adc-ac40-0cc1be5e85e8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/132e3120-f78e-4adc-ac40-0cc1be5e85e8?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Knockback** | Very High | Vehicles will have a high knockback when triggering the device. |
   | **Bumper Color** | Alternate the bumper colors to add visual variety in your arena. | Changes the color of the bumper. |

The pinball devices are set to have high knockbacks so players can be launched into the air and use their grappling tools to swing. There is no set amount of Pinball Bumpers to place.

### Pinball Flipper

You will now locate and place the Pinball Flipper.

[![Pinball Flipper Device](https://dev.epicgames.com/community/api/documentation/image/4d8e5d3a-64cc-4fd9-9970-ccf3ee29d3e2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d8e5d3a-64cc-4fd9-9970-ccf3ee29d3e2?resizing_type=fit)

1. Equipped the **Pinball Flipper** and hold the right mouse button to change the sidebar options.
2. Press **Tab** to select **Resize Axis [All]** if not already selected and then hold **R** to grow the item to its maximum size.

   a. Hold the right mouse button again to change the sidebar options again.

   b. Press **Tab** to change the **Rotation Axis** to **[Roll]** and angle the piece to match your floor.
3. Customize its options as shown below.

   [![Pinball Flipper Modified Settings](https://dev.epicgames.com/community/api/documentation/image/3cf37821-9ffd-4bac-b7f6-63e524e71747?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3cf37821-9ffd-4bac-b7f6-63e524e71747?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Flip Direction** | Flip Flop | The flipper will switch directions when triggered. |
   | **On Triggered Knockback** | Mega High | Vehicles will have a strong knockback when triggering the device. |
   | **On Bump Knockback** | Super High | When the flipper is triggered by proximity, the vehicle will have a strong knockback. |
   | **Flipper Color** | Alternate the flipper colors to add visual variety in your arena. | Changes the color of the flippers. |
   | **Knockup Amount** | Super High | Vehicles will be launched high after triggering the device. |

There is no set amount of Pinball Flippers to place. With both the Pinball Bumper and Flipper customized, use your phone tool to copy and paste both devices in a unique pattern to serve as an obstacle.

### Collectibles Gallery

Next, select the Collectibles Gallery devices that players will run over to collect for gold.

[![Collectibles Gallery](https://dev.epicgames.com/community/api/documentation/image/db800073-c027-46e0-9c14-059867db7afb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/db800073-c027-46e0-9c14-059867db7afb?resizing_type=fit)

1. Locate **Collectibles Gallery**, then click PLACE NOW, and place it outside of the pinball arena.

   a. Pull one item from the gallery.
2. Customize its options as shown below.

   [![Collectibles Gallery Modified Settings](https://dev.epicgames.com/community/api/documentation/image/8b62bc5b-0607-40eb-8a72-33bf2615abc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b62bc5b-0607-40eb-8a72-33bf2615abc0?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Collectible Object** | Coin | We will use the coin item from this gallery. |
   | **Score** | 0 | Players will not receive a score from picking up this item. |
   | **When Collected Transmit On** | Channel 7 | A signal will be sent to the device that grants gold once players collect the item. |
3. Delete the unused gallery items.
4. Distribute the items along the pinball arena for players to collect. You can also place them in the air for players to collect while in the air.

   [![Distributed Collectibles Coin](https://dev.epicgames.com/community/api/documentation/image/b5dd7c1d-b6aa-4f12-9684-67ae60a5b15f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b5dd7c1d-b6aa-4f12-9684-67ae60a5b15f?resizing_type=fit)

There is no set amount of collectible items to place.

### Designer Tips

For your pinball arena, try to create challenges for overachieving players. Reward these players with special items like status buff items or extra gold. Play around with props and items from the **Gallery** tab to offer these challenges.

[![Arena challenges](https://dev.epicgames.com/community/api/documentation/image/77fe6ec0-457a-4214-802d-cf7d66272ba0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/77fe6ec0-457a-4214-802d-cf7d66272ba0?resizing_type=fit)

In the photo above, rings from the **Galleries** tabs are used as a base for players to grapple as they aim for coins.

You can type **Ring Gallery A** in the **Galleries** search tab to use the pieces in this example.

### Barrier Devices

The last step in the pinbrawl area is to add the Barrier devices that will hold players in the pinbrawl arena.

[![Barrier Device](https://dev.epicgames.com/community/api/documentation/image/a55f1076-f8c5-40f2-97d2-0ce2595decdc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a55f1076-f8c5-40f2-97d2-0ce2595decdc?resizing_type=fit)

1. Locate **Barrier**, then click PLACE NOW, and place one device on the top of the walls you placed.

   a. Align the Barrier’s arrow with the edge of the wall similar to the photo below.

   [![Aligning Barriers](https://dev.epicgames.com/community/api/documentation/image/d9fbaeff-d8b6-476f-8369-47dc81e2bd21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d9fbaeff-d8b6-476f-8369-47dc81e2bd21?resizing_type=fit)
2. Customize its options as shown below.

   [![Barrier Device Modified Settings](https://dev.epicgames.com/community/api/documentation/image/fd4ab52f-db8e-4084-b9b9-de28b1108862?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fd4ab52f-db8e-4084-b9b9-de28b1108862?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Style** | Dreamy Sky | This can either be set to **Invisible** or as a visual element for players to experience. |
   | **Barrier Width** | 0.05 | The wall barriers should be as thin as possible. |
   | **Barrier Depth** | This number is the amount of tiles long your arena is. | The barrier will be long enough to cover the entire wall. |
   | **Barrier Height** | 6 | The side barriers will be high enough to extend to the top barrier. |
3. Copy this device and paste it on the opposite wall, adjust the depth as needed.

   a. Repeat this step along the base of your arena to create a thin barrier that covers the length of your arena.

   b. Create a thin barrier that extends to the edge of the roof you created when building the arena. This barrier should cross with the three barriers placed before.

[![Completed Barrier Placement](https://dev.epicgames.com/community/api/documentation/image/3cc3a017-7c30-4f41-929a-70b2caae2701?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3cc3a017-7c30-4f41-929a-70b2caae2701?resizing_type=fit)

With these devices, players cannot fly off of the arena as they swing and boost with their vehicles.

### Designer Tips

Since players launch and fall from great heights, decorate the arena with a boundary to reassure players they wont fall off the arena.

It may be overwhelming for players to fall and launch at great heights with sky visuals. Assure players they won’t fall off the map by offering boundaries in the arena like in the photo below. They won't know there's a barrier device placed to keep them safe inside.

[![Arena Boundary](https://dev.epicgames.com/community/api/documentation/image/d4004f48-4a03-4907-91a7-4c278bc6057c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d4004f48-4a03-4907-91a7-4c278bc6057c?resizing_type=fit)

Try adding colorful lights to your arena by using **Beacons** from the **Lights** category in the GALLERIES tab.

Especially if you placed **Music Blocks** as floor pieces when building the arena, use audio devices like **Radio** to play tunes throughout your arena. If you do, the radio will trigger visual effects with the music blocks.

## Setting Up Background Devices

You will use the following devices in this section:

- **Item Granter**
- **Gold (Item)**
- **Timed Objective**
- **Player Reference**
- **HUD Controller**

There are many background devices that drive gameplay. These devices should not be seen by players. Place these devices in a hidden area.

### Item Granter

Head to a spot underneath your pinball arena to set up the Item Granter that will grant players gold.

[![Item Granter](https://dev.epicgames.com/community/api/documentation/image/38d4463b-1b7b-4374-962a-a884a5cfb7f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38d4463b-1b7b-4374-962a-a884a5cfb7f4?resizing_type=fit)

1. Locate **Item Granter**, then click PLACE NOW, and place the device on the ground.
2. Customize its options as shown below.

   [![Item Granter Modified Settings](https://dev.epicgames.com/community/api/documentation/image/bbec97de-01e6-4e4c-b941-6c4112ee8961?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bbec97de-01e6-4e4c-b941-6c4112ee8961?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **On-Grant Action** | Keep All | The equipped gold will accumulate and increase in the player’s inventory. |
   | **Grant Item When Receiving From** | Channel 7 | When the Collectibles Gallery’s coin is picked up, it will send a signal to this device, which will grant gold. |

Next, you will [register](https://mediaspace.unrealengine.com/media/RegisteringCraftingConsumablesinFortniteCreative/1_zpmj3v0g) gold to this device that wil be granted from triggering players.

[![Gold Consumable](https://dev.epicgames.com/community/api/documentation/image/1919a446-45d9-468b-8423-127025eb235c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1919a446-45d9-468b-8423-127025eb235c?resizing_type=fit)

1. Select **Gold** from the **Items** tab of the **Creative Inventory** then move to an empty area.
2. Press the **Tab** key to open the **Creative** menu, then click the **Play** tab.
3. Click the equipped gold and press **Z** to split the stack of 500 until you have 63 left in your inventory. The unequipped stack will fall to the ground.
4. Stand beside the Item Granter and drop the remaining gold to register it to the device.

[![Registering Gold to Item Granter](https://dev.epicgames.com/community/api/documentation/image/7b5c8538-5974-4a0c-94a4-5510e80b43aa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7b5c8538-5974-4a0c-94a4-5510e80b43aa?resizing_type=fit)

### Designer Tips

If you have added challenges to your arena, reward the players who overachieve with status buffs like **Slurp Mushroom** and **Jelly Bean** that will aid their gameplay.

To do so repeat the steps above to offer as an aiding reward. You can use a new item from the Collectibles Gallery to represent the rewarding items.

Be sure to place new Item Granters on unused channels for the setting **Grant Items When Receiving From**. This channel should match the setting **When Item Picked Up Transmit On** for the Collectibles Gallery item that you chose.

### Timed Objective

Next, add the Timed Objective that will end the pinball round and transmit a signal that will push players to the brawl arena.

[![Timed Objective Device](https://dev.epicgames.com/community/api/documentation/image/891616a5-a569-4476-a655-47295e4c4f93?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/891616a5-a569-4476-a655-47295e4c4f93?resizing_type=fit)

1. Locate **Timed Objective**, then click PLACE NOW, and place it on the ground.
2. Customize its options as shown below.

   [![Timed Objective Modified Settings](https://dev.epicgames.com/community/api/documentation/image/d23f066d-2ecb-47c5-b8fd-4842875dfb87?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d23f066d-2ecb-47c5-b8fd-4842875dfb87?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Start When Round Starts** | Yes | The timer will begin to count down as soon as the round begins. |
   | **Time** | 2.5 Minutes | This is the duration the timer will count for. |
   | **Timer Label Text** | Time left to collect coins: | This is the header text for the countdown's HUD. |
   | **When Started Transmit On** | Channel 6 | The timer will trigger the Player Reference device to activate. |
   | **When Completed Transmit On** | Channel 5 | A signal will be sent to stop the Item Granter from granting coins. |

Next, you will connect the Timed Objective device to the Player Reference. This will allow the Player Reference to activate and become the representing device for players.

### Designer Tips

Players are only able to directly send signals to devices through triggering, like pressing a button or standing on the device. Since players are not able transmit indirect signals during gameplay, the Player Reference device can serve as a spokesperson for the player and send the required signal onced triggered by another device.

### Player Reference

Select and place Player Reference devices that will represent each player.

[![Player Reference Device](https://dev.epicgames.com/community/api/documentation/image/5beb72e1-b310-43ea-b7af-41bef24742b0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5beb72e1-b310-43ea-b7af-41bef24742b0?resizing_type=fit)

1. Locate **Player Reference**, then click PLACE NOW, and place it on the ground.
2. Customize its options as shown below.

   [![Player Reference Modified Settings](https://dev.epicgames.com/community/api/documentation/image/00a51986-1a96-484e-bc09-dbcb7bbff675?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00a51986-1a96-484e-bc09-dbcb7bbff675?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Show Base** | No | There are no sequencers to activate this device. |
   | **Play Audio** | No | This device will not be heard by players. |
   | **Register Player When Receiving From** | Channel 1-4 | The player spawn pad will send a signal to their Player Reference devices when they spawn. Each device will have a different channel ranging from channel 1 to 4. For example, one device will have this setting for Channel 1 and another will have this setting for Channel 2. For the spawn pads set on the pinball arena, match the setting **When Player Spawned Transmit On** to this channel. |
   | **Activate When Receiving From** | Channel 5 | The timer activates this device when it completes to transmit a signal that will teleport the player. |
   | **Enable When Receiving From** | Channel 6 | The player’s information is stored in this device when the timer begins. |
   | **When Activated Transmit On** | Channel 10-13 | The ending timer will activate this device, which will then send a signal for players to teleport to the brawl arena. Each device will have a different channel ranging from channel 10 to 13. For example, one device will have this setting for Channel 10 and another will have this setting for Channel 11 and so forth. |
3. Copy this device three more times. All four of the devices should have a different channel ranging from 1 to 4 for the setting **Register Player When Receiving From**. These devices should also have a different channel ranging from 10 to 13 for the setting **When Activated Transmit On**.

Step 4 is important for teleporting your players to the next area.

### HUD Controller Device

Next, select and place the HUD Controller device. This device will control which core pieces of information will show on the player’s screen.

By using this device, you can set it so only the information that’s relevant to your gameplay will show and hide information that’s not needed.

[![HUD Controller Device](https://dev.epicgames.com/community/api/documentation/image/b4a58c70-7302-4507-8b1d-8a20e87f465e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b4a58c70-7302-4507-8b1d-8a20e87f465e?resizing_type=fit)

1. Locate **HUD Controller Device**, then click PLACE NOW, and place it on the ground.
2. Customize its options as shown below.

   [![HUD Controller Modified Settings](https://dev.epicgames.com/community/api/documentation/image/2985f885-9523-4b49-88b7-cbaab01afeca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2985f885-9523-4b49-88b7-cbaab01afeca?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Show Mini Map** | No | The minimap is not needed for this gameplay. |

## Setting Brawl Arena Devices

[![Brawl Room Device Overview](https://dev.epicgames.com/community/api/documentation/image/46c2f46a-6355-4d1a-afc2-d8e1cf7c081a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/46c2f46a-6355-4d1a-afc2-d8e1cf7c081a?resizing_type=fit)

In this section, you will use the following devices:

- **Teleporter**
- **Vending Machine**

Start by selecting the teleporters that will connect to the Player Reference Pads. When triggered from the Timer, the Player Reference Device will send a signal to these teleports that will transfer players to various locations in your brawl arena.

### Teleporter

Start by equipping and placing the Teleporter.

[![Teleporter Device](https://dev.epicgames.com/community/api/documentation/image/9db7c0ca-b873-4023-8eef-14007f586ac8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9db7c0ca-b873-4023-8eef-14007f586ac8?resizing_type=fit)

1. Locate **Teleporter**, then click PLACE NOW, and place it on the ground.
2. Customize its options as shown below.

   [![Teleporter Modified Settings](https://dev.epicgames.com/community/api/documentation/image/4edfcaca-e122-483a-a4a3-53aa9d7621b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4edfcaca-e122-483a-a4a3-53aa9d7621b2?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Teleporter Group** | None | There is no group that can use this device. |
   | **Teleporter Target Group** | None | There is no group that can use this device. |
   | **Teleport To When Receiving From** | Channel 10-13 | Players will teleport to the placed location when receiving a signal from the Player Spawn Pad. Each Teleporter will have a different channel ranging from 10 to 13. For example, one Teleporter will be set to Channel 10 and another will be set to Channel 11. |

### Vending Machine

Place the Vending Machine and select weapons to register them to the device.

[![Vending Machine Device](https://dev.epicgames.com/community/api/documentation/image/1539b7ce-7062-40a2-b2cc-14c25f0f103b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1539b7ce-7062-40a2-b2cc-14c25f0f103b?resizing_type=fit)

1. Locate **Vending Machine**, then click PLACE NOW, and place it on the ground, standing directly beside it.
2. Customize its options as shown below.

   [![Vending Machine Modified Settings](https://dev.epicgames.com/community/api/documentation/image/a56528f7-73e2-44b0-abc7-8a18ab7750b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a56528f7-73e2-44b0-abc7-8a18ab7750b2?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **First Item Resource Type** | Gold | The first weapon can be purchased with gold. |
   | **Cost of First Item** | 650 | The first weapon will be the highest costing item. |
   | **Second Item Resource Type** | Gold | The second weapon can be purchased with gold. |
   | **Cost of First Item** | 420 | The second weapon will be easier to purchase. |
   | **Third Item Resource Type** | Gold | The third weapon can be purchased with gold. |
   | **Cost of Third Item** | 200 | The third weapon will be the easiest to purchase. |
3. Press the **Tab** key to open the **Creative** menu, then click the **Weapons** tab.

   a. Select and equip the **Mythic** quality **Skye’s Assault Rifle**, **Epic** quality **Compact SMG**, and the **Uncommon** quality **Combat Assault Rifle**.
4. Press the **Tab** key to open the **Play** menu.

   a. Drag the **Mythic** quality weapon from your Loadout bar until you see a backpack icon appear to register it as your first item.

   b. Drag the **Epic** quality weapon from your Loadout bar until you see a backpack icon appear to register it as your second item.

   c. Drag the **Uncommon** quality weapon from your Loadout bar until you see a backpack icon appear to register it as your third item.

The Vending Machine should now rotate a display of each weapon with their corresponding gold cost.

You have now completed building and setting up the brawl arena. The last step is to set up the pre-game lobby where players will initially spawn during gameplay.

### Designer Tips

You can edit this step to use only one weapon per Vending Machine. This way, players can purchase weapons faster.

You could also use the [**Conditional Button**](using-conditional-button-devices-in-fortnite-creative) and Item Spawner instead of the Vending Machine. This pair of devices can be used for faster weapon granting as well.

You can also alter the required gold for each weapon to match the amount of gold granted per coin on your arena.

## Setting Up the Pre-Game Lobby

[![Pre-Game Devices Overview](https://dev.epicgames.com/community/api/documentation/image/3c65c3e4-7594-4b09-b100-726fece9fd7f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c65c3e4-7594-4b09-b100-726fece9fd7f?resizing_type=fit)

*This photo can be used as a visual reference on device placement and creative possibilities.*

You will use the following devices in this section:

- **Billboard**
- **Player Spawn Pad**

### Billboard Device

Begin by placing and customizing the billboard devices.

[![Billboard Device](https://dev.epicgames.com/community/api/documentation/image/de046455-bf49-4b99-a550-7abde3afabe2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de046455-bf49-4b99-a550-7abde3afabe2?resizing_type=fit)

1. Locate **Billboard**, then click PLACE NOW, and place your first billboard on a wall.
2. Customize its options as shown below.

   [![Billboard Device Modified Settings](https://dev.epicgames.com/community/api/documentation/image/e9855371-1977-431c-8de9-444dfa36006e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9855371-1977-431c-8de9-444dfa36006e?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Text** | Collect the coins. Press "E" to grapple. Press Spacebar to boost. | This text communicates the game rules to players. |
   | **Text Size** | Large | This creates text that is large enough to catch the player's attention. |
   | **Text Font** | Roberto | This adds a font style to the text. |
   | **Outline** | Light | The black outline around each letter will be light in weight. |
   | **Text Color** | Lavender Purple | This color shows as a dim white that’s not too bright on the eyes. |
3. Equip your phone tool and right-click to copy the billboard.

   a. Place the copied billboard beside the first one.
4. Change the **Text** option to the value shown below.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Text** | After teleporting, use your coins to purchase a weapon. The last player standing wins! | This text communicates the second half of game rules to players. |

Repeat steps 2 - 3 on the opposite wall.

### Designer Tips

Billboards are an excellent way for Creators to relay information to players as free-standing text. When placing billboards, you want to make sure your text is unobstructed and clear for players to easily read.

### Player Spawn Pads

Next you will place and customize the Player Spawn Pads.

[![Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/149a01e0-8124-4c37-a7ee-fbb32d6180ed?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/149a01e0-8124-4c37-a7ee-fbb32d6180ed?resizing_type=fit)

1. Locate **Player Spawn Pad**, then click PLACE NOW, and place it in front of your billboards.
2. Customize its options as shown below.

   [![Player Spawn Pad Modified Settings](https://dev.epicgames.com/community/api/documentation/image/eb883324-e22f-499c-a3b3-6e38bbb388c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb883324-e22f-499c-a3b3-6e38bbb388c2?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Team** | None | Players will not be assigned spawn pads. |
   | **Priority Group** | Secondary | The secondary pads are used as a backup spawn from the primary pads. |
   | **Visible During Games** | No | The spawn pads will be hidden during gameplay. |
3. Equip your phone tool and right-click to copy the player spawn pad.

   a. Paste one spawn pad beside the one you just placed.
4. Repeat step 4 by placing two spawn pads on the opposite wall.

When players load into the game, they will be immediately introduced to the game rules you provided on the billboards. Effectively communicating game rules will allow for players to enjoy the gameplay with no frustrations.

### Designer Tips

When communicating game rules, be brief and specific with your text. Try to avoid displaying a long message on one billboard.

Add props from the **PreFabs** and **Galleries** tab to decorate your lobby with items that best fit your theme. Add devices like **Customizable Light** to lighten dark areas in your structures.

You have now completed the Pinbrawl Tutorial.
