# player_marker_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_marker_device>
> **爬取时间**: 2025-12-27T01:50:20.495076

---

Used to mark an `agent`'s position on the minimap and configure the information shown for marked `agent`s.

Example configuration options:

- Health and shield bars for marked players.
- Distance to a marked player.

Example marker appearance options:

- Customized text label displayed on marked players.
- Alternative minimap icon and icon color.

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
| `FirstItemValueChangedEvent` | `listenable(payload)` | Signaled when the first item type monitored on marked agents has changed. Sends the marked `agent`. |
| `FirstItemValueReachedEvent` | `listenable(payload)` | Signaled when a marked `agent` meets the quantity condition for the first monitored item type (e.g. Fewer Than, Equal To, More Than X). Sends the marked `agent`. |
| `SecondItemValueChangedEvent` | `listenable(payload)` | Signaled when the second item type monitored on marked agents has changed. Sends the marked `agent`. |
| `SecondItemValueReachedEvent` | `listenable(payload)` | Signaled when a marked `agent` meets the quantity condition for the second monitored item type (e.g. Fewer Than, Equal To, More Than X). Sends the marked `agent`. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Attach`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_marker_device/attach) | Attaches a marker to `Agent`. |
| [`Detach`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_marker_device/detach) | Detaches a marker from `Agent`. |
| [`DetachFromAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_marker_device/detachfromall) | Detaches markers from all marked `agent`s. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_marker_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_marker_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
