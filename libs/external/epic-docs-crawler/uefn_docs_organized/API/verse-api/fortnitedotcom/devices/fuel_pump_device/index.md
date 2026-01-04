# fuel_pump_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/fuel_pump_device
> **爬取时间**: 2025-12-27T01:49:56.808398

---

Used to provide fuel sources for vehicles. Can also be used to deal considerable damage to `agent`s and the environment when destroyed.

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
| `EmptyEvent` | `listenable(payload)` | Signaled when the fuel pump is emptied. Sends the `agent` that emptied the fuel pump. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/fuel_pump_device/disable) | Disables this device. |
| [`Empty`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/fuel_pump_device/empty) | Grants fuel to `Agent`. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/fuel_pump_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/fuel_pump_device/reset) | Resets fuel stock to *Fuel Capacity* value. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
