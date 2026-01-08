# hud_message_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_message_device>
> **爬取时间**: 2025-12-27T01:41:24.911014

---

Used to show custom HUD messages to one or more `agent`s.

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
| `ClearAllMessagesEvent` | `listenable(payload)` | Called when all queued *Messages* from all players that are affected by this HUD Message Device have been cleared. |
| `HideMessageEvent` | `listenable(payload)` | Called when a *Message* has been Hidden on-screen. Returns an `Agent` if it was Hidden from a specified `Agent`'s screen. |
| `ShowMessageEvent` | `listenable(payload)` | Called when a *Message* has been Shown on-screen. Returns an `Agent` if it was Shown on a specified `Agent`'s screen. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ClearAllMessages`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_message_device/clearallmessages) | Clears all queued *Messages* from all players that are affected by this HUD Message Device. |
| [`GetDisplayTime`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_message_device/getdisplaytime) | Returns the time (in seconds) for which the HUD message will be displayed. `0.0` means the message is displayed persistently. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_message_device/hide) | Hides the HUD message. |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_message_device/hide-1) | Hides the currently set HUD *Message* on `Agent`s screen. Use this when the device is setup to target specific `agent`s. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`SetDisplayTime`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_message_device/setdisplaytime) | Sets the time (in seconds) the HUD message will be displayed. `0.0` will display the HUD message persistently. |
| [`SetText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_message_device/settext) | Sets the *Message* to be displayed when the HUD message is activated. `Text` is clamped to 150 characters. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_message_device/show) | Shows the currently set HUD *Message* on `Agent`s screen. Will replace any previously active message. Use this when the device is setup to target specific `agent`s. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_message_device/show-1) | Shows the currently set *Message* HUD message on screen. Will replace any previously active message. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_message_device/show-2) | Displays a Custom message to a specific *Agent* that you define.Setting *DisplayTime* to `0.0` will display the HUD message persistently.If not defined, or less than `0.0` the message will show for the time set on the device. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_message_device/show-3) | Displays a Custom message that you define for all PlayersSetting *DisplayTime* to `0.0` will display the HUD message persistently.If not defined, or less than `0.0` the message will show for the time set on the device. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
