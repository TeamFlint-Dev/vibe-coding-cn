# find_inventory_event class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/find_inventory_event
> **爬取时间**: 2025-12-27T01:03:41.314672

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

This class has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `ItemComponent` | `item_component` |  |
| `ChosenInventory` | `??inventory_component` |  |
| `ChosenInventoryPriority` | `?float` |  |
