# canvas_slot struct

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/canvas_slot
> **爬取时间**: 2025-12-27T07:07:47.134385

---

Slot for a canvas widget.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/UI }` |

## Members

This struct has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Anchors` | `anchors` | The border for the margin and how the widget is resized with its parent. Values are defined between 0.0 and 1.0. |
| `Offsets` | `margin` | The offset that defined the size and position of the widget. When the anchors are well defined, the Offsets.Left represent the distance in pixels from the Anchors Minimum.X, the Offsets.Bottom represent the distance in pixel from the Anchors Maximum.Y, effectively controlling the desired widget size. When the anchors are not well defined, the Offsets.Left and Offsets.Top represent the widget position and Offsets.Right and Offset.Bottom represent the widget size. |
| `SizeToContent` | `logic` | When true we use the widget's desired size. The size calculated by the Offsets is ignored. |
| `Alignment` | `vector2` | Alignment is the pivot/origin point of the widget. Starting in the upper left at (0.0,0.0), ending in the lower right at (1.0,1.0). |
| `ZOrder` | `int` | Z Order of this slot relative to other slots in this canvas panel. Higher values are rendered last (and so they will appear to be on top) |
| `Widget` | `widget` | The widget assigned to this slot. |
