# ShowElementsForPlayer function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/fort_hud_controller/showelementsforplayer
> **爬取时间**: 2025-12-27T02:58:01.913631

---

Shows a set of HUD elements for a single player. Note: This overrides general rules set by non-player functions for the given elements. Call 'ResetElementsForPlayer' in order to return the player to general behavior

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/UI }` |

`ShowElementsForPlayer<public>(Player:player, HUDElements:[]hud_element_identifier)<transacts><no_rollback>:void`

## Parameters

`ShowElementsForPlayer` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Player` | `player` |  |
| `HUDElements` | `[]hud_element_identifier` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `ShowElementsForPlayer` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `ShowElementsForPlayer` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
