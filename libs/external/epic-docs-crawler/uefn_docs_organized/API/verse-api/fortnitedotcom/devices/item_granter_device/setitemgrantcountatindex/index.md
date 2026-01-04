# SetItemGrantCountAtIndex function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/item_granter_device/setitemgrantcountatindex
> **爬取时间**: 2025-12-27T05:28:42.657415

---

Sets the number of items this Item Granter will award for the item at the specified `ItemIndex`.
`Count` must be greater than 0.
If *Cycle Behavior* is *Stop*, `ItemIndex` is clamped to the number of items in the Item Granter.
If *Cycle Behavior* is *Wrap*, `ItemIndex` is modulo'd to the number of items in the Item Granter.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`SetItemGrantCountAtIndex<public>(ItemIndex:int, Count:int)<transacts><no_rollback>:void`

## Parameters

`SetItemGrantCountAtIndex` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `ItemIndex` | `int` |  |
| `Count` | `int` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SetItemGrantCountAtIndex` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `SetItemGrantCountAtIndex` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
