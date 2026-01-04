# MakeColorFromHex function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/colors/makecolorfromhex
> **爬取时间**: 2025-12-27T01:18:36.398498

---

Makes an ACES 2065-1 `color` from a CSS-style sRGB `hexString`. Supported formats are:

- RGB
- RRGGBB
- RRGGBBAA
- # RGB
- # RRGGBB
- # RRGGBBAA

  An invalid hex string will return `Black`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Colors }` |

`MakeColorFromHex<public><native>(hexString:[]char):`[`color`](/documentation/en-us/fortnite/verse-api/versedotorg/colors/color)

## Parameters

`MakeColorFromHex` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `hexString` | `[]char` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `MakeColorFromHex` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |
