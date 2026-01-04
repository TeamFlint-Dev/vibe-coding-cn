# creative_prop class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop
> **爬取时间**: 2025-12-27T00:39:29.811818

---

A Fortnite prop that has been placed or spawned in the island.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from `creative_object`.

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |

## Exposed Interfaces

This class exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`invalidatable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/invalidatable) | Implemented by classes whose instances can become invalid at runtime. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `CanBeDamaged` | `?logic` | Enable/disable whether this prop can be damaged. If disabled, the creative prop will not take damage from attacks. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ApplyAngularImpulse`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/applyangularimpulse) | Apply an angular impulse to a ‘creative\_prop’ with units in Newton*meter*seconds. Will not do anything if physics is disabled. |
| [`ApplyForce`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/applyforce) | Apply a force to a ‘creative\_prop’ with units in Newtons. Will not do anything if physics is disabled. |
| [`ApplyLinearImpulse`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/applylinearimpulse) | Apply a linear impulse to a ‘creative\_prop’ with units in Newton\*seconds. Will not do anything if physics is disabled. |
| [`ApplyTorque`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/applytorque) | Apply a torque to a ‘creative\_prop’ with units in Newton\*meters. Will not do anything if physics is disabled. |
| [`Dispose`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/dispose) | Destroys the `creative_prop` and remove it from the island. |
| [`GetAngularVelocity`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/getangularvelocity) | Returns a ‘creative\_prop’s angular velocity in radians/second. |
| [`GetDynamic`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/getdynamic) | Get whether a ‘creative\_prop’ is dynamic (affected by physics functions). |
| [`GetLinearVelocity`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/getlinearvelocity) | Returns a ‘creative\_prop’s linear velocity in meters/second. |
| [`GetMass`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/getmass) | Returns a ‘creative\_prop’s mass in kilograms. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/hide) | Hides the `creative_prop` in the world and disable collisions. |
| [`IsDisposed`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/isdisposed) | Succeeds if this object has been disposed of either via `Dispose()` or through an external system. |
| [`IsValid`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/isvalid) | Succeeds if this object has not been disposed of either via `Dispose()` or through an external system. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`SetAngularVelocity`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/setangularvelocity) | Set a ‘creative\_prop’s angular velocity in radians/seconds. Will not do anything if physics is disabled. |
| [`SetDynamic`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/setdynamic) | Set whether a ‘creative\_prop’ is dynamic (affected by physics functions). Will not do anything if physics is disabled OR the prop does not have a FortPhysicsComponent. |
| [`SetLinearVelocity`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/setlinearvelocity) | Set a ‘creative\_prop’s linear velocity in meters/second. Will not do anything if physics is disabled. |
| [`SetMaterial`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/setmaterial) | Changes the Material of the Mesh used by this instance. Optionally can specify which Mesh element index to apply the material to, otherwise defaults to the 0 (default) Mesh element |
| [`SetMesh`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/setmesh) | Changes the Mesh used by this instance. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_prop/show) | Shows the `creative_prop` in the world and enable collisions. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
