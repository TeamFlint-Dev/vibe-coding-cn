# FitsInPlayerMap function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/fitsinplayermap
> **爬取时间**: 2025-12-27T01:22:04.586101

---

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`FitsInPlayerMap(Value:t where t:)<reads><decides>:t`

## Parameters

`FitsInPlayerMap` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Value` | `t` |  |
| `t` |  |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `FitsInPlayerMap` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |

### Effects

The following effects determine how `FitsInPlayerMap` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
