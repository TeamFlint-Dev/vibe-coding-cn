# ai_patrol_path_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/ai_patrol_path_device
> **爬取时间**: 2025-12-27T01:37:37.727187

---

Used to create patrolling behavior for guards spawned with the `guard_spawner_device`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `NextNodeUnreachableEvent` | `listenable(payload)` | Signaled when a guard cannot reach the next `ai_patrol_path_device`. |
| `NodeReachedEvent` | `listenable(payload)` | Signaled when a guard reaches this device. |
| `PatrolPathStartedEvent` | `listenable(payload)` | Signaled when a guard starts moving on the patrol path. |
| `PatrolPathStoppedEvent` | `listenable(payload)` | Signaled when a guard stops moving on the patrol path. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Assign`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/ai_patrol_path_device/assign) | Assign an AI to this patrol path. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/ai_patrol_path_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/ai_patrol_path_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`GoToNextPatrolGroup`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/ai_patrol_path_device/gotonextpatrolgroup) | Commands patroller to follow the *Next Patrol Path Group* instead of the default *Patrol Path Group*. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
