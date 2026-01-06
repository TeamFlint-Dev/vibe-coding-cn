# Take function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/item_component/take
> **爬取时间**: 2025-12-27T02:55:00.073631

---

Takes the specified amount of this item's stack, reducing this item's stack size in the process.
If taking the exact (full) amount, the item itself should be returned instead.
There is no default implementation of Take i.e. by default, it will fail.
If you want to allow this, you must override Take and return an entity containing
a new item\_component. This new entity should not be in any inventory.
See the online documentation for more details.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Itemization }` |

`Take<public><native>(Amount:int)<transacts><decides>:`[`entity`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)

## Parameters

`Take` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Amount` | `int` |  |

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `Take` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `experimental` |  | This feature is in an experimental state, and you cannot publish projects that use this feature. The API for this feature is subject to change and backward compatibility is not guaranteed. |

### Specifiers

The following specifiers determine how you can interact with `Take` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `Take` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
