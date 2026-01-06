# Inventory Component

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/inventory-component-in-fortnite
> **爬取时间**: 2025-12-27T00:34:14.204605

---

This feature is in an experimental state so you can try it out, provide feedback, and see what we are planning. You cannot publish a project that uses Itemization at this time.

Please keep in mind that we do not guarantee backward compatibility for assets created at the experimental stage. The APIs for these features are subject to change, and we may remove entire experimental features or specific functionality at our discretion. Check out the list of known issues before you start working with the feature.

The `inventory_component` is a Scene Graph component used as a container for Items. For how to add a [component](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#component) to your [entity](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#entity), see **[Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite)**.

Entities are only considered items if they have an `item_component`. Without one, entities will not be added to inventories properly as well as Custom Item and Inventories functionality may be broken.

- References to an “item” are referring to an entity with an `item_component`.
- References to “inventories” are referring to an entity with an `inventory_component`.

## Class Description

The `inventory_component` is used as a container to hold items. Items added to the inventory become children of the `inventory_component`'s entity. Along with the normal scene graph hierarchy functionality, Inventories can manage themselves and their owned items with specific properties and [methods](https://dev.epicgames.com/documentation/en-us/fortnite/method):

- Add or remove items using `AddItem()` and `RemoveItem()`.
- To retrieve items `GetItem()` and `FindItems()` can be used. Get [functions](https://dev.epicgames.com/documentation/en-us/fortnite/function) return immediate children, whereas Find functions return all descendents.
- To find other inventories there is `GetInventories()` and `FindInventories()`.
- Events to [subscribe](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#subscribe) to, such as `AddItemEvent` and `RemoveItemEvent`.
- `GetEquippedItems()` can be used for equipment, and the events `EquipItemEvent` and `UnequipItemEvent` used to track them.

With an `inventory_component`, any entity could become a bag or a backpack, a chest containing loot, or even a character loadout with weapons and abilities.

Inventories can control which items are added or removed in different ways. One useful method involves **[Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)**. When the `AddItem()` function is called a scene event is broadcast that can be responded to by components. When a scene event arrives at a component, the `OnReceive()` event is fired, which can be overridden to trigger logic.

The Experimental release of Custom Items and Inventories also includes another method of controlling adding, removing, and merging items. By subclassing the `inventory_rule_interface` type, new overrides can be written  for `CanAdd()` ,  `CanRemove()` , and `CanMerge()`. These rules can be added to `InventoryRuleList` using `AddRule()`. Please note, this feature is not expected to persist beyond the Experimental release.

The component is listed as `inventory_component` in the component dropdown list. For more information, check out 
the `inventory_component` API reference from the [Verse API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api).

## Inventories and Scene Graph

The [Custom Items and Inventories system](https://dev.epicgames.com/documentation/en-us/fortnite/custom-inventory-and-items-overview-in-fortnite) delivers a basic setup that should be understood to  get the most out of it.

All Players will begin with a **Root Inventory** which is an entity with an `inventory_component` attached to the **Player Entity**. This Root Inventory also has a number of `fort_inventory_component` sub-inventories. These are required to preserve Fortnite functionality. See **[Fort Inventory Component](https://dev.epicgames.com/documentation/en-us/fortnite/fort-inventory-component-in-fortnite)** for details on these components.

Due to the method of traversing the Scene Graph, the Root Inventory will always be the first Inventory found when searching an entity tree for an entity with an `inventory_component`. For this reason, the Root Inventory is a sensible target to attach new Inventories.

```verse
# Helper function that gets the first descendant inventory component from an agent.
# This will be the root inventory.
GetAgentInventory(Agent:agent)<decides><transacts>:inventory_component=
    TargetInventory := (for (I : Agent.FindDescendantComponents(inventory_component)) { I })[0]
```

[![](https://dev.epicgames.com/community/api/documentation/image/0aff14ad-e1d1-44d6-8c12-6bddf829a347?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0aff14ad-e1d1-44d6-8c12-6bddf829a347?resizing_type=fit)

Above you can see the default setup for the Root Inventory and the standard Fortnite Inventories.

The Root Inventory is attached to the Player, and all the sub-inventories are attached to the Root Inventory. New Inventories should be added to the Root Inventory so that other systems only need to find and interface with the one Root inventory.

## Example

Adding an `inventory_component` to an entity in the Prefab Editor allows it to store items as an Inventory. 
The chest below has an `inventory_component`. It can now leverage all the functionality inside the component.

[![The chest has an inventory_component on the entity.](https://dev.epicgames.com/community/api/documentation/image/e9e3d881-8fd9-4fb1-b7a3-a35f711c7a2d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9e3d881-8fd9-4fb1-b7a3-a35f711c7a2d?resizing_type=fit)

Click image to enlarge.

However to get the most power from Custom Items and Inventories, you will need to use Verse:

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Itemization }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Itemization }

# This device will give an inventory to all players
# It will then make a dummy item and give it to the inventory.
inventory_giver_device := class(creative_device) :

    OnBegin<override>()<suspends>:void=

        AllPlayers := GetPlayspace().GetPlayers()

        # For all current players, call AddInventoryToPlayer().
        for(Player:AllPlayers):
            AddInventoryToPlayer(Player)
       
        # Subscribe to PlayerAddedEvent to add an inventory to future players.
        GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAddedEvent)

    # Call our inventory add function when the subscribed event is triggered.
    OnPlayerAddedEvent(Player:player):void=
        AddInventoryToPlayer(Player)
           
    AddInventoryToPlayer(Player:player):void=
            # Create a new entity.
            NewInventoryEntity := entity{}
           
            # Create a new inventory_component.
            # Add it to NewEntity, turning it into an inventory.
            NewInventoryComponent := custom_inventory_component{Entity := NewInventoryEntity}
            NewInventoryEntity.AddComponents(array{NewInventoryComponent})
           
            # The inventory must be attached to the root inventory.
            if:
                RootInventoryEntity := GetAgentInventory[Player].Entity
            then:
                # Add the NewItemEntity to the inventory root.
                RootInventoryEntity.AddEntities(array{NewInventoryEntity})

                # Create an item entity to give to the Player.
                NewItemEntity := entity{}
                NewItemEntity.AddComponents(array{ item_component{Entity := NewItemEntity} })

                # Call AddItem() function to add it to the inventory.
                if(NewInventoryComponent.AddItem[NewItemEntity]):
                    Print("Successfully added an item to the inventory.")
```

A common requirement of inventories is to apply rules to what items may exist inside. Below is a script for a custom `inventory_component` which overrides the component 
method `OnReceive()`. Here it has been used to make a maximum Inventory size rule:

```verse
# This custom inventory component overrides the OnReceive function.
# This will allow us to determine whether or not we want an entity with this inventory component, to receive items.
custom_inventory_component := class(inventory_component) :

    # What is the maximum number of items allowed in this inventory?
    @editable
    MaximumItemSlots:int = 5

    # The OnReceive function is called any time the owner entity receives any scene event.
    OnReceive<override>(SceneEvent:scene_event):logic=

        # Here we are casting the received event to the find_inventory_event type.
        if(FindInventoryEvent := find_inventory_event[SceneEvent]):

            # We check whether this inventory has fewer than 5 items already inside.
            # If so, then we modify the scene event by adding a reference to Self, with a priority, to the scene event's EligibleInventories array.
            if:
                GetItems().Length < MaximumItemSlots
            then:
                Entry := inventory_with_priority{Inventory := Self, Priority := 1.0}
                set FindInventoryEvent.EligibleInventories = FindInventoryEvent.EligibleInventories + array{Entry}
       
        # OnReceive must return a logic value. This is whether the event should be consumed by this component.
        # Here we return false, and allow other inventories to bid to receive the item.
        false
```

You can see in the clip above how our custom\_inventory\_component is only allowing 3 items into it. After that, new items are rejected.

For gameplay examples of inventories and how to use the `inventory_component`, see the tutorials in  **[Custom Items and Inventories with Scene Graph](https://dev.epicgames.com/documentation/en-us/fortnite/custom-items-and-inventories-with-scene-graph-in-uefn)**.
