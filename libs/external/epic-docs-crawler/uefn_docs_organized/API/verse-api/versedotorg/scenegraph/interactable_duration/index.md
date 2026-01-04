# interactable_duration class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_duration
> **爬取时间**: 2025-12-27T00:53:55.393374

---

Used to set an interaction duration.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `InteractDuration` | `?float` | The number of seconds an agent must spend interacting with the object to successfully complete an interaction. 0.0 or less results in an immediate successful interaction. If set during an interaction, the value given will be used for the next interaction and the remaining duration will be updated subtracting the new given value with the current time elapsed. If the subtraction were zero or less it will immediately conclude. |
| `MaxSimultaneousInteractors` | `??int` | The max number of simultaneous interactors. A value of false is unlimited. This value represents how many agents may have active interactions. If this changes to a value less than the current number of active interactions, those interactions are not canceled but new interactions will not start. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetRemainingInteractDurationForAgent`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_duration/getremaininginteractdurationforagent) | Returns an agent’s remaining duration, in seconds, for interaction. Fails if the agent is not interacting with this component.Returns the same value when called multiple times within a transaction. |
| [`SetRemainingInteractDurationForAgent`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_duration/setremaininginteractdurationforagent) | Sets an agent’s remaining duration, in seconds, for interaction. Fails if the agent is not interacting with this component. |
