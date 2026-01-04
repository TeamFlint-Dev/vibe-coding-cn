# FromTransform function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/fromtransform
> **爬取时间**: 2025-12-27T02:30:24.368383

---

Util function for converting a `transform` from /UnrealEngine.com/Temporary/SpatialMath to a `transform` from /Verse.org/SpatialMath.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/SpatialMath }` |

`FromTransform<public>(InTransform:transform)<reads><computes>:`[`transform`](/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/transform)

## Parameters

`FromTransform` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `InTransform` | `transform` |  |

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `FromTransform` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `available` | `MinUploadedAtFNVersion := 3400` | This feature is available beginning with the UEFN version specified by `MinUploadedAtFNVersion` and unavailable prior to that version. |

### Specifiers

The following specifiers determine how you can interact with `FromTransform` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `FromTransform` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
