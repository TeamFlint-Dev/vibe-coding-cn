# IsEnabled function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/scout_spire_device/isenabled
> **爬取时间**: 2025-12-27T06:59:54.869057

---

Succeeds if the Spire is enabled and fails if it is disabled.

- While disabled, the Spire is inactive: it will not react to players or take damage.
- If the Spire is currently despawned, this function instead reports the enabled state the Spire will have the next time it is spawned.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`IsEnabled<override>()<transacts><decides>:void`

## Parameters

`IsEnabled` does not take any parameters.

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `IsEnabled` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `override` | Indicates that this child class provides a different method implementation than the parent class. |

### Effects

The following effects determine how `IsEnabled` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
