# ToString function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/tostring-1
> **爬取时间**: 2025-12-27T00:48:03.714331

---

Makes a `string` representation of `InTransform` where the result is on the form.
`"{Translation = {ToString(`InTransform.Translation`)}, Rotation = {ToString(`InTransform.Rotation`)}, Scale = {ToString(`InTransform.Scale`)}}".

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SpatialMath }` |

`ToString<public>(InTransform:transform)<reads><computes>:[]char`

## Parameters

`ToString` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `InTransform` | `transform` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `ToString` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `ToString` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
