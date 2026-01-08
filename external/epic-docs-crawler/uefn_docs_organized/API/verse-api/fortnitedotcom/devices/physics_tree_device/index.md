# physics_tree_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/physics_tree_device>
> **爬取时间**: 2025-12-27T01:56:30.551962

---

Physics tree that can be chopped down, and damage players, vehicles, creatures, and structures.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |
| [`prop_spawner_base_device`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_spawner_base_device) | Base class for devices that spawn a prop object. |
| [`physics_object_base_device`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/physics_object_base_device) | Base class for various physics-based gameplay elements (e.g. boulders/trees). |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `LogDestroyedEvent` | `listenable(payload)` | Signaled when the log created by a tree is destroyed. |
| `StumpDestroyedEvent` | `listenable(payload)` | Signaled when the stump created by a tree is destroyed. |
| `TreeKnockedDownEvent` | `listenable(payload)` | Signaled when a tree has taken enough damage to be knocked down. |
| `TreeSpawnedEvent` | `listenable(payload)` | Signaled when a tree is spawned. |

### Functions

| Function Name | Description |
| --- | --- |
| [`DestroyAllSpawnedObjects`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_spawner_base_device/destroyallspawnedobjects) | Destroys all props spawned from this device. |
| [`DestroyLog`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/physics_tree_device/destroylog) | Destroys the current log. |
| [`DestroyStump`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/physics_tree_device/destroystump) | Destroys the current stump. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_spawner_base_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_spawner_base_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`ReleaseLog`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/physics_tree_device/releaselog) | Releases the log from the tree, if there is one. |
| [`SpawnObject`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_spawner_base_device/spawnobject) | Spawns the prop associated with this device. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
