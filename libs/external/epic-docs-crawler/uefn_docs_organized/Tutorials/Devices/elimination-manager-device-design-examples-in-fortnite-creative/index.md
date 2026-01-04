# Elimination Manager Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/elimination-manager-device-design-examples-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:04:59.188853

---

With the **Elimination Manager** device, you can drop items on the device to register them, then when a player eliminates a specified target, items registered with this device can spawn at the eliminated target's location.

You can set the device to drop items in a specific order, or randomly. You can have the items drop based on elimination of other players or other enemies such as fiends or sentries.

Here are some examples of how you can use the Elimination Manager device.

- [Basic Drops](https://dev.epicgames.com/documentation/en-us/fortnite/elimination-manager-device-design-examples-in-fortnite-creative)
- [Drop Chance](https://dev.epicgames.com/documentation/en-us/fortnite/elimination-manager-device-design-examples-in-fortnite-creative)
- [Elimination Penalty](https://dev.epicgames.com/documentation/en-us/fortnite/elimination-manager-device-design-examples-in-fortnite-creative)

## Basic Drops

Use the Elimination Manager to control item drops when enemies are eliminated. Dropped items can then be used to redeem rewards or give players other benefits.

### Devices Used

- 1 x **Elimination Manager**
- 1 x [**Creature Spawner**](using-creature-spawner-devices-in-fortnite-creative)
- 1 x [**Item Granter**](using-item-granter-devices-in-fortnite-creative)
- 1 x [**Conditional Button**](using-conditional-button-devices-in-fortnite-creative)

### Build It Yourself

1. Place a **Creature Spawner** and customize it as follows:

   [![Basic Drops Creature Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/51e2e05a-af8d-49a6-95d7-ddabbea750c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/51e2e05a-af8d-49a6-95d7-ddabbea750c3?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Creature Type** | Fiend | The Creature Spawner will only spawn fiends. |
2. Place an **Elimination Manager** and drop a **Pumpkin** while standing near it to register the item.
3. Customize it as follows:

   [![Basic Drops Elimination Manager Settings](https://dev.epicgames.com/community/api/documentation/image/81dc1353-6c28-4a78-aa94-def13dfcb38d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/81dc1353-6c28-4a78-aa94-def13dfcb38d?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Target Type** | All Creatures | All creatures will drop the registered item when eliminated. |
4. Place an **Item Granter** and drop a **Tactical Assault Rifle** while standing near it to register the weapon. Customize it as follows:

   [![Basic Drops Item Granter Settings](https://dev.epicgames.com/community/api/documentation/image/60faa6a2-1221-48da-adad-c44cd9269beb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/60faa6a2-1221-48da-adad-c44cd9269beb?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Equip Granted Item** | First Item | When the Tactical Assault Rifle is granted, it will automatically become equipped. |
5. Place a **Conditional Button** and drop a **Pumpkin** while standing near it to register the item. Customize it as follows:

   [![Basic Drops Conditional Button Settings](https://dev.epicgames.com/community/api/documentation/image/2dac157a-4bda-45a2-8a7b-7f1e83510e0e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2dac157a-4bda-45a2-8a7b-7f1e83510e0e?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Key Items Required** | 50 | The Conditional Button will require 50 Pumpkins to be activated (Pumpkins are dropped in stacks of 10). |
6. Set the direct event bindings of the Conditional Button to the following:

   [![Basic Drops Conditional Button Events](https://dev.epicgames.com/community/api/documentation/image/bfc42aef-c659-48dd-9936-634c130e4917?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bfc42aef-c659-48dd-9936-634c130e4917?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | **On Activated Send Event To** | ItemGranter | Grant Item | When the player successfully activates the Conditional Button, they will be granted the Tactical Assault Rifle. |

Here's an overview of how devices communicate in this example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Item Granter** | Grant Item | **Conditional Button** | On Activated Send Event To | When the player successfully activates the Conditional Button, they will be granted the Tactical Assault Rifle. |

You now have the functionality for basic enemy drops using the Elimination Manager.

This core functionality of the Elimination Manager is fundamental to many different game modes and has potential to create many different experiences. This example could be extended to a full game with different enemy types, upgrade choices, waves, and so on. Enemies can drop many different items, so consider making them drop items, new weapons, or building materials.

## Drop Chance

Use the Elimination Manager drop chance functionality to hide key items in a swarm of enemies.

### Devices Used

- 1 x **Elimination Manager**
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x [**Creature Spawner**](using-creature-spawner-devices-in-fortnite-creative)
- 1 x [**Lock Device**](using-lock-devices-in-fortnite-creative)
- 1 x [**Conditional Button**](using-conditional-button-devices-in-fortnite-creative)

### Build It Yourself

1. Create a small play area with a door on one wall and a **Player Spawner** across the room. Keep the default settings on the Player Spawner.
2. Place a **Creature Spawner** in the center of the room and customize it to the following settings:

   [![Drop Chance Creature Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/13f2e48f-d913-4a53-8b61-21de8f1ade4a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13f2e48f-d913-4a53-8b61-21de8f1ade4a?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Creature Type** | Fiend | The Creature Spawner will only spawn fiends. |
   | **Spawner Visibility** | Off | The Creature Spawner itself will not be visible during gameplay. |
3. Place an **Elimination Manager** and drop a **Key** while standing near it to register the item. Customize it to the following settings:

   [![Drop Chance Elimination Manager Settings](https://dev.epicgames.com/community/api/documentation/image/7f5f9ab1-9908-440e-a11e-a4c03ffe9a0d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7f5f9ab1-9908-440e-a11e-a4c03ffe9a0d?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Target Type** | All Creatures | All creatures will have a possibility of dropping the registered item when eliminated. |
   | **Drop Chance** | 10% | There will be a 10% chance for any given eliminated enemy to drop the registered item. |
4. Place a **Lock Device** next to the door and keep the default settings.
5. Place a **Conditional Button** next to the door and drop a **Key** while standing near it to register the item. Keep the default settings and set the direct event bindings to the following:

   [![Drop Chance Conditional Button Events](https://dev.epicgames.com/community/api/documentation/image/c757e27a-2805-4c81-824a-afbb4c11bb1c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c757e27a-2805-4c81-824a-afbb4c11bb1c?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | **On Activated Send Event To** | LockDevice | Open | When the player activates the Conditional Button with the Key, the door will open and allow them to escape. |

Here's an overview of how devices communicate in this example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **LockDevice** | Open | **ConditionalButton** | On Activated Send Event To | When the player activates the Conditional Button with the Key, the door will open and allow them to escape. |

You now have the basic functionality for a rare item drop.

This example could be easily extended by requiring more Key items for the player to escape the area or receive a reward. Different items could be dropped by different enemies, or larger enemies could have a higher chance of dropping a rare item. Explore different combinations of items, enemies, and drop chances to find a balance that feels engaging and fair.

It is often a good idea to make sure that higher-quality items are dropped less frequently than items with less power, and the drop chance setting is a great way to control this.

## Elimination Penalty

The Elimination Manager can also control how players are penalized when eliminated. Use the **Elimination Penalty** option to create a simple 1v1 game with a currency system.

### Devices Used

- 1 x **Elimination Manager**
- 2 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 5 x [**Item Spawner**](using-item-spawner-devices-in-fortnite-creative)
- 1 x [**Item Granter**](using-item-granter-devices-in-fortnite-creative)
- 1 x [**Conditional Button**](using-conditional-button-devices-in-fortnite-creative)

### Build It Yourself

1. Create a simple enclosed play area and place 2 **Player Spawners** in separate areas, one for each team. Customize them to the following settings:

   [![Elimination Penalty Player Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/948770fb-d4b6-45b1-aec6-f8e57868e8d3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/948770fb-d4b6-45b1-aec6-f8e57868e8d3?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Player Team** | Team 1, Team 2 | This team will spawn in the Player Spawner (use one team for each Player Spawner). |
   | **Visible in Game** | Off | The Player Spawners will be invisible during gameplay. |
2. Place an **Item Spawner** and drop Gold while standing near it to register the item. Customize it to the following settings:

   [![Elimination Penalty Item Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/c28dcaf6-e6aa-4c2e-8b85-6110ef8fce27?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c28dcaf6-e6aa-4c2e-8b85-6110ef8fce27?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Base Visible During Game** | Off | The base of the Item Spawner will be invisible during gameplay. |
   | **Time Before First Spawn** | Instant | The item will be spawned instantly when the game begins. |
   | **Time Between Spawns** | 5.0 Seconds | The item will respawn every 5 seconds. |
   | **Run Over Pickup** | On | The player will be able to pick up the item just by running over it. |
3. Duplicate this Item Spawner and place 4 more around the play area.
4. Place an **Elimination Manager** outside of the play area and customize it to the following settings:

   [![Elimination Penalty Elimination Manager Settings](https://dev.epicgames.com/community/api/documentation/image/23c59709-5c04-44ae-8b89-76da997c85cc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23c59709-5c04-44ae-8b89-76da997c85cc?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Target Type** | Players Only | Players will be affected by this Elimination Manager. |
   | **Elimination Penalty** | On | There will be a penalty applied when players are eliminated. |
   | **Penalty Item** | Gold | When players are eliminated, they will lose Gold. |
   | **Penalty Amount** | 50.0% | Players will lose half of their Gold when they are eliminated. |
   | **Penalty Effect** | Grant | The Gold that players lose will be granted to the player who eliminated them. |
5. Place an **Item Granter** outside of the play area and drop a Tactical Assault Rifle while standing near it to register the weapon. Customize it as follows:

   [![Elimination Penalty Item Granter Settings](https://dev.epicgames.com/community/api/documentation/image/62ba0a61-3a22-4181-80bc-32f0d3b37292?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/62ba0a61-3a22-4181-80bc-32f0d3b37292?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Equip Granted Item** | Yes | When players are granted an item, it will be automatically equipped. |
6. Place a **Conditional Button** on one of the walls of the play area and drop Gold while standing near it to register the item. Customize it as follows:

   [![Elimination Penalty Conditional Button Settings](https://dev.epicgames.com/community/api/documentation/image/fd113629-151a-4049-80b1-c4198bf27395?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fd113629-151a-4049-80b1-c4198bf27395?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Key Items Required** | 2,500 | The player will need 2,500 Gold to activate the Conditional Button (Gold is spawned in stacks of 500). |
7. Set the direct event bindings of the Conditional Button to the following:

   [![Elimination Penalty Conditional Button Events](https://dev.epicgames.com/community/api/documentation/image/6399e475-a639-4469-a6a5-53dc0a6b5d04?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6399e475-a639-4469-a6a5-53dc0a6b5d04?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | **On Activated Send Event To** | WeaponItemGranter | Grant Item | When the player successfully activates the Conditional Button, they will be granted the Tactical Assault Rifle. |
8. Finally, modify the following [**Island Settings**](understanding-island-settings-in-fortnite-creative):

   | Category | Setting | Value | Explanation |
   | --- | --- | --- | --- |
   | [**Player Settings**](player-settings-in-fortnite-creative) | Infinite Building Materials | **Off** | Players will not have unlimited resources. |
   | [**Mode**](mode-settings-in-fortnite-creative) | Eliminated Player's Items | **Keep** | The player will keep the items they had when eliminated. |
   | [**User Interface**](user-interface-settings-in-fortnite-creative) | Show Gold Resource Count | **Yes** | The HUD will show how much Gold the player has. |

Here's an overview of how devices communicate in this example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **WeaponItemGranter** | Grant Item | **ConditionalButton** | On Activated Send Event To | When the player successfully activates the Conditional Button, they will be granted the Tactical Assault Rifle. |

You now have the functionality for a game based around elimination penalties using the Elimination Manager.

The Elimination Manager has many settings that you can use to control how elimination penalties work in your game. You can set items to drop on the ground instead of being granted, or they can be removed from the game entirely. Players could lose score or resources instead of gold, or they could lose all three!

Play with different settings and different penalty amounts to find the configuration that best suits your game.
