# disguise_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/disguise_device>
> **爬取时间**: 2025-12-27T01:58:21.523145

---

Used to apply a cosmetic disguise to the player.
The disguise to apply is defined on the device, as are the conditions for when the disguise breaks.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |

## Exposed Interfaces

This class exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`enableable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/enableable) | Implemented by classes whose instances can be enabled and disabled. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `ApplyAnyDisguiseEvent` | `listenable(payload)` | Signaled when any disguise is successfully applied to `player`. Includes disguises applied by any disguise device, or by a disguise kit. |
| `ApplyDisguiseEvent` | `listenable(payload)` | Signaled when a disguise from this device is successfully applied to `player`. |
| `BreakAnyDisguiseEvent` | `listenable(payload)` | Signaled when any applied disguise on `player` is broken. Includes disguises applied by any disguise device, or by a disguise kit. The second optional `agent` describes who broke the disguise (the damage source if broken by damage or elimination). The conditions triggering a disguise to break are set in the device's user options. |
| `BreakDisguiseEvent` | `listenable(payload)` | Signaled when a disguise applied by this device on `player` is broken. The second optional `agent` describes who broke the disguise (the damage source if broken by damage or elimination). The conditions triggering a disguise to break are set in the device's user options. |
| `RemoveAnyDisguiseEvent` | `listenable(payload)` | Signaled when any applied disguise on `player` is removed. Includes disguises applied by any disguise device, or by a disguise kit. Removal can occur from calling the *Remove Disguise* function, or from getting replaced by another disguise. This event will not trigger if the disguise is broken. |
| `RemoveDisguiseEvent` | `listenable(payload)` | Signaled when a disguise applied by this device on `player` is removed. Removal can occur from calling the *Remove Disguise* function, or from getting replaced by another disguise. This event will not trigger if the disguise is broken. |
| `ShouldApplyDisguiseOnPlayerSpawn` | `?logic` | Maps to the user option for *Should Apply Disguise on Spawn*. If this is true, the device will apply a disguise to the player as soon as they spawn, so long as they pass the device's filter options. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ApplyDisguise`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/disguise_device/applydisguise) | Applies the disguise to the provided `player`. If the provided `player` does not pass the device's filter settings, or if another disguise is already present and the device's *Stomp Existing Disguise* option is set to false, the disguise will not be applied. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/disguise_device/disable) | Disables this device, preventing it from listening to inputs. Disguises applied by this device are not removed when the device is disabled. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/disguise_device/enable) | Enables this device, allowing it to listen for inputs. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsAnyDisguiseApplied`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/disguise_device/isanydisguiseapplied) | Succeeds if the provided `player` has any disguise applied. Includes disguises applied by any disguise device, or by a disguise kit. |
| [`IsDisguiseApplied`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/disguise_device/isdisguiseapplied) | Succeeds if the provided `player` has a disguise applied from this device. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/disguise_device/isenabled) | Succeeds if the object is enabled, fails if it is disabled. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`RemoveAnyDisguise`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/disguise_device/removeanydisguise) | Removes any applied disguise from `player`. Includes disguises applied by any disguise device, or by a disguise kit. |
| [`RemoveDisguise`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/disguise_device/removedisguise) | Removes the disguise applied by this device, if it exists, from the provided `player`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
