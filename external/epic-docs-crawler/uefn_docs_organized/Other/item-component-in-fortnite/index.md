# Item Component

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/item-component-in-fortnite
> **爬取时间**: 2025-12-27T00:34:58.565918

---

This feature is in an Experimental state so you can try it out, provide feedback, and see what we are planning. You cannot publish a project that uses Itemization at this time.

Please keep in mind that we do not guarantee backward compatibility for assets created at the experimental stage, the APIs for these features are subject to change, and we may remove entire Experimental features or specific functionality at our discretion. Check out the list of known issues before you start working with the feature.

In the [Custom Items and Inventories system](https://dev.epicgames.com/documentation/en-us/fortnite/custom-inventory-and-items-overview-in-fortnite), an `item_component` becomes a [class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse) that defines what an item is and isn’t. For how to add a [component](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#component) to your [entity](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#entity), see  **[Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite)**.

Entities are only considered items if they have an `item_component`. Without one, entities will not be added to inventories properly and lots of Custom Item and Inventories functionality may be broken.

- References to an “item” are directly referring to an entity with an `item_component`.
- References to “inventories” are directly referring to an entity with an `inventory_component`.

## Class Definition

Attaching an `item_component` to an entity turns the entity into an item. This means it can be added to an inventory and manipulated by inventories. The `item_component` also contains the following basic functionality:

- `Categories` -   An array of `item_category` that can be used to sort and characterize.
- Item stacking behaviour:

  - `StackSize` - An integer that conveys how many of these items are stacked.
  - `MaxStackSize` - How many items can be merged or stacked, before a new stack must be created. This defaults to no maximum (for example, infinite stacking).
  - Subscribe to `ChangeStackSizeEvent` to monitor stack changes.
  - `MergeableItemComponentClasses` is an array that can contain subclasses of 
    the `item_component`. This allows any entity with a subclass inside the array to merge with this entity to form a stack.
- The component also contains helper functions such 
  as `GetParentInventory()` and `IsEquipped()`.

More functionality can be given to an item with additional components that expose different features and basic Fortnite gameplay. You can also write your own custom Verse components. For more information check out the `item_component` API reference from the [Verse API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api).

See **[Components](https://dev.epicgames.com/documentation/en-us/fortnite/components-in-unreal-editor-for-fortnite)** for a complete list of Custom Items and Inventories components.

## Example

Item components are required by entities to function as items. The [Prefab editor](https://dev.epicgames.com/documentation/en-us/fortnite/prefab-editor-user-interface-in-unreal-editor-for-fortnite) has limited editable properties, so to get the most out of the component you will need to use Verse.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Itemization }

# Helper function that gets the first descendant inventory component from an agent.
# This will be the root inventory.
GetAgentInventory(Agent:agent)<decides><transacts>:inventory_component=
    TargetInventory := (for (I : Agent.FindDescendantComponents(inventory_component)) { I })[0]

# This device will create an item for all players. Each will set its stack size and then pick itself up to the Player's inventory.
item_giver_device := class(creative_device) :

    OnBegin<override>()<suspends>:void=

        AllPlayers := GetPlayspace().GetPlayers()

        for(Player:AllPlayers):

            # Adding the item_component to an entity turns it into an item.
            NewEntity := entity{}
            NewItemComponent:item_component = item_component{Entity := NewEntity}
            NewEntity.AddComponents(array{NewItemComponent})

            # Modify the stacking properties through the setter functions.
            NewItemComponent.SetStackSize(5)
            NewItemComponent.SetMaxStackSize(NewMaxStackSize:=5)

            # Get an inventory from the Player.
            # Pickup the item so it goes into the Player inventory.
            if(TargetInventory := GetAgentInventory[Player]):

                if(NewItemComponent.PickUp[TargetInventory]):

                    Print("Item successfully picked up.")
```

Functionality can easily be added to Items by subclassing the `item_component`. This could be to modify the basic properties, or to add new functions and fields specific to your experience.

```verse
custom_item_component := class(item_component) :

    # We could populate the Categories array with Fortnite and/or custom item categories.
    Categories<override>:[]item_category = array{}

    # By adding itself to the MergeableItemComponentClasses, it allows entities with this item_component to merge in inventories.
    MergeableItemComponentClasses<override>:[]castable_subtype(item_component) = array{custom_item_component}
   
    # MaxStackSize is an optional property. By default it has no value (false) and can be infinitely stacked.
    var MaxStackSize<override>:?int = option{5}

    # By subclassing you can also add new class members, such as fields or methods.
```

The gif illustrates the stacking behavior of the item\_component.

Here you can see a prefab item using the `custom_item_component` shown above. The item is picked up and a new one respawned. You can see the stacking behavior in the inventory.
