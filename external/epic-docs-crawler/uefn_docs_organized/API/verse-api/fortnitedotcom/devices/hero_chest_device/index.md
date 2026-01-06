# hero_chest_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device
> **爬取时间**: 2025-12-27T01:37:45.085162

---

An indestructible chest that can be locked and unlocked.

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
| `ChestRank` | `?hero_chest_rank` | Determines the hologram that appears above the chest, as well as the loot the chest contains.   - From low to high, the ranks are C, B, A, and S. |
| `LockedDescription` | `?message` | Descriptive text shown when interacting while the chest is locked.   - By default, this says 'You cannot open this right now.'. |
| `LockedLabel` | `?message` | Main text shown when interacting while the chest is locked.   - The default is 'Rank X Chest' where X is the value of *Rank*. |
| `LockedSublabel` | `?message` | Additional text shown when interacting while the chest is locked.   - By default, this says 'Unable to open'. |
| `OpenEvent` | `listenable(payload)` | Triggers whenever the chest is opened, returning the `agent` who opened it if applicable. |
| `ShowHologram` | `?logic` | Whether to show the rank hologram while the chest is closed. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/disable) | Disable the device. While disabled, the chest can't be interacted with. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/enable) | Enable the device, allowing interaction. |
| [`GetRankAsString`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/getrankasstring) | Returns the chest rank as a `string`. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/isenabled) | Succeeds if the device is enabled, fails if it's disabled. |
| [`IsLocked`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/islocked) | Succeeds if the chest is locked for `Agent`. |
| [`IsLockedForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/islockedforall) | Succeeds if the chest's default locked state is Locked.   - The default locked state is initialized by the *Start Locked* user option and is overridden by *LockForAll* and *UnlockForAll*. |
| [`IsOpen`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/isopen) | Succeeds if the chest is currently open, fails if it's closed. |
| [`Lock`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/lock) | Lock the chest for `Agent`. Has no effect if the chest is open. |
| [`LockForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/lockforall) | Lock the chest for everyone, and set this chest's default state to Locked. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Open`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/open) | Open the chest. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/reset) | Close the chest, refresh its loot, and set the chest to its default locked state for everyone.   - The default locked state is initialized by the *Start Locked* user option and is overridden by *LockForAll* and *UnlockForAll*. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`Unlock`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/unlock) | Unlock the chest for `Agent`. Has no effect if the chest is open. |
| [`UnlockForAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hero_chest_device/unlockforall) | Unlock the chest for everyone, and set this chest's default state to Unlocked. |
