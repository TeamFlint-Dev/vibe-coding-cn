# interactable_success_limit class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_success_limit
> **爬取时间**: 2025-12-27T00:53:34.643939

---

Used to set a limit of times to interact.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `MaxSuccessfulInteractions` | `??int` | The number of times the component can be successfully interacted with. A value of false is unlimited. When SuccessfulInteractionCount reaches MaxSuccessfulInteractions all active interactions are canceled, and the component cannot be interacted with. |
| `SuccessfulInteractionCount` | `?int` | The number of times this component has had a successful interaction. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ClearSuccessfulInteractionCount`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_success_limit/clearsuccessfulinteractioncount) | Resets the counter for the times this component has had a successful interaction. |
