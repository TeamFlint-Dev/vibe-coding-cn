# healing_args struct

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healing_args
> **爬取时间**: 2025-12-27T01:01:17.180098

---

Parameters for common healing functions on Fortnite objects.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Game }` |

## Members

This struct has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Instigator` | `?game_action_instigator` | Player, agents, etc. that instigated the healing of the object. |
| `Source` | `?game_action_causer` | Player, weapon, vehicle, etc. that healed the object. |
| `Amount` | `float` | Amount of healing to apply to the object. |
