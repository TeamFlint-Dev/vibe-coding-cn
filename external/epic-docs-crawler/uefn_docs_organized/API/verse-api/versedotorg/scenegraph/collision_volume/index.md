# collision_volume class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/collision_volume>
> **爬取时间**: 2025-12-27T00:51:09.201309

---

Collision Volumes represent the collision shapes of meshes. They can be detected by Overlap and Sweep queries and generate collisions in the physics simulation.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Collidable` | `?logic` | Enable/disable collision on this volume. |
| `Queryable` | `?logic` | Enable/disable spatial queries against this volume. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetLocalTransform`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/collision_volume/getlocaltransform) | Get the transform of this volume in the space of its owner (usually a component on an entity) |
| [`SetLocalTransform`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/collision_volume/setlocaltransform) | Set the transform of this volume in the space of its owner (usually a component on an entity) |
