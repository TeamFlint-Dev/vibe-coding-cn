# tracker_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device
> **爬取时间**: 2025-12-27T01:41:51.546458

---

Allows creation and HUD tracking of custom objectives for `agent`s to complete.

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
| `CompleteEvent` | `listenable(payload)` | Signaled when the tracked value reaches `GetTarget` for an `agent`. Sends the `agent` that reached `GetTarget` for their tracked value. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Assign`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/assign) | Assigns the device to `Agent` (and any `agent`s sharing progress). |
| [`AssignToAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/assigntoall) | Assigns this device to all valid `agent`s. |
| [`ClearPersistence`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/clearpersistence) | Clears tracked progress for `Agent`. Only valid if *Use Persistence* is set to *Use*. |
| [`Complete`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/complete) | The objective immediately completes. |
| [`DecreaseTargetValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/decreasetargetvalue) | Decreases the target value for `Agent` by 1. |
| [`Decrement`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/decrement) | Decrease the tracked value by *Amount to Change on Received Signal* for `Agent`. |
| [`GetActiveAgents`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/getactiveagents) | Returns an array of agents that currently have this tracker active. |
| [`GetTarget`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/gettarget) | Returns the target value that must be achieved in order for `CompleteEvent` to trigger. Clamped to `0 <= GetTarget <= 10000`. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`GetValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/getvalue) | Returns the current total tracked value for all players. |
| [`GetValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/getvalue-1) | Returns the current total tracked value for the team at `TeamIndex`. |
| [`GetValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/getvalue-2) | Returns the current tracked value for `Agent`. |
| [`HasReachedTarget`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/hasreachedtarget) | Is true if `Agent` has reached the *TargetValue* for the tracker. |
| [`IncreaseTargetValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/increasetargetvalue) | Increases the target value for `Agent` by 1. |
| [`Increment`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/increment) | Increases the tracked value by *Amount to Change on Received Signal* for `Agent`. |
| [`IsActive`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/isactive) | Is true if `Agent` currently has the tracker active. |
| [`Load`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/load) | Loads tracked progress for `Agent`. Only valid if *Use Persistence* is set to *Use*. |
| [`LoadForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/loadforall) | Loads tracked progress for all valid `agent`s. Only valid if *Use Persistence* is set to *Use*. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Remove`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/remove) | Removes this device from `Agent` (and any `agent`s sharing progress). |
| [`RemoveFromAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/removefromall) | Removes this device from all valid `agent`s. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/reset) | Resets the progress for `Agent` (and any `agent`s sharing progress). |
| [`Save`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/save) | Saves tracked progress for `Agent`. Only valid if *Use Persistence* is set to *Use*. |
| [`SetDescriptionText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/setdescriptiontext) | Sets a description for the `tracker_device`, which is displayed if *Show on HUD* is enabled. `Text` has a 64 character limit. |
| [`SetTarget`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/settarget) | Sets the target value that must be achieved in order for `CompleteEvent` to trigger. Clamped to `0 <= TargetValue <= 10000`. |
| [`SetTitleText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/settitletext) | Sets the title for the `tracker_device`, which is displayed if *Show on HUD* is enabled. `Text` has a 32 character limit. |
| [`SetValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/setvalue) | Sets the current tracked value for the device for all active players. |
| [`SetValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/setvalue-1) | Sets the current tracked value for the device for the Team at the `TeamIndex`. If *Sharing* is set to *Individual*, this will set the value for all team members. If *Sharing* is set to *All*, this will set the value for all players. |
| [`SetValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/tracker_device/setvalue-2) | Sets the current tracked value for the device for a specific 'Agent'. If *Sharing* is set to *Team*, this will set the value for their team. If *Sharing* is set to *All*, this will set the value for everyone. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
