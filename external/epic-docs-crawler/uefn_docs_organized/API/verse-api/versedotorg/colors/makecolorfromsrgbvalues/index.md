# MakeColorFromSRGBValues function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/colors/makecolorfromsrgbvalues
> **爬取时间**: 2025-12-27T01:18:41.798108

---

Makes an ACES 2065-1 `color` from the integer sRGB components `Red`, `Green`, and `Blue`.
Valid sRGB component values are between '0' and '255', inclusive.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Colors }` |

`MakeColorFromSRGBValues<public><native>(Red:int, Green:int, Blue:int):`[`color`](/documentation/en-us/fortnite/verse-api/versedotorg/colors/color)

## Parameters

`MakeColorFromSRGBValues` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Red` | `int` |  |
| `Green` | `int` |  |
| `Blue` | `int` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `MakeColorFromSRGBValues` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |
