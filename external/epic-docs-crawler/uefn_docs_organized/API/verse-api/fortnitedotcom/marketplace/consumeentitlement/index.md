# ConsumeEntitlement function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/consumeentitlement
> **爬取时间**: 2025-12-27T01:15:53.970813

---

Consumes a consumable `entitlement`.
Fails if:

- The `entitlement` is not consumable.
- The `Player` does not own requested `Count` of `entitlement`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Marketplace }` |

`ConsumeEntitlement<public><native>(Player:player, entitlement_type:concrete_subtype(entitlement), Count:int)<transacts><suspends><no_rollback>:logic`

## Parameters

`ConsumeEntitlement` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Player` | `player` |  |
| `entitlement_type` | `concrete_subtype(entitlement)` |  |
| `Count` | `int` |  |

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `ConsumeEntitlement` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `available` | `MinUploadedAtFNVersion := 3800` | This feature is available beginning with the UEFN version specified by `MinUploadedAtFNVersion` and unavailable prior to that version. |

### Specifiers

The following specifiers determine how you can interact with `ConsumeEntitlement` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `ConsumeEntitlement` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `suspends` | Indicates that the function is async. Creates an async context for the body of the function. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
