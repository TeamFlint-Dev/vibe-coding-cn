# roly_poly_spawner_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly_spawner_device
> **爬取时间**: 2025-12-27T01:38:03.864298

---

Device for spawning a Roly Poly

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
| `AutomaticRespawn` | `?logic` | If true, when a Roly Poly flees while the spawner is enabled, a new one will spawn after RespawnDelay. |
| `BuckPlayerWhenDamaged` | `?logic` | Determines if the Roly Poly will remove the player when it takes damage. |
| `CanBeFrightened` | `?logic` | Determines if the Roly Poly will curl up and hide when attacked. |
| `DismissOnDisabled` | `?logic` | If true, disabling the spawner immediately dismisses the active roly poly. |
| `DismountEvent` | `listenable(payload)` | Signaled when an 'agent' exits a spawned Roly Poly. Sends the 'agent' that exited the Roly Poly. |
| `FleeEvent` | `listenable(payload)` | Signaled when a spawned Roly Poly flees. |
| `FrightenEvent` | `listenable(payload)` | Signaled when an 'agent' causes the spawned Roly Poly to curl up and hide. |
| `Invulnerable` | `?logic` | Determines if Roly Poly will take damage when hit. |
| `MaxHealth` | `?float` | Determines how much damage the Roly Poly will take before fleeing. |
| `RespawnDelay` | `?float` | Seconds to wait before respawning after a flee when AutomaticRespawn is true. |
| `RideEvent` | `listenable(payload)` | Signaled when an 'agent' enters a spawned Roly Poly. Sends the 'agent' that entered the Roly Poly. |
| `SelfSootheEnabled` | `?logic` | Determines if frightened Roly Poly will open up on its own. |
| `SelfSootheTime` | `?float` | Determines the time in seconds that the Roly Poly will stay curled up and hide before opening up on its own. |
| `SootheEvent` | `listenable(payload)` | Signaled when an 'agent' causes the spawned Roly Poly to open up after being scared. |
| `SootheTime` | `?float` | Determines the time in seconds that the player needs to soothe the Roly Poly before it opens up. |
| `SpawnEvent` | `listenable(payload)` | Signaled when a Roly Poly is spawned or respawned by this device. |
| `SpawnOnEnabled` | `?spawn_on_enable_behavior` | If not Never, enabling the spawner immediately spawns a Roly Poly, IfNone will only spawn there is no active Roly Poly. |
| `StartFrightened` | `?logic` | Determines if the Roly Poly will spawn in curled up. |
| `StartingEnergy` | `?float` | Determines the amount of energy the Roly Poly will spawn with. |
| `UnlimitedEnergy` | `?logic` | Determines if the Roly Poly will get tired and leave after rolling around. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly_spawner_device/disable) | Disable the spawner: dismiss the active Roly Poly (if 'DismissOnDisabled' is true) and prevent any further spawns. Any pending respawn timers are cancelled. |
| [`Dismiss`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly_spawner_device/dismiss) | Dismiss the active Roly Poly if present. If 'AutomaticRespawn' is true, a respawn timer for 'RespawnDelay' seconds will be created. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly_spawner_device/enable) | Enable the spawner. While enabled, the spawner maintains at most one active Roly Poly. |
| [`GetActiveRolyPoly`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly_spawner_device/getactiverolypoly) |  |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly_spawner_device/isenabled) | Succeeds if the Spawner is enabled, fails if it's disabled. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Ride`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly_spawner_device/ride) | Attempt to set 'agent' as the spawned Roly Poly's rider. |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly_spawner_device/spawn) | Spawn a Roly Poly now. If one is active, dismiss it first, then spawn. If the spawner is disabled, this call does nothing. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
