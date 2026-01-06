# item_spawner_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/item_spawner_device
> **爬取时间**: 2025-12-27T01:48:45.221931

---

Used to configuration and spawn items that players can pick up and use.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |
| [`base_item_spawner_device`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/base_item_spawner_device) | Base class for devices that spawn items. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `ItemPickedUpEvent` | `listenable(payload)` | Signaled when an `agent` picks up the spawned item. Sends the `agent` that picked up the item. |

### Functions

| Function Name | Description |
| --- | --- |
| [`CycleToNextItem`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/item_spawner_device/cycletonextitem) | Cycles device to next configured item. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/base_item_spawner_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/base_item_spawner_device/enable) | Enables this device. |
| [`GetEnableRespawnTimer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/item_spawner_device/getenablerespawntimer) | Returns device *Respawn Item on Timer* option (see `SetTimeBetweenSpawns`) |
| [`GetTimeBetweenSpawns`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/item_spawner_device/gettimebetweenspawns) | Returns the *Time Between Spawns* (in seconds) after an item is collected before the next is spawned, if this device has *Respawn Item on Timer* enabled (see `SetEnableRespawnTimer`) |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`SetEnableRespawnTimer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/item_spawner_device/setenablerespawntimer) | Sets device *Respawn Item on Timer* option (see `SetTimeBetweenSpawns`) |
| [`SetTimeBetweenSpawns`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/item_spawner_device/settimebetweenspawns) | Sets the *Time Between Spawns* (in seconds) after an item is collected before the next is spawned, if this device has *Respawn Item on Timer* enabled (see `SetEnableRespawnTimer`) |
| [`SpawnItem`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/item_spawner_device/spawnitem) | Spawns the current item. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
