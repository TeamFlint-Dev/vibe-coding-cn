# MakeRotationFromYawPitchRollDegrees function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/makerotationfromyawpitchrolldegrees
> **爬取时间**: 2025-12-27T02:32:29.022214

---

Makes a `rotation` by applying `YawRightDegrees`, `PitchUpDegrees`, and `RollClockwiseDegrees`, in that order:

- first a *yaw* about the Z axis with a positive angle indicating a clockwise rotation when viewed from above,
- then a *pitch* about the new Y axis with a positive angle indicating 'nose up',
- followed by a *roll* about the new X axis axis with a positive angle indicating a clockwise rotation when viewed along +X.
  Note that these conventions differ from `MakeRotation` but match `ApplyYaw`, `ApplyPitch`, and `ApplyRoll`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/SpatialMath }` |

`MakeRotationFromYawPitchRollDegrees<public><native>(YawRightDegrees:float, PitchUpDegrees:float, RollClockwiseDegrees:float)<reads>:`[`rotation`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/rotation)

## Parameters

`MakeRotationFromYawPitchRollDegrees` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `YawRightDegrees` | `float` |  |
| `PitchUpDegrees` | `float` |  |
| `RollClockwiseDegrees` | `float` |  |

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
