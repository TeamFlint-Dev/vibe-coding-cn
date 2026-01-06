# SpawnAt function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/wildlife_spawner_device/spawnat
> **爬取时间**: 2025-12-27T06:32:01.281136

---

Spawn a creature at the given position. When Rotation is not provided, it will default to the Device`s rotation.
Returns the agent spawned or false if the device has reached its maximum spawn count.
This function is` ` because it takes time to load the NPC before it can be returned.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`SpawnAt<public>(Position:vector3, Rotation:?rotation)<transacts><suspends><no_rollback>:?agent`

## Parameters

`SpawnAt` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Position` | `vector3` |  |
| `Rotation` | `?rotation` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SpawnAt` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `SpawnAt` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `suspends` | Indicates that the function is async. Creates an async context for the body of the function. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
