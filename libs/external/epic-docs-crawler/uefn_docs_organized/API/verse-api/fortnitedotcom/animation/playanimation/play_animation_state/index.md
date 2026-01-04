# play_animation_state enumeration

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/animation/playanimation/play_animation_state
> **爬取时间**: 2025-12-27T07:07:03.472126

---

The potential states of a play animation instance.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Animation/PlayAnimation }` |

## Enumerators

The `play_animation_state` enumeration includes the following enumerators:

| Name | Description |
| --- | --- |
| `BlendingIn` | The animation is blending in. |
| `Playing` | The animation has blended in, is playing, and has not begun blending out. |
| `BlendingOut` | The animation is playing and is blending out. |
| `Completed` | The animation completed successfully. |
| `Stopped` | The animation was stopped internally. |
| `Interrupted` | The animation was interrupted externally. |
| `Error` | An error occurred at creation or during playback. |
