# Over function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/colors/over
> **爬取时间**: 2025-12-27T01:19:05.349638

---

Blend colors `CA1` and `CA2` with `CA1` over `CA2` using two non-premultiplied `color_alpha` values.
Alpha components are clamped between `0.0` and `1.0`. Fails if the value of both clamped Alpha components are `0.0`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Colors }` |

`Over<public>(CA1:color_alpha, CA2:color_alpha)<reads><computes><decides>:`[`color_alpha`](/documentation/en-us/fortnite/verse-api/versedotorg/colors/color_alpha)

## Parameters

`Over` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `CA1` | `color_alpha` |  |
| `CA2` | `color_alpha` |  |

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `Over` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `available` | `MinUploadedAtFNVersion := 3800` | This feature is available beginning with the UEFN version specified by `MinUploadedAtFNVersion` and unavailable prior to that version. |

### Specifiers

The following specifiers determine how you can interact with `Over` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `Over` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
