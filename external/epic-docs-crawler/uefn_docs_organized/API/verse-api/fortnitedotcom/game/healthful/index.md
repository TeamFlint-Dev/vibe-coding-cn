# healthful interface

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healthful
> **爬取时间**: 2025-12-27T01:00:22.909808

---

Implemented by Fortnite objects that have health state and can be eliminated.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Game }` |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`GetHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healthful/gethealth) | Returns the health state of the object. This value will be between 0.0 and `GetMaxHealth` |
| [`SetHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healthful/sethealth) | Sets the health state of the object to `Health`.   - Health state will be clamped between 1.0 and `GetMaxHealth`. - Health state cannot be directly set to 0.0. To eliminate `healthful` objects use the `damageable.Damage` functions instead. |
| [`GetMaxHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healthful/getmaxhealth) | Returns the maximum health of the object. This value will be between 1.0 and Inf. |
| [`SetMaxHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healthful/setmaxhealth) | Sets the maximum health state of the object.   - MaxHealth will be clamped between 1.0 and Inf. - Current health state will be scaled up or down based on the scale difference between the old and new MaxHealth state. |
