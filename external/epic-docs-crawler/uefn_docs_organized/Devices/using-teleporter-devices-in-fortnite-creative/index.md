# Teleporter Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:48:09.703599

---

This is a customizable rift that moves players instantly between locations. The Teleporter device can be used to move players around your island, or create multi-island experiences with teleporters that take players from one island to another.

Teleporter devices can be set to visible, invisible, and silent. A silent, invisible teleporter can make gameplay exciting by transporting players suddenly from one place to another.

You can even group teleporters together to move players to areas on your island in the order you intend.

For help on how to find the **Teleporter** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

The default state of the Teleporter is set up to immediately enable creators to set up a two-teleporter system. Placing two teleporters and changing no settings will automatically set up the ability to walk through one teleporter and end up at the other.

The default values are **bold**.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Teleporter Group** | None, **Group A**, Pick a Group | Sets the teleporter group that this device belongs to. |
| **Teleporter Target Group** | None, **Group A**, Pick a Group | Determines the teleporter group that this device will send players to. |
| **Teleporter Rift Visible** | **Yes**, No | Determines whether the teleporter rift is visible during the game. |
| **Play Visual Effects** | **Yes**, No | Determines whether the teleporter's visual effects should be displayed. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **All**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. Pre-Game inclused all phases prior to the Game starting (the waiting for players lobby on Featured Islands and the Game Start Countdown). |
| **Selected Team** | **All**, Pick a Team | Determines which team can use this device. |
| **Invert Team Selection** | On, **Off** | If set, the teleporter can be used by all but the selected team. |
| **Selected Class** | **None**, Any, No Class, Pick a class | Determines which class, if any, is used in the **Affects Class** option. If this is set to **None**, all classes are used. If you select the **Any** value, any assigned class is used, regardless of what it is. If you select **No Class**, only players without an assigned class are affected. |
| **Invert Class Selection** | **No**, Yes | If set, the teleporter can be used by all but the selected class. |
| **Change Teleporter Target** | **Never**, On Entry, *On Timer* | Determines how often the teleporter will select a new random destination from its target group.  When this option is set to **On Timer**, the option Change Teleporter Target Interval becomes available. |
| **Change Teleporter Target Interval** | 5 seconds, Select an amount of time | Determines how often the teleporter will select  a new random destination from its target group. |
| **Link to Target** | **No**, Yes | By default, the teleporter works by linking the instigating teleporter to another teleporter in the  Teleporter  Group.  If this is set to **Yes**, this teleporter's random target will be linked to this teleporter until reset. A player will be able to return to the target teleporter and use it to reach this teleporter.  All teleporters that are potential random targets must have this option set to **Yes** in order for a link to be created. |
| **Play Sound Effects** | **Yes**, No | Determines whether the teleporter's audio effects should be played. |
| **Conserve Momentum** | **Yes**, No | Determines whether the momentum of an object entering the teleporter should be preserved when it emerges from its destination. |
| **Face Player in Teleporter Direction** | **No**, Relative, Yes | Determines whether the orientation of the player should be changed to that of the destination teleporter. With the **Relative** option, the player will emerge at the same angle to the destination teleporter that they were to the sending teleporter. |
| **Effect Radius** | **Off**, Pick a radius distance | When the teleporter is triggered, all players within the selected radius will be teleported. |
| **Maintain Relative Position** | **Yes**, No | When set to **Yes**, the teleported player will be facing the same direction at the destination as they were facing in the original teleporter. |
| **Skydive After Teleport** | Yes, **No** | Determines whether players should skydive after being teleported. |
| **Maintain Momentum During Teleport to Event** | **World**, Relative, Off | Determines if the player being teleported to this teleporter through an event should carry their momentum.  **Relative** means the momentum is carried in the direction the teleporter is facing.  **World** means the player will continue in the direction they were before being teleported.. |

### Physics-Enabled Options

The following options become available when [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) are enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Allow Physics Props** | On, **Off** | Determines whether the device teleports physics props. |
| **Conserve**Physics Prop Momentum | On, Off | Determines whether the physics props maintain their direction and speed after exiting teleport. |
| **Physics prop Momentum Conservation** | **World**, Relative, Off | Determines the behavior of a prop exiting a teleporter when Conserve Physics Prop Momentum  is True.  **World** conserves momentum, direction and rotation.  **Teleporter Facing**: direction is determined by the exit teleporter orientation.  **Relative** means the momentum is carried in the direction the prop enters the origin teleporter, maintaining it relative to the exit teleporter orientation. |

## Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/function) listens for an event on a device, and then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Teleport When Receiving From** | Teleports the instigating player to this destination when when an event occurs. |
| **Activate When Receiving From** | Activates the device when an event occurs. |
| **Activate Link to Target When Receiving From** | When an event occurs, the **Link to Target** option is set to **Yes**. |
| **Deactivate Link to Target When Receiving From** | When an event occurs, the **Link to Target** option is set to **No**. |
| **Reset Link to Target When Receiving From** | When an event occurs, it resets the linked target so it can send the player to another random target. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite-creative/event) tells another device when to perform a function.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Enter Send Event To** | When a player enters the teleporter, an event is sent to the selected device. |
| **On** **Teleported** **Send Event To** | When a player emerges from the teleporter, an event is sent to the selected device. |

## Gameplay Examples that Use Teleporters

- [Color Switch Challenge](https://dev.epicgames.com/documentation/en-us/fortnite/color-switch-challenge-gameplay-example-in-fortnite-creative)
- [Loadout Lobby](https://dev.epicgames.com/documentation/en-us/fortnite/loadout-lobby-gameplay-example-in-fortnite-creative)
- [Tug of War](https://dev.epicgames.com/documentation/en-us/fortnite/tug-of-war-in-fortnite-creative)

## Design Examples

Here are some examples of how you can use the Teleporter device:

- [Moving All Players](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative)
- [Fish in a Barrel](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative)
- [Class Selector](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative)

### Moving All Players

A common use of the Teleporter is to move all players to a new area when changing phases of a game. For example, you may want to move players from a parkour phase to an elimination phase in different areas of the map.

**Devices used**:

- 4 x **Teleporter**
- 4 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 4 x [**Player Reference**](using-player-reference-devices-in-fortnite-creative)
- 1 x [Timed Objective](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)

1. Place a **Player Reference** in an out-of-the-way location. Keep the default settings.
2. Place a **Player Spawner** in the starting area. Keep the default settings. Set the direct event bindings of the Player Spawner to the following:

   [![Player Spawner](https://dev.epicgames.com/community/api/documentation/image/92821378-f4c0-4400-b9a4-fdc1a621bca6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/92821378-f4c0-4400-b9a4-fdc1a621bca6?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Player Spawned Send Event To | PlayerReference | Register Player | When the player spawns, they will be registered to the Player Reference, allowing them to be teleported easily later on. |
3. In another area, place a **Teleporter** and customize it to the following settings:

   [![Teleporter](https://dev.epicgames.com/community/api/documentation/image/355eacfa-7ebd-4e4d-99a0-b9abb7b1eb1b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/355eacfa-7ebd-4e4d-99a0-b9abb7b1eb1b?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Teleporter Group | None | The Teleporter will not be accessible from any other Teleporters. |
   | Teleporter Target Group | None | The Teleporter will not be able to send players anywhere else. |
   | Teleporter Rift Visible | No | The Teleporter will be invisible during gameplay. |
   | Play Visual Effects | No | The Teleporter will not play any effects when a player teleports to it. |
   | Play Sound Effects | No | The Teleporter will not play any sounds when a player teleports to it. |
   | Conserve Momentum | No | The player loses all inertia and will drop straight down upon teleporting. |
4. Set the direct event bindings of the Player Reference to the following:

   [![Player Reference](https://dev.epicgames.com/community/api/documentation/image/6d94d473-fab1-4094-b139-6e4197add55b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d94d473-fab1-4094-b139-6e4197add55b?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Activated Send Event To | Teleporter | Teleport | When the Player Reference is activated, it will teleport the referenced instigator to the Teleporter. |
5. Select all three devices (Player Spawner, Player Reference, and Teleporter). Copy and paste them three additional times.

   Make sure to select all three devices at once to ensure that all direct event bindings will be correct in the copies.
6. Place a **Timed Objective** in an out-of-the-way location and customize it to the following settings:

   [![Timed Objective Settings](https://dev.epicgames.com/community/api/documentation/image/6cb90021-8843-4ba5-b706-61088224b3dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6cb90021-8843-4ba5-b706-61088224b3dc?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Start When Round Starts | Yes | The Timed Objective will begin counting down when the round starts. |
   | Timer Label Text | Players teleported in... | The players' HUDs will show this message during the countdown. |
   | Urgency Mode | Disabled | The Timed Objective will not have additional effects when the countdown is about to end. |
7. Set the direct event bindings of the Timed Objective to the following:

   [![Timed Objective Events](https://dev.epicgames.com/community/api/documentation/image/5ff750e8-6f49-462d-b9a0-b09d12b38bf8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5ff750e8-6f49-462d-b9a0-b09d12b38bf8?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Completed Send Event To | PlayerReference, PlayerReference2, PlayerReference3, PlayerReference4 | Activate | When the Timed Objective completes its countdown, it will activate all of the Player References, causing all players to teleport. |

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **PlayerReference1-4** | Register Player | **PlayerSpawner1-4** | On Player Spawned Send Event To | When the player spawns, they will be registered to the Player Reference, allowing them to be teleported easily later on. |
| **Teleporter1-4** | Teleport | **PlayerReference1-4** | On Activated Send Event To | When the Player Reference is activated, it will teleport the referenced instigator to the Teleporter. |
| **PlayerReference1-4** | Activate | **TimedObjective** | On Completed Send Event To | When the Timed Objective completes its countdown, it will activate all of the Player References, causing all players to teleport. |

You now have the base functionality for teleporting all players at once.

This technique is very useful in many game modes that feature multiple phases in different areas of the map. You can also use it to reset a game manually by moving all players back to the starting area.

If you want all players to teleport to the same place, you can move all of the Teleporters into the same spot using the **grid snap** tool. If you have to edit them manually, move them apart, make edits to the individual Teleporters, then move them back to the earlier position.

### Fish in a Barrel

You can use a Teleporter to create a Fish in a Barrel minigame.

**Devices used**:

- 1 x **Teleporter**
- 4 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x [Random Number Generator](https://dev.epicgames.com/documentation/en-us/fortnite/using-random-number-generator-devices-in-fortnite-creative)
- 4 x [**Player Reference**](using-player-reference-devices-in-fortnite-creative)
- 1 x [Timed Objective](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)

1. Build a large "barrel" with a rim that players can walk around in.
2. Place four **Player Spawners** at the bottom of the barrel and customize them to the following settings:

   [![Player Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/130ed936-d40a-4098-af5b-904f6cda4dde?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/130ed936-d40a-4098-af5b-904f6cda4dde?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Visible in Game | Off | The Player Spawner will be invisible during gameplay. |
3. Place a **Teleporter** on the rim of the barrel and customize it to the following settings:

   [![Teleporter](https://dev.epicgames.com/community/api/documentation/image/2fa6772f-081c-4605-847d-e61539590028?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2fa6772f-081c-4605-847d-e61539590028?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Teleporter Group | None | The Teleporter will not be accessible from any other Teleporters. |
   | Teleporter Target Group | None | The Teleporter will not be able to send players anywhere else. |
   | Conserve Momentum | No | The player loses all inertia and will drop straight down upon teleporting. |
   | Face Player In Teleporter Direction | Yes | The player will face in the same direction as this Teleporter upon arriving. |
4. Place a **Random Number Generator** in an out-of-the-way location and customize it to the following settings:

   [![Random Number Generator](https://dev.epicgames.com/community/api/documentation/image/f5d0b470-f221-4531-b09b-93df472dbf31?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f5d0b470-f221-4531-b09b-93df472dbf31?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Value Limit 2 | 4 | The Random Number Generator will have an upper limit of 4. |
   | Roll Time | Instant | The Random Number Generator will choose a number instantly when activated. |
   | Zone | Forward | The Random Number Generator's volume will extend out in front of the device. |
   | Length | 4 | The Random Number Generator's volume will be 4 tiles long. |
5. Place a **Timed Objective** in an out-of-the-way location and customize it to the following settings:

   [![Timed Objective Settings](https://dev.epicgames.com/community/api/documentation/image/6bf0c60f-07b5-4b1e-8d20-40e8f84aab33?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6bf0c60f-07b5-4b1e-8d20-40e8f84aab33?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Start When Round Starts | Yes | The Timed Objective will begin counting down when the round starts. |
   | Time | 5 Seconds | The countdown will start at 5 seconds. |
   | Timer Label Text | The attacker will be chosen in... | Everyone’s HUD will show this message during the countdown. |
   | Urgency Mode | Disabled | The Timed Objective will not have additional effects when the countdown is about to end. |
6. Set the direct event bindings of the Timed Objective to the following:

   [![Timed Objective Events](https://dev.epicgames.com/community/api/documentation/image/244019fe-0c06-4256-a9ee-d718fb3cc22e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/244019fe-0c06-4256-a9ee-d718fb3cc22e?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Completed Send Event To | RandomNumberGenerator | Activate | When the Timed Objective completes its countdown, it will activate the Random Number Generator, which will select a random number between 1 and 4. |
7. Place an **Item Granter** in an out-of-the-way location. Drop a Legendary Red-Eye Assault Rifle while standing next to the Item Granter to register the weapon. Customize it to the following settings:

   [![Item Granter](https://dev.epicgames.com/community/api/documentation/image/82082e99-8f6f-435d-949f-164fba7f7d21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82082e99-8f6f-435d-949f-164fba7f7d21?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Equip Granted Item | First Item | When the item is granted, it will be automatically equipped. |
8. Place a **Player Reference** in the first sequencer area of the Random Number Generator. Keep the default settings. Set its direct event bindings to the following:

   [![Player Reference Events](https://dev.epicgames.com/community/api/documentation/image/3d480211-7f2e-4224-90d3-0349b34c8218?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3d480211-7f2e-4224-90d3-0349b34c8218?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Activated Send Event To | ItemGranter | Grant Item | When the Player Reference is activated, it will grant the registered player the weapon registered to the Item Granter. |
   | On Activated Send Event To | Teleporter | Teleport | When the Player Reference is activated, it will teleport the registered player to the Teleporter on the barrel's rim. |
9. Copy and paste this Player Reference three times and place one in each of the remaining sequencer areas of the Random Number Generator as shown below.

   [![Player Reference Placement](https://dev.epicgames.com/community/api/documentation/image/ef65d0d3-cd0e-4f02-b695-b83416181792?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ef65d0d3-cd0e-4f02-b695-b83416181792?resizing_type=fit)
10. Set the direct event bindings of the Player Spawners to the following, making sure to connect each Player Spawner to the corresponding Player Reference (PlayerSpawner to PlayerReference, PlayerSpawner2 to PlayerReference2, etc.)

    [![Player Spawner Events](https://dev.epicgames.com/community/api/documentation/image/5e5479e9-53a9-439b-9d9a-5eedbd3b69ed?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5e5479e9-53a9-439b-9d9a-5eedbd3b69ed?resizing_type=fit)

    | Function | Device | Event | Description |
    | --- | --- | --- | --- |
    | On Player Spawned Send Event To | PlayerReference | Register Player | When the player spawns, they will be registered to the Player Reference, allowing them to be teleported easily later on. |

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **RandomNumberGenerator** | Activate | **TimedObjective** | On Completed Send Event To | When the Timed Objective completes its countdown, it will activate the Random Number Generator, which will select a random number between 1 and 4. |
| **ItemGranter** | Grant Item | **PlayerReference1-4** | On Activated Send Event To | When the Player Reference is activated, it will grant the registered player the weapon registered to the Item Granter. |
| **Teleporter** | Teleport | **PlayerReference1-4** | On Activated Send Event To | When the Player Reference is activated, it will teleport the registered player to the Teleporter on the barrel's rim. |
| **PlayerReference1-4** | Register Player | **PlayerSpawner1-4** | On Player Spawned Send Event To | When the player spawns, they will be registered to the Player Reference, allowing them to be teleported easily later on. |

You now have the base functionality for creating a Fish in a Barrel minigame using the Teleporter.

Random Number Generators can be used with Teleporters to create highly varied and dynamic gameplay scenarios. Consider how this example could be extended into a full game mode. The player on the rim could randomly change every 10 seconds, or the fish could earn a way to fight back.

### Class Selector

You can use Teleporters to create an efficient class selection system.

**Devices used**:

- 6 x **Teleporter**
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 3 x [**Class Designer**](using-class-designer-devices-in-fortnite-creative)
- 3 x [**Class Selector**](using-class-selector-devices-in-fortnite-creative)

1. Build a basic map with a spawn area, a sniper tower, a front line, and a turret area with a **Mounted Turret**.

   [![Map](https://dev.epicgames.com/community/api/documentation/image/fc70b297-b3f8-4ed0-8311-e848296b120f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc70b297-b3f8-4ed0-8311-e848296b120f?resizing_type=fit)
2. Place a **Player Spawner** and customize it to the following settings:

   [![Player Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/7ab5cbf3-4f53-4214-8495-430ce45ff8bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7ab5cbf3-4f53-4214-8495-430ce45ff8bc?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Visible in Game | Off | The Player Spawner will be invisible during gameplay. |
3. Place a **Class Designer** in an out-of-the-way location. Drop a Legendary Combat Pistol while standing next to the Class Designer to register the weapon. Customize it to the following settings:

   [![Class Designer](https://dev.epicgames.com/community/api/documentation/image/be1a9752-6427-4e26-88e7-5f00480f00f8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/be1a9752-6427-4e26-88e7-5f00480f00f8?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Class Name | Turret | The first class will be the "Turret" class. |
   | Class Identifier | 1 | The Turret class uses Class Identifier 1. |
   | Equip Granted Item | First Item | When the loadout for the class is granted, the first item will be automatically equipped. |
4. Copy and paste this Class Designer two times. Set one of the new Class Designers to Class Name "Front Line" and Class Identifier 2, and set the other to Class Name "Sharpshooter" and Class Identifier 3. Register a Legendary Red-Eye Assault Rifle for the Front Line class and a Mythic Heavy Sniper Rifle for the Sharpshooter class.
5. Place a **Class Selector** and customize it to the following settings:

   [![Class Selector](https://dev.epicgames.com/community/api/documentation/image/0eeb2b69-faa9-47a0-a787-7fe4e8919a51?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0eeb2b69-faa9-47a0-a787-7fe4e8919a51?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Class to Switch to | 1 | This class selector will switch the player to class 1 (Turret) when activated. |
   | Time to Switch | Instant | The player class will be changed instantly when the Class Selector is activated. |
   | Clear Items on Switch | All Items | The player loses all items when changing classes in case they already had a weapon from another class. |
   | Volume Visible in Game | Off | The glowing area above the Class Selector will be invisible during gameplay. |
   | Visible in Game | Off | The base of the Class Selector will be invisible during gameplay. |
6. Copy and paste this Class Selector two times, and set the new Class Selectors to a **Class to Switch to** of 2 and 3. Make sure all three Class Selectors are clearly named based on the class they correspond to.
7. Place a **Teleporter** in the spawn area and customize it to the following settings:

   [![Entry Teleporter Settings](https://dev.epicgames.com/community/api/documentation/image/e369f2d1-045a-4de2-b7c0-73c6ef9b659e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e369f2d1-045a-4de2-b7c0-73c6ef9b659e?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Teleporter Group | None | The Teleporter will not be accessible from any other Teleporters. |
   | Teleporter Target Group | Group A | The Teleporter will teleport players to a Teleporter in Group A. |
   | Conserve Momentum | No | The player loses all inertia and will drop straight down upon teleporting. |
8. Set the direct event bindings of the Teleporter to the following:

   [![Entry Teleporter Event](https://dev.epicgames.com/community/api/documentation/image/494e9d9b-316d-4bc4-8fcc-ef270df002ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/494e9d9b-316d-4bc4-8fcc-ef270df002ae?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Enter Send Event To | TurretClassSelector | Change Player to Class | When the player enters this Teleporter, they will be changed to the Turret class. |
9. Place a **Teleporter** near the Mounted Turret in the turret area and customize it to the following settings:

   [![Exit Teleporter Settings](https://dev.epicgames.com/community/api/documentation/image/8bca583b-9744-4b86-805e-7be4a56696f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8bca583b-9744-4b86-805e-7be4a56696f3?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Teleporter Group | Group A | The Teleporter will be accessible from Teleporters with a Target Group of Group A. |
   | Teleporter Target Group | None | The Teleporter will not be able to send players anywhere else. |
   | Teleporter Rift Visible | No | The Teleporter will be invisible during gameplay. |
   | Face Player In Teleporter Direction | Yes | The player will face in the same direction as this Teleporter upon arriving. |
10. Repeat steps 7-9 for the Front Line and Sharpshooter classes. For the Front Line class, teleport the player to the front line. For the Sharpshooter class, teleport the player to the top of the sniper tower.

    For additional clarity during gameplay, use billboards to label the different teleporters in the spawn area.

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **TurretClassSelector, FrontLineClassSelector, SharpshooterClassSelector** | Change Player to Class | **TurretTeleporter, FrontLineTeleporter, SharpshooterTeleporter** | On Enter Send Event To | When the player enters this Teleporter, they will be changed to the corresponding class. |

You now have the base functionality for an advanced class selection system.

This example is useful in game modes where members of different classes begin in different areas and players are allowed to choose their own class.

To create a maximum number of players in a specific class, use [Player Counters](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-counter-devices-in-fortnite-creative) to keep track of how many players are in each class and then disable the Teleporters when the maximum has been reached.

Teleporters can also be limited to only members of certain classes. Consider having different Teleporters for different classes around a play area to create interesting gameplay scenarios and more complex strategies.
