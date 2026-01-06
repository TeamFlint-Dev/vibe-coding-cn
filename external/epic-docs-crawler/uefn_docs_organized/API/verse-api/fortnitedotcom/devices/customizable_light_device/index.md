# customizable_light_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/customizable_light_device
> **爬取时间**: 2025-12-27T01:45:15.951853

---

Used to create a light which can have its color and brightness manipulated in response to in-game events.

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
| [`DimLight`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/customizable_light_device/dimlight) | Dims the light by *Dimming Amount*. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/customizable_light_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/customizable_light_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/customizable_light_device/reset) | Resets the light to its initial state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`Toggle`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/customizable_light_device/toggle) | Toggles between `TurnOn` and `TurnOff`. |
| [`TurnOff`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/customizable_light_device/turnoff) | Turns off the light. |
| [`TurnOn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/customizable_light_device/turnon) | Turns on the light. |
| [`UndimLight`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/customizable_light_device/undimlight) | Brightens the light by *Dimming Amount*. |
