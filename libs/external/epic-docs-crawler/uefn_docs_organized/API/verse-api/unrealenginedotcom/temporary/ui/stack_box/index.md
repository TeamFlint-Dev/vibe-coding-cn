# stack_box class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/stack_box
> **爬取时间**: 2025-12-27T07:09:33.831218

---

Stack box is a container of a list of widgets stacked either vertically or horizontally.

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
| `Orientation` | `orientation` | The orientation of the stack box. Either stack widgets horizontal or vertical. |
| `Slots` | `[]stack_box_slot` | The child widgets of the stack box. Used only during initialization of the widget and not modified by Add/RemoveWidget. |

### Functions

| Function Name | Description |
| --- | --- |
| [`AddWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/stack_box/addwidget) | Add a new child slot to the stack box. Slots are added at the end. |
| [`GetParentWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getparentwidget) | Returns the `widget`'s parent `widget`. Fails if no parent exists, such as if this `widget` is not in the `player_ui` or is itself the root `widget`. |
| [`GetRootWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getrootwidget) | Returns the `widget` that added this `widget` to the `player_ui`. The root `widget` will return itself. Fails if this `widget` is not in the `player_ui`. |
| [`GetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getvisibility) | Returns the current `widget_visibility` state. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/isenabled) | `true` if this `widget` can be modified interactively by the player. |
| [`RemoveWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/stack_box/removewidget) | Removes a slot containing the given widget |
| [`SetEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setenabled) | Enables or disables whether the `player` can interact with this `widget`. |
| [`SetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setvisibility) | Shows or hides the `widget` without removing itself from the containing `player_ui`. See `widget_visibility` for details. |
