# teleporter_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/teleporter_device
> **爬取时间**: 2025-12-27T01:48:13.218347

---

Customizable rift that allows `agent`s to move instantly between locations. You can use this to move players around your island, or create multi-island experiences with teleporters that take players from one island to another.

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
| `EnterEvent` | `listenable(payload)` | Signaled when an `agent` enters this device. Sends the `agent` that entered this device. |
| `TeleportedEvent` | `listenable(payload)` | Signaled when an `agent` emerges from this device. Sends the `agent` that emerged from this device. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Activate`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/teleporter_device/activate) | Teleport `Agent` to the target group using this device. |
| [`ActivateLinkToTarget`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/teleporter_device/activatelinktotarget) | When a link is activated, the current destination teleporter will be able to bring the `agent` back to this origin teleporter. Both origin and destination teleporters need to have this activated to work as expected. |
| [`DeactivateLinkToTarget`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/teleporter_device/deactivatelinktotarget) | Deactivates any currently active Link. The current destination teleporter will no longer be able to return the agent to this origin teleporter. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/teleporter_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/teleporter_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`ResetLinkToTarget`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/teleporter_device/resetlinktotarget) | Resets the currently selected destination teleporter, and selects an eligible destination. If the target is a *Teleporter Group*, this may be another randomly chosen `teleporter_device` from that group. |
| [`Teleport`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/teleporter_device/teleport) | Teleport `Agent` to this device. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
