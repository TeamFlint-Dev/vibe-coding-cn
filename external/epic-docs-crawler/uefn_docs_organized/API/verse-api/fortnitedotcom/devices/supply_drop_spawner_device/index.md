# supply_drop_spawner_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/supply_drop_spawner_device>
> **爬取时间**: 2025-12-27T01:35:30.639382

---

Used to spawn and configure an aerial supply drop that can provide players with customized weapons/supplies.

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
| `BalloonPoppedEvent` | `listenable(payload)` | Signaled when the balloon on the supply crate is popped. Sends the `?agent` that popped the balloon. If no `agent` popped the balloon returns `false`. |
| `DestroyCrateEvent` | `listenable(payload)` | Signaled when the supply crate is destroyed. Sends the destroying `agent`. If no `agent` destroyed the crate then `false` is returned. |
| `LandingEvent` | `listenable(payload)` | Signaled when the supply crate lands for the first time. |
| `OpenedEvent` | `listenable(payload)` | Signaled when the supply crate is opened. Sends the `agent` that opened the crate. |

### Functions

| Function Name | Description |
| --- | --- |
| [`DestroyBalloon`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/supply_drop_spawner_device/destroyballoon) | Destroys the balloon and causes the supply crate to freefall. |
| [`DestroySpawnedDrops`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/supply_drop_spawner_device/destroyspawneddrops) | Destroys supply drops spawned by this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Lock`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/supply_drop_spawner_device/lock) | Locks the supply crate so `agent`s cannot open it. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Open`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/supply_drop_spawner_device/open) | Opens the supply crate, ignoring the locked or unlocked state. `Agent` acts as the instigator of the open action. |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/supply_drop_spawner_device/spawn) | Spawns a supply drop provided one hasn't already spawned. *Owning Team* is set to `Agent`'s team. |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/supply_drop_spawner_device/spawn-1) | Spawns a supply drop provided one hasn't already spawned. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`Unlock`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/supply_drop_spawner_device/unlock) | Unlocks the supply crate so `agent`s can open it. |
