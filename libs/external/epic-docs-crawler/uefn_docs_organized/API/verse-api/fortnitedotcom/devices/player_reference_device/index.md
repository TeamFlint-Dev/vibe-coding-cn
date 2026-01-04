# player_reference_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_reference_device
> **爬取时间**: 2025-12-27T01:50:08.995214

---

Used to relay `agent` statistics to other devices and `agent`s. Can transmit statistics such as elimination count, eliminated count, or scores when certain conditions are met. Can also project a hologram of the `agent` and display text that can be altered in various positions and curvatures.

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
| `ActivatedEvent` | `listenable(payload)` | Signaled when this device is activated. Sends the `agent` stored in the device. |
| `AgentReplacedEvent` | `listenable(payload)` | Signaled when the `agent` tracked by this device is replaced. Sends the new `agent` stored in the device. |
| `AgentUpdatedEvent` | `listenable(payload)` | Signaled when the `agent` tracked by this device is updated. Sends the new `agent` stored in the device. |
| `AgentUpdateFailsEvent` | `listenable(payload)` | Signaled when the `agent` tracked by this fails to be updated. Sends the `agent` that attempted to be stored in this device. |
| `TrackedStatChangedEvent` | `listenable(payload)` | Signaled when a stat tracked by this device is updated. Sends the `agent` stored in the device. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Activate`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_reference_device/activate) | Ends the round/game. |
| [`Clear`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_reference_device/clear) | Clears the state of this device. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_reference_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_reference_device/enable) | Enables this device. |
| [`GetAgent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_reference_device/getagent) | Returns the `agent` currently referenced by the device. |
| [`GetStatValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_reference_device/getstatvalue) | Returns the stat value that this device is currently tracking |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsReferenced`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_reference_device/isreferenced) | Is true when `Agent` is the player being referenced by the device. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Register`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_reference_device/register) | Registers `Agent` as the `agent` being tracked by this device. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
