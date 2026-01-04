# skilled_interaction_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device
> **爬取时间**: 2025-12-27T01:47:06.369901

---

Used to create a minigame which expects specific input timing from the player.
Visuals may vary, but always feature a scrubber that moves from 0.0 to 1.0.
Good and perfect zones are defined on the device, describing at what point the player must provide input to succeed.

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
| `AdvanceAgentFromQueueEvent` | `listenable(payload)` | Signaled when the `agent` moves from the queue into interacting. An agent enters the queue if BeginInteract is called for them but there is no room for them to begin an interaction given the current configuration. This event will fire when an agent who is waiting in that queue advances from it and begins an interaction, removing it from the queue |
| `AllowDuplicatePlayerEntries` | `?logic` | Maps to the user option 'Allow duplicate Player Entries' If this is toggled while a queue exists then the queue will not be affected, but any new additions to the queue will use the new behavior. ie; if duplicate entries exist and this is set to true, the duplicate entries will not be removed but any new duplicates will be rejected. |
| `BadInputTriggeredEvent` | `listenable(payload)` | Signaled when the `agent` provides a bad input. Bad input occurs when input is provided while the scrubber is outside the *Good Zone*. Sends the `agent` that provided the input. Sends the `float` position of the meter scrubber from `0.0` to `1.0`. |
| `EmptyQueueEvent` | `listenable(payload)` | Fired when the queue empties of all queued agents. The queue has to have at least one agent in it for this to fire. If BeginInteraction is called and a queue is not created, then this event will not be triggered. |
| `FailureLimit` | `?int` | Maps to the 'Failure Limit' user option. Determines how many times a bad input can be provided before failing the minigame. Value is clamped between 0 and 5. Any modifications to this event will take effect the next time an interaction is started. |
| `GoodInputTriggeredEvent` | `listenable(payload)` | Signaled when the `agent` provides a good input. Good input occurs when input is provided while the scrubber is within the *Good Zone* (excluding the *Perfect Zone*). Sends the `agent` that provided the input. Sends the `float` position of the meter scrubber from `0.0` to `1.0`. |
| `GoodZoneSize` | `?float` | Maps to the 'Good Zone Size' user option. Sets the good zone's size as a ratio of the total meter. Value is clamped between 0 and 1. Any modifications to this event will take effect the next time an interaction is started. |
| `InteractionCanceledEvent` | `listenable(payload)` | Signaled when the interaction is interrupted. The interaction can be interrupted in several ways.   - If the participating `agent` is eliminated or enters a downed state. - If *Deactivate* is called while the interaction is in progress. *If* Disable\* is called while the interaction is in progress. |
| `InteractionFailedEvent` | `listenable(payload)` | Signaled when the `agent` fails the interaction. The interaction can be failed in several ways   - If the number of bad inputs reaches the *Failure Limit*. - If the interaction has an *Interaction Time Limit* that expires. |
| `InteractionStartedEvent` | `listenable(payload)` | Signaled when the `agent` starts an interaction. Input is the `agent` which started interacting with the device. |
| `InteractionSucceededEvent` | `listenable(payload)` | Signaled when the `agent` succeeds at the interaction. The interaction is completed depending on the device's configuration.   - Once the device's *Success Target* is reached. - Upon a perfect input if using *Instant Success Perfect Behavior*. |
| `InteractTimeLimit` | `?float` | Maps to the 'Interact Time Limit' user option. Sets how long the player has to complete the interaction. Taking too long will result in failure. Value is clamped between 0 and 120 seconds. Any modifications to this event will take effect the next time an interaction is started. |
| `LockOutOnFailTime` | `?float` | Maps to the 'Lock Out on Fail Time' user option. If a bad input is provided, the interact will lock for the amount of time set. Set to 0 to disable this function. Value must be greater than or equal to 0 Any modifications to this event will take effect the next time an interaction is started. |
| `MaximumQueuedPlayers` | `?int` | Maps to the user option 'Maximum Queued players'. If queue size is changed while players are already queued, then entries will be removed from the list. ie; if you have a queue of 10 agents and then adjust the size to 6, then 4 agents will be removed from the queue. each of those agents will receive a AgentRemoveFromQueueEvent Can only be set to values greater than or equal to 0 |
| `MeterSpeed` | `?float` | Maps to the 'Movement Speed' user option. Determines how fast the meter moves across the interaction in percent per second. Value is clamped between 1 and 400. Any modifications to this event will take effect the next time an interaction is started. |
| `NextInQueueExecutionDelay` | `?float` | Maps to the user option for 'Next In Queue execution Delay' Determines how much time to wait (0 being instant), before triggering the next interaction in the queue. When modified will take effect after the current interaction is completed. Can only be set to values greater than or equal to 0 |
| `PerfectInputTriggeredEvent` | `listenable(payload)` | Signaled when the `agent` provides a perfect input. Perfect input occurs when input is provided while the scrubber is within the device's *Perfect Zone*. Sends the `agent` that provided the input. Sends the `float` position of the meter scrubber from `0.0` to `1.0`. |
| `PerfectZoneSize` | `?float` | Maps to the 'Perfect Zone Size' user option. Determines the perfect zone's size as a ratio of the good zone. Value is clamped between 0 and 1. Any modifications to this event will take effect the next time an interaction is started. |
| `QueueAgentEvent` | `listenable(payload)` | Signaled when the `agent` is put into the queue but has not started an interaction. If an agent skips the queue and is put directly into interacting, this event is skipped. |
| `RemoveAgentFromQueueEvent` | `listenable(payload)` | Signaled when the `agent` has been removed from the queue. This can happen in a few ways   - An agent is removed without advancing into an interaction. - If `Disable` is called while an agent is in the queue. - The queue size is shrunk, causing agents to be removed. |
| `SuccessTarget` | `?int` | Maps to the 'Success Target' user option. Sets how many successful inputs are required for the minigame to complete. Value is clamped between 0 and 5. Any modifications to this event will take effect the next time an interaction is started. |
| `SynchronousPlayerLimit` | `?int` | Maps to the user option for 'Synchronous Player Limit'. If the queue is configured to be synchronous, this is the number of players that will interact at the same time before moving onto the next batch of agents in the queue. When modified, it will take effect on the next Interaction, and does not affect any active interaction. Can only be set to values greater than or equal to 0 |

