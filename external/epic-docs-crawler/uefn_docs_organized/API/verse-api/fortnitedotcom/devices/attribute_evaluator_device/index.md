# attribute_evaluator_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/attribute_evaluator_device>
> **爬取时间**: 2025-12-27T01:36:44.246987

---

Evaluates attributes for `agent` when signaled from other devices. Acts as branching logic, checking whether the `agent` associated with the signal passes all of the tests setup in this device, then sends a signal on either `PassEvent` or `FailEvent`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |
| [`trigger_base_device`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device) | Base class for various specialized trigger devices. See also:  *`trigger_device`*  `perception_trigger_device` \* `attribute_evaluator_device` |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `FailEvent` | `listenable(payload)` | Signaled when the `agent` from `EvaluateAgent` fails the requirements specified by this device. Sends the `agent` originally passed to this device in `EvaluateAgent`. |
| `PassEvent` | `listenable(payload)` | Signaled when the `agent` from `EvaluateAgent` passes the requirements specified by this device. Sends the `agent` originally passed to this device in `EvaluateAgent`. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/enable) | Enables this device. |
| [`EvaluateAgent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/attribute_evaluator_device/evaluateagent) | Tests whether the specified agent satisfies the required conditions specified on the device (e.g. eliminations/score), and fires either the `PassEvent` or `FailEvent` accordingly. |
| [`GetMaxTriggerCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/getmaxtriggercount) | Gets the maximum amount of times this device can trigger.   - `0` indicates no limit on trigger count. |
| [`GetResetDelay`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/getresetdelay) | Gets the time (in seconds) before the device can be triggered again (if `MaxTrigger` count allows). |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`GetTransmitDelay`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/gettransmitdelay) | Gets the time (in seconds) which must pass after triggering, before this device informs other external devices that it has been triggered. |
| [`GetTriggerCountRemaining`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/gettriggercountremaining) | Returns the number of times that this device can still be triggered before hitting `GetMaxTriggerCount`. Returns `0` if `GetMaxTriggerCount` is unlimited. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/reset) | Resets the number of times this device has been activated. This will set `GetTriggerCountRemaining` back to `0` |
| [`SetMaxTriggerCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/setmaxtriggercount) | Sets the maximum amount of times this device can trigger.   - `0` can be used to indicate no limit on trigger count. - `MaxCount` is clamped between [0,20]. |
| [`SetResetDelay`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/setresetdelay) | Sets the time (in seconds) after triggering, before the device can be triggered again (if `MaxTrigger` count allows). |
| [`SetTransmitDelay`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/settransmitdelay) | Sets the time (in seconds) which must pass after triggering, before this device informs other external devices that it has been triggered. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
