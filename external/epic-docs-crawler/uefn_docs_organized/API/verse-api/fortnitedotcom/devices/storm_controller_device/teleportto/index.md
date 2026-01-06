# TeleportTo function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/storm_controller_device/teleportto
> **爬取时间**: 2025-12-27T05:17:44.067705

---

Teleports the `storm_controller_device` to the specified `Position` and `Rotation`.
Existing storms will not target the new location, but newly generated storms will.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`TeleportTo<override>(Position:vector3, Rotation:rotation)<transacts><decides>:void`

## Parameters

`TeleportTo` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Position` | `vector3` |  |
| `Rotation` | `rotation` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `TeleportTo` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `override` | Indicates that this child class provides a different method implementation than the parent class. |

### Effects

The following effects determine how `TeleportTo` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
