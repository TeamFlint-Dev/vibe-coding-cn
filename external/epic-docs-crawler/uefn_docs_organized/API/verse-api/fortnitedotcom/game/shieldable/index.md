# shieldable interface

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/shieldable
> **爬取时间**: 2025-12-27T01:01:28.170677

---

Implemented by Fortnite objects that have shields. A shield is a method of protection that can take incoming damage while leaving the health state unchanged.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Game }` |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`GetShield`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/shieldable/getshield) | Returns the shield state of the object. This value will be between 0.0 and `MaxShield` |
| [`SetShield`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/shieldable/setshield) | Sets the shield state of the object.   - Shield state will be clamped between 0.0 and `MaxShield`. |
| [`GetMaxShield`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/shieldable/getmaxshield) | Returns the maximum shield state of the object. This value will be between 0.0 and Inf. |
| [`SetMaxShield`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/shieldable/setmaxshield) | Sets the maximum shield state of the object.   - MaxShield will be clamped between 0.0 and Inf. - Current shield state will be scaled up or down based on the scale difference between the old and new MaxShield state. |
| [`DamagedShieldEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/shieldable/damagedshieldevent) | Signaled when the shield is damaged. |
| [`HealedShieldEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/shieldable/healedshieldevent) | Signaled when the shield is healed. |
