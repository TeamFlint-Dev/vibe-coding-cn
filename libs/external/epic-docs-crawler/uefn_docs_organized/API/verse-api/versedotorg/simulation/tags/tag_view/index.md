# tag_view interface

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/simulation/tags/tag_view
> **爬取时间**: 2025-12-27T02:43:01.708782

---

A queryable collection of gameplay tags.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Simulation/Tags }` |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`Has`](/documentation/en-us/fortnite/verse-api/versedotorg/simulation/tags/tag_view/has) | Determine if TagToCheck is present in this container, also checking against parent tags {"A.1"}.Has("A") will return True, {"A"}.Has("A.1") will return False If TagToCheck is not Valid it will always return False. |
| [`HasAny`](/documentation/en-us/fortnite/verse-api/versedotorg/simulation/tags/tag_view/hasany) | Checks if this container contains ANY of the tags in the specified container, also checks against parent tags {"A.1"}.HasAny({"A","B"}) will return True, {"A"}.HasAny({"A.1","B"}) will return False If InTags is empty/invalid it will always return False. |
| [`HasAll`](/documentation/en-us/fortnite/verse-api/versedotorg/simulation/tags/tag_view/hasall) | Checks if this container contains ALL of the tags in the specified container, also checks against parent tags {"A.1","B.1"}.HasAll({"A","B"}) will return True, {"A","B"}.HasAll({"A.1","B.1"}) will return False If InTags is empty/invalid it will always return True, because there were no failed checks. |
