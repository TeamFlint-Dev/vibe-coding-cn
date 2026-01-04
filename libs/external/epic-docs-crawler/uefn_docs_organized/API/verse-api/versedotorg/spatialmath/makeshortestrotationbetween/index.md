# MakeShortestRotationBetween function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/makeshortestrotationbetween
> **爬取时间**: 2025-12-27T00:45:21.410133

---

Makes the smallest angular `rotation` from `InitialVector` to `FinalVector` two vectors of arbitrary length such that:
`InitialVector * MakeShortestRotationBetween(InitialVector, FinalVector) = FinalVector` and
`MakeShortestRotationBetween(InitialVector, FinalVector)?.GetAngleRadians()` is as small as possible.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SpatialMath }` |

`MakeShortestRotationBetween<public><native>(InitialVector:vector3, FinalVector:vector3)<reads>:`[`rotation`](/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/rotation)

## Parameters

`MakeShortestRotationBetween` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `InitialVector` | `vector3` |  |
| `FinalVector` | `vector3` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `MakeShortestRotationBetween` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `MakeShortestRotationBetween` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
