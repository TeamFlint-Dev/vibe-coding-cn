# damage_result struct

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/damage_result>
> **爬取时间**: 2025-12-27T01:00:55.089729

---

Results for damage events on Fortnite objects.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Game }` |

## Members

This struct has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Target` | `damageable` | Object that was damaged. |
| `Amount` | `float` | Amount of damage applied to `Target`. |
| `Instigator` | `?game_action_instigator` | Player, agent, etc. that instigated the damage to `Target`. Can be false when damage is instigated by code, the environment, etc. |
| `Source` | `?game_action_causer` | Player, weapon, vehicle, etc. that damaged `Target`. Can be false when damage is caused by code, the environment, etc. |
