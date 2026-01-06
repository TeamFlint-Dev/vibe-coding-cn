# MoveTo function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trick_tile_device/moveto-1
> **爬取时间**: 2025-12-27T05:30:47.426922

---

Moves the `trick_tile_device` to the specified `Transform` over the specified time, in seconds.
Only the trigger will move, the target buildings will not change.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`MoveTo<override>(Transform:transform, OverTime:float)<transacts><suspends><no_rollback>:`[`move_to_result`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/move_to_result)

## Parameters

`MoveTo` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Transform` | `transform` |  |
| `OverTime` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `MoveTo` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `override` | Indicates that this child class provides a different method implementation than the parent class. |

### Effects

The following effects determine how `MoveTo` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `suspends` | Indicates that the function is async. Creates an async context for the body of the function. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
