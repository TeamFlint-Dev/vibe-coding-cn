# button class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/button
> **爬取时间**: 2025-12-27T07:08:15.069642

---

Button is a container of a single child widget slot and fires the OnClick event when the button is clicked.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/UI }` |

## Inheritance Hierarchy

This class is derived from `widget`.

| Name | Description |
| --- | --- |
| [`widget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget) | Base class for all UI elements drawn on the `player`'s screen. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Slot` | `button_slot` | The child widget of the button. Used only during initialization of the widget and not modified by SetSlot. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetParentWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getparentwidget) | Returns the `widget`'s parent `widget`. Fails if no parent exists, such as if this `widget` is not in the `player_ui` or is itself the root `widget`. |
| [`GetRootWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getrootwidget) | Returns the `widget` that added this `widget` to the `player_ui`. The root `widget` will return itself. Fails if this `widget` is not in the `player_ui`. |
| [`GetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getvisibility) | Returns the current `widget_visibility` state. |
| [`HighlightEvent`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/button/highlightevent) |  |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/isenabled) | `true` if this `widget` can be modified interactively by the player. |
| [`OnClick`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/button/onclick) | Subscribable event that fires when the button is clicked. |
| [`SetEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setenabled) | Enables or disables whether the `player` can interact with this `widget`. |
| [`SetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setvisibility) | Shows or hides the `widget` without removing itself from the containing `player_ui`. See `widget_visibility` for details. |
| [`SetWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/button/setwidget) | Sets the child widget slot. |
| [`UnhighlightEvent`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/button/unhighlightevent) |  |
