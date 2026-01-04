# GetItemCountRequired function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/conditional_button_device/getitemcountrequired
> **爬取时间**: 2025-12-27T06:01:14.215086

---

Returns the total quantity of a specific key item type that needs to be collected in order to activate the switch.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`GetItemCountRequired<public>(KeyItemIndex:int)<transacts>:int`

## Parameters

`GetItemCountRequired` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `KeyItemIndex` | `int` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `GetItemCountRequired` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `GetItemCountRequired` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
