# Shooting Academy

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/shooting-academy-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:26:36.712602

---

[![Shooting Academy gamelpay example](https://dev.epicgames.com/community/api/documentation/image/12bc7fcc-769b-485f-89d1-71ff927eeecd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12bc7fcc-769b-485f-89d1-71ff927eeecd?resizing_type=fit)

*Click image to enlarge.*

Your goal in the Shooting Academy is to shoot targets as accurately and quickly as possible. Players can work on improving their aim and accuracy while learning how to use the Combat Assault Rifle in this game.

In this example, you’ll learn how to use the Team Settings & Inventory device, the Player Spawn Pad device, the Barrier device, and the Shooting Range Gallery device.

## Devices Used

To learn more about placing [devices](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#device), [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop), and using the [grid](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grid), watch the [Video Tutorials](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-video-tutorials).

- **1 x [Barrier](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative) device**
- **1 x** [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- ****15 x**** [Target Dummy](using-shooting-range-gallery-devices-in-fortnite-creative) devices
- **1 x** [Legendary Assault Rifle](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-weapons-primer)

## Traps Used

- **1 x** [Team Settings & Inventory device](using-team-settings-and-inventory-devices-in-fortnite-creative)

## Placing Traps

1. Press **Tab** to go into the [Creative Inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
2. Click **Devices > Team Settings & Inventory >** [Equip](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#equip) to add the Team Settings & Inventory device to your [Quick Bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
3. Press **Y** to place the **Team Settings & Inventory device** in an open space. This device will grant players the Combat Assault Rifle when they spawn into the game.

   [![Placing the Team Settings & Inventory device](https://dev.epicgames.com/community/api/documentation/image/8c939730-8787-491a-b599-aa4adf2f0f29?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c939730-8787-491a-b599-aa4adf2f0f29?resizing_type=fit)
4. Edit the **Team Settings & Inventory device** options.

   [![Team Settings & Inventory device settings](https://dev.epicgames.com/community/api/documentation/image/12dcbc64-d09e-4ac0-b162-8a4c6a98112a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12dcbc64-d09e-4ac0-b162-8a4c6a98112a?resizing_type=fit)

   *Click image to enlarge.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Equip Granted Item** | **First Item** | Equips the weapon in the player's first item slot. |
   | **Infinite Ammo** | **On** | Provides infinite ammo for the rifle. |

## Placing Devices

1. Click **Devices > Barrier device > Equip** to add the Barrier device to your Quick Bar. Continue to add the following devices from the device menu:

   1. Score Manager device
   2. Player Spawn Pad device
   3. Shoot Range Gallery device
2. Place the **Barrier device** on top of the **Team Settings & Inventory device**. This creates an area for the player to move around in and also limits how close the player can get to the targets.

   [![Placing the Barrier device](https://dev.epicgames.com/community/api/documentation/image/8c8e58d9-757b-42d4-a301-bb5fd846292d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c8e58d9-757b-42d4-a301-bb5fd846292d?resizing_type=fit)
3. Edit the **Barrier device** options.

   [![Editing the Barrier device options](https://dev.epicgames.com/community/api/documentation/image/9c2ac100-96bf-4c4b-9ae2-5f202187f57c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9c2ac100-96bf-4c4b-9ae2-5f202187f57c?resizing_type=fit)

   *Click image to enlarge.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Barrier Style** | **Invisible** | Creates an invisible barrier around the player. |
   | **Block Weapon Fire** | **No** | Allows weapon fire to pass through the barrier. |
   | **Zone Shape** | **Hollow** | Allows the player to move around inside the barrier. |
   | **Barrier Width** | **2** | Gives enough room for the player to walk around, but not get up close to the dummy targets. |
   | **Barrier Depth** | **2** | Gives enough room for the player to walk around, but not get up close to the dummy targets. |

4. Place the **Player Spawn pad** on the **Team Settings & Inventory device**.

   [![Placing the Player Spawn pad](https://dev.epicgames.com/community/api/documentation/image/2852fa45-8482-462f-9d55-6564685d8c91?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2852fa45-8482-462f-9d55-6564685d8c91?resizing_type=fit)
5. Edit the **Player Spawn pad** options to the following:

   [![Player Spawn Pad options](https://dev.epicgames.com/community/api/documentation/image/d96aeb94-6e64-4f17-b1f0-193a3537aef4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d96aeb94-6e64-4f17-b1f0-193a3537aef4?resizing_type=fit)

   *Click image to enlarge.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Visible During Games** | **No** | Makes the Player Spawn pad invisible during the game. |
   | **When Player Spawned Transmit on** | **Channel 1** | Transmits a signal to connected devices when the player enters the game. |

## Preparing the Shooting Range

To prepare your shooting range, you need to load the Team Settings & Inventory device with a weapon for the player to use and place the target dummies.

1. Stand over the Team Settings & Inventory device.
2. Open the [Creative inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) screen and click on the **Weapons** tab to view the selection of weapons.
3. Click on the **Legendary Combat Assault Rifle**, then click **Equip** to add it to the [Equipment bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
4. Click, hold, and drag the rifle icon from the Equipment bar until the orange [backpack icon](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#backpack-icon) appears, then release.

   [![Adding the rifle to the Team Settings & Inventory device](https://dev.epicgames.com/community/api/documentation/image/24aa1b7d-4cee-4898-91cf-d9f8ed37c5f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/24aa1b7d-4cee-4898-91cf-d9f8ed37c5f7?resizing_type=fit)

   *Click image to enlarge.*
5. Place the **Shooting Range Gallery**. The gallery targets should face the Team Settings & Inventory device.

   [![Placing the target dummies](https://dev.epicgames.com/community/api/documentation/image/68a018f4-1671-4e4c-8149-4bf18d941686?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/68a018f4-1671-4e4c-8149-4bf18d941686?resizing_type=fit)
6. Edit the first dummy target to the desired level of difficulty and award points to the player based on the dummy’s level of difficulty.
7. Copy and paste the dummy 19 more times to create more targets of the same difficulty.
8. Repeat the last 2 steps after creating increasingly difficult targets.

   For a more challenging shooting range, place the Shooting Range Gallery farther away from the Barrier device.

   **Still Targets**

   [![Still standing target dummy options](https://dev.epicgames.com/community/api/documentation/image/625252d7-b541-4c8b-956f-49ab4268b9e8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/625252d7-b541-4c8b-956f-49ab4268b9e8?resizing_type=fit)

   *Click image to enlarge.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Score Bullseye Multiplier** | **2** | Provides double the reward points for a bullseye hit. |
   | **Reset Time** | **15 Seconds** | Provides enough time for the player to focus on another target before the dummy pops back up. |

   **Moving Targets**

   [![Settings for moving target dummy options](https://dev.epicgames.com/community/api/documentation/image/6d57a569-550b-42d6-9007-c219a042863c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d57a569-550b-42d6-9007-c219a042863c?resizing_type=fit)

   *Click image to enlarge.*

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Speed** | **FAST** | Makes the target move side-to-side quickly making the target harder to hit. |
   | **Target Type** | **Pumpkin Head** | Pumpkin Head has a large head making it easier to shoot for the bullseye. |
   | **Score Bullseye Multiplier** | **2** | Awards two times the points for bullseye hits. |
   | **Bullseye Knockdown** | **On** | Targets will fall down when their bullseye are hit. |
   | **Reset Time** | **15 Seconds** | Provides enough time for the player to focus on another target before the dummy pops back up. |

## My Island Settings

You can use My Island options to enhance your game’s experience. My Island options work with your device settings to determine the game’s structure and how your devices work together, and what the game UI does during your game.

Only modify the options described below, leave the rest of the default settings as is.

Try using the following:

### Game

[![Game Option Settings](https://dev.epicgames.com/community/api/documentation/image/c65308a3-50fd-4425-a024-ad2c9d81693c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c65308a3-50fd-4425-a024-ad2c9d81693c?resizing_type=fit)

*Click image to enlarge.*

| Option | Value | Explanation |
| --- | --- | --- |
| **Max Players** | **1** | Only one person at a time can spawn into the game because there is only one Player Spawn pad. |
| **Total Rounds** | **3** | Gives players 3 rounds to get as many points as possible per round, allowing players to beat their score from the previous round. |
| **Time Limit** | **8 Minutes** | Players can amass as many points as possible during the time limit. |
| **Auto Start** | **Immediate** | Allows players to enter the shooting range immediately. |

### Settings

[![Settings Options for My Island](https://dev.epicgames.com/community/api/documentation/image/b1983132-1a53-4d69-bf43-2fb9fe780cb8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1983132-1a53-4d69-bf43-2fb9fe780cb8?resizing_type=fit)

*Click image to enlarge.*

| Options | Value | Explanation |
| --- | --- | --- |
| **Start with a Pickaxe** | **No** | Turns off starting with a pickaxe. |

## Playing Your Game

After you successfully create the Shooting Academy tutorial and play your level, you’ll see other uses for the Barrier and Shooting Gallery devices. Use the barrier device options to enable and disable barriers using the channel system.

Target dummies not only move side-to-side, but also up and down, and all movements in a random pattern depending on how you edit the target’s options.
