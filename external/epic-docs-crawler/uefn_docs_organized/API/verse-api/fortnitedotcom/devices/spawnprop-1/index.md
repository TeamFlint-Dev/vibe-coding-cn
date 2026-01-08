# SpawnProp function

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/spawnprop-1>
> **爬取时间**: 2025-12-27T01:52:33.773985

---

Spawns a `creative_prop` at the specified `Transform`. `Units are in cm.
Returns tuple:
0: Instance of a` creative\_prop`. False if no` creative\_prop `could be created. See` spawn\_prop\_result` for failure cases.
1: Success or failure results.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`SpawnProp<public><native>(Asset:creative_prop_asset, Transform:transform)<transacts>:(?creative_prop, spawn_prop_result)`

## Parameters

`SpawnProp` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Asset` | `creative_prop_asset` |  |
| `Transform` | `transform` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SpawnProp` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `SpawnProp` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
