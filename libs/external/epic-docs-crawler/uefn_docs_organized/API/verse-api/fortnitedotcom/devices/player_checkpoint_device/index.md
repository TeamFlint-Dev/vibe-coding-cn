# player_checkpoint_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_checkpoint_device
> **爬取时间**: 2025-12-27T01:42:21.975048

---

Used to set an `agent`'s spawn point when activated. This can also clear the `agent`'s inventory.

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
| `FirstActivationEvent` | `listenable(payload)` | Signaled when this device is first activated by any `agent`. Sends the `agent` that activated this device. |
| `FirstActivationPerAgentEvent` | `listenable(payload)` | Signaled each time a new `agent` activates this device. Sends the `agent` that activated this device. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_checkpoint_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_checkpoint_device/enable) | Enables this device. |
| [`GetRegisteredAgents`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_checkpoint_device/getregisteredagents) | Returns an array of agents that are currently registered to this checkpoint. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsRegistered`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_checkpoint_device/isregistered) | Succeeds when `Agent` is registered to this checkpoint. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Register`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_checkpoint_device/register) | Registers this checkpoint for `Agent`. This sets the respawn point and can clear `Agent`'s inventory depending on this device's settings. Multiple `agent`s can be registered to this device at one time. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
