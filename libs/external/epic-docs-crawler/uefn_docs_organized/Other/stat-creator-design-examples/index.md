# Stat Creator Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/stat-creator-design-examples
> **爬取时间**: 2025-12-26T23:07:41.391331

---

Get ready to discover some fun and unique ways to track player progress as they play your games!

## Set Up a Basic Custom Stat

The **Stat Creator** device is perfect for making unique ways to track player progress in your Island. In this example, you’ll make a stat that tracks the number of explosions that a player has triggered!

### Devices Used

- 1 x [Stat Creator](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-creator-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Stat Counter](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-counter-devices-in-fortnite-creative) device
- 3 x [Explosive](https://dev.epicgames.com/documentation/en-us/fortnite/using-explosive-devices-in-fortnite-creative) devices

### Set Up the Devices

1. Place a **Player Spawner** device.
2. Place a **Stat Creator**device.
3. Customize the device:

   [![](https://dev.epicgames.com/community/api/documentation/image/882e39ce-0c50-4cc5-98d5-bbb1c2e07952?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/882e39ce-0c50-4cc5-98d5-bbb1c2e07952?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat Name | Explosions Triggered |
   | Stat Icon | Bomb |
4. Place a **Stat Counter** device.
5. Customize the counter:

   [![](https://dev.epicgames.com/community/api/documentation/image/ba4aba5b-98ee-4718-928f-02ad3f167fa2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba4aba5b-98ee-4718-928f-02ad3f167fa2?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Comparison Value | 3 |
   | Value Override Type | Add |
   | Value Override | 1 |
   | Visible in Game | No |
6. Place an **Explosive** device.
7. Configure the device to set **Player Damage** to **0**:

   [![](https://dev.epicgames.com/community/api/documentation/image/02b93d76-abd0-4315-ac05-45e0f953c0dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02b93d76-abd0-4315-ac05-45e0f953c0dd?resizing_type=fit)
8. Configure the following **events** on the **Explosion** device so that it adds one to the **Explosions Triggered** stat when it explodes.

You now have the basic functionality for a custom stat!

### Design Tip

The combination of **Stat Creator** and **Stat Counter** devices is great for creating, changing, and tracking a stat. In this example, it would be easy to add another device and trigger it when the player successfully triggers three explosions.

## Build a Parkour Skill Mechanic

The **Stat Creator** can be configured to have different levels of a statistic, allowing you to create your own custom gameplay skills! You’ll use this to set up a **parkour skill** stat that gives players an upgrade when they level up!

### Devices Used

- 1 x Stat Creator device
- 1 x Player Spawner device
- 1 x [Stat Counter](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-counter-devices-in-fortnite-creative) device
- 2 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) devices
- 1 x [Movement Modifier](https://dev.epicgames.com/documentation/en-us/fortnite/movement-modifier) device

### Set Up the Gameplay

1. Place the **Slick Pegs**, **Peg and Rails**, and **Ice Rails** prefabs, one after the other.
2. Place a **Player Spawner** device at the beginning of the Slick Pegs parkour prefab.
3. Place a **Stat Creator** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/541e3f81-7264-4d8f-8861-a91e511071ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/541e3f81-7264-4d8f-8861-a91e511071ea?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat Name | Parkour Skill |
   | Max Value | 2 |
   | Max Level | 2 |
   | Stat Icon | Running |
4. Place a **Stat Counter** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/d5d24a7c-1e3a-45b4-9c14-8e2dd6c4cc8d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d5d24a7c-1e3a-45b4-9c14-8e2dd6c4cc8d?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Tracked Stat | Parkour Skill |
   | Value Override Type | Add |
   | Value Override | 1 |
   | Visible in Game | No |
5. Place a **Movement Modifier** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/ae3bd0ff-b425-478e-ab82-66cc8f2309dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ae3bd0ff-b425-478e-ab82-66cc8f2309dd?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Speed | 2.0 |
   | Infinite Duration | True |
   | Visible During Game | No |
   | Pad Has Collision | Off |
6. Place a large **Trigger** device at the end of the first parkour segment, as shown:

   [![](https://dev.epicgames.com/community/api/documentation/image/796e3557-787c-49da-b14c-dc0de2329a50?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/796e3557-787c-49da-b14c-dc0de2329a50?resizing_type=fit)
7. Customize the **Trigger**:

   [![](https://dev.epicgames.com/community/api/documentation/image/0ed37a9b-849b-46a9-9fa2-a01c839481bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0ed37a9b-849b-46a9-9fa2-a01c839481bb?resizing_type=fit)

   Value

   | Option | Value |
   | --- | --- |
   | Visible In Game | Off |
   | Times Can Trigger | 1 |
   | Visible During Game | No |
   | Pad Has Collision | Off |
8. Configure the following event on the trigger so that it increases the **Parkour Skill** value when the player reaches it:

   [![](https://dev.epicgames.com/community/api/documentation/image/dd3e5a2f-3213-4d22-9074-fc0079b69684?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd3e5a2f-3213-4d22-9074-fc0079b69684?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Triggered | Stat Counter | Override Value |
9. Duplicate this trigger and place the copy on the end of the second parkour section.
10. Configure the following event on the **Stat Creator** device so that it gives the player a movement upgrade when they level up.

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > Player**.
2. Under **Locomotion**, change **Allow Manting** to **Off.**

   [![](https://dev.epicgames.com/community/api/documentation/image/f164bed8-3b6d-4f36-a5b1-610bf5ac6e46?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f164bed8-3b6d-4f36-a5b1-610bf5ac6e46?resizing_type=fit)

You now have the basic functionality for a parkour skill leveling system!

### Design Tip

This example only uses one level, but you can easily add levels with other upgrades and rewards!

A skill system like this is a great way to give incentives for players to complete certain tasks a number of times, so get creative with which skills you want to track!

## Build a Target Level Minigame

The **Stat Creator** can track levels that raise and lower based on different gameplay triggers, allowing for multiple types of stat tracking!

In this example, you’ll create a system that tracks the player’s “wanted level” based on their actions in-game, and spawns enemies to match!

### Devices Used

- 1 x Stat Creator device
- 1 x Player Spawner device
- 1 x Item Granter device
- 2 x [Stat Powerup](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-powerup-devices-in-fortnite-creative) devices
- 9 x [Guard Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/guard-spawner-device) devices
- 3 x [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) devices
- 3 x [Stat Counter](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-counter-devices-in-fortnite-creative) devices

### Set Up the Player

1. Begin with the **Greasy Grove POI Island** starter island.
2. Place a **Player Spawner** device and customize so the spawner is not visible in-game:

   [![](https://dev.epicgames.com/community/api/documentation/image/36a20d8a-b344-4c47-93d5-9f8a430569d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36a20d8a-b344-4c47-93d5-9f8a430569d0?resizing_type=fit)
3. Place an **Item Granter** device and register a Legendary **Tactical Assault Rifle** to the device.
4. Customize the **Item Granter** device:

   [![](https://dev.epicgames.com/community/api/documentation/image/9afafc66-6812-422f-9e70-880033e52d58?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9afafc66-6812-422f-9e70-880033e52d58?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | Spare Weapon Ammo | 999 |
   | Grant on Game Start | On |

### Configure the Basic Target Stat

1. Place a **Stat Creator** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/b08ef58c-774b-4518-af13-5f7ab50c08db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b08ef58c-774b-4518-af13-5f7ab50c08db?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/920f0e2d-c5bd-48e7-8e68-90a5385c49f0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/920f0e2d-c5bd-48e7-8e68-90a5385c49f0?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat Name | Target |
   | Max Value | 500 |
   | Max Level | 3 |
   | Per Level Points Multiplier | 1.5X |
   | Can Lose Level from Point Loss | Yes |
   | Stat Color | #FF0100 |
   | Stat Icon | Exclamation |
2. Place a **Stat Powerup** device in a place that the player can’t reach. This powerup will raise the player’s **Target Stat** when they eliminate a guard.
3. Customize the powerup:

   [![](https://dev.epicgames.com/community/api/documentation/image/b9cc79c0-73b3-44c8-abd0-1056d18b3671?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9cc79c0-73b3-44c8-abd0-1056d18b3671?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/01ba3aac-1c8b-4ba4-a8b9-264086907a68?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/01ba3aac-1c8b-4ba4-a8b9-264086907a68?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat to Apply | Target |
   | Magnitude | 100 |
   | Effect Duration | Instant |
   | Time to Respawn | Instant |
   | Ambient Audio | Off |
   | Pick Up Audio | Off |
   | Who Can See This Powerup | None |
4. Duplicate this device and rename it to **Decrease Target Stat Powerup**. Change its **Magnitude** setting to **-250**. This will decrease the player’s **Target Stat** when they call off the guards.
5. Place a **Guard Spawner** device that will spawn guards when the player has a **Target Level** of at least**1** (which will be always), then customize it:

   [![](https://dev.epicgames.com/community/api/documentation/image/e8ea580e-492a-43c1-bcbb-ca65b8671b9e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8ea580e-492a-43c1-bcbb-ca65b8671b9e?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Spawn Count | 2 |
   | Guard Team Option | Team Wildlife & Creatures |
   | Spawn Radius | 25M |
   | Max Patrol Distance | 25.0M |
   | Drop Inventory on Elimination | No |
6. Configure the following event on the Guard Spawner device to increase the player’s Target Stat when a guard is eliminated.

   [![](https://dev.epicgames.com/community/api/documentation/image/02e67977-0374-4f32-97e1-f9dbbba28d79?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02e67977-0374-4f32-97e1-f9dbbba28d79?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Eliminated | Increase Target Stat Powerup | Pickup |
7. Duplicate the Guard Spawner device and place it next to the previous guard spawner. It will spawn guards when the player has a Target Level of at least 2.
8. Customize the new Guard Spawner device:

   [![](https://dev.epicgames.com/community/api/documentation/image/e4752b56-a310-41e1-bfb2-179f4008834f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e4752b56-a310-41e1-bfb2-179f4008834f?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/bfc9c796-e3e2-4b9e-aaae-6cf10ae1e941?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bfc9c796-e3e2-4b9e-aaae-6cf10ae1e941?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Guard Type | Ghost |
   | Spawn Count | 3 |
   | Guard Team Option | Team Wildlife & Creatures |
   | Spawn Radius | 25M |
   | Enabled at Game Start | Disabled |
   | Max Patrol Distance | 25.0M |
   | Drop Inventory on Elimination | No |
9. Duplicate the guard spawner one more time and place it next to the other two. It will spawn guards when the player has a Target Level of 3.
10. Customize the third guard spawner:

    [![](https://dev.epicgames.com/community/api/documentation/image/6f91b693-70b4-4534-bf33-ad30e20b3521?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6f91b693-70b4-4534-bf33-ad30e20b3521?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Guard Type | Grotto |
    | Guard Team Option | Team Wildlife & Creatures |
    | Spawn Radius | 25M |
    | Enabled at Game Start | Disabled |
    | Max Patrol Distance | 25.0M |
    | Drop Inventory on Elimination | No |
11. Place a **Button** device inside a nearby house.
12. Customize the button:

    [![](https://dev.epicgames.com/community/api/documentation/image/894699a8-5334-4685-9c6c-8b7d25225c31?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/894699a8-5334-4685-9c6c-8b7d25225c31?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Interact Time | 1.0 Second |
    | Reset Delay | 10 Seconds |
    | Interaction Text | Call them off! |
13. Configure the following event on the button to decrease the player’s Target Stat when they call off the guards by interacting with the button.

    [![](https://dev.epicgames.com/community/api/documentation/image/23a9803c-2b3c-4385-af24-dee0d298e164?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23a9803c-2b3c-4385-af24-dee0d298e164?resizing_type=fit)

    | Event | Select Device | Select Function |
    | --- | --- | --- |
    | On Interact | Decrease Target Stat Powerup | Pickup |

### Configure the Leveling System

1. Place a **Stat Counter** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/d2b47888-e1c2-45f8-9089-698489d69dac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d2b47888-e1c2-45f8-9089-698489d69dac?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Tracked Stat | Target (Level) |
   | Compare Type | Equal To |
   | Broadcast Events On Stat Change | On |
   | Visible in Game | No |
2. Configure the following event on the stat counter to disable the Level 2 Guard Spawner when the player’s level changes to Level 1.

   [![](https://dev.epicgames.com/community/api/documentation/image/5c2aec4c-d365-4a06-8c25-93e2cd4c4c47?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c2aec4c-d365-4a06-8c25-93e2cd4c4c47?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Compare Success | Level 2 Guard Spawner | Disable |
3. Place another **Stat Counter** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/1602890d-c235-4e96-81e6-fdedb7300ca9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1602890d-c235-4e96-81e6-fdedb7300ca9?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Tracked Stat | Target (Level) |
   | Compare Type | Equal To |
   | Comparison Value | 2 |
   | Broadcast Events On Stat Change | On |
   | Visible in Game | No |
4. Configure the following event to disable the **Level 3 Guard Spawner** and enable the **Level 2 Guard Spawner** when the player’s level changes to Level 2.

   You must call events on both of these spawners because you don't know whether the player will be leveling up to Level 2 from Level 1 or down from Level 3.

   [![](https://dev.epicgames.com/community/api/documentation/image/d0747069-8b33-4e11-be83-07911d092b3b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0747069-8b33-4e11-be83-07911d092b3b?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Compare Success | Level 2 Guard Spawner | Enable |
   | On Compare Success | Level 3 Guard Spawner | Disable |
5. Place one more **Stat Counter** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/7f688287-4992-444f-8333-f6692b6b07c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7f688287-4992-444f-8333-f6692b6b07c2?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Tracked Stat | Target (Level) |
   | Compare Type | Equal To |
   | Comparison Value | 3 |
   | Broadcast Events On Stat Change | On |
   | Visible in Game | No |
6. Configure the following event to enable the **Level 3 Guard Spawner** when the player’s level changes to Level 3.

   [![](https://dev.epicgames.com/community/api/documentation/image/a708bf82-3123-4e62-a9be-fd6532d79510?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a708bf82-3123-4e62-a9be-fd6532d79510?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Compare Success | Level 3 Guard Spawner | Enable |
7. Duplicate the cluster of three guard spawners and place the copies in a different area.
8. Repeat the previous step.

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > Player**.
2. Under **Equipment**, change **Environment Damage** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/8afe09bf-5545-482e-ab04-5dd8ef866e19?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8afe09bf-5545-482e-ab04-5dd8ef866e19?resizing_type=fit)
3. Go to **Island Settings > Mode**.
4. Under **Eliminations**, change **Eliminated Player’s Items** to **Keep**.

   [![](https://dev.epicgames.com/community/api/documentation/image/5f05779f-56d9-4812-9ec0-aac4fba996ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f05779f-56d9-4812-9ec0-aac4fba996ac?resizing_type=fit)

You now have a working target system with the Stat Creator device!

### Design Tip

This is a classic system that can spruce up all kinds of open world games!

You can also use this with a multiplayer map — maybe the player with the most eliminations has a higher Target Level and gives other players more points for an elimination!
