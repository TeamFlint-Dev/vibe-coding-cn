# interactable_cooldown_per_agent class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_cooldown_per_agent>
> **爬取时间**: 2025-12-27T00:52:14.093747

---

Used to set a cooldown per agent when interacted.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

## Members

This class has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Duration` | `?float` | The duration in seconds after a successful interaction, before the interacting agent can initiate a subsequent interaction. This is only used if the duration is greater than 0.0. Modifying this does not affect any RemainingPerAgentCooldownDuration. This property gives other agents time to interact, when there is a limited number of Simultaneous Interactors. |
| `RemainingDuration` | `?[agent]float` | The cooldown remaining, in seconds, before a particular agent is able to initiate an interaction on this component. |
| `ExpiredEvent` | `unknown` | Event which fires when the per agent cooldown expires. Sends the agent which was previously affected by the cooldown. |
