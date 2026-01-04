# (Playspace:fort_playspace).GetHUDController extension

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/gethudcontroller
> **爬取时间**: 2025-12-27T01:04:35.454403

---

Get the `fort_hud_controller` for the current `fort_playspace`.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/UI }` |

`(Playspace:fort_playspace).GetHUDController<public><native>()<transacts><no_rollback>:`[`fort_hud_controller`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/fort_hud_controller)

## Parameters

`GetHUDController` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Playspace` | `fort_playspace` |  |

## Attributes, Specifiers, and Effects

The following attributes, specifiers, and effects determine how you can interact with `GetHUDController` in your programs, as well as how it behaves in your programs and UEFN. For the complete list of attributes, specifiers, and effects; see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

### Specifiers

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
