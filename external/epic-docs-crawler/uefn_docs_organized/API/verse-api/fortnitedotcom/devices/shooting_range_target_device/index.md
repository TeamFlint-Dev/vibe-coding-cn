# shooting_range_target_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/shooting_range_target_device>
> **爬取时间**: 2025-12-27T01:37:19.461255

---

A single customizable pop up target that can be hit by `agent`s to trigger various events.

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
| `BullseyeHitEvent` | `listenable(payload)` | Signaled when the target is hit in the bullseye area. |
| `HitEvent` | `listenable(payload)` | Signaled when the target is hit by an `agent`. |
| `HopDownEvent` | `listenable(payload)` | Signaled when the target moves down slightly, making it harder to hit. |
| `HopUpEvent` | `listenable(payload)` | Signaled when the target moves up slightly, making it harder to hit. |
| `KnockdownEvent` | `listenable(payload)` | Signaled when the target takes enough damage to get knocked down. |
| `PopDownEvent` | `listenable(payload)` | Signaled when the target moves from standing upright to laying flat. |
| `PopUpEvent` | `listenable(payload)` | Signaled when the target moves from laying flat to standing upright. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/shooting_range_target_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/shooting_range_target_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`HopDown`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/shooting_range_target_device/hopdown) | Moves an active (standing upright) target down slightly, in an effort to make it harder to hit. |
| [`HopUp`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/shooting_range_target_device/hopup) | Moves an active (standing upright) target up slightly, in an effort to make it harder to hit. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`PopDown`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/shooting_range_target_device/popdown) | Causes a target to transition from standing upright (active) to lying flat (inactive). |
| [`PopUp`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/shooting_range_target_device/popup) | Causes a target to transition from lying flat (inactive) to standing upright (active). |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/shooting_range_target_device/reset) | Resets the target to its initial settings. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
