# audio_mixer_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/audio_mixer_device
> **爬取时间**: 2025-12-27T01:40:05.092078

---

Used to manage sound buses via control bus mixes set on the Audio Mixer Device.

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

This class has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`ActivateMix`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/audio_mixer_device/activatemix) | Activates the mix set on the audio mixer. |
| [`DeactivateMix`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/audio_mixer_device/deactivatemix) | Deactivates the mix set on the audio mixer. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Register`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/audio_mixer_device/register) | Adds `Agent` as a target when using the *CanBeHeardBy* Registered Players or NonRegisteredPlayers options. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`Unregister`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/audio_mixer_device/unregister) | Removes `Agent` as a target when using the *CanBeHeardBy* Registered Players or NonRegisteredPlayers options. |
| [`UnregisterAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/audio_mixer_device/unregisterall) | Removes all previously registered `agent`s when using the *CanBeHeardBy* Registered Players or NonRegisteredPlayers options. |
