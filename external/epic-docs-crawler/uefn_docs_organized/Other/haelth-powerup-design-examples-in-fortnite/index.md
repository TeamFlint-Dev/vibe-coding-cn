# Health Powerup Device Design Examples

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/haelth-powerup-design-examples-in-fortnite>
> **爬取时间**: 2025-12-26T23:04:11.312215

---

Health Powerup is a device you can use in many different ways to regenerate a player's health, the health of their shield, or both. Find out a few cool ways to work this device into your island gameplay!

## Health Boost Pickup

You can set up a health boost that increases a player’s health over time. In this example, you’ll configure the device to give the player a three-second health boost when they pick up the device.

### Devices Used

- 3 x Health Powerup devices
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device
- 1 x [Creature Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative) device

### Set Up the Devices

1. Start with the **T**ilted To**wers POI Island** starter island.ilted To
2. Place a **Player Spawner** device.
3. Place an **Item Granter** device and register a Tactical Assault Rifle to the device.
4. Customize the Item Granter as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/690b3193-38be-4968-82e6-efcf89069584?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/690b3193-38be-4968-82e6-efcf89069584?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | Grant on Game Start | On |

5. Place a **Creature Spawner** device.
6. Place a **Health Powerup** device.
7. Customize the Health Powerup as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/7bcb6b52-8ae4-4ff6-9db9-352e1a9f2706?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7bcb6b52-8ae4-4ff6-9db9-352e1a9f2706?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Effect Magnitude | 15 |
   | Effect Duration | 3 Seconds |

8. Duplicate the Health Powerup two more times in different locations.

You now have the basic functionality for a powerup that gives a timed health boost!

### Design Tip

This core functionality of the Health Powerup is a great way to give players an incentive to move around your map in a multiplayer mode! Try playing with the spawn behavior on the powerups to get more variation in which powerups are reactivated, and when!

## Survival Safe Room

The Health Powerup pairs very well with other devices to create the appearance that the player is being healed by an unseen force!

In this example, you’ll use a Volume device with the Health Powerup device to create a safe room that heals the player!

### Devices Used

- 1 x Health Powerup device
- 1 x Player Spawner device
- 1 x [Wildlife Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-wildlife-spawner-devices-in-fortnite-creative) device
- 2 x [Post Process Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-post-processing-devices-in-fortnite-creative) devices
- 1 x [Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) device

### Set Up the Island

