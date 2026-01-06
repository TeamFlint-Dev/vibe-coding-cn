# (InPlayer:player).SendToLobby extension

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/fortplayerutilities/sendtolobby
> **爬取时间**: 2025-12-27T00:59:47.875957

---

Sends `InPlayer` back to the main game lobby.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/FortPlayerUtilities }` |

`(InPlayer:player).SendToLobby<public><native>()<transacts>:void`

## Parameters

`SendToLobby` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `InPlayer` | `player` |  |

## Attributes, Specifiers, and Effects

The following attributes, specifiers, and effects determine how you can interact with `SendToLobby` in your programs, as well as how it behaves in your programs and UEFN. For the complete list of attributes, specifiers, and effects; see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

### Specifiers

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
