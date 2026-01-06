# (InAgent:agent).GetInstigator extension

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/getinstigator
> **爬取时间**: 2025-12-27T01:17:49.625153

---

Returns a `game_action_instigator` interface for `InAgent`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Characters }` |

`(InAgent:agent).GetInstigator<public><native>()<transacts>:`[`game_action_instigator`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/game_action_instigator)

## Parameters

`GetInstigator` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `InAgent` | `agent` |  |

## Attributes, Specifiers, and Effects

The following attributes, specifiers, and effects determine how you can interact with `GetInstigator` in your programs, as well as how it behaves in your programs and UEFN. For the complete list of attributes, specifiers, and effects; see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

### Specifiers

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
