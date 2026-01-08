# overlord_spire_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device>
> **爬取时间**: 2025-12-27T01:53:36.367083

---

A boss-like environmental encounter that will attack players with different abilities

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
| [`has_spire_functionality`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/has_spire_functionality) | An interface for shared functionality between different spire devices |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `ActivateEvent` | `listenable(payload)` | Triggers when the Spire becomes activated from players entering the `Activation Distance` |
| `ActivationDistance` | `?float` | Determines the distance where approaching players activate the Spire.   - Values are clamped between `500.0` and `10000.0` cm |
| `BeamArc` | `?float` | Determines the distance/angle that the beam will travel   - Values are clamped between `0.0` and `360.0` degrees |
| `BeamCooldownTime` | `?float` | Determines the amount of time that the Spire must wait to use the beam attack after previously using it   - Values are clamped between `0.0` and `60.0` seconds |
| `BeamDamagePerSecondToBuildings` | `?float` | Determines how much total damage the beam attack does per second to buildings.   - Values are clamped between `0.0` and `1000.0` - A portion of the damage is applied multiple times per second while a target is within the beam. |
| `BeamDamagePerSecondToCreatures` | `?float` | Determines how much total damage the beam attack does per second to creatures.   - Values are clamped between `0.0` and `1000.0` - A portion of the damage is applied multiple times per second while a target is within the beam. |
| `BeamDamagePerSecondToGuards` | `?float` | Determines how much total damage the beam attack does per second to guards.   - Values are clamped between `0.0` and `1000.0` - A portion of the damage is applied multiple times per second while a target is within the beam. |
| `BeamDamagePerSecondToPlayers` | `?float` | Determines how much total damage the beam attack does per second to players.   - Values are clamped between `0.0` and `1000.0` - A portion of the damage is applied multiple times per second while a target is within the beam. |
| `BeamDamagePerSecondToVehicles` | `?float` | Determines how much total damage the beam attack does per second to vehicles.   - Values are clamped between `0.0` and `1000.0` - A portion of the damage is applied multiple times per second while a target is within the beam. |
| `BeamDamagePerSecondToWildlife` | `?float` | Determines how much total damage the beam attack does per second to wildlife.   - Values are clamped between `0.0` and `1000.0` - A portion of the damage is applied multiple times per second while a target is within the beam. |
| `BeamDuration` | `?float` | Determines how long the Spire takes to complete the beam attack   - Values are clamped between `1.0` and `60.0` seconds |
| `BeginBeamEvent` | `listenable(payload)` | Triggers when the Spire begins charging up its beam attack |
| `BeginHomingProjectileEvent` | `listenable(payload)` | Triggers when the Spire starts spawning homing projectiles to fire |
| `BeginScreamEvent` | `listenable(payload)` | Triggers when the Spire begins to perform the scream. |
| `BeginSlamEvent` | `listenable(payload)` | Triggers when the Spire begins its slam attack |
| `BeginSlamRecoverEvent` | `listenable(payload)` | Triggers when the Spire begins trying to recover from the slam attack, when the appendage weakpoint is stuck in the ground. |
| `DeactivateEvent` | `listenable(payload)` | Triggers when the Spire becomes deactivated, either from players leaving the `Activation Distance` |
| `DestroyEvent` | `listenable(payload)` | Triggers when the Spire is destroyed from damage or events   - Includes the `agent` that destroyed it, if any. |
| `EndBeamEvent` | `listenable(payload)` | Triggers when the Spire finishes shooting its beam attack |
| `EndHomingProjectileEvent` | `listenable(payload)` | Triggers when the last homing projectile has exploded |
| `EndScreamEvent` | `listenable(payload)` | Triggers when the Spire has finished performing the scream |
| `EndSlamEvent` | `listenable(payload)` | Triggers when the Spire has finished recovering from the slam attack |
| `EndSlamRecoverEvent` | `listenable(payload)` | Triggers when the Spire finishes recovering from the slam attack and the appendage weakpoint is no longer stuck in the ground. |
| `Health` | `?float` | The Spire's current health. Clamped between 0 and `MaxHealth`.   - Setting this value does nothing if the Spire is destroyed. |
| `HomingProjectileCooldownTime` | `?float` | Determines the amount of time that the Spire must wait to use the homing projectile attack after previously using it   - Values are clamped between `0.0` and `60.0` seconds |
| `HomingProjectileDamageCreatures` | `?float` | Determines how much total damage the homing projectile attack does to creatures.   - Values are clamped between `0.0` and `10000.0` |
| `HomingProjectileDamageToBuildings` | `?float` | Determines how much total damage the homing projectile attack does to buildings.   - Values are clamped between `0.0` and `10000.0` |
| `HomingProjectileDamageToGuards` | `?float` | Determines how much total damage the homing projectile attack does to guards.   - Values are clamped between `0.0` and `10000.0` |
| `HomingProjectileDamageToPlayers` | `?float` | Determines how much total damage the homing projectile attack does to players.   - Values are clamped between `0.0` and `10000.0` |
| `HomingProjectileDamageToVehicles` | `?float` | Determines how much total damage the homing projectile attack does to vehicles.   - Values are clamped between `0.0` and `10000.0` |
| `HomingProjectileDamageWildlife` | `?float` | Determines how much total damage the homing projectile attack does to wildlife.   - Values are clamped between `0.0` and `10000.0` |
| `HomingProjectileMaxSpeed` | `?float` | Determines the maximum speed that homing projectiles can accelerate to.   - Values are clamped between `100.0` and `5000.0` meters per second |
| `IsBeamAttackEnabled` | `?logic` | Determines if the Spire is able to use the beam attack. Setting this to false will not interrupt the attack if it is currently in progress. |
| `IsHomingProjectileAttackEnabled` | `?logic` | Determines if the Spire is able to use the homing projectile attack. Setting this to false will not interrupt the attack if it is currently in progress. |
| `IsScreamAttackEnabled` | `?logic` | Determines if the Spire is able to perform the scream attack.   - The scream is an ability used when the spire drops below a health threshold. It performs an animation and events can be hooked up to it for things like spawning a wave of Guards to fight for it. - Setting this to false will not interrupt the ability if it is currently in progress. |
| `IsSlamAttackEnabled` | `?logic` | Determines if the Spire is able to use the slam attack. Setting this to false will not interrupt the attack if it is currently in progress. |
| `MaxHealth` | `?float` | The maximum health of this Spire. |
| `MaximumTimeBetweenAbilities` | `?float` | Determines the maximum amount of time that the Spire must wait to use another ability after previously using one   - The actual time to wait after each ability is chosen at random between this value and MinimumTimeBetweenAbilities - This is effectively a global cooldown across all abilities. - Values are clamped between `0.0` and `60.0` seconds |
| `MinimumTimeBetweenAbilities` | `?float` | Determines the minimum amount of time that the Spire must wait to use another ability after previously using one   - The actual time to wait after each ability is chosen at random between this value and MaximumTimeBetweenAbilities - This is effectively a global cooldown across all abilities. - Values are clamped between `0.0` and `60.0` seconds |
| `NumberOfHomingProjectiles` | `?int` | Determines the number of homing projectiles that can be fired per attack.   - Values are clamped between `1` and `20` projectiles |
| `ShowMapIcon` | `?logic` | Determines if a Spire-specific icon should be displayed on the map while the Spire is spawned |
| `SlamAttackDamageCreatures` | `?float` | Determines how much total damage the slam attack does to creatures.   - Values are clamped between `0.0` and `10000.0` |
| `SlamAttackDamageToBuildings` | `?float` | Determines how much total damage the slam attack does to buildings.   - Values are clamped between `0.0` and `10000.0` |
| `SlamAttackDamageToGuards` | `?float` | Determines how much total damage the slam attack does to guards.   - Values are clamped between `0.0` and `10000.0` |
| `SlamAttackDamageToPlayers` | `?float` | Determines how much total damage the slam attack does to players.   - Values are clamped between `0.0` and `10000.0` |
| `SlamAttackDamageToVehicles` | `?float` | Determines how much total damage the slam attack does to vehicles.   - Values are clamped between `0.0` and `10000.0` |
| `SlamAttackDamageWildlife` | `?float` | Determines how much total damage the slam attack does to wildlife.   - Values are clamped between `0.0` and `10000.0` |
| `SlamCooldownTime` | `?float` | Determines the amount of time the Spire must wait to use the slam attack after previously using it   - Values are clamped between `0.0` and `60.0` seconds |
| `SlamInitialRadius` | `?float` | Determines the radius that the slam attack initially affects before the shockwave spreads.   - Values are clamped between `100.0` and `1000.0` meters |
| `SlamRecoveryTime` | `?float` | Determines the amount of time it takes for the Spire to recover from the slam attack.   - Values are clamped between `0.0` and `60.0` seconds - The higher the value, the longer the weakpoint is exposed. |
| `SlamShockwaveDuration` | `?float` | Determines the time it takes for the slam attack's shockwave to reach the maximum radius.   - Values are clamped between `1.0` and `30.0` seconds |
| `SlamShockwaveMaxRadius` | `?float` | Determines the maximum radius that the slam attack's shockwave can spread   - Values are clamped between `100.0` and `5000.0` meters |
| `SpawnEvent` | `listenable(payload)` | Triggers when the Spire is spawned, either from players entering the `Activation Distance` or by events. |
| `TargetChangeEvent` | `listenable(payload)` | Triggers when the Spire’s player target is changed to a different player |
| `WaitForAllProjectilesToSpawnBeforeNextAttack` | `?logic` | Succeeds if the Spire must wait until all projectiles have spawned before moving on to the next attack   - Fails if the Spire will move on to the next attack when it finishes the spawning animation. - This setting is useful to make the encounter more challenging by allowing the Spire to shoot a large number of homing projectiles and to move on to another attack while they are still spawning |

