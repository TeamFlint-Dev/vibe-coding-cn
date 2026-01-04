# progress_based_mesh_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/progress_based_mesh_device
> **爬取时间**: 2025-12-27T01:35:55.556941

---

This device is used to associate changes in progression with a mesh transition. As the device's progression changes, it will transition between a set of defined meshes.
The ThresholdMesh field can be found under the 'Visuals' category on an instance of a progress\_based\_mesh\_device in Unreal Editor Fortnite.

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
| `CurrentProgress` | `?float` | The current progress this device has made towards its ProgressTarget. This value will be clamped between 0 and Progress Target. Modifying this value will cause changes Mesh Changes corresponding to your defined ThresholdMeshes. |
| `EmptyEvent` | `listenable(payload)` | This event is fired whenever 'CurrentProgress' reaches 0. |
| `FillEvent` | `listenable(payload)` | This event is fired whenever 'CurrentProgress' reaches the 'ProgressTarget'. |
| `ProgressChangeEvent` | `listenable(payload)` | This event is fired whenever 'CurrentProgress' value gets changed, whether through direct modification, or as a result of the Progress or Regress state. |
| `ProgressRate` | `?float` | This value maps to the 'ProgressRate' user option. When this device is in the Progress state, 'CurrentProgress' will be increased by this value per second until it reaches the 'ProgressTarget'. Utilizing this value is not required, as 'CurrentProgress' can also be modified directly. |
| `ProgressState` | `?progress_device_state` | The current state of this device. |
| `ProgressTarget` | `?float` | This value maps to the 'ProgressTarget' user option. The target Progress goal of this value. Setting this value will clamp it between 0 and 100. If 'ProgressTarget' is set to a value lower than 'CurrentProgress', 'CurrentProgress' will be clamped to 'ProgressTarget', and fire any threshold related events. |
| `ProgressThresholdCrossEvent` | `listenable(payload)` | This event fires whenever this device changes meshes as a result of 'CurrentProgress' value causing a new Threshold to be met. The ThresholdMeshe field can be found under the 'Visuals' category on an instance of a progress\_based\_mesh\_device in Unreal Editor Fortnite. |
| `RegressRate` | `?float` | This value maps to the 'RegressRate' user option. When this device is in the Regress state, 'CurrentProgress' will be decreased by this value per second until it reaches the 0. Utilizing this value is not required, as 'CurrentProgress' can also be modified directly. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
