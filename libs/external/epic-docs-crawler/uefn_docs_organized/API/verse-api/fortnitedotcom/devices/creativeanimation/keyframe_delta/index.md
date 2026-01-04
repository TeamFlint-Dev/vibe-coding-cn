# keyframe_delta struct

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/keyframe_delta
> **爬取时间**: 2025-12-27T01:57:29.704946

---

Instead of specifying the actual keyframe positions, we specify the keyframe *deltas*. This allows us to treat the initial position of the prop as keyframe 0 and avoid the question of how to get the prop to its initial location. For a `animation_mode.Loop` animation, the net rotation and translation must both be zero. Each delta is interpreted as a world-space transformation to be concatenated onto the previous transform(s).

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices/CreativeAnimation }` |

## Members

This struct has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `DeltaLocation` | `vector3` | Target position of the `creative_prop`. This is a world-space coordinate in cm, with the initial position of the `creative_prop` acting as coordinate (0,0). |
| `DeltaRotation` | `rotation` | Target rotation for the `creative_prop`. Rotations are relative to the starting rotation of the `creative_prop` |
| `DeltaScale` | `vector3` | Target scale for the `creative_prop`. Scale is multiplicative to the starting Scale of the `creative_prop` |
| `Time` | `float` | Time in seconds the `creative_prop` should animate between its last frame and this frame. |
| `Interpolation` | `cubic_bezier_parameters` | Interpolation mode for this `keyframe_delta`. See `InterpolationTypes` for standard interpolation options. See `cubic_bezier_parameters` for authoring custom interpolations. Default = `InterpolationTypes.Linear` |
