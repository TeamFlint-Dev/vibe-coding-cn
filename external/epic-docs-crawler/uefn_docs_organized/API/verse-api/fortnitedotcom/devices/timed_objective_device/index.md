# timed_objective_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timed_objective_device
> **爬取时间**: 2025-12-27T01:50:45.900309

---

Configures game modes where players can start or stop timers to advance gameplay objectives, such as Attack/Defend Bomb objectives.

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
| `BeganEvent` | `listenable(payload)` | Signaled when the objective begins. Sends the `agent` that started the timer. |
| `CompletedEvent` | `listenable(payload)` | Signaled when the objective is completed. Sends the `agent` that started the timer or completed the timer by calling `Complete`. |
| `EndedEvent` | `listenable(payload)` | Signaled when the objective ends. Sends the `agent` that stopped the timer. |
| `PausedEvent` | `listenable(payload)` | Signaled when the objective is paused. Sends the `agent` that paused the timer. |
| `RestartedEvent` | `listenable(payload)` | Signaled when the objective is restarted. Sends the `agent` that restarted the timer. |
| `ResumedEvent` | `listenable(payload)` | Signaled when the objective is resumed. Sends the `agent` that resumed the timer. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Begin`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timed_objective_device/begin) | Starts the objective with `Agent` acting as the user the interacted this device. |
| [`Complete`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timed_objective_device/complete) | Completes the objective with `Agent` acting as the user the interacted this device. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timed_objective_device/disable) | Disables the objective for `Agent`. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timed_objective_device/enable) | Enables the objective for `Agent`. |
| [`End`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timed_objective_device/end) | Ends the objective with `Agent` acting as the user the interacted this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timed_objective_device/hide) | Makes this device invisible. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Pause`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timed_objective_device/pause) | Pauses the objective with `Agent` acting as the user the interacted this device. |
| [`Restart`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timed_objective_device/restart) | Restarts the objective with `Agent` acting as the user the interacted this device. |
| [`Resume`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timed_objective_device/resume) | Resumes the objective with `Agent` acting as the user the interacted this device. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timed_objective_device/show) | Makes this device visible. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
