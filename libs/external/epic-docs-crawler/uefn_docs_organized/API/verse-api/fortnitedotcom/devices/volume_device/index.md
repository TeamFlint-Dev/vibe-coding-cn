# volume_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/volume_device
> **爬取时间**: 2025-12-27T01:42:45.056737

---

Used to track when agents enter and exit a volume.

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
| `AgentEntersEvent` | `listenable(payload)` | Signaled when an `agent` enters the device volume. |
| `AgentExitsEvent` | `listenable(payload)` | Signaled when an `agent` exits the device volume. |
| `PropEnterEvent` | `listenable(payload)` | Signaled when an `creative_prop` entered the device volume. |
| `PropExitEvent` | `listenable(payload)` | Signaled when an `creative_prop` exited the device volume. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetAgentsInVolume`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/volume_device/getagentsinvolume) | Returns an array of agents that are currently occupying the volume. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsInVolume`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/volume_device/isinvolume) | Succeeds when `Agent` is in the volume. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
