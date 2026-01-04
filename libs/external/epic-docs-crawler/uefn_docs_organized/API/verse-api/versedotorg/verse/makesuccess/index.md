# MakeSuccess function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/makesuccess
> **爬取时间**: 2025-12-27T01:28:33.432226

---

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Verse }` |

`MakeSuccess<public>(Result:success_type where success_type:any)<transacts><no_rollback>:`[`result(success_type,error_type)`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/result/result(success_type,error_type))

## Parameters

`MakeSuccess` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Result` | `success_type` |  |
| `success_type` | `any` |  |

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `MakeSuccess` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `available` | `MinUploadedAtFNVersion := 3800` | This feature is available beginning with the UEFN version specified by `MinUploadedAtFNVersion` and unavailable prior to that version. |

### Specifiers

The following specifiers determine how you can interact with `MakeSuccess` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `MakeSuccess` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
