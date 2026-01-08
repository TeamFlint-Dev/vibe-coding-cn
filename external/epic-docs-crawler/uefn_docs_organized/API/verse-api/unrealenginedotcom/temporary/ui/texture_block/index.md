# texture_block class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/texture_block>
> **爬取时间**: 2025-12-27T07:09:39.281665

---

A widget to display a texture.

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
| `DefaultHorizontalTiling` | `image_tiling` | The horizontal tiling option. Used only during initialization of the widget and not modified by SetTiling. |
| `DefaultImage` | `texture` | The image to render. Used only during initialization of the widget and not modified by SetImage. |
| `DefaultTint` | `color` | Tinting applied to the image. Used only during initialization of the widget and not modified by SetTint. |
| `DefaultVerticalTiling` | `image_tiling` | The vertical tiling option. Used only during initialization of the widget and not modified by SetTiling. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetDesiredSize`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/texture_block/getdesiredsize) | Gets the size this widget desired to be displayed in. |
| [`GetImage`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/texture_block/getimage) | Gets the image to render. |
| [`GetParentWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getparentwidget) | Returns the `widget`'s parent `widget`. Fails if no parent exists, such as if this `widget` is not in the `player_ui` or is itself the root `widget`. |
| [`GetRootWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getrootwidget) | Returns the `widget` that added this `widget` to the `player_ui`. The root `widget` will return itself. Fails if this `widget` is not in the `player_ui`. |
| [`GetTiling`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/texture_block/gettiling) | Gets the tiling option. |
| [`GetTint`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/texture_block/gettint) | Gets the tint applied to the image. |
| [`GetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getvisibility) | Returns the current `widget_visibility` state. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/isenabled) | `true` if this `widget` can be modified interactively by the player. |
| [`SetDesiredSize`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/texture_block/setdesiredsize) | Sets the size this widget desired to be displayed in. |
| [`SetEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setenabled) | Enables or disables whether the `player` can interact with this `widget`. |
| [`SetImage`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/texture_block/setimage) | Sets the image to render. |
| [`SetTiling`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/texture_block/settiling) | Sets the tiling option when the image is smaller than the allocated size. |
| [`SetTint`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/texture_block/settint) | Sets the tint applied to the image. |
| [`SetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setvisibility) | Shows or hides the `widget` without removing itself from the containing `player_ui`. See `widget_visibility` for details. |
