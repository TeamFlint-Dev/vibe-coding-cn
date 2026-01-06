# race_checkpoint_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/race_checkpoint_device
> **爬取时间**: 2025-12-27T01:57:47.858278

---

Used in tandem with `race_manager_device` to define the route players must traverse.

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
| `CheckpointBecomesCurrentEvent` | `listenable(payload)` | Signaled when this checkpoint becomes the current checkpoint for `agent`. Sends the `agent` who is now targeting this checkpoint. |
| `CheckpointBecomesCurrentForTheFirstTimeEvent` | `listenable(payload)` | Signaled when this checkpoint becomes the next checkpoint that `agent`s need to pass for the first time. Sends the first `agent` who is now targeting this checkpoint. |
| `CheckpointCompletedEvent` | `listenable(payload)` | Signaled when an `agent` passes this checkpoint. Sends the `agent` that passed this checkpoint. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/race_checkpoint_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/race_checkpoint_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`SetAsCurrentCheckpoint`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/race_checkpoint_device/setascurrentcheckpoint) | Sets this checkpoint as the current checkpoint for `Agent`. This only functions if `Agent` has not already passed this checkpoint. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
