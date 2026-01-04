# Switch Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/switch-device-design-examples
> **爬取时间**: 2025-12-26T23:04:05.081467

---

Switch devices can be operated by users to turn devices on or off, or as a game mechanic to start or stop other devices.

[![](https://dev.epicgames.com/community/api/documentation/image/a7c90ffd-b162-4a5c-a4e7-c22a47992951?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a7c90ffd-b162-4a5c-a4e7-c22a47992951?resizing_type=fit)

## Simple Light Switch Mechanic

One basic use of the Switch device is as a light switch as it can be easily configured to turn other devices on and off.

### Devices Used

- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 2 x [Customizable Light (Torch)](https://dev.epicgames.com/documentation/en-us/fortnite/using-customizable-light-devices-in-fortnite-creative) devices
- 1 x [Switch](https://dev.epicgames.com/documentation/en-us/fortnite/using-switch-devices-in-fortnite-creative) device

### Set Up the Devices

1. Place the **Castle Cellar** prefab building.
2. Place a **Player Spawner** device outside the door.
3. Place a **Switch** device inside the building.
4. Customize the switch:

   [![](https://dev.epicgames.com/community/api/documentation/image/13acf328-2337-430e-a95a-bfb23a28ef1c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13acf328-2337-430e-a95a-bfb23a28ef1c?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Turn On Text | Turn On Lights |
   | Turn Off Text | Turn Off Lights |
   | Device Model | Antique Lever (Unlit) |
5. Place two **Customizable Lights (Torch)** devices.
6. Customize the lights:

   [![](https://dev.epicgames.com/community/api/documentation/image/77acfd2d-54ae-40f5-9cdc-3208c8864423?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/77acfd2d-54ae-40f5-9cdc-3208c8864423?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Option | Value | Description |
   | Initial State | Off |  |
   | Brightness Scale | 1.0 |  |
   | Turn On Team | None | Makes it so that players cannot directly interact with the Lights. |
   | Turn Off Team | None | Makes it so that players cannot directly interact with the Lights. |

### Bind Functions and Events

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#directeventbinding) is how you set devices to communicate directly with other devices. This involves setting [functions](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) and [events](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#event) for the devices involved.

1. Configure the following events on the switch:

   [![](https://dev.epicgames.com/community/api/documentation/image/09f2dcc7-f7db-442d-945f-3af3a25f0503?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/09f2dcc7-f7db-442d-945f-3af3a25f0503?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Turned On | Torch, Torch2 | Turn On |
   | On Turned Off | Torch, Torch2 | Turn Off |

You now have the basic functionality for players interacting with lights using the Switch device!

### Design Tip

You can connect a switch to any device. These are  useful in turning different devices on and off! A switch can be easily used to open and close a door remotely, trigger the movement of a prop, or enable or disable a vehicle.

## Build a Persistent Tutorial Manager

The Switch device can be configured to save its state between playthroughs, allowing for very basic and straightforward data saving.

In this example, you will use a switch to create a system that automatically skips a tutorial if the player has completed it before.

### Devices Used

- 1 x Switch device
- 1 x Player Spawner device
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device
- 1 x [Creature Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative) device
- 2 x [Player Checkpoint](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative) devices
- 2 x [Teleporter](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative) devices
- 1 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) device

### Set Up the Basic Gameplay

You’ll begin by setting up the basic play area and gameplay functionality.

1. Create a play area with pieces from the **Obstacle Course Gallery Blue** Gallery.

   Make sure the area has distinct sections for the tutorial and gameplay segments.
2. Place a **Player Spawner** device in another area of the map that the player will see during the starting countdown.
3. Place an **Item Granter** device and register a **Legendary Tactical Assault Rifle** to the device.
4. Customize the item granter:

   [![](https://dev.epicgames.com/community/api/documentation/image/bda09e36-c8cf-4076-9c28-056687974b81?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bda09e36-c8cf-4076-9c28-056687974b81?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Receiving Players | All |
   | Spare Weapon Ammo | 999 |
   | Grant on Game Start | On |
5. Place a **Creature Spawner** device in the tutorial area, and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/69344db7-1cb1-4292-8e76-77795ecf0969?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69344db7-1cb1-4292-8e76-77795ecf0969?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Creature Type | Fiend |
   | Activation Range | 3.0 Tiles |
   | Max Spawn Distance | 1.0 Tiles |

### Configure the Different Start Points

You’ll now use the **Teleporter** and **Player Checkpoint** devices to configure starting locations for the tutorial and gameplay segments.

1. Place a **Player Checkpoint** device at the beginning of the tutorial segment, and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/d58a52e2-d3d1-4140-ba06-e932bc5d5581?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d58a52e2-d3d1-4140-ba06-e932bc5d5581?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Visible In Game | Off |
   | Play Activate FX | Off |
2. Place a Teleporter device on top of the player checkpoint and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/dc64b0c0-a2fd-4828-976b-d42d0d404d81?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dc64b0c0-a2fd-4828-976b-d42d0d404d81?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Teleporter Rift Visible | No |
   | Play Visual Effects | No |
   | Play Sound Effects | No |
3. Copy these two devices and place another pair at the beginning of the Gameplay segment. Rename them accordingly.
4. Customize the new Gameplay Teleporter device.

   [![](https://dev.epicgames.com/community/api/documentation/image/5ce856b4-47e8-4884-9461-50feb09822d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5ce856b4-47e8-4884-9461-50feb09822d0?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Option | Value | Description |
   | Teleporter Group | Group B | This ensures that the two Teleporters are not connected to one another and will only teleport the player on events. |
   | Teleporter Target Group | Group B | This ensures that the two Teleporters are not connected to one another and will only teleport the player on events. |
   | Teleporter Rift Visible | No |  |
   | Play Visual Effects | No |  |
   | Play Sound Effects | No |  |

### Set Up the Persistent Switch

Now, set up a switch to keep track of whether the player has completed the tutorial, and to save the data.

1. Place a **Switch** device and customize.

   [![](https://dev.epicgames.com/community/api/documentation/image/3baf36e3-2f5e-4711-94fa-63067cb38f2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3baf36e3-2f5e-4711-94fa-63067cb38f2e?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Visible During Game | No |
   | Use Persistence | Use |
   | Auto-Save | Yes |
   | Auto-Load | Game Start |
2. Place a **Trigger** device in the doorway at the exit of the tutorial segment and customize.

   [![](https://dev.epicgames.com/community/api/documentation/image/e7bb790c-5f6c-4934-b032-3cdebf47873a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7bb790c-5f6c-4934-b032-3cdebf47873a?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Visible In Game | Off |
   | Times Can Trigger | 1 |
   | Trigger VFX | Off |
   | Trigger SFX | Off |

### Bind Functions and Events

The next step is to bind the functions and events.

1. Configure the following event on the **Player Spawner** device, ensuring that the switch checks its state on game start.

   [![](https://dev.epicgames.com/community/api/documentation/image/b9efa7ce-1c54-4425-9217-cdfe6af83330?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9efa7ce-1c54-4425-9217-cdfe6af83330?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Player Spawned | Tutorial Switch | Check State |
2. Configure the following events on the switch to send the player to the correct location and set their respawn location at the beginning of the game.

   [![](https://dev.epicgames.com/community/api/documentation/image/01c03303-8788-4907-903e-92e89e8f01f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/01c03303-8788-4907-903e-92e89e8f01f6?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | On Check Result On | Gameplay Checkpoint | Register |
   | On Check Result On | Gameplay Teleporter | Teleport |
   | On Check Result Off | Tutorial Checkpoint | Register |
   | On Check Result Off | Tutorial Teleporter | Teleport |
3. Configure the following events on the Trigger device to update the player’s respawn point and save their tutorial progress when they complete the tutorial segment.

   [![](https://dev.epicgames.com/community/api/documentation/image/f892c0f5-499b-4897-9653-63511e92ea32?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f892c0f5-499b-4897-9653-63511e92ea32?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | On Triggered | Gameplay Checkpoint | Register |
   | On Triggered | Tutorial Switch | Turn On |

You now have the basic functionality for a system that uses a switch to track whether a player has completed a tutorial!

### Design Tip

This example showcases a Persistent Tutorial Manager in a single-player context, but the persistence functionality on the switch can easily be used for multiplayer games as well.

For each player to have their own unique switch, make sure the **Store State Per Player** setting is on **Yes**. This would be great in Islands where different players can enter the game at different times, making sure that each is able to interact with the tutorial on their own.

## Build a King-of-the-Hill Game!

The Switch device can be used as an interactable objective in a two-player King-of-the-Hill game!

In this example, you will use a Switch device to represent which player is in control of the hill. If **On**, the Blue Team is in control. If **Off**, the Red Team is in control.

### Devices Used

- 1 x Switch device
- 2 x Player Spawner devices
- 2 x Team Settings & Inventory devices
- 2 x [End Game](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative) devices
- 3 x [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) devices
- 16 x [Customizable Light](https://dev.epicgames.com/documentation/en-us/fortnite/using-customizable-light-devices-in-fortnite-creative) (Spotlight) devices
- 6 x [VFX Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative) devices
- 2 x [Skydome](https://dev.epicgames.com/documentation/en-us/fortnite/using-skydome-devices-in-fortnite-creative) devices
- 2 x [Channel](https://dev.epicgames.com/documentation/en-us/fortnite/using-channel-devices-in-fortnite-creative) devices

### Set Up the Play Area and Basic Devices

1. Create a play area with a large hill in the center using pieces from the **Obstacle Course Gallery Black** and **Obstacle Course Gallery Grip Tape** galleries.
2. Add spawn areas for each team using pieces from the **Obstacle Course Gallery Blue** and **Obstacle Course Gallery Red** galleries.
3. Place a large **Switch** device on the top of the hill and customize.

   [![](https://dev.epicgames.com/community/api/documentation/image/fd3a3bbb-ddc2-4259-88cc-07f805c197cc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fd3a3bbb-ddc2-4259-88cc-07f805c197cc?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Enabled at Game Start | No |
   | Turn On Text | CHANGE TO BLUE |
   | Turn Off Text | CHANGE TO RED |
   | Device Model | Antique Lever (Unlit) |
4. Place a **Timer** device to create a delay before the switch activates at the beginning of the game and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/d97a003a-f819-4e03-8d52-861b9da06ab0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d97a003a-f819-4e03-8d52-861b9da06ab0?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/21a1f8b6-8db2-42ec-bc42-b73c4ba7aa0b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21a1f8b6-8db2-42ec-bc42-b73c4ba7aa0b?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Duration | 10.0 Seconds |
   | Timer Name | Game Start |
   | Start at Game Start | On |
   | Can Interact | No |
   | Visible During Game | HIdden |
   | Timer Color | White |
   | Display Time In | Seconds Only |
   | Timer Running Text | Hill Active In… |
5. Place an **Item Granter** device and register a **Legendary Tactical Assault Rifle** to the device.
6. Customize the device.

   [![](https://dev.epicgames.com/community/api/documentation/image/78eb955e-c18e-461b-bb07-9286d40bb77c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/78eb955e-c18e-461b-bb07-9286d40bb77c?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Receiving Players | All |
   | Spare Weapon Ammo | 999 |
   | Grant on Game Start | On |

### Configure the Two Teams

1. Place a **Player Checkpoint** device in the blue spawn area and customize it to Team 1 (the Blue team).

   [![](https://dev.epicgames.com/community/api/documentation/image/a9b0d5ef-7311-43a8-bd4c-533861bc9fc3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9b0d5ef-7311-43a8-bd4c-533861bc9fc3?resizing_type=fit)
2. Place a **Team Settings & Inventory** device in the blue spawn area, and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/57b09475-2afa-4d62-84c1-1ddcb664a6c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57b09475-2afa-4d62-84c1-1ddcb664a6c3?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Team Name | Blue |
   | Team | 1 |
   | Team Color | Sky Blue |
3. Place an **End Game** device in the blue spawn area and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/94d10e23-e714-4808-8fb4-d2205b4ed16b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/94d10e23-e714-4808-8fb4-d2205b4ed16b?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Winning Team | Team 1 |
   | Custom Victory Callout | Blue Wins |
4. Place a **Timer** device in the blue spawn area, and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/43390203-2519-4079-8d7c-31275ce96675?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/43390203-2519-4079-8d7c-31275ce96675?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Duration | 20.0 Seconds |
   | Timer Name | Blue |
   | Can Interact | No |
   | Visible During Game | Hidden |
   | Timer Color | Sky Blue |
   | Display Time In | Seconds Only |
   | Timer Running Text | BLUE WINS IN… |
   | Timer Label Text Style | Blue |
   | Enable Urgency Mode | On |
   | Urgency Mode Time | 5.0 Seconds |
5. Copy the devices placed in this section and place the duplicates in the red spawn area. Update the settings on the devices for Team 2 instead of Team 1 and Red instead of Blue where applicable.

### Set Up the VFX

1. Place 16 **Customizable Lights (Spotlight)** devices along the top of the hill, and customize them.

   [![](https://dev.epicgames.com/community/api/documentation/image/9491c296-b340-4866-a79d-d77de921a2f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9491c296-b340-4866-a79d-d77de921a2f2?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Activate on Phase | Game Start |
   | Brightness Scale | 1.0 |
   | Color | White |
   | Color Change Time | Instant |
   | Turn On Team | None |
   | Turn Off Team | None |
2. Place two **VFX Spawner** devices at the top of the hill. Customize each spawner to your liking, with one set for blue and one for red. Make sure the spawners are set to **Enabled on Phase** at **None**.
3. Place four additional VFX spawners on the sides of the hill. Customize each to your liking, with one on each side for blue and one on each side for red.
4. Place two **Channel** devices, one for blue and one for red. These will streamline our direct event binding for the VFX in the next section.

### Bind Functions and Events

1. Configure the following events on the **Game Start Timer** device to enable the switch after a 10-second starting delay.

   [![](https://dev.epicgames.com/community/api/documentation/image/cd15c03a-ad42-4112-b998-16ddff59e937?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cd15c03a-ad42-4112-b998-16ddff59e937?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Success | Switch | Enable |
2. Configure the following events on the Blue Timer to make the Blue Team win if the timer reaches 0.

   [![](https://dev.epicgames.com/community/api/documentation/image/73c1b21a-0aa7-411e-b4a2-3281c447b918?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/73c1b21a-0aa7-411e-b4a2-3281c447b918?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Success | Blue End Game Device | Activate |
3. Repeat the previous step with the red timer and Red End Game device.
4. Configure the following events on the Blue Channel device to trigger the VFX changes when the channel is triggered.

   [![](https://dev.epicgames.com/community/api/documentation/image/5308c3ce-d7a7-4c65-8aae-a0817146a429?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5308c3ce-d7a7-4c65-8aae-a0817146a429?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/ad44a87d-2929-4087-914c-b472aecbaae5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad44a87d-2929-4087-914c-b472aecbaae5?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Received Transmit | Light-Light16 | Set to Team Color |
   | On Received Transmit | Red VFX Spawner1-3 | Disable |
   | On Received Transmit | Blue VFX Spawner1-3 | Enable |
5. Repeat the previous step with the **Red Channel.**Configure it so that it disables the Blue VFX Spawners and Skydome, and enables the Red VFX Spawners and Skydome. Leave the light events the same.
6. Configure the following events on the switch to start and pause the timers and trigger the VFX channels.

   [![](https://dev.epicgames.com/community/api/documentation/image/619cd966-a651-475f-be51-78b09ec20485?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/619cd966-a651-475f-be51-78b09ec20485?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/5f01da8a-a54e-4c47-a1d8-9122855ea80a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f01da8a-a54e-4c47-a1d8-9122855ea80a?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Turned On | Blue Timer | Start |
   | On Turned On | Blue Timer | Resume |
   | On Turned On | Red Timer | Pause |
   | On Turned On | Blue VFX Channel | Transmit |
   | On Turned Off | Red Timer | Start |
   | On Turned Off | Red Timer | Resume |
   | On Turned Off | Blue Timer | Pause |
   | On Turned Off | Red VFX Channel | Transmit |

You now have a fully functioning King-of-the-Hill game!

### Design Tip

This example is configured for just two players, but you could add more player spawners to accomodate a larger battle.

When adding more players, make sure the play space is large enough to accommodate many interactions at once, and tune the amount of time it takes players to respawn to keep the gameplay engaging!
