# healable interface

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healable>
> **爬取时间**: 2025-12-27T01:01:05.827810

---

Implemented by Fortnite objects that can be healed.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Game }` |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`Heal`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healable/heal) | Heal the `healable` object anonymously by `Amount`. Setting `Amount` to less than 0 will cause no healing. Use `Heal(:healing_args):void` when healing is being applied from a known instigator and source. |
| [`Heal`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healable/heal-1) | Cause `Args.Amount` damage to the `damageable` object. Setting `Amount` to less than 0 will cause no damage. |
| [`HealedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healable/healedevent) | Signaled when healing is applied to the `healable` object. |
