# prop_mover_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device
> **爬取时间**: 2025-12-27T01:51:18.068496

---

Used to move around a building or prop, and customize responses to various collision event types.

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
| `AgentHitEvent` | `listenable(payload)` | Signaled when the prop hits an `agent`. Sends the `agent` hit by the prop. |
| `AIHitEvent` | `listenable(payload)` | Signaled when the prop hits a creature, animal, or NPC. |
| `BeganEvent` | `listenable(payload)` | Signaled when the prop movement begins. |
| `DisabledEvent` | `listenable(payload)` | Signaled when this device is disabled. |
| `EnabledEvent` | `listenable(payload)` | Signaled when this device is enabled. |
| `EndedEvent` | `listenable(payload)` | Signaled when the prop movement ends. |
| `FinishedEvent` | `listenable(payload)` | Signaled when the prop reaches its destination. |
| `MovementModeChangedEvent` | `listenable(payload)` | Signaled when the prop changes its direction. |
| `PropHitEvent` | `listenable(payload)` | Signaled when the prop hits another prop. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Advance`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device/advance) | Moves the prop forward based on this device's default configuration, ignoring the prop's previous movement. |
| [`Begin`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device/begin) | Begins the prop moving. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device/enable) | Enables this device. |
| [`End`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device/end) | Ends the prop moving. |
| [`GetTargetDistance`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device/gettargetdistance) | Returns the total distance (in meters) that the prop will move. |
| [`GetTargetSpeed`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device/gettargetspeed) | Returns the speed (in meters per second) at which the prop mover will move the prop to its destination. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device/reset) | Moves the prop to its original position. |
| [`Reverse`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device/reverse) | Reverses the prop's moving direction. |
| [`SetTargetDistance`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device/settargetdistance) | Sets the total distance (in meters) that the prop will move. |
| [`SetTargetSpeed`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_mover_device/settargetspeed) | Sets the speed (in meters per second) at which the prop will move to its destination. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
