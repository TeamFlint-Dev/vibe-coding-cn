# SetMagnitude function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/stat_powerup_device/setmagnitude
> **爬取时间**: 2025-12-27T05:55:54.288687

---

Sets the *Magnitude* for this powerup, clamped to the Min and Max defined in the device.
Will not apply to any currently applied effects.
For the Stat Powerup, this is the value of the stat that the powerup will add or remove to a player that picks up the powerup.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`SetMagnitude<public>(Magnitude:float)<transacts><no_rollback>:void`

## Parameters

`SetMagnitude` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Magnitude` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SetMagnitude` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `SetMagnitude` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
