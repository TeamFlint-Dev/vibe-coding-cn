# PlayReaction function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/ai/equipped_sidekick_component/playreaction>
> **爬取时间**: 2025-12-27T02:47:53.957824

---

Request to play a given reaction on the sidekick.
This reaction is not guaranteed to play immediately; instead, the StartPlayReactionEvent should be used to monitor this.
This will fail if the Sidekick cannot play the given reaction.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/AI }` |

`PlayReaction<override><native>(Reaction:sidekick_reaction)<transacts><decides>:void`

## Parameters

`PlayReaction` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Reaction` | `sidekick_reaction` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `PlayReaction` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `override` | Indicates that this child class provides a different method implementation than the parent class. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `PlayReaction` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
