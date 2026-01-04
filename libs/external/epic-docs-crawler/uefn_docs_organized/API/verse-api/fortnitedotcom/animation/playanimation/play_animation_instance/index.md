# play_animation_instance class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/animation/playanimation/play_animation_instance
> **爬取时间**: 2025-12-27T07:07:08.553668

---

An animation instance created from play\_animation\_controller.Play that can be queried and manipulated.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Animation/PlayAnimation }` |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `CompletedEvent` | `listenable(payload)` | Event triggered when the animation is completed. |
| `InterruptedEvent` | `listenable(payload)` | Event triggered when the animation is interrupted. |
| `BlendedInEvent` | `listenable(payload)` | Event triggered when the animation has finished to blend out. |
| `BlendingOutEvent` | `listenable(payload)` | Event triggered when the animation is beginning to blend out. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetState`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/animation/playanimation/play_animation_instance/getstate) | Returns the state of the animation playback. |
| [`Stop`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/animation/playanimation/play_animation_instance/stop) | Stops the animation. |
| [`Await`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/animation/playanimation/play_animation_instance/await) | Helper function that waits for the animation to complete or be interrupted. |
| [`IsPlaying`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/animation/playanimation/play_animation_instance/isplaying) | Helper function that succeeds if the state is Playing, BlendingIn, or BlendingOut. |
