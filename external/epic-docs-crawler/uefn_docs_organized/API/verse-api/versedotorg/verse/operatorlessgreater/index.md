# operator'<>' function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorlessgreater
> **爬取时间**: 2025-12-27T01:27:14.786940

---

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`operator'<>'(Lhs:t, Rhs:comparable where t:comparable)<decides>:t`

## Parameters

`operator'<>'` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Lhs` | `t` |  |
| `Rhs` | `comparable` |  |
| `t` | `comparable` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `operator'<>'` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |

### Effects

The following effects determine how `operator'<>'` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
