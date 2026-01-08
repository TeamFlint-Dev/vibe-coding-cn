# HideNearbyPlayers function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hiding_prop_device/hidenearbyplayers>
> **爬取时间**: 2025-12-27T06:45:06.557639

---

Hides all players within the provided meters of a hiding prop.
Returns an array of all players that were hidden.
This event will not allow more players than is specified in 'MaxNumberOfOccupants' to be hidden in this device.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`HideNearbyPlayers<public>(DistanceInMeters:float)<transacts><no_rollback>:[]player`

## Parameters

`HideNearbyPlayers` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `DistanceInMeters` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `HideNearbyPlayers` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `HideNearbyPlayers` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
