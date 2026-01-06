# fort_round_manager interface

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/fort_round_manager
> **爬取时间**: 2025-12-27T01:00:39.022835

---

This interface is implemented by the round manager living on the simulation entity.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Game }` |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`SubscribeRoundStarted`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/fort_round_manager/subscriberoundstarted) | Subscribed callbacks will be invoked in two scenarios:   - When a new Fortnite round starts - If a round is ongoing, your callback will be invoked immediately   Upon the round ending, all callbacks will be canceled |
| [`SubscribeRoundEnded`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/fort_round_manager/subscriberoundended) | Subscribed callbacks will be invoked when a Fortnite round ends |
