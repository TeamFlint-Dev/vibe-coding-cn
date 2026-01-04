# GetPollQuestion function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vote_group_device/getpollquestion
> **爬取时间**: 2025-12-27T05:13:44.594882

---

The display text for this poll.
For example the string “What to have for lunch?”

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`GetPollQuestion<public><final>()<transacts><no_rollback>:`[`message`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/message)

## Parameters

`GetPollQuestion` does not take any parameters.

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `GetPollQuestion` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `final` | You can only use the final specifier on classes and members of classes. When a class has the final specifier, you cannot create a subclass of the class. When a field has the final specifier, you cannot override the field in a subclass. When a method has the final specifier, you cannot override the method in a subclass. |

### Effects

The following effects determine how `GetPollQuestion` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
