# SetMaxHealth function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/service_station_device/setmaxhealth
> **爬取时间**: 2025-12-27T05:54:31.908200

---

Sets the maximum health state of the object.

- MaxHealth will be clamped between 1.0 and Inf.
- Current health state will be scaled up or down based on the scale difference between the old and new MaxHealth state.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`SetMaxHealth<override>(MaxHealth:float)<transacts>:void`

## Parameters

`SetMaxHealth` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `MaxHealth` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SetMaxHealth` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `override` | Indicates that this child class provides a different method implementation than the parent class. |

### Effects

The following effects determine how `SetMaxHealth` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
