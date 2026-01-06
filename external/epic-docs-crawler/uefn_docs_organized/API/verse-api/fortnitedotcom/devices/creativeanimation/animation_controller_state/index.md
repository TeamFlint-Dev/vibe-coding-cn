# animation_controller_state enumeration

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/animation_controller_state
> **爬取时间**: 2025-12-27T01:49:10.114234

---

`animation_controller` states.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices/CreativeAnimation }` |

## Enumerators

The `animation_controller_state` enumeration includes the following enumerators:

| Name | Description |
| --- | --- |
| `InvalidObject` | The target of the animation is not an animatable prop. This could be because:   - It is not a `creative_prop` that can be animated. - It was disposed or otherwise destroyed. - It has the 'Register with Structural Grid' option set in UEFN. |
| `AnimationNotSet` | No animation has been successfully set via `animation_controller.SetAnimation`, or that animation has been cleared by a failed call to `animation_controller.SetAnimation`. |
| `Stopped` | Animation has either never started, finished, or was explicitly stopped. |
| `Playing` | Animation is playing. |
| `Paused` | Animation is paused. |
