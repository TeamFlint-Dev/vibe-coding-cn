# SetValue function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/stat_creator_device/setvalue
> **爬取时间**: 2025-12-27T06:52:46.434451

---

Updates stat Value for `Agent`.
Succeeds if *Scope* is set to *Agent* and `Agent` passes the requirement checks on the device.
If the stat does not have levels, `Value` is clamped between 0 and *Max Value*.
If the stat does have levels, the Value is not clamped and setting a value below 0 or above *Max Value* will
decrement or increment the level appropriately. e.g. if *Number of Levels* is 10, *Max Value is 100*
and you are currently level 0, a `Value` of 550 will set you to Level 5 and Value 50.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`SetValue<public>(Agent:agent, Value:int)<transacts><decides>:void`

## Parameters

`SetValue` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Agent` | `agent` |  |
| `Value` | `int` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SetValue` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `SetValue` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
