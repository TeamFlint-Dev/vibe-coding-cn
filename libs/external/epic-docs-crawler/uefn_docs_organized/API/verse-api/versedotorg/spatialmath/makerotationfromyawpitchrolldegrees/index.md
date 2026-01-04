# MakeRotationFromYawPitchRollDegrees function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/makerotationfromyawpitchrolldegrees
> **爬取时间**: 2025-12-27T00:49:31.428944

---

Degrees version of `MakeRotationFromYawPitchRollRadians`

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SpatialMath }` |

`MakeRotationFromYawPitchRollDegrees<public><native>(YawAngle:float, PitchAngle:float, RollAngle:float)<reads>:`[`rotation`](/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/rotation)

## Parameters

`MakeRotationFromYawPitchRollDegrees` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `YawAngle` | `float` |  |
| `PitchAngle` | `float` |  |
| `RollAngle` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `MakeRotationFromYawPitchRollDegrees` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `MakeRotationFromYawPitchRollDegrees` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
