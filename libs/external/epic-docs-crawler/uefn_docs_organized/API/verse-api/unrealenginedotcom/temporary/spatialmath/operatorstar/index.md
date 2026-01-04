# operator'*' function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorstar
> **爬取时间**: 2025-12-27T02:35:48.660029

---

Makes a `vector2` by component-wise multiplication of `Left` and `Right`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/SpatialMath }` |

`operator'*'<public>(Left:vector2, Right:float)<computes>:`[`vector2`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/vector2)

## Parameters

`operator'*'` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Left` | `vector2` |  |
| `Right` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `operator'*'` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `operator'*'` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
