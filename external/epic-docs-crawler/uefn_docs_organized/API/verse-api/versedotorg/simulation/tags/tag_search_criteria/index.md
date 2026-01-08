# tag_search_criteria class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/simulation/tags/tag_search_criteria>
> **爬取时间**: 2025-12-27T02:47:33.303728

---

Advanced tag search criteria

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Simulation/Tags }` |

## Members

This class has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `RequiredTags` | `[]tag` | Tags required to be on the object. |
| `PreferredTags` | `[]tag` | Tags that are used if no required tags are specified. These are treated as if any of them will do. |
| `ExclusionTags` | `[]tag` | Tags that may NOT be on the object. All items with these tags are excluded from the search. |
| `SortType` | `tag_search_sort_type` | Flag to request sorting the results by tag. |
