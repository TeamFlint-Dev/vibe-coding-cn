# wilds_plant_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wilds_plant_device>
> **爬取时间**: 2025-12-27T01:36:25.555391

---

Used to create plants with explosive pods that players can detonate and launch.

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
| `ExplodeEvent` | `listenable(payload)` | Triggers whenever the plant or launched projectile explodes.   - Sends the `agent` that initially launched the projectile or triggered an immediate explosion. - Sends `false` if no `agent` is found. |
| `GrowEvent` | `listenable(payload)` | Triggers whenever the plant grows. |
| `LaunchEvent` | `listenable(payload)` | Triggers whenever the plant launches a projectile.   - Sends the `agent` that triggered this event. - Sends `false` if no `agent` is found. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wilds_plant_device/disable) | Disables the device to prevent interaction and growth. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wilds_plant_device/enable) | Enables the device to allow interaction and let it grow. |
| [`Explode`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wilds_plant_device/explode) | Detonates the plant if the device is enabled. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Grow`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wilds_plant_device/grow) | Grows the plant if the device is enabled. If *Infinite Regrowths* is `false`, this is limited by *Maximum Regrowths*. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`SetInfiniteRegrowths`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wilds_plant_device/setinfiniteregrowths) | Sets whether the plant can always regrow after launching a projectile or being destroyed. |
| [`SetMaximumRegrowths`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wilds_plant_device/setmaximumregrowths) | Sets how many times the plant can regrow after launching a projectile or being destroyed.   - This applies across the device’s entire lifetime and is unaffected by *Enable* and *Disable*. - This value is clamped. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
