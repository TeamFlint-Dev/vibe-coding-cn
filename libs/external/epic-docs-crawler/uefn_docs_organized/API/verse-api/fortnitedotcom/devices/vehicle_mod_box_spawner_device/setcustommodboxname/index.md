# SetCustomModBoxName function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vehicle_mod_box_spawner_device/setcustommodboxname
> **爬取时间**: 2025-12-27T05:37:47.179515

---

Set this device's mod boxes to use the name `Name`

- The displayed name will not exceed 50 characters.
- The following characters are disallowed: {, }, <, >, \, /, and |.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`SetCustomModBoxName<public>(Name:message)<transacts><no_rollback>:void`

## Parameters

`SetCustomModBoxName` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Name` | `message` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `SetCustomModBoxName` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `SetCustomModBoxName` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
