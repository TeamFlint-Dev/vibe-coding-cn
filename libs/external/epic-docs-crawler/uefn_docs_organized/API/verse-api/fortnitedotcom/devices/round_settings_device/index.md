# round_settings_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/round_settings_device
> **爬取时间**: 2025-12-27T01:51:04.504582

---

Used to customize gameplay for any round-based game. It generally defines what happens to the`agent`'s inventory and rewards in each round.

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
| `RoundBeginEvent` | `listenable(payload)` | Signaled when a game round starts. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/round_settings_device/disable) | Disables this device. |
| [`DisableEndRoundConditions`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/round_settings_device/disableendroundconditions) | Disables all end-round conditions. The round must be ended through calling `EndRound` or a creative event after this is called. |
| [`DisableMatchmaking`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/round_settings_device/disablematchmaking) | Disables the ability for players to Matchmake into the Island. Only applies to published games that have matchmaking turned on in the Island settings |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/round_settings_device/enable) | Enables this device. |
| [`EnableMatchmaking`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/round_settings_device/enablematchmaking) | Enables the ability for players to Matchmake into the Island. Only applies to published games that have matchmaking turned on in the Island settings |
| [`EndRound`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/round_settings_device/endround) | Ends the round immediately with `Agent`'s team set as the winner of the round. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`ToggleMatchmaking`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/round_settings_device/togglematchmaking) | Toggles between `EnableMatchmaking` and `DisableMatchmaking`. |
