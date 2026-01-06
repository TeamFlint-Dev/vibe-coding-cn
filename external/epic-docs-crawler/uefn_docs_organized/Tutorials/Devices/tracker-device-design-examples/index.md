# Tracker Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/tracker-device-design-examples
> **爬取时间**: 2025-12-26T23:04:42.243134

---

The **[Tracker](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative)** device is intended to track custom [objectives](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#objective) that a player can complete.

You can track objectives for individual players, a team, or multiple teams, and send a signal to another device when the player completes a tracked objective.

## Target Practice Tracker

A basic use of the tracker is to track events sent to the device. In this example, you’ll use **target dummies** to send events to a tracker.

### Devices Used

- 1 x Tracker device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device
- 3 x [Target Dummy](https://dev.epicgames.com/documentation/en-us/fortnite/using-target-dummy-devices-in-fortnite-creative) devices

### Set Up the Devices

1. Place a **Player Spawner** device outside the door.
2. Place an **Item Granter** device and register a **Legendary Tactical Assault Rifle** to the device.
3. Customize the item granter.

   [![](https://dev.epicgames.com/community/api/documentation/image/a780c5c0-88ce-4336-9379-cfca35ce350c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a780c5c0-88ce-4336-9379-cfca35ce350c?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Receiving Players | All |
   | Grant on Game Start | On |
4. Place a **Tracker** device.
5. Customize the tracker.

   [![](https://dev.epicgames.com/community/api/documentation/image/742a50b4-4d60-4d5a-914c-656ac97b2e5d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/742a50b4-4d60-4d5a-914c-656ac97b2e5d?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Target Value | 5 |
   | When Target Is Reached | End Round |
   | Tracker Title | Hit Targets |
   | Description Text | Hit the targets 5 times to end the round. |
6. Place three **Target Dummy** devices.

### Bind Functions and Events

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#directeventbinding) is how you set devices to communicate directly with other devices. This involves setting [functions](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) and [events](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#event) for the devices involved.

Configure the following events on the Target Dummy device.

[![](https://dev.epicgames.com/community/api/documentation/image/7cc34367-fa47-417d-a274-d64ff5656d0d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7cc34367-fa47-417d-a274-d64ff5656d0d?resizing_type=fit)

|  |  |  |
| --- | --- | --- |
| Event | Select Device | Select Function |
| On Hit | Tracker | Increment Progress |

You know have the basic functionality for target practice using the Tracker device!

### Design Tip

The Tracker device can be connected to any device that can send events — which is pretty much all of them!

Think of all of the different possible quests that you can give the player with all of the Fortnite Creative devices at your disposal.

## Build a Timed Escape Room

You can configure the Tracker device to track many different events by default, including the number of chests the player has opened. In this example, you’ll combine this functionality of the tracker with a timer to create a Timed Escape Room experience!

### Devices Used

- 1 x Tracker device
- 1 x Player Spawner device
- 1 x [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) device
- 2 x [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative) devices

### Set Up the Escape Room Play Area

1. Place the **Haunted Homestead** prefab.
2. Place three **Chests** around the building with whatever items you would like inside.
3. Place a **Player Spawner** device near the door.
4. Customize the device so the player spawner is not visible in-game.

   [![](https://dev.epicgames.com/community/api/documentation/image/b319c162-e56a-446b-8ac9-5b04fad3c2fb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b319c162-e56a-446b-8ac9-5b04fad3c2fb?resizing_type=fit)
5. Place **Lock** devices on the front and back doors of the building.

### Configure the Escape Room Gameplay

1. Place a **Tracker** device.
2. Customize the tracker.

   [![](https://dev.epicgames.com/community/api/documentation/image/7db237b2-5184-4421-8824-2f91145546a4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7db237b2-5184-4421-8824-2f91145546a4?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Stat to Track | Chest Opened |
   | Target Value | 3 |
   | Tracker TItle | Find Chests |
   | Description Text | Find and open all 3 chests before the time runs out! |
   | Quest Icon | Chest |
3. Place a **Timer** device.
4. Customize the timer.

   [![](https://dev.epicgames.com/community/api/documentation/image/090aa6ac-fa6c-40df-a7a4-22f721820757?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/090aa6ac-fa6c-40df-a7a4-22f721820757?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Duration | 30.0 Second |
   | Start at Game Start | On |
   | Can Interact | No |
   | Success on Timer End | False |
   | Visible During Game | Hidden |
   | Timer Color | White |
   | Display Time In | Seconds Only |

   |  |
   | --- |
   | Remove |

### Bind Functions and Events

1. Configure the following event on the timer, stopping the objective if the player runs out of time.

   [![](https://dev.epicgames.com/community/api/documentation/image/0aff42be-27bc-41d1-9ab9-6641549de686?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0aff42be-27bc-41d1-9ab9-6641549de686?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Failure | Tracker | Remove |
2. Configure the following events on the tracker to unlock the doors and end the timer if the player completes the objective.

   [![](https://dev.epicgames.com/community/api/documentation/image/d4866923-9dc8-403b-8d01-cfc51882396b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d4866923-9dc8-403b-8d01-cfc51882396b?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | When Complete | Timer Device | Disable |
   | When Complete | Lock Device 1 - 2 | Unlock |

You now have the basic functionality for a system that uses  Tracker and Timer devices to create a simple timed objective.

### Design Tip

Connecting the tracker to a timer is a good way to create a simple and effective game loop. With this combination, you have a goal to complete (an objective with the tracker) and a challenge making it difficult (time limit with the timer). With these building blocks, you can create the foundation of tons of fun games!

## Build a Farming Mode with the Tracker

The Tracker device is great for setting up quests in role-playing games.

In this example, you’ll use the tracker to track a quest in a farming game. You'll configure the device to work for both single and multiplayer sessions and will save the player’s quest progress in between play sessions.

### Devices Used

- 1 x Player Spawner device
- 1 x [Barrier](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative) device
- 9 x [Prop Manipulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-manipulator-devices-in-fortnite-creative) devices
- 9 x Conditional Button devices
- 9 x Timer devices
- 1 x Tracker device

### Set Up the Farm Mode Play Area

1. Place the **FarmHouse** prefab in an empty meadow to set the scene.
2. Place a player spawner on the porch.
3. Customize the spawner to hide it in-game.
4. Place a **Chest** with **Wheat** inside of it on the porch to give the player some resource to start with.
5. Create two 9 x 9 farming plots using ground tiles from the Indestructible Gallery and fences from the Frenzy Farm Prop Gallery.
6. Place 9 small wheat props from the **Farm Parts Gallery** on one of the plots.

   [![](https://dev.epicgames.com/community/api/documentation/image/7590b2cb-6eb6-4e95-88da-7ef954c8aef3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7590b2cb-6eb6-4e95-88da-7ef954c8aef3?resizing_type=fit)
7. Place a Barrier device at the entrance of the empty plot and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/e93d8943-f637-4799-99a7-a00a71a17203?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e93d8943-f637-4799-99a7-a00a71a17203?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Barrier Material | Translucent (Only Visible When Close) |
   | Barrier Depth | Minimal |
   | Barrier Height | 0.7 Tiles |

### Set Up the Tracker

1. Place a Tracker device.
2. Customize the tracker.

   [![](https://dev.epicgames.com/community/api/documentation/image/7f469bd5-29b3-4c08-89a8-ea173ee40c8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7f469bd5-29b3-4c08-89a8-ea173ee40c8c?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/de063c7c-ea1a-4bba-a40b-49683d2ea068?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de063c7c-ea1a-4bba-a40b-49683d2ea068?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Stat to Track | Events |
   | Target Value | 25 |
   | Sharing | All |
   | Tracker Title | Harvest Wheat |
   | Description text | Harvest 25 Wheat to unlock a new plot of land! |
   | Quest Icon | Grass |
   | Use Persistence | On |
   | Auto-Save | Yes |
   | Auto-Load | Initial Spawn |
3. Configure the following event on the tracker to unblock the second plot of land when the objective is completed.

   [![](https://dev.epicgames.com/community/api/documentation/image/597e2910-ee80-4c9d-87a7-1094a168f352?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/597e2910-ee80-4c9d-87a7-1094a168f352?resizing_type=fit)

### Configure the Farming Mechanic

1. Place a **Prop Manipulator** device and drop a **Wheat** resource near it to register it to the device.
2. Customize the device.

   [![](https://dev.epicgames.com/community/api/documentation/image/3f34d69e-fd55-48c6-afae-9446ba5499c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f34d69e-fd55-48c6-afae-9446ba5499c5?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/7270d1de-edfd-425d-8bdc-c435ab9e4844?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7270d1de-edfd-425d-8bdc-c435ab9e4844?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Option | Value | Description |
   | Start Hidden | On |  |
   | Override Resources | On | This makes it so that hitting the wheat prop will drop Wheat. |
   | Resource Node Available | 5 |  |
   | Resource Node Type | Item |  |
   | Resource Node Depletion Mode | Stay Empty | You will configure what happens when there is no Wheat left in the prop manually. |
   | Modify Prop Health | Yes |  |
   | Is Prop Invulnerable | Yes |  |
3. Place a **Conditional Button** device in the wheat prop. Drop a Wheat resource near it to register it to the device, then customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/4641cf63-ec54-4849-a967-96b6f3d8303b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4641cf63-ec54-4849-a967-96b6f3d8303b?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Interact Time | 1.0 Second |
   | Interact Text | Plant Wheat |
   | Missing Items Text | Need Wheat to Plant Crops |
   | Key Items Required | 1 |
   | Visible During Game | Hologram Only |
4. Place a timer near the ground in the wheat prop, and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/d4a1b2c6-b298-4a29-a91f-8645b8ea12d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d4a1b2c6-b298-4a29-a91f-8645b8ea12d0?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Duration | 10.0 Seconds |
   | Can Interact | No |
   | Timer Color | White |
   | Show on HUD | No |
5. Configure the following event on the Prop Manipulator device to notify the tracker every time a Wheat resource is harvested from the prop.

   [![](https://dev.epicgames.com/community/api/documentation/image/1e616297-5bb1-4643-855c-1dcd8b386258?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e616297-5bb1-4643-855c-1dcd8b386258?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Function | Select Device | Select Event |
   | On Harvesting | Tracker | Increment Progress |
6. Configure the following event on the Prop Manipulator device to notify the tracker every time a Wheat resource is harvested from the prop.

   [![](https://dev.epicgames.com/community/api/documentation/image/aa470b28-2e69-4742-9ade-dd39672ce8c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aa470b28-2e69-4742-9ade-dd39672ce8c3?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Function | Select Device | Select Event |
   | On Harvesting | Tracker | Increment Progress |
7. Configure the following functions on the **Conditional Button** device to enable it when there is no more Wheat in the prop and disable it when it is activated.

   [![](https://dev.epicgames.com/community/api/documentation/image/7eac8777-0b94-48f7-af71-238391a276f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7eac8777-0b94-48f7-af71-238391a276f2?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Function | Select Device | Select Event |
   | Enable | Crop Prop Manipulator | On Resource Depletion |
   | Disable | Crop Conditional Button | On Activated |
8. Configure the following functions on the Timer device to start the countdown when the Conditional Button is activated and reset to its original state when the prop runs out of Wheat.

   [![](https://dev.epicgames.com/community/api/documentation/image/57d989c6-f99c-45d1-b4e1-afbff6351ee6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57d989c6-f99c-45d1-b4e1-afbff6351ee6?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Function | Select Device | Select Event |
   | Start | Crop Conditional Button | On Activated |
   | Reset | Crop Prop Manipulator | On Resource Depletion |

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > Player**.
2. Under **Build Mode**, change **Allow Building** to **None**.

   [![](https://dev.epicgames.com/community/api/documentation/image/fb20fd82-1697-43d3-819a-4747de9f379a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fb20fd82-1697-43d3-819a-4747de9f379a?resizing_type=fit)
3. Under **Inventory**, change **Infinite Building Materials** to **Off**.
4. Under **Equipment**, change **Environment Damage** to **Off**.

You now have the basic functionality for a farming simulator!

### Design Tip

Consider how these mechanics could be extended into a full game. Different plots of land could contain different crops, or the player could even be given a choice of what to plant where.

You could also set up a shop where the player could sell their crops for money to buy new upgrades. Completing an objective with the tracker could start a new, more difficult objective, creating an entire questline.

The possibilities are endless!
