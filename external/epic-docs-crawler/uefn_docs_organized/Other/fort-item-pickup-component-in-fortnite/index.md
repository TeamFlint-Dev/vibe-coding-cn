# Fort Item Pickup Component

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/fort-item-pickup-component-in-fortnite
> **爬取时间**: 2025-12-27T00:34:27.525661

---

This feature is in an experimental state so you can try it out, provide feedback, and see what we are planning. You cannot publish a project that uses Custom Items and Inventories at this time.

Please keep in mind that we do not guarantee backward compatibility for assets created at the experimental stage, the APIs for these features are subject to change, and we may remove entire experimental features or specific functionality at our discretion. Check out the list of known issues before you start working with the feature.

The `fort_item_pickup_component` extends the capabilities of the **[Item Component](https://dev.epicgames.com/documentation/en-us/fortnite/item-component-in-fortnite)** by leveraging standard pickup properties. For how to add a component to your entity, see  **[Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite)**.

Entities are only considered items if they have an `item_component`. Without one, entities will not be added to inventories properly as well as Custom Item and Inventories functionality may be broken.

- Reference to an item refers to an entity with an `item_component`.
- Reference to inventories refers to an entity with an `inventory_component`.

## Class Description

A `fort_item_pickup_component` provides an item with the common functionality of a typical Fortnite item:

- The entity can be picked up by pressing the interact input.

  The `fort_item_pickup_component` requires a [mesh\_component](https://dev.epicgames.com/documentation/en-us/fortnite/mesh-component-in-unreal-editor-for-fortnite) to receive an interaction input.
- It shows a widget that describes the item when it can be picked up in the world.
- It plays a simple animation to communicate picking up and dropping.
- `PickupLifetime` allows the entity to be removed after a duration if it has not been picked up.

If you do not want to use this pickup component, you can create your own using the `interactable_component`.

The fort\_item\_pickup\_component provides a quick way to give items Fortnite comparable behavior.

When the Custom Items and Inventories system is turned on, the `fort_item_pickup_component` is listed in the component dropdown list. For more information, 
check out the `fort_item_pickup_component`API reference from the [Verse API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api).

See **[Components](https://dev.epicgames.com/documentation/en-us/fortnite/components-in-unreal-editor-for-fortnite)** for a complete list of Custom Items and Inventories components.

## Example

You can add the `fort_item_pickup_component` to a prefab through the Prefab editor, or by using  Verse:

```verse
using { /Fortnite.com/Itemization }
using { /Fortnite.com/Devices }
using { /Verse.org/SceneGraph }
using { /UnrealEngine.com/BasicShapes }
using { /UnrealEngine.com/Itemization }
using { /UnrealEngine.com/Temporary/SpatialMath }

# This device creates a new item, gives it the basic components required for an item, then places it at the device location.
# The item can be immediately interacted with and picked up.
fort_item_pickup_device := class(creative_device) :

    OnBegin<override>()<suspends>:void=

        # The item will require a parent to be attached to, otherwise it will be removed.
        # The Simulation entity is a reliable entity to attach world items to.
        if(SimEntity := GetSimulationEntity[]):

            NewEntity := entity{}
            NewItemComponent := item_component{Entity := NewEntity}

            # The fort_item_item_pickup_component requires a mesh_component with collision to perform the pickup check.
            # We can use a cube basic shape.
            NewMeshComponent := cube{Entity := NewEntity}

            # We can construct the fort_item_pickup_component and provide a value for PickupLifetime.
            # The item will be removed from the scene in 15 seconds.
            NewFortItemPickupComponent := fort_item_pickup_component{Entity := NewEntity, PickupLifetime := 15.0}
            NewEntity.AddComponents(array{NewItemComponent, NewFortItemPickupComponent, NewMeshComponent})
           
            # Once the entity is setup, with all the required components, we can set it's transform to the device's.
            # Finally we parent the new entity to the Simulation entity.
            NewEntity.SetGlobalTransform(FromTransform(Self.GetTransform()))
            SimEntity.AddEntities(array{NewEntity})
```
