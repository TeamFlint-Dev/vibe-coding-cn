# creative_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device
> **爬取时间**: 2025-12-27T01:39:00.433170

---

Inherit from this to create a custom creative device. Inherited classes will appear in the UEFN content browser the next time Verse compiles. Instances of your derived `creative_device` can then be placed in the island by dragging them from the content browser into the scene.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Exposed Interfaces

This class exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`creative_object_interface`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object_interface) |  |

## Members

This class has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`OnBegin`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/onbegin) | Override to add custom logic when the game experience begins. |
| [`OnEnd`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/onend) | Override to add custom logic when the game experience ends. Any coroutines spawned inside `OnEnd` may never execute. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/gettransform) | Returns the transform of the `creative_device` with units in cm. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/teleportto) | Teleports the `creative_device` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/teleportto-1) | Teleports the `creative_device` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/moveto) | Moves the `creative_device` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_device` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/moveto-1) | Moves the `creative_device` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_device` it will be stopped and put into the `AnimationNotSet` state. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/show) | Shows this device in the world. |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/hide) | Hides this device in the world. |
