# hud_controller_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_controller_device
> **爬取时间**: 2025-12-27T01:52:27.674179

---

Used to show or hide parts of the HUD for players or teams. Use this with other devices such as the `hud_message_device`, `map_indicator_device`, and `billboard_device` to control exactly how much information players can see during a game, as well as how and when they see that information.

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
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_controller_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_controller_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`ResetAffectedClass`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_controller_device/resetaffectedclass) | Resets the *Affected Class* option to its starting value. |
| [`ResetAffectedTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_controller_device/resetaffectedteam) | Resets the *Affected Team* option to its starting value. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`UpdateAffectedClass`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_controller_device/updateaffectedclass) | Sets the *Affected Class* option to `Agent`'s class. |
| [`UpdateAffectedTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hud_controller_device/updateaffectedteam) | Sets the *Affected Team* option to `Agent`'s team. |
