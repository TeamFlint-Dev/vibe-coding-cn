# vehicle_spawner_siege_cannon_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vehicle_spawner_siege_cannon_device
> **爬取时间**: 2025-12-27T02:00:13.805505

---

Specialized `vehicle_spawner_device` that allows a siege cannon to be configured and spawned.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |
| [`vehicle_spawner_device`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vehicle_spawner_device) | Base class for various specialized vehicle spawners which allow specific vehicle types to be spawned and configured with specialized options. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `AgentEntersVehicleEvent` | `listenable(payload)` | Signaled when an `agent` enters the vehicle. Sends the `agent` that entered the vehicle. |
| `AgentExitsVehicleEvent` | `listenable(payload)` | Signaled when an `agent` exits the vehicle. Sends the `agent` that exited the vehicle. |
| `DestroyedEvent` | `listenable(payload)` | Signaled when a vehicle is destroyed. |
| `SpawnedEvent` | `listenable(payload)` | Signaled when a vehicle is spawned or respawned by this device. Sends the fort\_vehicle who was spawned. |
| `VehicleDestroyedEvent` | `listenable(payload)` | Signaled when a vehicle is destroyed. Deprecated, use DestroyedEvent instead. |
| `VehicleSpawnedEvent` | `listenable(payload)` | Signaled when a vehicle is spawned or respawned by this device. Deprecated, use SpawnedEvent instead. |

### Functions

| Function Name | Description |
| --- | --- |
| [`AssignDriver`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vehicle_spawner_device/assigndriver) | Sets `agent` as the vehicle's driver. |
| [`DestroyVehicle`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vehicle_spawner_device/destroyvehicle) | Destroys the vehicle if it exists. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vehicle_spawner_device/disable) | Disables this device. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vehicle_spawner_device/enable) | Enables this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`RespawnVehicle`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vehicle_spawner_device/respawnvehicle) | Spawns a new vehicle. The previous vehicle will be destroyed before a new vehicle spawns. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
