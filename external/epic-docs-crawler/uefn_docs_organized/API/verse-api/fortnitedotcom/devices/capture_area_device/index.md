# capture_area_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device
> **爬取时间**: 2025-12-27T02:00:07.923252

---

Used to create a zone that can trigger effects once players enter it. Can be set up to be capturable by a team, to provide a score while held, or to require a specific item as a drop-off.

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
| `AgentEntersEvent` | `listenable(payload)` | Signaled when an `agent` enters this device area. Sends the `agent` that entered this device area. |
| `AgentExitsEvent` | `listenable(payload)` | Signaled when an `agent` exits this device area. Sends the `agent` that exited this device area. |
| `AreaIsContestedEvent` | `listenable(payload)` | Signaled when this device is contested. Sends the `agent` that is contesting this device. |
| `AreaIsScoredEvent` | `listenable(payload)` | Signaled when this device is scored. Sends the `agent` that scored this device. |
| `ControlChangeEvent` | `listenable(payload)` | Signaled when this device control changes. Sends the `agent` that triggered this device control change. |
| `ControlChangeStartsEvent` | `listenable(payload)` | Signaled when this device control change starts. Sends the `agent` that is triggering this device control change. |
| `FirstAgentEntersEvent` | `listenable(payload)` | Signaled when the first `agent` enters this device area. Sends the `agent` that entered this device area. |
| `ItemIsConsumedEvent` | `listenable(payload)` | Signaled when an item is consumed by this device. Sends the `agent` that provided the item to this device. |
| `ItemIsDeliveredEvent` | `listenable(payload)` | Signaled when an item is delivered to this device. Sends the `agent` that delivered the item to this device. |
| `LastAgentExitsEvent` | `listenable(payload)` | Signaled when the last `agent` exits this device area. Sends the `agent` that exited this device area. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ActivateObjectivePulse`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/activateobjectivepulse) | Activates the objective pulse for this device. |
| [`AllowCapture`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/allowcapture) | Allows this device to be captured. |
| [`DeactivateObjectivePulse`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/deactivateobjectivepulse) | Deactivates the objective pulse for this device. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/disable) | Disables this device. |
| [`DisallowCapture`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/disallowcapture) | Disallows this device from being captured. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/enable) | Enables this device. |
| [`GetAgentsInVolume`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/getagentsinvolume) | Returns an array of agents that are currently occupying the Capture Area. |
| [`GetHeight`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/getheight) | Returns the *Capture Height* (in meters) of the capture area. |
| [`GetRadius`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/getradius) | Returns the *Capture Radius* (in meters) of the capture area. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`GiveControl`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/givecontrol) | Gives control of this device to the capturing `agent`'s team. |
| [`IsInArea`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/isinarea) | Is true when `Agent` is in the Capture Area. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Neutralize`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/neutralize) | Clears control of this device for all teams. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/reset) | Resets control of this device for all teams. |
| [`SetHeight`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/setheight) | Sets the *Capture Height* (in meters) of the capture area. |
| [`SetRadius`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/setradius) | Sets the *Capture Radius* (in meters) of the capture area. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`ToggleCaptureAllowed`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/togglecaptureallowed) | Toggles between `AllowCapture` and `DisallowCapture`. |
| [`ToggleEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/capture_area_device/toggleenabled) | Toggles between `Enable` and `Disable`. |
