# 4. Holding Area

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-04-holding-area-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:17:14.766549

---

The holding room is where the player starts. The room should provide clarity to the player about what’s happening in the game and enforce the idea of captivity and confinement. Everything in this room should immediately inform the player about the type of escape room experience this is.

To create the mood of the game, the room should feel creepy and dark. It has a number of rustic and broken looking props, a camera sits above the door to give the impression to the player that they are being watched. All these elements combined should evoke a sense of urgency and caution.

Each section of the escape room has a number of devices set up for two different reasons. One set of devices are meant to be interacted with when the player reaches that room. Other devices are meant to drop items after the player has completed a task elsewhere and causes the player to double back to collect the spawned items.

**Devices used:**

- **1 x** [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite)
- **1 x** [**Hud Message**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative)
- **1 x** [**Conditional Button**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-conditional-button-devices-in-fortnite-creative)
- **1 x** [**Lock**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-lock-devices-in-fortnite-creative)
- **1 x** [**Teleporter**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-teleporter-devices-in-fortnite-creative)
- **1 x** [**Item Placer**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-item-placer-devices-in-fortnite-creative)
- **1 x** [**Item Spawner**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-item-spawner-devices-in-fortnite-creative)

To turn your interior point and spot lights to red, follow these steps.

Enhance the use of this filter by adding lights to your project in dark areas and change the light color values to red. Changing the color to red deepens the contrast between black and white and better defines objects in the level while using the post-process volume.

