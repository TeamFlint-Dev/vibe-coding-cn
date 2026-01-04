# (Rotation:rotation).GetYawPitchRollDegrees extension

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/getyawpitchrolldegrees
> **爬取时间**: 2025-12-27T02:29:27.267729

---

Makes an `[]float` with three elements:

- *yaw* degrees of `rotation`
- *pitch* degrees of `rotation`
- *roll* degrees of `rotation`
  using the conventions of `MakeRotationFromYawPitchRollDegrees`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/SpatialMath }` |

`(Rotation:rotation).GetYawPitchRollDegrees<public><native>()<reads><computes>:[]float`

## Parameters

`GetYawPitchRollDegrees` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Rotation` | `rotation` |  |

## Attributes, Specifiers, and Effects

The following attributes, specifiers, and effects determine how you can interact with `GetYawPitchRollDegrees` in your programs, as well as how it behaves in your programs and UEFN. For the complete list of attributes, specifiers, and effects; see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

### Specifiers

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