1. Start with the **Arctic Island** starter island.
2. Place a fire from the **Colossal Coliseum Prop Gallery** inside the building on the hill.
3. Place a **Player Spawner**.
4. Customize the Player Spawner so **Visible in Game** is set to **Off**:

   [![](https://dev.epicgames.com/community/api/documentation/image/f86ef633-2a9b-40bd-ab25-15da88db0599?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f86ef633-2a9b-40bd-ab25-15da88db0599?resizing_type=fit)
5. Place a **Wildlife Spawner** between the Player Spawner and the building.
6. Customize the Wildlife Spawner as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/ff939a19-9053-440a-ab93-f426aaaffb93?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ff939a19-9053-440a-ab93-f426aaaffb93?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Biome Variant | Snow |
   | Allow Infinite Spawn | No |
   | Spawn Timer | 0.1 Seconds |
   | Spawn Through Walls | Off |
   | Spawn Radius | 30.0M |
   | Taming | Disabled |

7. Place a **Post Process** device.
8. Customize the Post Process device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/4a167948-7ced-4864-bbb5-0e48998bc64f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4a167948-7ced-4864-bbb5-0e48998bc64f?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Post Process Effect | Frost |
   | Blend in Duration | 1.0 |
   | Blend out Duration | 1.0 |

### Configure the Safe Zone

1. Place another Post Process device.
2. Customize the Post Process device as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/b9f6f371-6350-4a84-a3f8-a8cff657134c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9f6f371-6350-4a84-a3f8-a8cff657134c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Post Process Effect | Film Warm |
   | Starting Strength | 0.0 |
   | Blend in Duration | 1.0 |
   | Blend out Duration | 1.0 |

3. Place a **Health Powerup** in a location that the player won’t be able to reach.
4. Customize the Health Powerup as follows:
5. Place a Volume device in the center of the building.
6. Configure the following events on the Volume so that when the player enters the building, the post processing changes and the Health Powerup is applied. When the player leaves the building, the Health Powerup should end and the Post Processing should go back to the starting state.

   [![](https://dev.epicgames.com/community/api/documentation/image/0e4916cd-7d70-44cb-9e21-27b484fdb256?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0e4916cd-7d70-44cb-9e21-27b484fdb256?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/ab3a5709-d25e-4c6c-87f8-b1d0cd81ef97?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ab3a5709-d25e-4c6c-87f8-b1d0cd81ef97?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Enter Send Event To | Health Powerup | Pickup |
   | On Enter Send Event To | Frost Post Process Device | Blend Out for All |
   | On Enter Send Event To | Warm Post Process Device | Blend in for All |
   | On Exit Send Event To | Health Powerup | Clear |
   | On Exit Send Event To | Frost Post Process Device | Blend in for All |
   | On Exit Send Event To | Warm Post Process Device | Blend Out for All |

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > Player**.
2. Under **Locomotion**, change **Allow Sprinting** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/b717da8f-bd3c-44a7-b404-afb327214a9f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b717da8f-bd3c-44a7-b404-afb327214a9f?resizing_type=fit)

You now have the functionality for a safe zone in an arctic survival game!

### Design Tip

Invisible Health Powerups can give the impression that anything is healing the player, as long as it can send events to start and stop the healing! For example, try healing the player whenever they are in a vehicle! Or maybe heal the player only when they are standing in fire!

## Build a Combat Game with Custom Health Pickup

In this example, you’ll use events and functions on the Health Powerup to create your own custom health pickup, complete with audio and visual effects!

### Devices Used

- 1 x Health Powerup device
- 1 x Player Spawner device
- 1 x Item Granter device
- 1 x [Tracker](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative) device
- 3 x [Creature Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative) devices
- 1 x [Prop Manipulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-manipulator-devices-in-fortnite-creative) device
- 1 x [Customizable Light](https://dev.epicgames.com/documentation/en-us/fortnite/using-customizable-light-devices-in-fortnite-creative) device
- 1 x [Audio Player](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-fortnite-creative) device
- 1 x [VFX Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative) device

### Set Up the Basic Gameplay

1. Place a **Player Spawner**.
2. Customize the Player Spawner so **Visible in Game** is set to **Off.**
3. Place an **Item Granter** and register a Tactical Assault Rifle to the device.
4. Customize the Item Granter as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/a96e1078-6266-4f1f-a614-8f77f710aa69?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a96e1078-6266-4f1f-a614-8f77f710aa69?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | Grant on Game Start | On |

5. Place three **Creature Spawners** around the area.
6. Place a Tracker.
7. Customize the **Tracker** as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/0cea8194-b2d9-46ef-89bf-8fd984a6f3b0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0cea8194-b2d9-46ef-89bf-8fd984a6f3b0?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat to Track | Events |
   | Target Value | 5 |
   | Tracker Title | Eliminate Creatures |
   | Description Text | Eliminate 5 Creatures to Spawn the Healing Idol! |
   | Quest Icon | Enemy |

8. Configure the following **functions** on the Tracker to increment the progress each time a creature is eliminated.

   [![](https://dev.epicgames.com/community/api/documentation/image/ea8aa273-c152-4dac-b4d7-040e594f06be?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ea8aa273-c152-4dac-b4d7-040e594f06be?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | Increment Progress When Receiving From | Creature Spawner 1-3 | On a Creature Is Eliminated |

### Configure the Custom Health Powerup

1. Place a statue from the **Colossal Coliseum Prop Gallery**. Size the statue to be roughly the same size as the player.
2. Place a **Health Powerup** in the center of the statue.
3. Customize the Health Powerup as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/c8b5716f-f318-47db-a374-084ac2d0b947?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c8b5716f-f318-47db-a374-084ac2d0b947?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/d9d62e95-246b-4340-a640-d6a2cfcf8109?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d9d62e95-246b-4340-a640-d6a2cfcf8109?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat to Modify | Both |
   | Effect | Set To |
   | Effect Magnitude | 200 |
   | Pickup Radius | 1 |
   | Respawn | No |
   | Spawn on Minigame Start | No |
   | Ambient Audio | Off |
   | Pick Up Audio | Off |
   | Who Can See This Powerup | None |

4. Place a **Prop Manipulator** connected to the statue.
5. Customize the Prop Manipulator so **Start Hidden** is set to **On**:
6. Place a **Customizable Light** over the statue.
7. Customize the Customizable Light as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/e278628e-4eeb-4b9c-bf50-8116edcaab74?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e278628e-4eeb-4b9c-bf50-8116edcaab74?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Initial State | Off |
   | Light Color | #FFB000 |

8. Place an **Audio Player** by the statue.
9. Customize the Audio Player as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/42e1fcb4-6079-465d-99f9-2542c6e05d01?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42e1fcb4-6079-465d-99f9-2542c6e05d01?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Audio | Unlock |
   | Play on Hit | Off |

10. Place a **VFX Spawner** on the statue.
11. Customize the VFX Spawner as follows:

    [![](https://dev.epicgames.com/community/api/documentation/image/0b2aed68-8f21-4ddf-a12a-c48499f08b1f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0b2aed68-8f21-4ddf-a12a-c48499f08b1f?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Effect Type | Burst |
    | Burst Visual Effect | Explosion Electrical |

12. Configure the following events on the Tracker to spawn the custom pickup when the player completes the creature elimination objective.

    [![](https://dev.epicgames.com/community/api/documentation/image/4f14aa0f-016a-4924-9741-93db6ba992ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f14aa0f-016a-4924-9741-93db6ba992ff?resizing_type=fit)

    | Event | Select Device | Select Function |
    | --- | --- | --- |
    | When Complete Send Event To | Customizable Light | Turn On |
    | When Complete Send Event To | Health Powerup | Spawn |
    | When Complete Send Event To | Prop Manipulator | Show Props |
    | When Complete Send Event To | Audio Player | Play |

13. Configure the following events on the Health Powerup to play the custom effects and destroy the Creature Spawners when the player picks it up.

    [![](https://dev.epicgames.com/community/api/documentation/image/c16973f1-1969-448f-b2c9-d00432f794e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c16973f1-1969-448f-b2c9-d00432f794e0?resizing_type=fit)

    [![](https://dev.epicgames.com/community/api/documentation/image/e9e0c43e-c722-44e5-b88e-97715deb84b3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9e0c43e-c722-44e5-b88e-97715deb84b3?resizing_type=fit)

    | Event | Select Device | Select Function |
    | --- | --- | --- |
    | On Item Picked Up Send Event To | Creature Spawner 1-3 | Destroy Spawner |
    | On Item Picked Up Send Event To | Creature Spawner 1-3 | Eliminate Creatures |
    | On Item Picked Up Send Event To | Customizable Light | Turn Off |
    | On Item Picked Up Send Event To | Prop Manipulator | Hide Props |
    | On Item Picked Up Send Event To | VFX Spawner | Restart |

You now have the core functionality for a custom health pickup!

### Design Tip

With the event that is called when the player picks up the Health Powerup, you can control any other device! Maybe if a player picks up a Health Powerup, the colors of the world should get brighter with a Post Process device! Or, you could this event to give the player a speed boost as well as a health boost!
