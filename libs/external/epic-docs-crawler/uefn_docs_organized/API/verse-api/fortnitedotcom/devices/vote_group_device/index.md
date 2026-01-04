# vote_group_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_group_device
> **爬取时间**: 2025-12-27T01:35:42.748784

---

Represents a poll.
For example, in a poll “What to have for lunch?” the group represents the question and contains the possible answers.
Owns the overall state of the poll and keeps track of available options.
A group can have multiple options, connected via an internal ID.

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
| `BeginVoteEvent` | `listenable(payload)` | Triggered when voting begins. |
| `EndVoteEvent` | `listenable(payload)` | Triggered when voting has completed. |
| `VoteTiedEvent` | `listenable(payload)` | Triggered when voting ends and at least two options are tied for first place. |

### Functions

| Function Name | Description |
| --- | --- |
| [`BeginVote`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_group_device/beginvote) | Allows votes to be cast for this group’s options, and starts a timer if applicable. |
| [`EndVote`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_group_device/endvote) | Prevents any more votes from being cast and picks a winner based on vote count. |
| [`GetMaxVotesPerPlayer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_group_device/getmaxvotesperplayer) | The total number of times each player can vote in this poll. If zero or less, players cannot vote. |
| [`GetPollQuestion`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_group_device/getpollquestion) | The display text for this poll. For example the string “What to have for lunch?” |
| [`GetTimeLimit`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_group_device/gettimelimit) | The amount of time this poll is available before ending, in seconds. If set to zero, the poll will not be ended by a time limit. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`GetVotingOptions`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_group_device/getvotingoptions) | Get the list of options currently in this voting group. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
