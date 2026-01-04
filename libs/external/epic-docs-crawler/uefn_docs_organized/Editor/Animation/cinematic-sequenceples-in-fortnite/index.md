# Cinematic Sequence Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/cinematic-sequenceples-in-fortnite
> **爬取时间**: 2025-12-26T23:04:48.239747

---

Available in **Unreal Editor for Fortnite (UEFN) only**, this device is perfect for creating [cutscenes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#cutscene) for player onboarding, in-game instructions, or just for fun!

## Starting Weapon Sequence

The **Cinematic Sequence** device has settings that you can use to create a basic opening sequence to give the player their starting weapons one by one instead of all at once!

### Devices Used

- 1 x [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device

### Set Up the Devices

1. Place a **Player Spawner** device.
2. Place an **Item Granter** device.
3. Customize the Item Granter as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/c7959e60-d3dc-4d9d-8f19-50f61768a4cd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c7959e60-d3dc-4d9d-8f19-50f61768a4cd?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | On Grant Action | Keep All |
   | Item List - Index [0] - Item Definition | Tactical Assault Rifle L1 |
   | Item List - Index [1] - Item Definition | Tactical Pistol L1 |
   | Item List - Index [2] - Item Definition | Grenade |
   | Receiving Players | All |
4. Create a [level sequence](https://dev.epicgames.com/community/learning/tutorials/r4jn/fortnite-uefn-using-level-sequencer) called **StartingWeaponsSequence**.
5. Place a **Cinematic Sequence** device.
6. Customize the Cinematic Sequence device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/f0eea0a7-687c-4c8a-9486-006b7312a50a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f0eea0a7-687c-4c8a-9486-006b7312a50a?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Sequence | StartingWeaponSequence |
   | Auto Play | Yes |
7. Open the **StartingWeaponSequence** and add the Item Granter to the timeline. Create three [keyframes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#keyframe) for gameplay events. The first will **Grant Item** and the next two will call **Cycle to Next Item**.

   [![](https://dev.epicgames.com/community/api/documentation/image/1ddee787-279e-4f88-9643-834083278619?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1ddee787-279e-4f88-9643-834083278619?resizing_type=fit)

You now have the basic functionality for an opening weapon sequence!

### Design Tip

Simple effects like this are a great way to give your game a more polished, cinematic quality. Making gameplay changes sequential instead of all at once can also give the player a chance to process what’s happening during the game. In this example, players see each weapon separately for a better starting understanding of their loadout!

## Survival Platforming Minigame

You can use the Cinematic Sequence device to trigger different sequential events with different devices.

In this example, you’ll create a simple platforming mechanic with beacons to indicate where the player should jump.

### Devices Used

- 1 x Cinematic Sequence device
- 1 x Player Spawner device
- 1 x [Damage Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative) device
- 16 x [Prop Manipulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-manipulator-devices-in-fortnite-creative) devices
- 16 x [Beacon](https://dev.epicgames.com/documentation/en-us/fortnite/using-beacon-devices-in-fortnite-creative) devices

### Set Up the Play Area

1. Create a platform in the sky using **16 floor pieces** from the **Fortnite > Galleries > Building > Pirate Cove Gallery**.
2. Place a **Player Spawner** device on one of the floors.
3. Customize the Player Spawner so **Visible in Game** is set to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/0971f87d-c9c4-4d23-a02e-dbf054151403?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0971f87d-c9c4-4d23-a02e-dbf054151403?resizing_type=fit)
4. Place a **Damage Volume** device below the platform.
5. Customize the Damage Volume as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/8c25bbe7-48ee-44c4-8be7-0f0a42b0d96a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c25bbe7-48ee-44c4-8be7-0f0a42b0d96a?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Zone Width | 20.0 |
   | Zone Depth | 20.0 |
   | Zone Height | 0.0 |
   | Damage Type | Elimination |

### Configure the Disappearing Platforms

1. Place a **Prop Manipulator** device on one of the floor pieces.
2. Customize the Prop Manipulator so the **Start Hidden** option is set to **On**:

   [![](https://dev.epicgames.com/community/api/documentation/image/a64bdc99-2fae-45ac-b2bb-4aebe87a21ad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a64bdc99-2fae-45ac-b2bb-4aebe87a21ad?resizing_type=fit)
3. Duplicate this Prop Manipulator, placing one on each of the 16 floor pieces.
4. Change the Prop Manipulator that the player spawns on to not start hidden.
5. Place a **Beacon** device in the center of one of the floor pieces.
6. Customize the Beacon as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/087c9d40-d22c-4834-be23-d4eca477bc90?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/087c9d40-d22c-4834-be23-d4eca477bc90?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Beacon Particle Style | Flare |
   | Enabled on Phase | None |
7. Duplicate this Beacon and place one on each of the 16 floor pieces.
8. Go through each Prop **Manipulator/Beacon** pair and rename the devices in number order.
9. Create a level sequence and name it **PlatformSequence**.
10. Place a **Cinematic Sequence** device.
11. Customize the Cinematic Sequence as follows:

    [![](https://dev.epicgames.com/community/api/documentation/image/41e5a91a-8b49-434f-accf-f50acd26015d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/41e5a91a-8b49-434f-accf-f50acd26015d?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Sequence | PlatformSequence |
    | Loop Playback | True |
    | Auto Play | True |
12. Follow the pattern of **Gameplay Event** **keyframes** below, with each of the Beacons in order.

    For the first beacon, **Disable** it on the first frame and Enable again at 60 frames before the sequence loops. For all of the other Beacons, Enable on the first keyframe, then Disable 60 frames later.

    [![](https://dev.epicgames.com/community/api/documentation/image/24192c46-cbf1-4f64-b86b-0e50515d1aa8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/24192c46-cbf1-4f64-b86b-0e50515d1aa8?resizing_type=fit)
13. Follow a similar pattern for all of the Prop Manipulators in order, this time with the first Prop Manipulator calling Show Props on the first frame and Hide Props 60 frames later.

    [![](https://dev.epicgames.com/community/api/documentation/image/5c692ad3-0931-446e-ad8e-a83365859f44?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c692ad3-0931-446e-ad8e-a83365859f44?resizing_type=fit)

You now have the basic functionality for a survival platforming minigame!

### Design Tip

The Cinematic Sequence device is great for this kind of timed gameplay. Keyframes can be copy/pasted easily on the timeline, so you can quickly get sequential repeating behavior on different devices like this!

## Build a Rhythm Game!

With the ability to time different gameplay events with the Cinematic Sequence device, you can create the core functionality of a rhythm game.

### Devices Used

- 1 x Cinematic Sequence device
- 1 x Player Spawner device
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device
- 3 x [Prop Manipulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-manipulator-devices-in-fortnite-creative) devices
- 1 x [Score Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative) device
- 1 x [Radio](https://dev.epicgames.com/documentation/en-us/fortnite/radio) device

### Set Up the Basic Functionality

1. Start with the **Shark Island** starter island.
2. Place a **Player Spawner** on the helipad and customize it so that **Visible in Game** is set to **Off**.
3. Place an **Item Granter**.
4. Customize the Item Granter as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/51bcb42f-06e4-4e4b-9db2-92cf8b3ebc52?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/51bcb42f-06e4-4e4b-9db2-92cf8b3ebc52?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Item List - Index [0] - Item Definition | Pistol L1 |
   | Receiving Players | All |
   | Equip Granted Item | True |
   | Spare Weapon Ammo | 999 |
   | Grant on Game Start | True |
5. From the **Fortnite > Galleries > Props > Egg Gallery**, place **three large eggs** in the sky over the water. These will be the targets.
6. Place a **Prop Manipulator** on one of the eggs.
7. Customize the Prop Manipulator as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/e9b8179f-de4c-4dde-a446-bd9c3dbbbdac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9b8179f-de4c-4dde-a446-bd9c3dbbbdac?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Start Hidden | True |
   | Modify Prop Health | True |
   | Is Prop Invulnerable | True |
8. Duplicate this Prop Manipulator and place it on the two other eggs.
9. Place a **Score Manager**.
10. Customize the Score Manager as follows:

    [![](https://dev.epicgames.com/community/api/documentation/image/74a69864-99c6-46e3-be40-90d886290c76?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/74a69864-99c6-46e3-be40-90d886290c76?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Display Score Update on HUD | True |
    | HUD Message | Hit! |
11. Configure the following function on the Score Manager so that when one of the eggs is hit, the Score Manager increases the player’s score.

    [![](https://dev.epicgames.com/community/api/documentation/image/3ae768b1-dce4-4390-b3a6-a9fece9f871c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ae768b1-dce4-4390-b3a6-a9fece9f871c?resizing_type=fit)

    | Function | Device | Event |
    | --- | --- | --- |
    | Activate | Prop Manipulator0–2 | On Damaged |

### Configure the Rhythm Mechanics

1. Place a **Radio**.
2. Customize the Radio as follows:
3. Create a level sequence and name it **MusicSequence**.
4. Place a **Cinematic Sequence** device.
5. Customize the device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/de21cbcc-aa3f-46c4-94af-d9496ac2164a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de21cbcc-aa3f-46c4-94af-d9496ac2164a?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Sequence | MusicSequence |
   | Loop Playback | True |
   | Auto Play | Tru |
6. The player should be shooting the eggs on **frames 0**, **30**, and **60**. As such, you’ll make it so that the Prop Manipulators **show the eggs 10 frames before** these moments and **hide them again 5 frames** after to give the player a fair window.

   Set up the level sequence as follows. The first keyframe for Prop Manipulator 0 **Hides** the prop and the second one **Shows** it. For prop Manipulators 1 and 2, the first keyframe **Shows** the prop and the second **Hides** it again.

   [![](https://dev.epicgames.com/community/api/documentation/image/c7513b93-4655-44d7-acb7-a49dd8e489e8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c7513b93-4655-44d7-acb7-a49dd8e489e8?resizing_type=fit)

### Modify Island Settings

Make the following modifications to the island settings object.

- Under **Round**, change **Stat** ****Value** to **End**** to **Score**, then change **Stat Value to End** to **10**.

  [![](https://dev.epicgames.com/community/api/documentation/image/e3140f2d-5a19-4b26-ae80-0003b233a3e1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3140f2d-5a19-4b26-ae80-0003b233a3e1?resizing_type=fit)

You now have a basic rhythm game!

### Design Tip

This example uses a very simple repeating pattern to show the basics of rhythm mechanics with the Cinematic Sequence device, but you can use the timeline to create much more complicated compositions! Explore using different objects to represent different types of notes, with an  indication of which notes will be coming next!
