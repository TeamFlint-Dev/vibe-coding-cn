# video_player_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device
> **爬取时间**: 2025-12-27T01:59:33.398157

---

Used to display curated videos onto in-game screens or player HUDs.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `StreamStartedEvent` | `listenable(payload)` | Signaled when this device becomes the controlling streaming device for the `agent`. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/disable) | Disables this device. |
| [`DisableCollision`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/disablecollision) | Disables collision checks on this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/enable) | Enables this device. |
| [`EnableCollision`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/enablecollision) | Enables collision checks on this device. |
| [`EndForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/endforall) | Turns off all streaming devices of this type on the island. |
| [`EnterFullScreen`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/enterfullscreen) | Transitions to fullscreen for `Agent`. |
| [`ExitFullScreen`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/exitfullscreen) | Transitions to fullscreen for `Agent`. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`HidePIP`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/hidepip) | Hides the picture-in-picture video from `Agent`. |
| [`MakePIPDefaultSize`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/makepipdefaultsize) | Transitions the picture-in-picture video to the default size for `Agent`. |
| [`MakePIPFullScreen`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/makepipfullscreen) | Transitions the picture-in-picture video to full screen for `Agent`. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`ReleaseControl`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/releasecontrol) | If any streaming device has forced control of the stream, this will release it and play the highest priority stream in line. |
| [`Restart`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/restart) | Restart the stream from the beginning. |
| [`Seek`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/seek) | Seeks to the *Triggered Seek Time*. Caution: The stream will pause while the video buffers when seeking. |
| [`TakeControl`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/video_player_device/takecontrol) | Stops the currently playing stream and starts the custom stream with the audio only playing from this device. *Stream Priority* will not work until control is released. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
