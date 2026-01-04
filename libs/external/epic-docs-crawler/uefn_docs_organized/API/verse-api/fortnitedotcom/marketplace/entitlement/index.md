# entitlement class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/marketplace/entitlement
> **爬取时间**: 2025-12-27T01:14:59.028693

---

An entitlement that is tracked by the commerce system.

- A player may only have one `entitlement` if the entitlement is not consumable.
- A player may have `MaxCount` of a consumable entitlement.
- Your derived type must be  to be used by the purchase system.
- If the entitlement you are selling gives players a meaningful advantage in your island, you must set ConsequentialToGameplay to true.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Marketplace }` |

## Exposed Interfaces

This class exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`has_icon`](/documentation/en-us/fortnite/verse-api/versedotorg/assets/has_icon) | Interface that provides an icon. |
| [`has_description`](/documentation/en-us/fortnite/verse-api/versedotorg/presentation/has_description) | Interface that provides descriptive names or text. |

## Members

This class has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `MaxCount` | `int` |  |
| `Consumable` | `logic` |  |
| `PaidRandomItem` | `logic` |  |
| `PaidArea` | `logic` |  |
| `ConsequentialToGameplay` | `logic` |  |
