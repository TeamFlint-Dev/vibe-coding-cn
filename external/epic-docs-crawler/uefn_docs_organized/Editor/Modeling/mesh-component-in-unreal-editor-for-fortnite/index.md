# Mesh Component

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/mesh-component-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:43:38.635382

---

Components are basic building blocks that use data and logic to build your game. Use the **mesh c****omponent** like an asset. When selecting a mesh component, a dropdown menu of static meshes provides a way for you to use a default mesh or one that you made or imported.

The **mesh component** is an asset-generated component. An **asset-generated component** is a component class that is automatically created based on preexisting content in your project, such as a mesh, sound, or particle system asset. These assets may also expose properties that you can modify on the generated component.

You can add an asset-generated component to an entity by selecting **+Component** in the Details panel and navigating to the base class to find the component you want. You can also drag and drop the asset from the Content Browser into the Details panel for your entity. These asset-generated components also can be referenced specifically in your Verse code and appear in your **Assets.digest.verse** file.

You need to compile the Verse code for your project after you import or create your asset in order to generate the component class. You need at least one Verse written component to compile the Verse code.

To add a component to your entity, refer to [Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite).  The component is listed as mesh\_component, which matches the Verse class for the mesh component. For more information about the Verse API for the mesh component, check out the [mesh\_component API reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/mesh_component).

## Example

By using the mesh\_component to gray box your level, you can easily switch out the default Static Meshes with ones you created or imported. Gray boxing a scene with the mesh\_component does a few things:

- Ensures the level design fits around the gameplay elements.
- Lowers development time.
- Turning an entity with the mesh\_component into a prefab means quick iteration on a design.

  [![The mesh_component can be used to gray box a scene to ensure that the level design fits around the gameplay elements.](https://dev.epicgames.com/community/api/documentation/image/59c31dad-0908-479e-9294-168d8d951b41?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/59c31dad-0908-479e-9294-168d8d951b41?resizing_type=fit)

Once a static mesh is applied to the mesh\_component, the component is referenced by the default mesh object used to create the component at its base.

This is not the preferred method for using mesh\_component. Refer to the Known Issues list on the **Scene Graph** page for more information.

You can only add one of a given component class or subclass. For example, you can only have one `mesh_component` on an entity. This extends to subclasses of components, meaning if you add a `capsule_light_component` to your entity, you cannot also add a `rect_light_component` since both are subclasses of `light_component`. The same limitation applies to custom components made in Verse.

## Component Options

All basic component options on the mesh-component can be enabled, disabled, and overridden from the component card and can be used with a Verse component. Asset-generated components are always overridden from the component dropdown menu.

| Option | Value | Description |
| --- | --- | --- |
| **Enable** | **True**, False | Enables or disables the component in the scene. |
| **Collidable** | **True**, False | The mesh may collide in the physics simulation when set to True. |
| **Queryable** | **True**, False | The mesh can be queried in Verse code when set to True. |
| **Visible** | **True**, False | The mesh visibility can be enabled and disabled in the scene. |

Material slots on the mesh\_component are easily selected and overridden from the mesh dropdown menu where all available Static Meshes are listed.
