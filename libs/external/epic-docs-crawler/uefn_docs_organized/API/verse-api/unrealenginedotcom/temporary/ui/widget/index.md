# widget class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget
> **爬取时间**: 2025-12-27T02:56:24.852161

---

Base class for all UI elements drawn on the `player`'s screen.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/UI }` |

## Members

This class has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`SetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setvisibility) | Shows or hides the `widget` without removing itself from the containing `player_ui`. See `widget_visibility` for details. |
| [`GetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getvisibility) | Returns the current `widget_visibility` state. |
| [`SetEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setenabled) | Enables or disables whether the `player` can interact with this `widget`. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/isenabled) | `true` if this `widget` can be modified interactively by the player. |
| [`GetParentWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getparentwidget) | Returns the `widget`'s parent `widget`. Fails if no parent exists, such as if this `widget` is not in the `player_ui` or is itself the root `widget`. |
| [`GetRootWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getrootwidget) | Returns the `widget` that added this `widget` to the `player_ui`. The root `widget` will return itself. Fails if this `widget` is not in the `player_ui`. |
