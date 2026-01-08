# trigger_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_device>
> **爬取时间**: 2025-12-27T01:52:14.354815

---

Used to relay events to other linked devices.

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
| `TriggeredEvent` | `listenable(payload)` | Signaled when an `agent` triggers this device. Sends the `agent` that used this device. Returns `false` if no `agent` triggered the action (ex: it was triggered through code). |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_base_device/enable) | Enables this device. |
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
| [`Trigger`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_device/trigger) | Triggers this device with `Agent` being passed as the `agent` that triggered the action. Use an `agent` reference when this device is setup to require one (for instance, you want to trigger the device only with a particular `agent`. |
| [`Trigger`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_device/trigger-1) | Triggers this device, causing it to activate its `TriggeredEvent` event. |
