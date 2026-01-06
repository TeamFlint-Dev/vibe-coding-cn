# GetAgents function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/teams/fort_team_collection/getagents
> **爬取时间**: 2025-12-27T02:51:20.910201

---

Returns an array of all `agent`s on `InTeam`.
Fails if `InTeam` is not part of the `fort_team_collection`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Teams }` |

`GetAgents<public>(InTeam:team)<transacts><decides>:[]agent`

## Parameters

`GetAgents` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `InTeam` | `team` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `GetAgents` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `GetAgents` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
