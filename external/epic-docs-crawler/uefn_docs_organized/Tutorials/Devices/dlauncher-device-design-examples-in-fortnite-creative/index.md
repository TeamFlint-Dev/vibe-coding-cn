# D-Launcher Device Design Examples

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/dlauncher-device-design-examples-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:05:40.134469

---

The **directional launcher** (**D-Launcher** for short) is a device that launches players over long distances in a selected direction. It's great for giving players the ability to fly large distances quickly on your Island.

There are actually three different launchers — **Standard**, **Primal**, and **Invasion**. The functionalities are mostly (but not completely) the same, but with very different cosmetics. (For more on how they differ, see [D-Launcher Devices](using-d-launcher-devices-in-fortnite-creative).)

You'll find three examples here of how you can put this device into play in your games!

## Example 1 — Parkour Traversal

Use the D-Launcher as a [traversal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#traverse) mechanic in a simple parkour challenge.

### Devices Used

- 1 x [**D-Launcher (Primal)**](using-d-launcher-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 2 x [Prop Mover](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative) device
- 1 x [**Damage Volume**](using-damage-volume-devices-in-fortnite-creative) device

### Build Your Own

You will set up a basic parkour challenge with a starting tower, three floating platforms, and an end tower, then add devices. There are a number of galleries with assets that are perfect for both the towers and the floating platforms.

For more on galleries, see [Using Prefabs and Galleries](https://dev.epicgames.com/documentation/en-us/fortnite/using-prefabs-and-galleries-in-fortnite-creative).

1. Build the two towers with three floating platforms between them.
2. Place a **Player Spawner** device on the top of the starting tower.
3. Place **Prop Mover** devices on both of the outside floating platforms (not the middle one), orienting them in the direction you want each platform to travel.

   Once you've customized the first prop mover, you will copy and place it on the remaining platforms.
4. Customize the prop movers with the following settings:

   [![](https://dev.epicgames.com/community/api/documentation/image/5d5cc40b-9173-43b8-b0d6-1895f4effa22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5d5cc40b-9173-43b8-b0d6-1895f4effa22?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Distance** | 10.0 Meters | Shortens the distance the prop moves from the default. |
   | **On Player Collision Behavior** | Continue | This setting keeps player interaction from affecting the prop behavior. |
   | **Player Damage on Collision** | 0.0 | No damage is received by the player. |
   | **Path Complete Action** | Ping Pong | This sets the prop to move back and forth. |

5. Place a **D-Launcher (Primal)** device on the middle platform (the one that will not be moving).

   [![](https://dev.epicgames.com/community/api/documentation/image/8f390644-3d1d-4ade-abc8-12a621126af6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f390644-3d1d-4ade-abc8-12a621126af6?resizing_type=fit)
6. Adjust the **Launch Speed** to make sure the player will fly in the path of the final moving platform.

   [![](https://dev.epicgames.com/community/api/documentation/image/8b6c3508-c1da-49fe-ab01-82bd7de8f804?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b6c3508-c1da-49fe-ab01-82bd7de8f804?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Launch Speed** | 25 Meters/Second | If this speed doesn't work, try faster or slower speeds. Remember that the objective is to launch the player onto the next platform! |

   The default behavior of the Primal D-Launcher sends the player in a gentle arc away from the device.

   Use the blue line extending out from the D-Launcher to see the player’s path.
7. Place a Damage Volume on the ground below the course and customize it

   [![](https://dev.epicgames.com/community/api/documentation/image/9dbb5b3e-75b3-4929-ae1f-bbea292245b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9dbb5b3e-75b3-4929-ae1f-bbea292245b1?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Zone Width** | 100 | The size of the damage zone. This should cover the full area directly under the moving platforms. |
   | **Zone Depth** | 100 | The depth of the zone. |
   | **Zone Height** | .25 | Does not need to be tall, just enough to catch a fallen player! |
   | **Damage Type** | Elimination | A fallen player is eliminated and must respawn before continuing. |

   These settings cause any player touching the ground to be eliminated.

### Design Tip

This functionality is useful for many different game modes, not just parkour. For example, you can use the D-Launcher device to give players access to higher vantage points or hard-to-reach areas in a player vs. player (PvP) game. With this device, the traversal possibilities are endless!

## Example 2 — Hazard Ahead

Because the D-Launcher device can launch a player in any direction, it also works as a hazard for players to avoid. In this example, players must avoid touching launchers that are set to launch them away from the parkour area.

### Devices Used

- 1 x [**D-Launcher (Invasion)**](using-d-launcher-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 3 x [Prop Mover](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative) devices
- 1 x [**Damage Volume**](using-damage-volume-devices-in-fortnite-creative) device

### Build Your Own

1. Build a similar setup to the first example, with a starting tower, three floating platforms, and an end tower.
2. Place a **Player Spawner** device on top of the starting tower.
3. Place a **Prop Mover** device on the first floating platform, orienting it in the direction you want the platform to move.

   Once you've customized the first prop mover, you will copy and place it on the remaining platforms.
4. Customize the first prop mover.

   [![](https://dev.epicgames.com/community/api/documentation/image/b20d8034-f379-4a4f-8f4d-6caa85a1a5f0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b20d8034-f379-4a4f-8f4d-6caa85a1a5f0?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Distance** | 10.0 Meters | Shortens the distance the prop moves from the default. |
   | **Speed** | 3.0 Meters/second | This speed can be adjusted from one platform to the next to create interesting patterns. |
   | **On Player Collision Behavior** | Continue | This setting keeps player interaction from affecting the prop behavior. |
   | **Player Damage on Collision** | 0.0 | No damage is received by the player. |
   | **On Prop Collision Behavior** | Continue | Keeps movement in place if a platform makes contact with another prop. For example, if a platform collides with a launcher, you want the movement to continue! |
   | **Prop Damage on Collision** | 0.0 | No damage is received by the launcher. |

5. Copy and place this device on the other two platforms, adjusting the **Speed** setting on each one to create interesting movement patterns.
6. Place a **D-Launcher (Invasion)** device on the end of the path for the second and third platforms, orienting them to face the direction that the platform is coming from, and angle them up slightly.

   [![](https://dev.epicgames.com/community/api/documentation/image/bcc6a999-e0ce-4220-9d64-712d7d88f30d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bcc6a999-e0ce-4220-9d64-712d7d88f30d?resizing_type=fit)

   The default behavior of this launcher will send the player at a 90-degree angle away from the device.

   You could also adjust the launch angle setting to achieve the same effect, but it wouldn't necessarily be as easy for the player to "read" the device mechanic.
7. Place a **Damage Volume** device on the ground below the course and customize it:

   [![](https://dev.epicgames.com/community/api/documentation/image/c740374d-42e4-4e2a-aaf7-09636788dcd0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c740374d-42e4-4e2a-aaf7-09636788dcd0?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Zone Width** | 100 | The size of the damage zone. This should cover the full area directly under the moving platforms. |
   | **Zone Depth** | 100 | The depth of the zone. |
   | **Zone Height** | .25 | Does not need to be tall, just enough to catch a fallen player! |
   | **Damage Type** | Elimination | A fallen player is eliminated and must respawn before continuing. |

   These settings cause any player touching the ground to be eliminated.

### Design Tip

As with the traversal example, using the D-Launcher to create hazards goes beyond parkour gameplay.

Creating areas that players have to avoid in a PvP game can make gameplay more dynamic and engaging. Play with the speed and angle settings on your launchers as well as a device’s orientation to get new and interesting launch behaviors!

## Example 3 — Skeet Shooting

D-Launcher devices can launch more than just players — they can also launch wildlife and creatures!

This example uses creature-launching, along with a low-gravity function, to create a simple skeet-shooting mini-game.

### Devices Used

- 1 x [**D-Launcher (Invasion)**](using-d-launcher-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device
- 1 x [**Creature Placer**](using-creature-placer-devices-in-fortnite-creative) device
- 1 x [**Damage Volume**](using-damage-volume-devices-in-fortnite-creative) device
- 1 x [**VFX Spawner**](using-vfx-spawner-devices-in-fortnite-creative)  device

### Build Your Own

1. Place an **Item Granter** device.
2. Drop a **Heavy Impact Sniper Rifle** from the **Weapons** category in Creative **Contents** while standing near it to register the weapon to the device.
3. Place a **Player Spawner** device and bind as shown to grant the rifle to the player when they spawn.

   [![](https://dev.epicgames.com/community/api/documentation/image/d487f9e6-3129-4fb7-831a-491354328a93?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d487f9e6-3129-4fb7-831a-491354328a93?resizing_type=fit)

   For more on how event and function binding works, see Getting Started with Direct Event Binding.
4. Place a **D-Launcher (Standard)** device a small distance away from the player spawner, then customize it:

   [![](https://dev.epicgames.com/community/api/documentation/image/16a22617-e793-4eff-876d-3ee437cc61f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/16a22617-e793-4eff-876d-3ee437cc61f4?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Launch Speed** | 25 Meters/second | The speed applied to the object when launched. |
   | **Launch Angle** | 60 Degrees | The angle at which it launches. |

   These settings will send a launched creature in a high arc. The default behavior of this launcher also defaults to **Low Gravity** set to **On**, so the creature will fall more slowly.
5. Add a **Creature Placer** device directly above the launcher.
6. Bind its events as shown to make sure the device spawns a new creature each time the last one is eliminated.

   [![](https://dev.epicgames.com/community/api/documentation/image/87005a8b-b531-4f32-bfa4-8035ac4978b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/87005a8b-b531-4f32-bfa4-8035ac4978b7?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Eliminated Send Event To** | Creature Placer | Enable |

7. You can also use event binding to make the launch even more intense! Place a VFX Spawner device just above the launcher.
8. Customize the VFX to make a single large explosion when activated:

   [![](https://dev.epicgames.com/community/api/documentation/image/76cd50fd-86c0-4791-928b-4d184fd30d43?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/76cd50fd-86c0-4791-928b-4d184fd30d43?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Effect Type** | Burst | Sets the effect for a single burst instead of continuous. |
   | **Burst Visual Effect** | Explosion Large | Provides a large explosion! |

9. Go back to the launcher and bind the following events.

   [![](https://dev.epicgames.com/community/api/documentation/image/5ff50d36-dee9-4cc9-96f4-05cba26ac01e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5ff50d36-dee9-4cc9-96f4-05cba26ac01e?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Non Player Launched Send Event To** | VFX Spawner | Restart |

   This makes the effect play when a creature (non-player) is launched!
10. Place a **Damage Volume** on the ground where the creature will land.
11. Set the **Damage Type** to **Elimination**.

    [![](https://dev.epicgames.com/community/api/documentation/image/134b40aa-ebd0-4d3e-9549-c5a473cf8bc3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/134b40aa-ebd0-4d3e-9549-c5a473cf8bc3?resizing_type=fit)

    This ensures that any creature the player fails to shoot mid-air will still be eliminated when it hits the ground!

### Design Tip

Explore all of the settings on this D-Launcher to find other interesting uses.

Try launching other things — vehicles, guards, and even [chickens](using-wildlife-spawner-devices-in-fortnite-creative)!

You can also configure the device to work only for players from specific [classes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class), so it's possible to set it up in a way that different players will interact with the launcher differently.
