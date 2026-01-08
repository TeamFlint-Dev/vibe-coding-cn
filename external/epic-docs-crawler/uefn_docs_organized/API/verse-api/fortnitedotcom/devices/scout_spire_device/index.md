# scout_spire_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device>
> **爬取时间**: 2025-12-27T02:00:20.428825

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
| `BeginChargeLaserEvent` | `listenable(payload)` | Triggers when the Spire begins its laser attack |
| `DeactivateEvent` | `listenable(payload)` | Triggers when the Spire becomes deactivated, either from players leaving the `Activation Distance` |
| `DestroyEvent` | `listenable(payload)` | Triggers when the Spire is destroyed from damage or events   - Includes the `agent` that destroyed it, if any. |
| `EndChargeAndFireLaserEvent` | `listenable(payload)` | Triggers when the Spire shoots its laser attack. Triggers once, even if it shoots at multiple targets |
| `Health` | `?float` | The Spire's current health. Clamped between 0 and `MaxHealth`.   - Setting this value does nothing if the Spire is destroyed. |
| `IsShieldActive` | `?logic` | If the invulnerable shield for this Spire is active. While active, the Spire cannot take damage.   - Setting this value does nothing if the Spire is destroyed. |
| `LaserAdditionalVerticalImpulseForce` | `?float` | Determines the additive vertical force of the impulse applied to targets of the laser attack.   - Values are clamped between `0.0` and `10000.0` |
| `LaserAttackDamageToBuildings` | `?float` | Determines how much total damage the laser attack does to buildings.   - Values are clamped between `0.0` and `10000.0` |
| `LaserAttackDamageToCreatures` | `?float` | Determines how much total damage the laser attack does to creatures.   - Values are clamped between `0.0` and `10000.0` |
| `LaserAttackDamageToGuards` | `?float` | Determines how much total damage the laser attack does to guards.   - Values are clamped between `0.0` and `10000.0` |
| `LaserAttackDamageToPlayers` | `?float` | Determines how much total damage the laser attack does to players.   - Values are clamped between `0.0` and `10000.0` |
| `LaserAttackDamageToVehicles` | `?float` | Determines how much total damage the laser attack does to vehicles.   - Values are clamped between `0.0` and `10000.0` |
| `LaserAttackDamageToWildlife` | `?float` | Determines how much total damage the laser attack does to wildlife.   - Values are clamped between `0.0` and `10000.0` |
| `LaserChargeTime` | `?float` | Determines the time it takes for the Spire to charge up its laser attack.   - Values are clamped between `0.5` and `60.0` |
| `LaserCooldownTime` | `?float` | Determines the amount of time that the Spire must wait to use the laser attack after previously using it.   - Values are clamped between `0.5` and `60.0` |
| `LaserEffectRadius` | `?float` | Determines the radius of the blast from where the laser hits.   - Values are clamped between `100.0` and `1000.0` |
| `LaserHorizontalImpulseForce` | `?float` | Determines the multiplicative horizontal force of the impulse applied to targets of the laser attack based on distance.   - Values are clamped between `0.0` and `10000.0` |
| `LasersPerCharge` | `?int` | Determines the number of targets the Spire can shoot lasers at per charged attack.   - Values are clamped between `1` and `50` |
| `LaserVerticalImpulseForce` | `?float` | Determines the multiplicative vertical force of the impulse applied to targets of the laser attack based on distance.   - Values are clamped between `0.0` and `10000.0` |
| `MaxHealth` | `?float` | The maximum health of this Spire. |
| `ShowMapIcon` | `?logic` | Determines if a Spire-specific icon should be displayed on the map while the Spire is spawned. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Despawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device/despawn) | Hides the spire immediately without playing any vfx   - Does nothing if the Spire is already destroyed or despawned. |
| [`Destroy`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device/destroy) | Sets the Spire's health to zero, destroying it.   - Does nothing if the Spire has not spawned or is already destroyed. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device/disable) | Disable the device which causes the Spire to become deactivated, stopping the behaviors and attacks, as well as preventing activation when players are within the `Activation Distance`.   - Does nothing if the Spire is destroyed or already disabled. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device/enable) | Enable the device, causing the Spire to become activated when players are within the `Activation Distance`.   - Does nothing if the Spire is destroyed or already enabled. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsActivated`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device/isactivated) | If this Spire is currently activated.   - Succeeds if activated. Fails if deactivated - An activated Spire will react to enemies and take damage \* Becomes activated from being enabled and players entering the `Activation Distance` |
| [`IsDestroyed`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device/isdestroyed) | Succeeds if this Spire's health has reached 0. Fails otherwise. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device/isenabled) | Succeeds if the Spire is enabled and fails if it is disabled.   - While disabled, the Spire is inactive: it will not react to players or take damage. - If the Spire is currently despawned, this function instead reports the enabled state the Spire will have the next time it is spawned. |
| [`IsSpawned`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device/isspawned) | Succeeds if this Spire is in a spawned state. Fails if the Spire is destroyed or has not spawned. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device/reset) | Resets the Spire to its initial state. |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device/spawn) | Spawns the Spire, causing it to become visible and enabling collision   - Does nothing if the Spire is already spawned or destroyed. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
