# race_manager_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/race_manager_device
> **爬取时间**: 2025-12-27T01:40:11.722545

---

Used with the `race_checkpoint_device` to create more advanced racing modes.

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
| `FirstLapCompletedEvent` | `listenable(payload)` | Signaled when an `agent` completes their first lap. Sends the `agent` that finished the lap. |
| `LapCompletedEvent` | `listenable(payload)` | Signaled when an `agent` completes a lap. Sends the `agent` that finished the lap. |
| `RaceBeganEvent` | `listenable(payload)` | Signaled when the race begins. Sends the `agent` that started the race. |
| `RaceCompletedEvent` | `listenable(payload)` | Signaled when an `agent` finishes the race. Sends the `agent` that finished the race. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Begin`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/race_manager_device/begin) | Begins the race. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/race_manager_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/race_manager_device/enable) | Enables this device. |
| [`End`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/race_manager_device/end) | Ends the race. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
