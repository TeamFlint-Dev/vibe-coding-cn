# Damage Volume Device Design Examples

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/damage-volume-design-examples-in-fortnite>
> **爬取时间**: 2025-12-26T23:05:53.552223

---

The **Damage Volume** device is great for raising stakes by dealing damage or eliminating players who step where they shouldn't!

Read on to see three ways you can put this device into action on your island.

## Parkour Play Zone Boundary

This simple parkour gameplay uses a Damage Volume device to eliminate any players who fall to the ground.

### Devices Used

- 1 x [Damage Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device

### Build Steps

1. Set up the play area with two towers and three evenly spaced floating platforms in between.
2. Place a **Prop Mover** device on each platform facing toward the center of the play area, and customize it as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/1bd87279-c15f-4a23-bedd-6d89d492fafc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1bd87279-c15f-4a23-bedd-6d89d492fafc?resizing_type=fit)

   | Setting | Value | Description |
   | --- | --- | --- |
   | Distance | 10.0 Meters | The platform will not move very far and the jumps will be reasonable for the player. |
   | On Player Collision Behavior | Continue | If the player collides with the edge of a platform, it will continue moving instead of stopping. |
   | Path Complete Action | Ping Pong | After the platform finishes its path, it will go in the opposite direction back to the starting position. |

