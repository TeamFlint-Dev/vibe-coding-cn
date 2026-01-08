# Itemization module

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization>
> **爬取时间**: 2025-12-26T23:25:29.893042

---

Copyright Epic Games, Inc. All Rights Reserved.
###############################################
Generated Digest of Verse API
DO NOT modify this manually!
Generated from build: ++Fortnite+Release-39.20-CL-49392838
###############################################

- [`UnrealEngine.com`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom)
- **`Itemization`**

## Classes and Structs

| Name | Description |
| --- | --- |
| [`add_item_result`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/add_item_result) |  |
| [`remove_item_result`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/remove_item_result) |  |
| [`equip_item_result`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/equip_item_result) |  |
| [`unequip_item_result`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/unequip_item_result) |  |
| [`find_inventory_event`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/find_inventory_event) | When adding an item, 'find\_inventory\_event' is used as a first pass to find the best inventory for an item. It is sent downwards. 'add\_item\_query\_event' can be used to veto inventory choices. It is sent upwards. |
| [`add_item_error`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/add_item_error) |  |
| [`add_item_query_event`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/add_item_query_event) | When adding an item, 'find\_inventory\_event' is used as a first pass to find the best inventory for an item. It is sent downwards. 'add\_item\_query\_event' can be used to veto inventory choices. It is sent upwards. |
| [`remove_item_error`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/remove_item_error) |  |
| [`remove_item_query_event`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/remove_item_query_event) |  |
| [`inventory_component`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/inventory_component) | Inventory components hold items. An entity with an inventory component can be considered to have an inventory. The inventory component controls which items can enter or exit. They also determine whether an item can be equipped. |
| [`item_category`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/item_category) | item\_category is used to classify items. |
| [`change_equipped_result`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/change_equipped_result) |  |
| [`change_inventory_result`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/change_inventory_result) |  |
| [`change_stack_size_result`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/change_stack_size_result) |  |
| [`change_max_stack_size_result`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/change_max_stack_size_result) |  |
| [`equip_item_error`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/equip_item_error) |  |
| [`equip_item_query_event`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/equip_item_query_event) |  |
| [`unequip_item_error`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/unequip_item_error) |  |
| [`unequip_item_query_event`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/unequip_item_query_event) |  |
| [`item_component`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/item_component) | Anything using this component should be considered an item. Required to interact with inventories. |
| [`item_details_component`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/item_details_component) | Component that holds the details of an item. |
| [`item_icon_component`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/item_icon_component) | Component that holds the icon for an item. |

## Interfaces

| Name | Description |
| --- | --- |
| [`has_item_merge_rules`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/itemization/has_item_merge_rules) | Item Merge Rules Interface. Implemented by components that want to participate in item mergeability checks. |
