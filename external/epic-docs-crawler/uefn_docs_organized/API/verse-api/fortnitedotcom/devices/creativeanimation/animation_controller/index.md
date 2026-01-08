# animation_controller class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/animation_controller>
> **爬取时间**: 2025-12-27T01:48:38.026214

---

Used to move and animate the position of `creative_prop` objects.

- See `creative_prop.GetAnimationController` for information on acquiring an instance of an
  `animation_controller` for a given `creative_prop`.
- See `SetAnimation` for details on authoring movement and animations.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices/CreativeAnimation }` |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `KeyframeReachedEvent` | `listenable(payload)` | Signaled each time a keyframe is reached. Callback(KeyframeIndex:int, InReverse:logic). Note that the KeyframeIndex in the callback is generally in [1, NumDeltaKeyframes] except that in a PingPong animation the final keyframe played in reverse is identified as index 0. This is because SetAnimation takes *delta* keyframes whereas this event notifies the listener that a specific keyframe has been reached. |
| `MovementCompleteEvent` | `listenable(payload)` | Signaled when the entire animation is complete. This will only fire for `OneShot` animations. |
| `StateChangedEvent` | `listenable(payload)` | Signaled when the state has changed. Use `GetState` to get the new state. |

### Functions

| Function Name | Description |
| --- | --- |
| [`AwaitNextKeyframe`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/animation_controller/awaitnextkeyframe) | Suspends at the callsite until the next `keyframe_delta` is finished. This will also return if the animation is aborted or not playing. See `await_next_keyframe_result` if your code needs to take different paths based on why `AwaitNextKeyframe` returned. |
| [`Play`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/animation_controller/play) | Starts or resumes playback of the animation. |
| [`Pause`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/animation_controller/pause) | Pauses the animation if it is already playing. |
| [`Stop`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/animation_controller/stop) | Stops playback and resets the animation to the first keyframe. Also resets the prop transform. Calling this method is valid while the animation is in the `Playing` or `Paused` states. |
| [`GetState`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/animation_controller/getstate) | Returns the current state of this `animation_controller`. |
| [`IsValid`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/animation_controller/isvalid) | Succeeds if this `animation_controller`s target is still valid (i.e., the target has not been disposed of either via `Dispose` or through any external system.) |
| [`SetAnimation`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creativeanimation/animation_controller/setanimation) | Sets the animation for the `animation_controller`. Animations are processed in the order provided in `Keyframes`. See notes in `keyframe_delta` and `animation_mode` for more details on controlling the animations. |
