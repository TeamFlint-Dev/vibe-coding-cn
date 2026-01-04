# Trigger Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/trigger-device-design-examples
> **爬取时间**: 2025-12-26T23:04:17.700459

---

**Trigger** devices are useful for triggering other devices, and can be activated by players, vehicles, or other devices.

## Make an Automatic Door

When you combine a **Trigger** device with a **Lock** device, you have an easy way to set up a door that automatically opens and closes.

### Devices Used

- 2 x Trigger devices
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative) device

### Set Up the Devices

1. Place the **Art Deco Bank** prefab.
2. Place a **Player Spawner** device in front of the front door.
3. Place a **Lock** device on the door panel. Make sure the light on the lock is blue — this indicates that it is successfully connected to the door.
4. Place a **Trigger** device in front of the door, and change the size to make sure it is wide enough to cover the entire ground in front of the double doors.
5. Customize the trigger so that it isn't visible in the game.

   [![](https://dev.epicgames.com/community/api/documentation/image/40fc087d-68a5-4cf2-8655-4b08b04cdedc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40fc087d-68a5-4cf2-8655-4b08b04cdedc?resizing_type=fit)
6. Place a second Trigger device away from the building. This trigger will close the door again after it is opened.
7. Customize the second trigger.

   [![](https://dev.epicgames.com/community/api/documentation/image/11f53415-d93b-478b-8833-7c73c2c05c1e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/11f53415-d93b-478b-8833-7c73c2c05c1e?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Visible In Game | Off |
   | Triggered by Player | Off |
   | Trigger Delay | 2.0 Seconds |
   | Trigger VFX | Off |
   | Trigger SFX | Off |
8. Configure the following **event** on the first trigger so that it opens the door and triggers the closing trigger when the player steps on it.

   [![](https://dev.epicgames.com/community/api/documentation/image/9e814725-f4d7-4196-a25d-46c881f3f780?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9e814725-f4d7-4196-a25d-46c881f3f780?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Triggered | Lock Device | Open |
   | On Triggered | Close Trigger | Trigger |
9. Configure the following event on the closing trigger so that it closes the door after a delay.

   [![](https://dev.epicgames.com/community/api/documentation/image/82960535-18c0-4bbc-97be-78b6bd8c1b36?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82960535-18c0-4bbc-97be-78b6bd8c1b36?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Triggered | Lock Device | Close |

You now have the basic functionality for an automatic door!

### Design Tip

This simple functionality can be extended in many ways. If you want players to open the door from either side, place another trigger on the inside of the door and configure it the same way as the first.

You can also connect other devices to a trigger. For example, you could set an alarm to go off if a player goes somewhere they shouldn't!

## Random Loadout

Triggers can be activated by sequencers like the **Random Number Generator** device. Combining a trigger with a random number generator provides a way to grant a player a random loadout!

### Devices Used

- 4 x Trigger devices
- 1 x Player Spawner device
- 1 x [Random Number Generator](https://dev.epicgames.com/documentation/en-us/fortnite/using-random-number-generator-devices-in-fortnite-creative) device
- 4 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) devices
- 1 x [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) device

### Set Up the Devices

1. Place a **Player Spawner** device.
2. Place a **Random Number Generator** device.
3. Customize the device.

   [![](https://dev.epicgames.com/community/api/documentation/image/df29b551-5689-4471-bffb-c9cd1747e862?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/df29b551-5689-4471-bffb-c9cd1747e862?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Value Limit 2 | 4 |
   | Roll Time | Instant |
   | Zone Direction | Forward |
   | Visible During Game | No |
   | Play Audio | Off |
4. Place a **Trigger** device inside the first tile that extends out from the Random Number Generator device.

   [![](https://dev.epicgames.com/community/api/documentation/image/b2a1674c-9c31-4e63-945a-7f3fa0529176?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b2a1674c-9c31-4e63-945a-7f3fa0529176?resizing_type=fit)
5. Customize the trigger.

   [![](https://dev.epicgames.com/community/api/documentation/image/840e6d0e-548f-4773-a42f-879ea5fb840d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/840e6d0e-548f-4773-a42f-879ea5fb840d?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Visible In Game | Off |
   | Triggered by Player | Off |
   | Trigger VFX | Off |
   | Trigger SFX | Off |
6. Place an **Item Granter** device next to the random number generator. Register a **Combat Shotgun** to the device
7. Configure the following event on the trigger so that it triggers the item granter to grant the player the Combat Shotgun when triggered.

   [![](https://dev.epicgames.com/community/api/documentation/image/035a9eaa-4fe3-40f6-8b40-c917fc61d2e7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/035a9eaa-4fe3-40f6-8b40-c917fc61d2e7?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Triggered | Item Granter 1 | Grant Item |
8. Duplicate the **Trigger** and **Item Granter** devices three more times, placing each in each of the sequencer zones of the random number generator. **Copy both devices at the same time to preserve the events bound between them.**
9. Update the three new item granters to have a **Combat Assault Rifle**, **Combat SMG**, and **Bolt Action Sniper Rifle** registered respectively.
10. Place a **Button** device and customize.

    [![](https://dev.epicgames.com/community/api/documentation/image/08595059-cc8b-4297-a079-78193085b9fd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/08595059-cc8b-4297-a079-78193085b9fd?resizing_type=fit)

    |  |  |
    | --- | --- |
    | Option | Value |
    | Interaction Text | Grant New Loadout |
11. Configure the following event on the **Button** device so that it starts the **Random Number Generator** device and gives the player a new loadout when activated.

    [![](https://dev.epicgames.com/community/api/documentation/image/ff65712e-af71-45eb-b26b-90fcd6ae76c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ff65712e-af71-45eb-b26b-90fcd6ae76c2?resizing_type=fit)

    |  |  |  |
    | --- | --- | --- |
    | Event | Select Device | Select Function |
    | On Interact | Random Number Generator | Activate |

You now have the basic functionality for a random loadout system!

### Design Tip

Another way to trigger the system is to configure the Random Number Generator device to activate at the start of the game, giving each player a random starting weapon.

Think about how you could set up the system as an unlockable upgrade in which the player can re-roll their loadout!

## Build a Surfboard Time Trial

The Trigger device can be activated by objects other than players, such as projectiles, creatures, and vehicles. In this example, you’ll use triggers to create a speed course for a surfboard. Yes, a surfboard!

### Devices Used

- 6 x Trigger devices
- 1 x Player Spawner device
- 1 x [Surfboard Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-surfboard-spawner-devices-in-fortnite-creative) device
- 5 x [Prop Manipulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-surfboard-spawner-devices-in-fortnite-creative) devices
- 5 x [VFX Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative) devices
- 1 x [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) device
- 1 x [End Game](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative) device

### Set Up the Basic Gameplay

1. Begin with the **Archipelago Island** starter island.
2. Place a **Player Spawner** device on one of the islands.
3. Customize the player spawner so it isn't visible in-game.

   [![](https://dev.epicgames.com/community/api/documentation/image/4ad25a17-4a6b-4a10-af79-8f4572f218ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4ad25a17-4a6b-4a10-af79-8f4572f218ea?resizing_type=fit)
4. Place a **Surfboard Spawner** device and customize.

   [![](https://dev.epicgames.com/community/api/documentation/image/14e00b38-e6cd-49c7-a1c7-39c2027240cc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/14e00b38-e6cd-49c7-a1c7-39c2027240cc?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Visible During Game | Off |
   | Vehicle Indestructible | On |

### Configure the Checkpoint Zones

1. Place a **Square Frame** from the **Reactive Trim** Gallery.
2. Place a **Trigger** device inside the frame, resizing it to cover the inside of the frame as completely as possible.

   [![](https://dev.epicgames.com/community/api/documentation/image/26d189a8-f5d2-407d-9253-41a6d90fafca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26d189a8-f5d2-407d-9253-41a6d90fafca?resizing_type=fit)
3. Customize the trigger.

   [![](https://dev.epicgames.com/community/api/documentation/image/90a54815-e456-418f-b27a-3e00aa13ccc5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/90a54815-e456-418f-b27a-3e00aa13ccc5?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Visible In Game | Off |
   | Times Can Trigger | 1 |
   | Trigger VFX | Off |
   | Trigger SFX | Off |
4. Place a **Prop Manipulator** device and connect to the frame.
5. Place a **VFX Spawner** device in the center of the frame.
6. Customize the VFX spawner.

   [![](https://dev.epicgames.com/community/api/documentation/image/1ccb357e-ee1f-4d6e-9194-bd1af83271b9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1ccb357e-ee1f-4d6e-9194-bd1af83271b9?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Effect Type | Burst |
   | Burst Visual Effect | Explosion Electrical |
7. Configure the following event on the trigger so that it hides the frame and triggers the visual effects when the player goes through it on the surfboard.

   [![](https://dev.epicgames.com/community/api/documentation/image/6fd4f992-e988-4a18-96f1-a54582910e1c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6fd4f992-e988-4a18-96f1-a54582910e1c?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Triggered | VFX Spawner | Restart |
   | On Triggered | Prop Manipulator | Hide Props |

### Set Up the Game End

1. Place a **Timer** device.
2. Customize the timer.

   [![](https://dev.epicgames.com/community/api/documentation/image/8ebb6ae6-f7d8-4650-8fd6-5bd32417c320?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ebb6ae6-f7d8-4650-8fd6-5bd32417c320?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Start at Game Start | On |
   | Can Interact | No |
   | Success on Timer End | False |
   | Visible During Game | Hidden |
   | Timer Color | White |
   | Timer Running Text | Ride through all zones in… |
3. Place an **End Game** device in an area that the player can’t see.
4. Place another trigger and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/72bcb584-a545-4e32-9207-e6736f67f293?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/72bcb584-a545-4e32-9207-e6736f67f293?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Visible In Game | Off |
   | Triggered by Player | Off |
   | Triggered by Vehicles | Off |
   | Transmit Every X Triggers | 5 |
5. Configure the following functions on the **Game End Trigger** device so that each trigger triggers it.

   [![](https://dev.epicgames.com/community/api/documentation/image/571cbbd8-6fdd-46a7-85a3-b4446cbda335?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/571cbbd8-6fdd-46a7-85a3-b4446cbda335?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Function | Select Device | Select Event |
   | Trigger When Receiving From | Trigger1-5 | On Triggered |
6. Configure the following events on the **Game End Trigger** device to stop the timer and end the game when the player completes the challenge.

   [![](https://dev.epicgames.com/community/api/documentation/image/9e187dd8-e4d6-4e78-9751-88adc5d0b56f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9e187dd8-e4d6-4e78-9751-88adc5d0b56f?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Triggered | End Game Device | Activate |
   | On Triggered | Timer Device | Pause |

You now have a working surfboard time trial!

### Design Tip

The **Race Checkpoint** devices can produce a similar effect to this mechanic, but they are more specialized for races in which the player must go through checkpoints in a specific order.

For this example, a custom trigger used with another trigger that tracks progress through a checkpoint works better.
