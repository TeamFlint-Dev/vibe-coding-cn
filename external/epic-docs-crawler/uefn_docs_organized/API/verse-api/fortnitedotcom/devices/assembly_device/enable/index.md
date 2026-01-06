# Enable function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/enable
> **爬取时间**: 2025-12-27T05:19:32.247934

---

Enable this object.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`Enable<override>()<transacts><no_rollback>:void`

## Parameters

`Enable` does not take any parameters.

### Attributes and Effects

The following attributes and effects determine how `Enable` behaves and how you can use it in your programs. For the complete list of attribute and effect specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Meaning |
| --- | --- |
| `override` | Indicates that this child class provides a different method implementation than the parent class. |

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
