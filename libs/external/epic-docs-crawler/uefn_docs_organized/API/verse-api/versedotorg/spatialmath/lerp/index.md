# Lerp function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/lerp
> **爬取时间**: 2025-12-27T00:47:01.394543

---

Used to linearly interpolate/extrapolate between `From` (when `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all arguments are finite.
Returns `From*(1 - Parameter) + To*Parameter`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SpatialMath }` |

`Lerp<public>(From:vector3, To:vector3, Parameter:float)<reads><computes>:`[`vector3`](/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/vector3)

## Parameters

`Lerp` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `From` | `vector3` |  |
| `To` | `vector3` |  |
| `Parameter` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `Lerp` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `Lerp` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
