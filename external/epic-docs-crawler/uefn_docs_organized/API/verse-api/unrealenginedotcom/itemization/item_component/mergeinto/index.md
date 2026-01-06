# MergeInto function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/item_component/mergeinto
> **爬取时间**: 2025-12-27T02:54:39.205863

---

Attempts to merge this item into the specified item. Fails if items cannot be merged or no items are moved.
If TargetAmount is specified, only that amount will try to be merged into this item.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Itemization }` |

`MergeInto<public><final><native_callable>(TargetItem:entity, TargetAmount:?int)<transacts><decides>:void`

## Parameters

`MergeInto` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `TargetItem` | `entity` |  |
| `TargetAmount` | `?int` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `MergeInto` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `final` | You can only use the final specifier on classes and members of classes. When a class has the final specifier, you cannot create a subclass of the class. When a field has the final specifier, you cannot override the field in a subclass. When a method has the final specifier, you cannot override the method in a subclass. |
| `native_callable` | Indicates that an instance method is both native (implemented in C++) and may be called by other C++ code. You can see this specifier used on an instance method. This specifier doesn't propagate to subclasses and so you don't need to add it to a definition when overriding a method that has this specifier. |

### Effects

The following effects determine how `MergeInto` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
