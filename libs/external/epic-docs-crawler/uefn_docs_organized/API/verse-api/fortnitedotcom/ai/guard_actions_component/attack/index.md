# Attack function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/ai/guard_actions_component/attack
> **爬取时间**: 2025-12-27T02:50:24.603340

---

Attack the target. The target must have been detected.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/AI }` |

`Attack<public><native>(Target:entity)<transacts><suspends><no_rollback>:`[`result(success_type,error_type)`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/result/result(success_type,error_type))

## Parameters

`Attack` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Target` | `entity` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `Attack` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `Attack` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `suspends` | Indicates that the function is async. Creates an async context for the body of the function. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
