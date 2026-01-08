# SetCooldownDelay function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/nitro_hoop_device/setcooldowndelay>
> **爬取时间**: 2025-12-27T05:51:34.997933

---

Set the duration of the cooldown delay to `Seconds`. This is the delay between triggering a cooldown and entering the cooldown phase.

- The cooldown delay does not apply to cooldowns triggered by *StartCooldown* or *Disable*.
- `Seconds` is clamped between `0.0` and `5.0`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`SetCooldownDelay<public>(Seconds:float)<transacts><no_rollback>:void`

## Parameters

`SetCooldownDelay` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Seconds` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SetCooldownDelay` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `SetCooldownDelay` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
