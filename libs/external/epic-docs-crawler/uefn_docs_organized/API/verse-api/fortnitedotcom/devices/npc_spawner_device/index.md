# npc_spawner_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/npc_spawner_device
> **爬取时间**: 2025-12-27T01:51:10.612421

---

Used to spawn NPCs made with Character Definition asset.

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
| `EliminatedEvent` | `listenable(payload)` | Signaled when a character is eliminated. `Source` is the `agent` that eliminated the character. If the character was eliminated by a non-agent then `Source` is 'false'. `Target` is the character that was eliminated. |
| `SpawnedEvent` | `listenable(payload)` | Signaled when a character is spawned. Sends the `agent` character who was spawned. |

### Functions

| Function Name | Description |
| --- | --- |
| [`DespawnAll`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/npc_spawner_device/despawnall) | Despawns all characters. If set, `Instigator` will be considered as the eliminator of those characters. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/npc_spawner_device/disable) | Disables this device. Characters will despawn if *Despawn AIs When Disabled* is set. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/npc_spawner_device/enable) | Enables this device. Characters will start to spawn. |
| [`GetAgents`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/npc_spawner_device/getagents) | Get all agents created by this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/npc_spawner_device/reset) | Resets the spawn count allowing spawning of a new batch of characters. |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/npc_spawner_device/spawn) | Tries to spawn a character. |
| [`SpawnAt`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/npc_spawner_device/spawnat) | Spawn a NPC at the given position. When Rotation is not provided, it will default to the Device`s rotation. Returns the agent spawned or false if the device has reached its maximum spawn count. This function is` ` because it takes time to load the NPC before it can be returned. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
