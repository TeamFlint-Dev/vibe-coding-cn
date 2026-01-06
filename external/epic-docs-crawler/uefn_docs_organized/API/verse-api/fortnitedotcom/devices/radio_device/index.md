# radio_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/radio_device
> **爬取时间**: 2025-12-27T01:53:19.187722

---

Used to play curated music from the device or one or more registered `agent`s.

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

This class has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/radio_device/hide) | Hides this device from the world. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Play`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/radio_device/play) | Starts playing audio from this device. |
| [`Register`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/radio_device/register) | Adds the specified agent as a target for the Radio to play audio from |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/radio_device/show) | Shows this device in the world. |
| [`Stop`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/radio_device/stop) | Stops playing audio from this device. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`Unregister`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/radio_device/unregister) | Removes the specified agent as a target for the Radio to play audio from if previously Registered |
| [`UnregisterAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/radio_device/unregisterall) | Removes all previously registered agents as targets for the Radio to play audio from |
