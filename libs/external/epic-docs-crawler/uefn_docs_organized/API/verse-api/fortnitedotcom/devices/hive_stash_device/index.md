# hive_stash_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device
> **爬取时间**: 2025-12-27T00:35:43.638390

---

A strange organic object that may have something or someone inside of it.

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
| [`healthful`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healthful) | Implemented by Fortnite objects that have health state and can be eliminated. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `CanBeDamaged` | `?logic` | Whether the hive stash can be damaged.   - `true` by default. |
| `CanDropItems` | `?logic` | Whether the hive stash drops items when opened. This can happen in addition to an `agent` being rescued.   - `true` by default. |
| `HiveStashStyle` | `?hive_stash_style` | Determines what players can see inside the hive stash, as well as its interaction text. This does not affect what happens when it opens.   - `Empty` shows nothing and says `Break Open`. - `Loot` shows a chest and says `Break Open`. - `Trapped` shows a floating character and says `Rescue`. |
| `InteractTextOverride` | `?message` | If set, this overrides the text shown when interacting while the hive stash is closed. |
| `OpenEvent` | `listenable(payload)` | Triggers whenever the hive stash is opened, returning the instigating `agent` if applicable. |
| `RescueAnimationEndEvent` | `listenable(payload)` | Triggers when the rescue animation ends.   - Returns the rescued `agent`. |
| `RescueEvent` | `listenable(payload)` | Triggers whenever an `agent` is rescued, either by the hive stash opening with a linked spawner, or by calling *RescueAgent* while the hive stash is closed.   - Returns the rescued `agent`. |
| `ShouldKeepLinkOnReset` | `?logic` | Whether to keep or clear a spawner link when *Reset* is called. Links can always be cleared with *ClearSpawnerLink*.   - `true` by default. |
| `ShouldPlayRescuedAnimation` | `?logic` | Whether an `agent` spawned from registered data or teleported by *FreeAgent* plays a short animation to get them off the hive stash.   - The animation may not work properly on skeletons other than the average player skeleton. - `true` by default. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ClearSpawnerLink`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/clearspawnerlink) | Clear the link between the hive stash and a spawner device. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/disable) | Disable the device, preventing players from interacting with it. Changes to health and state, such as those caused by damage, can still be applied. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/enable) | Enable the device, allowing players to interact with it. |
| [`GetHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/gethealth) | Get the device's current health. |
| [`GetMaxHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/getmaxhealth) | Get the device's current maximum health. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`HasLinkedSpawner`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/haslinkedspawner) | Succeeds if the device currently has a linked spawner, fails otherwise. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/isenabled) | Succeeds if the device is enabled, fails if it's disabled. |
| [`IsOpen`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/isopen) | Succeeds if the hive stash is currently open, fails otherwise. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Open`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/open) | Open the hive stash. If a spawner is linked, trigger it and rescue the resulting `agent` from the hive stash.   - When the `agent` is rescued, if *ShouldPlayRescuedAnimation* is `true`, they will play a short animation to get off the hive stash. |
| [`RescueAgent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/rescueagent) | Teleport `Agent` to the hive stash. If *ShouldPlayRescuedAnimation* is `true`, they will play a short animation to get off the hive stash.   - If the hive stash is closed, it will burst open first, ignoring a linked spawner. This will not clear a linked spawner. - Has no effect if `Agent` cannot be teleported for any reason, such as not being in the game anymore. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/reset) | Reset the hive stash. This closes it, sets it to full health, and sets *ShouldPlayRescuedAnimation*, *CanBeDamaged*, *CanDropItems*, *InteractTextOverride*, and *HiveStashStyle* to their initial values.   - This can also clear the link to a spawner depending on *ShouldKeepLinkOnReset*. - The hive stash will not reset if the rescue animation is currently playing. |
| [`SetHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/sethealth) | Set the device's current health. |
| [`SetLinkedSpawner`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/setlinkedspawner) | Link the hive stash to `GuardSpawner`. This overrides the hive stash's existing link if one exists.   - If the hive stash opens with a linked spawner, trigger the spawner and rescue the resulting `agent` from the hive stash. - The rescued `agent` respects its spawner's events, functions, spawn count, and spawn limits. |
| [`SetLinkedSpawner`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/setlinkedspawner-1) | Link the hive stash to `NPCSpawner`. This overrides the hive stash's existing link if one exists.   - If the hive stash opens with a linked spawner, trigger the spawner and rescue the resulting `agent` from the hive stash. - The rescued `agent` respects its spawner's events, functions, spawn count, and spawn limits. |
| [`SetLinkedSpawnerFromAgent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/setlinkedspawnerfromagent) | If `Agent` was spawned by a `guard_spawner_device` or `npc_spawner_device`, link the hive stash to that spawner. This overrides the hive stash's existing link if one exists.   - Fails if `Agent` is not from a `guard_spawner_device` or `npc_spawner_device`, or if `Agent` was already eliminated. - If the hive stash opens with a linked spawner, trigger the spawner and rescue the resulting `agent` from the hive stash. - The rescued `agent` respects its spawner's events, functions, spawn count, and spawn limits. |
| [`SetMaxHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/setmaxhealth) | Set the device's current maximum health. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
