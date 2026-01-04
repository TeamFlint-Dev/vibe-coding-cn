# spire_spike_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/spire_spike_device
> **爬取时间**: 2025-12-27T01:36:07.678285

---

A Destroyable environment prop that when destroyed, drops loot. When players approach the Spire Spike, they start a countdown to a knockback ability. When players are knocked back, they do not receive damage from the knockback ability or take fall damage. They can destroy structures near the knockback location. Damaging the spike can also start the countdown to the knockback or restart the countdown if it is already started.

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
| `AdditionalVerticalKnockback` | `?float` | Additive vertical force on the knockback ability. Clamped between `0.0` and `100.0`. |
| `CanGrantItems` | `?logic` | Determine if the Spire Spike should drop loot when destroyed or not. |
| `CurrentHealth` | `?float` | The current health of the Spire Spike. Setting to `0.0` or negative will destroy the Spire Spike. Clamps to the maximum of MaxHealth. |
| `DestroyEvent` | `listenable(payload)` | Triggers when the Spire Spike is destroyed. Includes the `agent` that destroyed it, if any. |
| `HorizontalKnockbackMultiplier` | `?float` | Horizontal force on the knockback ability. Clamped between `0.0` and `100.0`. |
| `IsInvulnerable` | `?logic` | Determines if the Spire Spike can take any damage. |
| `KnockbackChargeTimer` | `?float` | The remaining time (in seconds) on the knockback charge timer. Clamped between `0.0` and `60.0`.   - When setting, this also sets the length of this Spire Spike's future knockback charge timers. - If there is no active timer, getting returns `0.0`. |
| `KnockbackChargeTimerLength` | `?float` | The length of the knockback charge timer in seconds, regardless of the timer's current state. Clamped between `0.0` and `60.0`. |
| `KnockbackEvent` | `listenable(payload)` | Triggers when the Spire Spike does its knockback ability. |
| `KnockbackTriggerRange` | `?float` | The range (in meters) a player needs to be within to trigger the proximity countdown. This is also the range of the knockback abilities affected targets. Clamped between `2.0` and `10.0`. |
| `MaxHealth` | `?float` | The max health of the Spire Spike. Must be greater than or equal to `1.0`. Current health will be scaled up or down based on the scale difference between the old and new MaxHealth. |
| `ShouldChargeKnockbackOnPlayerProximity` | `?logic` | Determines if the knockback ability should charge once a player has entered the trigger range. |
| `ShouldKnockbackChargeFromTakingDamage` | `?logic` | Determines if taking damage should start the knockback charge timer. If the timer was already active and this is true, taking damage will restart the timer. |
| `ShouldKnockbackDestroyStructures` | `?logic` | Determines if structures should be destroyed if a player is knocked back into them. |
| `VerticalKnockbackMultiplier` | `?float` | Vertical force on the knockback ability. Clamped between `0.0` and `100.0`. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ChargeKnockback`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/spire_spike_device/chargeknockback) | Force begins the knockback charge timer. Will restart the charge timer if already active. |
| [`Despawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/spire_spike_device/despawn) | Despawns the Spire Spike. It will not drop loot. |
| [`Destroy`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/spire_spike_device/destroy) | Destroy the Spire Spike. Will cause the Spire Spike to drop its loot. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsSpawned`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/spire_spike_device/isspawned) | Returns if Spire Spike is currently spawned. |
| [`Knockback`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/spire_spike_device/knockback) | Force the Spire Spike to trigger its knockback ability immediately. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/spire_spike_device/spawn) | Spawn the Spire Spike. Resets CurrentHealth back to max health. Resets any timers currently active. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
