# class_and_team_selector_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/class_and_team_selector_device>
> **爬取时间**: 2025-12-27T01:46:04.458350

---

Used together with `class_designer_device` to control how/when created classes can be accessed by `agent`s.

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
| `ClassSwitchedEvent` | `listenable(payload)` | Signaled when an `agent` changes class. Sends the `agent` whose class changed. |
| `TeamSwitchedEvent` | `listenable(payload)` | Signaled when an `agent` changes teams. Sends the `agent` whose team changed. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ChangeClass`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/class_and_team_selector_device/changeclass) | Changes the `Agent`'s class. |
| [`ChangeSelectorTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/class_and_team_selector_device/changeselectorteam) | Changes the selecting team. |
| [`ChangeTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/class_and_team_selector_device/changeteam) | Changes the `Agent`'s team. |
| [`ChangeTeamAndClass`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/class_and_team_selector_device/changeteamandclass) | Changes the `Agent`'s team and class. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/class_and_team_selector_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/class_and_team_selector_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
