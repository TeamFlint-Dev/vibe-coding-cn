# 8. Customizing Player Spawns

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-08-customizing-player-spawns-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:23:37.993436

---

This section will show you how to set the devices needed to spawn players into different teams with VFX (visual effects) attached to players. You will also set the teleporters which will move players from the lobby to the game area.

**Devices used:**

- ~16 x [Player Spawn Pads](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-spawn-pad-devices-in-fortnite-creative)
- 9 x [Teleporters](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-teleporter-devices-in-fortnite-creative)

## Player Spawn Pad Devices

[![Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/8df9d0dc-f53c-41db-9fed-cbea22620ca8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8df9d0dc-f53c-41db-9fed-cbea22620ca8?resizing_type=fit)

It’s a good idea to place extra spawners to ensure spawning is registered for every player.

Place your spawn pads in an area away from the arena where the gameplay will be carried out. For this template, players spawn in an area designed to look like an elevator lobby that leads to the area where the gameplay will take place.

These spawn pads are used to spawn players at the start of the round and when players of the prop team are eliminated.

Place a Player Spawn Pad in your lobby and configure the **User Options** to match the table below. Then, copy and paste the device to account for the amount of players in your game. Remember to place extra spawners to ensure spawning is registered for every player.

[![Modified Player Spawn Pad](https://dev.epicgames.com/community/api/documentation/image/b88591d4-cf00-455e-8c3c-0f07d5794d15?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b88591d4-cf00-455e-8c3c-0f07d5794d15?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible in Game** | False | The spawn pads will not be visible during gameplay. |

## Teleporter Device

[![Teleporter](https://dev.epicgames.com/community/api/documentation/image/67cdbf2b-7944-4f69-904a-65f9b357217f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/67cdbf2b-7944-4f69-904a-65f9b357217f?resizing_type=fit)

The teleporters should be placed in two areas.

[![Lobby Teleporter](https://dev.epicgames.com/community/api/documentation/image/4d9b737c-f400-4225-867e-847a01128d8a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d9b737c-f400-4225-867e-847a01128d8a?resizing_type=fit)

One teleporter should be placed in the lobby where your players spawn. This device is used with Verse to teleport props and hunters into the game area.

Before the game begins, this teleporter is also used to teleport hunters who attempt to leave the lobby before the timer is completed.

When the prop team is moved to the game area, the teleporter is enabled, the prop agents are teleported, and the teleporter is then disabled. When the hunter team’s wait timer expires, the teleporter is enabled again, the hunter team is teleported, and the teleporter is then left enabled so that both eliminated props and players joining mid-game can teleport into the game area.

After players of the hunter team are teleported into the game arena, it is enabled so that props that respawn as hunters can rejoin the game.

You may need to instruct players to walk into the teleporter after they respawn since they will no longer be automatically pushed to the arena.

Place this teleporter in your lobby where the Player Spawn Pads are located and configure the **User Options** to match the table below.

[![Modified Lobby Teleporter](https://dev.epicgames.com/community/api/documentation/image/86111912-73ed-4771-b2f9-5bd137e2675e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/86111912-73ed-4771-b2f9-5bd137e2675e?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Teleporter Group** | Group None | Sets the teleport group that this device belongs to. |
| **Teleporter Target Group** | Group A | Determines the teleporter group that this device will send players to. |
| **Teleporter Rift Visible** | True | This rift will be visible for players to see. |
| **Enabled During Phase** | None | This device will start disabled and enabled with Verse when the round starts. |

[![Arena Teleporter](https://dev.epicgames.com/community/api/documentation/image/c975d068-b069-4e68-ac24-1566da3a0fac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c975d068-b069-4e68-ac24-1566da3a0fac?resizing_type=fit)

Next, set up the arena teleporters. These teleporters are linked to the one in the lobby for respawned players to exit.

You can place as many teleports as you like in a location that suits your gameplay. For this tutorial, we use eight teleporters in a single location.

Place a Teleporter in your desired location and configure the **User Options** to match the table below. Then, copy and paste this device in a layout and quantity that suits your gameplay needs.

[![Modified Lobby Teleporter](https://dev.epicgames.com/community/api/documentation/image/c6517ba0-fdd8-4165-80a0-c47f5f2a13c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c6517ba0-fdd8-4165-80a0-c47f5f2a13c4?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Teleporter Group** | Group A | Sets the teleporter group that this device belongs to. |
| **Target Teleporter Group** | Group None | Determines the teleporter group that this device will send players to. |
| **Teleporter Rift Visible** | False | This device will not be visible during gameplay. |
| **Face Player in Teleporter Direction** | Yes | Determines whether the orientation of the player should be changed to that of the destination teleporter. |

## Next Section

[![9. Configuring the Informative Devices](https://dev.epicgames.com/community/api/documentation/image/2c19e6e7-3e2a-43e0-b199-989c0862b40d?resizing_type=fit&width=640&height=640)

9. Configuring the Informative Devices

Set up the devices that send information to players and the game.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-09-configuring-the-informative-devices-in-unreal-editor-for-fortnite)
