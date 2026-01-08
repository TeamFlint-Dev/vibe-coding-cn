# conversation_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device>
> **爬取时间**: 2025-12-27T01:39:27.530189

---

Used to set and trigger conversations made via the Conversation Graph. The conversation triggered is assigned to the device.

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
| [`enableable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/enableable) | Implemented by classes whose instances can be enabled and disabled. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `AllowedConversationCount` | `?int` | Sets the number of conversations allowed at once with the device. This will not make any conversations exit if there are more current conversations than allowed after this call. |
| `CancelEvent` | `listenable(payload)` | Signalled when a conversation has ended early by EndConversation or EndConversationForAll. |
| `CharactersPerSecond` | `??float` | The constant rate that characters are revealed over the course of a second when a Speech node activates. The exact characters in the respective speech node are revealed and do not combine into glyphs. When the value is changed, active conversations are not updated. Works with the Box and Custom UI. The value of CharactersPerSecond is the default value used when initiating a conversation. CharactersPerSecond will be clamped between 0.25 and 100.0. If set to false all the characters will reveal instantly. |
| `EndEvent` | `listenable(payload)` | Signalled when a conversation has ended. |
| `IndicatorBubbleRange` | `?float` | The range that the Indicator Bubble will be seen at. Clamps to range[0, 25]. |
| `OnConversationEvent` | `listenable(payload)` | Signaled when a choice node tied to this event is selected by an `agent`. Sends the `agent` that triggered the event, and `EventNumber` is the number specified in the Conversation Event node. |
| `ShowConversationTextInWorldSpace` | `?logic` | Whether the device will show conversation text in worldspace when using the Radial UI type. |
| `ShowIndicatorBubble` | `?logic` | whether the device will show the Indicator Bubble when nearby. |
| `ShowNameWhenNearby` | `?logic` | Whether the device will show the Speaker when nearby. |
| `SpeakerName` | `?message` | The Speaker Name of the device. When the value is changed, active conversations are not updated. The value of SpeakerName is the default value used when initiating a conversation. |

### Functions

| Function Name | Description |
| --- | --- |
| [`CanInitiateConversation`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device/caninitiateconversation) | Check if an `agent` can initiate a conversation. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device/disable) | Disables this device. A disabled conversation device will not listen for inputs and trigger conversations. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device/enable) | Enables this device. An enabled conversation device will listen for inputs and trigger conversations. |
| [`EndConversation`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device/endconversation) | Ends the assigned conversation with the `agent`. |
| [`EndConversationForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device/endconversationforall) | Ends all active conversations with this device. |
| [`GetActiveConversationsCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device/getactiveconversationscount) | Returns the count of currently-active conversations with this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`HideConversation`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device/hideconversation) | Hide the conversation UI for an 'agent'. Responses cannot be selected while the UI is hidden. This will work with Box and Custom UI. |
| [`InitiateConversation`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device/initiateconversation) | Begins the assigned conversation with the `agent`. The conversation will not start if the device or the `agent` are otherwise incapable of having a conversation. |
| [`IsAgentInConversation`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device/isagentinconversation) | Check if an `agent` is in an active conversation. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device/isenabled) | Check if the device is enabled. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`ShowConversation`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conversation_device/showconversation) | Show the conversation UI for an 'agent'. This will work with Box and Custom UI. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
