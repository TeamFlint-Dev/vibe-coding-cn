# OnBeginSimulation function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/onbeginsimulation
> **爬取时间**: 2025-12-27T02:41:16.673674

---

Called when the component begins simulating within the scene.

- Use this to set up TickEvent callbacks or other setup that must be guaranteed to complete immediately.
- `OnAddedToScene` is guaranteed to run before `OnBeginSimulation`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

`OnBeginSimulation<protected><native><native_callable>()<transacts><no_rollback>:void`

## Parameters

`OnBeginSimulation` does not take any parameters.

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `OnBeginSimulation` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `protected` | The identifier is only accessible in the current class and any subtypes. You can use this on classes, interfaces, structs, enums, non-module methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |
| `native_callable` | Indicates that an instance method is both native (implemented in C++) and may be called by other C++ code. You can see this specifier used on an instance method. This specifier doesn't propagate to subclasses and so you don't need to add it to a definition when overriding a method that has this specifier. |

### Effects

The following effects determine how `OnBeginSimulation` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
