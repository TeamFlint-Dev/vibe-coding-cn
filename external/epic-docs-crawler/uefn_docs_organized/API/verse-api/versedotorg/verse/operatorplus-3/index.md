# operator'+' function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorplus-3>
> **爬取时间**: 2025-12-27T01:27:26.146715

---

Returns a new set that is the union of all elements in `InSetL` set and `InSetR`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`operator'+'<public><native>(InSetL:classifiable_subset(element_type), InSetR:classifiable_subset(element_type) where t:any)<transacts>:`[`classifiable_subset(element_type)`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/classifiable_subset/classifiable_subset(element_type))

## Parameters

`operator'+'` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `InSetL` | `classifiable_subset(element_type)` |  |
| `InSetR` | `classifiable_subset(element_type)` |  |
| `t` | `any` |  |

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `operator'+'` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `experimental` |  | This feature is in an experimental state, and you cannot publish projects that use this feature. The API for this feature is subject to change and backward compatibility is not guaranteed. |

### Specifiers

The following specifiers determine how you can interact with `operator'+'` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `operator'+'` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
