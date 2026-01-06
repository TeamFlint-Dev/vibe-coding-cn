# collision_box class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/collision_box
> **爬取时间**: 2025-12-27T00:50:21.670231

---

An axis-aligned collision box.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `collision_volume`:

| Name | Description |
| --- | --- |
| [`collision_volume`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/collision_volume) | Collision Volumes represent the collision shapes of meshes. They can be detected by Overlap and Sweep queries and generate collisions in the physics simulation. |
| [`collision_element`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/collision_element) | Base class for collision\_volumes that consist of a single volume with a single collision\_profile and collision\_material for the whole volume. This covers most volume types used in queries and physics, except compound types like a mesh. A query will always return an element rather than a general volume. For example when colliding with a mesh, the element will be a collision\_triangle, which is a collision\_element and has a single material, rather than a collision\_triangle\_mesh, which is not an element and has a material palette. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Collidable` | `?logic` | Enable/disable collision on this volume. |
| `CollisionProfile` | `?collision_profile` | The collision\_profile for this volume. |
| `Extents` | `?vector3` |  |
| `Queryable` | `?logic` | Enable/disable spatial queries against this volume. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetLocalTransform`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/collision_volume/getlocaltransform) | Get the transform of this volume in the space of its owner (usually a component on an entity) |
| [`SetLocalTransform`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/collision_volume/setlocaltransform) | Set the transform of this volume in the space of its owner (usually a component on an entity) |
