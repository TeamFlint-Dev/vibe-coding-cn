# Lock Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/lock-device-design-examples
> **爬取时间**: 2025-12-26T23:03:41.829635

---

You can use the **Lock** device to customize the state and accessibility of a door. Locking and unlocking can be triggered by player actions or by other devices.

This device only works with assets that have a door or gate attached.

## Locking a Door

The most basic use for the Lock device is — you guessed it — locking a door!

Connect the lock to a **Button** device for easy toggling between locked and unlocked states.ndefined

### Devices Used

- 1 x [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) device

### Set Up the Devices

1. Place the **Brick House** [prefab](https://dev.epicgames.com/documentation/en-us/fortnite/using-prefabs-and-galleries-in-fortnite-creative).
2. Place a **Player Spawner** device in front of the door.
3. Place a **Lock** device on the door panel. Make sure the light on the lock is blue, which indicates that it is connected to the door.
4. Place a **Button** device next to the door.
5. Customize the button as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/13e69eec-d615-4055-9d70-8949270f0980?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13e69eec-d615-4055-9d70-8949270f0980?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Interaction Text | Toggle Lock |
6. Configure the following event on the button so that it toggles the lock when pressed.

   [![](https://dev.epicgames.com/community/api/documentation/image/e8e4e4e3-f1df-45bf-9e74-3bae67d1f100?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8e4e4e3-f1df-45bf-9e74-3bae67d1f100?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Interact | Lock Device | Toggle Locked |

You now have the basic functionality for a locking door!

### Design Tip

The Lock device can very easily be connected to a Conditional Button device to give the added requirement that aplayer possess the correct key. The key can be anything: an actual key, a specific weapon, a fish, or anything else you can imagine.

## Escape Room Exit

Locks are a core part of any escape room or puzzle game where players must solve a puzzle to get out of an area. In this example, you’ll set up a basic puzzle that unlocks the player’s exit when solved.

### Devices Used

- 1 x **Lock** device
- 1 x **Player Spawner** device
- 1 x [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative) device
- 1 x [Audio Player](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-fortnite-creative) device
- 4 x [Switch](https://dev.epicgames.com/documentation/en-us/fortnite/using-switch-devices-in-fortnite-creative) devices

### Set Up the Play Area

1. Place the **Castle Cellar** prefab.
2. Place a **Player Spawner** device inside the building.
3. Customize the player spawner to **not be visible in-game**:

   [![](https://dev.epicgames.com/community/api/documentation/image/1d9b23b1-182b-46b2-bc18-31d090c2a646?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d9b23b1-182b-46b2-bc18-31d090c2a646?resizing_type=fit)
4. Place a lock on each of the two doors leading outside.
5. Place a **HUD Message** device.
6. Customize the HUD message:

   [![](https://dev.epicgames.com/community/api/documentation/image/511e8f74-09bb-4015-af4d-0b4b27a0541c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/511e8f74-09bb-4015-af4d-0b4b27a0541c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Message | Flip all three levers to escape! |
   | Show on Round Start | On |
   | Time from Round Start | Instant |
   | Text Color | White |
7. Place an **Audio Player** device. (In later steps, you will configure this to play a sound effect when the puzzle is completed.)
8. Customize the audio player:

   [![](https://dev.epicgames.com/community/api/documentation/image/bc6e2373-a3cf-4fa7-8562-470142440981?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bc6e2373-a3cf-4fa7-8562-470142440981?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Enable Spatialization | Off | Makes sure the audio pan is equal regardless of where the player is. |
   | Enable Volume Attenuation | Off | Makes sure the audio volume is equal regardless of where the player is. |

### Configure the Switch System

Next, you’ll set up a basic logic system that will be able to tell whether all of the puzzle switches are on or not.

1. Place a **Switch** device. This will be the **master switch**.
2. Customize the switch:

   [![](https://dev.epicgames.com/community/api/documentation/image/9bfb5557-c411-4f2e-bc08-0de2881ff6dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9bfb5557-c411-4f2e-bc08-0de2881ff6dd?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Visible During Game | No |
   | Sound | Disabled |
   | Allow Interaction | No |
3. Place another switch. This will be the first of the **puzzle switches**. Customize the puzzle switch as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/e90751e2-e9dc-4743-aef4-5222e3e95a91?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e90751e2-e9dc-4743-aef4-5222e3e95a91?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Device Model | Ancient Lever |
4. Configure the following event on the puzzle switch so that the switch forces the master switch to match its value. (You will configure the master switch to check each puzzle switch in a future step. For now, the puzzle switch will turn the master switch **Off** when checked.)

   [![](https://dev.epicgames.com/community/api/documentation/image/57e70806-2afa-408f-afc2-ce4fd0888929?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57e70806-2afa-408f-afc2-ce4fd0888929?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/e43a6e71-ca01-443e-a073-27db542dc0d1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e43a6e71-ca01-443e-a073-27db542dc0d1?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Turned Off | Master Switch | Turn Off |
   | On Check Result Off | Master Switch | Turn Off |
5. Configure the following event on the master switch so that when turned on, it checks the puzzle switch, unlocks the doors, and plays the audio player. When turned off, it will relock the doors and stop the audio player, which will keep everything working when the master switch is quickly turned on and off by the puzzle switches.

   [![](https://dev.epicgames.com/community/api/documentation/image/8517465d-1077-48ef-886e-b950e1fc1baf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8517465d-1077-48ef-886e-b950e1fc1baf?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/7e77e4fc-16bb-4fef-b252-d2652b174d99?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e77e4fc-16bb-4fef-b252-d2652b174d99?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Turned On | Lock Device 1-2 | Unlock |
   | On Turned On | Audio Player | Play |
   | On Turned Off | Lock Device 1-2 | Lock |
   | On Turned Off | Audio Player | Stop |
6. Duplicate the puzzle switch two more times and place them strategically around the building. Duplicating the device will ensure that they retain the correct direct event bindings.

You now have the basic functionality for an escape room using locks!

### Design Tip

To add some more tension to a puzzle like this, try giving the player some type of time limit. That could be as simple as a Timer that locks them inside permanently if they don’t complete the puzzle in a certain amount of time. Or, think of more creative ways to limit the player, like slowly doing damage to them while inside or filling the room up with water!

### Build a Door Parkour Game!

When combined with other devices like the Timer, the Lock device can produce very interesting results. In this example, you’ll create a parkour map using opening and closing doors as a primary mechanic!

### Devices Used

1. 8 x **Lock** devices
2. 1 x **Player Spawner** device
3. 1 x [Prop Mover](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative) device
4. 1 x [Bouncer Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/using-bouncer-gallery-devices-in-fortnite-creative) device
5. 1 x [Damage Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative) device
6. 1 x [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) device
7. 1 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) device
8. 1 x [End Game](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative) device

### Set Up Your Parkour Island

Begin by setting up your parkour island using floors from the **Colossal Coliseum Floor & Stair Gallery** and doors from the **Colossal Coliseum Wall Gallery**. While setting up the island, test out the jumps yourself to dial in the distances between objects! If you’re confused about how things should look, see the video above.

1. Place a floor floating high up in the air.
2. On the starting floor, place a Player Spawner.
3. Customize the Player Spawner so **Visible in Game** is set to **Off**

   [![](https://dev.epicgames.com/community/api/documentation/image/d66738a4-3042-4c4f-b267-58f607ef699d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d66738a4-3042-4c4f-b267-58f607ef699d?resizing_type=fit)
4. In front of the starting platform, place a few floors with doors on either side.
5. In front of this platform, place another floor up and slightly to the left.
6. Place a Prop Mover on this platform. Make sure that the device appears green while placing, which indicates that it is connected to the platform. Rotate the Prop Mover to point to the right.
7. Customize the Prop Mover:

   [![](https://dev.epicgames.com/community/api/documentation/image/5fa9339e-5c79-4a5a-ad0d-3f726e630fa3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5fa9339e-5c79-4a5a-ad0d-3f726e630fa3?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Speed | 4.0 Meters/Second |
   | On Player Collision Behavior | Continue |
   | Player Damage on Collision | 0.0 |
   | Path Complete Action | Ping Pong |
8. In front and below this platform, place a bouncer from the Bouncer Gallery device.
9. Customize the Bouncer:
10. Way above the Bouncer, place another platform with a door in front.
11. Create a path of four horizontal doors with gaps between them, each one raised slightly from the last. Rotate them differently to create some variation.
12. After the last door, place another platform blocked by a door. This will be the ending point for the parkour course!
13. Place a Damage Volume on the ground below the parkour course.
14. Customize the Damage Volume:

    [![](https://dev.epicgames.com/community/api/documentation/image/cbe30e70-8633-4350-91ff-fe5357c0288d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cbe30e70-8633-4350-91ff-fe5357c0288d?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Zone Depth | 100 |
    | Zone Height | Minimal |
    | Damage Type | Elimination |

### Configure the Locks

1. Place a **Lock** device on the first door.
2. For the lock, set **Visible During Game** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/64162a14-b357-447d-a4c0-59f0c63c69a6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/64162a14-b357-447d-a4c0-59f0c63c69a6?resizing_type=fit)
3. Place a **Timer** device and customize.

   [![](https://dev.epicgames.com/community/api/documentation/image/643617de-5a1d-44dd-bd9b-4d60b251a0de?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/643617de-5a1d-44dd-bd9b-4d60b251a0de?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/67bf529e-7ed8-4bd7-8866-b893f359db4c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/67bf529e-7ed8-4bd7-8866-b893f359db4c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Start at Game Start | On |
   | Can Interact | No |
   | Completion Behavior | Restart |
   | Visible During Game | Hidden |
   | Timer Color | White |
   | Show on HUD | No |
4. Configure the following event on the timer so that each time it completes, it will switch the state of the door from open to closed or vice versa.

   [![](https://dev.epicgames.com/community/api/documentation/image/9ff471a9-9206-48b2-8d2f-ca7be6e8d3ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9ff471a9-9206-48b2-8d2f-ca7be6e8d3ac?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Success | Lock Device 1 | Toggle Opened |
5. Duplicate the lock and place duplicates on each door throughout the course. Duplicating the devices ensures that they retain the correct direct event bindings.

### Set Up the Game End

1. Right after the final door on the ending platform, place a **Trigger** device on the ground.
2. Customize the trigger so **Visible in Game** is set to **Off**:

   [![](https://dev.epicgames.com/community/api/documentation/image/47ec1bfa-c6f9-4154-a687-5f22c5840f38?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/47ec1bfa-c6f9-4154-a687-5f22c5840f38?resizing_type=fit)
3. Place an **End Game** device somewhere where the player won’t be able to see it, and customize it with a **Course Completed!** victory callout.

   [![](https://dev.epicgames.com/community/api/documentation/image/4d80dc12-d0e3-4ee2-9548-866f30de6779?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d80dc12-d0e3-4ee2-9548-866f30de6779?resizing_type=fit)
4. Configure the following event on the Trigger device so that when the player reaches it, the game ends.

   [![](https://dev.epicgames.com/community/api/documentation/image/53dd8c07-8b53-4c9c-a432-baba8d614579?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/53dd8c07-8b53-4c9c-a432-baba8d614579?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > Player**.
2. Under **Locomotion**, change **Glider Redeploy** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/294270f4-84c3-4c76-8276-76ac82e8071e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/294270f4-84c3-4c76-8276-76ac82e8071e?resizing_type=fit)
3. Under **Equipment**, change **Start With Pickaxe** to **No**.

   [![](https://dev.epicgames.com/community/api/documentation/image/9b2e5271-9f1f-425b-994d-c364882fb8a4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9b2e5271-9f1f-425b-994d-c364882fb8a4?resizing_type=fit)
4. Go to Island Settings > Mode.
5. Under **Spawning**, change **Respawn Time** to **1 Second**.

   [![](https://dev.epicgames.com/community/api/documentation/image/93a1a317-b535-4ccc-b1b5-7891adb8a7e8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93a1a317-b535-4ccc-b1b5-7891adb8a7e8?resizing_type=fit)

You now have a working parkour game using locks!

### Design Tip

This example uses only one timer to control all of the locks, but consider having more timers to control each lock individually. This would give more control over each door, allowing you to set some to be quicker than others!
