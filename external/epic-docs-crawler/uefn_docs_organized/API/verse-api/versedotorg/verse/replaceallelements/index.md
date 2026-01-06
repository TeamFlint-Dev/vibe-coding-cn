# (Input:[]t).ReplaceAllElements extension

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/replaceallelements
> **爬取时间**: 2025-12-27T01:23:23.606129

---

Makes an `array` by replacing all elements that equal `ElementToReplace` with `ElementToReplaceWith` in `Input`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`(Input:[]t).ReplaceAllElements<public>(ElementToReplace:t, ElementToReplaceWith:t where t:comparable)<computes>:[]t`

## Parameters

`ReplaceAllElements` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Input` | `[]t` |  |
| `ElementToReplace` | `t` |  |
| `ElementToReplaceWith` | `t` |  |
| `t` | `comparable` |  |

## Attributes, Specifiers, and Effects

The following attributes, specifiers, and effects determine how you can interact with `ReplaceAllElements` in your programs, as well as how it behaves in your programs and UEFN. For the complete list of attributes, specifiers, and effects; see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

### Specifiers

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
