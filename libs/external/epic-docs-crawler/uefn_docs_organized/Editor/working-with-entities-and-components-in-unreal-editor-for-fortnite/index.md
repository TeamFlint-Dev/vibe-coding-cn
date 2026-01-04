# Working with Entities and Components

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:23:02.396300

---

Below are the workflows for adding entities, [components](https://dev.epicgames.com/documentation/en-us/fortnite/component), and [prefabs](https://dev.epicgames.com/documentation/en-us/fortnite/prefabs-and-prefab-instances-in-unreal-editor-for-fortnite) to your project. You can use these workflows to create complex objects and add them to your experience.

## Creating an Entity

To create an entity:

1. Open the **Place Actors** panel.
2. Select the **Entity** icon.

   [![](https://dev.epicgames.com/community/api/documentation/image/1f892ddd-f115-4087-8657-03c8cb4a3982?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1f892ddd-f115-4087-8657-03c8cb4a3982?resizing_type=fit)
3. Drag an empty entity into the [viewport](https://dev.epicgames.com/documentation/en-us/uefn/user-interface-reference-for-unreal-editor-for-fortnite#Viewport).

   You can begin adding components to the entity from the [Details panel](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary).

## Adding More Entities Through the Outliner

Once you have an entity in the scene, you can add more entities through the Outliner.

Duplicating the entity creates more entities in the Outliner.

![](https://dev.epicgames.com/community/api/documentation/image/c47f6da8-72a0-4890-8e14-aa3f3d499709?resizing_type=fit)

You can also right-click on an entity in the Outliner and choose the following options:

- **Add Entity**: This option adds a new entity nested under the entity you originally selected.
- **Group Under New Entity**: This option creates a new entity that becomes the parent of the entity you originally selected. If your original entity was nested under another entity, the structure stays the same, with the new entity inserted between the original parent and child entities.

## Nesting and Structuring Entities

Placing entities into a hierarchical structure creates relationships between the entities in the hierarchy. The nesting structure has four levels:

- **Ancestor**: Any level above parent (parent, grandparent, great-grandparent, and so on).
- **Descendent**: Any level below the currently selected entity (children, grandchildren, and so on).
- **Parent**: Single ancestor one level above the currently selected entity.
- **Child**: Descendent one level below the currently selected entity.

In this structure, the Ancestor entity controls the lifetime of all the entities nested underneath.

[![An example of nested entities.](https://dev.epicgames.com/community/api/documentation/image/7392017f-331a-4c6a-8f9e-d482b374fbb1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7392017f-331a-4c6a-8f9e-d482b374fbb1?resizing_type=fit)

In the example below, the **lamp post** on its own is a simple game object that can only do the one thing its component is set to do: be a static mesh of a lamp post.

[![](https://dev.epicgames.com/community/api/documentation/image/85152858-637a-4196-acc4-6ac9ee6b7199?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/85152858-637a-4196-acc4-6ac9ee6b7199?resizing_type=fit)

When the **Rotation\_Point** entity, **Dock\_Lantern** entity, and **SpotLight** entity are nested beneath the **Default\_Wooden\_LightPost\_Prefab\_C** entity, the lamp post takes on the characteristics of its children, making the lamp post a more complex game object.

[![](https://dev.epicgames.com/community/api/documentation/image/701358fc-5bbd-4e27-87bc-d46301c7e13f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/701358fc-5bbd-4e27-87bc-d46301c7e13f?resizing_type=fit)

There are a few reasons to do this:

- Scale the component functions of an entity to specify how the entity should work in the scene.
- Determine how child and descendent entities interact with the parent and ancestor entities.
- Hierarchical structuring represents object lifetime in-game; if the ancestor object is destroyed, then so are all the descendent and child objects.

  When grouping entities, rename the parent entity so you know what the entity is.

Nesting is a concept that you can take advantage of. For example, you can align architectural assets to reduce the likeliness of gaps in your buildings.

Descendent entities can be offset relative to the ancestor’s position in the world allowing you to set a central pivot point that controls the placement of the building’s walls, floors, and more when being duplicated or moved in the scene.

## Adding a Component

Adding a component to an entity determines the behavior of game objects in your project.

To add components to your entity and customize them from the **Details** panel:

1. Select the entity in the viewport or Outliner.
2. In the **Details** panel of the entity, select **Add Component**.

   [![](https://dev.epicgames.com/community/api/documentation/image/8ee770cd-7221-412e-acaf-fad7b4873344?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ee770cd-7221-412e-acaf-fad7b4873344?resizing_type=fit)
3. Search through the **Component dropdown menu**, and select a component. This adds a component to the entity, an entry field for that component appears in the Details panel for the entity.
4. From the **Details** panel, customize the component in the **component options**.

   [![](https://dev.epicgames.com/community/api/documentation/image/aab6056e-0373-4939-9849-51af5740eb7f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aab6056e-0373-4939-9849-51af5740eb7f?resizing_type=fit)

Components can be simple, like a mesh, or complex, like a custom Verse script. You can assign multiple components to one entity to define how that entity behaves in your project. However, only one component type can be used on an entity at a time.

This means once you select a component type you cannot reuse that component type on the same entity. To use the same component you'll need to add another entity and add the same component to the new entity. For more information on which components are available in Scene Graph, refer to [Components](https://dev.epicgames.com/documentation/en-us/fortnite/components-in-unreal-editor-for-fortnite).

Don’t see the component you need? Try making your own! Check out how to [create your own components with Verse](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite).

Currently you can only add one of a given component subclass. For example, you can only have one `point_light_component` on your entity, but you can have one `point_light_component` and one `rect_light_component` on your entity. The same limitation applies to your custom components made in Verse.

![](https://dev.epicgames.com/community/api/documentation/image/21761570-8377-43b2-b569-f0318b2d8cf4?resizing_type=fit)

### Asset-Generated Components

An asset-generated component is a component class that is automatically created based on preexisting content in your project, such as a mesh, sound, or particle system asset. These assets may also expose properties that you can modify on the generated component.

## Overriding Components

You can override components in the **Details** panel of the [Prefab Editor](https://dev.epicgames.com/documentation/en-us/fortnite/prefab-editor-user-interface-in-unreal-editor-for-fortnite) or in the scene. This means that you can change the nature of the component by adding new functionality or changing the associated assets of the component without having to create a new entity or remove the current component.

Components can have 4 different override states. These states are visible on the component card:

| Image | Name | Description |
| --- | --- | --- |
|  | **No Override** | The component does not have an override. |
|  | **Override Here** | The component is overridden here at this level. |
|  | **Override Inside** | The component has an override state on one of its options. [INCLUDE:#state] |
|  | **Unique Override** | The override is unique to this prefab instance. [INCLUDE:#state] |

To override a component, do the following:

1. In the **Details** panel for the component, click the **component card dropdown menu button**, which is a plus (**+**).

   [![](https://dev.epicgames.com/community/api/documentation/image/0e1e9af4-5c0e-4088-9fe9-a62055662ca2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0e1e9af4-5c0e-4088-9fe9-a62055662ca2?resizing_type=fit)
2. In the dropdown menu, select **Override Component**.

   [![](https://dev.epicgames.com/community/api/documentation/image/965ea57e-96d7-4227-b7e1-a5c380eeefe7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/965ea57e-96d7-4227-b7e1-a5c380eeefe7?resizing_type=fit)

In the image below, all empty icons next to the components in the Details panel now have the override icon.

[![](https://dev.epicgames.com/community/api/documentation/image/5f48213a-f136-4b1a-8739-58a7894d2059?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f48213a-f136-4b1a-8739-58a7894d2059?resizing_type=fit)

Changing the default values of a component’s options also creates an override to that component’s function, such as increasing the default values on a light component. When you change default values, the component control button features a **+ icon** to signal that default values were changed.

[![](https://dev.epicgames.com/community/api/documentation/image/d5989c89-cbea-46a4-9217-45755f0a8150?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d5989c89-cbea-46a4-9217-45755f0a8150?resizing_type=fit)

## Clear Overrides

To go back to the original prefab design, do the following:

1. In the **Details** panel, click on the **component card dropdown menu button**.

   [![](https://dev.epicgames.com/community/api/documentation/image/0b6e90c3-9ccf-4184-b39a-fc9686d4fe3c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0b6e90c3-9ccf-4184-b39a-fc9686d4fe3c?resizing_type=fit)
2. Select **Clear Override**. The prefab returns to its original state.

   [![](https://dev.epicgames.com/community/api/documentation/image/3b349751-c389-42e8-9d1b-9e9343c7b4c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3b349751-c389-42e8-9d1b-9e9343c7b4c7?resizing_type=fit)

## Removing a Component

To remove components from entities:

1. In the **Details** panel, click the **component card dropdown menu button**, which is a plus (**+**), on the component.

   [![](https://dev.epicgames.com/community/api/documentation/image/7dd1147a-e69f-41df-a4e1-579fc819525b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7dd1147a-e69f-41df-a4e1-579fc819525b?resizing_type=fit)
2. In the dropdown menu, select **Remove Component**. The component is removed from the entity.

   [![](https://dev.epicgames.com/community/api/documentation/image/d88e4f4c-baaf-400f-8552-ef80b1ecb516?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d88e4f4c-baaf-400f-8552-ef80b1ecb516?resizing_type=fit)

[![](https://dev.epicgames.com/community/api/documentation/image/19d02c46-e9ba-4c21-8404-6f0e11a16930?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19d02c46-e9ba-4c21-8404-6f0e11a16930?resizing_type=fit)

This workflow works in the Prefab Editor as well.

## Saving Entities as Prefabs

Once you create your entities and add components to them, you can save specific entities as a prefab. This means you can create multiple instances of the same entity and component structure, and that these changes propagate across them all instantly. To learn how to create prefabs and propagate changes, see [Prefabs and Prefab Instances](https://dev.epicgames.com/documentation/en-us/fortnite/prefabs-and-prefab-instances-in-unreal-editor-for-fortnite).

## Working with Scene Graph in Fortnite Creative

**Scene Graph Entity** support is available in Fortnite Creative. Using the **[Phone Tool](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#phone)** you have basic editing capabilities in Scene Graph using the controls and feedback you're familiar with during **[Edit Mode](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#edit-mode)**. The support feature also means you can interact with all entities and actors simultaneously in the scene using the Phone Tool.

These basic interactions between Fortnite Creative and Scene Graph are possible because entire entity hierarchies are selected as one object by the Phone Tool.

Scene Graph entities cannot be created in Creative edit Mode.
