# Print function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/diagnostics/log/print
> **爬取时间**: 2025-12-27T07:10:41.288154

---

Print message using the given log level

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/Diagnostics }` |

`Print<public>(Message:[]char, Level:log_level)<computes>:void`

## Parameters

`Print` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Message` | `[]char` |  |
| `Level` | `log_level` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `Print` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `Print` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
