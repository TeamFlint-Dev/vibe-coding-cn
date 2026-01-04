# player_ui class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/player_ui
> **爬取时间**: 2025-12-27T07:09:02.803313

---

The main interface for adding and removing `widget`s to a player's UI.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/UI }` |

## Members

This class has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`AddWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/player_ui/addwidget) | Adds `Widget` to this `player_ui` using default `player_ui_slot` configuration options. |
| [`AddWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/player_ui/addwidget-1) | Adds `Widget` to this `player_ui` using `Slot` for configuration options. |
| [`RemoveWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/player_ui/removewidget) | Removes `Widget` from this `player_ui`. |
| [`SetFocus`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/player_ui/setfocus) | Sets the user's focus on this `Widget`. The target `Widget`must be focusable, otherwise this has no effect. If `SetFocus` is called before `AddWidget`, the `widget` will be focused after `AddWidget` is called, unless a SetFocus is called on a different `widget` by the time `AddWidget` is called. |
