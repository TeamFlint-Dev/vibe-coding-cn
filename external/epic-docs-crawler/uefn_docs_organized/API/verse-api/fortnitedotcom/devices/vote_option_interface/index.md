# vote_option_interface interface

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_interface>
> **爬取时间**: 2025-12-27T01:46:50.885000

---

Represents an individual choice in a poll.
For example, in a poll “What to have for lunch?” an option might be “Tacos”
Tracks how many times each agent has voted for this option.
An option is associated with only one group device (or “poll”) via an internal ID.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Members

This interface has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `CastVoteEvent` | `listenable(payload)` | Triggered when a vote is cast by ‘agent’ |
| `WinVoteEvent` | `listenable(payload)` | Triggered if this option wins the vote. |

### Functions

| Function Name | Description |
| --- | --- |
| [`CastVote`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_interface/castvote) | Attempts to cast a vote for ‘Agent’ If the voting agent has votes remaining and the voting group has started a vote, the vote will be cast successfully. Fails if Agent does not have votes remaining or voting group has not started. |
| [`GetVoteCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_interface/getvotecount) | Returns the total votes cast for this option. |
| [`GetVoteGroup`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_interface/getvotegroup) | Returns the group device this option corresponds to, if any. Fails if the option is not in a group, or there is no corresponding group device with the same ID. |
| [`HasAgentVoted`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_interface/hasagentvoted) | Succeeds if `Agent` has voted for this option, fails if not. |
| [`GetOptionDescription`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_option_interface/getoptiondescription) | The string to display to the user when choosing which option to select. |
