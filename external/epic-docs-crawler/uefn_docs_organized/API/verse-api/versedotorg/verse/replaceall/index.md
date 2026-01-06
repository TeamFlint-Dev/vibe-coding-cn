# (Input:[]t).ReplaceAll extension

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/replaceall
> **爬取时间**: 2025-12-27T01:29:38.416971

---

Makes an `array` by replacing all ranges of elements that equal `ElementsToReplace` with `Replacement` in `Input`.
When there are multiple overlapping instances of `ElementsToReplace` in `Input`, only the position with the lowest index is replaced.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`(Input:[]t).ReplaceAll<public>(ElementsToReplace:[]t, Replacement:[]t where t:comparable)<transacts>:[]t`

## Parameters

`ReplaceAll` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Input` | `[]t` |  |
| `ElementsToReplace` | `[]t` |  |
| `Replacement` | `[]t` |  |
| `t` | `comparable` |  |

## Attributes, Specifiers, and Effects

The following attributes, specifiers, and effects determine how you can interact with `ReplaceAll` in your programs, as well as how it behaves in your programs and UEFN. For the complete list of attributes, specifiers, and effects; see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

### Specifiers

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
