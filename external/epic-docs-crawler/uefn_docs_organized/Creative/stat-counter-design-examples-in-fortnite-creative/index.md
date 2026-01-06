# Stat Counter Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/stat-counter-design-examples-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:06:14.804626

---

The **Stat Counter** device is a way you can set statistic (stat) limits, then trigger events when those limits are met.ake an Elimination Gate

You can set the Stat Counter device to require that a player reach a specified quantity of a stat then trigger another device!

### Devices Used

- 1 x [Stat Counter](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-counter-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device
- 1 x [Guard Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative) device

### Set Up the Devices

1. Place a **Player Spawner** device.
2. Place an **Item Granter** device and register a **Legendary Tactical Assault Rifle** to the granter.
3. Customize the Item Granter device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/356c3f48-fbef-4373-ab28-299806625e0a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/356c3f48-fbef-4373-ab28-299806625e0a?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | Grant on Game Start | On |
4. Place a large **Stat Counter** device in a place where the player can see it.
5. Customize the counter:

   [![](https://dev.epicgames.com/community/api/documentation/image/17077b0b-bafc-452f-bd6c-492228dab955?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17077b0b-bafc-452f-bd6c-492228dab955?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Tracked Stat | AI Eliminations |
   | Comparison Value | 3 |
   | Broadcast Events On Stat Change | On |
6. Place a **Guard Spawner** device.
7. Customize the device:

   [![](https://dev.epicgames.com/community/api/documentation/image/8b7f0e69-f18c-4dee-acef-5691c08f339f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b7f0e69-f18c-4dee-acef-5691c08f339f?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Guard Team Option | Team Wildlife & Creatures |
8. Configure the following event on the **Stat Counter** device so that when the player reaches **3 AI eliminations**, it disables the spawner:

   [![](https://dev.epicgames.com/community/api/documentation/image/b9af9509-d236-4b7c-8644-5ac1e6ffec77?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9af9509-d236-4b7c-8644-5ac1e6ffec77?resizing_type=fit)

| Event | Select Device | Select Function |
| --- | --- | --- |
| On Compare Success | Guard Spawner | Disable |

You now have the basic functionality for an elimination gate using the Stat Counter device!

### Design Tip

At its most basic level, the Stat Creator device is great for tracking and changing stats and triggering gameplay changes when stats reach a certain value.

Explore the different built-in stats that can be tracked, then in future examples, use your own custom stats!

## Build a Stealth Tracker

The **Stat Counter** can be configured to only check a value at a certain point, which lets you track stats then decide how to respond to them later.

### Devices Used

- 1 x Stat Counter device
- 1 x Player Spawner device
- 2 x Item Granter devices
- 3 x [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative) devices
- 1 x [Stat Creator](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-creator-devices-in-fortnite-creative) device
- 5 x [Guard Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative) devices
- 1 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) device

### Set Up the Basic Gameplay

1. Place the **Castle** prefab.
2. Place a **Player Spawner** device.
3. Customize the player spawner and customize it to not be visible in-game:

   [![](https://dev.epicgames.com/community/api/documentation/image/e7e6a334-37d4-46c2-88e8-71cf9497a30a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7e6a334-37d4-46c2-88e8-71cf9497a30a?resizing_type=fit)
4. Place an **Item Granter** and register a **Legendary Suppressed Pistol** to the device.
5. Customize the granter:

   [![](https://dev.epicgames.com/community/api/documentation/image/3c6cc793-6d5c-4d64-a618-ea16c26ef565?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c6cc793-6d5c-4d64-a618-ea16c26ef565?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | Grant on Game Start | On |
6. Place a **HUD Message** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/fe8ec964-b9ef-4d27-8df2-3741ed6bd327?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fe8ec964-b9ef-4d27-8df2-3741ed6bd327?resizing_type=fit)

   | Option |  |
   | --- | --- |
   | Message | Make it to the top of the castle! |
   | Show on Round Start | On |
   | Time from Round Start | Instant |
   | Text Color | White |
7. Place a **Stat Creator** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/50642b64-2253-4c57-96e2-2e7c6db448ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/50642b64-2253-4c57-96e2-2e7c6db448ff?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat Name | Guard Alerts |
   | Stat Color | #FF0100 |
   | Stat Icon | Exclamation |
8. Place a **Stat Counter** device on top of the castle and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/61d94156-886a-47ba-8cb4-37394ea47e1a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/61d94156-886a-47ba-8cb4-37394ea47e1a?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/a84406fd-5d13-4df2-bc40-7fe2a078df94?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a84406fd-5d13-4df2-bc40-7fe2a078df94?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Tracked Stat | Guard Alerts |
   | Compare Type | Equal or Fewer |
   | Comparison Value | 10 |
   | Value Override Type | Add |
   | Value Override | 1 |
   | Value to Show | Value |
   | Show Background | Off |
9. Place a **Guard Spawner** device on the player's path to the top of the castle and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/246cb20a-44ed-4b1f-8cea-ac7767b7466f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/246cb20a-44ed-4b1f-8cea-ac7767b7466f?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/da1a70a2-d113-4ad4-be8d-e37f59af2f15?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da1a70a2-d113-4ad4-be8d-e37f59af2f15?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Spawn Count | 2 |
   | Allow Infinite Spawn | No |
   | Total Spawn Limit | 2 |
   | Guard Team Option | Team Wildlife & Creatures |
   | Spawn Through Walls | Off |
   | Max Patrol Distance | 25.0M |
   | Visibility Range | 20M |
   | Team Awareness Propagation | No |
10. Configure the following event on the guard spawner so that when a guard is alerted, the stat counter adds **1** to the Guard Alerts stat.

    [![](https://dev.epicgames.com/community/api/documentation/image/849e788e-41c8-44b4-8dc9-a2ce7dd7da59?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/849e788e-41c8-44b4-8dc9-a2ce7dd7da59?resizing_type=fit)

    | Event | Select Device | Select Function |
    | --- | --- | --- |
    | On Alerted To Player | Stat Counter | Override value |
11. Duplicate the guard spawner four more times and place them on the player’s path to the top of the castle.

### Configure the Rewards

1. Place an **Item Granter** device and register a stack of **Gold** to the device.
2. Customize the item granter:

   [![](https://dev.epicgames.com/community/api/documentation/image/a79ecda4-2ba6-4059-8f4b-f7c7a44d4126?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a79ecda4-2ba6-4059-8f4b-f7c7a44d4126?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | On Grant Action | Keep All |
   | Drop Items at Player Location | Always |
3. Place a **HUD Message** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/2b8840a5-60d1-4f50-9709-d0ec0682cb5d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b8840a5-60d1-4f50-9709-d0ec0682cb5d?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Message | Well done! Here's your reward... |
   | Text Color | White |
4. Place another **HUD Message** device and customize with a different message.

   [![](https://dev.epicgames.com/community/api/documentation/image/daf8c604-8dc9-4bb9-a12b-1ed0f3ba4d1c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/daf8c604-8dc9-4bb9-a12b-1ed0f3ba4d1c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Message | You alerted too many Guards! No reward for you! |
   | Text Color | White |
5. Configure the following event on the **Stat Counter** device so that when the stat is checked, if the player succeeds (alerted guards ten times or less), the reward is given and the success message is shown, but if they do not succeed, it will show the failure message.

   [![](https://dev.epicgames.com/community/api/documentation/image/a895ca8a-ca64-4441-92d4-09252192600c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a895ca8a-ca64-4441-92d4-09252192600c?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Compare Success | Success HUD Message Device | Show |
   | On Compare Success | Reward Item Granter | Grant Item |
   | On Compare Failure | Failure HUD Message Device | Show |
6. Place a wide **Trigger** device across the stairs on top of the castle as shown:

   [![](https://dev.epicgames.com/community/api/documentation/image/0ed5db35-d0bc-4b52-b3b2-705f4581ae36?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0ed5db35-d0bc-4b52-b3b2-705f4581ae36?resizing_type=fit)
7. Customize the trigger:

   [![](https://dev.epicgames.com/community/api/documentation/image/7333d23f-1baf-4559-b2b2-d8f02308c38a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7333d23f-1baf-4559-b2b2-d8f02308c38a?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Visible In Game | Off |
   | Times Can Trigger | 1 |
   | Trigger VFX | Off |
   | Trigger SFX | Off |
8. Configure the following event on the trigger to see whether the player succeeded or failed when they reach the top of the castle.

   [![](https://dev.epicgames.com/community/api/documentation/image/63a2b88e-852c-49c7-be3f-1152c15837aa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/63a2b88e-852c-49c7-be3f-1152c15837aa?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Triggered | Stat Counter | Compare Stat |

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > Player.**
2. Under **Equipment**, change **Environment Damage** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/ab1ab4b3-b774-4a5c-9d6c-d7001290fa6d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ab1ab4b3-b774-4a5c-9d6c-d7001290fa6d?resizing_type=fit)

You now have the basic functionality for a stealth tracker using the Stat Counter device!

### Design Tip

As this example shows, there are different ways to compare stats with the Stat Counter device. You can check whether a stat is lower, higher, equal to, or not equal to another stat, so experiment with ways to create custom stat mechanics.

## Build a Crafting Level System

The Stat Counter can be used to track levels of a given stat, allowing you to configure different unlocks for different levels. In this example, you’ll create a crafting level system that will unlock new crafting recipes as players harvest more material!

### Devices Used

- 1 x [Skilled Interaction](https://dev.epicgames.com/documentation/en-us/fortnite/using-skilled-interaction-devices-in-fortnite-creative) device
- 1 x Player Spawner device
- 1 x Stat Creator device
- 1 x [Stat Powerup](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-powerup-devices-in-fortnite-creative) device
- 25 x [Prop Manipulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-manipulator-devices-in-fortnite-creative) devices
- 3 x Item Granter devices
- 3 x [Conditional Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative) devices

### Set Up the Basic Stat Devices

1. Begin with the **Mountain Ridge Island** starter island.
2. Place a **Player Spawner** device and customize so that it is not visible in-game.
3. Place a **Stat Creator** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/c58a1fe0-c91b-474a-98ec-46cc72dd792f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c58a1fe0-c91b-474a-98ec-46cc72dd792f?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat Name | Harvest Skill |
   | Max Value | 5 |
   | Max Level | 3 |
   | Stat Color | #FFF000 |
   | Stat Icon | Cave |
4. Place a **Stat Counter** device to trigger gameplay unlocks when the player reaches Level 2. Customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/b6f4b670-f945-4c2c-9850-2173dabc2052?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6f4b670-f945-4c2c-9850-2173dabc2052?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Tracked Stat | Harvest Skill (Level) |
   | Compare Type | Equal To |
   | Comparison Value | 2 |
   | Broadcast Events On Stat Change | On |
   | Visible in Game | No |
5. Place another Stat Counter device to trigger gameplay unlocks when the player reaches Level 3, and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/2b77cb56-1ca9-4805-a268-bc96e29be713?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b77cb56-1ca9-4805-a268-bc96e29be713?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Tracked Stat | Harvest Skill (Level) |
   | Compare Type | Equal To |
   | Comparison Value | 3 |
   | Broadcast Events On Stat Change | On |
   | Visible in Game | No |
6. Place a **Stat Powerup**  device where the player cannot reach it. This device will increase the player’s **Harvest Skill** when they mine ores.
7. Customize the Stat Powerup device:

   [![](https://dev.epicgames.com/community/api/documentation/image/b9cf19f4-1da0-4a59-94f8-2d2e1353885b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9cf19f4-1da0-4a59-94f8-2d2e1353885b?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat to Apply | Harvest Skill |
   | Effect Duration | Instant |
   | Time To Respawn | Instant |
   | Ambient Audio | Off |
   | Pick Up Audio | Off |
   | Who Can See This Powerup | None |

### Set Up the Mining Sources

1. Place a rock from the **Rocky Desert Nature** gallery. This will contain the **Copper** resource.
2. Place a **Prop Manipulator** attached to the rock. Register a **Copper** item to the device.
3. Customize the Prop Manipulator:

   [![](https://dev.epicgames.com/community/api/documentation/image/051123c1-d569-4a93-8e46-599aa471156c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/051123c1-d569-4a93-8e46-599aa471156c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Override Resources | On |
   | Resource Node Available | 5 |
   | Resource Node Type | Item |
   | Resource Node Depletion Mode | Destroy |
4. Configure the following event on the **Prop Manipulator** device to increase the player’s Harvest Skill when the rock is destroyed:

   [![](https://dev.epicgames.com/community/api/documentation/image/6dd1f507-c91d-4e09-b55f-3ccebdbe5334?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6dd1f507-c91d-4e09-b55f-3ccebdbe5334?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Destroyed | Harvest Stat Powerup | Pickup |
5. Place a rock from the **Tropical Rock** gallery. This will contain the **Silver** resource.
6. Duplicate the previous **Prop Manipulator** device and place it on the new Silver rock. Clear the items in the prop manipulator and register a **Silver** item to the device.
7. Customize the prop manipulator:

   [![](https://dev.epicgames.com/community/api/documentation/image/d7c79864-66d6-4648-b99e-ddc3881e6145?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d7c79864-66d6-4648-b99e-ddc3881e6145?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Start Hidden | On |
   | Override Resources | On |
   | Resource Node Available | 5 |
   | Resource Node Type | Item |
   | Resource Node Depletion Mode | Destroy |
8. Place a rock from the **Volcanic Rock** gallery. This will contain the **Obsidian** resource.
9. Duplicate the previous prop manipulator and place it on the new Obsidian rock.
10. Clear the items in the prop manipulator and register an Obsidian item to the device, then rename the Prop Manipulator device to Level 3 Prop Manipulator.  Leave the settings from the Level 2 Prop Manipulator the same.

### Configure the Crafting System

1. Place a **large tree** near the player’s spawn point.
2. Place an **Item Granter** device rename it **Level 1 Item Granter** then register a **Grappler** to the device.
3. Place a **Conditional Button** device against the tree. Register **10 Copper** to the device.
4. Customize the conditional button to set the **Interact Text** to **Craft Grappler**:

   [![](https://dev.epicgames.com/community/api/documentation/image/5b13bbc4-cc41-4f7a-8c76-8e0b00151a79?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5b13bbc4-cc41-4f7a-8c76-8e0b00151a79?resizing_type=fit)
5. Configure the following event on the **Conditional Button** device so that when the player activates it with 10 Copper, they are given a **Grappler**.

   [![](https://dev.epicgames.com/community/api/documentation/image/a16c518c-3961-4115-a6a1-8bb86908c1df?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a16c518c-3961-4115-a6a1-8bb86908c1df?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Activated Send Event To | Level 1 Item Granter | Grant Item |
6. Duplicate the **Item Granter** and **Conditional Button** devices together and rename the devices to **Level 2...** instead of **Level 1... .**
7. Customize the conditional button:

   [![](https://dev.epicgames.com/community/api/documentation/image/7c5a98a2-bfb3-42e1-810f-197a7db80a29?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7c5a98a2-bfb3-42e1-810f-197a7db80a29?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Interact Text | Craft Grapple Glove |
   | Number of Key Item Slots | 2 |
   | Enabled on Game Start | Off |
8. Clear the items from the Prop Manipulator and Item Granter devices. Register a **Grapple Glove** in the Item Granter device. Register **10 Copper** and **10 Silver** in the Conditional Button device.
9. Duplicate the Item Granter and Conditional Button devices together and rename the devices to 
   Level 3... instead of Level 2...  .
10. Customize the new Conditional Button device:

    [![](https://dev.epicgames.com/community/api/documentation/image/89862c4c-2ff3-4d9f-a70d-6d5dde85950e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/89862c4c-2ff3-4d9f-a70d-6d5dde85950e?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Interact Text | Craft Jetpack |
    | Number Of Key Item Slots | 3 |
    | Enabled on Game Start | Off |
11. Clear the items from the Prop Manipulator and Item Granter devices. Register a **Grapple Glove** in the Item Granter device. Register **10 Copper**, 1**0 Silver**, and **10 Obsidian** in the Conditional Button device.

    For clarity, use Billboard devices to label the different Conditional Button devices.
12. Configure the following event on the **Level 2 Stat Counter** device to unlock the **Level 2 crafting recipe** and show the Silver rock when the player reaches **Level 2**.

    [![](https://dev.epicgames.com/community/api/documentation/image/dab23740-2311-42f9-a7e2-61c0c0cfe683?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dab23740-2311-42f9-a7e2-61c0c0cfe683?resizing_type=fit)

    | Event | Select Device | Select Function |
    | --- | --- | --- |
    | On Compare Success | Level 2 Prop Manipulator | Show Props |
    |  |  |  |
    | --- | --- | --- |
13. Configure the following event on the Level 3 Stat Counter device to unlock the Level 3 crafting recipe and show the Obsidian Rock when the player reaches Level 3.
14. Duplicate the Copper rock and Prop Manipulator 9 more times, placing them around the map.
15. Duplicate the Silver Rock and Prop Manipulator 9 more times, placing them around the map.
16. Duplicate the Obsidian Rock and Prop Manipulators four more times, placing them around the map.

You now have a working crafting system with level-up unlocks!

### Design Tip

This system is extremely useful for many different game modes in which you might want to track custom skills with their own unique unlocks. Consider all of the different skills you could track: mining, fishing, combat, socializing, and so many more!

 Device

[![](https://dev.epicgames.com/community/api/documentation/image/c40073e3-8c53-40bc-a911-5a22f7594a5c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c40073e3-8c53-40bc-a911-5a22f7594a5c?resizing_type=fit)
