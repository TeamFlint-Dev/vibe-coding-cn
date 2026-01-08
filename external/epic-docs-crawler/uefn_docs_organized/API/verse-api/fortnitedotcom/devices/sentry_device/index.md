# sentry_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/sentry_device>
> **爬取时间**: 2025-12-27T01:59:16.094179

---

Generates an AI bot that spawns in a location and usually attacks players when they come in range.

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
| `AlertedEvent` | `listenable(payload)` | Signaled when the sentry is alerted to an `agent`. Sends the `agent` who alerted the sentry. |
| `AttackingEvent` | `listenable(payload)` | Signaled when a sentry attacks an `agent`. Sends the `agent` who is being attacked. |
| `EliminatedEvent` | `listenable(payload)` | Signaled when a sentry is eliminated. Sends the `agent` that eliminated the sentry. If the sentry was eliminated by a non-agent then `false` is returned. |
| `EliminatingACreatureEvent` | `listenable(payload)` | Signaled when the sentry eliminates a creature. |
| `EliminatingAgentEvent` | `listenable(payload)` | Signaled when a sentry eliminates an `agent`. Sends the `agent` who was eliminated by the sentry. |
| `EntersAlertCooldownEvent` | `listenable(payload)` | Signaled when the sentry enters the alert state. |
| `ExitsAlertEvent` | `listenable(payload)` | Signaled when the sentry exists the alert state. |

### Functions

| Function Name | Description |
| --- | --- |
| [`DestroySentry`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/sentry_device/destroysentry) | Destroys the current sentry. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/sentry_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/sentry_device/enable) | Enables this device. |
| [`EnableAlert`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/sentry_device/enablealert) | Puts the sentry into the alert state. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`JoinTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/sentry_device/jointeam) | Sets the sentry to the same team `Agent` is on. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Pacify`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/sentry_device/pacify) | Puts the sentry into the pacify state, preventing from entering the alert (attacking) state. |
| [`ResetAlertCooldown`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/sentry_device/resetalertcooldown) | Resets the alert state. |
| [`ResetTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/sentry_device/resetteam) | Resets the sentry to the original team designated in the device options. |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/sentry_device/spawn) | Spawns the sentry. |
| [`Target`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/sentry_device/target) | Sets the sentry to target `Agent`. The sentry will not target agents on the same team as the sentry. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
