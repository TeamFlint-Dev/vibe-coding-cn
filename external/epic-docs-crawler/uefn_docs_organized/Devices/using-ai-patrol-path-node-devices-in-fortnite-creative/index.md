# AI Patrol Path Node Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-ai-patrol-path-node-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:41:27.626968

---

Use the **AI Patrol Path Node** device to create simple or complex patrolling behavior for guards spawned with the [Guard Spawner device](https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative).

Place the device where you want to start a [patrol path](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Using your phone tool, place additional [nodes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) (points) to mark the patrol path (use the [hotkey](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) control for placing or copying). The nodes will all be connected by a colored line, which will have directional arrows based on the patrol behavior you choose in the device options. You can use the phone tool to remove a node by using the control for cutting or deleting. See the image below for an example.

*The Copy and Cut hotkeys change to Append Node and Move Node when you're working with this device.*

Paths can be straight or curved, and can go up and down stairs or slopes. You can create many different patrol paths, and set other devices to send signals that cause guards to switch from one path to another.

Some devices have a limit on how many times that device can be placed on an island. This is independent of how much [memory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the device uses. You can place up to **128 AI Patrol Path Node devices** on your island. For **each device**, you can set **up to 128 individual path nodes**.

  For help on how to find the Advanced Storm Controller Beacon device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

This device has some basic functionality, like setting a Patrol Path Group. Additionally, there are some advanced options, like setting the next patrol path group and determining patrolling behavior.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Patrol Path Group** | **Group None**, Pick or enter a number | Set the Patrol Path Group this device belongs to. |
| **Next Patrol Path Group** | **Group None**, Pick or enter a number | Determines the patrol path group the AI instigator moves to when the **Go To Next Patrol Path Group When Receiving From** option is used. |
| **Patrol Path Ordering** | **No Order**, Pick or enter a number | Determines the order of the patrol path in its patrol path group. If set to **No Order**, the device will put the patrol path at the end. If multiple patrol paths have the same order, they will be randomly ordered between themselves. |
| **Enabled at Start** | **Enabled**, Disabled | Determines if the device is enabled at the start of the game. |
| **Patrolling Mode** | **Back and Forth**, Looping, Stop at End | Determines how the AI uses the Patrol Path.  Options are:   - **Back and Forth**: The AI goes from the start node to the end node, and then goes from the end node back to the start node. - **Looping**: The AI goes from the start node to the end node, then returns directly to the start node. - **Stop at End**: the AI goes from the start node to the end node, and then stays at the end node. |
| **Show Path in Play Mode (Debug)** | **No**, Yes | Determines whether the patrol path is shown during the game. This option is for debugging and testing your island; it does not work with published islands. |
| **Show Path In Edit Mode** | **Yes**, No | Determines whether the patrol path is shown in Create mode. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, making your workflow more intuitive, and giving you more freedom to focus on your design ideas.

Below are the functions and events for this device.

### Functions

A [**function**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Go To Next Patrol Group When Receiving From** | This function sends the AI instigator to the next patrol group. Works with the **On Node Reached** or **On Next Node Unreachable** events. |
| **Go to Next Patrol Path When Receiving From** | This function sends the AI instigator to the next patrol path in the patrol group. This option works with the **When Patrol Node Reach** or **When Next Patrol Path Node** in unreachable. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Patrol Path Started Send Event To** | When an AI starts a patrol path, an event is sent to the selected device, which triggers the selected function. |
| **On Patrol Path Stopped Send Event To** | When an AI stops using a patrol path, an event is sent to the selected device, which triggers the selected function. |
| **On Node Reached Send Event To** | When an AI reaches the current patrol path node, an event is sent to the selected device, which triggers the selected function. |
| **On Next Node Unreachable Send Event To** | When an AI is unable to reach the next patrol path node, an event is sent to the selected device, which triggers the selected function. |

## Design Examples

Here are some examples of how you can use the AI Patrol Path Node device.

- [Door Spotted](https://dev.epicgames.com/documentation/en-us/fortnite/using-ai-patrol-path-node-devices-in-fortnite-creative)
- [Guard Hire](https://dev.epicgames.com/documentation/en-us/fortnite/using-ai-patrol-path-node-devices-in-fortnite-creative)

### Door Spotted

The action of a guard sighting a player can send a signal to other devices. Here is an example of a mechanic that can be implemented into a game that uses this.

You will need the following devices.

- 1 x [Guard Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative)
- 3 x **AI Patrol Path Nodes**
- 1 x [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative)
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)

1. Create a simple hallway in an L shape, with a door at one side, and alcoves to hide in.
2. Place an AI Patrol Path Node on one end of the L-shaped structure. Customize it to the following settings.

   [![Door Path](https://dev.epicgames.com/community/api/documentation/image/b7100057-7a13-4c68-8ab9-35f17a93c4fc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b7100057-7a13-4c68-8ab9-35f17a93c4fc?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Patrol Path Group | Group 1 | The name of the AI patrol path you created. |
3. Copy and paste the initial AI Patrol Path Node. Set up two more that traverse around the corner and to the end of the L-shaped hallway.
4. Set a Guard Spawner in a convenient location on the map where you can group global devices. Customize it to the following settings.

   [![Door Guard](https://dev.epicgames.com/community/api/documentation/image/6cbf9545-422d-4acd-a906-1beec9b7e1d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6cbf9545-422d-4acd-a906-1beec9b7e1d7?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Number of Guards | 1 | Maximum number of guards that can spawn at a time. |
   | Total Spawn Limit | 1 | Total spawns of guards as they are eliminated. |
   | Spawn Radius | 2.5M | Distance from the spawner that a guard can appear. |
   | Spawn On Patrol Path | Group 1 | The AI Patrol Path that the guards will spawn on and follow. |
   | When Alerted To Player Transmit On | Channel 2 | When a guard identifies a player, they will send a signal to this channel. |
   | When Eliminated Transmit On | Channel 3 | When the guard is eliminated, a signal is sent to this channel. |
5. In front of the open door, set a Lock device and customize it to the following settings.

   [![Door Lock](https://dev.epicgames.com/community/api/documentation/image/fe82ccf0-650a-42a0-92e7-5c654f44d5a3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fe82ccf0-650a-42a0-92e7-5c654f44d5a3?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Initial Door Position | Open | When the match starts, the door will automatically be open. |
   | Open When Receiving From | Channel 3 | Upon receiving the signal from eliminating the guard, the door will be opened. |
   | Close When Receiving From | Channel 2 | Upon being sighted by the guard, the door will automatically close and lock. |
6. Within a protected alcove that has cover to block a guard's line of sight if the player crouches, place a Player Spawner. Customize it to the following settings.

   [![Door Spawner](https://dev.epicgames.com/community/api/documentation/image/da7011ce-bbb1-4026-a410-63b01bec2946?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da7011ce-bbb1-4026-a410-63b01bec2946?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | When Player Spawned Transmit On | Channel 1 | When the player spawns, a signal is sent to an Item Granter to award a weapon. |
7. Place an Item Granter next to the Guard Spawner. Register an assault rifle to it, then customize it to the following settings.

   [![Door Path](https://dev.epicgames.com/community/api/documentation/image/af8579f8-4994-4616-9723-8e2fe1f0adf2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/af8579f8-4994-4616-9723-8e2fe1f0adf2?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| Equip Granted Item | First Item | The first item registered to the Item Granter is automatically equipped on spawn. |
| Grant Item When Receiving From | Channel 1 | When the player initially spawns, they are awarded and equipped with the registered weapon. |

You now have the basic functionality for having a door close and lock when a player is sighted by a guard, and unlocked when the player eliminates the guard.

As an alternative to having a player defeat the guard, you can have a button that the player can push to unlock the door. Navigating it through stealth will then become mandatory, or a player can return after eliminating the guards and try again.

You could also set the device to cause all guards to go on alert, or spawn hostile Sentry devices in chokepoints, suddenly making the level significantly more dangerous.

### Guard Hire

Guards, like other AIs such as boars and wolves, can also be recruited by the player to help them in combat.

You will need the following devices.

- 4 x [Guard Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative)
- 2 x **AI Patrol Path Nodes**
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)

1. Create a small T-shaped hallway with a safe spawning alcove at the bottom of the T.
2. Place the Player Spawner in the alcove, using it's default settings.
3. Place a Guard Spawner within the alcove. Customize it to the following settings.

   | Option | Value | Description |
   | --- | --- | --- |
   | Number of Guards | 1 | The number of guards spawned by the device at one time. |
   | Team | Team 1 | Set to the same team as the player's default. |
   | Spawn Timer | 1 Second | Guards are spawned after a one second delay. |
   | Spawn Through Walls | Off | The guards cannot spawn past walls within their spawn radius. |
   | Spawn Radius | 2.5M | The maximum distance a guard can spawn from its spawner. |
   | Patrol Option | Disable Patrol | Guards will stand in their initial spawn location instead of patrolling around. |
   | Can Be Hired | Yes | By interacting with the guards, you can have them follow you. |
4. Copy two more of this Spawn Manager and place them all within the alcove.
5. Place an AI Patrol Path Node on one end of the T juncture hallway. Customize it to the following settings.

   [![AI Patrol Path Node Settings](https://dev.epicgames.com/community/api/documentation/image/f588c698-41f3-4af6-af37-a4779f021bb3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f588c698-41f3-4af6-af37-a4779f021bb3?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Patrol Path Group | Group 1 | The name of the AI patrol path for Guards to use. |
6. Copy and place a second AI Patrol Path Node on the other end of the hallway.
7. Place a fourth Guard Spawner anywhere on the level, and customize it to the following settings.

   [![Enemy Guard Spawner](https://dev.epicgames.com/community/api/documentation/image/023f1d05-2e3f-4fab-a15f-e551e751fdda?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/023f1d05-2e3f-4fab-a15f-e551e751fdda?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| Guard Type | Ghost | The physical model of the guard used. |
| Number Of Guards | 2 | Maximum number of guards that can be spawned at once. |
| Total Spawn Limit | 2 | Total number of guards that can be spawned. |
| Team | Team 2 | The enemy guards are set to a separate team. |
| Spawn Timer | 1 Second | Time interval before spawning guards. |
| Spawn On Patrol Path Group | Group 1 | Guards will spawn on the patrol path and follow it instead of spawn near the guard spawner. |

You now have the basic functionality to hire guards that will fight enemy AIs — from creatures to other guards — in a player's defense.

Making it impossible for a player to do damage outside of using a melee weapon can make utilizing and sustaining the guards important. New guards could be recruited that despawn the old ones, with better statistics and health, gradually building up a standing army that follows the player. There can be many enemies, from creatures to animals to sentries and other guards that they will react to.
