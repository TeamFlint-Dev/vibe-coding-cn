# MakeSRGBFromColor function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/colors/makesrgbfromcolor
> **爬取时间**: 2025-12-27T01:19:48.880520

---

Makes an sRGB `tuple` by converting `InColor` from an ACES 2065-1 `color` to sRGB.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Colors }` |

`MakeSRGBFromColor<public><native>(InColor:color):(float, float, float)`

## Parameters

`MakeSRGBFromColor` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `InColor` | `color` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `MakeSRGBFromColor` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |
