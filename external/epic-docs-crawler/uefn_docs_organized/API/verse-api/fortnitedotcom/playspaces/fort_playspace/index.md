# fort_playspace interface

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/playspaces/fort_playspace>
> **爬取时间**: 2025-12-27T00:44:01.490277

---

A nested container that scopes objects, style, gameplay rules, visuals, etc. All objects and players in an experience will belong to a fort\_playspace. There is typically one `fort_playspace` for an entire experience, though this may change in the future as the platform evolves.

To access the `fort_playspace` for a `creative_device` use `creative_device.GetPlayspace`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Playspaces }` |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`GetPlayers`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/playspaces/fort_playspace/getplayers) | Get all human `player`s that are in the current `fort_playspace`. |
| [`GetTeamCollection`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/playspaces/fort_playspace/getteamcollection) | Get the `fort_team_collection` for the current `fort_playspace`. |
| [`PlayerAddedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/playspaces/fort_playspace/playeraddedevent) | Signaled when a human `player` joins the `fort_playspace`. Returns a subscribable with a payload of the`player` that entered the `fort_playspace`. |
| [`PlayerRemovedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/playspaces/fort_playspace/playerremovedevent) | Signaled when a human `player` leaves the `fort_playspace`. Returns a subscribable with a payload of the`player` that left the `fort_playspace`. |
| [`GetParticipants`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/playspaces/fort_playspace/getparticipants) | Get all `agent`s that are participating in the current `fort_playspace` experience. Participants might be human players (of `player` type) or AI-controlled characters (of `agent` type) that are registered and affecting the participant's count. |
| [`ParticipantAddedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/playspaces/fort_playspace/participantaddedevent) | Signaled when a participant `agent` joins the `fort_playspace`. Returns a subscribable with a payload of the`agent` that entered the `fort_playspace`. |
| [`ParticipantRemovedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/playspaces/fort_playspace/participantremovedevent) | Signaled when a participant `agent` leaves the `fort_playspace`. Returns a subscribable with a payload of the`agent` that left the `fort_playspace`. |
