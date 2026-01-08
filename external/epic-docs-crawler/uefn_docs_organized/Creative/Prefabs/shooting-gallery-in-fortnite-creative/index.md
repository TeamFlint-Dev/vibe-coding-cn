# Shooting Gallery

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/shooting-gallery-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:53:44.535987

---

## Island Description

This tutorial shows you how to set up all the devices for a **Shooting Gallery**. This is a game mode where players hit targets to increase their score before the timer runs out. The tutorial also features some designer tips that can improve [gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gameplay).

The [island code](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#island-code) for this tutorial is **7321-1576-4110**. To take a look, from the Fortnite Lobby click **CHANGE** above the PLAY button to open the Discover screen. Click **ISLAND CODE**, type in the code and press **Enter**. A screen displays with information about the island. Click **PLAY** to start the game.

Explore the different features, then come back to this tutorial to see how it was created. As you follow along, you will build your own Shooting Gallery from scratch. The tutorial will explain each element in the build and why it is included.

## Devices Used

These devices were used for this gameplay example:

- 1 x [Player Spawner device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device
- 2 x [Item Spawner](using-item-spawner-devices-in-fortnite-creative) devices
- 1 x [Button](using-button-devices-in-fortnite-creative) device
- 1 x [End Game](using-end-game-devices-in-fortnite-creative) device
- 1 x [Timed Objective](using-timed-objective-devices-in-fortnite-creative) device
- 1 x [Barrier](using-barrier-devices-in-fortnite-creative) device
- 5 x [Target Dummy](https://dev.epicgames.com/documentation/en-us/fortnite/using-target-dummy-devices-in-fortnite-creative) devices

## Overview of the Tutorial Steps

Below is an overview of the steps you'll need to accurately recreate this island:

1. Create a new island using a [starter island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#starter-island).
2. Add and set up a Player Spawn Pad close to the firing line.
3. Add and set up two Item Spawners.
4. Add and set up an Item Granter.
5. Add and set up the Button device.
6. Add and set up the End Game device.
7. Add and set up the Timed Objective device.
8. Add and set up the Barrier device.
9. Add and set up the Shooting Range Gallery devices.
10. Change the **My Island** settings to set up the game.

## Create Your Island

Start with the **Grid Island** as your starter island. This tutorial uses **prefabs** and **galleries** from the **Tilted Towers** category, but any theme you pick will work. Which building pieces you use depends on the style of the game you want to create, so there is a lot of room for creativity here.

There are three main areas to consider in a shooting gallery: a spawn area where the player can gather their weapons, a firing line for the player to shoot their weapon from, and finally, an area for the target dummies. Add a barrier to prevent the player from getting too close to the targets.

[![shoot-those-dummies](https://dev.epicgames.com/community/api/documentation/image/51e1ffd5-5948-4e45-aba7-701e73375719?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/51e1ffd5-5948-4e45-aba7-701e73375719?resizing_type=fit)

## Add and Set up a Player Spawn Pad

Once you finish setting up your island, add a **Player Spawner** device on the island. Place the spawner near the firing line. The Shooting Gallery is usually a single-player game, but you can add more player spawners if you want players to compete for who gets the most points.

Follow the steps below to locate and place the device.

1. From Create mode, press the **M**key to open the **Creative** menu, then select the **Devices** category.
2. Locate **Player Spawner**  device, then place it near your spawner.
3. Customize the options as shown below.

   [![Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/13e5c561-4a98-4fa7-ae2e-a74b100b608a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13e5c561-4a98-4fa7-ae2e-a74b100b608a?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible during games** | No | Make the spawn pad invisible for distraction-free spawn area. |
   | **When Player Spawned Transmit On** | Channel 4 | Assign [Channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) 4 to this spawn pad. When the player spawns to this pad, the channel you selected is [triggered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |

4. Click **OK** to save your options.

Click **OK** after changing your settings. Otherwise, your customized options will not be saved.

## Add and Set Up the Item Spawners

Add two Item Spawner devices to the level. The Item Spawners hold the weapons your player needs to pick up before starting the game.

Follow the steps below to locate and place the devices.

1. From Create menu, press the **M**key, then select the **Devices** category.
2. Locate **Item Spawner**, then place it out of the way of the player.
3. Customize the options as shown below. To speed up the process, set the options for the first Item Spawner, then **Copy** and **Paste** the device.

   [![Item Spawer](https://dev.epicgames.com/community/api/documentation/image/bd670e1c-3793-4e60-9072-6fe181bb74bd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd670e1c-3793-4e60-9072-6fe181bb74bd?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Time Before First Spawn** | 1 second | The weapon dropped in this spawner spawns 1 second after the game starts. |
   | **Time Between Spawns** | 1 second | The weapon dropped in this spawner respawns 1 second after the player picks it up. |

4. Click **OK** to save your options.
5. Drop weapons Into the spawners. To register weapons for this device, follow these steps.

   [![Item Spawner Gif](https://dev.epicgames.com/community/api/documentation/image/faab7051-ae9e-4a1e-9f57-d5a3547fa10d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/faab7051-ae9e-4a1e-9f57-d5a3547fa10d?resizing_type=fit)

   1. In the Creative menu, select the WEAPONS category, find an assault rifle and a sniper rifle, then equip them.
   2. Stand directly beside the device that will register the first weapon.
   3. Press the **Tab** key to open the **PLAY** inventory screen.
   4. Click the sniper rifle, then press **Z** to drop the weapon. You can also drag the weapon to the side until a [backpack icon](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#backpack-icon) appears.
   5. Repeat steps 3 and 4 with the assault rifle for the second Item Spawner.

## Add and Set Up the Item Granter

The **[Item Granter](using-item-granter-devices-in-fortnite-creative)** is used to grant extra ammunition to the player at the start of the game.

Follow the steps below to locate and place the device.

1. From Create mode, open the **Creative** menu, then select the **Devices** category.
2. Locate **Item Granter**, then place it out of the way of the player.
3. Customize the options as shown below.

   [![Item Granter](https://dev.epicgames.com/community/api/documentation/image/d690ef4d-0bab-4e3b-b59a-535c98ef66f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d690ef4d-0bab-4e3b-b59a-535c98ef66f3?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **On-Grant Action** | Keep All | All items in your inventory remain when granted items from this device. |
   | **Grant** | All Items | Grants all items in the device |
   | **Grant Item When Receiving From** | Channel 2 | When the player presses the button programmed to transmit on this channel, they receive the items in the granter. |

4. Click **OK** to save your options.
5. Drop ammo into the granter

   1. In the Creative menu, select the Consumables category, find AMMO: MEDIUM BULLETS and AMMO: HEAVY BULLETS, then double-click to equip them. You can double-click multiple times to equip more of the same item. In this tutorial, your player should get 300 rounds of each ammo type.
   2. Stand directly beside the granter.
   3. Press the **Tab** key to open the **PLAY** inventory screen.
   4. Click each ammo type, then press **Z**. You can also drag them to the side until a [backpack icon](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#backpack-icon) appears.

## Add and Set Up the Button

The **[Button](using-button-devices-in-fortnite-creative)** activates other devices by transmitting a signal when the player interacts with it.

Follow the steps below to locate and place the button.

1. From Create mode, press the **Tab** key to open the **Creative** menu, then click the **Devices** tab.
2. Locate **Button**, then click PLACE NOW, and place it on or near the firing line.
3. Customize the options as shown below.

   [![Button](https://dev.epicgames.com/community/api/documentation/image/c2189d95-81d6-4757-932e-6c9135d20dfe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c2189d95-81d6-4757-932e-6c9135d20dfe?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **When Interacted With Transmit On** | Channel 2 | When the player presses the button, it transmits on the selected channel and causes the Timed Objective device to start as well as the Item Granter to grant them everything in its inventory. |

4. Click **OK** to save your options.

## Add and Set Up the Timed Objective

The **[Timed Objective](using-timed-objective-devices-in-fortnite-creative)** device counts down from 30 seconds and displays a HUD message once the button to start the game has been pressed.

Follow the steps below to locate and place the Timed Objective.

1. From Create mode, press the **Tab** key to open the **Creative** menu, then click the **Devices** tab.
2. Locate **Timed Objective**, then click PLACE NOW, and place it out of the way of the player.
3. Customize the options as shown below.

   [![Timed Objective](https://dev.epicgames.com/community/api/documentation/image/094b182b-5ed7-4225-96c1-aab532f2fa82?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/094b182b-5ed7-4225-96c1-aab532f2fa82?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Time** | 30 seconds | Sets the length of time the player has to hit as many target dummies as they can. |
   | **Timer Label Text** | shoot the target dummies! | Displays the chosen message on the player's screen for the duration of the timer. |
   | **Start When Receiving From** | Channel 2 | When the device receives the signal from the selected channel, in this case the button being pressed, it starts the countdown. |
   | **When Completed Transmit On** | Channel 3 | When the timer runs out, it transmits on the selected channel to signal the end of the game. |

4. Click **OK** to save your options.

## Add and Set Up the End Game Device

The **[End Game](using-end-game-devices-in-fortnite-creative)** device determines when the [win conditions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#win-condition) are met. In this case, the game will end when the timer runs out. Follow the steps below to locate and place the End Game device.

1. From Create mode, press the **Tab** key to open the **Creative** menu, then click the **Devices** tab.
2. Locate **End Game**, then click PLACE NOW, and place it out of the way.
3. Customize the options as shown below.

   [![End Game](https://dev.epicgames.com/community/api/documentation/image/b69ac65a-8527-4c9f-9c2a-25f4882fef4b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b69ac65a-8527-4c9f-9c2a-25f4882fef4b?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Activate When Receiving From** | Channel 3 | When the timer runs out, the device receives from this channel to trigger the end of the game. |

4. Click **OK** to save your options.

## Add and Set Up the Barrier Device

The **[Barrier](using-barrier-devices-in-fortnite-creative)** keeps the player within the bounds you set and prevents them from getting too close to the target dummies. Place the barrier in a central area between the spawn pad and the firing line.

Barrier size is measured using the island's grid tiles: a barrier that is 1 unit of height by 1 unit of depth by 1 unit of width will cover one cube on your Grid Island.

[![Barrier grid](https://dev.epicgames.com/community/api/documentation/image/ac39bfd2-1f0c-47d5-a392-30a23b9fbb3b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ac39bfd2-1f0c-47d5-a392-30a23b9fbb3b?resizing_type=fit)

The tutorial grid is 5 x 5 x 5.

Follow the steps below to locate and place the Barrier.

1. From Create mode, press the **Tab** key to open the **Creative** menu, then click the **Devices** tab.
2. Locate **Barrier**, then click PLACE NOW, and place it in a central location.
3. Customize the options as shown below.

   [![Barrier](https://dev.epicgames.com/community/api/documentation/image/8366afed-79bb-4aaa-9b7b-3ffc2a88b73b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8366afed-79bb-4aaa-9b7b-3ffc2a88b73b?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Style** | Invisible | Sets the barrier style to invisible. |
   | **Enabled During Phase** | All | Ensures the barrier remains active before and during the game. |
   | **Block Weapon Fire** | No | Allows the player to shoot the targets through the barrier. |
   | **Zone Shape** | Box (Hollow) | Choosing this setting lets the player remain inside the barrier instead of being blocked from entering. |
   | **Barrier Width** | 5 | Width used in the tutorial island. |
   | **Barrier Depth** | 5 | Depth used in the tutorial island. |
   | **Barrier Height** | 5 | Height used in the tutorial island. |

4. Click **OK** to save your options.

## Add and Set Up Target Dummies

Finally, place the **[Shooting Range Gallery](using-shooting-range-gallery-devices-in-fortnite-creative)** devices. The tutorial uses 5 static Target Dummies, but you can choose the target type you prefer. A Shooting Range Gallery device also comes with the option of a moving target.

Follow the steps below to locate and place the Shooting Range Gallery devices.

1. From Create mode, press the **Tab** key to open the **Creative** menu, then click the **Devices** tab.
2. Locate **Shooting Range Gallery**, then click PLACE NOW, and place it outside the zone that's covered by the barrier.
3. Customize the options as shown below. To speed up the process, set the options for the first dummy, then **Copy** and **Paste** the device to all the desired locations.

   [![Target Dummy](https://dev.epicgames.com/community/api/documentation/image/77430aa4-c732-4392-97c8-2bafcc78a2e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/77430aa4-c732-4392-97c8-2bafcc78a2e9?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Enabled at Game Start** | Disabled | This setting disables the target dummy until the game is started using the button device. |
   | **Score Bullseye Multiplier** | 3 | Hitting the target's bullseye gives the player three times the normal score award. |
   | **Time Before Pop-Up** | Never | The target doesn't pop up on its own unless the game is started. |
   | **Start Position** | Down | The target dummy lays dormant until the player presses the button to start the game, then they will pop up. |
   | **Enable When Receiving From** | Channel 2 | The target dummy becomes enabled once the player presses the button to start the game. |
   | **Pop-Up When Receiving From** | Channel 2 | The target dummy pops up once the player presses the button to start the game. |

4. Click **OK** to save your options.

## Change My Island Settings

Some of My Island settings need to be customized to create this game experience.

Any settings not mentioned in the table below should be left in their default state.

### Settings Tab

| Option | Value | Explanation |
| --- | --- | --- |
| **Light Brightness** | 100% | Ensures all areas of your level are well illuminated. |
| **Allow Building** | None | Prevents players from building structures in your level. |
| **Environment Damage** | Off | Prevents players from damaging the level around the dummies. |
| **Start with Pickaxe** | No | Players start without the pickaxe. |

### UI Tab

[![Settings UI](https://dev.epicgames.com/community/api/documentation/image/82459d32-2457-4d72-b340-c45ec89952fa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82459d32-2457-4d72-b340-c45ec89952fa?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **HUD Info Type** | Score | Displays the score in the HUD, which is tied to the number of accurate hits and bullseye hits a player achieves. |
| **Use Team Score** | Yes | Allows the player to see their score at the end of the game. |
| **Scoreboard Win Condition** | Score | Determines the win condition for the scoreboard, in this case the number of hits a player has landed on the targets. |

## Designer Tips

### Modified Scoring

**Additional Devices Required**

- 2 x [Score Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative)
- 1 x [Target Dummy Track](using-shooting-range-gallery-devices-in-fortnite-creative)

In the above tutorial each dummy grants the player 1 point on knock down and 3 points on a bullseye knock down, with its default health set to 1. If you want your player to get points without having to knock down the dummies, you can change the target dummies' health to INFINITE, and make them transmit to two **[Score Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative)** devices.

The first score manager will track regular hits and the second will track bullseyes.

Try modifying the score each hit will grant. To make things more challenging, make the dummy move on a track, that way the player will want to alternate between hitting the moving dummy and the stationary ones.

Take a look at the tables below for the suggested modified options.

**Target Dummy Track**

[![Target dummy track](https://dev.epicgames.com/community/api/documentation/image/c25b8e9b-692e-4ae3-9cea-da8fdeb5ea6e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c25b8e9b-692e-4ae3-9cea-da8fdeb5ea6e?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Target Type** | Pumpkin-head | This type of target is easier to hit when moving on a track. |
| **Health** | Infinite | Prevents the dummy from getting knocked down after being hit. |
| **Show Health Bar** | No | Removes the health bar. |
| **Time Before Pop-Up** | Never | The target does not pop up on its own unless the game is started. |
| **Start Position** | Down | The target dummy lays dormant until the player presses the button tho start the game, then they pop up. |
| **Enable When Receiving From** | Channel 2 | The target dummy becomes enabled once the player presses the button to start the game. |
| **Pop-Up When Receiving From** | Channel 2 | The target dummy pops up once the player presses the button to start the game. |
| **When Hit Transmit On** | Channel 5 | The target dummy transmits to the first score manager when a regular hit is registered. |
| **On Bullseye Hit Transmit On** | Channel 6 | The target dummy transmits to the second score manager when a bullseye hit is registered. |

[![score managers](https://dev.epicgames.com/community/api/documentation/image/eaf72660-1750-407d-b05f-300e4572e002?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eaf72660-1750-407d-b05f-300e4572e002?resizing_type=fit)

**Score Manager #1**

| Option | Value | Explanation |
| --- | --- | --- |
| **Score Value** | 3 | Awards 3 points when triggered. In this case the trigger is hitting a target dummy. |
| **Activate When Receiving From** | Channel 5 | When the player hits the target dummies programmed to transmit on this channel, the score manager increments their score by 1 point. |

**Score Manager #2**

| Option | Value | Explanation |
| --- | --- | --- |
| **Score Value** | 5 | Awards 5 points when triggered. In this case the trigger is hitting a bullseye on the target dummy. |
| **Activate When Receiving From** | Channel 6 | When the player hits the bullseye on the target dummies programmed to transmit on this channel, the score manager increments their score by 5 points. |

### Clean Up Your HUD

**Additional Devices Required**

- 1 x [HUD Controller device](using-hud-controller-devices-in-fortnite-creative)

[![HUD device](https://dev.epicgames.com/community/api/documentation/image/37435abd-e6cb-4c1f-bd78-fbc401c3d691?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/37435abd-e6cb-4c1f-bd78-fbc401c3d691?resizing_type=fit)

Often overlooked, this device allows you to clear out the clutter by removing any HUD element that isn't relevant to your game. In this case, use the modified options below to remove the mini map and the building resources.

[![Heads Up Display](https://dev.epicgames.com/community/api/documentation/image/8e0c3211-23ff-49de-8c7b-dbd165899e2b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8e0c3211-23ff-49de-8c7b-dbd165899e2b?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Show Mini Map** | No | Removes the mini map from the HUD. |
| **Show Wood Resource** | No | Removes wood resource from the HUD. |
| **Show Stone Resource** | No | Removes stone resource from the HUD. |
| **Show Metal Resource** | No | Removes metal resource from the HUD. |
| **Show Gold Resource** | No | Removes gold resource from the HUD. |

### Use the Class Designer Device

**Additional Devices Required**

- 1 x [Class Designer device](using-class-designer-devices-in-fortnite-creative)

The **[Class Designer](using-class-designer-devices-in-fortnite-creative)** gives you a way to define a custom class with an initial set of attributes and an inventory loadout. For this shooting gallery, we can eliminate the need for item spawners and granters by defining what the player gets at the start of the game and by giving players infinite ammo. Start by replicating the modified options below.

[![class designer](https://dev.epicgames.com/community/api/documentation/image/6ce19064-4d4b-4141-88c7-37eaa9a674cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6ce19064-4d4b-4141-88c7-37eaa9a674cb?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Class Identifier** | 1 | The options selected on this device affects all players designated as class 1. |
| **Equip Granted Item** | First Item | Equips the first item from the set of items dropped in the class designer. |
| **Infinite Ammo** | On | Grants class 1 players infinite ammo. |

Drop the weapons you would like your player to start with into the class designer device, just as you did for the item spawners and the granter.

[![class designer](https://dev.epicgames.com/community/api/documentation/image/38d1a4de-a9e4-4e8d-ae7e-956c8892f951?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38d1a4de-a9e4-4e8d-ae7e-956c8892f951?resizing_type=fit)

Go back to **My Island** and select the **Game** tab. Change the **Default Class Identifier** to 1.

[![game settings](https://dev.epicgames.com/community/api/documentation/image/1e20c678-dac5-4a16-94f4-f45ade793da1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e20c678-dac5-4a16-94f4-f45ade793da1?resizing_type=fit)
