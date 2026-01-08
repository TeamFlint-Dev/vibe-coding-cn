# lock_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/lock_device>
> **爬取时间**: 2025-12-27T01:46:11.677477

---

Used to customize the state and accessibility of doors. `lock_device` only works with assets that have a door attached.

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
| [`Close`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/lock_device/close) | Closes the door. `Agent` is the instigator of the action. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Lock`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/lock_device/lock) | Locks the door. `Agent` is the instigator of the action. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Open`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/lock_device/open) | Opens the door. `Agent` is the instigator of the action. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`ToggleLocked`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/lock_device/togglelocked) | Toggles between `Lock` and `Unlock`. `Agent` is the instigator of the action. |
| [`ToggleOpened`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/lock_device/toggleopened) | Toggles between `Open` and `Close`. `Agent` is the instigator of the action. |
| [`Unlock`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/lock_device/unlock) | Unlocks the door. `Agent` is the instigator of the action. |
