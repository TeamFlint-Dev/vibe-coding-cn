# HasAll function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/simulation/tags/tag_view/hasall
> **爬取时间**: 2025-12-27T07:11:21.726389

---

Checks if this container contains ALL of the tags in the specified container, also checks against parent tags {"A.1","B.1"}.HasAll({"A","B"}) will return True, {"A","B"}.HasAll({"A.1","B.1"}) will return False If InTags is empty/invalid it will always return True, because there were no failed checks.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Simulation/Tags }` |

`HasAll<public>(InTags:[]tag)<reads><computes><decides>:void`

## Parameters

`HasAll` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `InTags` | `[]tag` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `HasAll` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `HasAll` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
