# collision_interaction enumeration

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/collision_interaction>
> **爬取时间**: 2025-12-27T00:50:15.792690

---

Specifies how a collision volume pair should interact. See collision\_profile.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

## Enumerators

The `collision_interaction` enumeration includes the following enumerators:

| Name | Description |
| --- | --- |
| `Ignore` | The pair will not be detected by Overlap and Sweep queries. The pair will not collide in the physics simulation. |
| `Overlap` | The pair will be detected by Overlap and Sweep queries. The pair will not collide in the physics simulation. |
| `Block` | The pair will be detected by Overlap and Sweep queries. The pair will collide in the physics simulation. |
