# MakeClassifiableSubset function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/makeclassifiablesubset
> **爬取时间**: 2025-12-27T01:28:11.542205

---

Constructs a `classifiable_subset` containing the `InElements`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`MakeClassifiableSubset<public><native>(InElements:[]t where t:any)<reads>:`[`classifiable_subset(element_type)`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/classifiable_subset/classifiable_subset(element_type))

## Parameters

`MakeClassifiableSubset` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `InElements` | `[]t` |  |
| `t` | `any` |  |

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `MakeClassifiableSubset` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `experimental` |  | This feature is in an experimental state, and you cannot publish projects that use this feature. The API for this feature is subject to change and backward compatibility is not guaranteed. |

### Specifiers

The following specifiers determine how you can interact with `MakeClassifiableSubset` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `MakeClassifiableSubset` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `reads` | This effect indicates that the same inputs to the function may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing package version. |
