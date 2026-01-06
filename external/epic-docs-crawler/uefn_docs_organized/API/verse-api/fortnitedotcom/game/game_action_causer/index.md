# game_action_causer interface

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/game_action_causer
> **爬取时间**: 2025-12-27T01:01:22.849353

---

Implemented by Fortnite objects that can be passed through game action events, such as damage and heal.
For example: player, vehicle, or weapon.

Event Listeners often use `game_action_causer` to pass along additional information about what weapon caused the damage.
Systems will then use that information for completing quests or processing game specific event logic.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Game }` |

## Members

This interface has no members.
