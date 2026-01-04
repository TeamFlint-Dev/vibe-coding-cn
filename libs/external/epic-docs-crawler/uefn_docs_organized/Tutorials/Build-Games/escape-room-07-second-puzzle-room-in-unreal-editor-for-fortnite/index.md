# 7. Second Puzzle Room

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-07-second-puzzle-room-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:17:08.630469

---

The second puzzle room provides room for exploring. It is designed to feel like a workshop with a tool box and tool closet. There are some secrets hidden in plain sight, such as a shortwave radio the player can interact with and the Duct Tape they need to rig the stove to explode in the kitchen.

Again the design of the basement should lead the player into the larger area to explore and search for items and interact with the radio.

Nothing should block the player from interacting with the puzzle switches. HUD Messages were used here to guide the player into the puzzle and to look for items once the puzzle is completed.

**Devices Used:**

- **2 x** [**Conditional Button**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-conditional-button-devices-in-fortnite-creative)
- **1 x** [**Lock**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-lock-devices-in-fortnite-creative)
- **2 x** [**Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative)
- **1 x** [**Mutator Zone**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-mutator-zone-devices-in-fortnite-creative)
- **3 x** [**Hud Message**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative)
- **2 x** [**Item Placer**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-item-placer-devices-in-fortnite-creative)
- **1 x** [**Item Spawner**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-item-spawner-devices-in-fortnite-creative)

## Radio and Door Devices

These devices inform the player about the room they've entered and what they need to do here.

### Conditional Button 1 and 2

