# chair_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/chair_device
> **爬取时间**: 2025-12-27T01:58:50.474596

---

Creates a chair where `Agent`s can sit.

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
| `ExitedEvent` | `listenable(payload)` | Signaled when an `agent` stops sitting on the Chair. Sends the standing `Agent`. |
| `SeatedEvent` | `listenable(payload)` | Signaled when an `agent` sits on the Chair. Sends the sitting `agent`. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/chair_device/disable) | Disables the Chair. A disabled Chair cannot be interacted with and any `agent` currently occupying the Chair will be ejected. |
| [`DisableExit`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/chair_device/disableexit) | Prevents any seated `agent` from leaving the Chair manually. While Exit is disabled, call Eject to force them out. |
| [`Eject`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/chair_device/eject) | Ejects any `agent` currently in the chair. |
| [`Eject`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/chair_device/eject-1) | Makes `Agent` exit this chair if they are currently in the chair. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/chair_device/enable) | Enables the Chair. An enabled Chair can be interacted with and occupied by any `agent` that meets the requirements. |
| [`EnableExit`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/chair_device/enableexit) | Allows any seated `agent` to leave the chair manually. |
| [`GetSeatedAgent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/chair_device/getseatedagent) | Returns the `agent` currently occupying the chair. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsOccupied`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/chair_device/isoccupied) | Succeeds if the chair is currently occupied. |
| [`IsSeated`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/chair_device/isseated) | Succeeds if `Agent` is currently in the chair . |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Seat`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/chair_device/seat) | Makes `Agent` sit on this chair if they meet the requirements. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
