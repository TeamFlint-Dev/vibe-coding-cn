# 8. Outside Cabin

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-08-outside-cabin-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:17:49.033416

---

The visual aesthetic of the outdoors should be eerie and laden with fog. This should make the cabin and the surrounding area feel ominous and foreboding.

Outside the cabin place the barrier device and make sure to include the sub basement in the depth, otherwise players may not be able to leave the basement. Afterwards, get the other devices you’ll need and set them up in a place that you can organize them.

In the front of the cabin around the Pickup Truck Spawner, you need to set up Mutator Zones, HUD Messages, and Triggers to prompt players into performing certain actions for the truck, like getting gas and searching for the key.

You will also need to set up the cabin door with a Conditional Button, Lock, Audio Player, and End Game devices.

[![An example of how the devices are arranged outside the cabin.](https://dev.epicgames.com/community/api/documentation/image/d21bfd80-f390-49ab-a9de-c7a9bea1c49d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d21bfd80-f390-49ab-a9de-c7a9bea1c49d?resizing_type=fit)

**Devices Used:**

- **4 x** [**Mutator Zone**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-mutator-zone-devices-in-fortnite-creative)
- **2 x** [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite)
- **3 x** [**HUD Message**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative)
- **1 x** [**Pickup Truck Spawner**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-pickup-truck-spawner-devices-in-fortnite-creative)
- **1 x** [**Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative)
- **1 x** [**End Game**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-end-game-devices-in-fortnite-creative)
- **1 x** [**Barrier**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-barrier-devices-in-fortnite-creative)
- **1 x** [Audio Player](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-unreal-editor-for-fortnite)
- **1 x** [**HUD Controller**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-controller-devices-in-fortnite-creative)
- **1 x** [Day Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-day-sequence-devices-in-unreal-editor-for-fortnite)
- **6 x** [**VFX Spawner**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-vfx-spawner-devices-in-fortnite-creative)
- **1 x** [**Lock**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-lock-devices-in-fortnite-creative)
- **1 x** [**Conditional Button**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-conditional-button-devices-in-fortnite-creative)

## Kidnapper Leaves Durr Burger

[![Place this Mutator Zone at the top of the stairs leading out of the basement.](https://dev.epicgames.com/community/api/documentation/image/4173a366-6992-4dbf-a602-b5f7d368b727?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4173a366-6992-4dbf-a602-b5f7d368b727?resizing_type=fit)

Add to the suspense of the game with a cut scene showing the captor returning to the house from the Durr Burger.

### Mutator Zone 1 - 4

[![Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/91a5893a-0e94-4c4a-b375-9615257cf354?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/91a5893a-0e94-4c4a-b375-9615257cf354?resizing_type=fit)

Rename the Mutator Zones so it’s easier to tell them apart. The Mutator Zones were renamed to:

- Escape Basement Mutator Zone
- See Truck Mutator Zone
- Add Gas Mutator Zone
- Need Key Mutator Zone

| Option | Value | Explanation |
| --- | --- | --- |
| **Allow Editing** | No | Players should not be allowed to edit during gameplay. |
| **Enable VFX** | No | VFX are not necessary. |
| **Allow Building** | No | Players should not be allowed to build during gameplay. |
| **Override All Movement Bonuses at Zero** | No | This setting isn’t necessary. |
| **Zone Shape** | Cylinder | This should be enough to encompass the player leaving the basement. |
| **Zone Width** | - Escape Basement Mutator Zone - **0.5** - See Truck Mutator Zone - **5.5** - Add Gas Mutator Zone - **2.0** - End Game Mutator Zone - **16.00** - Missing Key Mutator Zone - **0.5** | See Escape Basement Mutator Zone:   - The zone needs to fit around the space that the player escapes the basement from.   See Truck   - This needs to be wide enough to trigger the HUD Message on both sides of the cabin.   Add Gas Mutator Zone:   - This is smaller so the HUD Messages appear only when the player approaches the vehicle.   Missing Key Mutator Zone:   - Needs to only cover the player getting into the truck. |
| **Zone Depth** | - Escape Basement Mutator Zone - **1.0** - See Truck Mutator Zone - **2.5** - Add Gas Mutator Zone - **1.0** - Missing Key Mutator Zone - **0.5** | See Escape Basement Mutator Zone:   - Covers the hole in the ceiling the player escapes from.   See Truck   - Deep enough to trigger the HUD Message on both sides of the cabin.   Add Gas Mutator Zone:   - Deep enough to trigger the HUD Messages.   Missing Key Mutator Zone:   - Large enough to cover the player getting into the truck. |
| **Zone Height** | - Escape Basement Mutator Zone - **0.5** - See Truck Mutator Zone - **0.5** - Add Gas Mutator Zone - **1.0** - Missing Key Mutator Zone - **0.5** | The Mutator Zones must only be triggered while the player is above ground. The last two Mutator Zones account for the player being in the truck. |
| **Allow Map Marker** | No | There is no map to mark. |
| **Allow Emote Wheel** | No | There s no reason for a player to emote here. |

### Cinematic Sequence 1 & 2

[![Cinematic Sequence](https://dev.epicgames.com/community/api/documentation/image/d109931a-fbc9-427b-9482-f9e302fd97b9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d109931a-fbc9-427b-9482-f9e302fd97b9?resizing_type=fit)

Rename the Cinematic Sequence devices to make it easier to tell them apart. These devices were renamed:

- Bad Guy Leaves Durr Burger Cinematic
- Ending Cinematic Sequence Device

| Option | Value | Explanation |
| --- | --- | --- |
| **Sequence** | Add your sequences here. | Each device should have a matching sequence that plays when the player reaches the bedroom inside the cabin, and when the game ends. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Bad Guy Leasves Durr Burger Cinemtaic** | Play Function | **Escape Basement Mutator Zone** | On Player Entering the Zone | Plays a cinematic where the player sees the bad guy returning to the cabin. |
| [Cinematic Sequence](https://dev.epicgames.com/community/api/documentation/image/edf41662-098d-417e-90e2-6403b2dc0120?resizing_type=fit) |  | [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/b42be972-75c8-4d92-b290-2aa0a2fe7459?resizing_type=fit) |  |  |
| **Ending Cinemtaic Sequence Device** | Play Function | **Truck Trigger** | On Triggered | Plays a cinematic where the player sees the bad guy returning to the cabin. |
| [Cinematic Sequence](https://dev.epicgames.com/community/api/documentation/image/6aec3563-796b-44a2-8a91-9545c75f94e7?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/baa185f7-0627-4caa-bbcc-d272d0571c78?resizing_type=fit) |  |  |

## Setting Up the Truck Interactions

[![Set up the devices to let players know what to do with the truck.](https://dev.epicgames.com/community/api/documentation/image/4a331232-74ee-4650-8834-a73aa7f299b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4a331232-74ee-4650-8834-a73aa7f299b2?resizing_type=fit)

There are a series of devices you’ll use to prompt the player to act to get the truck ready for escape. These prompts include the use of Mutator Zones and HUD Messages. You’ll also want to set up devices for the end sequence when the player drives the truck away from the cabin.

### HUD Message 1 - 3

[![HUD Message](https://dev.epicgames.com/community/api/documentation/image/009ac9f1-c742-4d81-9a1c-ae1ea823e6b5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/009ac9f1-c742-4d81-9a1c-ae1ea823e6b5?resizing_type=fit)

Rename the HUD Message devices so you can easily tell them apart. In this example the devices were named:

- See Truck HUD Message
- Gas HUD Message
- Missing Key HUD Message

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | See Truck HUD Message:   - A Bear truck! I can escape!   Gas HUD Message:   - Oh no! The tank is empty! Hmmm… did I see a gas can in the basement?   Missing Key HUD Message:   - Truck's not gonna start without a key! It must be in the house somewhere. | The dialogue is meant to sound like inner thoughts and also prompt the player to act. |
| **Display Time** | - See Truck HUD Message - 2.0 - Gas HUD Message - **5.0** - Missing Key HUD Message - **3.0** | Messages that prompt the player to action should display longer. Messages that provide information can display for less time. |
| **Layer** | See Truck - 0  Gas HUD Message - 0  Missing Key HUD Message - 1 | All messages use the same layer to stagger their messages. |
| **Priority** | See Truck HUD Message - **1**  Gas HUD Message - **2**  Missing Key HUD Message - **1** | The **See Truck HUD Message** and the **Gas HUD Messages** need to stagger. The **Missing Key HUD Message** isn’t grouped and can display for a second longer than the **See Truck HUD Message**. |
| **Allow Multiple in Queue** | Yes | This only applies to the **See Truck HUD Message** and the **Gas HUD Messages**. |
| **QueueTimeout** | True, 5 | This option needs to be set on the **Gas HUD Message device**. Turn on the option and set to 7 so the last message about the gas has time to display. |

### Pickup Truck Spawner

[![Pickup Truck Spawner](https://dev.epicgames.com/community/api/documentation/image/1b06ece4-8e62-4e64-a1d9-77cad6fa6c4c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1b06ece4-8e62-4e64-a1d9-77cad6fa6c4c?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Fuel Consumption** | Yes | The truck should use fuel to make it feel more realistic. |
| **Starting Fuel** | 0 | The truck needs to be empty to cause the player to look for gas. |
| **Radio Enabled** | No | Ambient music is played during gameplay using Audio Player devices. |
| **Color and Style** | Hit the Road | The truck should look old and used. |
| **Random Starting Fuel** | No | The starting amount of fuel is already set. |
| **Enable Respawn** | No | The truck should not respawn. |
| **Destroy Truck when Disabled** | No | The truck should remain intact even when disabled. |
| **Allowed Class** | Class Slot - 1 | The player needs a class to cause the truck to start and drive once they pick up the key. |
| **Boost Enabled** | No | The truck should not use boost in this game. |

### Trigger

[![Trigger](https://dev.epicgames.com/community/api/documentation/image/dfb4267f-9c1d-4599-9b07-ee4690b1496e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dfb4267f-9c1d-4599-9b07-ee4690b1496e?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Games** | No | The trigger doesn't need to be visible during gameplay, set this to **No**. |
| **Triggered by Sequencers** | No | Only the player should be able to set off this device. |
| **Triggered by Water** | No | Only the player should be able to set off this device. |
| **Trigger VFX** | No | No VFX are necessary. |
| **Trigger SFX** | No | No SFX are necessary. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Ending Cinematic Sequence** | Play Function | **Truck Trigger** | On Triggered | When the player drives the truck over the trigger, the trigger signals the camera to record the player driving away. |
| [Cinematic Sequence](https://dev.epicgames.com/community/api/documentation/image/0a5c40b6-04fd-4fe3-b0e0-28e9123d1bf4?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/07c94bfe-2bb4-4f6e-b63b-feefb94e38a0?resizing_type=fit) |  |  |
| **See Truck Mutator Zone** | Disable | **Add Gas Mutator Zone** | On Player Entering Zone | To stop the HUD Messages from overlapping and showing multiple times, disable the Mutator Zones you no longer need. |
| [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/fd9999ee-ea04-4109-86d4-73670591886e?resizing_type=fit) |  | [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/e4132f16-4a0d-473d-aef8-7c96074059c7?resizing_type=fit) |  |  |
| **Add Gas Mutator Zone** | Disable | **Need Key Mutator Zne** | On Player Entering Zone | To stop the HUD Message from showing multiple times, disable the Mutator Zones you no longer need. |
| [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/ac24dcdf-708f-4918-a461-43555b643f2e?resizing_type=fit) |  | [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/9d440c35-e92c-4512-998a-8a45125620d1?resizing_type=fit) |  |  |
| **See Truck HUD Message** | Show | **See Truck Mutator Zone** | On Player Entering Zone | Informs the player that there is a truck they can use to escape. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/7862055d-81b5-43f1-8ec7-b05e6565a388?resizing_type=fit) |  | [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/301b7e72-49f8-4dd9-a8a6-5dbff22297f7?resizing_type=fit) |  |  |
| **See Truck HUD Message** | Hide | **Add Gas Mutator Zone** | On Player Entering Zone | Hides the message so the add gas message can display from the next HUD Message device. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/9a6de47f-5e52-462b-99b7-508e776491c2?resizing_type=fit) |  | [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/b7d3c1c6-d402-45b9-b240-d0a2ac0dabf9?resizing_type=fit) |  |  |
| **Gas HUD Message** | Show | **Add Gas Mutator Zone** | On Player Entering Zone | Informs the player they can’t drive the truck without gas and causes the player to search for gas. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/e6239155-4808-4cf5-b392-59de4521029b?resizing_type=fit) |  | [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/54eb2314-c515-47b6-a1f6-654debbd017f?resizing_type=fit) |  |  |
| **Gas HUD Message** | Hide | **Add Gas Mutator Zone** | On Player Entering Zone | You don't need the see truck or need gas mesasges to display more than once. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/5d72ad67-d199-4fd7-9ee9-cc9cf000fa18?resizing_type=fit) |  | [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/65fb149c-f94a-4e03-b303-d585f35c62e6?resizing_type=fit) |  |  |
| **Gas HUD Message** | Clear Layer | **Gas Can Item Spawner** | On Item Pick Up | Once the player picks up the gas can there's no more need to show the gas message. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/597ace7b-4475-4f33-bf67-e685175b850f?resizing_type=fit) |  | [Item Spawner](https://dev.epicgames.com/community/api/documentation/image/af57a4d5-b3a2-424b-8d6a-65ddcf4dda90?resizing_type=fit) |  |  |
| **Missing Key HUD Message** | Show | **Pickup Truck Spawner** | On Player Enters Vehicle | Lets the player know they can’t escape until they have the key and causes the player to enter the cabin. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/6bbb0230-5d72-468c-ab8c-1813868ebedc?resizing_type=fit) |  | [Pickup Truck Spawner](https://dev.epicgames.com/community/api/documentation/image/99426563-312f-411c-a4b6-c71e8f5741b0?resizing_type=fit) |  |  |
| **Missing Key HUD Message** | Hide | **KidnapperReturns Cut scene Trigger** | On Triggered | Once the player opens the door to the rook with the truck key the player no longer needs to see the message. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/1aed10dc-b4c4-49ca-9b18-28e0bc70ff74?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/99be2838-2ba9-48e4-9b41-3cd6023f63d2?resizing_type=fit) |  |  |
| **Missing Key HUD Message** | Clear Layer | **Truck Key Item Placer** | On Granted Item | Stops the message from displaying again. |
| [HUD Message](https://dev.epicgames.com/community/api/documentation/image/a3e5cabf-e8a3-4ff8-8322-819e9592d67e?resizing_type=fit) |  | [Item Placer](https://dev.epicgames.com/community/api/documentation/image/2a666e4f-97fc-43db-9776-235dc647ddaa?resizing_type=fit) |  |  |
| **Trigger** | Enable | **Sentry** | On Attacking | Turn the trigger on so when the player runs it over, the End game device can be triggered and end the game. |
| [Trigger](https://dev.epicgames.com/community/api/documentation/image/6e59c8bc-12cb-46ac-bbd8-cb092a549475?resizing_type=fit) |  | [Sentry](https://dev.epicgames.com/community/api/documentation/image/fc895753-8f00-46f2-9038-d772d2aa5b04?resizing_type=fit) |  |  |
| **Trigger** | Enable | **Pickup Truck Spawner** | On Player Enters Vehicle | Once the player enters the truck with the key the game is over and the final cinematic plays. |

### End Game

[![End Game](https://dev.epicgames.com/community/api/documentation/image/1efcb7c2-7502-4f1a-94e9-1fa431a316bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1efcb7c2-7502-4f1a-94e9-1fa431a316bc?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Custom Victory Callout** | I did it! I’m getting away! | Let the play know the game is over. |

### Cinematic Sequence

[![Cinematic Sequence](https://dev.epicgames.com/community/api/documentation/image/b16c0300-5eec-4b12-a2ee-fa2ee7c3b2a3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b16c0300-5eec-4b12-a2ee-fa2ee7c3b2a3?resizing_type=fit)

Rename the Cinematic Sequence devices to make it easier to tell them apart. These devices were renamed to:

- Ending Cinematic Sequence

| Option | Value | Explanation |
| --- | --- | --- |
| **Sequence** | Add your sequences here. | Each device should have a matching sequence that plays when the game begins, the player reaches the bedroom inside the cabin, and when the game ends. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **End Game** | Activate | **Ending Cinematic Sequence Device** | On Stopped | The game ends when the last cinematic is finished playing. |
| [End Game](https://dev.epicgames.com/community/api/documentation/image/4842538d-6ded-422b-864e-8ca314342d8d?resizing_type=fit) |  | [Mutator Zone](https://dev.epicgames.com/community/api/documentation/image/e5966dcd-c68e-4ee9-8d6b-66becf664cce?resizing_type=fit) |  |  |
| **Ending Cinematic Sequence** | Play Function | **Truck Trigger** | On Triggered | When the player drives the truck over the trigger, the trigger signals the camera to record the player driving away. |
| [Cinematic Sequence](https://dev.epicgames.com/community/api/documentation/image/442adf7a-a833-48e1-a587-1736569722a4?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/d4899751-b0d5-4169-9a59-a8b610ea93eb?resizing_type=fit) |  |  |

## Setting Up Environmental Devices

[![Use these devices to set up the environment and boundaries.](https://dev.epicgames.com/community/api/documentation/image/90721d2f-f903-4ef1-bd6b-97c5422e78f1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/90721d2f-f903-4ef1-bd6b-97c5422e78f1?resizing_type=fit)

These devices determine environmental aspects of the game from the time of day, where players can explore, to the sounds the player hears.

### Barrier

[![Barrier](https://dev.epicgames.com/community/api/documentation/image/12aee18c-debb-4cc3-ac6d-a136aac95a88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12aee18c-debb-4cc3-ac6d-a136aac95a88?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Barrier Material** | Light\_Shaft\_Mat | A material created that is see through. |
| **Barrier Depth** | 24.0 | The barrier must be deep enough to encompass the area around the cabin. |
| **Barrier Width** | 16.0 | Create a barrier that allows the player to explore without getting lost. |
| **Barrier Height** | 10.00 | The barrier must be tall enough to encompass the basement and sub basement areas. |
| **Enabled on Phase** | Always | The barrier should always be available during the game. |
| **Zone Shape** | Hollow Box | Allows the player to move around inside the barrier zone. |
| **Block Weapon Fire** | No | There’s no reason to block weapon fire. |

### Audio Player

[![Audio Player](https://dev.epicgames.com/community/api/documentation/image/a939b9e6-828d-4dd8-83a1-7409d4120d29?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a939b9e6-828d-4dd8-83a1-7409d4120d29?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Audio** | MX\_SurvivalHorror\_Graveyard\_Loop\_Cue | When the player sees the kidnapper returns cut scene the music changes to this sound cue. |

### HUD Controller

[![HUD Controller](https://dev.epicgames.com/community/api/documentation/image/3e93ffda-1d5a-4782-ad2f-7ef4495b6f78?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e93ffda-1d5a-4782-ad2f-7ef4495b6f78?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Show Minimap** | No | The minimap isn’t necessary for this game. |
| **Show HUDInfo Box** | No | This information isn’t necessary. |
| **Show Build Menu** | No | This information isn’t necessary. |
| **Show Player Inventory** | Yes | The player should see what’s in their inventory. |
| **Show Wood Resources** | No | This information isn’t necessary. |
| **Show Stone Resources** | No | This information isn’t necessary. |
| **Show Metal Resources** | No | This information isn’t necessary. |
| **Show Gold Resources** | No | This information isn’t necessary. |
| **Show Map Scoreboard** | No | This information isn’t necessary. |
| **Show Storm Timer** | No | This information isn’t necessary. |
| **Show Player Count** | No | This information isn’t necessary. |
| **Show Elimination Counter** | No | This information isn’t necessary. |
| **Show Round Timer** | No | This information isn’t necessary. |
| **Show Round Details** | No | This information isn’t necessary. |
| **Show Team Info** | No | This information isn’t necessary. |
| **Show Damage Numbers** | No | This information isn’t necessary. |
| **Show Health Numbers** | No | This information isn’t necessary. |
| **Show Shields** | No | This information isn’t necessary. |
| **Show Shield Numbers** | No | This information isn’t necessary. |
| **Show Battle Pass UI** | No | This information isn’t necessary. |
| **Show Crafting Resources** | No | This information isn’t necessary. |
| **Show Storm Notifications** | No | This information isn’t necessary. |

### Day Sequence

[![Day Sequence](https://dev.epicgames.com/community/api/documentation/image/7b66a9a0-960b-4638-84c0-f96ef5066781?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7b66a9a0-960b-4638-84c0-f96ef5066781?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Day/night Cycle** | 18.00 | Sets the game to 6pm. |
| **Priority** | 1000 | This ensures the Day Sequence device takes priority over default lighting settings. |
| **Trigger Volume** | Yes | Adds a Post Process volume for the Day Sequence device. |
| **Extent X** | 0.5 | Blends the sky of the Day Sequence device with the default by 50%. |
| **Extent Y** | 0.5 | Blends the sky of the Day Sequence device with the default by 50%. |
| **Extent Z** | 0.5 | Blends the sky of the Day Sequence device with the default by 50%. |
| **Sunlight** | Yes | Adds sunlight to the outdoor scene. |
| **Intensity** | 0.2 | Creates a 20% sunlight intensity. |
| **Enable Lens Flare** | No | There won’t be a need for a lens flare because it’s nighttime. |
| **Fog** | Yes | Creates more cloud cover in the sky. |
| **Density** | 0.45 | Gives you 45% fog cover in the sky. |
| **Height Falloff** | 0.25 | Causes the fog to fall off at a rate of 25%. |
| **Skylight** | Yes | Adds atmospheric lighting to the project. |
| **Intensity** | 0.5 | Gives the atmospheric lighting 50% intensity. |
| **Sky** | Yes | Provides a way to add the moon to the sky. |
| **Sun Intensity** | 0.5 | Gives the light coming from the sun a 50% intensity. |
| **Moon Size** | 1 | Creates a large moon on the sky. |
| **Moon Intensity** | 0.5 | The light coming from the moon has a 50% intensity. |
| **Star Brightness** | 13 | Enables the stars in the sky to be visible with varying light intensity. |
| **Clouds** | Yes | Provides a way to add mroe cloud coverage to the sky. |
| **Speed** | 5.0 | Makes the clouds move at a speed of 5 kilometers per second. |

### Visual Effect Spawner

Place one VFX Spawner, then change it’s properties. Afterward, copy and paste the VFX Spawner around the barrier perimeter to create a foggy landscape.

[![Visual Effects Spawner](https://dev.epicgames.com/community/api/documentation/image/d887b20b-fadb-456f-be57-b479eda0bcdb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d887b20b-fadb-456f-be57-b479eda0bcdb?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visual Effect** | Light Fog | Creates fog for your outdoors. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Audio Player** | Play | **Trigger** | On Triggered | Starts the new music playing during the kidnapper returns cut scene and turns off the other Audio Player. |
| [Audio Plaeyer](https://dev.epicgames.com/community/api/documentation/image/21f6c943-bf07-42ae-9936-2944b86177c0?resizing_type=fit) |  | [Trigger](https://dev.epicgames.com/community/api/documentation/image/ae4cf1fc-9394-4ed0-84ca-339af05a49b8?resizing_type=fit) |  |  |
| **Day Sequence** | Enable | **Player Spawner** | On Player Spawned | Enables the device to use the lighting setup in the project. |
| [Day Sequence](https://dev.epicgames.com/community/api/documentation/image/7da87fa1-8e96-4858-9ebd-707034312f0d?resizing_type=fit) |  | [Player Spawner](https://dev.epicgames.com/community/api/documentation/image/debb2812-544c-4033-9fd3-6f71b8833598?resizing_type=fit) |  |  |

## Creating an Obstacle

[![The cabin door with the lock and conditional button devices.](https://dev.epicgames.com/community/api/documentation/image/e4ab1e36-020b-4ff3-ac11-641359489a77?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e4ab1e36-020b-4ff3-ac11-641359489a77?resizing_type=fit)

Locking the front door to the cabin and causing the player to double back and look for the key to the cabin adds to the suspense and urgency to get inside the cabin. Lock the front door with a Lock device and let the player know they're missing a key to the door with a Conditional Button device.

### Lock

[![](https://dev.epicgames.com/community/api/documentation/image/86b814a1-0277-4afb-9413-84e25344713f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/86b814a1-0277-4afb-9413-84e25344713f?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible in Game** | No | The door acts as another obstacle to the player's freedom. |

### Conditional Button

[![](https://dev.epicgames.com/community/api/documentation/image/0871b450-489a-4b56-af8b-1d87d6b93e22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0871b450-489a-4b56-af8b-1d87d6b93e22?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Key Item** | Key | Causes the player to double back into the basement to search for the key to the cabin door. |
| **Interact Text** | I have the key to the cabin. | Let's the player know they have the right key for the door. |
| **Missing Items Text** | I need a key to the cabin. | Let's the play know they need a key to enter the cabin. |
| **Disable After Use** | Yes | There's no reason to use this devcie again once the key has been consumed by the device. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Lock** | Unlock | **Conditional Button** | On Activated | Unlocks the door when the key is given to the conditional button. |
| [Lock](https://dev.epicgames.com/community/api/documentation/image/1927b216-4af2-4853-aaf9-de6cdaa7b683?resizing_type=fit) |  | [Conditional Button](https://dev.epicgames.com/community/api/documentation/image/50cc89a0-1a78-42f0-b68c-c0094eefe71d?resizing_type=fit) |  |  |
| **Lock** | Open | **Conditional Button** | On Activated | Opens the door for the player to enter the cabin. |
| [Lock](https://dev.epicgames.com/community/api/documentation/image/2beca205-0ffd-4139-bbff-bce74c84a132?resizing_type=fit) |  | [Conditional Button](https://dev.epicgames.com/community/api/documentation/image/0ef7ddb8-b903-499f-af2b-6e80ca6b5e36?resizing_type=fit) |  |  |

## Next Section

[![9. Inside Cabin](https://dev.epicgames.com/community/api/documentation/image/54b47813-ab9a-4b1f-9f7a-9055ea2010a4?resizing_type=fit&width=640&height=640)

1. Inside Cabin

Create an explosive ending to the island inside the cabin.](<https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-09-inside-cabin-in-unreal-editor-for-fortnite>)
