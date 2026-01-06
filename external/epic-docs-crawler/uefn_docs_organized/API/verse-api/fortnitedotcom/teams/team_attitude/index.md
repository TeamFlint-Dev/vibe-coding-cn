# team_attitude enumeration

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/teams/team_attitude
> **爬取时间**: 2025-12-27T01:00:16.962911

---

A generic set of team attitudes. Use this enum to model relationship behavior between your experience's agents/teams.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Teams }` |

## Enumerators

The `team_attitude` enumeration includes the following enumerators:

| Name | Description |
| --- | --- |
| `Friendly` | Agents/teams are friends. In Fortnite games two `agent`s on the same `team` are `friendly`. |
| `Neutral` | Agents/teams are neutral. In Fortnite games items and AI not belonging to a `friendly` or `hostile` team are `neutral`. |
| `Hostile` | Agents/teams are hostile. In fortnite games two `agent`s on opposing `team`s are `hostile`. |
