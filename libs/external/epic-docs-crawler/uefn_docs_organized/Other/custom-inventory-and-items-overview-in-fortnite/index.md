# Custom Inventory and Items Overview

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/custom-inventory-and-items-overview-in-fortnite
> **爬取时间**: 2025-12-27T00:35:48.668380

---

This feature is in an experimental state so you can try it out, provide feedback, and see what we are planning. You cannot publish a project that uses Custom Inventory and Items at this time.

Please keep in mind that we do not guarantee backward compatibility for assets created at the Experimental stage, the APIs for these features are subject to change, and we may remove entire experimental features or specific functionality at our discretion. Check out the list of known issues before you start working with the feature.

Items and inventory systems are a critical part of many kinds of games. Using Scene Graph's entities and components, you can customize Fortnite's player inventory, and create custom items unique to your island.

[Items](https://dev.epicgames.com/documentation/en-us/fortnite/custom-inventory-and-items-overview-in-fortnite#items) are objects in an island that players and [agents](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#agent) can use and own. [Inventories](https://dev.epicgames.com/documentation/en-us/fortnite/custom-inventory-and-items-overview-in-fortnite#inventories) include the existing Fortnite player inventory, as well as any custom inventories you create with the `inventory_component`. Custom Inventory and Items is a system for creating, controlling, and storing items. This system is an experimental feature that you need to enable in Project Settings, and you use it with Scene Graph in UEFN and Verse.

## Scene Graph Basics

Scene Graph is an entity and component system, built on top of Verse. Entities are containers for components, and components give an entity functionality. You can attach entities to each other in a parent-child relationship, which creates hierarchies. Reusable arrangements of entities and components are called prefabs. For more information on entities and components, see [Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite). For more information on prefabs in Scene Graph, see [Prefabs and Prefab Instances](https://dev.epicgames.com/documentation/en-us/fortnite/prefabs-and-prefab-instances-in-unreal-editor-for-fortnite).

### Known Issues

Custom Inventory and Items is the first system to leverage Scene Graph in UEFN. Because of that, there are a number of bugs in the Experimental release that you might encounter when using this system. You can find the [list of known issues here](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-known-issues-in-fortnite). We are working on many fixes and improvements which will be included in a future release.

## Items

An item is an [entity](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#entity) in Scene Graph that has an `item_component`. By default, items can be merged and stacked, can have categories for comparison and sorting, and can be equipped and unequipped.

Since the Custom Inventory and Items system uses Scene Graph, you can add components to items to increase their functionality. The system comes with several basic components to start with, which are listed in the table below.

| Component | Description |
| --- | --- |
| `item_component` | This component makes an entity an item. It also gives the entity the ability to be stacked, and to be owned and controlled by an inventory. |
| `item_icon_component` | This stores an icon for the item that is displayed in the Fortnite UI. |
| `item_details_component` | This contains text data such as the item's name and description. |
| `mesh_component` | This stores a mesh asset that represents the item in the game. |
| `fort_item_pickup_component` | This component allows the item to be treated the same as a Fortnite item pickup. This includes an interaction prompt to pick it up, UI, and pickup/drop animations. |

[![Image shows an item entity with multiple components added](https://dev.epicgames.com/community/api/documentation/image/e621f3e1-7785-4c1e-b99d-c0c02a123b03?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e621f3e1-7785-4c1e-b99d-c0c02a123b03?resizing_type=fit)

An item can only have one component of each type. This includes components that inherit from other components that are already attached to the item.

So for example, if you create a custom component for a specific item that is a child of the `item_component`, your custom item component would display instead of the generic item component.

## Item Modularity

With Custom Inventory and Items, we can introduce proper modularity. This means you can use components to build item functionality additively. Below are examples of components attached to an item entity that grant functionality.

[![Items and inventories are modular, allowing you to add components to detail the functionality of an item or inventory.](https://dev.epicgames.com/community/api/documentation/image/13995964-12ea-443d-be91-4852f4d44deb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/13995964-12ea-443d-be91-4852f4d44deb?resizing_type=fit)

1. Entity
2. `item_component`: makes an entity an item.
3. `item_details_component`: stores text data such as the item's name and description.
4. `item_icon_component`: stores an icon for the item that displays in the Fortnite UI.
5. `mesh_component`: stores a mesh asset that represents the item in the game.

## Inventories

An inventory is an entity that has an `inventory_component`. 
 Inventories are containers for item entities and the inventory controls what happens to those items.

The Custom Inventory and Items system uses inventories and sub-inventories to compartmentalize items. This makes it easier to sort, add and retrieve items within an inventory. Since an item may only exist inside one inventory at a time, inventories also determine the ownership of item entities.

By default, inventories can hold an infinite number of any kind of item. However, you can create restrictions and rules that determine which items can be added. Some examples of these restrictions and rules:

- Add items to an inventory only if they meet the required type query.
- Limit the number of items in an inventory.
- Allow items of higher priority to eject items of lower priority when the inventory is full.
- Restrict an inventory to a single item.

When an `AddItem()` function can't resolve on the target inventory, it looks for other inventories that could potentially hold the item. The function uses Scene Graph hierarchies
— it will first attempt to add the item to sibling inventories (inventories that share a parent with the initial target inventory), then it will look at child inventories (inventories that are parented by the initial target inventory). The function will check all inventories in the hierarchy before returning a fail.

[![Diagram shows the target inventory, along with its sibling and child inventories.](https://dev.epicgames.com/community/api/documentation/image/84d82c95-62cf-466e-961a-e9b7778fe8bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/84d82c95-62cf-466e-961a-e9b7778fe8bb?resizing_type=fit)

## Inventory Filtering with Scene Events

When an inventory is targeted with an `AddItem()` function call, it will receive a scene event (`add_item_event`) . By overriding a component's `OnReceive()` function, custom logic can be triggered to affect the entry of the item. This allows for inventory rules, such as checking the item type before allowing, only allowing a certain number of items in the inventory, and so on. The `OnReceive()` event is implemented in the base component class and is available to all Scene Graph components.

The `add_item_event` collects responses from all inventories it reaches. You can have inventory components modify the event, and have those inventory components offer themselves to receive the item being added. The event contains an array called `inventory_with_priority`, which you can set and update with your target inventory. This allows you to nominate the target inventory with a priority to receive the item. When the scene event has been broadcast, all inventories with a set priority are considered to receive the item, and the inventory with the highest priority receives the item.

In the Experimental release of Custom Inventory and Items, only the `add_item_event` is available. However, other events will be added in future updates.

## Fortnite Inventories

Custom Inventory and Items comes with a number of `inventory_component` subclasses, called `fort_inventory_components`. These have item filtering and UI elements that mimic the Fortnite Battle Royale player inventory.

[![Shows the various fort_inventory components that represent the sections of the default Fortnite player inventory.](https://dev.epicgames.com/community/api/documentation/image/282302b4-b07a-4388-8e81-048371c63397?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/282302b4-b07a-4388-8e81-048371c63397?resizing_type=fit)

| Component | Description |
| --- | --- |
| `fort_inventory_harvest_tool_component` | Corresponds to the Harvest Tool slot of the default Fortnite player inventory. |
| `fort_inventory_weapon_hotbar_component` | Corresponds to the hotbar of the default Fortnite player inventory. |
| `fort_inventory_build_hotbar_component` | Corresponds to the building tools hotbar of the default Fortnite player inventory. |
| `fort_inventory_trap_component` | Corresponds to the trap slot of the default Fortnite player inventory. |
| `fort_inventory_currencies_component` | Corresponds to the currencies section of the default Fortnite player inventory. |
| `fort_inventory_collectibles_component` | Corresponds to the collectibles section of the default Fortnite player inventory. |
| `fort_inventory_ammo_component` | Corresponds to the ammo section of the default Fortnite player inventory. |

You can also create your own configuration of sub-inventories to add to, remove from, or replace the default player inventory.

Items and inventories are as simple or complex as the number of components that are added to the item or inventory entity. As the Custom Inventory and Items system continues to be developed, more components will be added that provide even more functionality.
