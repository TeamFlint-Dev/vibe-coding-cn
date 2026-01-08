# operator'-' function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/colors/operatorminus>
> **爬取时间**: 2025-12-27T01:19:27.189742

---

Makes an ACES 2065-1 `color` from the component-wise difference of `c0` and `c1`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Colors }` |

`operator'-'<public><native>(c0:color, c1:color):`[`color`](/documentation/en-us/fortnite/verse-api/versedotorg/colors/color)

## Parameters

`operator'-'` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `c0` | `color` |  |
| `c1` | `color` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `operator'-'` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |
