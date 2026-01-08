# fort_hud_controller interface

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/fort_hud_controller>
> **爬取时间**: 2025-12-27T01:08:03.211616

---

A HUD controller that allows for showing and hiding of HUD elements.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/UI }` |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`ShowElements`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/fort_hud_controller/showelements) | Shows a set of HUD elements for every player. Note: This can be overridden by rules set by 'ForPlayer' functions since player specific rules are prioritized over general rules. |
| [`HideElements`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/fort_hud_controller/hideelements) | Hides a set of HUD elements for every player. Note: This can be overridden by rules set by 'ForPlayer' functions since player specific rules are prioritized over general rules. |
| [`ResetElementVisibility`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/fort_hud_controller/resetelementvisibility) | Resets the visibility for a set of HUD elements for every player. Note: This will not clear player specific rules set by the 'ForPlayer' functions which can only be reset by calling 'ResetElementsForPlayer'. |
| [`ShowElementsForPlayer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/fort_hud_controller/showelementsforplayer) | Shows a set of HUD elements for a single player. Note: This overrides general rules set by non-player functions for the given elements. Call 'ResetElementsForPlayer' in order to return the player to general behavior |
| [`HideElementsForPlayer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/fort_hud_controller/hideelementsforplayer) | Hides a set of HUD elements for a single player. Note: This overrides general rules set by non-player functions for the given elements. Call 'ResetElementsForPlayer' in order to return the player to general behavior |
| [`ResetElementsForPlayer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/fort_hud_controller/resetelementsforplayer) | Resets the player-specific visibility rules of a set of HUD elements for a single player. Note: This will not reset rules that have been set by means other than the 'PerPlayer' functions. |
