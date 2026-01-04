# SetHealth function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/sethealth
> **爬取时间**: 2025-12-27T06:44:04.820536

---

Sets the health state of the Roly Poly to 'Health'.

- Health state will be clamped between 1.0 and 'GetMaxHealth'.
- Health state cannot be directly set to 0.0. To eliminate the Roly Poly, use the 'Dismiss' function on the spawner instead.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`SetHealth<override>(Health:float)<transacts>:void`

## Parameters

`SetHealth` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Health` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SetHealth` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `override` | Indicates that this child class provides a different method implementation than the parent class. |

### Effects

The following effects determine how `SetHealth` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
