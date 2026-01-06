# damageable interface

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/damageable
> **爬取时间**: 2025-12-27T01:01:33.431621

---

Implemented by Fortnite objects that can be damaged.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Game }` |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`Damage`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/damageable/damage) | Damage the `damageable` object anonymously by `Amount`. Setting `Amount` to less than 0 will cause no damage. Use `Damage(:damage_args):void` when damage is being applied from a known instigator and source. |
| [`Damage`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/damageable/damage-1) | Damage the `damageable` object by `Args.Amount`. Setting `Amount` to less than 0 will cause no damage. |
| [`DamagedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/damageable/damagedevent) | Signaled when damage is applied to the `damageable` object. |
