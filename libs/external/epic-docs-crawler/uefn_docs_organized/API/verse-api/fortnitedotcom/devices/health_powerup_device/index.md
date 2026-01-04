# health_powerup_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/health_powerup_device
> **爬取时间**: 2025-12-27T01:55:03.901563

---

Used to regenerate an `agent`'s health and/or shields.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |
| [`powerup_device`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/powerup_device) | Base class for various powerup devices offering common events like `ItemPickedUpEvent`. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `ItemPickedUpEvent` | `listenable(payload)` | Signaled when the powerup is picked up by an `agent`. Sends the `agent` that picked up the powerup. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Despawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/powerup_device/despawn) | Despawns this powerup from the experience. |
| [`GetDuration`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/powerup_device/getduration) | Returns the *Duration* that this powerup will be active for on any player it is applied to. |
| [`GetMagnitude`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/health_powerup_device/getmagnitude) | Returns the current *Magnitude* for the powerup. For the Health Powerup, this is the amount of health or shield that the powerup will add or remove, |
| [`GetRemainingTime`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/powerup_device/getremainingtime) | If the `Agent` has the effect applied to them, this will return the remaining time the effect has. Returns -1.0 if the effect has an infinite duration. Returns 0.0 if the `Agent` does not have the effect applied. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`HasEffect`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/powerup_device/haseffect) | Returns the `Agent` has the powerup's effect (or another of the same type) applied to them. |
| [`IsSpawned`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/powerup_device/isspawned) | Succeeds if the powerup is currently spawned. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Pickup`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/powerup_device/pickup) | Grants this powerup to `Agent`. |
| [`Pickup`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/powerup_device/pickup-1) | Grants this powerup without an agent reference. Requires *Apply To* set to *All Players*. |
| [`SetDuration`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/powerup_device/setduration) | Updates the *Duration* for this powerup, clamped to the Min and Max defined in the device. Will not apply to any currently applied effects. |
| [`SetMagnitude`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/health_powerup_device/setmagnitude) | Sets the *Magnitude* for this powerup, clamped to the Min and Max defined in the device. Will not apply to any currently applied effects. For the Health Powerup, this is the amount of health or shield that the powerup will add or remove, |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/powerup_device/spawn) | Spawns the powerup into the experience so users can interact with it. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
