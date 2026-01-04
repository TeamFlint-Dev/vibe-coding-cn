# SetCarryableMaterial function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/carryable_spawner_device/setcarryablematerial
> **爬取时间**: 2025-12-27T06:28:34.932012

---

Set the material of the carryable.
Index describes which material index on the mesh the material will apply to.
This will update immediately if already spawned, and also apply to any carryable spawned from this device in the future.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`SetCarryableMaterial<public>(Material:material, Index:int)<transacts><no_rollback>:void`

## Parameters

`SetCarryableMaterial` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Material` | `material` |  |
| `Index` | `int` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SetCarryableMaterial` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `SetCarryableMaterial` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
