# wildlife_spawner_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device>
> **爬取时间**: 2025-12-27T01:53:05.237940

---

Used to customize the properties of NPCs spawned by this device.
Changing properties will only affect newly spawned wildlife creatures.

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
| `CanRide` | `?logic` | If true, agents can ride the wildlife creature. |
| `CanTame` | `?logic` | If true and the wildlife creature supports being tamed, agents can tame the NPC. |
| `Damage` | `??float` | If a value is given, the `Damage` value of the wildlife creature is overridden. If an override is not specified, the default `Damage` of the wildlife creature is used. This value is clamped between 1.0 and 500.0. |
| `DamagedEvent` | `listenable(payload)` | Signaled when wildlife is damaged. `Source` is the `agent` that damaged the wildlife. If the wildlife was damaged by a non-agent then `false` is returned. `Target` is the wildlife that was damaged. |
| `DamageToEnvironment` | `??float` | If a value is given, the `Damage` value of the wildlife creature is overridden when damaging the environment. If an override is not specified, the default `Damage` of the wildlife creature is used. This value is clamped between 1.0 and 500.0. |
| `DamageToPlayer` | `??float` | If a value is given, the `Damage` value of the wildlife creature is overridden when damaging players. If an override is not specified, the default `Damage` of the wildlife creature is used. This value is clamped between 1.0 and 500.0. |
| `DismountedEvent` | `listenable(payload)` | Signaled when an `agent` dismounts wildlife. `Source` is the `agent` that dismounted the wildlife. `Target` is the wildlife that was dismounted. |
| `EliminatedEvent` | `listenable(payload)` | Signaled when wildlife is eliminated. `Source` is the `agent` that eliminated the wildlife. If the wildlife was eliminated by a non-agent, or because the oldest wildlife was eliminated as Spawn function was called after spawn count was exceeded, then `Source` is 'false'. `Target` is the wildlife that was eliminated. |
| `EliminatingEvent` | `listenable(payload)` | Signaled when a wildlife eliminates an agent. `Source` is the wildlife that eliminated the agent. `Target` is the agent that was eliminated. |
| `EnergyConsumptionAmount` | `?int` | The amount of riding energy that is consumed when the `ConsumeEnergy` function is called. This value is clamped between 0 and 100. |
| `EnergyRestorationAmount` | `?int` | The amount of riding energy that is restored when the `RestoreEnergy` function is called. This value is clamped between 0 and 100. |
| `ForceSpawnedEvent` | `listenable(payload)` | Signaled when wildlife is force-spawned and causes the oldest wildlife to be eliminated. Sends the `agent` wildlife that was spawned. |
| `InitialEnergy` | `?int` | The amount of riding energy the wildlife creature spawns with. This value is clamped between 0 and 100. |
| `Invincible` | `?logic` | Whether the NPC can receive damage. |
| `MaxEnergy` | `?int` | The maximum riding energy the wildlife creature spawns with. This value is clamped between 0 and 100. |
| `MaxHealth` | `??float` | If a value is given, the `MaxHealth` value of the wildlife creature is overridden. If an override is not specified, the default Health of the wildlife creature is used. This value is clamped between 1.0 and 10000.0. |
| `PreventDismount` | `?logic` | If true, agents cannot manually use the interact action to dismount from the wildlife creature. |
| `RiddenEvent` | `listenable(payload)` | Signaled when an `agent` rides wildlife. `Source` is the `agent` that started riding the wildlife. `Target` is the wildlife that was ridden. |
| `SomethingIsEatenEvent` | `listenable(payload)` | Signaled when wildlife eats a pickup such as a Shroom or Meat. Sends the wildlife that ate something. |
| `SpawnedEvent` | `listenable(payload)` | Signaled when this device spawns wildlife. Sends the `agent` wildlife that was spawned. |
| `SpeedMultiplier` | `?float` | If a value is given, the `SpeedMultiplier` value is applied to the default speed of the wildlife creature. If an override is not specified, the wildlife creature moves at its default speed. This value is clamped between 0.1 and 2.0. |
| `TamedEvent` | `listenable(payload)` | Signaled when wildlife is tamed. `Source` is the `agent` that tamed the wildlife. `Target` is the wildlife that was tamed. |
| `TamedFollowDistance` | `??float` | Distance in meters from the player who tamed it that the wildlife creature will try to stay within. If a value is given, the `TamedFollowDistance` value of the wildlife creature is overridden. If an override is not specified, the default `TamedFollowDistance` of the wildlife creature is used. This value is clamped between 2.0 and 30.0. |
| `UntamedEvent` | `listenable(payload)` | Signaled when wildlife is untamed. `Source` is the `agent` that tamed the wildlife. `Target` is the wildlife that was untamed. |
| `WanderRange` | `??float` | Distance in meters from its spawn position from which the wildlife creature will peacefully roam. If a value is given, the `WanderRange` value of the wildlife creature is overridden. If an override is not specified, the default `WanderRange` of the wildlife creature is used. This value is clamped between 10.0 and 100.0. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ConsumeEnergy`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/consumeenergy) | Consumes energy from wildlife belonging to `Agent` by *Energy Consume Amount*. |
| [`ConsumeEnergyForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/consumeenergyforall) | Consumes energy from wildlife by *Energy Consume Amount*. |
| [`Despawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/despawn) | Despawns wildlife. `Agent` is marked as the one who eliminated the wildlife. |
| [`DestroySpawner`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/destroyspawner) | Destroys this device, marking `Agent` as the destroyer of the device. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/disable) | Disables this device. |
| [`Dismount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/dismount) | Dismounts `Agent` from wildlife. |
| [`DismountAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/dismountall) | Dismounts all `agent`s from wildlife. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/enable) | Enables this device. |
| [`GetAgents`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/getagents) | Get all agents created by this device. |
| [`GetSpawnLimit`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/getspawnlimit) | Returns the spawn limit of the device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/reset) | Resets the count on the *Total Spawn Count* option. |
| [`RestoreEnergy`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/restoreenergy) | Restores energy to wildlife belonging to `Agent` by *Energy Restore Amount*. |
| [`RestoreEnergyForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/restoreenergyforall) | Restores energy to wildlife by *Energy Restore Amount*. |
| [`Ride`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/ride) | Teleports `Agent` to the nearest wildlife, then `Agent` mounts that wildlife. |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/spawn) | Spawns wildlife from this device. If spawn count is exceeded the oldest wildlife will be eliminated. |
| [`SpawnAt`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/spawnat) | Spawn a creature at the given position. When Rotation is not provided, it will default to the Device`s rotation. Returns the agent spawned or false if the device has reached its maximum spawn count. This function is` ` because it takes time to load the NPC before it can be returned. |
| [`Tame`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/tame) | Tames wildlife, making them AI partners of `Agent`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`Untame`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/untame) | Untames any tamed wildlife that belong to `Agent`. |
| [`UntameAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/untameall) | Untames all wildlife. |
