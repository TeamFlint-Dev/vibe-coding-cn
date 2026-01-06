# animation_mode enumeration

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/animation_mode
> **爬取时间**: 2025-12-27T01:52:46.417110

---

Animation play modes.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices/CreativeAnimation }` |

## Enumerators

The `animation_mode` enumeration includes the following enumerators:

| Name | Description |
| --- | --- |
| `OneShot` | Stop after playing the animation once. |
| `PingPong` | Reverse direction after reaching the final `keyframe_delta`, then play the animation in reverse. |
| `Loop` | Play the animation in a loop. This requires the animation ends exactly where it began. |
