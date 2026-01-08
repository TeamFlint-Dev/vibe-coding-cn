# color_block class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/color_block>
> **爬取时间**: 2025-12-27T07:08:51.664925

---

A solid color widget.

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
| `DefaultColor` | `color` | The color of the widget. Used only during initialization of the widget and not modified by SetColor. |
| `DefaultDesiredSize` | `vector2` | The size this widget desired to be displayed in. Used only during initialization of the widget and not modified by SetDesiredSize. |
| `DefaultOpacity` | `float` | The opacity of the widget. Used only during initialization of the widget and not modified by SetOpacity. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetColor`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/color_block/getcolor) | Gets the widget's color. |
| [`GetDesiredSize`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/color_block/getdesiredsize) | Gets the size this widget desired to be displayed in. |
| [`GetOpacity`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/color_block/getopacity) | Gets the widget's opacity. |
| [`GetParentWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getparentwidget) | Returns the `widget`'s parent `widget`. Fails if no parent exists, such as if this `widget` is not in the `player_ui` or is itself the root `widget`. |
| [`GetRootWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getrootwidget) | Returns the `widget` that added this `widget` to the `player_ui`. The root `widget` will return itself. Fails if this `widget` is not in the `player_ui`. |
| [`GetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getvisibility) | Returns the current `widget_visibility` state. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/isenabled) | `true` if this `widget` can be modified interactively by the player. |
| [`SetColor`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/color_block/setcolor) | Sets the widget's color. |
| [`SetDesiredSize`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/color_block/setdesiredsize) | Sets the size this widget desired to be displayed in. |
| [`SetEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setenabled) | Enables or disables whether the `player` can interact with this `widget`. |
| [`SetOpacity`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/color_block/setopacity) | Sets the widgets's opacity. |
| [`SetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setvisibility) | Shows or hides the `widget` without removing itself from the containing `player_ui`. See `widget_visibility` for details. |
