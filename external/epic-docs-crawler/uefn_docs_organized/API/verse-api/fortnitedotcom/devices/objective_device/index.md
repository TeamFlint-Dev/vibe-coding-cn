# objective_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device>
> **爬取时间**: 2025-12-27T01:57:58.204161

---

Provides a collection of destructible devices that you can select from to use as objectives in your game.

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
| [`healthful`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healthful) | Implemented by Fortnite objects that have health state and can be eliminated. |
| [`damageable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/damageable) | Implemented by Fortnite objects that can be damaged. |
| [`healable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healable) | Implemented by Fortnite objects that can be healed. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `DestroyedEvent` | `listenable(payload)` | Signaled when this device has been destroyed by an `agent`. Sends the `agent` that destroyed this device. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ActivateObjectivePulse`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/activateobjectivepulse) | Activates an objective pulse at `Agent`'s location pointing toward this device. |
| [`Damage`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/damage) |  |
| [`Damage`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/damage-1) |  |
| [`DamagedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/damagedevent) |  |
| [`DeactivateObjectivePulse`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/deactivateobjectivepulse) | Deactivates the objective pulse at `Agent`'s location. |
| [`Destroy`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/destroy) | Destroys the objective item. This is done regardless of the visibility or health of the item. |
| [`GetHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/gethealth) |  |
| [`GetMaxHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/getmaxhealth) |  |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Heal`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/heal) |  |
| [`Heal`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/heal-1) |  |
| [`HealedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/healedevent) |  |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/hide) | Hides this device from the world. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`SetHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/sethealth) |  |
| [`SetInvulnerable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/setinvulnerable) | Sets the device either invulnerable or damageable |
| [`SetMaxHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/setmaxhealth) |  |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/objective_device/show) | Shows this device in the world. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
