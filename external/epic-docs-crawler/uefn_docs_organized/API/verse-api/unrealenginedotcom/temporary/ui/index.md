# UI module

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui>
> **爬取时间**: 2025-12-27T02:02:15.781722

---

Module import path: /UnrealEngine.com/Temporary/UI

- [`UnrealEngine.com`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom)
- [`Temporary`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary)
- **`UI`**

## Classes and Structs

| Name | Description |
| --- | --- |
| [`player_ui`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/player_ui) | The main interface for adding and removing `widget`s to a player's UI. |
| [`widget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget) | Base class for all UI elements drawn on the `player`'s screen. |
| [`player_ui_slot`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/player_ui_slot) | `widget` creation configuration options. |
| [`widget_message`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget_message) | Parameters for `event`s signalled by a `widget`. |
| [`anchors`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/anchors) | The anchors of a `widget` determine its the position and sizing relative to its parent. `anchor`s range from `(0.0, 0.0)` (left, top) to `(1.0, 1.0)` (right, bottom). |
| [`margin`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/margin) | Specifies the gap outside each edge separating a `widget` from its neighbors. Distance is measured in units where `1.0` unit is the width of a pixel at 1080p resolution. |
| [`button`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/button) | Button is a container of a single child widget slot and fires the OnClick event when the button is clicked. |
| [`button_slot`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/button_slot) | Slot for button widget. |
| [`canvas`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/canvas) | Canvas is a container widget that allows for arbitrary positioning of widgets in the canvas' slots. |
| [`canvas_slot`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/canvas_slot) | Slot for a canvas widget. |
| [`color_block`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/color_block) | A solid color widget. |
| [`texture_block`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/texture_block) | A widget to display a texture. |
| [`material_block`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/material_block) | A widget to display a material. |
| [`overlay`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/overlay) | Overlay is a container consisting of widgets stacked on top of each other. |
| [`overlay_slot`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/overlay_slot) | Slot for an overlay widget |
| [`stack_box`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/stack_box) | Stack box is a container of a list of widgets stacked either vertically or horizontally. |
| [`stack_box_slot`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/stack_box_slot) | Slot for a stack\_box widget |
| [`text_base`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base) | Base widget for text widget. |

## Functions

| Name | Description |
| --- | --- |
| [`GetPlayerUI`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/getplayerui) | Returns the `player_ui` associated with `Player`. Fails if there is no `player_ui` associated with `Player`. |
| [`MakeCanvasSlot`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/makecanvasslot) | Make a canvas slot for fixed position widget. If Size is set, then the Offsets is calculated and the SizeToContent is set to false. If Size is not set, then Right and Bottom are set to zero and are not used. The widget size will be automatically calculated. The SizeToContent is set to true. The widget is not anchored and will not move if the parent is resized. The Anchors is set to zero. |

## Enumerations

| Name | Description |
| --- | --- |
| [`ui_input_mode`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/ui_input_mode) | `widget` input consumption mode. |

|  |  |
| --- | --- |
| [`widget_visibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget_visibility) | Used by `widget.SetVisibility` determine how a `widget` is shown in the user interface. |

|  |  |
| --- | --- |
| [`orientation`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/orientation) | Used by`widget` orientation modes. |

|  |  |
| --- | --- |
| [`horizontal_alignment`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/horizontal_alignment) | `widget` horizontal alignment mode. |

|  |  |
| --- | --- |
| [`vertical_alignment`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/vertical_alignment) | `widget` vertical alignment mode. |

|  |  |
| --- | --- |
| [`image_tiling`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/image_tiling) | Tiling options values |

|  |  |
| --- | --- |
| [`text_justification`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_justification) | Text justification values: Left: Justify the text logically to the left based on current culture. Center: Justify the text in the center. Right: Justify the text logically to the right based on current culture. The Left and Right value will flip when the local culture is right-to-left. |

|  |  |
| --- | --- |
| [`text_overflow_policy`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_overflow_policy) | Text overflow policy values: Clip: Overflowing text will be clipped. Ellipsis: Overflowing text will be replaced with an ellipsis. |
