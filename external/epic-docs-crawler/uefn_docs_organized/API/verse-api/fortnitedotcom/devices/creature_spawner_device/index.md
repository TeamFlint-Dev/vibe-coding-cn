# creature_spawner_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creature_spawner_device
> **爬取时间**: 2025-12-27T01:59:59.204373

---

Used to spawn one or more waves of creatures of customizable types at selected time intervals.

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
| `EliminatedEvent` | `listenable(payload)` | Signaled when a creature is eliminated. `Source` is the `agent` that has eliminated the creature. If the creature was eliminated by a non-agent then `Source` is 'false'. `Target` is the creature that was eliminated. |
| `SpawnedEvent` | `listenable(payload)` | Signaled when a creature is spawned. Sends the `agent` creature who was spawned. |

### Functions

| Function Name | Description |
| --- | --- |
| [`DestroySpawner`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creature_spawner_device/destroyspawner) | Destroys this device. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creature_spawner_device/disable) | Disables this device. |
| [`EliminateCreatures`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creature_spawner_device/eliminatecreatures) | Eliminates all creatures spawned by this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creature_spawner_device/enable) | Enables this device. |
| [`GetSpawnLimit`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creature_spawner_device/getspawnlimit) | Returns the spawn limit of the device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`SpawnAt`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creature_spawner_device/spawnat) | Spawn a creature at the given position. When Rotation is not provided, it will default to the Device’s rotation. Returns the agent spawned or false if the device has reached its maximum spawn count. This function is ‘’ because it takes time to load the creature before it can be returned. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
