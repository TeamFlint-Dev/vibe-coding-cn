# Down But Not Out Device Design Example

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/down-but-not-out-device-design-examples-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:05:05.357339

---

The **Down But Not Out** device can save players from elimination. Even if a player loses all their health, another player can swoop in and revive them before it’s too late!

In this example, the objective is to occupy the capture area at the mountain's summit for a specified time to win the game, with players working cooperatively to achieve the objective.

This device is an excellent choice for team vs. team games, allowing players to rescue teammates in danger. You will learn how to build a cooperative mountain-climbing game where players have to rely on each other to overcome the dangers of the mountain and reach the summit!

## Devices Used

- 2 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) devices (for two players)
- 1 x [Physics Boulder](https://dev.epicgames.com/documentation/en-us/fortnite/using-physics-boulder-devices-in-fortnite-creative) device
- 1 x [VFX Creator](using-vfx-creator-devices-in-fortnite-creative) device
- 1 x [Audio Player](using-speaker-devices-in-fortnite-creative) device
- 1 x [Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) device
- 1 x [Damage Volume](using-damage-volume-devices-in-fortnite-creative) device
- 1 x [Capture Area](using-capture-area-devices-in-fortnite-creative) device
- 1 x [Down But Not Out](using-down-but-not-out-devices-in-fortnite-creative) device

For devices that you'll place more than once, you can save time if you place and customize the first one, then copy and place as needed!

## Build Your Own

For this example, you will configure the island settings, build your mountain, and add and modify devices.

Place at least one **Player Spawner** device on your island first to avoid having to fall into the island each time you access it!

## Configure the Island Settings

Since this game is about climbing, you'll want to make sure that the players move in ways that support that gameplay.

1. Go to [**Island Settings**](understanding-island-settings-in-fortnite-creative), then make the following changes.
2. Select **Player**, then **Locomotion**.
3. Scroll down as needed to make the following modifications:

   [![island settings](https://dev.epicgames.com/community/api/documentation/image/9e600d9b-1f12-4dd7-ab9b-c24df993b76a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9e600d9b-1f12-4dd7-ab9b-c24df993b76a?resizing_type=fit)

   [![island settings](https://dev.epicgames.com/community/api/documentation/image/627978c5-bae3-48c1-a98d-804b9bbcf2ba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/627978c5-bae3-48c1-a98d-804b9bbcf2ba?resizing_type=fit)

   [![island settings](https://dev.epicgames.com/community/api/documentation/image/0bd8955c-de5c-4ed5-985a-1327fad77422?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0bd8955c-de5c-4ed5-985a-1327fad77422?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Allow Mantling** | On | Players can [mantle](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#mantle) up the mountain. |
   | **Allow Hurdling** | On | Players can [hurdle](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hurdle) over barriers as they scale. |
   | **Allow Sprinting** | On | Players can increase speed or height of jump. |
   | **Sprinting Energy Cost Per Second** | 25 | The increased cost of sprinting makes the game more challenging. |
   | **Glider Redeploy** | Off | Players cannot use a glider if they fall off the mountain. |

You will be making more changes to island settings at the end of this example, but you'll circle back later!

## Build the Mountain

There are a number of [galleries](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gallery) with big pieces of rock that make a great starting point for your mountain-climbing game. This design example uses terrain pieces from the **Modular Mountain Gallery Temperate Buildable** and Mod**ular Rock Gallery Temperate A** galleries, but feel free to select from other galleries as well.

For more on galleries, see [Using Prefabs and Galleries](https://dev.epicgames.com/documentation/en-us/fortnite/using-prefabs-and-galleries-in-fortnite-creative).

[![island settings](https://dev.epicgames.com/community/api/documentation/image/ce1500e4-0838-4a77-b8b3-203ff996e4ce?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce1500e4-0838-4a77-b8b3-203ff996e4ce?resizing_type=fit)

### Build the Mountain Base

1. Place some rocks to build the base for your mountain. The bigger the base of your mountain, the more rocks you can add to make it fun to climb!
2. Scale each rock as needed to fit with the other rocks.

   [![island settings](https://dev.epicgames.com/community/api/documentation/image/c9b693d8-5646-4042-80f5-698d07f99772?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c9b693d8-5646-4042-80f5-698d07f99772?resizing_type=fit)

### Add Ledges for Climbing

The bottom rocks provide the base for your mini-game, but you should continue to pile on more to ensure that players can scale from the bottom to the peak.

Using rocks as ledges also lets the player take advantage of movements like mantling.

[![build ledges](https://dev.epicgames.com/community/api/documentation/image/706c8e96-7090-482a-b2c4-7d8236d69a22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/706c8e96-7090-482a-b2c4-7d8236d69a22?resizing_type=fit)

Explore the galleries and you’ll find all sorts of interesting shapes for players to climb over.

If you need to scale or rotate the rocks, make sure the **Quick Menu** (**Tab > Quick Menu**) **Collision** setting is on **Terrain**.

[![Quick Menu](https://dev.epicgames.com/community/api/documentation/image/787a3580-4e80-47d5-8f81-566ed4b01383?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/787a3580-4e80-47d5-8f81-566ed4b01383?resizing_type=fit)

This lets you push the ledge rocks into the base mountain to create an upward path.

Be sure to test the path that you build — if *you* can’t climb from ground to peak, it's likely no one else can either!

## Add Some Danger

On the mountain, players have to watch out for dangerous boulders rolling down from above. You'll use devices to help players identify dangerous areas with showers of falling rocks and a rumbling sound when they enter into an area where a boulder can fall.

### Place a Physics Boulder Device

To find this device, use the search box, or look at the **Environment** subcategory under **Devices**.

[![Find Physics Boulder device](https://dev.epicgames.com/community/api/documentation/image/70f72f92-3ea4-4e9f-b76c-f8bcdcab7609?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/70f72f92-3ea4-4e9f-b76c-f8bcdcab7609?resizing_type=fit)

The search box is an easy way to find any device if you know the device name! Just make sure you don't have any subcategories checked that could filter out that device.

1. Place a **Physics Boulder** device on your island. Place this device near your mountain. You will change the position later.
2. Use the following settings to customize it.

   [![Configure Physics Boulder device](https://dev.epicgames.com/community/api/documentation/image/7d66291b-5b24-4c98-b014-14474dd2d203?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d66291b-5b24-4c98-b014-14474dd2d203?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Damage to Players** | 100.0 | This is lower than the default damage to give other players a chance to use the DBNO feature. |
   | **Damage to Environment** | 0.0 | For this game mechanic, you don't need damage to the environment, only to players. |
   | **Balanced Boulder Respawns on Timer** | Off | Once a boulder tumbles, you don't want it to respawn. |
   | **Leave Base** | Off | You will want the base to come down with the boulder. |

### Place a VFX Creator Device

You will use this device to create a visual effect for falling rocks.

1. Add a **VFX Creator** device near the Physics Boulder device.
2. Use the following settings to create a visual effect that looks like a shower of falling rocks:

   [![Configure VXF device](https://dev.epicgames.com/community/api/documentation/image/b1c7e12a-ab4c-458e-95ee-b0bfebcc3c93?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1c7e12a-ab4c-458e-95ee-b0bfebcc3c93?resizing_type=fit)

   [![Configure VXF device](https://dev.epicgames.com/community/api/documentation/image/7a0d590e-23b1-48a6-b980-f43624f3e358?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a0d590e-23b1-48a6-b980-f43624f3e358?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Enabled During Phase** | Gameplay Only | Player will only see this effect once the game starts. |
   | **Sprite Shape** | Splatter | This looks like clumps of dirt. |
   | **Sprite Size** | 2X | This sets the initial size of the sprites at twice the default, to make it look more like clumps of dirt. |
   | **Sprite Duration** | 3S | The clumps will fall then fade after 3 seconds. |
   | **Main Color** | #3B3B3B | The hex code color for a shade of brown. |
   | **Main Color Brightness** | 7.7/% | This is brighter than the default value to make it more obvious. |
   | **Use Secondary Color** | Yes | This is the color the clumps transition to. |
   | **Secondary Color** | 5A595A | The code for a shade of gray. |
   | **Secondary Color Brightness** | 7.7/% | Brighter than the default value. |
   | **Effect Gravity** | 10 percent | Slows down how fast the particles fall. |
   | **Keep Size** | No | Lets the particles change size over time. |
   | **Spawn Mode** | Bursts | Instead of a continuous splatter effect, it will happen in bursts. |
   | **Time Between Loops** | 5S | Sets 5 seconds between each burst. |
   | **Spawn Zone Size** | 0.6 | This size is slightly larger than the default. |

### Place an Audio Player Device

Not every spot on the mountain is safe, and rolling boulders are a constant danger. You'll use an audio player to play a dramatic sound effect that will help warn players that a huge rock is about to tumble down on their heads!

1. Add an Audio Player device near the Physics Boulder device.
2. Customize the device with the following values:

   [![Configure audio device](https://dev.epicgames.com/community/api/documentation/image/c41c39a2-2337-465c-bfbc-2d97f426c8e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c41c39a2-2337-465c-bfbc-2d97f426c8e9?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Enabled During Phase** | Gameplay Only | This effect is only needed for gameplay. |
   | **Audio** | Spooky Lobby Thunder | Produces a sound like the rumbling of falling rocks. |
   | **Volume** | 2.5 | Ups the volume enough to be mildly alarming. |
   | **Play on Hit** | Off | The audio will be triggered through a different mechanic, covered under [Bind the Devices](https://dev.epicgames.com/documentation/en-us/fortnite/down-but-not-out-device-design-examples-in-fortnite-creative) below. |

### Place a Volume Device

The boulders are only released when players enter certain areas. You’ll use a **Volume** device to bind the other devices and create the hazards climbers will encounter when climbing your mountain.

1. Place the **Volume** device close to the other devices.
2. Customize it with the following settings:

   [![Configure VXF device](https://dev.epicgames.com/community/api/documentation/image/ce0bd272-609b-4f0e-929b-da70dff5de56?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce0bd272-609b-4f0e-929b-da70dff5de56?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Vehicle Events Enabled** | Off | Keeps vehicles from triggering devices bound with this volume. |
   | **Creature and Wildlife Events Enabled** | Off | Keeps creatures and wildlife from triggering. |
   | **Guard Events Enabled** | Off | Also blocks guards from triggering the devices. |

This leaves only the Player Events Enabled, which means that when a player enters or leaves this volume, bound devices will be triggered.

## Bind the Devices

**Direct event binding** is how devices communicate with each other. There are several bindings you'll need to set up for the game mechanics to work correctly.

You will bind the Physics Boulder, VFX Creator and the Audio Player to the Volume device to activate all of them when a player enters volume, and to send the boulder rolling down the side of the mountain when they exit the volume!

All of this binding can be done from the Volume device.

1. Open the **Customize Volume** and go to the **Events** tab.
2. Set the following event bindings:

   [![](https://dev.epicgames.com/community/api/documentation/image/fc539fb7-fb1c-4053-9612-c0e1273f3c1b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc539fb7-fb1c-4053-9612-c0e1273f3c1b?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Enter Send Event To** | VFX Creator | Start Effect at Device |
   | **On Enter Send Event To** | Audio Player | Play |
   | **On Exit Send Event To** | Physics Boulder | Release Rolling Boulder |
   | **On Exit Send Event To** | Physics Boulder | Destroy Base |
   | **On Exit Send Event To** | VFX Creator | Disable |

These settings result in a warning of eminent rock fall to a player when they enter the volume, followed by an actual falling boulder when the player moves out of the volume.

## Position the Obstacles on Your Mountain

Now that you've configured the first four devices, it's time to get them ready to do their dangerous magic.

1. Rotate the Physics Boulder onto its side so the big rock can roll freely once the device is triggered.

   [![](https://dev.epicgames.com/community/api/documentation/image/9ccd2ccc-8a3a-4fca-ab15-42b251c4aa9d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9ccd2ccc-8a3a-4fca-ab15-42b251c4aa9d?resizing_type=fit)
2. Place the VFX Creator device under the Physics Boulder device. This will help direct players' attention toward the danger.
3. Place the Audio Player device above the boulder.
4. Group select all three devices, then copy and paste them together on your mountain.
5. Place the Volume device along the path beneath the devices that the players will climb. Adjust the size of the volume so it fits the ledge where you place it.

   [![](https://dev.epicgames.com/community/api/documentation/image/ed3eb2ef-39c1-4887-8fe3-b8a718005b5f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ed3eb2ef-39c1-4887-8fe3-b8a718005b5f?resizing_type=fit)
6. If you've created multiple paths, repeat steps 4 and 5 to add more obstacles.

## Set the Win Condition Devices

Some mountain peaks rise so high that breathing becomes difficult when a climber scales them. Mountain climbers call this region the **death zone**. The remaining devices will set up the game mechanics for your mountain's death zone.

### Place a Damage Volume Device

1. Place a **Damage Volume** device and center it in your mountain.
2. Adjust the depth, width, and height so it covers the top ledges that players must climb to reach the summit without covering the top summit area.

   Don’t let the Damage Volume extend above the summit.

   [![](https://dev.epicgames.com/community/api/documentation/image/d3ce74ee-d92f-40aa-907d-594d87325e6b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d3ce74ee-d92f-40aa-907d-594d87325e6b?resizing_type=fit)
3. Customize the Damage Volume device:

   [![](https://dev.epicgames.com/community/api/documentation/image/bb0294c7-74e6-41eb-b7df-86aabdb14f6d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb0294c7-74e6-41eb-b7df-86aabdb14f6d?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Damage** | 1 | Reduces the amount of damage done to work better with the DBNO device. |
   | **Affects Creatures** | No | Creatures are not affected by this device. |
   | **Affects Guards** | No | Guards are not affected by this device. |
   | **Affects Vehicles** | No | Vehicles are not affected by this device. |

The last three settings leave only players losing health from this damage volume.

### Place a Capture Area Device

You will add a **Capture Area** device to your mountain that covers the summit area. This defines the peak of the mountain as the objective for your players to climb to.

1. Place the Capture Area device.

   [![](https://dev.epicgames.com/community/api/documentation/image/b6fa9c99-bd26-4ade-8e33-0261660f77ad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6fa9c99-bd26-4ade-8e33-0261660f77ad?resizing_type=fit)
2. Configure the device with the following settings.

   [![](https://dev.epicgames.com/community/api/documentation/image/9c98bf8b-2727-41d5-bbaf-b22831fedffb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9c98bf8b-2727-41d5-bbaf-b22831fedffb?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/4543aa09-586f-4492-bb3f-e152c8c4d3be?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4543aa09-586f-4492-bb3f-e152c8c4d3be?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Capture Radius** | 1 Tile | The size of the capture area. |
   | **Capture Height** | ½ Tile | Its height. |
   | **Item Visible in Game** | Off | Hides the area hologram in-game. |
   | **Visible During Game** | Off | Hides the device in-game. This also turns off collision properties for the device, meaning that players can pass through the device when in the area. |
   | **Consume Item on Scoring** | No | Since no items are required to enter the area, no items are consumed. |
   | **Consume Item When Dropped** | No | Again, no points are made for dropped items. |
   | **Can Be Used for Periodic Scoring By** | All | Since this game is cooperative, not competitive, the area can be used by all players. |
   | **Item Delivery Score** | 0 | No score is awarded for delivered items. |
   | **Control Time** | 10 Seconds | Sets how long a player needs to be in the area to take control. |
   | **Take Control Faster Per Player** | X2 | Increases control based on the number of players in the area. |
   | **Take Control Faster While Emoting** | X2 | Affects how much emoting increases the player's ownership of the area. Dance for victory! |
   | **Progress Decay Type** | Instant | Removes the need for a player to carry an object to gain control of the area. |
   | **Count as Objective** | On | This lets the area count as the game objective. |

### Place a Down But Not Out Device

The final device here is **Down But Not Out**. With this, players can rescue each other from the dangers of the climb so they can all reach the summit together!

1. Place the DBNO device.
2. Customize it with the following settings.

   [![](https://dev.epicgames.com/community/api/documentation/image/05f185ef-e02c-4680-a92b-b744c3fc3112?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/05f185ef-e02c-4680-a92b-b744c3fc3112?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **DBNO Enabled** | Yes | Determines whether players can be put into a Down But Not Out state. |
   | **Time to Revive** | 5 Seconds | How long it takes to revive a downed teammate. |

## Complete Island Settings Configurations

The final step is to configure the Mode and Round settings in your Island Settings.

1. Go to Island Settings, then select **Mode > Structure**.
2. Make the following changes:

   [![](https://dev.epicgames.com/community/api/documentation/image/63bf8f46-7629-4218-b770-8da6b7db82fa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/63bf8f46-7629-4218-b770-8da6b7db82fa?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Max Players** | 4 | Controls how many players can enter the game at a time. |
   | **Teams** | Cooperative | This keeps all players working together. |
   | **Team Size** | 1 | This ensures everyone is on the same team. |

3. Go to **Round > End Condition**, and make the following changes:

   [![](https://dev.epicgames.com/community/api/documentation/image/c45cc8db-8212-4387-a2a0-67c69b281687?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c45cc8db-8212-4387-a2a0-67c69b281687?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Time Limit** | None | There is no time limit to the game. |
   | **Objectives to End** | 1 | Only 1 objective is required for the players to win the game. |

4. Go to **Round > Victory Condition**, and make the following changes:

   [![](https://dev.epicgames.com/community/api/documentation/image/daae66f5-5acd-4422-98d5-f83754b5690f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/daae66f5-5acd-4422-98d5-f83754b5690f?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Round Win Condition** | Objectives | Once the objective is accomplished, the game is over! |

And there you have it — a cooperative mountain climbing adventure!

## Design Tip

Explore adding other devices to create even more obstacles on your mountain!
