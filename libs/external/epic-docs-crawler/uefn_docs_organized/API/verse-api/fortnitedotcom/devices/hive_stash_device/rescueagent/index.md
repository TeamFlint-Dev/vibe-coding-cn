# RescueAgent function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device/rescueagent
> **爬取时间**: 2025-12-27T02:22:36.025537

---

Teleport `Agent` to the hive stash. If *ShouldPlayRescuedAnimation* is `true`, they will play a short animation to get off the hive stash.

- If the hive stash is closed, it will burst open first, ignoring a linked spawner. This will not clear a linked spawner.
- Has no effect if `Agent` cannot be teleported for any reason, such as not being in the game anymore.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`RescueAgent<public>(Agent:agent)<transacts><no_rollback>:void`

## Parameters

`RescueAgent` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Agent` | `agent` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `RescueAgent` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `RescueAgent` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
