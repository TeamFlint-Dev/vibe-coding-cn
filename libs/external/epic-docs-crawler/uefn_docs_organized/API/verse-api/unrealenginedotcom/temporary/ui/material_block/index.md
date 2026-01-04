# material_block class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/material_block
> **爬取时间**: 2025-12-27T07:08:09.478037

---

A widget to display a material.

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
| `DefaultDesiredSize` | `vector2` | The size this widget desired to be displayed in. Used only during initialization of the widget and not modified by SetDesiredSize. |
| `DefaultImage` | `material` | The image to render. Used only during initialization of the widget and not modified by SetImage. |
| `DefaultTint` | `color` | Tinting applied to the image. Used only during initialization of the widget and not modified by SetTint. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetDesiredSize`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/material_block/getdesiredsize) | Gets the size this widget desired to be displayed in. |
| [`GetImage`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/material_block/getimage) | Gets the image to render. |
| [`GetParentWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getparentwidget) | Returns the `widget`'s parent `widget`. Fails if no parent exists, such as if this `widget` is not in the `player_ui` or is itself the root `widget`. |
| [`GetRootWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getrootwidget) | Returns the `widget` that added this `widget` to the `player_ui`. The root `widget` will return itself. Fails if this `widget` is not in the `player_ui`. |
| [`GetTint`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/material_block/gettint) | Gets the tint applied to the image. |
| [`GetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getvisibility) | Returns the current `widget_visibility` state. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/isenabled) | `true` if this `widget` can be modified interactively by the player. |
| [`SetDesiredSize`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/material_block/setdesiredsize) | Sets the size this widget desired to be displayed in. |
| [`SetEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setenabled) | Enables or disables whether the `player` can interact with this `widget`. |
| [`SetImage`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/material_block/setimage) | Sets the image to render. |
| [`SetTint`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/material_block/settint) | Sets the tint applied to the image. |
| [`SetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setvisibility) | Shows or hides the `widget` without removing itself from the containing `player_ui`. See `widget_visibility` for details. |