3. Place a **Damage Volume** device under the play area and customize it:

   [![](https://dev.epicgames.com/community/api/documentation/image/13ee16d0-0917-4143-b10a-d085a8a2a64d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13ee16d0-0917-4143-b10a-d085a8a2a64d?resizing_type=fit)

   | Setting | Value | Explanation |
   | --- | --- | --- |
   | Zone Width | 15 | The Damage Volume will cover the entire ground below the play area. |
   | Zone Depth | 5 | The Damage Volume will cover the entire ground below the play area. |
   | Zone Height | Minimal | The Damage Volume does not need to extend above the ground very much. |
   | Damage Type | Elimination | When a player touches the Damage Volume, they will be eliminated. |

### Design Tip

This is a useful technique for creating quick and easy respawns when a player goes somewhere they should not. As opposed to a **Barrier** device, which just stops the player, the **Damage Volume** device can more strongly deter a player from going into specific areas by damaging or eliminating them.

## Prevent Spawn Camping

This island shows Damage Volume devices being used to eliminate players who are trying to [spawn camp](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawn-camping).

Each spawn area has a Damage Volume device that you'll configure to eliminate any player not on the spawning team.

### Devices Used

- 2 x [Damage Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative) devices
- 4 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) devices

### Build Steps

1. Create the buildings where each team will spawn  in two distinct areas of an island.
2. Place a **Damage Volume** device in each building that covers the entire space inside, and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/1d85baf0-77a5-4452-897e-6748853cd3de?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d85baf0-77a5-4452-897e-6748853cd3de?resizing_type=fit)

   | Setting | Value | Explanation |
   | --- | --- | --- |
   | Distance | 10.0 Meters | The platform will not move too far and the jumps will be reasonable for the player. |
   | On Player Collision Behavior | Continue | If the player collides with the edge of a platform, it will continue moving instead of stopping. |
   | Path Complete Action | Ping Pong | After the platform finishes its path, it will go in the opposite direction back to the starting position. |

   1. Place two Player Spawners in each spawn building and customize:

      [![](https://dev.epicgames.com/community/api/documentation/image/ebf81818-ba0b-4f25-bd69-85eb3dc94429?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ebf81818-ba0b-4f25-bd69-85eb3dc94429?resizing_type=fit)

      | Setting | Value | Explanation |
      | --- | --- | --- |
      | Zone Width | 3 | The Damage Volume will cover the entire area of the spawn building. |
      | Zone Depth | 2 | The Damage Volume will cover the entire area of the spawn building. |
      | Zone Height | 2 | The Damage Volume will cover the entire area of the spawn building. |
      | Damage Type | Elimination | When a player touches the Damage Volume, they will be eliminated. |
      | Selected Team | Team 1/2 | The team selection should be set to the team that spawns inside of this building. |
      | Invert Team Selection | On | The Damage Volume will eliminate all players except those who spawn inside of that buildi |

### Design Tip

This technique can be used with as many teams as you want, and will prevent anyone who is not on a spawning team from entering that spawn area. This could also be accomplished with the **Barrier** device, but once again, the Damage Volume can be a stronger enforcer against spawn-camping players.

## Triggered by Players

This simple **floor-is-lava** game mode uses a Damage Volume device that players trigger during gameplay. The core game loop is set up so that when the Button is pressed, the Damage Volume is enabled and its “Selected Team” setting is set to the team of the player pressing the Button. The Damage Volume has the “Invert Team Selection” setting enabled, meaning that it will damage all teams except for the triggering player’s team. The Button will also trigger the Timer, which disables the Damage Volume after 15 seconds.

### Devices Used

- 1 x Damage Volume device
- 2 x Player Spawner devices
- 1 x [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) device
- 1 x [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) device

### Build Steps

1. Create a play area with a number of different obstacles and sightlines that create interesting combat.
2. Place a **Damage Volume** device that covers the entire floor of the play area, and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/fc9d249f-34a4-4ec1-a0ea-3313773bacfd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc9d249f-34a4-4ec1-a0ea-3313773bacfd?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/1ea8d096-a0bd-43bc-9199-fd8f7ada9e76?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1ea8d096-a0bd-43bc-9199-fd8f7ada9e76?resizing_type=fit)

   | Setting | Value | Explanation |
   | --- | --- | --- |
   | Enabled on Phase | None | The Damage Volume will begin off. |
   | Zone Visible During Game | Yes | When enabled, the Damage Volume will be visible. |
   | Zone Width | 8 | The Damage Volume will cover the entire floor of the play area. |
   | Zone Depth | 3 | The Damage Volume will cover the entire floor of the play area. |
   | Zone Height | 0.25 Tiles | The Damage Volume will cover the entire floor of the play area. |
   | Damage | 5 | Every time the Damage Volume ticks, it will deal any players inside 5 damage. |
   | Damage Tick Rate | 1 Second | The Damage Volume will deal damage every second. |
   | Invert Team Selection | On | The Damage Volume will damage all players except for players on the team that is currently registered to the device |

3. Place two **Player Spawners,** one for each team oneither side of the play area, and customize each to a specific team:

   [![](https://dev.epicgames.com/community/api/documentation/image/43a82aa3-84de-4089-a36b-14703c6de2e1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/43a82aa3-84de-4089-a36b-14703c6de2e1?resizing_type=fit)

   | Setting | Value | Explanation |
   | --- | --- | --- |
   | Player Team | Team 1/2 | Players from only this team will spawn in this building. |

4. Place a **Timer** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/49614b6d-b466-4ef0-a818-9b4cc475b599?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/49614b6d-b466-4ef0-a818-9b4cc475b599?resizing_type=fit)

   | Setting | Value | Explanation |
   | --- | --- | --- |
   | Duration | 15.0 Seconds | The Timer will go for 15 seconds. |
   | Can Interact | No | The player will not be able to manually manipulate the Timer. |
   | Completion Behavior | Reset | After the Timer completes, it will reset to its initial state, allowing it to be started again. |
   | Timer Color | White | The Timer will appear white in game. |
   | Display Time In | Seconds Only | The Timer will only show the number of seconds until it is completed. |

5. Bind the following event:

   [![](https://dev.epicgames.com/community/api/documentation/image/a8a8f96e-92e2-4ae5-b5c8-f1791813b8a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a8a8f96e-92e2-4ae5-b5c8-f1791813b8a7?resizing_type=fit)

   | Event | Device | Function | Explanation |
   | --- | --- | --- | --- |
   | On Success | Damage Volume | Disable | When the Timer completes, it will disable the Damage Volume. |

6. Place a **Button** device in a neutral place in the play area and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/21b00343-8ecc-4beb-85a3-ac5da45e6214?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21b00343-8ecc-4beb-85a3-ac5da45e6214?resizing_type=fit)

   | Setting | Value | Explanation |
   | --- | --- | --- |
   | Reset Delay | 15.0 Seconds | The Button cannot be pressed for 15 seconds after it has been pressed. |
   | Interaction Text | Enable Damage | The Button will display text saying “Enable Damage” when the player hovers over it. |

7. Bind the following events:

   [![](https://dev.epicgames.com/community/api/documentation/image/65419d44-b91e-47c9-af57-deed71288904?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/65419d44-b91e-47c9-af57-deed71288904?resizing_type=fit)

   | Event | Device | Function | Explanation |
   | --- | --- | --- | --- |
   | On Interact | Damage Volume | Update Selected Team | When the Button is pressed, it will register the team of the player who pressed it to the Damage Volume, meaning that this player’s team will be ignored by the damage. |
   | On Interact | Damage Volume | Enable | When the Button is pressed, the Damage Volume will be enabled. |
   | On Interact | Timer Device | Start | When the Button is pressed, the 15-second Timer is started, after which the Damage Volume will be turned back off. |

### Design Tip

This functionality could be a fun addition to existing elimination maps. Explore different positions for the damage volumes, using multiple different buttons. You can even use a Conditional Button to give the Damage Volume trigger a cost!
