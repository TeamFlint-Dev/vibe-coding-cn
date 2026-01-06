# 9. Inside Cabin

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-09-inside-cabin-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:17:26.189246

---

The cabin interior is roughly split into two sections, the main kitchen area and the bedroom.

**Cozy Cabin** comes with a set of props, but these were moved out of the corners and a fridge and stove were added. The stuffed bear was moved out of the bedroom and placed against the wall of the bedroom.undefined

A table was added to hold the key to the truck the player needs to escape the cabin and win the game. The barrel and candles were added to give the room a bit of light.

[![The cabin bedroom.](https://dev.epicgames.com/community/api/documentation/image/0c00c0ee-72f3-4d95-9cb9-28860eb512bf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c00c0ee-72f3-4d95-9cb9-28860eb512bf?resizing_type=fit)

Players should have room to run around the cabin and search for items as well as fight in the final battle.

**Devices Used:**

- **3 x** [**Hud Message**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative) devices
- **1 x** [**Mutator Zone**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-mutator-zone-devices-in-fortnite-creative) device
- **1 x** [**Explosive**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-explosive-devices-in-fortnite-creative) device
- **2 x** [**Conditional Button**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-conditional-button-devices-in-fortnite-creative) devices
- **1 x** [**Lock**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-lock-devices-in-fortnite-creative) device
- **1 x** [**Class Selector**](https://dev.epicgames.com/documentation/fortnite-creative/using-class-selector-devices-in-fortnite-creative) device
- **1 x** [**Class Designer**](https://dev.epicgames.com/documentation/fortnite-creative/using-class-designer-devices-in-fortnite-creative) device
- **1 x** [**Cinematic Sequence**](https://dev.epicgames.com/documentation/en-us/uefn/cinematic-sequence-device-in-unreal-editor-for-fortnite) device
- **3 x** [**Item Placer**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-item-placer-devices-in-fortnite-creative) devices
- **1** [**Item Granter**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-item-granter-devices-in-fortnite-creative) device
- **1 x** [**Item Spawner**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-item-spawner-devices-in-fortnite-creative) device
- **3 x** [**Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative) devices
- **1 x** [**Fire Volume**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-fire-volume-devices-in-fortnite-creative) device
- **1 x** [**Sentry**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-sentry-devices-in-fortnite-creative) device

## Search for the Key Devices

[![Use these devices to guide the player through this part of the game.](https://dev.epicgames.com/community/api/documentation/image/5c4478c4-a3e9-45f0-bac1-d6d67917604b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c4478c4-a3e9-45f0-bac1-d6d67917604b?resizing_type=fit)

Use these devices to guide the player toward finding the key while giving them extra healing items.

### HUD Message 1 - 3

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/e57fb523-0ceb-44bb-bac6-6e2cf70cd0d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e57fb523-0ceb-44bb-bac6-6e2cf70cd0d7?resizing_type=fit)

Rename the **HUD Message** devices so you can easily tell them apart. In this example the devices were named:

- Search for Key HUD Message
- Blow Up Cabin HUD Message
- Find the Key HUD Message

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | Search for Key HUD Message:   - I've got to find the key to the truck!   Blow Up Cabin HUD Message:   - I could blow up this cabin if I rigged the stove with some duct tape.   Find the Key HUD Message:   - Uh oh… The key must be in the room behind the locked door! | The messages informs the player of their objective in the cabin and the decisions they can make in the cabin. |
| **Display Time** | 3.0 | The messages are short and only need to display for a few seconds. |
| **Layer** | 1 | All devices use the same layer to stagger their mesasges. |
| **Priority** | Search for Key HUD Message - 1  Search for the Key HUD Message - 1  Blow Up Cabin HUD Message - 2  Find Key in the Cabin HUD Message - 3 | The messages are staggered and layered so they don’t overlap. |
| **Allow Multiple in Queue** | Yes | Allows more than one message in the queue. |
| **Queue Timeout** | 5.0 | Messages should timeout after 5 seconds. |
| **Re-Evaluate Messages On Show** | Yes | Ensures the messages display in the proper order. |

### Item Placer 1 - 5

[![Item Placer](https://dev.epicgames.com/community/api/documentation/image/4df1c221-e963-4009-b3aa-121a0c225cc6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4df1c221-e963-4009-b3aa-121a0c225cc6?resizing_type=fit)

Rename the **Item Placer** devices so you can easily tell them apart. In this example the devices were named:

- Corn Item Placer
- Apple Item Placer
- Shotgun Item Placer
- Bedroom Door Key Item Placer
- Small Slurp Potion Item PLacer

| Option | Value | Explanation |
| --- | --- | --- |
| **Interact Text** | Corn:   - I’m not sure if I need this, but it looks tasty.   Apple:   - An apple a day won’t start the truck. I need to find the key!   Shotgun:   - I should take this just in case.   Bedroom Door Key:   - I found it!   Small Slurp Potion:   - I should take some more medicine. | The text on the corn and apple keep the player looking for the key to the truck. |
| **Interact Time** | 0.1 | The player should pick up the items quickly. |
| **Can be Damaged at Game Start** | No | These items should not be damageable. |
| **Item List** | Item Placers 1-5:   - Corn - Apple - Shotgun - Bedroom Door Key - Small Slurp Potion | The two items can help boost the health of the player, the key gives the player access to the end of the game. |
| **Item Quantity** | 1 (Except for the small slurp potion, provide 4.) | The players only need one of each food type to top off their health. |

### Trigger 1 - 3

[![Trigger](https://dev.epicgames.com/community/api/documentation/image/36af6301-fd04-447e-a6de-3f903a07ae6d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36af6301-fd04-447e-a6de-3f903a07ae6d?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible In Game** | No | Players should not see the Trigger. |
| **Triggered by Vehicles** | No | Only the player should be able to set off this device. |
| **Triggered by Sequencers** | No | Only the player should be able to set off this device. |
| **Triggered by Water** | No | Only the player should be able to set off this device. |
| **Times can Trigger** | Cabin Trigger   - 2 x   Fight Sentry Trigger   - 2x   Kidnapper Returns Trigger   - 1x | The trigger should trigger the necessary number of times. |
| **Trigger VFX** | No | No VFX are necessary. |
| **Trigger SFX** | No | No SFX are necessary. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Cabin Trigger** | Disable | **Cabin Trigger** | On Triggered | Ensures the player cannot trigger the device again. |
| [Trigger](https://dev.epicgames.com/community/api/documentation/image/ea8b63cd-365c-4dac-9628-8a9135e1f016?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/9ebb37be-e3f3-4762-83bd-a8b6c72473ba?resizing_type=fit) |  |  |
| **Search for Key HUD Message** | Show | **Cabin Trigger** | On Triggered | Urges the player to look for the key to the truck. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/b28a56b0-b9ab-4631-9dc3-82538f0739ff?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/79ebb35b-c8fe-429e-b5f6-fabe03eacb9d?resizing_type=fit) |  |  |
| **Search for Key HUD Message** | Clear Layer | **Timed Object** | On Started | Clears the message layer so the next HUD Message can display without overlapping. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/c4ead05f-6bc0-4382-b3df-9fffa97122eb?resizing_type=fit) |  | [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/213d6832-6ca1-47a3-b518-1712cab73e9d?resizing_type=fit) |  |  |
| **Find the Key in the Cabin HUD Message** | Show | **Item Placer 2** | On Item Granted | Shows the prompt that tells the player to go to the bedroom. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/684ea33d-67ae-4367-b81f-f74405dbbe89?resizing_type=fit) |  | [Item Placer](https://dev.epicgames.com/community/api/documentation/image/375cdb4c-a22c-4491-bb76-737951f0fdaa?resizing_type=fit) |  |  |
| **Blow Up the Cabin HUD Message** | Show | **Decides Trigger** | On Triggered | Shows the message to the player to blow up the cabin. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/daa3f640-0467-470a-af3a-664be7386119?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/422d6796-4432-4751-813c-12e3625f6a5e?resizing_type=fit) |  |  |
| **Door Open HUD Message** | Show | **Timed Objective** | On Started | Shows the message telling the player the bedroom door is now open. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/b2784959-c8d7-4dd9-bd7a-97cfaff1a86f?resizing_type=fit) |  | [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/ec6418f6-a3af-44f6-9294-8c34a39b15e2?resizing_type=fit) |  |  |

## Bedroom Devices

[![](https://dev.epicgames.com/community/api/documentation/image/e027d263-6d34-44f5-b0e9-25845947770c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e027d263-6d34-44f5-b0e9-25845947770c?resizing_type=fit)

These devices are used in the final fight. They allow the player to enter the bedroom, see the kidnapper return cut scene and change the player’s class.

### Conditional Button

[![Conditional Button](https://dev.epicgames.com/community/api/documentation/image/7b100b54-c977-437f-a885-f8e52d4ce7e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7b100b54-c977-437f-a885-f8e52d4ce7e0?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Key Item** | Key | A HUD message informs the player they need a key to open the door. |
| **Interact Text** | I found the key to this room. | Prompts the player to give the key to the button. |
| **Missing Items** | I need to find the key to this room. | Informs the player they’re missing a key item. |
| **Disable After Use** | Yes | There’s no need to interact with this device further. |
| **Visible During Game** | No | To feel real, the button must be invisible. |
| **Score on Key Item Consumed** | 35 | Reward the player for finding and using the duct tape. |

### Lock

[![Lock](https://dev.epicgames.com/community/api/documentation/image/65cce76d-d14e-4d0a-a242-24e61bc7b1ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/65cce76d-d14e-4d0a-a242-24e61bc7b1ab?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Game** | No | Players don’t need to see the lock. |

### Cinematic Sequence

[![Cinematic Sequence](https://dev.epicgames.com/community/api/documentation/image/ba086ef1-e337-4205-bce9-dd0a08a1f9a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba086ef1-e337-4205-bce9-dd0a08a1f9a7?resizing_type=fit)

Rename the Cinematic Sequence devices to make it easier to tell them apart. This devices was renamed:

- Kidnapper Returns Cinematic Sequence Device

| Option | Value | Explanation |
| --- | --- | --- |
| **Sequence** | Add your sequences here. | Each device should have a matching sequence that plays when the game begins, the player reaches the bedroom inside the cabin, and when the game ends. |

### Class Selector

[![Class Selector](https://dev.epicgames.com/community/api/documentation/image/52d1fa97-4303-4770-bd71-8f4f843daf4b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/52d1fa97-4303-4770-bd71-8f4f843daf4b?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Class to Switch to** | Class Slot 1 | Create a class that allows the player to drive the truck. |
| **Visible in Game** | False | The device doesn't need to be visible in-game. |
| **Volume Visible in Game** | False | The volume doesn't need to be visible in-game. |
|  |  |  |
| --- | --- | --- |

### Class Designer

[![Class Designer](https://dev.epicgames.com/community/api/documentation/image/9abb8ad6-1430-4d89-aa62-f01bc231cd47?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9abb8ad6-1430-4d89-aa62-f01bc231cd47?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Class Name** | Survivor | Defines the player as a survivor. |
| **Class Identifier** | Class Slot 1 | Creates a class that alows the player to drive the truck at the end of the game. |
| **Grant Ammo with Weapons** | False | Ammo will be granted with the ammo chest in the bedroom, not with this device. |

### Item Placer

[![Item Placer](https://dev.epicgames.com/community/api/documentation/image/52480434-d029-4c46-b4c2-cd6e8187c642?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/52480434-d029-4c46-b4c2-cd6e8187c642?resizing_type=fit)

This is the truck key the player needs to escape the cabin.

| Option | Value | Explanation |
| --- | --- | --- |
| **Interact Text** | The key to the truck! | Let's the player know they have the key to the truck. |
| **Interact Time** | 0.1 | Players quickly acquire the key. |
| **Item List** | Key | The key to the truck. |
| **Item Quantity** | 1 | The player only needs one key. |

## Item Granter

[![Item Granter](https://dev.epicgames.com/community/api/documentation/image/cbdd5309-e15c-46e3-adee-47591a476fa1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cbdd5309-e15c-46e3-adee-47591a476fa1?resizing_type=fit)

This provides extra bullets and a touch of realism to the exerpience.

| Option | Value | Explanation |
| --- | --- | --- |
| **On Grant Action** | Keep All | Allows the player to keep all the ammo. |
| **Item List** | Shotgun Shells | Extra ammo for the gun since it has limited ammo. |
| **Item Quantity** | 40 | Provides extra ammo to the player. |
| **Grant on Cycle** | No | There's no need to continuously provide ammo. |
| **Equip Granted Item** | Yes | Allows the player to use the ammo right away. |

## Item Spawner

[![Item Spawner](https://dev.epicgames.com/community/api/documentation/image/eeb4c4ba-4e54-4213-9f9f-5b8b25e05309?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eeb4c4ba-4e54-4213-9f9f-5b8b25e05309?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Spawn Item on Timer** | False | This spawns when triggered. |
| **Respawn Item on Timer** | False | This spanws when triggered and should't respawn. |
| **Item List** | Medkit | Provides the player with more health if they have difficulty defeating the Sentry device. |
| **Items Respawn** | False | This item will not respawn. |
| **Base Visible During Game** | False | The base shouldn't be visible during the game. |
| **Bonus Ammo For Weapons** | False | This isn't necessary because there's an ammo box. |
| **Run Over Pickup** | True | Player can run over the item to pick it up. |
| **Allow Spawning When Blocked** | True | If the player doesn't have the item spawner in their line of sight, the Medkit still spawns. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Bedroom Lock** | Unlock | **Conditional Button** | On Activated | When the player gives the key to the button, the bedroom door unlocks. |
| [Lock](https://dev.epicgames.com/community/api/documentation/image/5e68e4de-8006-40ed-9ef8-c1fc0e0de140?resizing_type=fit) |  | [Conditional Button](https://dev.epicgames.com/community/api/documentation/image/85d9d23e-519b-4e8d-9652-45b17036237c?resizing_type=fit) |  |  |
| **Bedroom Lock** | Open | **Conditional Button** | On Activated | Opens the door when the player gives the key to the button. |
| [Lock](https://dev.epicgames.com/community/api/documentation/image/ae273e30-8b61-453a-b316-cd9f89b1838d?resizing_type=fit) |  | [Conditional Button](https://dev.epicgames.com/community/api/documentation/image/5c12413c-70ee-410f-90bd-ce6d9027cf17?resizing_type=fit) |  |  |
| **Fight Trigger** | Enable | **Conditional Button** | On Activated | When the player gives the key to the button, the Trigger becomes enabled |
| [Trigger](https://dev.epicgames.com/community/api/documentation/image/91d365b7-a6c5-4da9-aeb5-80c1db6d4fcb?resizing_type=fit) |  | [Conditional Button](https://dev.epicgames.com/community/api/documentation/image/9d07c5f4-d36a-4451-b8df-2357030b903b?resizing_type=fit) |  |  |
| **Kidnapper Returns Cinematic Sequence** | Play Function | **Cut Scene Trigger** | On Triggered | When the player enters the bedroom in the cabin this cinematic starts playing. |
| [Cinematic Sequence](https://dev.epicgames.com/community/api/documentation/image/b8e27d3a-80e0-4f65-9e70-427eee63c5b9?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/d97e83a5-4582-4aa7-850d-0f2209cbe13c?resizing_type=fit) |  |  |
| **Item Spawner** | Spawn Item | **Item Granter** | On Item Granted | When the player receives the extra ammo from the ammo box, the Medkit spawns. |
| [Item Spawner](https://dev.epicgames.com/community/api/documentation/image/df686937-22b6-441a-bded-1df8edb764ed?resizing_type=fit) |  | [Item Granter](https://dev.epicgames.com/community/api/documentation/image/a41717ee-9c63-42cb-a609-677de5ec28d4?resizing_type=fit) |  |  |

## Destroy the Cabin Devices

[![The devices used to catch the cabin on fire.](https://dev.epicgames.com/community/api/documentation/image/a9634e6d-bc58-456c-9dcd-c35941b049d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9634e6d-bc58-456c-9dcd-c35941b049d5?resizing_type=fit)

After the player decides to destroy the cabin, these devices start a 2 minute countdown until the cabin explodes.

### Conditional Button

[![Conditional Button](https://dev.epicgames.com/community/api/documentation/image/78ee95c9-26af-43a5-a9ce-8ef5794ceee7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/78ee95c9-26af-43a5-a9ce-8ef5794ceee7?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Key Item** | Duct Tape | A HUD message informs the player they can blow up the cabin using the stove if they duct tape the buttons of the stove. |
| **Interact Text** | I’ve got duct tape. | Prompts the player to give the duct tape to the button. |
| **Missing Items** | Looks like I need some duct tape. | Informs the player they’re missing a key item. |
| **Disable After Use** | Yes | There’s no need to interact with this device further. |
| **Visible During Game** | No | To feel real, the button must be invisible. |
| **Score on Key Item Consumed** | 35 | Reward the player for finding and using the duct tape. |

### Mutator Zone

[![Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/c7a8d267-bc59-4d9c-ad6a-4cfffa6adf72?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c7a8d267-bc59-4d9c-ad6a-4cfffa6adf72?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Zone Width** | 0.35 | You only want to surround the stove with the Mutator Zone. |
| **Zone Depth** | 0.35 | You only want to surround the stove with the Mutator Zone. |
| **Zone Height** | 0.5 | It only needs to be as tall as a play character |
| **Affects Creatures** | No | There are no creatures to affect. |
| **Affects Guards** | No | There are no guards to affect. |
| **Allow Editing** | No | There’s no building in the game. |
| **Allow Jumping** | No | Jumping is not necessary in this zone. |
| **Enable VFX** | No | There is no need for VFX. |
| **Allow Building** | No | There’s no building in the game. |
| **Override All Movement Bonuses at Zero** | No | This option isn’t necessary. |
| **Allow Map Marker** | No | There’s no need to mark where the player is in this zone. |
| **Allow Emote Wheel** | No | There’s no need to emote in this zone. |

## Explosive

[![Explosive](https://dev.epicgames.com/community/api/documentation/image/ee7a3210-b89a-4fbd-adf8-a8a05eb7ce94?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee7a3210-b89a-4fbd-adf8-a8a05eb7ce94?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Can Be Damaged** | No | Players should not be able to damage this device. |
| **Player Damage** | 0.0 | This should damage the cabin only. |
| **Structure Damage** | 3000 | The cabin should take a large amount of damage. |
| **Visible During Game** | No | The explosion is supposed to look like it’s coming from the stove. |
| **Collision During Games** | Off | Collision isn’t necessary. |
| **Show Health Bar** | No | The health bar isn’t necessary. |

### Timed Objective

[![Timed Objective](https://dev.epicgames.com/community/api/documentation/image/b2b09632-e165-49f0-83fe-d5dc19a98235?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b2b09632-e165-49f0-83fe-d5dc19a98235?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Time** | 180 | Gives the player 2 minutes until the cabin explodes. |
| **Hologram Until Activated** | No | The stove is supposed to be the object that destroys the cabin. |
| **Visible During Game** | No | The stove is supposed to be the object that destroys the cabin. |
| **Countdown Visible** | No | This HUD element has been turned off. |
| **Urgency Mode** | No | This isn’t necessary for the game. |
| **Audio Effects** | No | The music from the Audio device is the only audio the player should be hearing. |
| **Deactivation Sound** | No | The device should not be making noise. |
| **Completion Sounds** | No | The device should not be making noise. |

### Fire Volume

[![Fire Volume](https://dev.epicgames.com/community/api/documentation/image/ff6e65c6-ce31-4316-bd6c-723ff919c77d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ff6e65c6-ce31-4316-bd6c-723ff919c77d?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Zone Width** | 1.5 | Covers the kitchen area. |
| **Zone Depth** | 2.0 | Covers the kitchen area. |
| **Zone Height** | 0.8 | Covers the kitchen area. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Timed Objective** | Enabled | **See Truck Mutator Zone** | On Player Entering Zone | Enables the Timed Objective device to start when activated. |
| [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/311b397e-fbe5-441e-9663-66eb6b6b14d4?resizing_type=fit) |  | [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/9a79b2ec-2d4a-4ac8-a97a-d6d9680723cd?resizing_type=fit) |  |  |
| **Timed Objective** | Start | **Conditional Button** | On Activated | Starts the 2 minute countdown until the explosion. |
| [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/21b43843-0081-46aa-ad5d-c33bd25ccf48?resizing_type=fit) |  | [Conditional Button](https://dev.epicgames.com/community/api/documentation/image/ed5f6efe-98fe-4c75-9f02-58d547a8ca03?resizing_type=fit) |  |  |
| **Timed Objective** | Pause | **Kidnapper Returns Trigger** | On Triggered | Stops the Timed Objective from making noise during the Kidnapper Returns Cinematic Sequence. |
| [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/a0b6cc28-c789-44ba-8f94-0338084400d3?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/bf702ace-5f72-4575-a02e-c4050ee25c28?resizing_type=fit) |  |  |
| **Timed Objective** | Restart | **Fight Trigger** | On Device Sees A Player | Starts the Timed Objective count down again. |
| [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/b0db441e-e9ae-4c57-9bf5-1988b7b41246?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/901c4487-575b-4a81-9514-205e0338372c?resizing_type=fit) |  |  |
| **Explosive** | Explode | **Timed Objective** | On Completed | Blows up the cabin. |
| [Explosive](https://dev.epicgames.com/community/api/documentation/image/9b25f061-1948-407a-a14a-0c75992b26e0?resizing_type=fit) |  | [Timed Objective](https://dev.epicgames.com/community/api/documentation/image/4427c4fb-60eb-43dd-85d1-6061b36db737?resizing_type=fit) |  |  |
| **Fire Volume** | Ignite | **Explosive** | On Exploded | Adds fire to the explosion to make it look more realistic. |
| [Fire Volume](https://dev.epicgames.com/community/api/documentation/image/151ed47f-b2e2-479d-9dab-9e25cf845b5e?resizing_type=fit) |  | [Explosive](https://dev.epicgames.com/community/api/documentation/image/898d021f-90f3-4a81-af51-1347bcd4f5f6?resizing_type=fit) |  |  |

## Final Fight Device

[![Sentry waiting for final fight.](https://dev.epicgames.com/community/api/documentation/image/da9f95ca-00d8-49bc-8a14-3b7a449fb3a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da9f95ca-00d8-49bc-8a14-3b7a449fb3a9?resizing_type=fit)

This device becomes active after the Kidnapper Returns cut scene plays. The player must defeat this final boss to escape the cabin and win the game.

To make the ending of the game more exciting, design a custom boss fight with third-party custom assets.

### Sentry

[![Sentry Device](https://dev.epicgames.com/community/api/documentation/image/fcc8871c-3208-421f-a220-b13f87a2a52d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fcc8871c-3208-421f-a220-b13f87a2a52d?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Sentry Health** | 5000 | The sentry should offer an obstacle, but not be difficult to beat. |
| **Range** | 10.0 | You want the player to walk out of the bedroom and be startled by the Sentry. |
| **Accuracy** | Moderate | Makes the sentry pretty accurate, but enables the player to get good shots in. |
| **Show Visualization Range** | False | This is unnecessary. |
| **Use Line of Sight** | False | This allows the sentry to detect the player in the bedroom without them being in the sentry's line of sight. |
| **Spawn on Game Start** | False | The sentry spawns when the player steps on the Kidnapper Returns Trigger. |
| **Score on Elimination** | 150 | Reward the player generously for eliminating the sentry. |
| **Show Alert Icon** | False | This is unnecessary. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Sentry** | Enable | **Kidnapper Returns Cut scene Trigger** | On Triggered | Spawns the Sentry for the final fight. |
| [Sentry](https://dev.epicgames.com/community/api/documentation/image/7bddb632-8e22-4511-8062-f0bf20e45630?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/7584ffc7-99e4-4d5f-b1ca-adceffb7bb08?resizing_type=fit) |  |  |
| **Sentry** | Spawn | **Truck Key Item Placer** | On Item Granted | The Sentry begins looking for enemies and starts shooting at the player when they enter the sentry's range. |
| [Sentry](https://dev.epicgames.com/community/api/documentation/image/c20b1f0b-437e-475c-bd23-ccb861a02c65?resizing_type=fit) |  | [Item Placer](https://dev.epicgames.com/community/api/documentation/image/67cfa38f-00ba-4898-9f55-3f251354d21f?resizing_type=fit) |  |  |

## Next Section

[![10. Verse Switch State Puzzle](https://dev.epicgames.com/community/api/documentation/image/5d6dc66d-2feb-40d8-aa29-9c95da0ceb0a?resizing_type=fit&width=640&height=640)

10. Verse Switch State Puzzle

Create a simple switch state puzzle you can copy or make your own.](https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-10-verse-switch-state-puzzle-in-unreal-editor-for-fortnite)
