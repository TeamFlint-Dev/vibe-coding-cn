# BeginInteraction function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/begininteraction-1
> **爬取时间**: 2025-12-27T06:05:58.760690

---

Begins the interaction for the provided `agent`(s).
Will cancel any other interactions already in progress for the `agent` if a queue is not being utilized.
If a queue is being utilized and duplicate player entries are not allowed then any duplicate player entries in the queue will not be added.
If the number of agents requesting interact fits into the current interaction configuration, then those agents will begin
interact immediately and skip the queue entirely.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`BeginInteraction<public>(Agents:[]agent)<transacts><decides>:void`

## Parameters

`BeginInteraction` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Agents` | `[]agent` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `BeginInteraction` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `BeginInteraction` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
