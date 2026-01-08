# gameplay_controls_third_person_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_controls_third_person_device>
> **爬取时间**: 2025-12-27T01:42:16.050417

---

Used to adapt the controls to the camera perspective

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |
| [`gameplay_controls_device`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_controls_device) | Used to update the gameplay controls scheme based on current control mode. |

## Members

This class has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`AddTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_controls_device/addto) | Adds the gameplay control to the `Player`’s gameplay controls stack and pushes it to be the active control. |
| [`AddToAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_controls_device/addtoall) | Adds the gameplay control to all `Agent`s gameplay controls stack and pushes it to be the active control. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_controls_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_controls_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`RemoveFrom`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_controls_device/removefrom) | Removes the gameplay control from the `Agent`’s gameplay controls stack and pops from being the active control replacing it with the next one in the stack. |
| [`RemoveFromAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_controls_device/removefromall) | Removes the gameplay control from all `Agent`s gameplay controls stack and pops from being the active control replacing it with the next one in the stack. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
