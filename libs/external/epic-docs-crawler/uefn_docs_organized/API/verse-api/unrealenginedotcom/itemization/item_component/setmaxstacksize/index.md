# SetMaxStackSize function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/item_component/setmaxstacksize
> **爬取时间**: 2025-12-27T02:55:33.290445

---

Sets the maximum stack size for this item. If ClampStackSize is true, StackSize will be clamped to NewMaxStackSize.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Itemization }` |

`SetMaxStackSize<public><final><native>(NewMaxStackSize:int, ClampStackSize:logic)<transacts>:void`

## Parameters

`SetMaxStackSize` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `NewMaxStackSize` | `int` |  |
| `ClampStackSize` | `logic` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SetMaxStackSize` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `final` | You can only use the final specifier on classes and members of classes. When a class has the final specifier, you cannot create a subclass of the class. When a field has the final specifier, you cannot override the field in a subclass. When a method has the final specifier, you cannot override the method in a subclass. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `SetMaxStackSize` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
