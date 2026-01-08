# MakeColorFromSRGB function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/colors/makecolorfromsrgb>
> **爬取时间**: 2025-12-27T01:19:54.787305

---

Makes an ACES 2065-1 `color` from sRGB components `Red`, `Green`, and `Blue`.
Normal sRGB component values are between `0.0` and `1.0`, but this can handle larger values.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Colors }` |

`MakeColorFromSRGB<public><native>(Red:float, Green:float, Blue:float):`[`color`](/documentation/en-us/fortnite/verse-api/versedotorg/colors/color)

## Parameters

`MakeColorFromSRGB` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Red` | `float` |  |
| `Green` | `float` |  |
| `Blue` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `MakeColorFromSRGB` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |
