# damage_volume_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/damage_volume_device>
> **爬取时间**: 2025-12-27T01:52:21.031929

---

Used to specify an area volume which can damage `agent`s, vehicles, and creatures.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |
| [`effect_volume_device`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/effect_volume_device) | Base class for types of volumes with special gameplay properties. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `AgentEntersEvent` | `listenable(payload)` | Signaled when an `agent` enters the volume. Sends the `agent` entering the volume. |
| `AgentExitsEvent` | `listenable(payload)` | Signaled when an `agent` exits the volume. Sends the `agent` exiting the volume. |
| `PropEnterEvent` | `listenable(payload)` | Signaled when a `creative_prop` enters the device volume. |
| `PropExitEvent` | `listenable(payload)` | Signaled when a `creative_prop` exits the device volume. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/effect_volume_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/effect_volume_device/enable) | Enables this device. |
| [`GetAgentsInVolume`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/damage_volume_device/getagentsinvolume) | Returns an array of agents that are currently occupying the volume. |
| [`GetDamage`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/damage_volume_device/getdamage) | Returns the damage to be applied each tick within the volume. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsInVolume`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/damage_volume_device/isinvolume) | Is true when `Agent` is in the zone. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`SetDamage`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/damage_volume_device/setdamage) | Sets the damage to be applied each tick within the volume. `Damage` is clamped between `1` and `500`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`UpdateSelectedClass`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/damage_volume_device/updateselectedclass) | Updates *Selected Class* to `Agent`'s class. |
| [`UpdateSelectedTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/damage_volume_device/updateselectedteam) | Updates *Selected Team* to `Agent`'s team. |
