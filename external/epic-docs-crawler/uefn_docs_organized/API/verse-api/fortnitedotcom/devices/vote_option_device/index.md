# vote_option_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_device>
> **爬取时间**: 2025-12-27T01:59:21.655064

---

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |

## Exposed Interfaces

This class exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`vote_option_interface`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_interface) | Represents an individual choice in a poll. For example, in a poll “What to have for lunch?” an option might be “Tacos” Tracks how many times each agent has voted for this option. An option is associated with only one group device (or “poll”) via an internal ID. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `CastVoteEvent` | `listenable(payload)` |  |
| `WinVoteEvent` | `listenable(payload)` |  |

### Functions

| Function Name | Description |
| --- | --- |
| [`CastVote`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_device/castvote) |  |
| [`GetOptionDescription`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_device/getoptiondescription) |  |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`GetVoteCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_device/getvotecount) |  |
| [`GetVoteGroup`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_device/getvotegroup) |  |
| [`HasAgentVoted`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_device/hasagentvoted) |  |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
