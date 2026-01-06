# sweep_hit struct

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/sweep_hit
> **爬取时间**: 2025-12-27T00:55:16.779264

---

The results of a sweep query. See entity.FindSweepHits(). We will get one sweep\_hit for each intersection of any volume in SourceVolumes with any other volume.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

## Members

This struct has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `SourceComponent` | `?component` | The source component and volume (query input). For compound inputs (like an entity hierarchy) this will be a component/volume in that hierarchy. The SourceGlobalTransform is the transform of SourceVolume at the start of the sweep. For single volume inputs like a sphere, the volume and transform are just the inputs to the sweep, and the component is false. |
| `SourceVolume` | `collision_volume` | The source volume (query input). |
| `SourceStartGlobalTransform` | `transform` | The source volume transform at the start of the sweep. |
| `SourceHitTranslation` | `vector3` | The world-space translation (relative to SourceStartGlobalTransform) of SourceVolume when it touches TargetVolume. |
| `SourceHitDistance` | `float` | The Distance along the sweep at which SourceVolume touches TargetVolume. |
| `TargetComponent` | `component` | The component that was hit by SourceVolume. |
| `TargetVolume` | `collision_element` | The volume that was hit by SourceVolume. |
| `ContactPosition` | `vector3` | The point of contact between SourceVolume and TargetVolume. |
| `ContactNormal` | `vector3` | The normal on TargetVolume at the HitPosition. |
| `ContactFaceNormal` | `vector3` | If TargetVolume is a polygonal object (mesh, convex hull, etc.) and the contact point is on an edge or vertex, this is the most-opposing face normal of the faces that share that edge or vertex. Otherwise it is the same as HitNormal. |
