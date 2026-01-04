# 5. Sub-Basement

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-05-sub-basement-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:18:07.491457

---

Outside the holding room, the player should still feel danger, but have more room to explore. It should be clear where the player should go next. Using a HUD Message device you can let the player know to look for medication and other items while in this part of the game.

The sub basement is an unfinished space where the kidnapper watches his captive. To enforce the feeling of being watched, different trash piles were selected and scattered about on the floor, and stacks of water bottles were placed next to the computer area.

There are few devices used to prompt the player to look for healing items and search the room. Item Spawners placed in the sub basement don’t immediately offer players items, instead the Item Spawners are used to spawn items later in the gameplay.

**Devices Used:**

- **1 x** [**Hud Message**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative)
- **1 x** [**Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative)
- **1 x** [**Conditional Button**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-conditional-button-devices-in-fortnite-creative)
- **1 x** [**Lock**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-lock-devices-in-fortnite-creative)
- **4 x Decal**
- **2 x** [**Item Placer**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-item-placer-devices-in-fortnite-creative)
- **2 x** [**Item Spawner**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-item-spawner-devices-in-fortnite-creative)
- **1 x** [Audio Player](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-unreal-editor-for-fortnite)

## Player Prompts

To help the player decide what to do next, these devices remind the player of their health status and should send them in search of healing items.

### HUD Message

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/b24dc174-4495-4452-a138-64a818109218?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b24dc174-4495-4452-a138-64a818109218?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | I don't feel so good. I should look for medicine. | This will cause the player to seek out medicinal items.  The text should always be written in first person so the player feels as though they are reading the avatar’s thoughts. |
| **Priority** | 1 | This message should play first. |

### Trigger

[![Trigger](https://dev.epicgames.com/community/api/documentation/image/d03669cb-e6a6-4bcf-a7bf-69fd0fbd8989?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d03669cb-e6a6-4bcf-a7bf-69fd0fbd8989?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Games** | No | You don't need the spawn pad visible during gameplay, so set this to **No**. |
| **Triggered by Vehicles** | No | Only the player should be able to set off this device. |
| **Triggered by Sequencers** | No | Only the player should be able to set off this device. |
| **Triggered by Water** | No | Only the player should be able to set off this device. |
| **Trigger VFX** | No | No VFX are necessary. |
| **Trigger SFX** | No | No SFX are necessary. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **HUD** **Message** **Room 1** | Show | **Trigger** | On Triggered | This message should prompt the player to search for med kits. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/6e63a5e8-a28b-49e1-b62c-f2f40d83bab3?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/a38bdb79-237f-48b3-a758-232e285aab10?resizing_type=fit) |  |  |

## Escape Sub Basement Devices

These devices are used to keep the player in the sub basement until they complete the puzzle in the hidden room. It should also cause the player to double back to the sub basement and search the room for items they need to escape and heal. The decals on the wall provide the correct answer key for the second puzzle at the top of the stairs.

[![Stairwell](https://dev.epicgames.com/community/api/documentation/image/c2a5734c-9bd7-4d60-978a-45bd8c7fffeb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c2a5734c-9bd7-4d60-978a-45bd8c7fffeb?resizing_type=fit)

### Conditional Button

[![Conditional Button](https://dev.epicgames.com/community/api/documentation/image/4e11562f-5abb-4336-bfe5-1e2141870791?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e11562f-5abb-4336-bfe5-1e2141870791?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Key Item** | Keycard | A keycard is used to unlock the door. |
| **Interact Text** | I finally found the key. | Let the player know what happens after they unlock the door. |
| **Missing Items Text** | Is that door locked? I need to find the key card to unlock it. | Let the player know what they need to unlock the door. |
| **Disable After Use** | Yes | Players don’t need to interact with the Conditional Button once they find the keycard. |
| **Remain Unlocked After Activation** | Yes | There is no reason to lock the device once the player opens the door. |
| **Add Consumed Objects to Score** | Yes | Finding the keycard should reward the player for solving the puzzle. |
| **Score on Key Item 1 Consumed** | 20 | The keycard is worth 20 points. |

### Lock

[![Lock](https://dev.epicgames.com/community/api/documentation/image/168f057f-8883-48e5-afde-4d6a1911c1f8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/168f057f-8883-48e5-afde-4d6a1911c1f8?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Game** | No | The lock doesn’t need to be visible. |

### Decal

[![Decal](https://dev.epicgames.com/community/api/documentation/image/24f0b7d3-b223-4983-a30e-0080d0bf9bcd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/24f0b7d3-b223-4983-a30e-0080d0bf9bcd?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Decal Mask** | - Decal 1 - **4** - Decal 2 - **1** - Decal 3 - **3** - Decal 4 - **2** | These numbers provide the answer the second puzzle. |

### Item Placer 1 and 2

[![Item Placer](https://dev.epicgames.com/community/api/documentation/image/5d622ad9-7f80-4930-a826-1a22086c4efc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5d622ad9-7f80-4930-a826-1a22086c4efc?resizing_type=fit)

Rename the devices to tell them apart.

- Item Placer 1 - **Batteries Item Placer**
- Item Placer 2 - **Med Kit Item Placer**

| Option | Value | Explanation |
| --- | --- | --- |
| **Can Be Damaged at Game Start** | No | These items should not be damaged. |
| **Item List** | - Item Placer 1 - **Batteries** - Item Placer 2 - **Med Kit** | These items are hidden in plain sight on a shelf next to a tool box. |
| **Show Rarity Effects** | No | Players should search for these items, not be guided to them. |
| **Play Audio** | No | There’s no need to play audio from these items. |

## Escape Prep

[![Item Spawners](https://dev.epicgames.com/community/api/documentation/image/e5811886-b2db-4eb4-8d02-5b2d25ddf6d6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e5811886-b2db-4eb4-8d02-5b2d25ddf6d6?resizing_type=fit)

These devices place items that the player can use right away, while the others spawn items the player needs to double back to find to be able to escape the cabin and win the game.

### Item Spawner 1 and 2

[![Item Spawner](https://dev.epicgames.com/community/api/documentation/image/c80e1c38-ab0f-44d5-a134-ffc643ef149d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c80e1c38-ab0f-44d5-a134-ffc643ef149d?resizing_type=fit)

Rename the devices to tell them apart and make it easier to find them when using Direct Event Binding.

- Item Spawner 1 - **Gas Can Item Spawner**
- Item Spawner 2 - **Mechanical Part 1 Item Spawner**

| Option | Value | Explanation |
| --- | --- | --- |
| **Spawn Item on Timer** | No | Each spawner will be triggered by different functions in later parts of the gameplay. |
| **Respawn On timer** | No | These items should not respawn. |
| **Item List** | - Item Spawner 1 - **Gas Can** - Item Spawner 2 - **Mechanical Part** | These items become important at different stages in the game. |
| **Item Respawn** | No | Each item should only spawn once and be picked up once. |
| **Base Visible During Game** | No | The base doesn’t need to be seen. |
| **Bonus Ammo for Weapons** | No | Items should not provide extra ammo. |
| **Run Over Pickup** | Yes | Players should be able to run over the items to pick them up. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Item Spawner 1** | Hide Props | **Conditional Button Door 3** | On Activated | The gas can spawn after the third door is opened. |
| [Item Spawner](https://dev.epicgames.com/community/api/documentation/image/b27d3e69-d2ec-484b-869d-7fd54e04c783?resizing_type=fit) |  | [Conditional Button](https://dev.epicgames.com/community/api/documentation/image/8a77a410-d5e2-433c-859e-7e83625f1911?resizing_type=fit) |  |  |

## Ambience Device

Add to the ambience of the game with creepy music that should play throughout the game.

### Audio Player Device

[![Audio Player](https://dev.epicgames.com/community/api/documentation/image/b4dd7441-61ad-446b-ba04-cc5092253d10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b4dd7441-61ad-446b-ba04-cc5092253d10?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Audio** | Music\_Halloween\_SlasherCamp\_Cue | The music should be creepy. Anything from the Halloween folder will do. |
| **Volume** | 3 | This level acts as ambience for the gameplay. |
| **Fade In Duration** | 1.0 | Music takes 1 second to fade in. |
| **Fade Out Duration** | 1.0 | Music takes 1 second to fadeout when stopping. |
| **Enabled During Phase** | None | This device becomes enabled by the spawning of the player. |
| **Play on Hit** | False | This device is not dependent on the player to start the music. |
| **Stereo Spread** | 0.5 | The spread between the soudn on the right and left is 0.5 |
| **Sync Player Audio** | True | Synchronizes the audio across devices. |

## Next Section

[![6. Hidden Room](https://dev.epicgames.com/community/api/documentation/image/78ae00c7-c013-4f73-b22b-5cbd922595bc?resizing_type=fit&width=640&height=640)

6. Hidden Room

Create a hidden room to hide the first puzzle from view of the player.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-06-hidden-room-in-unreal-editor-for-fortnite)
