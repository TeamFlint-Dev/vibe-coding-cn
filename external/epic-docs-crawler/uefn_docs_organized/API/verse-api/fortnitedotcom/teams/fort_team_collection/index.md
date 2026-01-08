# fort_team_collection interface

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/teams/fort_team_collection>
> **爬取时间**: 2025-12-27T01:00:10.338999

---

Collection used to manage `team`s and `agent`s on those teams.
Use `fort_playspace.GetTeamCollection()` to get the `team_collection` for the active experience.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Teams }` |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`GetTeams`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/teams/fort_team_collection/getteams) | Returns an array of all the `team`s known to this `fort_team_collection` |
| [`AddToTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/teams/fort_team_collection/addtoteam) | Adds `InAgent` to `InTeam`. Fails if `InTeam` is not part of the `fort_team_collection`. |
| [`IsOnTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/teams/fort_team_collection/isonteam) | Succeeds if `InAgent` is on `InTeam`. Fails if:   - `InAgent` is not on `InTeam`. - `InTeam` is not part of the `fort_team_collection`. |
| [`GetAgents`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/teams/fort_team_collection/getagents) | Returns an array of all `agent`s on `InTeam`. Fails if `InTeam` is not part of the `fort_team_collection`. |
| [`GetTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/teams/fort_team_collection/getteam) | Get the `team` that `InAgent` is on. Fails if `InAgent` is not on a team in this `fort_team_collection`. |
| [`GetTeamAttitude`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/teams/fort_team_collection/getteamattitude) | Returns the `team_attitude` between `Team1` and `Team2`. Fails if:   - `Team1` is not in this `fort_team_collection`. - `Team2` is not in this `fort_team_collection`. |
| [`GetTeamAttitude`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/teams/fort_team_collection/getteamattitude-1) | Returns the `team_attitude` between `Agent1` and `Agent2`. Fails if:   - `Agent1` is not on a team in this `fort_team_collection`. - `Agent2` is not on a team in this `fort_team_collection`. |
