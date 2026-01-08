# Project Size Tool

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/project-size-tool-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:01:28.824083

---

A project’s total size includes all [assets](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#asset), the terrain, and game mechanics supported by Blueprint functionality. These elements all contribute to project size and use memory. Large detailed assets that use a lot of data have the largest effect on the performance of an island and contribute heavily to a project’s size.

The Unreal Editor for Fortnite (UEFN) **Project Size** tool uses a graph to illustrate the size of different asset types in relation to the project's overall size. Use this information to decide which files to compress further or which assets to edit to decrease their data footprint.

To learn more about your island’s memory usage, see the [Memory Management](https://dev.epicgames.com/documentation/en-us/fortnite/memory-management-in-unreal-editor-for-fortnite) page.

## Project Size Tool

To see a project’s size, the island first has to [cook](unreal-editor-for-fortnite-glossary#cook), [render](unreal-editor-for-fortnite-glossary#render), and play to calculate how the assets in your project contribute to memory usage.

[Launching](https://dev.epicgames.com/documentation/en-us/fortnite/playtesting-your-island-in-unreal-editor-for-fortnite) a [playtest](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#playtest) session provides a way for you to cook your assets and access the Project Size tool.

1. Click **Launch Session** in the [Level Editor Toolbar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite).

   [![Launch Session button](https://dev.epicgames.com/community/api/documentation/image/7a6e9533-10de-4620-9fd7-15603c759a92?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a6e9533-10de-4620-9fd7-15603c759a92?resizing_type=fit)

   The project loads and cooks the project data as it prepares to open in Fortnite Creative. After the project cooks, it opens in Fortnite Creative, where you can playtest your island.
2. Press the **Windows key** to go back to UEFN.
3. Click **Project** in the Level Editor Toolbar.

   [![Click the Project button](https://dev.epicgames.com/community/api/documentation/image/ef0bef1f-1fa2-4eb8-bed0-7597aa0573dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ef0bef1f-1fa2-4eb8-bed0-7597aa0573dd?resizing_type=fit)
4. Select **Project Size** from the Project dropdown menu or from the editor viewport’s Project Size widget. The **Project Size tab** opens in a separate window.

   [![Select Project Size from the dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/8f15f98f-a1a1-4e8b-8a4b-e6f0240c4dec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f15f98f-a1a1-4e8b-8a4b-e6f0240c4dec?resizing_type=fit)

   [![See your project’s size from the viewport in the editor as well.](https://dev.epicgames.com/community/api/documentation/image/223cd71c-ec67-4989-8eee-3a4eb22e720c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/223cd71c-ec67-4989-8eee-3a4eb22e720c?resizing_type=fit)

### Project Size Tab

The **Project Size tab** displays all project assets that add to a project’s size, and provides statistics on your island’s size. The more variety of assets there are in the project, the longer the list of assets will be.

[![Project Size tab in By Package view.](https://dev.epicgames.com/community/api/documentation/image/1784dd4a-f452-4f7d-a150-96683e6a18b3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1784dd4a-f452-4f7d-a150-96683e6a18b3?resizing_type=fit)

*Click image to enlarge.*

The project’s comprehensive size is recorded in a box below the **Statistics** bar. This section shows you different size stats:

- **Last Uploaded** - The size of the project was the last time it was cooked.
- **Upload Size** - The project’s size when cooked during the current session.
- **Download Size** - The projected size of the island. This statistic is padded to account for the way different consoles render the island.

The bar graph shows the list of asset types beside each asset’s data usage. You can change the data shown in the Project Size graph by clicking **Settings** in the Statistics bar and selecting different criteria based on group or data usage.

[![The Settings menu.](https://dev.epicgames.com/community/api/documentation/image/5885506e-319e-4c31-8f37-a58ff8bcdbfc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5885506e-319e-4c31-8f37-a58ff8bcdbfc?resizing_type=fit)

- **By Type** - Collapses the graph by asset types and their data use.
- **By Package** - Displays the individual assets by name and their data use.
- **Relative to Project Size** - Displays the data used by the asset based on the size of use relative to the entire project size.
- **Relative to Largest Item** - Compares and displays the data usage of assets to the item that uses the most data.
- **Show Dependencies** - Displays which assets are imported, external project dependencies, such as FAB content packs.

You can continue to [Live Edit](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#edit-mode) while the **Project Size** tab is docked in the editor. After editing your assets:

- Click **Push Changes** in the **Level Editor Toolbar** to publish all changes made in the Live Edit session.
- Click the **Refresh** icon in the **Statistics** bar to register all changes and get a new record of the project’s size.

## Asset Size

Assets can be data heavy depending on the asset’s complexity. The table below breaks down the asset type and how it contributes to a project’s size.

| Asset Type | Contribution to Project Size |
| --- | --- |
| **Shaders** | A shader is a program native to UEFN that calculates various attributes of rendered graphics. Shaders act as a set of instructions that the CPU sends to the GPU which affect the pixels on the screen and render your project’s geometry or visual traits of on-screen objects and materials. |
| **Landscape** | Custom landscapes use more data because they’re not natively designed to be performant like the [Template Islands](project-organization-in-unreal-editor-for-fortnite) under the Map Templates tab. Landscape material also contributes to the file size of a landscape, making it more data-intensive if it uses a custom landscape material. |
| **HLOD** | The [Hierarchical Level of Detail (HLOD)](unreal-editor-for-fortnite-glossary#hlod) system organizes multiple Static Mesh Actors and combines them into a single proxy mesh and Material at long view distances.  This helps reduce the number of Actors that need to be rendered for the scene, which reduces the number draw calls per frame and increases performance. This means you can add more detail to an area of a certain size multiple times causing the number of HLODs to increase. |
| **Static Mesh** | Static meshes are pieces of geometry that consists of numerous [polygons](unreal-editor-for-fortnite-glossary#polygon) which are cached in video memory and rendered by the graphics card. The more polygons a static mesh has, the harder it is to render. Using large static meshes or a large number of different static meshes increases the amount of data used in your project. |
| **Textures** | A texture is an image that loads from a file. Textures are applied as a sort of decal that wraps around a static mesh. The amount of detail in your texture can cause it to become data intense.  The texture’s [file size](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite) is relative to the resolution and doesn’t compress well. For every layer of data ([Diffuse](unreal-editor-for-fortnite-glossary#diffuse), [Normal](unreal-editor-for-fortnite-glossary#normal), and [Specular](unreal-editor-for-fortnite-glossary#specular)), the complexity of your texture increases as does its data requirements. |
| **Materials** | [Materials](unreal-editor-for-fortnite-glossary#material) that use texture packages (Diffuse, Normal, and Specular) tend to have larger file sizes and suffer the same problems data intense textures do when a material file is large; the size of the material file is relative to the resolution and doesn’t compress well. |
| **Niagara System** | Niagara visual effects ([VFX](unreal-editor-for-fortnite-glossary#vfx)) rely on materials to generate visuals. If the textures and materials are data intense, this causes the Niagara effect to also need more data to render properly. If an effect uses more than one material, this also contributes to the expense of the VFX. |
| **Skeletal Mesh** | [Skeletal meshes](unreal-editor-for-fortnite-glossary#skeletal-mesh) are made of two interdependent parts: a group of polygons that make up the surface of the skeletal mesh much like a static mesh, and a hierarchical set of interconnected bones which are used to animate the [vertices](unreal-editor-for-fortnite-glossary#vertices) of the polygons.  The more polygons a skeletal mesh has, the more complex it is to render. You can simplify a static mesh because it doesn’t need to move. However, skeletal meshes are different because animations depend on the number of bones and vertices to support the animation, thereby making the asset data heavy. |
| **Animation** | Complex animations involving large groups of vertices cause animations to require more data because the more vertices a skeletal mesh has, the harder it is to render. Without the correct number of bones and vertices the skeletal mesh won’t play the animation smoothly. |
| **Control Rig** | Control Rig creates animations and therefore contributes to a project’s size by determining which vertex groups are used and the number of times the different groups are used in the movement sequence. |
| **Level Sequence** | Level Sequences can include multiple animations and skeletal meshes which contribute to the project size. |
| **Metasound Source** | Audio can be compressed to a point, but the length and hi-fidelity quality of an [audio file](unreal-editor-for-fortnite-glossary#audio-file) may be data intense. |
| **Blueprint Class** | [Blueprints](unreal-editor-for-fortnite-glossary#blueprint) are node-based interfaces that determine gameplay elements inside UEFN. Depending on the external dependency, the Blueprint could be expensive and require a chunk of data to run properly. |

### Editing Assets

There are a number of ways you can edit your assets inside UEFN. Below is a list of useful editing tools:

- [**UV Editor**](https://docs.unrealengine.com/uv-editor-in-unreal-engine/) - Edit UVs to lower the data a material or mesh uses.
- [**PolyGroup Edit Tool**](https://docs.unrealengine.com/polygroup-edit-tool-in-unreal-engine) - Edit polygroups of static meshes to reduce vertices and simplify static meshes.
- [Resize Textures](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite) - Search for textures in older islands that don’t use the power of two sizing and edit them to conform to the power of two.
- [Editing Components](https://dev.epicgames.com/documentation/en-us/fortnite/editing-components-in-unreal-editor-for-fortnite) - Bulk edit assets to reduce updating cycles.

### Asset Guidelines

Here are some pages to help you troubleshoot assets that might not meet the publishing requirements and avoid running into issues with project size at publishing time:

- [Setting the Level of Detail](https://dev.epicgames.com/documentation/en-us/fortnite/setting-the-level-of-detail-in-unreal-editor-for-fortnite) - This document provides guidance on determining LOD for assets.
- [Streaming and HLODs](https://dev.epicgames.com/documentation/en-us/fortnite/streaming-and-hlods-in-unreal-editor-for-fortnite) - use World Partition to render your island in chunks rather than all at once to reduce rendering issues.
- [Architectural Modeling Guidelines](https://dev.epicgames.com/documentation/en-us/fortnite/architectural-modeling-guidelines-in-unreal-editor-for-fortnite) - Use these guidelines to create architectural assets that work with UEFN’s grid snapping and conform to Fortnite Creative’s performance requirements.
- [Modeling Tips](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-tips-in-unreal-editor-for-fortnite) - Learn how to create assets for UEFN that work in Fortnite Creative.
