# Fort Inventory Component

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/fort-inventory-component-in-fortnite
> **爬取时间**: 2025-12-27T00:34:51.720564

---

This feature is in an Experimental state, so you can try it out, provide feedback, and see what we are planning. You cannot publish a project that uses the Custom Game Items and Inventories system at this time.

Please keep in mind that we do not guarantee backward compatibility for assets created at the experimental stage, the APIs for these features are subject to change, and we may remove entire Experimental features or specific functionality at our discretion. Check out the list of known issues before you start working with the feature.

The Custom Items and Inventories system uses inventories and sub-inventories to compartmentalize items by sorting, adding, and retrieving items. To add a component to your entity, refer to **[Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite)**.

Entities are only considered items if they have an `item_component`. Without one, entities will not be added to inventories properly as well as Custom Item and Inventories functionality may be broken.

- References to an “item” are referring to an entity with an `item_component`.
- References to “inventories” are referring to an entity with an `inventory_component`.

## Class Description

The `fort_inventory_component` is a subclass of the `inventory_component`. Its purpose is to provide compatibility between Fortnite gameplay and the new Custom Items and Inventories system. By default players are given a Root Inventory, and then a number of specialized subclasses are added to the Root as sub-inventories:

|  |  |
| --- | --- |
| `fort_inventory_component` | Base subclass for all the other Fort Inventories. Also used to hold the Edit Mode tool. Required for Edit Mode. |
| `fort_inventory_build_hotbar_component` | Holds the build recipe items. Required for Edit Mode. |
| `fort_inventory_weapon_hotbar_component` | Holds equippable Fortnite items like weapons and consumables. Filters items by WorldItem item\_category. |
| `fort_inventory_collectibles_component` | Filters items by the Collectible item\_category. |
| `fort_inventory_resources_component` | Stores the default Fortnite resources, wood, brick and metal. Filters items by the Resource item\_category. |
| `fort_inventory_ammo_component` | Stores Fortnite ammo types. Filters items by the Ammo item\_category. |
| `fort_inventory_trap_component` | Holds a single item instance. Only allows items with the Trap item\_category. |
| `fort_inventory_currencies_component` | Stores any item with the Currency item\_category. |
| `fort_inventory_harvest_tool_component` | Holds the Player Harvest Tool. Required for Edit Mode. |

[![](https://dev.epicgames.com/community/api/documentation/image/2af9f21f-c917-4913-87a5-4f6bb54383f1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2af9f21f-c917-4913-87a5-4f6bb54383f1?resizing_type=fit)

Above you can see the default setup for the Root Inventory and the standard Fortnite inventories.

These components provide an approximation of the Fortnite: Battle Royale inventory behaviour. When Items added to the Root Inventory they are sorted and placed in specific SubInventories, and can be retrieved by searching for a specific subclass.

Additionally the Custom Items and Inventories system delivers a UI similar to Fortnite. Each UI element represents a counterpart `fort_inventory_component`.

[![](https://dev.epicgames.com/community/api/documentation/image/b0641569-99b0-4718-8b0b-3cfad0b05af7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b0641569-99b0-4718-8b0b-3cfad0b05af7?resizing_type=fit)

The image above shows how the Fortnite Inventory has been mapped to unique fort\_inventory\_component subclasses.

The Itemization UI looks different to this but has the same sections.

See **[Components](https://dev.epicgames.com/documentation/en-us/fortnite/components-in-unreal-editor-for-fortnite)** for a complete list of itemization components.

You can access the `fort_inventory_component` from the component dropdown list. For more information, check out the `fort_inventory_component` API reference from the Verse API.

## Example

Once Custom Items and Inventories has been enabled, a new property is exposed in the Island Settings device Custom Inventory Configuration. The default configuration provides all the `fort_inventory_components` that make up the Fortnite Inventory.

[![](https://dev.epicgames.com/community/api/documentation/image/b28231e4-b7d3-43f4-ab05-6c1d0182cd80?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b28231e4-b7d3-43f4-ab05-6c1d0182cd80?resizing_type=fit)

Like other Scene Graph components, the `fort_inventory_component` can also be added and removed through Verse.

Below is a script for getting specific `fort_inventory_components` and reading the items inside them. Since they inherit all the functionality of the 
base `inventory_component`, you can write your own systems to leverage Custom Items and Inventories alongside Fortnite Items.

```verse
# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Fortnite.com/Itemization }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Itemization }

# This device will look for fort_inventory_components on an agent and then repeatedly print out the total number of item stacks.
fort_inventory_item_counter_device := class(creative_device) :

    # You can set the subtype of fort_inventory_component you want to count.
    # InventoryToCount is any subtype of the fort_inventory_component.
    @editable
    InventoryToCount:subtype(fort_inventory_component) = false

    OnBegin<override>()<suspends>:void=

        loop:
            AllPlayers := GetPlayspace().GetPlayers()

            for(Player:AllPlayers):

                TotalItemCount := CountFortInventoryItems(Player)

                # Since CountFortInventoryItems() returns an int we can print it.
                Print("Total items in the fort_inventory_component: {TotalItemCount}")

            Sleep(2.0)
   
    CountFortInventoryItems(Agent:agent):int=

        # We are searching for any descendent components of the InventoryToCount type.
        FortInventories := Agent.FindDescendantComponents(InventoryToCount)

        var TotalItemCount:int = 0

        # For each Inventory, get the array of items.
        for(Inventory:FortInventories, InventoryItems := Inventory.GetItems()):

            # For each item entity, get the item_component.
            for(Item:InventoryItems, ItemComponent := Item.GetComponent[item_component]):

                # Use StackSize to get the SUM of all item stacks.  
                set TotalItemCount = TotalItemCount + ItemComponent.StackSize

        # Return all stacks counted.
        TotalItemCount
```
