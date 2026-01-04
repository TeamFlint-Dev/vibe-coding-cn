# MakeColorFromHSV function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/colors/makecolorfromhsv
> **爬取时间**: 2025-12-27T01:18:53.929871

---

Makes an ACES 2065-1 `color` from `Hue`, `Saturation`, and `Value` components.
Components use the HSV color model in the sRGB color space. Expected ranges:

- `0.0 <= Hue <= 360.0`
- `0.0 <= Saturation <= 1.0`
- `0.0 <= Value <= 1.0`
  Values out of expected ranges will undergo range reduction and conversion.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Colors }` |

`MakeColorFromHSV<public><native>(Hue:float, Saturation:float, Value:float):`[`color`](/documentation/en-us/fortnite/verse-api/versedotorg/colors/color)

## Parameters

`MakeColorFromHSV` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Hue` | `float` |  |
| `Saturation` | `float` |  |
| `Value` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `MakeColorFromHSV` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |
