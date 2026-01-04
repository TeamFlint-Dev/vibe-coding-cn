# 6. Hidden Room

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-06-hidden-room-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:17:31.616727

---

The hidden room behind the stairs is where you will set up the [Tagged Light Puzzle](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-puzzle-in-verse). This room should feel like there is something hidden in here, which is one reason there’s a safe in the corner of the room. Tube props were used to make it look like the safe is attached to the light puzzle.

[![The hidden room.](https://dev.epicgames.com/community/api/documentation/image/32ade5df-7486-43f3-a527-6fa035a8c9cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/32ade5df-7486-43f3-a527-6fa035a8c9cb?resizing_type=fit)

Glowing cubes and reflective cubes are used to hint to players which lights the switches are hooked up to. Provide further clues by setting up HUD Message devices to explain what is in the room.

The size of this room should provide enough room for the player to move around and solve the puzzle. This hidden room also contains secret items once the player advances past the second puzzle.

**Devices Used:**

- **3 x** [**Hud Message**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative)
- **1 x** [**Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative)
- **2 x** [**Item Spawner**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-item-spawner-devices-in-fortnite-creative)
- **1 x** [**Prop Manipulator**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-prop-manipulator-devices-in-fortnite-creative)

## Puzzle Prompts

### HUD Message 1 and 2

[![HUD Mesage](https://dev.epicgames.com/community/api/documentation/image/63d11147-7b04-4b5f-bf49-7c5b2c087bc3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/63d11147-7b04-4b5f-bf49-7c5b2c087bc3?resizing_type=fit)

Rename the HUD Message devices to tell them apart:

- HUD Message 1 - **Light Hint Message HUD Message Device**
- HUD MEssage 2 - **Safe Message HUD Message Device**

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | - **HUD Message 1**: The glowing blocks on the wall are in some sort of pattern. - **HUD Message 2**: I wonder what’s in the safe? |  |
| **Priority** | - **HUD Message 1**: 1 - **HUD Message 2**: 2 | The light hint message should show first, and the puzzle prompt should appear second. |

### Trigger

[![Trigger](https://dev.epicgames.com/community/api/documentation/image/4ed1b5b8-995f-41be-a8ae-41fa9baa0aee?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4ed1b5b8-995f-41be-a8ae-41fa9baa0aee?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Games** | No | The spawn pad doesn't need to be visible during gameplay, set this to **No**. |
| **Triggered by Vehicles** | No | Only the player should be able to set off this device. |
| **Triggered by Sequencers** | No | Only the player should be able to set off this device. |
| **Triggered by Water** | No | Only the player should be able to set off this device. |
| **Trigger VFX** | No | No VFX are necessary. |
| **Trigger SFX** | No | No SFX are necessary. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **HUD** **Message** **Room 1** | Show | **Trigger** | On Triggered | This message explains that the cubes on the wall are in an important pattern. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/1040c52f-22f3-4dcd-bbfe-021204598396?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/30cc5ed9-2cde-4fee-a185-acd1b7749ad7?resizing_type=fit) |  |  |
| **HUD MEssage 2** | Hide Props | **Trigger** | On Triggered | The message informs the player they need to complete the puzzle to get the item inside the safe. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/fb963cd4-7e4c-40cb-9f2f-c37a5fc7a194?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/ca9f0919-5a31-4f7c-ad2e-169e6046fdcf?resizing_type=fit) |  |  |

## Puzzle Prep

### Item Spawner 1 and 2

[![Item Spawner](https://dev.epicgames.com/community/api/documentation/image/2891d921-b48d-4e5e-88d6-2d151151d96e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2891d921-b48d-4e5e-88d6-2d151151d96e?resizing_type=fit)

The Keycard Item Spawner will be hooked up to the Tagged Lights Puzzle and the Chug Splash Item Spawner will be hooked up to the Switch Item Puzzle.

Rename the Item Spawners so you can find them easier when searching for them in Direct Event Binding from the Verse Devices.

| Option | Value | Explanation |
| --- | --- | --- |
| **Spawn Item on Timer** | No | Each spawner will be triggered by different functions in later parts of the gameplay. |
| **Respawn On timer** | No | These items should not respawn. |
| **Item List** | - Item Spawner 1- **Key Card** - Item Spawner 2 - **Chug Splash** | These items become important at different stages in the game. |
| **Item Respawn** | No | Each item should only spawn once and be picked up once. |
| **Base Visible During Game** | No | The base doesn’t need to be seen. |
| **Bonus Ammo for Weapons** | No | Items should not provide extra ammo. |
| **Run Over Pickup** | Yes | Players should be able to run over the items to pick them up. |

### Prop Manipulator

[![Prop Manipulator](https://dev.epicgames.com/community/api/documentation/image/26ab7777-93c9-481a-b5e4-6336301e4363?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26ab7777-93c9-481a-b5e4-6336301e4363?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Item List** | Fortilla Keycard | The Prop Manipulator reveals the keycard. |

## Next Section

[![7. Second Puzzle Room](https://dev.epicgames.com/community/api/documentation/image/067abc9d-eb88-4d47-99e9-b606946ef090?resizing_type=fit&width=640&height=640)

7. Second Puzzle Room

Create an upper basement area for players to find the second puzzle.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-07-second-puzzle-room-in-unreal-editor-for-fortnite)
