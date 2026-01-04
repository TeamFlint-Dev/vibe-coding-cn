# MakeColorAlpha function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/colors/makecoloralpha
> **爬取时间**: 2025-12-27T01:19:11.271225

---

Makes a new `color_alpha` from individual `R`, `G`, `B`, `A` component values.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Colors }` |

`MakeColorAlpha<public>(R:float, G:float, B:float, A:float)<computes>:`[`color_alpha`](/documentation/en-us/fortnite/verse-api/versedotorg/colors/color_alpha)

## Parameters

`MakeColorAlpha` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `R` | `float` |  |
| `G` | `float` |  |
| `B` | `float` |  |
| `A` | `float` |  |

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `MakeColorAlpha` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `available` | `MinUploadedAtFNVersion := 3800` | This feature is available beginning with the UEFN version specified by `MinUploadedAtFNVersion` and unavailable prior to that version. |

### Specifiers

The following specifiers determine how you can interact with `MakeColorAlpha` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `MakeColorAlpha` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
