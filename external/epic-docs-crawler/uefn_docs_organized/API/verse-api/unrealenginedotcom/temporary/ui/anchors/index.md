# anchors struct

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/anchors>
> **爬取时间**: 2025-12-27T07:08:41.098340

---

The anchors of a `widget` determine its the position and sizing relative to its parent.
`anchor`s range from `(0.0, 0.0)` (left, top) to `(1.0, 1.0)` (right, bottom).

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/UI }` |

## Members

This struct has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Minimum` | `vector2` | Holds the minimum anchors, (left, top). The valid range is between `0.0` and `1.0`. |
| `Maximum` | `vector2` | Holds the maximum anchors, (right, bottom). The valid range is between `0.0` and `1.0`. |
