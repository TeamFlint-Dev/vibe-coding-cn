# event function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/event
> **爬取时间**: 2025-12-27T00:20:33.946625

---

A *recurring*, successively signaled parametric `event` with a `payload` allowing a simple mechanism to coordinate between concurrent tasks.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`event<public>(t:any)<computes>:event(t)`

This function is a parametric type, meaning it returns a class or interface rather than a value or object instance.

## Parameters

`event` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `t` | `any` |  |

### Generated Class

`event` returns the parametric class [`event(t)`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/event/event(t)).

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `event` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `event` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
