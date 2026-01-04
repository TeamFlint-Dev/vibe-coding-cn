# Item Icon Component

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/item-icon-component-in-fortnite
> **爬取时间**: 2025-12-27T00:34:21.156386

---

This feature is in an Experimental state so you can try it out, provide feedback, and see what we are planning. You cannot publish a project that uses Itemization at this time.

Please keep in mind that we do not guarantee backward compatibility for assets created at the experimental stage, the APIs for these features are subject to change, and we may remove entire Experimental features or specific functionality at our discretion. Check out the list of known issues before you start working with the feature.

The `item_icon_component` 
is a Scene Graph [component](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#component) used to assign an icon to an [entity](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#entity). For how to add a component to your entity, see **[Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite)**.

Entities are only considered items if they have an `item_component`. Without one, entities will not be added to inventories properly as well as Custom Item and Inventories functionality may be broken.

- References to an “item” are referring to an entity with an `item_component`.
- References to “inventories” are referring to an entity with an `inventory_component`.

## Class Description

An `item_icon_component` uses a **[Texture](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#texture)** asset as a visual reference to the item in-game. The `item_icon_component` also provides a way to control the texture through [variables](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse) and [functions](https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-verse) in the [Custom Items and Inventories system](https://dev.epicgames.com/documentation/en-us/fortnite/custom-inventory-and-items-overview-in-fortnite).

The component property is `<protected>` and can only be modified at instantiation or by [subclassing](https://dev.epicgames.com/documentation/en-us/fortnite/subclass-in-verse) the component and defining them inside the subclass.

[![An example of a texture in the item_icon_component's texture slot.](https://dev.epicgames.com/community/api/documentation/image/8c496e48-0d23-4f02-9e10-6178d1edfb53?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c496e48-0d23-4f02-9e10-6178d1edfb53?resizing_type=fit)

Click to enlarge image.

Once the Custom Items and Inventories system is enabled the `item_icon_component` is listed in the component dropdown list. For more information check out 
the `item_icon_component` API reference from the [Verse API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api).

## Example

With Verse, the `item_icon_component` can be assigned a value through the component’s **texture slot** in the user options. The texture can be updated using a program to detect when the item is removed from the inventory’s item slot.

You can use the examples below to set up the `item_icon_component` in your project using Verse.

```verse
using { /Verse.org/Assets }
using { /Fortnite.com/Devices }
using { /Fortnite.com/Itemization }
using { /Verse.org/SceneGraph }
using { /UnrealEngine.com/Itemization }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Simulation }

# This device will create an item entity with an item_icon_component.
# It will set a default texture for the icon component.
add_icon_item_device := class(creative_device) :

    OnBegin<override>()<suspends>:void=

        # Make an entity, then an item_component. Make an item_icon_component, assign a value for Icon from the asset.digest.verse.
        # Add the item components to the new entity.
        TargetEntity:entity = entity{}
        NewItemComponent := item_component{Entity := TargetEntity}
        NewItemIconComponent := item_icon_component{Entity := TargetEntity, Icon := (/sample_user@fortnite.com/sample_project:)UI.Textures.T_Icon}
        TargetEntity.AddComponents(array{NewItemComponent,NewItemIconComponent})

        # The item will now have an icon in the default Custom Items and Inventory UI.
```

Below is an example of how to convert the texture inside the `item_icon_component` into a widget displayed using Verse UI.

```verse
# This function will display a texture block widget to the player screen.
# It sources the texture from the item_icon_component from the provided entity.
DisplayIconWidget(Player:player, Item:entity):void=
    if:
        IconComponent := Item.GetComponent[item_icon_component]
        PlayerUI := GetPlayerUI[Player]
    then:
        IconWidget := texture_block{DefaultImage:= IconComponent.Icon}
        PlayerUI.AddWidget(IconWidget)
```

To learn more about using Verse to create [user interfaces (UI)](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#ui), see **[Creating UI with Verse](https://dev.epicgames.com/documentation/en-us/fortnite/creating-ui-with-verse-in-unreal-editor-for-fortnite)**.
