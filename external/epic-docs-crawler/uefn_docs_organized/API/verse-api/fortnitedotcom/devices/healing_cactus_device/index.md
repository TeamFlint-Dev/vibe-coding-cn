# healing_cactus_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/healing_cactus_device>
> **爬取时间**: 2025-12-27T01:54:20.869002

---

Use to create a cactus with healing fruits that can be burst to heal nearby players.

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
| `BurstEvent` | `listenable(payload)` | Triggers when the plant bursts, passing in the triggering `agent`. |
| `GrowEvent` | `listenable(payload)` | Triggers when the plant grows. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Burst`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/healing_cactus_device/burst) | Burst the plant if the device is enabled, passing in the triggering `agent`. If there is no triggering `agent`, players will only be healed if `Heal Targets` is set to `Everyone`. |
| [`Burst`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/healing_cactus_device/burst-1) | Burst the plant if the device is enabled, passing in the triggering `agent`. If there is no triggering `agent`, players will only be healed if `Heal Targets` is set to `Everyone`. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/healing_cactus_device/disable) | Disables the device to prevent interaction and growth. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/healing_cactus_device/enable) | Enables the device to allow interaction and let it grow. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Grow`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/healing_cactus_device/grow) | Grows the plant if the device is enabled. If `Infinite Regrowths` is `false`, this is limited by `Maximum Regrowths`. If someone is too close, the plant won't grow until they move away. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
