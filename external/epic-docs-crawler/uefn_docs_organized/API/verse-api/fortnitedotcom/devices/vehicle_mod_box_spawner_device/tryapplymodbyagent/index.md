# TryApplyModByAgent function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vehicle_mod_box_spawner_device/tryapplymodbyagent
> **爬取时间**: 2025-12-27T05:39:17.628379

---

Apply the mod at `Index` in the device's list to the vehicle that `Agent` is riding.

- The first index in the list is `0` for Custom List Mod 1.
- Triggers `ModAppliedEvent`, `ModApplyFailEvent`, and `NoModEvent` as appropriate, regardless of `SetOverrideModApplyEvent`.
- Fails if this device is disabled, *Possible Mods* is not set to `Custom List`, `Index` or `Agent` is invalid, or `Agent` is not riding a vehicle.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`TryApplyModByAgent<public>(Index:int, Agent:agent)<transacts><decides>:void`

## Parameters

`TryApplyModByAgent` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Index` | `int` |  |
| `Agent` | `agent` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `TryApplyModByAgent` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `TryApplyModByAgent` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
