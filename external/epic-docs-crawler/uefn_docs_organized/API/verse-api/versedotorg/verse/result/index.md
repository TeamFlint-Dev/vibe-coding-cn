# result function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/result>
> **爬取时间**: 2025-12-27T01:30:28.481006

---

Implemented by classes that provide a result for an operation, which can fail or be successful

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`result<public>(success_type:any, error_type:any)<computes>:result(success_type,error_type)`

This function is a parametric type, meaning it returns a class or interface rather than a value or object instance.

## Parameters

`result` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `success_type` | `any` |  |
| `error_type` | `any` |  |

### Generated Interface

`result` returns the parametric interface [`result(success_type,error_type)`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/result/result(success_type,error_type)).

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `result` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `available` | `MinUploadedAtFNVersion := 3800` | This feature is available beginning with the UEFN version specified by `MinUploadedAtFNVersion` and unavailable prior to that version. |

### Specifiers

The following specifiers determine how you can interact with `result` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `result` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
