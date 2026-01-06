# operator'/' function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/colors/operatorslash-1
> **爬取时间**: 2025-12-27T01:18:20.965116

---

Makes an ACES 2065-1 `color` from each component of `c` divided by `factor`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Colors }` |

`operator'/'<public><native>(c:color, factor:int)<decides>:`[`color`](/documentation/en-us/fortnite/verse-api/versedotorg/colors/color)

## Parameters

`operator'/'` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `c` | `color` |  |
| `factor` | `int` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `operator'/'` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `operator'/'` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
