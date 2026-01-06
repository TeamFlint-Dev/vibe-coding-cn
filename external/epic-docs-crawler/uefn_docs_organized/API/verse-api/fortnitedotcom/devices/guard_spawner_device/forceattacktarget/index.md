# ForceAttackTarget function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/guard_spawner_device/forceattacktarget
> **爬取时间**: 2025-12-27T06:04:05.455637

---

Forces guards to attack `Target`, bypassing perception checks.
'ForgetTime' ranges from 0.0 to 600.0 (in seconds, default is 600.0), it is the time after which the target will be ignored if not found.
'ForgetDistance' ranges from 0.0 to 100000.0 (in centimeters, default is 100000.0), it is the distance at which the target will be ignored if not found.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`ForceAttackTarget<public>(Target:agent, ForgetTime:float, ForgetDistance:float)<transacts><no_rollback>:void`

## Parameters

`ForceAttackTarget` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Target` | `agent` |  |
| `ForgetTime` | `float` |  |
| `ForgetDistance` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `ForceAttackTarget` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `ForceAttackTarget` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
