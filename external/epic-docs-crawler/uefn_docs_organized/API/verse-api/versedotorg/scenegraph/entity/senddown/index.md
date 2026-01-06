# SendDown function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity/senddown
> **爬取时间**: 2025-12-27T02:46:19.878112

---

Send a scene event to this entity and then down the hierarchy. First, SendDown will be invoked on each component on this entity. Next, SendDown will be invoked on each child entity. Consuming the event at any point will halt propogation. Returns true if any participant consumed the event.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

`SendDown<public><native><native_callable>(SceneEvent:scene_event)<transacts><no_rollback>:logic`

## Parameters

`SendDown` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `SceneEvent` | `scene_event` |  |

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `SendDown` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `experimental` |  | This feature is in an experimental state, and you cannot publish projects that use this feature. The API for this feature is subject to change and backward compatibility is not guaranteed. |

### Specifiers

The following specifiers determine how you can interact with `SendDown` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |
| `native_callable` | Indicates that an instance method is both native (implemented in C++) and may be called by other C++ code. You can see this specifier used on an instance method. This specifier doesn't propagate to subclasses and so you don't need to add it to a definition when overriding a method that has this specifier. |

### Effects

The following effects determine how `SendDown` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
