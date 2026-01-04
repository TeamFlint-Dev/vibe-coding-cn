# ClearSuccessfulInteractionCount function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_success_limit/clearsuccessfulinteractioncount
> **爬取时间**: 2025-12-27T02:43:25.212925

---

Resets the counter for the times this component has had a successful interaction.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

`ClearSuccessfulInteractionCount<public><native>()<transacts>:void`

## Parameters

`ClearSuccessfulInteractionCount` does not take any parameters.

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `ClearSuccessfulInteractionCount` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `ClearSuccessfulInteractionCount` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
