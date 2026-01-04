# 4. Set Up Spawn Rooms

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-4-set-up-spawn-rooms-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:16:40.474449

---

**Devices used:**

- 4 x [Lock](https://www.fortnite.com/en-US/creative/docs/using-lock-devices-in-fortnite-creative)
- 12 x [Trigger](https://www.fortnite.com/en-US/creative/docs/using-trigger-devices-in-fortnite-creative)
- 16 x [Class Selector](https://www.fortnite.com/en-US/creative/docs/using-class-selector-devices-in-fortnite-creative)
- 24 x [Player Spawner devices](https://www.fortnite.com/en-US/creative/docs/using-player-spawn-pad-devices-in-fortnite-creative)

[![Spawn Room](https://dev.epicgames.com/community/api/documentation/image/ddeb7e17-81c6-4546-890b-eb2837bfa803?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ddeb7e17-81c6-4546-890b-eb2837bfa803?resizing_type=fit)

There are four spawn rooms, two in each team's castle. This is where players spawn, respawn, and choose a class.

There are two spawn rooms for each team, to discourage spawn camping. Once you have built or chosen the spawn rooms for each team, there are three parts to setting up each spawn room:

- Creating the locked doors that only open for players on the assigned team
- Placing the Player Spawners
- Placing the Class Selector devices

## Set Up Locks for the Automatic Doors

Use one **Lock** and three **Trigger** devices for each spawn room door.

Place the Lock device next to the door to the spawn room.

When the Lock devices are placed, change “Visible During Game” to False for each one.

Next, set up the **Trigger** devices to work with the Lock, so the door will open and close when a player on the right team approaches the door. To make this work, you need three Trigger devices for each door (six total).

- **Trigger 1**: This opens the door when the player runs over it. Place this in front of the door inside the spawn room.
- **Trigger 2**: This is an exact copy of Trigger 1, and opens the door from the other side. Place this in front of the door outside of the spawn room.
- **Trigger 3**: This closes the door to the spawn room. Place this near the door it works with.

Here are the options you need to customize for all three Triggers for each team.

**Triggers 1 and 2 (inside and outside room, open door)**

| Option | Value | Explanation |
| --- | --- | --- |
| **Activating Team** | Team 1 or 2 | Team 1 is the Blue team and Team 2 is Red. Each team can only open the door to their team’s spawn room. This way, the enemy team can’t enter the spawn room. |
| **Triggered by Vehicles** | False | Vehicles are not part of this game, so this is turned off. |
| **Trigger SFX** | False | You can set a sound to play when the trigger is activated. It isn’t needed, so set this to False. |
| **Trigger VFX** | False | You can set a visual effect to play when the trigger is activated. It isn’t needed, so set this to False. |
| **Visible in Game** | False | Like the Lock, the triggers will all be invisible to players in the game. |

**Trigger 3 (close door)**

| Option | Value | Explanation |
| --- | --- | --- |
| **Activating Team** | Team 1 or 2 | Only the players on their respective teams can activate this trigger. |
| **Triggered by Players** | False | This will not be activated by players. Instead, it will be activated by a signal from another device. |
| **Triggered by Vehicles** | False | Vehicles are not part of this game, so this is turned off. |
| **Delay** | 1 second | The amount of time that passes between the time Trigger 3 receives a signal and the time Trigger 3 sends a signal. |
| **Visible in Game** | False | Like the Lock, the triggers will all be invisible to players in the game. |

Repeat these steps for the subsequent spawn room decorations.

### Direct Event Binding

Direct event binding allows devices to talk to one another directly by using **events** and **functions**. Learn more about it on the [Direct Event Binding](https://dev.epicgames.com/documentation/en-us/fortnite/direct-event-binding-in-unreal-editor-for-fortnite) page.

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Blue Lock**  [lock device](https://dev.epicgames.com/community/api/documentation/image/3fe53c6a-2fb7-4495-ba60-a95b90d75731?resizing_type=fit) | Open | **Blue Trigger #2**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/8460747f-8f99-41b0-a1da-77039ef9a7d1?resizing_type=fit) | When Triggered | When players on the blue team walk over these triggers, the lock device will open the door. |
| **Blue Lock**  [lock device](https://dev.epicgames.com/community/api/documentation/image/c1a8f693-63d5-4689-be7c-c9e6ae144da1?resizing_type=fit) | Close | **Blue Trigger #3**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/498fd24e-77f6-435f-beea-7e0a4ac98f85?resizing_type=fit) | When Triggered | When players on the blue team walk over these triggers, the lock device will close the door. |
| **Red Lock**  [lock device](https://dev.epicgames.com/community/api/documentation/image/73bae7e9-b1ac-4e2d-85fd-454481d85471?resizing_type=fit) | Open | **Red Trigger #2**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/eab09643-beab-44f7-bd24-93df3b41e16d?resizing_type=fit) | When Triggered | When players on the red team walk over these triggers, the lock device will open the door. |
| **Red Lock**  [lock device](https://dev.epicgames.com/community/api/documentation/image/defb65cd-2c31-4a0d-a637-644ea98ac254?resizing_type=fit) | Close | **Red Trigger #3**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/01b77630-d0d8-4d7f-8e56-ae07aaff6a8a?resizing_type=fit) | When Triggered | When players on the red team walk over these triggers, the lock device will close the door. |

## Place Player Spawners

Once the doors are set up, place the **Player Spawner**. You need six Player Spawners per room for each team. Customize the options for the first one as shown below, then copy and paste it five times, for a total of six pads. Place all the Player Spawners on one side of the spawn room, facing in the same direction.

| Option | Value | Explanation |
| --- | --- | --- |
| **Player Team** | Team Index: 1 or 2 | The Player Spawner will only work for each selected team (Blue: Team 1, Red: Team 2). |
| **Priority Group** | 1 | Primary means these spawners will be picked first if another group exists. |
| **Use as Island Start** | False | You will set up another area where players are placed when they enter the island, later in this tutorial. |
| **Visible in Game** | False | Like the locks and triggers, this is set to invisible so the players won’t see it during the game. |

## Place Class Selector Devices

[![Class selectors](https://dev.epicgames.com/community/api/documentation/image/04812579-0232-4a2f-8edb-83049a0022ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/04812579-0232-4a2f-8edb-83049a0022ab?resizing_type=fit)

Set up **Class Selectors** so the players will be able to choose a class. You need to set up the Class Selectors to point to each of the classes defined by the Class Designer devices. Customize the options for each Class Selector as shown in the table below.

Leave any options not listed at their default values.

| Option | Value | Explanation |
| --- | --- | --- |
| **Class to Switch to** | Class Slot: 1, 2, 3 or 4 | Each Class Selector should use the numeric ID of one of the four defined classes. |
| **Time to Switch** | 0.0 | A player runs through the Class Selector to gain the class, so it should happen instantly. |
| **Clear Items on Switch** | True | When the player switches to a class, all items the player has are deleted. They are replaced with the equipment and items for the class. |
| **Accent Color** | Pick a color | Pick a different color for each class, so players can easily distinguish between them. |

Each spawn room will have four Class Selector devices, one for each class you defined. Place the four Class Selector devices on the opposite side of the room from the Player Spawners.

You can [Playtest your island](playtesting-your-island-unreal-editor-for-fortnite) at any time by clicking the "Launch Session" button.

[![Launch Session](https://dev.epicgames.com/community/api/documentation/image/32ef56c3-89f8-4915-95d6-8261b18248cd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/32ef56c3-89f8-4915-95d6-8261b18248cd?resizing_type=fit)

## Next Section

[![5. Set Up Flag Mechanics](https://dev.epicgames.com/community/api/documentation/image/edb0f450-4cc1-4923-8a5e-f294ee9043d2?resizing_type=fit&width=640&height=640)

5. Set Up Flag Mechanics

Set up the core flag capture mechanic of this game mode.](https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-5-set-up-flag-mechanics-in-unreal-editor-for-fortnite)
