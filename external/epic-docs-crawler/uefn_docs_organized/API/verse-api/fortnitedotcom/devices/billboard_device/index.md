# billboard_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/billboard_device>
> **爬取时间**: 2025-12-27T01:43:35.162438

---

Used to display custom text messages on a billboard.

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

This class has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`GetShowBorder`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/billboard_device/getshowborder) | Returns `true` if the device border is enabled. |
| [`GetTextSize`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/billboard_device/gettextsize) | Returns the *Text Size* of the device *Text*. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`HideText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/billboard_device/hidetext) | Hides the billboard text. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`SetShowBorder`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/billboard_device/setshowborder) | Sets the visibility of the device border mesh. This also determines whether the device collision is enabled. |
| [`SetText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/billboard_device/settext) | Sets the device *Text*. |
| [`SetTextSize`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/billboard_device/settextsize) | Sets the *Text Size* of the device *Text*. Clamped to range [8, 24]. |
| [`ShowText`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/billboard_device/showtext) | Shows the billboard text. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`UpdateDisplay`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/billboard_device/updatedisplay) | Updates the device display to show the current *Text*. |
