# cinematic_sequence_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device
> **爬取时间**: 2025-12-27T01:35:36.586238

---

Used to trigger level sequences that allow coordination of cinematic animation, transformation, and audio tracks.

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
| `StoppedEvent` | `listenable(payload)` | Signaled when the sequence is stopped. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetPlaybackFrame`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/getplaybackframe) | Returns the playback position (in frames) of the sequence. |
| [`GetPlaybackTime`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/getplaybacktime) | Returns the playback position (in time/seconds) of the sequence. |
| [`GetPlayRate`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/getplayrate) | Returns the playback rate of the sequence. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`GoToEndAndStop`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/gotoendandstop) | Go to the end and stop the sequence. |
| [`GoToEndAndStop`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/gotoendandstop-1) | Go to the end and stop the sequence. An instigating 'Agent' is required when the device is set to anything except *Everyone*. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Pause`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/pause) | Pauses the sequence. |
| [`Pause`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/pause-1) | Pauses the sequence. An instigating 'Agent' is required when the device is set to anything except *Everyone*. |
| [`Play`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/play) | Plays the sequence. This will only work when the device is set to *Everyone* |
| [`Play`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/play-1) | Plays the sequence. An instigating 'Agent' is required when the device is set to anything except *Everyone*. |
| [`PlayReverse`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/playreverse) | Plays the sequence in reverse. This will only work when the device is set to *Everyone* |
| [`PlayReverse`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/playreverse-1) | Plays the sequence in reverse. An instigating 'Agent' is required when the device is set to anything except *Everyone*. |
| [`SetPlaybackFrame`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/setplaybackframe) | Set the playback position (in frames) of the sequence. |
| [`SetPlaybackTime`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/setplaybacktime) | Set the playback position (in time/seconds) of the sequence. |
| [`SetPlayRate`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/setplayrate) | Set the playback rate of the sequence. |
| [`Stop`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/stop) | Stops the sequence. |
| [`Stop`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/stop-1) | Stops the sequence. An instigating 'Agent' is required when the device is set to anything except *Everyone*. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`TogglePause`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/togglepause) | Toggles between `Play` and `Stop`. |
| [`TogglePause`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/cinematic_sequence_device/togglepause-1) | Toggles between `Play` and `Stop`. An instigating 'Agent' is required when the device is set to anything except *Everyone*. |
