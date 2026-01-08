# 3. Race Area

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/parkour-elimination-3-race-area-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:21:06.811025

---

**Devices used**:

- 4 x [Player Checkpoint](https://www.fortnite.com/creative/docs/using-player-checkpoint-devices-in-fortnite-creative)
- 1 x [Damage Volume](https://www.fortnite.com/creative/docs/using-damage-volume-devices-in-fortnite-creative)
- 3 x [Lock](https://www.fortnite.com/creative/docs/using-lock-devices-in-fortnite-creative)
- 3 x [Trigger](https://www.fortnite.com/creative/docs/using-trigger-devices-in-fortnite-creative)
- 2+ x [Prop Mover](https://www.fortnite.com/creative/docs/using-prop-mover-devices-in-fortnite-creative)
- 1 x Teleporter

The race area is the largest part of the map, and the section in which you can get the most creative. Make a level that uses sliding, long jumping, door bashes and repeated vaults to keep the players on their toes.

[![map overview](https://dev.epicgames.com/community/api/documentation/image/c419e60b-a654-4d75-a765-c7c20bc3079e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c419e60b-a654-4d75-a765-c7c20bc3079e?resizing_type=fit)

If you want your map to drive engagement, make sure that at least two out of four average-skill players can complete your level with relative ease. [Playtest](playtesting-your-island-unreal-editor-for-fortnite) your level often and [invite friends](https://dev.epicgames.com/documentation/en-us/fortnite/collaborating-in-unreal-editor-for-fortnite) to collaborate and give you feedback!

## Checkpoint System

**Player Checkpoint Pad #1**

[![Checkpoint 1](https://dev.epicgames.com/community/api/documentation/image/d0c64357-52ad-4f79-9fa4-75834d6551e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0c64357-52ad-4f79-9fa4-75834d6551e0?resizing_type=fit)

The Player Checkpoint Pad will respawn the player at the last visited pad if they fail to make it onto a parkour feature.

Set it up inside the starting tunnel facing toward the race area. Use the **scale tool** to stretch and flatten it to fill up the whole tile. Players must make contact with it to override the player spawn pads.

[![scale tool](https://dev.epicgames.com/community/api/documentation/image/a2b8fbe6-ad34-456e-8741-1c50b78f20dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2b8fbe6-ad34-456e-8741-1c50b78f20dc?resizing_type=fit)

This can be copied and used for all the player checkpoints once it is set up and flattened. Make sure to have it hover in the air a bit so that players won't clip through and fall. Configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Game** | False | The base is not visible during the game. |

**Damage Volume**

If a player fails to make it onto a feature during the race, they will be eliminated and respawn at the last visited checkpoint. To make sure that players get eliminated, you need to set up the Damage Volume device.

Place this device anywhere on top of the lava. It will make sure anyone who touches the lava is instantly eliminated.

[![damage volume](https://dev.epicgames.com/community/api/documentation/image/bff90ed6-0876-4900-8f9c-c43c08cb783d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bff90ed6-0876-4900-8f9c-c43c08cb783d?resizing_type=fit)

Configure the **User Settings** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Zone Width** | 100 | Makes it 100 tiles wide, enough to cover the entire map. The volume is invisible so no reason not to make it huge to minimize math. |
| **Zone Depth** | 100 | Makes the depth 100 tiles, enough to cover the entire map. Same reason as above. |
| **Zone Height** | 0.05 | Makes a paper-thin area just above the lava which will eliminate before making contact. |
| **Damage Type** | Elimination | When the player makes contact with the damage volume they are instantly eliminated. |

## Door Bashing

Door bashing is big part of parkour in Fortnite. To ensure that every player gets evenly challenged, you need to ensure that the door closes automatically after being bashed in for the first time.

[![door lock](https://dev.epicgames.com/community/api/documentation/image/8c4edf3a-e4a7-4626-b653-1b89485c00e2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c4edf3a-e4a7-4626-b653-1b89485c00e2?resizing_type=fit)

Place these devices next to each door and make sure to link new lock and trigger devices to the correct doors. Configure the **User Options** as follows:

**Lock #1**

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible During Game** | False | The lock is not visible during the game. |
| **Starts Locked** | Unlocked | The door starts unlocked, allowing the player to shoulder bash through it. |

**Trigger #1**

| Option | Value | Explanation |
| --- | --- | --- |
| **Trigger Delay** | 1.0 | Allows time for the player to clear the door before activating and closing it. |
| **Trigger SFX** | False | No sound is made on activation. |
| **Trigger VFX** | False | No visual effect is done on activation. |
| **Visible In Game** | False | The trigger is invisible and has no collision during gameplay. |

**Direct Event Binding**

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Lock #1 to #3**  [lock device](https://dev.epicgames.com/community/api/documentation/image/b7d80bc7-0300-4ebe-aa4e-551604c80a57?resizing_type=fit) | Close | **Trigger #1 to #3**  [trigger device](https://dev.epicgames.com/community/api/documentation/image/d13bcaed-5640-49d3-8f16-c083c3023404?resizing_type=fit) | On triggered | When a player lands on the trigger, after a brief delay the trigger sends a signal to the Lock to close the door. |

### Obstacles

There is a variety of obstacles that can be used to challenge the players, so the choice is yours. This tutorial primarily makes use of the **Prop Mover**, Damage Rails and various combinations of jumping and vaulting features to increase the difficulty of the race.

Find and place the Prop Mover device onto a prop you'd like to animate, and configure the **User Options**.

| Option | Value | Explanation |
| --- | --- | --- |
| **Distance** | Select value | Total distance traveled by the prop. Adapt this value for each moving feature. |
| **Speed** | Select value | Speed at which the prop moves in gameplay. |
| **On Player Collision Behavior** | Continue | If the device contacts a player, it ignores them and continues moving. |
| **Player Damage On Collision** | 0 | No damage is done to the player for making contact. |
| **On Prop Collision Behavior** | Reverse | Does a 180 if it hits another solid prop such as a wall. |
| **Path Complete Action** | Ping Pong | Prop will go back and forth until the end of its circuit, or until it makes contact with a solid prop. |

## Race End

[![race finish](https://dev.epicgames.com/community/api/documentation/image/bdd0d5f7-4b88-4326-a3b0-d6cfe2309a53?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bdd0d5f7-4b88-4326-a3b0-d6cfe2309a53?resizing_type=fit)

Here is the final jump to end the course. **Teleporter #6**, which has had its size expanded to make it easier to jump into. Leaping into it triggers the elimination arena portion of the map and puts a time limit on finishing the course as well as buying a weapon safely and finding a position in the arena. The event binding for the teleporter is configured once all the devices for the [30-second countdown](https://dev.epicgames.com/documentation/en-us/fortnite/parkour-elimination-4-elimination-arena-in-unreal-editor-for-fortnite) are in place.

Configure the **User Options** as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Teleport Group** | Group None | This teleporter does not belong to any groups. |
| **Teleporter Target Group** | Group A | The group of teleports that it sends to when entered. |
| **Conserve Momentum** | False | When jumped into, you will be teleported from a full stop, preventing any falling damage. |

## Next Section

[![4. Elimination Arena](https://dev.epicgames.com/community/api/documentation/image/04effe90-7a1c-4cb7-9399-6013ff3c27f0?resizing_type=fit&width=640&height=640)

1. Elimination Arena

Build the arena where players will race to get to 10 eliminations.](<https://dev.epicgames.com/documentation/en-us/fortnite/parkour-elimination-4-elimination-arena-in-unreal-editor-for-fortnite>)
