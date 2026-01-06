# SortBy function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/sortby
> **爬取时间**: 2025-12-27T02:02:04.269502

---

Stably sort `Array` using `Less` where `Less` succeeding indicates `Left` should precede `Right`

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary }` |

`SortBy<public><native>(Array:[]t, Less:`(`(t, t)`), :`void where t:any)<computes>:[]t`

## Parameters

`SortBy` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Array` | `[]t` |  |
| `Less` | (`(t, t)`), :`void` |  |
| `t` | `any` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SortBy` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `SortBy` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