### Functions

| Function Name | Description |
| --- | --- |
| [`ClearTarget`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/cleartarget) | Removes the target set from `SetTarget` and allows the Spire to return to its normal targeting pattern |
| [`Destroy`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/destroy) | Sets the Spire's health to zero, destroying it.   - Does nothing if the Spire has not spawned or is already destroyed. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/disable) | Disable the device which causes the Spire to become deactivated, stopping the behaviors and attacks, as well as preventing activation when players are within the `Activation Distance`.   - Does nothing if the Spire is destroyed or already disabled. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/enable) | Enable the device, causing the Spire to become activated when players are within the `Activation Distance`.   - Does nothing if the Spire is destroyed or already enabled. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`HideClouds`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/hideclouds) | Fades out the preview clouds above where the Spire spawns. |
| [`IsActivated`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/isactivated) | If this Spire is currently activated.   - Succeeds if activated. Fails if deactivated - An activated will react to enemies and take damage \* Becomes activated from being enabled and players entering the `Activation Distance` |
| [`IsDestroyed`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/isdestroyed) | Succeeds if this Spire's health has reached 0. Fails otherwise |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/isenabled) | Succeeds if the device is enabled. Fails if the Spire is disabled. While disabled, the Spire is deactivated and will not react to approaching players, nor take damage. |
| [`IsSpawned`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/isspawned) | Succeeds if this Spire is in a spawned state. Fails if the Spire is destroyed or has not spawned. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/reset) | Resets the Spire to its initial state. |
| [`SetTarget`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/settarget) | Sets the main target of the Spire, causing the Spire to focus attacks on the 'TargetAgent' while they are within the `Activation Distance`.   - `TargetAgent` is an invalid `agent`, this function will clear the target. |
| [`ShowClouds`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/showclouds) | Fades in the preview clouds above where the Spire spawns. |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/overlord_spire_device/spawn) | Spawns the Spire, causing it to become visible and enabling collision   - Does nothing if the Spire is already spawned or destroyed |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
