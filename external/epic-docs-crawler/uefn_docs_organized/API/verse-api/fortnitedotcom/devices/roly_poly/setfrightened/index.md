# SetFrightened function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/setfrightened
> **爬取时间**: 2025-12-27T06:44:28.119199

---

Set the Frightened status of the Roly Poly.

- Setting to true will frighten the Roly Poly.
- Setting to false will soothe the Roly Poly.
- An 'agent' can be provided and will be passed back as the signaled events 'agent'.
- Depending on the state the Roly Poly is in, it may take a few seconds for the FrightenedEvent to be signaled. Ex. When a player is in the Roly Poly, it will buck the player and enter the frightened state when it lands on solid ground.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`SetFrightened<public>(Frightened:logic, Agent:?agent)<transacts><no_rollback>:void`

## Parameters

`SetFrightened` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Frightened` | `logic` |  |
| `Agent` | `?agent` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SetFrightened` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `SetFrightened` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
