# AddComponents function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity/addcomponents
> **爬取时间**: 2025-12-27T02:46:45.232020

---

Adds the provided components to the entity.

- If a component is not allowed to be added to this entity it is skipped.
  Note: When called during the AddedToScene or BeginSimulation phase, it will make sure the added component has achieved the corresponding phase.
- Components are added following these rules:
  1. All components are added to the entity child list.
  2. All components have `OnAddedToScene` called (if this entity is in the scene).
  3. All components have `OnBeginSimulation` called (if this entity is simulating).

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

`AddComponents<public><native><final>(Components:[]component)<transacts><no_rollback>:void`

## Parameters

`AddComponents` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Components` | `[]component` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `AddComponents` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |
| `final` | You can only use the final specifier on classes and members of classes. When a class has the final specifier, you cannot create a subclass of the class. When a field has the final specifier, you cannot override the field in a subclass. When a method has the final specifier, you cannot override the method in a subclass. |

### Effects

The following effects determine how `AddComponents` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
