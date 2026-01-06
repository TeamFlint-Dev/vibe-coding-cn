# timer_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device
> **爬取时间**: 2025-12-27T02:00:38.681301

---

Provides a way to keep track of the time something has taken, either for scoreboard purposes, or to trigger actions. It can be configured in several ways, either acting as a countdown to an event that is triggered at the end, or as a stopwatch for an action that needs to be completed before a set time runs out.

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
| `FailureEvent` | `listenable(payload)` | Signaled when the timer completes or ends with failure. Sends the `agent` that activated the timer, if any. |
| `StartUrgencyModeEvent` | `listenable(payload)` | Signaled when the timer enters *Urgency Mode*. Sends the `agent` that activated the timer, if any. |
| `SuccessEvent` | `listenable(payload)` | Signaled when the timer completes or ends with success. Sends the `agent` that activated the timer, if any. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ClearPersistenceData`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/clearpersistencedata) | Clears this device's saved data for `Agent`. |
| [`ClearPersistenceDataForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/clearpersistencedataforall) | Clears this device's saved data for all `agent`s. |
| [`ClearPersistenceDataForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/clearpersistencedataforall-1) | Clears this device's saved data for all `agent`s. |
| [`Complete`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/complete) | Completes the timer for `Agent`. |
| [`Complete`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/complete-1) | Completes the timer. |
| [`CompleteForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/completeforall) | Completes the timer for all `agent`s. |
| [`CompleteForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/completeforall-1) | Completes the timer for all `agent`s. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/disable) | Disables this device for `Agent`. While disabled this device will not receive signals. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/disable-1) | Disables this device. While disabled this device will not receive signals. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/enable) | Enables this device for `Agent`. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/enable-1) | Enables this device. |
| [`GetActiveDuration`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/getactiveduration) | Returns the remaining time (in seconds) on the timer for `Agent`. |
| [`GetActiveDuration`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/getactiveduration-1) | Returns the remaining time (in seconds) on the timer if it is set to be global. |
| [`GetMaxDuration`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/getmaxduration) | Returns the maximum duration of the timer (in seconds). |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsStatePerAgent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/isstateperagent) | Succeeds if this device is tracking timer state for each individual `agent` independently. Fails if state is being tracked globally for all `agent`'s. |
| [`Load`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/load) | Loads this device's saved data for `Agent`. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Pause`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/pause) | Pauses the timer for `Agent`. |
| [`Pause`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/pause-1) | Pauses the timer. |
| [`PauseForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/pauseforall) | Pauses the timer for all `agent`s. |
| [`PauseForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/pauseforall-1) | Pauses the timer for all `agent`s. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/reset) | Resets the timer back to its base time and stops it for `Agent`. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/reset-1) | Resets the timer back to its base time and stops it. |
| [`ResetForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/resetforall) | Resets the timer back to its base time and stops it for all `agent`s. |
| [`ResetForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/resetforall-1) | Resets the timer back to its base time and stops it for all `agent`s. |
| [`Resume`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/resume) | Resumes the timer for `Agent`. |
| [`Resume`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/resume-1) | Resumes the timer. |
| [`ResumeForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/resumeforall) | Resumes the timer for all `agent`s. |
| [`ResumeForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/resumeforall-1) | Resumes the timer for all `agent`s. |
| [`Save`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/save) | Saves this device's data for `Agent`. |
| [`SetActiveDuration`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/setactiveduration) | Sets the remaining time (in seconds) on the timer, if active, on `Agent`. |
| [`SetActiveDuration`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/setactiveduration-1) | Sets the remaining time (in seconds) on the timer, if active. Use this function if the timer is set to use the same time for all `agent`'s. |
| [`SetLapTime`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/setlaptime) | Sets the lap time indicator for `Agent`. |
| [`SetLapTimeForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/setlaptimeforall) | Sets the lap time indicator for all `agent`s. |
| [`SetLapTimeForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/setlaptimeforall-1) | Sets the lap time indicator for all `agent`s. |
| [`SetMaxDuration`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/setmaxduration) | Sets the maximum duration of the timer (in seconds). |
| [`Start`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/start) | Starts the timer for `Agent`. |
| [`Start`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/start-1) | Starts the timer. |
| [`StartForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/startforall) | Starts the timer for all `agent`s. |
| [`StartForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/timer_device/startforall-1) | Starts the timer for all `agent`s. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
