# Prefabs and Prefab Instances

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/prefab-and-prefab-instances-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:37:45.947158

---

Prefabs are stable objects that use a hierarchy of entities and components to hold the base information that all prefab instances share.

This makes it easier to edit prefabs as a whole, or in parts, as you continue building and designing your level. You can instance and override assets created in Scene Graph to create new game objects and prefabs.

Prefabs act like a stamp for game objects, so you can place the prefab in the scene as many times as you want. All instances you create are editable either as a group or individually.

For more information about the power and potential of prefabs, refer to the following documentation:

- [Scene Graph Sample Tutorial](https://dev.epicgames.com/documentation/en-us/uefn/scene-graph-sample-tutorial-in-unreal-editor-for-fortnite)
- [Create a Platformer with Scene Graph](https://dev.epicgames.com/documentation/en-us/uefn/create-a-platformer-with-scene-graph-in-unreal-editor-for-fortnite)

## Saving Entities as Prefabs

Prefabs should be as tightly constructed as possible, your prefab design should not be overly complicated. Prefabs with numerous entities and components become data heavy and can cause issues for your project.

Only one component type can be used on an entity at a time. This means once you select a component type you cannot reuse that component type on the same entity. To use the same component you need to add another entity, then add the same component to the new entity.

To create a prefab:

1. In the **Outliner**, right-click on the parent entity and select **Save As Prefab…**. The **Create New Prefab** window opens.

   [![Right-click on the parent entity and select Save As Prefab.](https://dev.epicgames.com/community/api/documentation/image/e7122e9f-3db0-40b4-9a6a-71d11d3e3b57?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7122e9f-3db0-40b4-9a6a-71d11d3e3b57?resizing_type=fit)

   *Click image to enalrge.*

   You can nest the entities in the Outliner first, or add new entities to a prefab in the Prefab Editor after.
2. Name the prefab, and select **Create entity Class**. The Prefab Editor opens with the prefab you created inside the viewport. The prefab thumbnail appears in the Content Browser.

   [![](https://dev.epicgames.com/community/api/documentation/image/a52e64e7-1908-4045-95f7-624be6829368?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a52e64e7-1908-4045-95f7-624be6829368?resizing_type=fit)

   Prefabs can be nested and grouped together in the Outliner for easier editing capabilities.
3. Select the prefab thumbnail, and drag the prefab out of the Content browser into the viewport. This creates another instance of the prefab.

## Propagating Changes to All Prefab Instances

A prefab instance is more than a visual copy of an original. Making changes with the [Prefab Editor](https://dev.epicgames.com/documentation/en-us/fortnite/prefab-editor-user-interface-in-unreal-editor-for-fortnite) causes all instances to automatically adopt all saved changes.
It’s useful to use hierarchies in Scene Graph to determine how child prefabs and entities interact with the parent. Especially when you’re working with assets whose pivot points may be off-center, or don’t use Unreal Units to align with objects in the world.

This saves you time because you don’t have to find every prefab instance and recreate the same changes over and over.

You can also group different prefabs together in a hierarchy to create more complex prefabs.

### Overriding Prefab Instances

You can override components in a prefab instance to make changes unique to that single instance. When you override a component, an **Override** icon appears on the entity in the Outliner, the component card, and next to the overridden component in the Details panel.

Overrides supersede the parent prefab’s design, at the affected component’s level, with the component’s overridden property changes. You can override components in two ways:

- Edit a prefab in the Prefab Editor.
- Override an entity or component from the component card.

From the **[Prefab Editor](https://dev.epicgames.com/documentation/en-us/uefn/prefab-editor-user-interface-in-unreal-editor-for-fortnite)**, add a new component or create a Verse component to add functionality like movement or intractability to the prefab. Saving these changes in the Prefab Editor ensures the change occurs to every instance of the prefab in the scene.

Overriding an entity is done by adding a new component or through creating a Verse component to add functionality like movement or intractability.

Overriding an entity or component from the component card in a prefab instance applies the unique changes to that single instance. In the image below, the two wooden houses are based on the same original prefab design, but the second house has overrides made to component cards at key components to add different meshes or turn parts of the prefab to face different directions to show a new side of the house.

[![Overriding components creates diversity in the scene.](https://dev.epicgames.com/community/api/documentation/image/986d5ce6-a4bc-4ff2-a779-301bd18834aa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/986d5ce6-a4bc-4ff2-a779-301bd18834aa?resizing_type=fit)

Click to enlarge image.

To override a component:

1. From the **Content Browser**, drag an instance of the prefab into the viewport.
2. In the **Details panel** select the `sphere_light_component` card of the prefab instance.

   [![In the Outliner, select the entity on the prefab instance.](https://dev.epicgames.com/community/api/documentation/image/c877d3ce-93cb-4930-8fb6-a0c7f4063753?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c877d3ce-93cb-4930-8fb6-a0c7f4063753?resizing_type=fit)

   Click image to enlarge.
3. Click the **component card menu button**, and select **Override Component**.
4. Select a new property for the component. The override of this component, for this instance, is now different from the parent prefab, and it stays the same even if you make changes to the parent prefab.

### Override Icons

Override icons are blue circles with a blue arrow pointing down the middle of the circle. The icon indicates that a component in this entity has been overridden. When entities are overridden you can use them multiple times in the scene and the entities still work consistently in a prefab as well.

New entities added to a prefab have green circles with a plus sign in the middle to signify that they were added after the prefab was established.

[![Entity icons indicating an overridden entity and added entity.](https://dev.epicgames.com/community/api/documentation/image/6f55ca95-e46d-491e-9302-de10c7d368be?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6f55ca95-e46d-491e-9302-de10c7d368be?resizing_type=fit)

Click to enlarge image.

## Prefab Hierarchies

Prefab hierarchies are created by nesting entities and prefabs under one parent prefab or entity. Parenting makes it possible to:

- Scale the component functions of a prefab to specify how the prefab should work in the scene.
- Determine how child entities interact with the parent prefab.

[![Village created with prefabs and overrides.](https://dev.epicgames.com/community/api/documentation/image/e923890f-9876-41b8-be54-71028c09afaf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e923890f-9876-41b8-be54-71028c09afaf?resizing_type=fit)

Click to enlarge image.

Hierarchies make it possible to snap assets to a particular vector in the scene through the Pivot Point placement. This is helpful not only for set dressing, but also for gameplay elements that use coordinates.

### Pivot Point Placement and Grid Snapping

[Pivot points](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#pivot-point) and [grid snapping](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#grid-snap) work with an entity’s **[transform\_component](https://dev.epicgames.com/documentation/en-us/fortnite/transforms-in-scene-graph-in-unreal-editor-for-fortnite)** to align game objects and prefabs in the scene.

The Prefab Editor doesn’t use the grid to scale prefabs. Instead, use the Outliner’s right-click menu to determine the offset for the pivot point of a prefab.

Grid snapping is relative to the size of your asset. To ensure assets behave as intended, they should be scaled to **512 Unreal Units**, and use the same grid measurement set in UEFN. If you don’t rescale your assets, then reset the pivot points of your assets, and rescale the grid snapping settings.

Placing the pivot point in the center of a prefab doesn’t work for all asset types, such as stairs. Instead, you can use the **Edit Transform** option in **[Modeling Mode](https://dev.epicgames.com/documentation/en-us/uefn/modeling-mode-in-unreal-editor-for-fortnite)** to offset the pivot point to ensure your assets appear and align where you want in the world.

Learn more about 3D world space with the [Left-Up-Forward Coordinate System](https://dev.epicgames.com/documentation/en-us/uefn/leftupforward-coordinate-system-in-unreal-editor-for-fortnite) document.

### Composition in Scene Graph

Composition in Scene Graph provides a way to align assets. All child entities and prefabs rotate on an offset relative to the parent object. If you turn a prefab structure **360 degrees**, the object moves around its center on the grid.

When you rotate an actor in UEFN, the rotation is determined by the placement of the actor in the world. This makes it more difficult to align individual actors to make a complete structure.

It’s useful to use hierarchies in Scene Graph to determine how child prefabs and entities interact with the parent. Especially when you’re working with assets whose pivot points may be off-center, or don’t use [Unreal Units](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#unreal-units) to align with objects in the world.

It’s also helpful when placing decorative assets in relation to parent prefabs that they’re placed on in the scene.

[![Child objects snap according to the Parent Entity's pivot point.](https://dev.epicgames.com/community/api/documentation/image/cf6ce80f-fd1c-4e82-a3f6-197a53d00d22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf6ce80f-fd1c-4e82-a3f6-197a53d00d22?resizing_type=fit)

Click to enlarge image

To learn more about using the Transform component, see the Transform Component(RYANS DOC LINK HERE) document.

## Prefab Class in Verse

Prefabs you create in your project are exposed as a class to Verse in the **Assets.digest.verse** file of your project. You can spawn instances of your prefabs by instantiating the Prefab class and adding them to an entity in the scene using Verse.

To learn more about working with prefabs, refer to [Creating Your Own Component in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite).