[![Conditional Button](https://dev.epicgames.com/community/api/documentation/image/de8b7a57-ad6e-48bb-826a-5464274bd0c0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de8b7a57-ad6e-48bb-826a-5464274bd0c0?resizing_type=fit)

Rename the Conditional Buttons so you can tell them apart:

- Conditional Button 1 - Door 3 Conditional Button
- Conditional Button 2 - Batteries Conditional Button

| Option | Value | Explanation |
| --- | --- | --- |
| **Key Items** | Conditional Button 1:   - Mechanical Parts\_T05 - Mechanical Parts\_T02 - Powercell   Conditional Button 2:   - Batteries | The mechanical pieces spawn when the second puzzle is solved. Batteries are a secret item players can find and use to get extra points. |
| **Interact Text** | Conditional Button 1:   - The door should open now.   Conditional Button 2:   - Maybe I can call for help if I put batteries in the radio. | The messages should inform the player what happens after the Conditional Button receives what it needs. |
| **Missing Items text** | Conditional Button 1:   - I need to find these metal objects to rig the door open.   Conditional Button 2:   - Maybe I can call for help if I put batteries in the radio. | The messages should inform the player that the Conditional Button is missing. |
| **Disable After Use** | Yes | Players don’t need to interact with the Conditional button again. |
| **Visible During Game** | No | This only applies to the Conditional Button that takes the batteries. It should be hidden inside the short wave radio. |
| **Reaction Radius** | 1 | This applies only to the Conditional Button that takes the batteries. |
| **Activated by Sequencers** | No | Only the player should activate this device. |
| **Score on Key Item 1 Consumed** | - Conditional Button 1 - **20**, **20**, **20** - Conditional Button 2 - **50** | Reward the player for performing all the tasks. |

### Lock

[![Lock](https://dev.epicgames.com/community/api/documentation/image/2bd88aed-0ddc-4c65-9675-deb10f746508?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2bd88aed-0ddc-4c65-9675-deb10f746508?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Game** | No | The lock doesn’t need to be visible. |
| **Hide Interaction When Locked** | Yes | The player doesn’t need to see the interaction effects. |

### Trigger

[![Trigger](https://dev.epicgames.com/community/api/documentation/image/ee8d5b35-9b3c-4570-87b2-9c931c61ad4f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee8d5b35-9b3c-4570-87b2-9c931c61ad4f?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Games** | No | The trigger doesn't need to be visible during gameplay, set this to **No**. |
| **Triggered by Vehicles** | No | Only the player should be able to set off this device. |
| **Triggered by Sequencers** | No | Only the player should be able to set off this device. |
| **Triggered by Water** | No | Only the player should be able to set off this device. |
| **Trigger VFX** | No | No VFX are necessary. |
| **Trigger SFX** | No | No SFX are necessary. |

### Mutator Zone

[![Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/b28c2e99-f811-43ba-98d3-dcf223ff72f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b28c2e99-f811-43ba-98d3-dcf223ff72f4?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Affects Creatures** | No | There are no creatures in this game. |
| **Affect Guards** | No | There are no guards in this game. |
| **Allow Editing** | No | This device should not be editable. |
| **Enable VFX** | No | No VFX are necessary. |
| **Allow Building** | No | Players will not be building. |
| **Override All Movement Bonuses at Zero** | No | There’s no need to override bonuses. |
| **Zone Shape** | Cylinder | To make the zone as small as possible. |
| **Allow Map Marker** | No | There’s no need for map marking. |
| **Allow Emote Wheel** | No | There’s no need for the emote wheel. |

### HUD Message 1- 3

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/4c7592de-8233-45bf-891e-60e6531487c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c7592de-8233-45bf-891e-60e6531487c2?resizing_type=fit)

Rename the HUD Message devices to tell them apart:

- HUD Message 1 - **Puzzle Message HUD Message Device**
- HUD Message 2 - **Radio HUD Message Device**
- HUD Message 3 - **Duct Tape HUD Message Device**

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | - **HUD Message 3rd Room**: Are those switches another puzzle? - **HUD Message Duct Tape**: I might need this later. - **HUD Message Batteries**: Oh no! Rats chewed through the wires! I can’t use the radio. | These messages guide the player through the game. |
| **Priority** | - **HUD Message 3rd Room** - 1 - **HUD Message Batteries** - 2 - **HUD Message Duct Tape** - 3 | Messages need to stagger, add them to different priorities. |
| **Layer** | HUD Message 3rd Room - **1** | All messages use the same layer to stagger their messages. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Mutator Zone** | Disable | **Trigger** | On Triggered | Stops the Mutator Zone from spawning more messages from the attached HUD Message device. |
| [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/2459acdd-1a73-4f48-9577-8be3c55bd3a2?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/52d44481-fae8-4017-bc0e-719b75c00885?resizing_type=fit) |  |  |
| **HUD Message Puzzle** | Show | **Mutator Zone** | On Player Entering Zone | The message informs the player there’s another puzzle that needs to be completed. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/fb1c2bb8-54a8-4246-86e9-e363f8ba5de2?resizing_type=fit) |  | [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/17d84c42-bfd9-417b-ae64-7831ca7bd45f?resizing_type=fit) |  |  |
| **HUD Message Batteries** | Show | **Conditional Button** | On Activated | Shows a message telling the player the radio can’t be used. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/3e9a0acf-0cd8-430f-8609-116b2740ddcb?resizing_type=fit) |  | [Conditional Button](https://dev.epicgames.com/community/api/documentation/image/e66b2efa-c203-4f24-b2d9-ca3f068c99c3?resizing_type=fit) |  |  |
| **HUD MessageDuct Tape** | Show | **Item Placer** | On Item Granted | Informs the player they need the item they just picked up. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/c2bc3213-c3c1-452f-8858-9e84bbd142ed?resizing_type=fit) |  | [Item Placer](https://dev.epicgames.com/community/api/documentation/image/f0f153c0-0bed-4988-a964-ca90ebea25e5?resizing_type=fit) |  |  |

## Escape Item Devices

These devices provide the player with items they need to escape this room and enter the next phase of the escape room.

### Item Placer

[![Item Placer](https://dev.epicgames.com/community/api/documentation/image/9d220a5f-2b74-47ee-8b74-4c502085a388?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d220a5f-2b74-47ee-8b74-4c502085a388?resizing_type=fit)

Rename the Item placer devices to tell them apart:

- Duct Tape
- Cabin Key

| Option | Value | Explanation |
| --- | --- | --- |
| **Can Be Damaged On Game Start** | No | Player should not be able to damage this item. |
| **Item List** | - Duct Tape - Key | The key is necessary to open the cabin door, and the duct tape is necessary to blwo up the cabin. |

### Item Spawner

[![Item Spawner](https://dev.epicgames.com/community/api/documentation/image/04f9a08f-b5b1-47c5-a2e2-546933871b5d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/04f9a08f-b5b1-47c5-a2e2-546933871b5d?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Spawn Item On timer** | No | Verse Device will spawn this item when the puzzle is successfully completed. |
| **Respawn Item on Timer** | No | The item should only spawn once. |
| **Item List** | Powercell | This item is necessary to open the door to the escape hatch. |
| **Items Respawn** | No | This item should only spawn once. |
| **Base Visible During Game** | No | The base is not necessary. |
| **Bonus Ammo For Weapons** | No | There is no need to provide bonus ammo for weapons. |
| **Run Over Pickup** | Yes | Players can run over the item to pick it up. |
| **Enabled at Game Start** | No | The Verse Device will turn on the device when it’s time. |

## Next Section

[![8. Outside Cabin](https://dev.epicgames.com/community/api/documentation/image/2464762c-ab81-4c7e-a73c-aa995d8145ca?resizing_type=fit&width=640&height=640)

8. Outside Cabin

Create creepy woods around the cabin for players to explore and to capture in your cinemtaics.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-08-outside-cabin-in-unreal-editor-for-fortnite)
