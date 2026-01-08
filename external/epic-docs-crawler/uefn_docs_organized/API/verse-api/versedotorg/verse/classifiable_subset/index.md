# classifiable_subset function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/classifiable_subset>
> **爬取时间**: 2025-12-27T01:23:42.616031

---

A `classifiable_subset` is a container that holds a set of elements. A classifiable\_subset can hold multiple elements of the same type.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`classifiable_subset<public>(element_type:any)<computes>:classifiable_subset(element_type)`

This function is a parametric type, meaning it returns a class or interface rather than a value or object instance.

## Parameters

`classifiable_subset` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `element_type` | `any` |  |

### Generated Class

`classifiable_subset` returns the parametric class [`classifiable_subset(element_type)`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/classifiable_subset/classifiable_subset(element_type)).

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `classifiable_subset` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `experimental` |  | This feature is in an experimental state, and you cannot publish projects that use this feature. The API for this feature is subject to change and backward compatibility is not guaranteed. |

### Specifiers

The following specifiers determine how you can interact with `classifiable_subset` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `classifiable_subset` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
