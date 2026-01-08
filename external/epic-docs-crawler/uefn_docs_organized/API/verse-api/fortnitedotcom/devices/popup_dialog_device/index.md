# popup_dialog_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device>
> **爬取时间**: 2025-12-27T01:47:58.531885

---

Used to create HUD text boxes that give players information, and allows responses to be customized to player choices.

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
| `DismissedEvent` | `listenable(payload)` | Signaled when this device is dismissed by an `agent`. Sends the `agent` who dismissed the popup. |
| `RespondingButtonEvent` | `listenable(payload)` | Signaled when *Button*  on this device is pushed by an `agent`. Sends the `agent` that pushed the button. Sends the `int` index of the button that was clicked. |
| `ShownEvent` | `listenable(payload)` | Signaled when this device is shown to an `agent`. Sends the `agent` looking at the popup. |
| `TimeOutEvent` | `listenable(payload)` | Signaled when this device times out while an `agent` is looking at it. Sends the `agent` who was looking at the popup. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/enable) | Enables this device. |
| [`GetButtonText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/getbuttontext) | Returns the *Button Text* for this popup at a specified index. |
| [`GetDescriptionText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/getdescriptiontext) | Returns the *Description* text for this popup. |
| [`GetTitleText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/gettitletext) | Returns the *Title* text for this popup. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/hide) | Hides the popup from `Agent`. |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/hide-1) | Hides the popup from all `agent`s in the experience. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`SetButtonCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/setbuttoncount) | Sets the number of buttons this popup has. Button Count is not updated on active Popups. |
| [`SetButtonText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/setbuttontext) | Sets the *Button Text* for a button at a specific index on this popup.   - `Text` should be no more than `24` characters. - If `Text` is empty the button will show *OK* instead. - Button 1 uses `Index` 0. |
| [`SetDescriptionText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/setdescriptiontext) | Sets the *Description* text for this popup. `Text` should be no more than `350` characters. |
| [`SetTitleText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/settitletext) | Sets the *Title* text for this popup. `Text` should be no more than `32` characters. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/show) | Shows the popup to `Agent`. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/popup_dialog_device/show-1) | Shows the popup to all `agent`s in the experience. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
