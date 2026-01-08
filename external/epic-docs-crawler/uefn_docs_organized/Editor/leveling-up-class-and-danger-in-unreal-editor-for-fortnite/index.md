# Leveling Up Class and Danger

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/leveling-up-class-and-danger-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:38:52.043299

---

Raise the stakes for players by leveling up the danger with each nightfall. Higher levels of danger coincide with an increase in the player's class and weapon strength. This makes the game engaging and gives the player a chance to increase their skills.

In this example, each time the player triggers the Nightmare Day Sequence device they also trigger a Creature Spawner and a Class Selector device. Increasingly more difficult creatures spawn with each night sequence. The player’s class is leveled up at the same time as a new horde of creatures spawns. Each new class provides a more powerful weapon to the player's weapons cache, giving them a better chance to defeat the creature hordes.

Devices used are:

- **Class Selector**
- **Item Spawner**
- **Creature Spawner**
- **Guard Spawner**
- **AI Patrol Path Node**
- **Danger Volume**
- **Prop Mover**

## Leveling Up Class and Weapons

Class selectors increase the player's class level as they progress through the game. Each time a player's class levels up, they're provided with a more powerful weapon. All weapons stay equipped, providing the player with a cache of weapons.

[![](https://dev.epicgames.com/community/api/documentation/image/df65bc1a-4e76-4379-af22-45924b112211?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/df65bc1a-4e76-4379-af22-45924b112211?resizing_type=fit)

### Class Selector

Modify the user options on the first Class Selector then duplicate the device as many times as you need to level up a player toward the boss fight at the end of the game.

[![](https://dev.epicgames.com/community/api/documentation/image/79e4deb5-37c0-46af-bd25-88f4801d72a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/79e4deb5-37c0-46af-bd25-88f4801d72a2?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| Class to Switch to (This option needs to be set to **True** in order to modify its options.) | Class Slot > 1 | This is the first class a player switches to. |
| Visible During Game | False | Seeing this device is unnecessary. |
| Volume Visible in Game | False | Seeing the volume is unnecessary. |

#### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| Class Selector | Change Player to Class | Trigger 2 | On Triggered | When the player trips the second trigger, their class changes. |
|  |  |  |  |  |

### Item Granter

Modify the device options, then duplicate as many times as there are classes.

[![](https://dev.epicgames.com/community/api/documentation/image/e8830a09-6492-43a2-b173-aa599a5408e4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8830a09-6492-43a2-b173-aa599a5408e4?resizing_type=fit)

After modifying the Item Granter's options, duplicate as many times as you have classes.

| Option | Value | Explanation |
| --- | --- | --- |
| On Grant Item | Keep All | Player keeps all their weapons even as they collect new ones. |
| Grant | All Items | Grants all the weapons listed |
| **Item List** | Array Element 1 | Opens a weapons slot |
| Item Definition | Infiltrator Pump Shotgun | Provides the player with a pump shotgun when the game begins. |
| Receiving Players | All | Provides the shotgun to the player who starts the game without a class or team. |
| Equip Granted Item | True | Equips the player with the weapon. |
| Initial Weapon Ammo | 999 | Provides enough ammo the player shouldn't run out. |
| Spare Ammo | 999 | Provides enough ammo the player shouldn't run out. |
| Drop Items at Player Location | Never | The weapons should always appear in the player's inventory. |

As the class increases, the weapons provided should also increase in power. The new weapon's power should provide a certain level of challenge to defeating the horde of creatures.

#### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| Item Granter | Enable | Player Spawner | On Player Spawned | The player spawns in and enables the device. |
|  |  |  |  |  |
| Item Granter | Grant Item | Player Spawner | On Player Spawned | When the player spawns into the game they are equipped with their first weapon. |
|  |  |  |  |  |
| Item Granter | Enabled | Trigger | On Triggered | When the player trips the trigger it enables the Item Granter. |
|  |  |  |  |  |
| Item Granter | Grant Item | Class Selector | On Class Switched | When the player switches class, they are granted the new weapon. |
|  |  |  |  |  |

The second item granter is bound to the second trigger, but grants the weapon when the first class selector switches the player's class.

## Leveling Up the Danger

As the player's class level and weapon power increase, the number of creatures and the challenges they present should also increase. To finish off the experience, players have a limited time to fight a guard that poses a considerable threat.

There should also be environmental dangers that teach players where they can and can't go in the game.

[![](https://dev.epicgames.com/community/api/documentation/image/0c7861fb-551c-4c42-a3de-94119f78ed16?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c7861fb-551c-4c42-a3de-94119f78ed16?resizing_type=fit)

### Creature Spawner

There are eight Creature Spawner devices in this game. Modify the basic options, then copy and paste the device around your island. Every additional spawner should increase the number of creatures spawned and their difficulty level.

| Option | Value | Explanation |
| --- | --- | --- |
| Creature Type | Fiend | Spawns the basic creature type. |
| Number of Creatures | 6 | Provides an easy challenge for the player who is armed with a shotgun. |
| Spawn Through Walls | False | Creatures must spawn within the line of sight of the device. |
| Limit Spawned Creatures | True | Limits the total number of spawned creatures to the number provided in Number of Creatures. |
| Total Spawn Limit | 10 | Sets the maximum number of creatures the spawner will produce. |
| Wave Timer | 10 Seconds | After the first wave of creatures spawns, the second wave spawns 10 seconds later. |
| Spawner Visibility | False | It's not necessary to see the spawner. |
| Enabled At Game Start | False | The device should not be enabled at the start of the game. |

The additional spawners spawn increasingly more challenging hordes. Spawners with different creature types are combined in specific areas on the island to make things more challenging.

| Spawner Number | Creature Type | Number of Creatures |
| --- | --- | --- |
| 2 | Red Fiend | 6-8 |
| 3 | Brute | 6 |
| 7 | Ranged | 8 |

#### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| Creature Spawner | Enabled | Trigger | On Triggered | When the player trips the trigger, the Creature Spawner is enabled. |
|  |  |  |  |  |
| Creature Spawner | Disable | Nightmare Timed Objective | On Completed | When the timer completes, the spawner is disabled and stops spawning creatures. |
|  |  |  |  |  |
| Creature Spawner | Eliminate Creatures | Elimination Tracker | On Cleared | When the Elimination Tracker clears the Target Value, it eliminates all spawned creatures the player hasn't eliminated. |
|  |  |  |  |  |

Additional creature spawners are enabled when players trip additional Trigger devices. All creature spawners use the same **Disable** and **Eliminate Creatures** event binding as shown above.

### Guard Spawner

A Guard AI is used to create a boss fight.

[![](https://dev.epicgames.com/community/api/documentation/image/5f90fe49-bcc2-41ef-b658-2a2d203a92cf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f90fe49-bcc2-41ef-b658-2a2d203a92cf?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| Spawn Count | 2 | The Guard Spawner will spawn two guards. |
| Spawn Through Walls | False | Guards should only spawn within the line of sight of the spawner. |
| Item List | 1 Array Element | Opens a weapon slot. |
| Item Index | Holo Twister Assault Rifle | A powerful weapon to create a challenge at the end of the game. |
| Item Quantity | 1 | The guard spawns with this one weapon in its inventory. |
| Allow infinite Spawns | False | The guard should not infinitely spawn. |
| Character Cosmetic | Commando Freak | The custom Fortnite skin aligns with the look and feel of the island. |
| Guard Team Option | Team Wildlife & Creatures | The guard will protect the creatures the player tries to eliminate. |
| Spawn Timer | 60 | The second guard will spawn 60 seconds after the first guard spawns. |
| Spawn Radius | 1.0 meter | Guards will spawn within 1 meter from the spawner plate. |
| Starting Health | 500 | Creates a challenge for the player. |
| Max Health | 500 | Creates a challenge for the player. |
| Starting Shield | 500 | Creates a challenge for the player. |
| Max Shield | 500 | Creates a challenge for the player. |
| Show Health Bar | True | The player sees the guard's health bar in the HUD. |
| Spawn on Patrol Path Group | 1 | The guard spawns on the AI Patrol Path. |
| Visibility Range | 2.0 m | The guard can spot the player within 2 meters of its position. |
| Drop Inventory on Elimination | False | The guard and its weapon disappear when eliminated. |
| Accuracy | HIGH | Creates a challenge for the player. |

#### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| Guard Spawner | Disable | Guard Timed Objective | On Completed | When the timer completes, the spawned guard disables and disappears. |
|  |  |  |  |  |
| Guard Spawner | Spawn | Player Spawn Pad | On Player Spawned | When the player spawns onto the island, so does the guard. |
|  |  |  |  |  |

### AI Patrol Path Node

Create a path for the Guard AI to traverse while it waits for the appearance of the player.

[![](https://dev.epicgames.com/community/api/documentation/image/b6dd816b-472d-47aa-88e2-74983bdc88fd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6dd816b-472d-47aa-88e2-74983bdc88fd?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| Patrolling Mode | Looping | The guard walks the patrol path on a loop. |

## Environmental Dangers

Platformer designers use environmental dangers to teach players where they can and can't travel. On this island, environmental challenges are placed in certain areas for players to discover the traps then deduce areas of safe travel.

[![](https://dev.epicgames.com/community/api/documentation/image/a35bd1f3-1910-4f2a-96ed-07a531321de9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a35bd1f3-1910-4f2a-96ed-07a531321de9?resizing_type=fit)

On the example island, water is a hazard players must avoid. Moving prop rocks provide a way for players to travel over the water safely.

You can change the environmental danger to fire, ice, or any other element that you want to use as a challenge.

### Damage Volume

Use as many Damage Volume devices as you need for your own water trap. Size the Damage Volume to the area you want to cover using the Zone Width, Zone Depth, and Zone Height options.

| Option | Value | Explanation |
| --- | --- | --- |
| Damage | 25 | Players lose 25 health points every 2 seconds of exposure to the Damage Volume. |
| Affects Creatures | False | Creatures are not affected by the Damage Volume. |
| Affects Guards | False | Guards are not affected by the Damage Volume. |

### Prop Mover

Prop Mover devices are used to create safe travel for players by moving rocks over the water. Make sure the Prop Mover's blue arrow points in the direction you want the prop to move.

Distances props move are measured in meters.

[![](https://dev.epicgames.com/community/api/documentation/image/4c751507-b197-4530-8c4f-843ce9e0594f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c751507-b197-4530-8c4f-843ce9e0594f?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| Distance | 10.0 | The rock moves 10 meters. |
| Speed | 2.5 | A gentle speed that provides players the opportunity to look around while standing on the rock. |
| Allow Reverse Past Start | True | Allows the rock to travel backward beyond its original position. |
| On AI Collision Behavior | Continue | If a creature runs into the prop, the rock continues on its path. |
| AI Damage on Collision | 0.0 | Creatures don't take damage if they run into the moving rock. |
| On Player Collision Behavior | Continue | Provides a way for the player to ride on the rock prop without causing the prop to stop moving. |
| Player Damage on Collision | 0.0 | Players don't take damage if they run into the moving rock. |
| On Prop Collision Behavior | Continue | If two prop rocks collide, the rock will continue to move. |
| Prop Damage on Collision | 0.0 | Colliding props won't take damage. |
| Path Complete Action | Ping Pong | The rock moves back toward its original position once reaching its destination. |
