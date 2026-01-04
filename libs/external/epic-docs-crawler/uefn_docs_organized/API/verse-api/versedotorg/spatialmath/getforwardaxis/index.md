# (Rotation:rotation).GetForwardAxis extension

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/getforwardaxis
> **爬取时间**: 2025-12-27T00:48:30.241228

---

Makes a unit `vector3` pointing in the *forward* rotated direction.
This is equivalent to: `vector3{Forward:=1.0, Left:=0.0, Up:=0.0} * Rotation`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SpatialMath }` |

`(Rotation:rotation).GetForwardAxis<public>()<reads><computes>:`[`vector3`](/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/vector3)

## Parameters

`GetForwardAxis` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Rotation` | `rotation` |  |

## Attributes, Specifiers, and Effects

The following attributes, specifiers, and effects determine how you can interact with `GetForwardAxis` in your programs, as well as how it behaves in your programs and UEFN. For the complete list of attributes, specifiers, and effects; see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

### Specifiers

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
