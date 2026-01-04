# Targeted Camera Gameplay

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/party-game-2-targeted-camera-gameplay-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:21:22.654725

---

To target the raft as players scramble for grenades, use Fixed Point Camera. The camera’s 50 degree angle focuses on the side view of the raft. This allows players to see the whole raft surface throughout the game. The camera also pans left and right following each player, keeping them inside the camera’s field of view (FOV).

Third Person Controls override the game camera and make the Fixed Point Camera the dominant view during the mini-game.

[![An example of the party game in action.](https://dev.epicgames.com/community/api/documentation/image/f34070a3-529b-4279-a170-74205ac42c98?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f34070a3-529b-4279-a170-74205ac42c98?resizing_type=fit)

**Devices used**:

- [**1 x Fixed Point Camera**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-fixed-point-camera-devices-in-fortnite-creative)
- [**1 x Third Person Controls**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-third-person-controls-devices-in-fortnite-creative)

## Fixed Point Camera

The [Fixed Point Camera](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#fixed-point-camera) provides each player with an alternative view of their character and the game zone. The targeted camera settings adjust the Pitch and Yaw movement of the camera, based on where a player is inside the camera’s FOV.

This type of camera is perfect for Beat’em Ups and fighting games that use melee weapons.

[![An example of the Fixed Point Camera set up to view the entire raft area.](https://dev.epicgames.com/community/api/documentation/image/7bb476e4-e85d-4479-a2c3-6eb11f7cd6f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7bb476e4-e85d-4479-a2c3-6eb11f7cd6f3?resizing_type=fit)

The placement of your camera needs to be optimal for all players to see the entire game area.

| Option | Value | Explanation |
| --- | --- | --- |
| **Priority** | 100 | Makes the camera a priority over other cameras. |
| **Add to Players on Start** | False | This camera is added to players once they enter the Teleporter rift and land on the raft. |
| **Enabled During Phase** | Gameplay Only | The camera is active during the mini-game gameplay only |
| **Field of View** | 50 | Provides players with an optimal view of the raft. |
| **Look at Offset Distance** | 1.2 cm | Moves the camera backward or forward, offsetting the player’s field of view by 1.2 cm. |
| **Look at Offset Horizontal** | 0.24 cm | Moves the camera left or right, offsetting the player’s field of view by 0.24 cm. |
| **Look at Offset Vertical** | 0.24 cm | Moves the camera up or down, offsetting the player’s field of view by 0.24 cm. |
| **Pitch Acceleration** | 0.0 | No Pitch Acceleration is applied. |
| **Clamp** | True | Clamps the camera to the player’s field of view. |
| **Clamp Pitch Min** | -2.0 degrees | The camera rotates down -2.0, until it stops following its target. |
| **Clamp Pitch Max** | 2.0 degrees | The camera rotates up 2.0, until it stops following its target. |
| **Clamp Yaw Min** | -4.0 degrees | The camera rotates left -4.0, until it stops following its target. |
| **Clamp Yaw Max** | 4.0 degrees | The camera rotates right 4.0, until it stops following its target. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Fixed Point Camera** | Enable | **Player Counter** | On Count Succeeds | The fixed point camera is enabled when the player count matches the Target Player Count number. |
| **Fixed Point Camera** | Add to All | **Activate Trigger** | On Triggered | The fixed point camera is added to all players when the Activate Trigger is triggered. |

## Third Person Controls

| Option | Value | Explanation |
| --- | --- | --- |
| **Priority** | 100 | Makes the camera and third person controls a priority over other cameras. |
| **Add to Players on Start** | False | The camera control is not added to players at the start of the game. |
| **Enabled During Phase** | Gameplay Only | The camera control is active during the mini-game gameplay only. |

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Third Person Controls** | Enable | **Player Counter** | On Count Succeeds | The third person controls are enabled when the player count matches the Target Player Count number. |
| **Third Person Controls** | Remove from Player | **Teleporter9** | On Enter | The third person controls are removed from players who enter the teleporter. |

## Next Section

[![Sequencer Cannonball Animations](https://dev.epicgames.com/community/api/documentation/image/b3c91506-4f2d-4694-8f7e-ba661162518f?resizing_type=fit&width=640&height=640)

Sequencer Cannonball Animations

Animate exploding cannonballs in Sequencer.](https://dev.epicgames.com/documentation/en-us/fortnite/party-game-3-sequencer-cannonball-animations-in-unreal-editor-for-fortnite)
