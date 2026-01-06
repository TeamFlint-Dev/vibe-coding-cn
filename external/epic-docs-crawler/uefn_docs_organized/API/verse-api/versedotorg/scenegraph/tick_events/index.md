# tick_events class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/tick_events
> **爬取时间**: 2025-12-27T00:54:33.271110

---

Describes discrete phases of a frame update. Subscribe to members of the tick\_events object to run code before or after the physics system has updated your object, allowing you to affect or react to these updates.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

## Members

This class has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `PrePhysics` | `execution_listenable` | Listen `PrePhysics` to run your code before the physics system has updated your object this frame. |
| `PostPhysics` | `execution_listenable` | Listen `PostPhysics` to run your code after the physics system has updated your object this frame. |
