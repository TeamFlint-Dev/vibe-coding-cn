# elimination_result struct

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/elimination_result
> **爬取时间**: 2025-12-27T01:01:00.291537

---

Result data for `fort_character` elimination events.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Game }` |

## Members

This struct has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `EliminatedCharacter` | `fort_character` | The `fort_character` eliminated from the match by `EliminatingCharacter`. |
| `EliminatingCharacter` | `?fort_character` | `fort_character` that eliminated `EliminatedCharacter` from the match. `EliminatingCharacter` will be false when `EliminatedCharacter` was eliminated through non-character actions, such as environmental damage. |
