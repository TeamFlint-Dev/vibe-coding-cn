# add_item_query_event class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/add_item_query_event
> **爬取时间**: 2025-12-27T01:03:35.885153

---

When adding an item, 'find\_inventory\_event' is used as a first pass to find the best inventory for an item. It is sent downwards.
'add\_item\_query\_event' can be used to veto inventory choices. It is sent upwards.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Itemization }` |

## Exposed Interfaces

This class exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`scene_event`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/scene_event) | An event which can be sent through the scene graph. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Item` | `item_component` |  |
| `Inventory` | `inventory_component` |  |
| `Errors` | `?[]add_item_error` |  |

### Functions

| Function Name | Description |
| --- | --- |
| [`AddError`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/add_item_query_event/adderror) |  |
