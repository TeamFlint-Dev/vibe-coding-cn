# Barrier Device Design Examples

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/barrier-device-design-examples-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:06:27.467157

---

You can use Barrier devices to construct an impenetrable zone that blocks both player movement and weapon fire. Keep going to find a few novel ways to apply this device to your own gameplay!

## Make a Map Border

The **Barrier** device is often used to create an outer boundary around a play area. In this example, we’ll use the **Hollow Box** shape of the barrier to create an invisible wall to keep players contained.

### Devices Used

- 1 x [Barrier](http://using-barrier-devices-in-fortnite-creative) device
- 1 x **Player Spawner** device

### Set Up the Devices

1. Place the **Barn** prefab. (You can find all prefabs from the [Creative Menu](https://dev.epicgames.com/documentation/en-us/fortnite/exploring-the-content-browser-menu-in-fortnite-creative#menu-tab)).
2. Place a Player Spawner device on the ground.
3. Place a Barrier device in the middle of the barn.
4. Customize the barrier as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/507a82c2-3ab7-4bd0-bef2-161f8bb9b2ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/507a82c2-3ab7-4bd0-bef2-161f8bb9b2ca?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Option | Value | Description |
   | Barrier Material | Invisible | The player will not see the boundaries of the barrier. |
   | Zone Shape | Hollow Box | This sets the boundaries at the perimeter of the box. |
   | Barrier Depth | 10.0 TIles | The depth of the barrier. |
   | Barrier Width | 10.0 Tiles | The width of the barrier. |
   | Barrier Height | 5.0 Tiles | The height of the barrier. |

You now have the basic functionality for a contained play area using the Barrier device!

### Design Tip

The **Hollow Box** shape is a great way to set this up quickly, but sometimes, for more complicated maps, it can be helpful to use multiple overlapping barriers. This can give you more control over the shape of the area, how high it extends in different spots, and how the barrier looks in different sections.

## Build Protected Spawn Zones

You can set the Barrier device to block players from specific teams. In this example, you’ll set up a multiplayer island with protected spawn areas for each team.

### Devices Used

- 2 x Barrier devices
- 8 x Player Spawner devices
- 1 x Item Granter device
- 2 x Button devices
- 2 x Timer devices

### Set Up the Play Area

1. Create a basic play area using assets from the **Obstacle Course Gallery Black**. Populate the area with smaller pieces to create interesting hiding places and sight lines for players.
2. Create two spawn areas on either side of the play area, one red and one blue, using assets from **Obstacle Course Gallery Red** and **Obstacle Course Gallery Blue**.
3. Place four Player Spawner devices in the blue spawn area.
4. Customize each player spawner by adding a specific team to be spawned.
5. Place four more player spawners in the Red spawn area and update the Player Team for each to Team 2.
6. Place an Item Granter device outside of the play area. Register a Legendary Tactical Assault Rifle to the device.
7. Customize the Item Granter

   [![](https://dev.epicgames.com/community/api/documentation/image/8b0470c4-331b-4826-a437-a1e19f4140df?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b0470c4-331b-4826-a437-a1e19f4140df?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Receiving Players | All |
   | Grant on Game Start | On |

### Customize the Barriers

1. Place a Barrier device in line with the doorway leading into the blue spawn area.
2. Customize the barrier.

   [![](https://dev.epicgames.com/community/api/documentation/image/0ccc9aa7-0214-4cb8-a69c-88bb8633efba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0ccc9aa7-0214-4cb8-a69c-88bb8633efba?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Option | Value | Description |
   | Barrier Material | Blue Forcefield |  |
   | Barrier Depth | Minimal |  |
   | Ignore Team | Team 1 | The Barrier will not block players on Team 1 from entering and leaving their own spawn area. |
   | Invisible to Ignored Players | On |  |

### Set Up the Infiltration Mechanic

To spruce up the gameplay, you’ll now give players the ability to “infiltrate” the enemy’s spawn zone!

1. Place a Button device to the left of the door leading into the red spawn area.
2. Customize the button.

   [![](https://dev.epicgames.com/community/api/documentation/image/9d891b7a-6c06-4f2e-92da-3c3e5a37e54d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d891b7a-6c06-4f2e-92da-3c3e5a37e54d?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Option | Value | Description |
   | Interact Time | 2.0 Seconds | The interact time is very long to make it difficult to infiltrate the enemy's spawn area. |
   | Activating Team | Team 1 |  |
   | Interaction Text | Infiltrate |  |

3. Place a Timer device above the button.
4. Customize the timer.

   [![](https://dev.epicgames.com/community/api/documentation/image/dc35b982-477c-4245-95d0-74e229aa4068?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dc35b982-477c-4245-95d0-74e229aa4068?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Option | Value | Description |
   | Duration | 5.0 Seconds |  |
   | Can Interact | No | The player should not be able to start or stop the timer manually. |
   | Completion Behavior | Reset |  |
   | Timer Color | White |  |
   | Timer Running Text | Blue is Infiltrating the Red Spawn Area! |  |

5. Configure the following events on the button to allow the player pressing the button to pass through the barrier and start the timer.

   [![](https://dev.epicgames.com/community/api/documentation/image/cef0c284-944a-4980-8709-e01417207f24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cef0c284-944a-4980-8709-e01417207f24?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Interact | Team 2 Barrier Device | Add Player to Ignore List |
   | On Interact | Team 1 Infiltrate Timer Device | Start |

6. Configure the following event on the timer to turn the barrier back on for the infiltrating player.

   [![](https://dev.epicgames.com/community/api/documentation/image/797c291a-2f12-4d89-85d7-08fa5752c1f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/797c291a-2f12-4d89-85d7-08fa5752c1f4?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Success | Team 2 Barrier Device | Remove All Players from Ignore List |

7. Copy these two components and paste them in the same place next to the Blue spawn area.
8. On the button, update the **Activating Team** setting to **Team 2**.
9. On the timer, update the **Timer Running Text** to **Red is Infiltrating the Blue Spawn Area!**
10. On both devices, update **Direct Event Bindings** to ensure that the barrier being referenced is the **Team 1** barrier and not Team 2.

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > Player**.
2. Under **Equipment**, change **Environment Damage** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/7deaed2f-9cf5-46db-8b4d-df9230377de7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7deaed2f-9cf5-46db-8b4d-df9230377de7?resizing_type=fit)

You now have the basic functionality for protected spawn zones with the ability for players to infiltrate!

### Design Tip

Even though a team can freely walk through the barrier in the door of their own spawn zone, note that they still cannot fire weapons through it. This is a good thing; it means that players can’t just sit in their spawn area and freely shoot out into the play area.

## Build a Melee Time Trial

The Barrier device is useful for blocking off areas of the map until a player completes an objective.

In this example, you’ll use a barrier to prevent entry into a volcano lair until players manage to complete the climb within a set time limit!

### Devices Used

- 1 x Barrier
- 1 x Player Spawner
- 1 x Item Granter
- 6 x Creature Placer
- 2 x Button
- 1 x Timer
- 1 x Trigger
- 1 x Teleporter

### Set Up the Basic Gameplay

1. Begin with the **Volcano Island** starter island.
2. Inside the volcano, place a platform of glass panels from the **Glass Gallery**.
3. Furnish the volcano interior with assets from **Residential Gallery A.**
4. Place a Player Spawner device near the bottom of the path up the volcano.
5. Customize the player spawner by setting **Visible in Game** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/9272e8f2-c701-4a05-a5a6-f182f6a7d6c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9272e8f2-c701-4a05-a5a6-f182f6a7d6c3?resizing_type=fit)
6. Place an **Item Granter** device and register an **Infinity Blade** to the device.
7. Customize the granter.

   [![](https://dev.epicgames.com/community/api/documentation/image/7227aab2-23d2-4fa9-a8c6-eb7f2b918150?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7227aab2-23d2-4fa9-a8c6-eb7f2b918150?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Receiving Players | All |
   | Grant on Game Start | On |

8. Place a Creature Placer device on the path leading up the volcano.
9. Customize the device.

   [![](https://dev.epicgames.com/community/api/documentation/image/a3d1ff8e-2c6b-4827-975e-dbf5089229c8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a3d1ff8e-2c6b-4827-975e-dbf5089229c8?resizing_type=fit)

10. |  |  |
    | --- | --- |
    | Option | Value |
    | Activation Range | 1.0 Tiles |
    | Enable on Game Phase | Never |

11. Duplicate the Creature Placer device five times, placing each one along the path. Adjust the **Creature Type setting** to spawn different creatures from each device.

    [![](https://dev.epicgames.com/community/api/documentation/image/fb4d7853-79ce-4218-8006-6424ea45392b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fb4d7853-79ce-4218-8006-6424ea45392b?resizing_type=fit)
12. **Place a barrier in the mouth of the volcano at the same height as the platform that extends over the mouth.**
13. Customize the barrier.

    [![](https://dev.epicgames.com/community/api/documentation/image/053099e0-95d6-4a54-970e-c0dd247df89b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/053099e0-95d6-4a54-970e-c0dd247df89b?resizing_type=fit)

    |  |  |  |
    | --- | --- | --- |
    | Option | Value | Description |
    | Barrier Material | Dreamy Sky |  |
    | Barrier Depth | 4.0 Tiles | This is configured to cover the mouth of the volcano without extending out through the sides. |
    | Barrier Width | 4.0 Tiles | This is configured to cover the mouth of the volcano without extending out through the sides. |
    | Barrier Height | Minimal |  |
    | Invisible to Ignored Players | On |  |

Configured correctly, the barrier should look like this:

[![](https://dev.epicgames.com/community/api/documentation/image/40032a87-b9c2-4f0e-9eb4-c38c539983b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40032a87-b9c2-4f0e-9eb4-c38c539983b6?resizing_type=fit)

### Configure the Objective

1. Place a Button device at the beginning of the path up the volcano.
2. Customize the button to set the **Interact Text** to **Start?**

   [![](https://dev.epicgames.com/community/api/documentation/image/3d2f45c8-b974-4073-8aed-2de5867ad3d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3d2f45c8-b974-4073-8aed-2de5867ad3d5?resizing_type=fit)
3. Place a Timer device.
4. Customize the timer.

   [![](https://dev.epicgames.com/community/api/documentation/image/162f82bd-dd7c-4b83-89b2-ada1fb01b19a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/162f82bd-dd7c-4b83-89b2-ada1fb01b19a?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Duration | 30.0 Seconds |
   | Can Interact | No |
   | Success on Timer End | False |
   | Completion Behavior | Reset |
   | Visible During Game | Hidden |
   | Timer Color | White |
   | Timer Running Text | Reach the top of the volcano before time runs out! |

5. Place a Trigger device at the top of the path. Make the trigger large enough to cover up the entire area that the player will walk across to ensure that they don’t accidentally walk around it.

   [![](https://dev.epicgames.com/community/api/documentation/image/b6c16426-d9e4-4015-bbc3-a2d37d5b3afc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6c16426-d9e4-4015-bbc3-a2d37d5b3afc?resizing_type=fit)
6. Customize the trigger.

   [![](https://dev.epicgames.com/community/api/documentation/image/8b9eec52-d3cc-4687-817e-c36feeeaf3c0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b9eec52-d3cc-4687-817e-c36feeeaf3c0?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Visible In Game | Off |
   | Enabled on Game Start | Off |
   | Trigger VFX | Off |
   | Trigger SFX | Off |

7. Place a button next to the trigger at the top of the path.
8. Customize the button by setting the **Interaction Text** to **Try again?**

   [![](https://dev.epicgames.com/community/api/documentation/image/57b4ba6e-3db8-4db9-a74f-7d3bf5be5e57?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57b4ba6e-3db8-4db9-a74f-7d3bf5be5e57?resizing_type=fit)
9. Place a Teleporter device at the bottom of the path.
10. Customize the teleporter.

    [![](https://dev.epicgames.com/community/api/documentation/image/a2e2132c-c04a-4b4e-be00-1ec24d8ea1cf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2e2132c-c04a-4b4e-be00-1ec24d8ea1cf?resizing_type=fit)

    |  |  |
    | --- | --- |
    | Option | Value |
    | Teleporter Rift Visible | No |
    | Play Visual Effects | No |
    | Play Sound Effects | No |
    | Face Player in Teleporter Direction | Yes |

### Bind Functions / Events

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#directeventbinding) is how you set devices to communicate directly with other devices. This involves setting [functions](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) and [events](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#event) for the devices involved.

1. Configure the following event on the button at the beginning of the climb to enable the creature placers, enable the finish line trigger, and start the timer.

   [![](https://dev.epicgames.com/community/api/documentation/image/fea4edac-b5d7-46a8-aabb-5667bf4759ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fea4edac-b5d7-46a8-aabb-5667bf4759ac?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Interact | Creature Placers (1-6) | Enable |
   | On Interact | Finish Trigger | Enable |
   | On Interact | Timer Device | Start |

2. Configure the following events on the Timer to disable the Creature Placers and the finish line Trigger if the player runs out of time.

   [![](https://dev.epicgames.com/community/api/documentation/image/29b3431b-2db8-40dd-92b9-d3cefc71771b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/29b3431b-2db8-40dd-92b9-d3cefc71771b?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Failure | Creature Placer 1-6 | Disable |
   | On Failure | Finish Trigger | Disable |

3. Configure the following events on the button at the top of the path to teleport the player back to the beginning if they fail and want to try again.

   [![](https://dev.epicgames.com/community/api/documentation/image/d70d7763-6e19-4cd2-825c-6d33713a7ecb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d70d7763-6e19-4cd2-825c-6d33713a7ecb?resizing_type=fit)
4. Configure the following events on the trigger at the top of the path to reset the timer and allow the player to ignore the barrier blocking the entrance to the volcano if they reach the trigger in time.

   [![](https://dev.epicgames.com/community/api/documentation/image/9d15656b-0fe7-4ed2-a74a-5e1638b8841f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d15656b-0fe7-4ed2-a74a-5e1638b8841f?resizing_type=fit)

   |  |  |  |
   | --- | --- | --- |
   | Event | Select Device | Select Function |
   | On Triggered | Barrier Device | Add Player to Ignore List |
   | On Triggered | Timer Device | Reset |

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > Player.**
2. Under **Equipment**, change **Start With Pickaxe** to **No**.

You now have a melee time trial island that uses the Barrier to create an unlockable area!

### Design Tip

The fact that we’re adding the successful player to the Barrier’s ignore list (rather than just disabling the Barrier) means that this functionality could be used easily in a multiplayer game where only players who have completed the objective should be able to access the area. Also, take a look through the different Barrier Materials. There are tons of cool options that can create really interesting effects!
