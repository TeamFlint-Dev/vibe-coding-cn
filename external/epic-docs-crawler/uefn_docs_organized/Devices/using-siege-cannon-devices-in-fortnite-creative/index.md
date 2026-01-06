# Siege Cannon Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-siege-cannon-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:38:13.007735

---

The **Siege Cannon** is a stationary heavy weapon that can deal massive area damage to players, vehicles, and the environment. You can also use it to launch players a great distance away, giving players another way to [traverse](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#traverse) an area and gain a tactical advantage. It can also be used for a fast escape!

For help on how to find the **Siege Cannon** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

This device has some basic functionality, like whether the spawner is visible during the game. Additionally, there are some advanced options, like how much [health](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#health) the vehicle has and which team can access the vehicle.

You can configure this device with the following options.

Default values are **bold**.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Visible During Game** | **On**, Off | Determines whether the spawner is visible during the game. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **All**, None, Pre-Game Only, Gameplay Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) during which the device will be enabled. Pre-Game includes all phases prior to the Game starting (the waiting for players lobby on Featured Islands and the Game Start Countdown). |
| **Respawn Time** | Never, **Instant**, Pick an amount of time | When the vehicle is destroyed, this determines the amount of time before another one spawns. |
| **Respawn Vehicle When Enabled** | **Yes**, No, Only When Needed | Determines whether the device respawns a vehicle when it is enabled.   - **Yes**: a vehicle spawns when the device is enabled. - **Only When Needed**: The device only spawns if the original was destroyed. - **No**: The device doesn't spawn a vehicle when it is enabled. |
| **Destroy Vehicle When Disabled** | **Yes**, No | Determines whether an existing vehicle is destroyed when the device is enabled.   - **Yes**: An existing vehicle is destroyed when the device is disabled. - **No**: A spawned vehicle remains when the device is disabled. |
| **Owning Team** | **Any**, Pick a team | Determines which team owns the vehicle spawner. |
| **Selected Class** | **None**, Any, No Class, Pick a class | Determines which classes can use the vehicle.   - **None**: Any player, even those with no assigned class, can use it. - **Any**: Any player who has an assigned class can use it. - **No Class**: Only players with no assigned class can use it. |
| **Vehicle Health** | **400 (Default)**, Indestructible, Pick an amount of health | Determines how much damage the vehicle can take before it is destroyed. |
| **Water Destruction Delay** | Never, Instant, **5 Seconds**, Pick an amount of time | When the vehicle drives through deep water, this determines how long the vehicle lasts before being destroyed. |

## Channels

When one device needs to "talk" to another device, it does so by [transmitting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a [signal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) on a specific [channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). The receiving device needs to be set up to [receive](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#receive) the signal on the same channel.

A channel is identified by a number, and channel numbers are customized for a device under the option that uses the channel. Most devices will also pass the identity of the player who [triggered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the device with the signal.

This device has receivers that perform a variety of functions when receiving a signal over a channel. Also, this device can transmit signals when certain conditions are met.

### Receivers

Receivers listen for a channel and perform an action when they hear any device (including themselves) send a signal on that channel.

| Option | Value | Description |
| --- | --- | --- |
| **Assigns Driver When Receiving From** | **No Channel**, Pick or enter a channel number | Designates the player that instigated the instigated the message as the spawned vehicle's driver. |
| **Respawn Vehicle When Receiving From** | **No Channel**, Pick or enter a channel number | Spawns the vehicle while destorying the existing vehicle if it exists. |
| **Destroy Vehicle When Receiving From** | **No Channel**, Pick or enter a channel number | Destroys the spawned vehicle if it exists. |

### Transmitters

Transmitters send a signal on the selected channel when triggered.

| Option | Value | Description |
| --- | --- | --- |
| **When Player Enters Vehicle Transmit On** | **No Channel**, Pick or enter a channel number | Transmits a signal on the selected channel when a player enters the spawned vehicle. |
| **When Player Exits Vehicle Transmit On** | **No Channel**, Pick or enter a channel number | Transmits a signal on the selected channel when a player exits the spawned vehicle. |
| **When Vehicle Spawns Transmit On** | **No Channel**, Pick or enter a channel number | Transmits a signal when a vehicle is spawned or respawned. |
| **When Vehicle Is Destroyed Transmit On** | **No Channel**, Pick or enter a channel number | Transmits a signal when a vehicle is destroyed. |

## Design Examples

Here are some examples of how you can use the Siege Cannon device.

- [Target Practice](https://dev.epicgames.com/documentation/en-us/fortnite/using-siege-cannon-devices-in-fortnite-creative)
- [Breaking Buildings](https://dev.epicgames.com/documentation/en-us/fortnite/using-siege-cannon-devices-in-fortnite-creative)
- [Elimination Streak Upgrades](https://dev.epicgames.com/documentation/en-us/fortnite/using-siege-cannon-devices-in-fortnite-creative)

### Target Practice

You can make an aerial target practice island using the Siege Cannon.

**Devices Used**:

- 1 x **Siege Cannon**
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x [Score Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative)
- 3 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)
- 3 x [Prop Manipulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-manipulator-devices-in-fortnite-creative)

1. Place a **Player Spawner**. Keep the default settings.
2. In front of the Player Spawner, place a **Siege Cannon**. Keep the default settings.
3. Place a **Score Manager** and customize it to the following settings:

   [![Score Manager](https://dev.epicgames.com/community/api/documentation/image/40f7b968-656d-4bd9-a355-6fba18fbc9ba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40f7b968-656d-4bd9-a355-6fba18fbc9ba?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Score Value | 10 | 10 points will be awarded when the device is activated. |
   | Display Score Update on HUD | On | When the score is updated, a notification will appear on the player's HUD. |
4. Place a balloon from the **Balloon Prop Gallery** and resize it to be as small as possible.
5. Attach a **Prop Manipulator** to the balloon and give it a recognizable name. Keep the default settings.
6. Place a **Trigger** directly in front of the balloon. Rotate and resize it to match the image below, then customize it to the following settings:

   [![Trigger Placement](https://dev.epicgames.com/community/api/documentation/image/a3cb1d71-0844-4848-951c-dc181daabe28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a3cb1d71-0844-4848-951c-dc181daabe28?resizing_type=fit)

   [![Trigger Settings](https://dev.epicgames.com/community/api/documentation/image/052f9656-98f8-4028-93f7-71a176e3152a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/052f9656-98f8-4028-93f7-71a176e3152a?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Triggered by Player | Off | The Trigger should not be activated when a player walks over it. |
   | Triggered by Damage | On | The Trigger will be activated when it is hit by a projectile from the Siege Cannon device. |
   | Times Can Trigger | 1 | The Trigger can only be activated once. |
   | Visible in Game | No | The Trigger will be invisible so it feels like the player is shooting the balloon behind it. |
   | Receive Damage While Invisible | Take Damage | This ensures that the Trigger will still be activated from damage even though it is invisible. |
7. Set the direct event bindings of the Trigger to the following:

   [![Trigger Events](https://dev.epicgames.com/community/api/documentation/image/8f3a79b5-6e88-45c8-9994-6b390023592c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f3a79b5-6e88-45c8-9994-6b390023592c?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Triggered Send Event To | ScoreManager10 | Activate | The player will be awarded 10 points for hitting a balloon. |
   | On Triggered Send Event To | BalloonPropManipulator | Hide Props | The balloon will be hidden when it is hit. |
8. Copy the entire balloon system (balloon, Prop Manipulator, and Trigger) and paste it two times in different locations in front of the Siege Cannon.

   After selecting all of the individual elements of the balloon system, press a number key (1-8) to store the entire system in the toolbar, making it easier to place again later.
9. Finally, modify the following Island Settings:

   | Modified Setting | Option | Explanation |
   | --- | --- | --- |
   | HUD Info Type | Score | The player's score will be shown in the HUD. |

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **ScoreManager10** | Disable | **BalloonTrigger1-3** | On Triggered Send Event To | The player will be awarded 10 points for hitting a balloon. |
| **BalloonPropManipulator1-3** | Hide Props | **BalloonTrigger1-3** | On Triggered Send Event To | The balloon will be hidden when it is hit. |

You now have the base functionality for an aerial target practice island.

For additional difficulty, consider adding Prop Movers to the balloon and associated devices to make it move around the play area. Also, add more balloons that are further away and move more quickly, and give the player more points for hitting them.

Because the Siege Cannon has a very high range, it can be difficult for players to determine how to aim their shots. Consider using buildings and other structures around (and even in between) the balloons to give a sense of distance for the player.

The functionality shown here can be used to trigger a great deal of other effects as well. The player could shoot a target to trigger a door unlock, another platform moving, a new mechanic to become available, etc.

### Breaking Buildings

Make building entries much more dynamic with the Siege Cannon!

**Devices used**:

- 1 x **Siege Cannon**
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)
- 1 x [Guard Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative)

1. Find a Prefab building that you like or create your own. Remove a wall piece from high up in the building and replace it with a player-built wall.

   [![Prefab Building](https://dev.epicgames.com/community/api/documentation/image/c0e19510-96c2-42db-a193-331204022d8b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c0e19510-96c2-42db-a193-331204022d8b?resizing_type=fit)
2. Inside the room adjacent to the replaced wall, place a **Guard Spawner**. Customize it to the following settings:

   [![Guard Spawner](https://dev.epicgames.com/community/api/documentation/image/e1b7e8c0-df7b-4612-a4c4-e1203c2e96ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e1b7e8c0-df7b-4612-a4c4-e1203c2e96ea?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Number of Guards | 2 | The Guard Spawner will spawn two guards. |
   | Total Spawn Limit | 2 | Once two guards are spawned, no more will spawn. |
   | Spawn Through Walls | Off | The guards must spawn within line of sight of the spawner, so they won't appear on the other side of walls. |
   | Spawn Radius | 2.5M | Guards will only spawn within this small radius, giving more control over their positions. |
   | Visibility Range | 100M | The guards will be able to detect the player from 100 meters away. |
   | Drop Inventory On Elimination | No | The player already has a gun, so the guards do not need to drop their guns when they are eliminated. |
3. Outside of the building, place a **Siege Cannon** with default settings. Ensure that when the player is fired, they can reach the player-built wall on the building.
4. Place an **Item Granter**. Give it a name you can recognize from a list. Drop an Epic Heavy Assault Rifle while standing next to the Item Granter to register the weapon. Customize it to the following settings:

   [![Item Granter](https://dev.epicgames.com/community/api/documentation/image/6c417f08-043a-4f20-b5d9-dfda10b187d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c417f08-043a-4f20-b5d9-dfda10b187d4?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Equip Granted Item | First Item | The weapon will be immediately equipped when granted. |
5. Place a **Player Spawner** behind the Siege Cannon. Set the direct event bindings of the Player Spawner to the following:

   [![Player Spawner](https://dev.epicgames.com/community/api/documentation/image/6a0266dc-bd7f-4aff-b868-bee404038735?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6a0266dc-bd7f-4aff-b868-bee404038735?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Player Spawned Send Event To | WeaponItemGranter | Grant Item | When the player spawns, they will be given the Heavy Assault Rifle. |
6. Finally, modify the following Island Settings:

   | Modified Setting | Option | Explanation |
   | --- | --- | --- |
   | Environment Damage | Player Built Only | The player will be able to break through the player built wall but not the rest of the building. |

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **WeaponItemGranter** | Grant Item | **PlayerSpawner** | On Player Spawned Send Event To | When the player spawns, they will be given the Heavy Assault Rifle. |

You now have the base functionality for creating a building entry sequence using the Siege Cannon.

This technique is great for creating dynamic and exciting starting sequences for infiltration game modes. The destructive and movement-based capabilities of the Siege Cannon are also very useful in various PvP modes that utilize player building. Consider using the Siege Cannon in games where players may be using resources to create barricades or entire structures; a dramatic explosion and quick ambush could be the exciting addition that your game needs!

### Elimination Streak Upgrade

You can add a Siege Cannon as an unlockable upgrade after completing an objective.

**Devices used**:

- 1 x **Siege Cannon**
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 2 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)
- 1 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)
- 1 x [Conditional Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative)
- 20 x [Shooting Range Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/shooting-range-gallery)

1. Place an **Item Granter**. Give it a name you can recognize from a list. Keep the default settings. Drop a Legendary Storm Scout Sniper Rifle while standing next to the Item Granter to assign the weapon. Customize it to the following settings:

   [![Item Granter](https://dev.epicgames.com/community/api/documentation/image/7bb3b460-070c-4524-a249-cab6a32a7455?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7bb3b460-070c-4524-a249-cab6a32a7455?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Equip Granted Item | First Item | The weapon will be immediately equipped when granted. |
2. Place a **Player Spawner** and set the direct event bindings of the Player Spawner to the following:

   [![Player Spawner](https://dev.epicgames.com/community/api/documentation/image/1cb01b1f-e7d9-4c0d-978f-71e5e2893dcc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1cb01b1f-e7d9-4c0d-978f-71e5e2893dcc?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Player Spawned Send Event To | WeaponItemGranter | Grant Item | When the player spawns, they will be given the Storm Scout Sniper Rifle. |
3. Place a **Siege Cannon** near the player's spawn location and customize it to the following settings:

   [![Trigger](https://dev.epicgames.com/community/api/documentation/image/e5ff027d-0415-4554-8922-50929c7e5caf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e5ff027d-0415-4554-8922-50929c7e5caf?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Enabled During Phase | None | The Siege Cannon will not be enabled when the game begins. |
4. Place a **Conditional Button** next to the Siege Cannon. Drop a **Gold coin** while standing next to the Conditional Button to assign it. Set its direct event bindings to the following:

   [![Conditional Button](https://dev.epicgames.com/community/api/documentation/image/15829d14-5549-4af8-b513-4d6a099f2020?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/15829d14-5549-4af8-b513-4d6a099f2020?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Activated Send Event To | SiegeCannon | Enable | When the player activates the Conditional Button with a Gold coin, the Siege Cannon will appear. |
5. Place another **Item Granter**. Give it a name you can recognize from a list. Drop a **Gold coin** while standing next to the Item Granter to register it. Customize it to the following settings:

   [![Trigger](https://dev.epicgames.com/community/api/documentation/image/a2a5cbdd-f3d3-4155-a0b9-12b1169780d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2a5cbdd-f3d3-4155-a0b9-12b1169780d5?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | On-Grant Action | Keep All | The Item Granter will not replace any other items in the player's inventory. |
   | Drop Items at Player Location | Yes | Instead of the Gold coin appearing in the player's inventory, it will spawn on the ground beside them. |
6. Place a **Trigger** to keep track of the number of Target Dummies that have been hit and customize it to the following settings:

   [![Trigger](https://dev.epicgames.com/community/api/documentation/image/b43f51cf-42f5-4f3b-a8f5-213666ba1e5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b43f51cf-42f5-4f3b-a8f5-213666ba1e5b?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Triggered by Player | Off | The Trigger should not be activated when a player walks over it. |
   | Times Can Trigger | 5 | The Trigger can only activate 5 times total to prevent repeated activations of the Gold coin granter. |
   | Transmit Every X Triggers | 5 | The Trigger will only transmit a signal after it is activated 5 times. |
   | Visible in Game | No | The Trigger should not be visible during gameplay. |
7. Set the direct event bindings of the Trigger to the following:

   [![Trigger Events](https://dev.epicgames.com/community/api/documentation/image/6e088c87-1dc8-4694-96ce-be95f11f3c7d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e088c87-1dc8-4694-96ce-be95f11f3c7d?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Triggered Send Event To | GoldItemGranter | Grant Item | After 5 triggers, the Item Granter will grant a Gold coin to the player. |
8. About 12-15 tiles away from the Player Spawner, create a large shooting range using Target Dummies from the **Shooting Range Gallery**. Customize the settings on the Target Dummies to create moving, hopping, and visually varied targets. Set the direct event bindings on all of the Target Dummies to the following:

   [![Target Dummy](https://dev.epicgames.com/community/api/documentation/image/4b59ca85-6b64-43e9-8c80-f68c5f84b193?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4b59ca85-6b64-43e9-8c80-f68c5f84b193?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Hit Send Event To | DummyHitTrigger | Trigger | Each time the player hits a Target Dummy, the Trigger will be activated. |

   Set the event settings on a few Target Dummies and then copy them to create the shooting range so you don't have to modify them on every Target Dummy individually.
9. Finally, modify the following Island Settings:

   | Modified Setting | Option | Explanation |
   | --- | --- | --- |
   | Infinite Ammo | On | Gives the player infinite ammo to use on the shooting range. |
   | HUD Info Type | Score | The player's score will be shown in the HUD. |

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **WeaponItemGranter** | Grant Item | **PlayerSpawner** | On Player Spawned Send Event To | When the player spawns, they will be given the Storm Scout Sniper Rifle. |
| **SiegeCannon** | Enable | **ConditionalButton** | On Activated Send Event To | When the player activates the Conditional Button with a Gold coin, the Siege Cannon will appear. |
| **GoldItemGranter** | Grant Item | **DummyHitTrigger** | On Triggered Send Event To | After 5 triggers, the Item Granter will grant a Gold coin to the player. |
| **DummyHitTrigger** | Trigger | **TargetDummy** | On Hit Send Event To | Each time the player hits a Target Dummy, the Trigger device will be activated. |

You now have the base functionality for an unlockable Siege Cannon upgrade.

For additional functionality, destroy the Siege Cannon after a specific amount of time to make the upgrade temporary. This can fit into many different elimination-based game modes, such as Free for Alls and Zone Capture games.

The movement functionality of the Siege Cannon also gives it an edge in maps that require strategic positioning, so consider movement carefully when deciding how and when to give players access to the Siege Cannon.

This example is built in a way that easily allows for additional upgrades to be added. Consider adding other devices or weapons that the player can unlock with the Gold coin they receive. Or, add other items that they will receive when completing other objectives, and create different rewards that they can unlock with different items.
