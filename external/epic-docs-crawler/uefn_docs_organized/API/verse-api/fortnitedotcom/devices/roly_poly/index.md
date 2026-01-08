# roly_poly class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly>
> **爬取时间**: 2025-12-27T01:57:23.952148

---

Roly Poly spawned from the 'roly\_poly\_spawner\_device'

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Exposed Interfaces

This class exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`positional`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/positional) | Implemented by objects to allow reading position information. |
| [`healthful`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healthful) | Implemented by Fortnite objects that have health state and can be eliminated. |
| [`healable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healable) | Implemented by Fortnite objects that can be healed. |
| [`damageable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/damageable) | Implemented by Fortnite objects that can be damaged. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Energy` | `?float` | Set/Get the Energy level of the spawned Roly Poly. Energy will be clamped to 0 - 100. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/gettransform) | Returns the transform of the Roly Poly |
| [`GetHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/gethealth) | Returns the health state of the Roly Poly. This value will be between 0.0 and 'GetMaxHealth' |
| [`SetHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/sethealth) | Sets the health state of the Roly Poly to 'Health'.   - Health state will be clamped between 1.0 and 'GetMaxHealth'. - Health state cannot be directly set to 0.0. To eliminate the Roly Poly, use the 'Dismiss' function on the spawner instead. |
| [`GetMaxHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/getmaxhealth) | Returns the maximum health of the Roly Poly. This value will be between 1.0 and 9999.0. |
| [`SetMaxHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/setmaxhealth) | Sets the maximum health state of the Roly Poly.   - MaxHealth will be clamped between 1.0 and 9999.0. - Current health state will be scaled up or down based on the scale difference between the old and new MaxHealth state. |
| [`Heal`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/heal) | Heal the Roly Poly anonymously by 'Amount'. Setting 'Amount' to less than 0 will cause no healing. Use 'Heal(:healing\_args):void' when healing is being applied from a known instigator and source. |
| [`Heal`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/heal-1) | Heal the Roly Poly by 'Args.Amount'. Setting 'Amount' to less than 0 will cause no healing. |
| [`HealedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/healedevent) | Signaled when healing is applied to the Roly Poly. |
| [`Damage`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/damage) | Damage the Roly Poly anonymously by 'Amount'. Setting 'Amount' to less than 0 will cause no damage. Use 'Damage(:damage\_args):void' when damage is being applied from a known instigator and source. Damage caused by events will not cause players to be bucked from the Roly Poly. |
| [`Damage`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/damage-1) | Damage the Roly Poly by 'Args.Amount'. Setting 'Amount' to less than 0 will cause no damage. Damage caused by events will not cause players to be bucked from the Roly Poly. |
| [`DamagedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/damagedevent) | Signaled when damage is applied to the Roly Poly. |
| [`SetFrightened`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/roly_poly/setfrightened) | Set the Frightened status of the Roly Poly.   - Setting to true will frighten the Roly Poly. - Setting to false will soothe the Roly Poly. - An 'agent' can be provided and will be passed back as the signaled events 'agent'. - Depending on the state the Roly Poly is in, it may take a few seconds for the FrightenedEvent to be signaled. Ex. When a player is in the Roly Poly, it will buck the player and enter the frightened state when it lands on solid ground. |
