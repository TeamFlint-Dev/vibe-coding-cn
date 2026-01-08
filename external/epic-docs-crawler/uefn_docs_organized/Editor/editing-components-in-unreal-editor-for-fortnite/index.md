# Editing Components

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/editing-components-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:17:42.294364

---

Components in Unreal Editor for Fortnite (UEFN) are properties of an [asset](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#asset) that determine how the asset looks and performs in-game. These editable component properties are part of all assets, including devices, [props](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#prop), and gallery items–if it’s in the [Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-browser), you can edit the asset’s component properties. The same goes for assets you import or create.

## Editing Components

Components can be edited one at a time, or in bulk if there are common properties that need editing across multiple assets. To edit components, highlight more than one asset in the [Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#outliner-panel) and use the right-click menu to choose between **Edit Selection in Property Matrix** and **Edit Components in the Property Matrix**.

[![Highlight more than one asset in the Outliner and use the right-click menu to choose between Edit Selection in Property Matrix and Edit Components in the Property Matrix.](https://dev.epicgames.com/community/api/documentation/image/a0ec6269-8f65-4c53-855d-2d6fdc6f9c89?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a0ec6269-8f65-4c53-855d-2d6fdc6f9c89?resizing_type=fit)

**Edit Selection in Property Matrix** allows you to edit one component of one asset at a time in the Property Matrix.

**Edit Components in the Property Matrix** allows you to bulk edit components of multiple assets at once. Only the properties that all selected Actors have in common will display in the Property Matrix.

### Property Matrix

Components are edited inside the **Property Matrix**, which is a type of asset editor. The left panel contains the Root assets, which is short for Root Component. A Root Component is the base of a Blueprint Instance.

Blueprints can only be authored for data, not game scripting in UEFN.

By editing the Root Component you can optimize your assets for better performance in-game and reduce the size of your overall project. With the Property Matrix you can edit the following types of properties in the [Details panel](user-interface-reference-for-unreal-editor-for-fortnite#detailssettingspartition):

- User Options
- LOD
- Static Mesh properties
- Rendering
- Light properties
- Collision
- HLOD
- Navigation
- Mobility

There are more component properties you can edit, the ones listed above are the most important for project optimization.

The Pinned tab contains all the common properties for all the assets you highlighted in the [Outliner](user-interface-reference-for-unreal-editor-for-fortnite#outliner). Editing the components in the Pinned tab edits the same component for all assets in the Root panel (the selected assets) at once.

[![The Property Matrix](https://dev.epicgames.com/community/api/documentation/image/d3cf721e-b966-4885-9077-aa6b9549d5a8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d3cf721e-b966-4885-9077-aa6b9549d5a8?resizing_type=fit)

| Number | Name | Description |
| --- | --- | --- |
| 1 | **Menu Bar and Tab Bar** | Provides access to basic tasks, component objects, and saving capabilities. |
| 2 | **Root Components** | A list of the Blueprint Actors Root Components. |
| 3 | **Pinned Tab** | A list of the common components in each of the Root Components. |
| 4 | **Details Panel** | The Details panel contains information on location, scalability, shadows, lighting, meshes, instance, structural support, weak spots, and more. |
| 5 | **Bottom Toolbar** | Contains the Content Drawer, Output Log, and Revision Control. |

## Using the Property Matrix

To edit the components of a Blueprint Actor or group of Blueprint Actors:

1. Select all the Blueprint Actors whose components you want to bulk edit in the viewport or the Outliner.
2. Right-click and select **Edit Components in the Property Matrix** > **Component Type**. The Property Matrix opens in a new window.

   [![Select the Actors in the Outliner then edit their components with the Property Matrix.](https://dev.epicgames.com/community/api/documentation/image/a5189a8e-b034-4727-8b27-215850b13a60?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a5189a8e-b034-4727-8b27-215850b13a60?resizing_type=fit)
3. Edit the component properties from the **Pinned Columns** panel. An asterisk appears beside the components. Any changes you make from this window can be seen immediately in the viewport.

   [![The Property Matrix window.](https://dev.epicgames.com/community/api/documentation/image/00e50a4d-4d73-46ab-8134-a42de7ffc562?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00e50a4d-4d73-46ab-8134-a42de7ffc562?resizing_type=fit)

   *Click image to enlarge.*
4. **Save** your changes, and **Check-In Changes** to Unreal Revision Control, then exit from the Property Matrix.

Within the Property Matrix window, you can select individual Blueprint Actors from the Root list and edit their components using the Pinned Column, or you can edit their individual components by selecting the Details Panel if you don’t want to make a universal change to all Blueprint Actors in the list.

## Example Use Case

One reason you might want to edit a Blueprint Actor’s components is to adjust properties that are not exposed at the blueprint level.

Blueprint Actors in an underground cave have their Cast Shadow properties on by default. To optimize your project, do a bulk edit on all Blueprint Actors to turn off the Cast Shadow properties on their Static Mesh components since there’s no need for them to cast shadows.

Shadows are heavy to calculate, so turning them off optimizes your project when players enter the cave.

Sometimes knowing what component properties to edit will not happen until the end of game and world building. At other times, and when you get more comfortable with the UEFN toolset, you’ll know right away which Blueprint Actors need to be edited and how.
