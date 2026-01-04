# Item Details Component

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/item-details-component-in-fortnite
> **爬取时间**: 2025-12-27T00:34:34.279068

---

This feature is in an experimental state so you can try it out, provide feedback, and see what we are planning. You cannot publish a project that uses Custom Items and Inventories at this time.

Please keep in mind that we do not guarantee backward compatibility for assets created at the experimental stage, the APIs for these features are subject to change, and we may remove entire experimental features or specific functionality at our discretion. Check out the list of known issues before you start working with the feature.

The `item_details_component` is a Scene Graph component. It contains text data about the item, such as its name and description. For how to add a [component](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#component) to your [entity](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#entity), see  **[Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite)**.

Entities are only considered items if they have an `item_component`. Without one, entities will not be added to inventories properly and lots of Custom Item and Inventories functionality may be broken.

- References to an “item” are referring to an entity with an `item_component`.
- References to “inventories” are referring to an entity with an `inventory_component`.

## Class Description

The `item_details_component` is a component that contains text data that can be used by other systems.  The `item_details_component` provides a way to add input for the item's:

- **Name**: The name of the item.
- **Description**: A long description of the item.
- **Short Description**: A brief description of the item.

These properties are `<protected>` and can therefore only be modified at instantiation or by [subclassing](https://dev.epicgames.com/documentation/en-us/fortnite/subclass-in-verse) the component and defining them inside the subclass.

An example of the Item Details Component in a project used to define a Cube item.

See **[Components](https://dev.epicgames.com/documentation/en-us/fortnite/components-in-unreal-editor-for-fortnite)** for a complete list of item and inventory components.

When the [Custom Items and Inventories system](https://dev.epicgames.com/documentation/en-us/fortnite/custom-inventory-and-items-overview-in-fortnite) is enabled the `item_details_component` is shown in the component dropdown list. For more information, check out the `item_details_component` API Reference from the [Verse API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api).

## Example

Properties from the `item_details_component`’s can be used to display item details in the [HUD](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#hud). Through Verse the `item_details_component` properties can be dynamically modified and new ones added.

You can use the examples below to set up the `item_details_component` in your project using Verse.

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Itemization }
using { /Verse.org/SceneGraph }
using { /UnrealEngine.com/Itemization }

# This device will create an entity with an item_details_component.
# Once this entity has been instantiated, print all the item details set.
add_details_item_device := class(creative_device) :

    # We must declare our details as localized messages.
    ItemName<localizes>:message = "Item"
    ItemDescription<localizes>:message = "Item Description"
    ItemShortDescription<localizes>:message = "Item Short Description"

    OnBegin<override>()<suspends>:void=

        # Make an entity, then an item_component. Construct an item_details_component using values from our declared messages.
        # Add the item components to the new entity.
        TargetEntity:entity = entity{}
        NewItemComponent := item_component{Entity := TargetEntity}
        NewItemDetailsComponent := item_details_component
            {
                Entity := TargetEntity,
                Name := ItemName,
                Description := ItemDescription,
                ShortDescription := ItemShortDescription
            }
        TargetEntity.AddComponents(array{NewItemComponent,NewItemDetailsComponent})

        # Print item details by getting the properties from the component.
        Print(NewItemDetailsComponent.Name)
        Print(NewItemDetailsComponent.Description)
        Print(NewItemDetailsComponent.ShortDescription)
```

In order to modify the properties of an `item_details_component` at runtime, you can create a subclass and write new functions to update the values:

```verse
# This is a subclass of the item_details_component with property setters.
custom_item_details_component := class(item_details_component) :

    SetName(NewName:message):void=
        set Name = NewName

    SetDescription(NewDescription:message):void=
        set Description = NewDescription

    SetShortDescription(NewShortDescription:message):void=
        set Description = NewShortDescription
```
