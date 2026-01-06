# MakeRotationRadians function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/makerotationradians
> **爬取时间**: 2025-12-27T00:45:37.547359

---

Makes a `rotation` from `Axis` and `Angle` in radians using a right-handed sign convention (e.g. a positive rotation around Up takes Forward to Left).

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SpatialMath }` |

`MakeRotationRadians<public><native>(Axis:vector3, Angle:float)<reads>:`[`rotation`](/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/rotation)

## Parameters

`MakeRotationRadians` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Axis` | `vector3` |  |
| `Angle` | `float` |  |

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `MakeRotationRadians` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `available` | `MinUploadedAtFNVersion := 3600` | This feature is available beginning with the UEFN version specified by `MinUploadedAtFNVersion` and unavailable prior to that version. |
| `vm_no_effect_token` |  |  |

### Specifiers

The following specifiers determine how you can interact with `MakeRotationRadians` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `MakeRotationRadians` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
