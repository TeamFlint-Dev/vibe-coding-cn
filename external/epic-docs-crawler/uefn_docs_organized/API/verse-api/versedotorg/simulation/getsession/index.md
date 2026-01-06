# GetSession function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/simulation/getsession
> **爬取时间**: 2025-12-27T00:55:49.218273

---

Returns the `session` corresponding to the current round. The result can be used with `weak_map` to implement global variables.
Note: may be changed in a future release to return a single instance per game. Round-local behavior should not be relied upon.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Simulation }` |

`GetSession<public><native>()<reads><computes>:`[`session`](/documentation/en-us/fortnite/verse-api/versedotorg/simulation/session)

## Parameters

`GetSession` does not take any parameters.

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `GetSession` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `GetSession` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
