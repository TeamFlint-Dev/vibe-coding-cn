# stack_box_slot struct

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/stack_box_slot>
> **爬取时间**: 2025-12-27T07:09:22.716894

---

Slot for a stack\_box widget

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/UI }` |

## Members

This struct has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Widget` | `widget` | The widget assigned to this slot. |
| `HorizontalAlignment` | `horizontal_alignment` | Horizontal alignment of the widget inside the slot. This alignment is only applied after the layout space for the widget slot is created and determines the widget alignment within that space. |
| `VerticalAlignment` | `vertical_alignment` | Vertical alignment of the widget inside the slot. This alignment is only applied after the layout space for the widget slot is created and determines the widget alignment within that space. |
| `Padding` | `margin` | Empty distance in pixels that surrounds the widget inside the slot. Assumes 1080p resolution. |
| `Distribution` | `?float` | The available space will be distributed proportionally. If not set, the slot will use the desired size of the widget. |
