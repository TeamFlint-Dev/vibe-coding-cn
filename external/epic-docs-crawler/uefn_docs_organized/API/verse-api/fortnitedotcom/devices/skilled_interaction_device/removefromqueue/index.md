# RemoveFromQueue function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/skilled_interaction_device/removefromqueue
> **爬取时间**: 2025-12-27T06:05:41.419660

---

Remove `agent`(s) from the queue, has the option to remove all entries that exist for that agent or not
This does not end the interaction for any agents.
Returns the number of agents that were removed.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

`RemoveFromQueue<public>(Agents:[]agent, AllEntries:logic)<transacts><no_rollback>:int`

## Parameters

`RemoveFromQueue` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Agents` | `[]agent` |  |
| `AllEntries` | `logic` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `RemoveFromQueue` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `RemoveFromQueue` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
