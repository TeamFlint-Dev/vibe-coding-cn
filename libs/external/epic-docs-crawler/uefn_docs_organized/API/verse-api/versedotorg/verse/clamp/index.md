# Clamp function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/clamp
> **爬取时间**: 2025-12-27T01:22:50.207992

---

Constrains the value of `Val` between `A` and `B`. Robustly handles different argument orderings.
Returns the median of `Val`, `A`, and `B`, such that comparisons with `NaN` operate as if `NaN > +Inf`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`Clamp<public>(Val:float, A:float, B:float)<computes>:float`

## Parameters

`Clamp` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Val` | `float` |  |
| `A` | `float` |  |
| `B` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `Clamp` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `Clamp` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
