# operator'*=' function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorstarequals-1
> **爬取时间**: 2025-12-27T01:32:03.997774

---

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`operator'*='(Lhs:float, Rhs:float)<transacts><predicts>:float`

## Parameters

`operator'*='` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Lhs` | `float` |  |
| `Rhs` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `operator'*='` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |

### Effects

The following effects determine how `operator'*='` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `predicts` |  |
