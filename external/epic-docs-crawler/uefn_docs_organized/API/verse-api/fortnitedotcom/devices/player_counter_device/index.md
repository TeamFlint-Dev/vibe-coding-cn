# player_counter_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device
> **爬取时间**: 2025-12-27T02:01:02.272038

---

Used to track and react to how many players are in a particular area, and optionally display that information in game.

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
| `CountedEvent` | `listenable(payload)` | Signaled when a valid player enters the zone and is counted. The frequency of evaluation against the *Target Player Count* can be controlled through the device settings. Sends the `agent` that is now being counted. |
| `CountFailsEvent` | `listenable(payload)` | Signaled when the player count does not match *Target Player Count*. The frequency of evaluation against *Target Player Count* can be controlled through the device settings. |
| `CountSucceedsEvent` | `listenable(payload)` | Signaled when the player count matches *Target Player Count*. The frequency of evaluation against *Target Player Count* can be controlled through the device settings. |
| `RemovedEvent` | `listenable(payload)` | Signaled when a player is no longer counted by this device, such as when they leave the zone, leave the game, or are assigned to a different `team` or class. Sends the `agent` that is no longer being counted. |

### Functions

| Function Name | Description |
| --- | --- |
| [`CompareToTarget`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/comparetotarget) | Triggers an evaluation of the current count vs *Target Player Count*, signaling `CountSucceedsEvent` or `CountFailsEvent` based on the evaluation result. |
| [`DecrementTargetCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/decrementtargetcount) | Decrements *Target Player Count* by `1`. Immediately triggers a new comparison. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/enable) | Enables this device. |
| [`GetCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/getcount) | Returns the number of players currently counted by this device |
| [`GetCountedAgents`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/getcountedagents) | Returns an array of agents that are currently counted by the device. |
| [`GetTargetCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/gettargetcount) | Returns the number of players required for this counter to succeed. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`HideInfoPanel`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/hideinfopanel) | Hide this device info panel from the world. |
| [`IncrementTargetCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/incrementtargetcount) | Increments *Target Player Count* by `1`. Immediately triggers a new comparison. |
| [`IsCounted`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/iscounted) | Is true if `Agent` is currently counted by this device. |
| [`IsPassingTest`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/ispassingtest) | Is true if the device is currently succeeding in its comparison. |
| [`IsShowingInfoPanel`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/isshowinginfopanel) | Returns whether this device is represented in the world as an info panel showing Current + Required player counts. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Register`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/register) | Adds the player to the registered player list. *Track Registered Players* determines how registered players are counted. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/reset) | Resets *Target Player Count* to the default value defined in the device settings. If *Target Player Count* was previously incremented or decremented, this reset immediately triggers a new comparison. |
| [`SetTargetCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/settargetcount) | Sets the number of players required for this counter to succeed. Immediately triggers a new comparison. |
| [`ShowInfoPanel`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/showinfopanel) | Show this device in the world as an info panel showing Current + Required player counts. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`TransmitForAllCounted`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/transmitforallcounted) | Triggers `CountedEvent` for all `agent`s currently being counted. |
| [`Unregister`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/unregister) | Removes the player from the registered player list. *Track Registered Players* determines how registered players are counted. |
| [`UnregisterAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/player_counter_device/unregisterall) | Clears all players from the list of registered players. *Track Registered Players* determines how registered players are counted. |