[![The post process volume adds to the spatial presence of the game.](https://dev.epicgames.com/community/api/documentation/image/b1d9e98c-30d8-4e6b-96b3-1837ab422f60?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1d9e98c-30d8-4e6b-96b3-1837ab422f60?resizing_type=fit)

You can create a different feeling with this post process filter by changing light colors to orange, yellow, or green. An orange light causes grey objects to appear more white, yellow light brings out the contrast in foliage, and green light adds contrast to objects that are different levels of the color green.

Perform a [bulk edit](https://dev.epicgames.com/documentation/en-us/fortnite/editing-components-in-unreal-editor-for-fortnite) on lighting actors in your level for efficiency.

## Opening Cutscene

Set the cutscene to begin the game. This lets the player know that they were taken by a bad guy and adds to the mystery of the game.

### Cinematic Sequence

[![Cinematic Sequence](https://dev.epicgames.com/community/api/documentation/image/89139c76-fdca-4eb5-91ff-dcf1aa16a5b3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/89139c76-fdca-4eb5-91ff-dcf1aa16a5b3?resizing_type=fit)

These device was renamed to:

- Starting Cinematic Sequence

| Option | Value | Explanation |
| --- | --- | --- |
| **Sequence** | Add your sequences here. | Each device should have a matching sequence that plays when the game begins, the player reaches the bedroom inside the cabin, and when the game ends. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Cinematic Sequence** | Play Function | **Player Spawn Pad** | On Player Spawned | The game starts with the intro cutscene, and this places the player in the cutscene. |
| [Cinematic Sequence](https://dev.epicgames.com/community/api/documentation/image/ab075f4b-1c13-448e-b819-f92d8607ddd9?resizing_type=fit) |  | [Player Spawner](https://dev.epicgames.com/community/api/documentation/image/af1662ae-46d9-440c-83b5-41fc62869bc6?resizing_type=fit) |  |  |

## The First Escape

[![The first room players escape from.](https://dev.epicgames.com/community/api/documentation/image/855b24ef-01a3-4fcb-8837-c051dd0276ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/855b24ef-01a3-4fcb-8837-c051dd0276ab?resizing_type=fit)

The holding room should feel clausterphobic. Finding the key shouold not be overly hard.

### HUD Message

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/d960fcda-7ec5-45c6-996b-73f7d285441f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d960fcda-7ec5-45c6-996b-73f7d285441f?resizing_type=fit)

Rename the HUD Message device, HUD Message Room 1.

| Option | Value | Explanation |
| --- | --- | --- |
| Message | Where am I? How did I get here? Please let there be a key to the door in this room!Where am I? How did I get here? Please let there be a key to the door in this room! | Guides the player to begin searching for the key to the door.  The text should always be written in first person so the player feels as though they are reading the avatar’s thoughts. |

### Conditional Button

[![Conditional Button](https://dev.epicgames.com/community/api/documentation/image/ee8125f5-d825-420d-a756-16bdb9eec29c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee8125f5-d825-420d-a756-16bdb9eec29c?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Key Item** | Key | To make the game feel more real. |
| **Interact Text** | I need a key. | Let the player know that they need to find a key. |
| **Disable After Use** | Yes | This device should not be used again after it opens the door. |

### Lock

[![Lock](https://dev.epicgames.com/community/api/documentation/image/02c1e44c-1db1-44b5-9d07-d1e061cdda28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02c1e44c-1db1-44b5-9d07-d1e061cdda28?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Game** | No | The lock doesn’t need to be visible during the game. |

### Teleporter

[![Teleporer](https://dev.epicgames.com/community/api/documentation/image/4f98bbac-324e-4d83-bd24-06d41a8fc3ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f98bbac-324e-4d83-bd24-06d41a8fc3ac?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Teleporter Group** | Group B | Sets the group the player is teleported to. |
| **Teleporter Rift Visible** | No | The teleporter should not be visible. |
| **Play Visual Effects** | No | VFX are not needed. |
| **Play Sound Effects** | No | SFX are not necessary. |
| **Conserve Momentum** | No | You don’t need to keep the player moving through the teleporter. |

## Item Placer

[![Item Placer](https://dev.epicgames.com/community/api/documentation/image/96e3905e-3b27-4b7c-972e-1b0f3524160c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96e3905e-3b27-4b7c-972e-1b0f3524160c?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Can Be Damagerd at Start of Game** | No | This item should not be damaged. |
| **Item List** | Key | Need a key for the Conditional Button. |
| **Show Rarity Effects** | No | The key needs to be hidden, showing effects will draw attention to it. |
| **Play Audio** | No | This is unnecessary. |

## Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **HUD** **Message** **Room 1** | Show | **Starting Cinematic Sequence** | On Stopped | This message should show to the player after the opening cinematic plays to prompt the player to look for the key to the door. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/06647dab-12e8-4431-bb0d-f9c34f5b6c97?resizing_type=fit) |  | [Cinematic Sequence](https://dev.epicgames.com/community/api/documentation/image/01c2f198-a29d-4ccb-b90d-cc7e613c6732?resizing_type=fit) |  |  |
| **Prop Manipulator** | Hide Props | **Trigger** | On Triggered | The Prop Manipulator will hide the laundry basket from view. |
| [Prop Manipulator](https://dev.epicgames.com/community/api/documentation/image/96aa0b1f-bfec-463a-95f7-46d6d5c7f905?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/aa05254a-9d89-4967-876c-416997cc63d2?resizing_type=fit) |  |  |
| **Lock** | Open | **Conditional Button** | On Activated | The lock unlocks the door so the player can now open the door. |
| [Lock](https://dev.epicgames.com/community/api/documentation/image/22fc780a-a6b7-4452-9a94-51053e58c4a4?resizing_type=fit) |  | [Conditional Button](https://dev.epicgames.com/community/api/documentation/image/2ed60d69-d3fd-461f-9c6b-2adca2365bc5?resizing_type=fit) |  |  |

## Second Puzzle Prep

This device has no bearing on the first escape. It’s simply to prepare for the solution of the second puzzle.

### Item Spawner

[![Item Spawner](https://dev.epicgames.com/community/api/documentation/image/6e9cb258-982f-44bf-b954-b1da125b6bbc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e9cb258-982f-44bf-b954-b1da125b6bbc?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Time Before First Spawn** | 0.1 | Make the item spawn immediately. |
| **Respawn Item On Timer** | No | This item does not need to respawn. |
| **Item List** | Mechanical Part | Place in the center of the room. |
| **Items Respawn** | No | No more items are necessary. |
| **Base Visible During Game** | No | The base should not be visible during the game. |
| **Bonus Ammo For Weapons** | No | Bonus Ammo is not necessary. |
| **Run Over Pickup** | Yes | Players can run over this item to pick it up. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Item Spawner** | Enable | **Trigger** | On Triggered | The Item Spawner spawns the key in place of the laundry basket. |
| [Item Spawner](https://dev.epicgames.com/community/api/documentation/image/76188cc8-9b79-4d99-8f3d-c036b1ae61ae?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/42e003e1-274b-4eef-a346-ec9db6f92919?resizing_type=fit) |  |  |

## Next Section

[![5. Sub-Basement](https://dev.epicgames.com/community/api/documentation/image/9e081a49-72dd-41ba-b69e-f9e10fa4bff1?resizing_type=fit&width=640&height=640)

1. Sub-Basement

Create a mysterious outroom for players to explore.](<https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-05-sub-basement-in-unreal-editor-for-fortnite>)
