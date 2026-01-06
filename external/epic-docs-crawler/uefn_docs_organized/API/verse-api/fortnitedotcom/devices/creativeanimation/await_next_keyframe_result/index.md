# await_next_keyframe_result enumeration

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/await_next_keyframe_result
> **爬取时间**: 2025-12-27T01:42:33.611766

---

Results for `animation_controller.AwaitNextKeyframe` function.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices/CreativeAnimation }` |

## Enumerators

The `await_next_keyframe_result` enumeration includes the following enumerators:

| Name | Description |
| --- | --- |
| `KeyframeReached` | The next keyframe has been reached successfully. |
| `NotPlaying` | No animation is currently playing and this function call has returned immediately. |
| `AnimationAborted` | The animation was canceled either due to the object being destroyed, becoming invalid, or because it was moved via some other API. |
