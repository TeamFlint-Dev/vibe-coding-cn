# water_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/water_device>
> **爬取时间**: 2025-12-27T01:41:18.253898

---

Used to create and manipulate volumes of water where players can swim, fish, or drive boats.

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
| `AgentEntersWaterEvent` | `listenable(payload)` | Signaled when an `agent` enters the water. Sends `agent` that entered the water. |
| `AgentExitsWaterEvent` | `listenable(payload)` | Signaled when an `agent` exits the water. Sends `agent` that exited the water. |
| `VerticalEmptyingCompletedEvent` | `listenable(payload)` | Signals when the water volume is completely empty. |
| `VerticalFillingCompletedEvent` | `listenable(payload)` | Signals when the volume is filled to the water level set in the *Default Vertical Water Percentage* option. |

### Functions

| Function Name | Description |
| --- | --- |
| [`BeginVerticalEmptying`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/water_device/beginverticalemptying) | Starts vertically emptying the water in the volume. |
| [`BeginVerticalFilling`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/water_device/beginverticalfilling) | Starts vertically filling the water in the volume. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/water_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/water_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/water_device/reset) | Resets the water level in the volume to the value set in the *Default Vertical Water Percentage* option. |
| [`ResumeVerticalMovement`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/water_device/resumeverticalmovement) | Resumes either filling or emptying the volume. |
| [`StopVerticalMovement`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/water_device/stopverticalmovement) | Stops filling or emptying the volume. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
