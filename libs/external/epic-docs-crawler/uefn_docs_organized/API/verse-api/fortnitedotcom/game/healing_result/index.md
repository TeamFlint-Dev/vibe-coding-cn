# healing_result struct

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healing_result
> **爬取时间**: 2025-12-27T01:01:11.202517

---

Results for healing events on Fortnite objects.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Game }` |

## Members

This struct has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Target` | `healable` | Object that was healed. |
| `Amount` | `float` | Amount of healing applied to `Target`. |
| `Instigator` | `?game_action_instigator` | Player, agent, etc. that instigated healing of the `Target`. Can be false when damage is instigated by code, the environment, etc. |
| `Source` | `?game_action_causer` | Player, weapon, vehicle, etc. that healed `Target`. Can be false when damage is caused by code, the environment, etc. |
