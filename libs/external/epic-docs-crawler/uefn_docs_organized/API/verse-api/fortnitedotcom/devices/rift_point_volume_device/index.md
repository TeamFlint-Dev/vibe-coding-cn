# rift_point_volume_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rift_point_volume_device
> **爬取时间**: 2025-12-27T01:48:31.122773

---

The Rift Point volume is used to interface with and manage the Rift Point item,
and provides an area that enables players to plant the item to create search and destroy style gameplay.

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
| `DefuseCancelEvent` | `listenable(payload)` | Sends an event when defusing the Rift Point is canceled, passing in the defusing `agent`. |
| `DefuseEvent` | `listenable(payload)` | Sends an event when the Rift Point is defused, passing in the defusing `agent`. |
| `DefuseStartEvent` | `listenable(payload)` | Sends an event when defusing the Rift Point is started, passing in the defusing `agent`. |
| `DetonateEvent` | `listenable(payload)` | Sends an event when the Rift Point detonates, passing in the planting `agent`. |
| `OnAgentEntered` | `listenable(payload)` | Sends an event when an `agent` enters the volume. |
| `OnAgentExited` | `listenable(payload)` | Sends an event when an `agent` exits the volume. |
| `PlantCancelEvent` | `listenable(payload)` | Sends an event when planting the Rift Point is canceled, passing in the planting `agent`. |
| `PlantEvent` | `listenable(payload)` | Sends an event when the Rift Point is planted, passing in the planting `agent`. |
| `PlantStartEvent` | `listenable(payload)` | Sends an event when planting the Rift Point is started, passing in the planting `agent`. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rift_point_volume_device/disable) | Disables the device, preventing the Rift Point from being planted. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rift_point_volume_device/enable) | Enables the device, allowing the Rift Point to be planted. |
| [`GetAgentsInVolume`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rift_point_volume_device/getagentsinvolume) | Returns an array of agents that are currently occupying the volume. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rift_point_volume_device/isenabled) | Succeeds if the component is enabled, fails if it’s disabled. |
| [`IsInVolume`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/rift_point_volume_device/isinvolume) | Is true when `Agent` is in the volume. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
