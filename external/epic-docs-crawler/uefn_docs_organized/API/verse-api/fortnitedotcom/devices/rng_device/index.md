# rng_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rng_device>
> **爬取时间**: 2025-12-27T01:56:23.951024

---

Used to generate random numbers between a minimum and maximum value. Events are signaled when numbers are generated.

- *Value Limit 1* is the minimum value for generation.
- *Value Limit 2* is the maximum value for generation.

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
| `LoseEvent` | `listenable(payload)` | Signaled when the generated number < *Winning Value*. |
| `RolledMaxEvent` | `listenable(payload)` | Signaled when the generated number = maximum. |
| `RolledMinEvent` | `listenable(payload)` | Signaled when the generated number = minimum. |
| `WinEvent` | `listenable(payload)` | Signaled when the generated number >= *Winning Value*. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Activate`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rng_device/activate) | Randomly generate a number between *Value Limit 1* and *Value Limit 2*.   - If the number is >= *Winning Value* then `WinEvent` is fired. - If the number is < *Winning Value* then `LoseEvent` is fired. - If the number = minimum then `RolledMinEvent` is fired. - If the number = maximum then `RolledMaxEvent` is fired. - `Agent` is used as the Instigator of the roll event. |
| [`Activate`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rng_device/activate-1) | Randomly roll a number within the configured min + max value range.   - If the number is >= *Winning Value* then `WinEvent` is fired. - If the number is < *Winning Value* then `LoseEvent` is fired. - If the number = minimum then `RolledMinEvent` is fired. - If the number = maximum then `RolledMaxEvent` is fired. |
| [`Cancel`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rng_device/cancel) | Cancels the active number generation. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rng_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rng_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
