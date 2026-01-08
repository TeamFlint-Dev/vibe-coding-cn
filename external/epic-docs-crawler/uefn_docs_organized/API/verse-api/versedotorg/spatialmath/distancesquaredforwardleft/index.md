# DistanceSquaredForwardLeft function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/distancesquaredforwardleft>
> **爬取时间**: 2025-12-27T00:49:36.479273

---

Returns the squared 2-D Euclidean distance between `V1` and `V2` by ignoring their difference in `Up`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SpatialMath }` |

`DistanceSquaredForwardLeft<public>(V1:vector3, V2:vector3)<reads><computes>:float`

## Parameters

`DistanceSquaredForwardLeft` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `V1` | `vector3` |  |
| `V2` | `vector3` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `DistanceSquaredForwardLeft` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `DistanceSquaredForwardLeft` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