### Functions

| Function Name | Description |
| --- | --- |
| [`BeginInteraction`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/begininteraction) | Begins the interaction for the provided `agent`. Will cancel any other interactions already in progress for the `agent` if a queue is not being utilized. If a queue is being utilized and duplicate player entries are not allowed then any duplicate player entries in the queue will not be added. If the number of agents requesting interact fits into the current interaction configuration, then those agents will begin interact immediately and skip the queue entirely. |
| [`BeginInteraction`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/begininteraction-1) | Begins the interaction for the provided `agent`(s). Will cancel any other interactions already in progress for the `agent` if a queue is not being utilized. If a queue is being utilized and duplicate player entries are not allowed then any duplicate player entries in the queue will not be added. If the number of agents requesting interact fits into the current interaction configuration, then those agents will begin interact immediately and skip the queue entirely. |
| [`ClearQueue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/clearqueue) | Clears the queue of all `agent`(s). Returns an array of all the players that were still in the queue. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/disable) | Disable this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/enable) | Enable this device. |
| [`EndInteraction`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/endinteraction) | Cancels the interaction, if in progress, for the provided `agent`. Does not clear the queue of any agent awaiting interaction |
| [`EndInteraction`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/endinteraction-1) | Cancels the interaction, if in progress, for the provided `agent`(s). Does not clear the queue of any agent awaiting interaction |
| [`GetInteractingAgents`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/getinteractingagents) | Gets the `agent`(s) who are currently interacting |
| [`GetQueue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/getqueue) | Gets the queue of `agent`(s) who are awaiting interaction. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/isenabled) | Succeeds if the object is enabled, fails if it's disabled. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`RemoveFromQueue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/removefromqueue) | Remove `agent`(s) from the queue, has the option to remove all entries that exist for that agent or not This does not end the interaction for any agents. Returns the number of agents that were removed. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
