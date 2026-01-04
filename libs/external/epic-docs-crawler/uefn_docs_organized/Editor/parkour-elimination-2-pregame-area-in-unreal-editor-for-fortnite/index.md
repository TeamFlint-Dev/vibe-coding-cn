# 2. Pre-Game Area

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/parkour-elimination-2-pregame-area-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:21:12.150172

---

**Devices used:**

- 4 x [Player Spawner](https://www.fortnite.com/creative/docs/using-player-spawner-devices-in-fortnite-creative)
- 4 x [Item Spawner](https://www.fortnite.com/creative/docs/using-item-spawner-devices-in-fortnite-creative)
- 4 x [HUD Message](https://www.fortnite.com/creative/docs/using-hud-message-devices-in-fortnite-creative)
- 5 x [Teleporter](https://www.fortnite.com/creative/docs/using-teleporter-devices-in-fortnite-creative)

[![start area](https://dev.epicgames.com/community/api/documentation/image/6e800e9a-8b08-408c-a565-3d15e8367afb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e800e9a-8b08-408c-a565-3d15e8367afb?resizing_type=fit)

Begin by giving each player their own starting room. Each of these rooms will have 1 **Player Spawner**, 1 **Item Spawner** and 1 **Teleporter**. The player will need to grab a coin, read the HUD message, and understand the importance of the currency — not taking the coin would make the player unable to buy a weapon in the elimination arena! Make it impossible for the player not to take the coin before entering the teleporter.

[![playerspawn](https://dev.epicgames.com/community/api/documentation/image/edd45dad-0dc1-4962-b061-166c677d9791?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/edd45dad-0dc1-4962-b061-166c677d9791?resizing_type=fit)

### Player Spawners #1 to #4

In the Content Browser, navigate to **Fortnite > Devices** and select **Player Spawner**. Drag the device onto your level and place it at the back of the player room.

Configure the **User Options** for the first spawner:

| Option | Value | Explanation |
| --- | --- | --- |
| **Priority Group** | "1": primary | This is an important setting as there are secondary Player Spawners in the elimination arena. When these get disabled, players will spawn there instead. Primary means that they are picked first if that group exists. |
| **Visible During Game** | False | Hides the base of the Spawner during gameplay. |

### Item Spawners #1 to #4

Place the **Item Spawner** in a location that cannot be avoided. All four rooms can use an identical finished Item Spawner — they have no settings that need to be incremented.

Configure the device's **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Items Respawn** | False | The item registered to the item spawner does not respawn. |
| **Base Visible During Game** | False | The base is not visible during gameplay. |
| **Time Before First Spawn** | 0 | The first spawn happens at the start of the round. |
| **Respawn Item on Timer** | False | Only 1 coin will ever be spawned. |
| **Run Over Pickup** | On | There's no need to hit an interact button to get the coin, and more importantly, it prevents the player from skipping it. |
| **Item Scale** | 2.0 | Makes the coin a bit bigger so it's not possible to avoid picking it up. |

Register a single **gold coin** to this spawner: scroll down to **Item List**, then press **+**, expand **Index**, and search for **Gold** to select the coin.

[![itemspawner](https://dev.epicgames.com/community/api/documentation/image/4b32485d-61ed-48d8-80ef-b41d4c59523a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4b32485d-61ed-48d8-80ef-b41d4c59523a?resizing_type=fit)

### Teleporters #1 to #4

There is a teleporter at the end of each starting room. All four rooms can use an identical finished Teleporter as they do not have any incremental settings.

Find and place the Teleporter device behind the Item Spawner and configure the device's **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Teleporter Group** | Group None | The group that the teleportation network belongs to. As it only sends to Group D, it doesn't need one of its own. |
| **Teleport Target Group** | Group D | The teleport network that entering this will send you to. This is set to the single teleporter inside the starting room. |

### HUD Message #1 to #4

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/0b820f4e-b052-4d59-ad3e-e38258bb21f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0b820f4e-b052-4d59-ad3e-e38258bb21f6?resizing_type=fit)

Each **HUD Message** device is linked to one of the Player Spawners, and will play a brief instructional message when the player spawns in.

Find and place the HUD Message device on top of the central starting area, and configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | Grab the Coin, enter the Teleporter, and race to the finish! | The message played upon spawning in. |
| **Message Recipient** | Triggering Player | Only the triggering player sees the message. |
| **Show on Round Start** | False | It will not automatically play when the match starts. |

### Teleporter #5

[![Teleport 5](https://dev.epicgames.com/community/api/documentation/image/21606d17-6e5c-41b1-9193-c85028dc6496?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21606d17-6e5c-41b1-9193-c85028dc6496?resizing_type=fit)

Here is the decorated starting room for the race. Note the teleporter in the middle square of the 3x3 block. It is set up as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Teleporter Group** | Group D | This is the group that the teleporters inside the player start rooms are linked to, so all of them will be sent to the same one. |
| **Teleporter Target Group** | Group None | This teleporter doesn't go anywhere. It's only meant to drop players into this room. |
| **Teleporter Rift Visible** | False | The teleporter is invisible. |
| **Play Visual Effects** | False | There's no visual effect needed for the teleporter. |
| **Play Sound Effects** | False | No sound effects are needed for the teleporter. |
| **Conserve Momentum** | False | The player is dropped from a standing start above it, so running and jumping in won't affect the teleportation. |
| **Face Player In Teleporter Direction** | Yes | They are faced toward the tunnel leading out into the parkour starting area. |

### Direct Event Binding

Direct event binding allows devices to talk to one another directly by using **events** and **functions**. Learn more about it [here](https://dev.epicgames.com/documentation/en-us/fortnite/direct-event-binding-in-unreal-editor-for-fortnite).

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **HUD Message #1 to #4**  [hud message](https://dev.epicgames.com/community/api/documentation/image/92668056-ee10-496c-b631-ee072914fb65?resizing_type=fit) | Show | **Player Spawner #1 to #4**  [spawn pad](https://dev.epicgames.com/community/api/documentation/image/890d9747-36ac-47a3-acd0-9f0c83ae1138?resizing_type=fit) | On Player Spawned | Players will see the HUD message when they spawn. |

Remember to save your progress!

[![savegame](https://dev.epicgames.com/community/api/documentation/image/49e9b940-c817-49ca-9332-6671dbc3009f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/49e9b940-c817-49ca-9332-6671dbc3009f?resizing_type=fit)

## Next Section

[![3. Race Area](https://dev.epicgames.com/community/api/documentation/image/44a56e91-485a-4098-bb38-bb085c76297b?resizing_type=fit&width=640&height=640)

3. Race Area

Build the parkour race section of the game.](https://dev.epicgames.com/documentation/en-us/fortnite/parkour-elimination-3-race-area-in-unreal-editor-for-fortnite)
