# gameplay_camera_orbit_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_camera_orbit_device
> **爬取时间**: 2025-12-27T01:45:03.291914

---

Used to update the camera's viewpoint to follow the target and be rotated manually.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |
| [`gameplay_camera_device`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_camera_device) | Used to update the camera’s current viewpoint and rotation based on current camera mode. |

## Members

This class has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`AddTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_camera_device/addto) | Adds the camera to the `Agent`’s camera stack and pushes it to be the active camera. |
| [`AddToAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_camera_device/addtoall) | Adds the camera to all `Agent`s camera stacks and pushes it to be the active camera. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_camera_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_camera_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`RemoveFrom`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_camera_device/removefrom) | Removes the camera from the `Agent`’s camera stack and pops from being the active camera replacing it with the next one in the stack. |
| [`RemoveFromAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/gameplay_camera_device/removefromall) | Removes the camera from all `Agent`s camera stacks and pops from being the active camera replacing it with the next one in the stack. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
