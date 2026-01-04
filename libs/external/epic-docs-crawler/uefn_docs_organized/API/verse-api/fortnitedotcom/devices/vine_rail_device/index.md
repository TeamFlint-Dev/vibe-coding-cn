# vine_rail_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vine_rail_device
> **爬取时间**: 2025-12-27T01:52:58.823155

---

Used to create a customizable vine version of the Grind Rails.

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
| `EndedGrindingEvent` | `listenable(payload)` | Signaled when an `agent` starts grinding on this `vine_rail_device`. |
| `StartedGrindingEvent` | `listenable(payload)` | Signaled when an `agent` starts grinding on this `vine_rail_device`. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vine_rail_device/disable) | Disables this device, preventing players from grinding on the vines. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vine_rail_device/enable) | Enables this device, letting players grind on the vines. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vine_rail_device/hide) | Hides the track. Players can still grind on the track if it is enabled. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vine_rail_device/show) | Make this track visible. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
