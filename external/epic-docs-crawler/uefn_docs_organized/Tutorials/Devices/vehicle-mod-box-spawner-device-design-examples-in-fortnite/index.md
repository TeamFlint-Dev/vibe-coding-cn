# Vehicle Mod Box Spawner Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/vehicle-mod-box-spawner-device-design-examples-in-fortnite
> **爬取时间**: 2025-12-26T23:04:35.975027

---

The **Vehicle Mod Box Spawner** device creates crazy vehicle powerups. When a player crashes a vehicle into this device, they drive away with mods that can help them navigate terrain, deal damage, and repair their own vehicle.

[![](https://dev.epicgames.com/community/api/documentation/image/6d7e7619-9e33-443e-953b-36ca2a3d7aa0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d7e7619-9e33-443e-953b-36ca2a3d7aa0?resizing_type=fit)

The default appearance of the spawner device is the glowing blue cube on the left, but when these powerups appear in-game they look like the powerup crate on the right.

## Basic Setup

Vehicle Mod Box powerup crates offer options for adding dynamic powerups to specific vehicles on your island. (For a list of vehicles that can interact with this device, see [Vehicle Mode Box Spawner Devices).](https://dev.epicgames.com/documentation/en-us/fortnite/using-vehicle-mod-box-spawner-devices-in-fortnite-creative)

### Device Used

- 1 x [Vehicle Mod Box Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-vehicle-mod-box-spawner-devices-in-fortnite-creative) device

### Place the Vehicle Mod Box Spawner Device

This device is a spawner, and the item that it spawns is a **Vehicle Mod Box** — a [powerup](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#powerup) that adds modifications to a vehicle that runs over it.

### Set Up the Device

Use the settings below to customize the look of the vehicle mod powerups when they appear during play, and modify the settings that control the powerups that drop.

1. Change the visual appearance of the powerups created by this device:

   [![](https://dev.epicgames.com/community/api/documentation/image/192cbf34-8c1e-4214-bae9-311ee7c3852e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/192cbf34-8c1e-4214-bae9-311ee7c3852e?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/4bce5393-ccd6-48d0-a7e5-869a3807f178?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4bce5393-ccd6-48d0-a7e5-869a3807f178?resizing_type=fit)
2. Change the settings so that this spawner only creates weapon mods.

   [![](https://dev.epicgames.com/community/api/documentation/image/95c0e76a-5866-450c-86b4-6ef00116880b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/95c0e76a-5866-450c-86b4-6ef00116880b?resizing_type=fit)

[![](https://dev.epicgames.com/community/api/documentation/image/6c8fe781-4f37-40b1-9537-8991e0b196f1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c8fe781-4f37-40b1-9537-8991e0b196f1?resizing_type=fit)

Using the Roof Weapons setting gives a powerup that will randomly attach either the grenade launcher weapon or the machine gun turret to the cab of the vehicle.

You can create similar powerups that randomly assign one of the choices available to upgrade the vehicle in the same way. For example, below are four Vehicle Mod Box powerups customized to randomly grant bumper upgrades, tire upgrades, roof weapons, or repairs.

[![](https://dev.epicgames.com/community/api/documentation/image/e0d3bcc8-cea5-4217-acff-514db225db11?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e0d3bcc8-cea5-4217-acff-514db225db11?resizing_type=fit)

### Design Tip

Try adjusting the respawn timer to control how often your powerups will respawn on your island. More or fewer powerups can really change the feel of the game!

## Expand the Powerups Available

Continuing from [Basic Setup](https://dev.epicgames.com/documentation/en-us/fortnite/vehicle-mod-box-spawner-device-design-examples-in-fortnite#basic-setup), in this example, you'll create more Vehicle Mod Box powerups, adjusting the settings to grant specific modifications for each one when a player picks it up.

### Devices Used

- 11 x Vehicle Mod Box Spawner devices

### Copy the Initial Spawners Devices and Customize the Settings

[![](https://dev.epicgames.com/community/api/documentation/image/8af26bfb-568f-4364-b50f-3d2ce0c3ad62?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8af26bfb-568f-4364-b50f-3d2ce0c3ad62?resizing_type=fit)

1. Create a copy of the Bumper upgrades powerup.
2. Customize the settings of the copy using the settings below:

   [![](https://dev.epicgames.com/community/api/documentation/image/dc5b2421-97d5-4306-88a2-eee20b06597d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dc5b2421-97d5-4306-88a2-eee20b06597d?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/43c1ecaa-75bc-4346-b887-460cce490aba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/43c1ecaa-75bc-4346-b887-460cce490aba?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/06e3aaca-2ae3-41b9-9155-dfea963d41f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06e3aaca-2ae3-41b9-9155-dfea963d41f6?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/041de821-f639-4fd4-9826-b8d2ee573c10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/041de821-f639-4fd4-9826-b8d2ee573c10?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/d47db837-294e-4a36-bb27-84125b0cd6ad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d47db837-294e-4a36-bb27-84125b0cd6ad?resizing_type=fit)
3. Repeat for the Spiked Bumper upgrade, then modify other options for tire upgrade and rooftop upgrade weapons.

   [![](https://dev.epicgames.com/community/api/documentation/image/c11e692a-1b94-461d-b246-c26a8200b981?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c11e692a-1b94-461d-b246-c26a8200b981?resizing_type=fit)
4. For a fun twist, make a powerup that could give the player a vehicle mod upgrade at random they pick it up! Use the following settings:

   [![](https://dev.epicgames.com/community/api/documentation/image/bf722396-b65f-43ac-b127-35b87cf7162c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bf722396-b65f-43ac-b127-35b87cf7162c?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/dbc2b881-549d-45c7-a29d-155f063f7ae5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dbc2b881-549d-45c7-a29d-155f063f7ae5?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/d02f2996-cdc5-4c2f-b636-9b5caa1809c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d02f2996-cdc5-4c2f-b636-9b5caa1809c4?resizing_type=fit)

### Design Tip

And just like that, you now have 11 different powerups to populate your islands with exciting gameplay options!

Try adjusting the respawn timers on each powerup to change the gameplay on your island. Longer respawn timers make more desirable upgrades.

## Build a Vehicle Battle Game!

Ready to build a game using the Vehicle Mod Box Spawner device? Follow the instructions in this example to create a team vehicle battle game mode for up to 10 players!

[![](https://dev.epicgames.com/community/api/documentation/image/074c3dd9-78bf-4aca-8422-c6ca8d223c0d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/074c3dd9-78bf-4aca-8422-c6ca8d223c0d?resizing_type=fit)

### Devices Used

- 1 x [SUV Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-suv-spawner-devices-in-fortnite-creative) device
- 1 x [Fang Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-fang-spawner-devices-in-fortnite-creative) device
- 1 x [Pickup Truck Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-pickup-truck-spawner-devices-in-fortnite-creative) device
- 1 x [Sports Car Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-sports-car-spawner-devices-in-fortnite-creative) device
- 2 x [Quadcrasher Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-quadcrasher-spawner-devices-in-fortnite-creative) devices
- 4 x [Fuel Pump](https://dev.epicgames.com/documentation/en-us/fortnite/using-fuel-pump-devices-in-fortnite-creative) devices
- 5 x Team Settings & Inventory devices
- 5 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) devices
- 10 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) devices (5 teams of 2)
- 11 x [Vehicle Mod Box Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-vehicle-mod-box-spawner-devices-in-fortnite-creative) devices

### Overview

1. Make a vehicle battle arena.
2. Place the vehicle spawners for each team.
3. Customize the Team Settings & Inventory device for Team 1.
4. Customize the Item Granter for the Team 1.
5. Place and customize the Player Spawners for Team 1.
6. Copy the team devices to the other team start locations.
7. Place the Vehicle Mod Box powerup spawners.
8. Configure the Island Settings.

### Make a Vehicle Battle Arena

[![](https://dev.epicgames.com/community/api/documentation/image/bafa751d-88c1-419f-b624-2bf56b06a622?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bafa751d-88c1-419f-b624-2bf56b06a622?resizing_type=fit)

1. Use pieces from the following galleries to create an enclosed arena for vehicles.

   - Modular Rock Gallery Arid A
   - Modular Rock Gallery Arid B
   - Desert Nature Gallery
2. Use buildings from the following prefabs:

   - Gas Station
   - Roadside Garage
3. Build a circular wall of large rocks. First, outline your arena, then add smaller rocks to break up the interior of the arena.

   [![](https://dev.epicgames.com/community/api/documentation/image/a58aecb7-0c64-4149-abe2-8f901345b208?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a58aecb7-0c64-4149-abe2-8f901345b208?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/40c264f0-41ac-4ec8-9934-453b0dc58eb2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40c264f0-41ac-4ec8-9934-453b0dc58eb2?resizing_type=fit)

### Place the Vehicle Spawners for Each Team

Pick interesting locations for the teams to start in your battle arena. **Space each team's starting location an even distance from the other team areas.**

Place the following vehicle spawners on each team area:

- 1 x SUV Spawner
- 1 x Fang Spawner
- 1 x Pickup Truck Spawner
- 1 x Sports Car Spawner
- 2 x Quadcrasher Spawners

[![](https://dev.epicgames.com/community/api/documentation/image/1de1d5e9-ac58-4247-bfa0-2eaeeab93cf1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1de1d5e9-ac58-4247-bfa0-2eaeeab93cf1?resizing_type=fit)

Place each vehicle in a team spawn area.

Give one team two **Quadcrasher ATV Spawners** instead of a single vehicle.

[![](https://dev.epicgames.com/community/api/documentation/image/6a537dc8-0872-444a-a9bd-e86c13ec682e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6a537dc8-0872-444a-a9bd-e86c13ec682e?resizing_type=fit)

### Customize the Settings & Inventory Device

Use the **Team Settings** device to set up each two-player team, starting with **Team 1.** The easiest way to do this is to set up the first device, then copy it for each team, changing the team device options as you go.

 Use the settings below for Team 1:

[![](https://dev.epicgames.com/community/api/documentation/image/43f7dad1-fb8e-4501-ac2b-2e8a4a331d15?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/43f7dad1-fb8e-4501-ac2b-2e8a4a331d15?resizing_type=fit)

### Place the Item Granter Device for Team 1

[![](https://dev.epicgames.com/community/api/documentation/image/a8431880-297f-49a2-8331-90859dfe5475?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a8431880-297f-49a2-8331-90859dfe5475?resizing_type=fit)

1. Arm the teams in your game mode with whatever weapons you want by dropping the weapons on the Item Granter device.
2. Configure the device with these settings:

   [![](https://dev.epicgames.com/community/api/documentation/image/5f0ea76f-6a37-43ff-ad36-fc59aafad139?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f0ea76f-6a37-43ff-ad36-fc59aafad139?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/2a19de97-004a-47a6-b33c-b36384e72797?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a19de97-004a-47a6-b33c-b36384e72797?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/23ebca39-42f4-420f-8aae-6a8f7510947a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23ebca39-42f4-420f-8aae-6a8f7510947a?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/7ee52868-4453-4d3f-84b6-5b52726d7be0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7ee52868-4453-4d3f-84b6-5b52726d7be0?resizing_type=fit)
3. Customize the **Functions** settings, connecting it to the **Team Inventory & Settings** device for **Team 1**:

   [![](https://dev.epicgames.com/community/api/documentation/image/bb778bf1-d0c8-48c8-aa9c-ab5b13cfe9c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb778bf1-d0c8-48c8-aa9c-ab5b13cfe9c3?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/07437aad-e1a8-43ff-95fa-ba574e0838b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/07437aad-e1a8-43ff-95fa-ba574e0838b7?resizing_type=fit)

### Copy the Remaining Devices to Each Team's Starting Location

1. Copy the devices you set up for Team 1 to each of the team starting locations. This includes:

   - Team Settings & Inventory
   - Item Granter
   - Player Spawners

   [![](https://dev.epicgames.com/community/api/documentation/image/18a80281-3914-42e9-a7bb-258d55723f51?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/18a80281-3914-42e9-a7bb-258d55723f51?resizing_type=fit)

Make sure to update the team settings in the Team Inventory & Settings device and the Player Spawner devices.

### Place the Vehicle Mod Box Spawners

In this example, you will use the eleven Vehicle Mod Box powerup spawners that you created in examples [Basic Setup](https://dev.epicgames.com/documentation/en-us/fortnite/vehicle-mod-box-spawner-device-design-examples-in-fortnite#basic-setup) and [Expand the Powerups](https://dev.epicgames.com/documentation/en-us/fortnite/vehicle-mod-box-spawner-device-design-examples-in-fortnite#expand-the-powerups-available) above. Follow those directions as needed to customize the devices for this game mode.

Pick interesting locations and place all eleven powerup spawners in your battle arena!

### Configure the Game Settings

1. Use the settings below for the **Mode**:

   [![](https://dev.epicgames.com/community/api/documentation/image/aae09601-1b0a-40a5-87d2-eda5d690728d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aae09601-1b0a-40a5-87d2-eda5d690728d?resizing_type=fit)
2. Use these **Round** settings:

   [![](https://dev.epicgames.com/community/api/documentation/image/a9c3f724-1c2c-418c-bed5-d348996d8fe7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9c3f724-1c2c-418c-bed5-d348996d8fe7?resizing_type=fit)
3. Set the **End Condition**:

   [![](https://dev.epicgames.com/community/api/documentation/image/0421ece2-a5b0-4e6f-a995-99442a43b2db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0421ece2-a5b0-4e6f-a995-99442a43b2db?resizing_type=fit)

### Design Tip

And it is complete — a brutal vehicle-based team battle for up to ten players!

You can adjust the placements and respawn timers for the Vehicle Mod Box powerup spawners to radically change how your matches play out!
