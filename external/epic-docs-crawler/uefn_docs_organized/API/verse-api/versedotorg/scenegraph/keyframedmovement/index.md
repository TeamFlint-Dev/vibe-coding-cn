# KeyframedMovement module

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement
> **爬取时间**: 2025-12-27T00:55:03.321984

---

Module import path: /Verse.org/SceneGraph/KeyframedMovement
Animate Scene Graph entities with keyframes.

- [`Verse.org`](/documentation/en-us/fortnite/verse-api/versedotorg)
- [`SceneGraph`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph)
- **`KeyframedMovement`**

## Classes and Structs

| Name | Description |
| --- | --- |
| [`easing_function`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/easing_function) | Base class for an animation easing function. |
| [`cubic_bezier_easing_function`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/cubic_bezier_easing_function) | Cubic bezier easing function. See CubicBezierEasingFunctions for some basic easing values. |
| [`linear_easing_function`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/linear_easing_function) | `Linear` animations move at a constant speed. |
| [`ease_cubic_bezier_easing_function`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/ease_cubic_bezier_easing_function) | `Ease` animations start slowly, speed up, then end slowly. The speed of the animation is slightly slower at the end than the start. |
| [`ease_in_cubic_bezier_easing_function`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/ease_in_cubic_bezier_easing_function) | `EaseIn` animations start slow, then speed up towards the end. |
| [`ease_out_cubic_bezier_easing_function`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/ease_out_cubic_bezier_easing_function) | `EaseOut` animations start fast, then slow down towards the end. |
| [`ease_in_out_cubic_bezier_easing_function`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/ease_in_out_cubic_bezier_easing_function) | `EaseInOut` animations are similar to `Ease` but the start and end animation speed is symmetric. |
| [`keyframed_movement_playback_mode`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/keyframed_movement_playback_mode) | Controls how the animation plays back. |
| [`oneshot_keyframed_movement_playback_mode`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/oneshot_keyframed_movement_playback_mode) | Play once and stop. |
| [`loop_keyframed_movement_playback_mode`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/loop_keyframed_movement_playback_mode) | Play once and repeat indefinitely. |
| [`pingpong_keyframed_movement_playback_mode`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/pingpong_keyframed_movement_playback_mode) | Play continuously reversing direction at each end. |
| [`keyframed_movement_delta`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/keyframed_movement_delta) | Represents a change in pose and scale over a duration. |
| [`keyframed_movement_component`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/keyframed_movement_component) | Provides teleportation and simple keyframe-based animation for an entity. Animations play back in the Pre-Physics tick phase. When animating an entity with a parent\_constraint, animation will be relative to the parent entity. |
