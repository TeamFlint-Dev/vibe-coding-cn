# carryable_spawner_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device
> **爬取时间**: 2025-12-27T01:52:01.959834

---

Used to spawn a carryable object into the experience.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |

## Exposed Interfaces

This class exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`enableable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/enableable) | Implemented by classes whose instances can be enabled and disabled. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `AgentCollideEvent` | `listenable(payload)` | Signaled when the carryable collides with an agent. Damage applied is based off the collision velocity, as well as the device's *Impact Damage* settings. This event will fire even if the damage applied is 0. |
| `CanTakeDamage` | `?logic` | Maps to the device option for *Takes Damage*. Whether or not the carryable takes damage / can be destroyed. |
| `CarryableObjectTransform` | `??transform` | The carryable transform, if the carryable exists in-world. |
| `CarryingAgent` | `??agent` | The `agent` carrying the carryable, if one exists. |
| `DropEvent` | `listenable(payload)` | Signaled when `agent` drops the carryable. Includes manual drop as well as force drop, which can occur on entering a state that doesn't support carrying, such as elimination. |
| `ExplodeEvent` | `listenable(payload)` | Signaled when the carryable explodes. Returns the instigating `agent`, if one exists.   - The `agent` provided to the *Explode* function, or the agent who dealt lethal damage to the carryable. - Otherwise, the `agent` who most recently carried the item.   Returns an array of `agent`s affected by the explosion. |
| `ExplosionDamage` | `?float` | Maps to the device option for *Explosion Character Damage*. Describes how much damage is done to characters caught in the carryable explosion. |
| `ExplosionEnvironmentalDamage` | `?float` | Maps to the device option for *Explosion Environmental Damage*. Describes how much damage is done to world objects caught in the carryable explosion. |
| `ExplosionImpulse` | `?float` | Maps to the device option for *Explosion Impulse*. Describes the strength of the knockback impulse applied by the carryable explosion. |
| `ExplosionRadius` | `?float` | Maps to the device option for *Explosion Radius*. Describes the radius (in meters) of the carryable explosion. |
| `ImpactDamage` | `?float` | Maps to the device option for *Impact Character Damage*. Describes how much damage is done to characters hit by the carryable. This value is scaled by the impact magnitude to calculate the applied damage. |
| `ImpactEnvironmentalDamage` | `?float` | Maps to the device option for *Impact Environmental Damage*. Describes how much damage is done to world objects hit by the carryable. This value is scaled by the impact magnitude to calculate the applied damage. |
| `InitialSpawnAngle` | `?float` | Maps to the device option for *Initial Spawn Angle*. The angle (in degrees) of the cone from which the carryable will be randomly tossed when it first spawns. |
| `InitialSpawnVelocity` | `?float` | Maps to the device option for *Initial Spawn Velocity*. The velocity (in meters per second) applied to the carryable when it first spawns. |
| `PickUpEvent` | `listenable(payload)` | Signaled when `agent` picks up the carryable. |
| `ReleaseEvent` | `listenable(payload)` | Signaled when `agent` stops carrying the carryable. This includes dropping, throwing, despawning, or force pickup by another player. |
| `SpawnEvent` | `listenable(payload)` | Signaled when the carryable spawns, either by the `Spawn` function, or by timer. |
| `StartingHealth` | `?float` | Maps to the device option for *Starting Health*. Describes how much health the carryable spawns with. |
| `ThrowEvent` | `listenable(payload)` | Signaled when `agent` throws the carryable. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Despawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/despawn) | Despawn the carryable, if it exists. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/disable) | Disables this device, preventing it from listening for inputs and sending events. When disabled, the carryable is unspawned, if it exists. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/enable) | Enables this device, allowing it to listen for inputs and send events. |
| [`Explode`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/explode) | Explode the carryable, if it exists. |
| [`Explode`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/explode-1) | Explode the carryable, if it exists. Assigns the provided `agent` as the explosion instigator. |
| [`ForcePlayerToCarry`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/forceplayertocarry) | Forces the carryable to be carried by the provided `player`, teleporting it into their hands. If not in a viable state to carry the item (such as in a vehicle), or if the `player` fails the device's filters, it is ignored. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/isenabled) | Succeeds if the object is enabled, fails if it is disabled. |
| [`IsSpawned`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/isspawned) | Fails if the carryable does not exist in-world. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`SetCarryableMaterial`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/setcarryablematerial) | Set the material of the carryable. Index describes which material index on the mesh the material will apply to. This will update immediately if already spawned, and also apply to any carryable spawned from this device in the future. |
| [`SetCarryableMesh`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/setcarryablemesh) | Set the mesh of the carryable. This will update immediately if already spawned, and also apply to any carryable spawned from this device in the future. |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/spawn) | Spawn the carryable from the device if it doesn't currently exist. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
