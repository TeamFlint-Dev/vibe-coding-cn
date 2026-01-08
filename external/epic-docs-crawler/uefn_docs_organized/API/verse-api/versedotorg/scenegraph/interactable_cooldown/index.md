# interactable_cooldown class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_cooldown>
> **爬取时间**: 2025-12-27T00:49:58.905566

---

Used to set a cooldown when interacted.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

## Members

This class has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Duration` | `?float` | The number of seconds after a successful interaction, before being able to initiate a subsequent interaction for anyone. This is only used if duration is greater than 0.0. Modifying this does not affect the RemainingDuration. When a cooldown starts on the component all other interactions are canceled. |
| `RemainingDuration` | `?float` | The remaining cooldown, in seconds, before new interactions can be initiated on this component. |
| `ExpiredEvent` | `unknown` | Event which fires when the shared cooldown expires. |
