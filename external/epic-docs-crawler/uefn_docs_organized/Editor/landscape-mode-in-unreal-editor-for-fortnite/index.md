# Changing Terrain with Landscape Mode

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/landscape-mode-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:08:58.221751

---

**Landscape Mode** is a set of editing tools in **Unreal Editor for Fortnite (UEFN)** that help you build some or all of the island terrain using the Landscape tools.

This [mode](unreal-editor-for-fortnite-glossary#mode) gives you improved control when creating environments. Using Landscape Mode to create your own terrain means your island will look and feel unique to players without taking a lot of time to make.

For more information on Landscape Mode, refer to the [Unreal Engine 5 Landscape Outdoor Terrain documents](https://docs.unrealengine.com/landscape-outdoor-terrain-in-unreal-engine/).

## How It Works

With the tools in Landscape Mode, you can build custom environments by modifying the terrain of existing islands or create your own terrain from scratch.

There are three stages to working with Landscape:

1. **Manage:** Create a new Landscape, make it larger or smaller, and manage its properties.
2. **Sculpt:** Edit the heightmap to shape the terrain.
3. **Paint:** Edit the weightmaps to blend between different material layers.

To learn more about creating custom landscapes, refer to [**Creating Landscapes**](https://docs.unrealengine.com/creating-landscapes-in-unreal-engine/).

The Visibility Brush causes issues in game for players and vehicles entering caves created with the brush. Players might despawn and vehicles might teleport above the landscape.

## Manage Tools

**Manage** contains tools for the Landscape as a whole (New, Import) as well as its tiles and/or components (Select, Add, Delete). It also provides controls for managing additional [splines](unreal-editor-for-fortnite-glossary#spline) that are associated with the Landscape (Splines).

[![The selection of tools available from Manage.](https://dev.epicgames.com/community/api/documentation/image/661590cc-6b5a-49b5-914b-633ac311bd1c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/661590cc-6b5a-49b5-914b-633ac311bd1c?resizing_type=fit)

- **New:** Create a new Landscape. (See directions below to create a new terrain.)
- **Import:** Import a Landscape from a file created in a third party application such as Houdini, Gaea, or use real-world satellites data. You can even export the Landscape you’re currently working on to make some changes in another software package and re-import it.
- **Select:** Select components to change their properties.
- **Add:** Add components to the Landscape.
- **Delete:** Delete components from the Landscape.
- **Splines:** Use **Ctrl + Click** to create splines for roads, pathways or other meshes that need to follow the terrain. [Spline mesh settings](https://docs.unrealengine.com/landscape-splines-in-unreal-engine/) can be found in the **Details** panel when you have segments selected.

You create a new Landscape from scratch from the **Create New** section of the **New** tool panel.

In UEFN the Landscape resolution is limited to a maximum of **2048 by 2048** vertices or an equivalent size, for example, 4096 by 1024 or 8192 by 512.

[![The options in the Manage section of Landscape Mode.](https://dev.epicgames.com/community/api/documentation/image/4cc9ff97-b2bc-4b8c-b1b2-0c2f21c0a896?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4cc9ff97-b2bc-4b8c-b1b2-0c2f21c0a896?resizing_type=fit)

| Number | Option | Description |
| --- | --- | --- |
| 1 | Create New | Creates a new Landscape in your Level. |
| 2 | Import From File | Imports a Landscape heightmap made in an external program. |
| 3 | World Partition Grid Size | Number of components per Landscape streaming proxies per axis. |
| 4 | Material | Assigns a material to your landscape. |
| 5 | Location | The location of the new Landscape. |
| 6 | Rotation | The rotation of the new Landscape. |
| 7 | Scale | The scale of the new Landscape. This is the size of each quad in the landscape defaulting to 100 units. |
| 8 | Section Size | The number of quads in a single component section. Each section is rendered independently, giving more control over the level-of-detail transitions within a component. |
| 9 | Sections Per Component | The number of sections in a single component. This along with the section size determines the size of each component. A component is the base unit for organizing Landscape data. |
| 10 | Number of Components | The number of components in the X and Y direction, determining the overall size of the Landscape. |
| 11 | Overall Resolution | Overall resolution of the new Landscape in vertices discounting overlapping vertices between neighboring components. |
| 12 | Total Components | The total number of components that will be created for this Landscape. |
| 13 | Fill World | Makes your Landscape as big as possible. |
| 14 | Create | Creates your Landscape in the world using the settings you specified. |

You can paint a landscape in Photoshop or write your own program to generate images to import.

To learn more about Landscape Components, refer to [**Landscape Technical Guide**](https://docs.unrealengine.com/landscape-technical-guide-in-unreal-engine/).

## Sculpt Tools

Using the **Sculpt** tools you can change the height of the terrain to create valleys, hills, mountains, and other features. You can utilize different layers to isolate areas or separate broad sculpting changes from finer details. To create a new layer or configure existing layers, right-click in the Edit Layers section.

[![The selection of sculpt tools available](https://dev.epicgames.com/community/api/documentation/image/e8fbbc29-5446-405d-9a87-0ac2e809423b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8fbbc29-5446-405d-9a87-0ac2e809423b?resizing_type=fit)

| Tool | Operation | GIF |
| --- | --- | --- |
| [**Sculpt**](https://docs.unrealengine.com/BuildingWorlds/Landscape/Editing/SculptMode/Sculpt/) | Raise the terrain by left-clicking and moving the mouse within the selected layer. Additionally, hold shift pressed to lower the terrain. | [Raises and lowers the terrain](https://dev.epicgames.com/community/api/documentation/image/248211a0-8a88-425e-a852-18f773e11e05?resizing_type=fit) |
| **Erase** | Reset sculpting changes within the selected layer. | [Resets  terrain sculpting](https://dev.epicgames.com/community/api/documentation/image/e833a958-9b0f-4162-85a3-e3f6829ffa9b?resizing_type=fit) |
| [**Smooth**](https://docs.unrealengine.com/BuildingWorlds/Landscape/Editing/SculptMode/Smooth/) | Smooths out the sculpting changes within the selected layer. Depending on the brush falloff settings, edges of the selected terrain flatten around the edges of the brush. | [Smooths the terrain](https://dev.epicgames.com/community/api/documentation/image/95e2f031-5b3c-4bdc-aa64-380ef327c593?resizing_type=fit) |
| [**Flatten**](https://docs.unrealengine.com/BuildingWorlds/Landscape/Editing/SculptMode/Flatten/) | Flattens the terrain in the selected layer based on the height of the initial left-click position. | [Flattens the terrain](https://dev.epicgames.com/community/api/documentation/image/a1f30bc1-3296-4a19-954b-9fb5a65d7191?resizing_type=fit) |
| [**Ramp**](https://docs.unrealengine.com/BuildingWorlds/Landscape/Editing/SculptMode/Ramp/) | Select two points on the terrain and press **Add Ramp** in the tool settings to create a ramp within the selected layer. | [Creates a ramp](https://dev.epicgames.com/community/api/documentation/image/32405782-315b-4ee3-825e-6acec30abe9f?resizing_type=fit) |
| [**Erosion**](https://docs.unrealengine.com/BuildingWorlds/Landscape/Editing/SculptMode/Erosion/) | Simulates erosion caused by the movement of soil within the selected layer. | [Simulates erosion by soil movement](https://dev.epicgames.com/community/api/documentation/image/30265ad2-e982-4493-bcf2-a4d0a3672d6f?resizing_type=fit) |
| [**Hydro**](https://docs.unrealengine.com/landscape-hydro-erosion-tool-in-unreal-engine/) | Simulates erosion caused by rainfall within the selected layer. | [Simulates erosion by rainfall](https://dev.epicgames.com/community/api/documentation/image/42fdccbc-11ce-4ee1-aa86-1e3403d47d94?resizing_type=fit) |
| [**Noise**](https://docs.unrealengine.com/BuildingWorlds/Landscape/Editing/SculptMode/Noise/) | Adds noise within the selected layer to randomly raise and lower the terrain and make it look more natural. | [Adds noise to the terrain](https://dev.epicgames.com/community/api/documentation/image/4dbbffa9-9f28-419c-be8e-2cf55caf4c51?resizing_type=fit) |
| [**Visibility**](https://docs.unrealengine.com/BuildingWorlds/Landscape/Editing/SculptMode/Visibility/) | Masks out individual quads in the Landscape to create holes, which is useful for creating caves or entrances to underground or hidden areas. | [Creates holes in the terrain](https://dev.epicgames.com/community/api/documentation/image/d6358efa-9de2-47b2-b449-f2d960d8409a?resizing_type=fit) |
| [**Mirror**](https://docs.unrealengine.com/BuildingWorlds/Landscape/Editing/SculptMode/Mirror/) | Copies one side of the selected layer to the other side to easily create a mirrored terrain. |  |
| [**Select**](https://docs.unrealengine.com/landscape-region-selection-tool-in-unreal-engine/) | Select a region of landscape to use as a mask for other tools, such as **Copy** or **Mirror**. |  |
| [**Copy**](https://docs.unrealengine.com/BuildingWorlds/Landscape/Editing/SculptMode/CopyPaste/) | Copy and paste areas of the terrain. You can also import and export a copied area of terrain to disk or from disk. |  |

Various Sculpt and Paint tools are brush based, and share common options.

| Image | Brush | Effect |
| --- | --- | --- |
| [Circular Brush](https://dev.epicgames.com/community/api/documentation/image/5c3634a5-24f1-4c5e-bac7-19084ec05a1a?resizing_type=fit) | Circular Brush Type | Creates a circular, rounded terrain. |
| [Alpha Brush](https://dev.epicgames.com/community/api/documentation/image/c918775b-1ff6-487a-9d4a-c08ecada8b78?resizing_type=fit) | Alpha Brush Type | Orients a mask image with a brush stroke. |
| [Pattern brush](https://dev.epicgames.com/community/api/documentation/image/5cf6f038-2b66-4e76-bf41-708999644ba1?resizing_type=fit) | Pattern Brush Type | Patterns a tile mask across the terrain. |
| [Entire Landscape brush](https://dev.epicgames.com/community/api/documentation/image/1e257b89-2025-4f07-a5f7-a5f28a03760d?resizing_type=fit) | Component Brush Type | Applies the change to the entire Landscape component. |
| [Smooth Falloff brush](https://dev.epicgames.com/community/api/documentation/image/1b2ea56c-3009-439e-9bd6-7628e02ec504?resizing_type=fit) | Smooth Brush Falloff | Results in a smooth falloff along the edges of the brush. |
| [Sharp Falloff brush](https://dev.epicgames.com/community/api/documentation/image/66c00c70-7992-47a8-8243-81bf2661518a?resizing_type=fit) | Sharp Brush Falloff | Results in a sharp falloff along the edges of the brush.. |
| [Spherical Falloff brush](https://dev.epicgames.com/community/api/documentation/image/209902b1-20ac-4ba5-a4f5-a0e17a16ece5?resizing_type=fit) | Spherical Brush Falloff | Results in a smooth falloff between the center and the edges of the brush. |
| [Tip Falloff brush](https://dev.epicgames.com/community/api/documentation/image/8ecfe727-3765-4bf4-a094-6fa2e349c098?resizing_type=fit) | Tip Brush Falloff | Results in an inverted smooth falloff along the edges of the brush. |

The Brush Falloffs can only be used with the Circular Brush Type.

Test the sculpt brush settings to find the right amount of falloff, strength, and brush size to create mountains, hills, paths, and more. Try using small semi-circular motions to introduce variation in your terrain.

[![Sculpt options available in the Sculpt tools in Landscape Mode.](https://dev.epicgames.com/community/api/documentation/image/363d5eaa-329e-4e09-8fa9-0bcd0466135e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/363d5eaa-329e-4e09-8fa9-0bcd0466135e?resizing_type=fit)

| Number | Option | Description |
| --- | --- | --- |
| 1 | Brush Type | The different types of brushes available. |
| 2 | Brush Falloff | The different falloffs you can apply to the brush. |
| 3 | Tool Strength | Strength of the brush. |
| 4 | Brush Size | The radius of the brush. |
| 5 | Brush Falloff | The amount of falloff at the edge of the brush, as a fraction of the brush’s size:   - 0= no falloff - 1= all falloff |
| 6 | Use Clay Brush | The Clay Brush works by looking at the average direction of all of the faces that are under the mouse and then moving the vertices in the averaged direction.  Because of this the Clay Brush is very good at filling in gaps and creating holes in the Landscape.  So when you switch to the Clay Brush you reduce the "spiky" appearance of the terrain at the edge of the path and instead sculpt the slope by keeping the slope direction as if adding a layer of clay. |

### Smooth Sculpt Tools

These are the additional tools that become available when **Smooth** is selected.

[![The Smooth sculpt tool settings.](https://dev.epicgames.com/community/api/documentation/image/1be49bc1-620e-4a7c-8884-e02af94efa5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1be49bc1-620e-4a7c-8884-e02af94efa5b?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Combined Layer Operation** | Operation applies to all the layers. |
| **Filter Kernel Radius** | The radius smoothing is performed over higher values smooth out bigger details, lower values only smooth out smaller details. |
| **Detail Smooth** | Larger detail smoothing values remove more details, while smaller values preserve more details. |

### Flatten Sculpt Tools

These are the additional tools that become available when **Flatten** is selected.

[![The Flatten sculpt tool settings.](https://dev.epicgames.com/community/api/documentation/image/8519a729-02ca-43a6-827f-cc824d101c71?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8519a729-02ca-43a6-827f-cc824d101c71?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Flatten Target** | Target height to flatten towards (in [Unreal Units](unreal-editor-for-fortnite-glossary#unreal-units).) |
| **Combined Layers Operation** | Operation applies to all the layers. |
| **Flatten Mode** | Whether to flatten by lowering, raising, both, or by terracing. |
| **Use Slope Flatten** | Flattens to the angle of the clicked point, instead of horizontal. |
| **Pick Value Per Apply** | Constantly picks new values to flatten towards when dragging around, instead of only using the first clicked point. |
| **Show Preview Grid** | Whether to show the preview grid for the flatten target height. |
| **Terrace Interval** | Height of the terrace intervals in Unreal Units, for the terrace flatten mode. |
| **Terrace Smoothing** | Smoothing value for terrace flatten mode. |

### Ramp Sculpt Tools

These are the additional tools that become available when **Ramp** is selected.

[![The Ramp sculpt tool settings.](https://dev.epicgames.com/community/api/documentation/image/5d8e0732-7d7b-4b7b-8f2c-f58f40dfd56b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5d8e0732-7d7b-4b7b-8f2c-f58f40dfd56b?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Reset** | Resets the ramp gizmo to allow you to drag out another gizmo. |
| **Add Ramp** | Adds a ramp to the terrain in the selected area.  This tool applies a one off change to the terrain. To create roads, paths, and more that you can keep editing, use the **Splines** tools in the **Manage** section instead. |
| **Combined Layers Operations** | Operation applies to all the layers. With this option enabled the ramp will be painted exactly where the gizmo appears but when it's disabled, the ramp will be added on to the layer underneath. |
| **Ramp Width** | Determines the width of the ramp. |
| **Side Falloff** | Determines the size of the falloff on the side of the ramp. |

### Erosion Sculpt Tool

These are the additional tools that become available when **Erosion** is selected.

[![The Erosion sculpt tool settings.](https://dev.epicgames.com/community/api/documentation/image/618def5c-2d60-405a-abcf-9ed55b5d3788?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/618def5c-2d60-405a-abcf-9ed55b5d3788?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Combined Layer Operation** | Operation applies to all the layers. |
| **Threshold** | The minimum height difference necessary for the erosion effects to be applied. Smaller values will result in more erosion being applied. |
| **Surface Thickness** | The thickness of the surface for the layer weight erosion effect. |
| **Iterations** | Number of erosion iterations, more means more erosion but is slower. |
| **Noise Mode** | Whether to erode the terrain by raising, lowering, or both. |
| **Noise Scale** | The size of the perlin noise filter. |

### Hydro Sculpt Tools

These are the additional tools that become available when **Hydro** is selected.

[![The Hydro sculpt tool settings.](https://dev.epicgames.com/community/api/documentation/image/a041a47b-2acb-48b6-9b5c-28fdc1170ff6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a041a47b-2acb-48b6-9b5c-28fdc1170ff6?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Combined Layer Operation** | Operation applies to all the layers. |
| **Rain Amount** | The amount of rain to apply to the surface. Larger values will result in more erosion. |
| **Sediment Cap** | The amount of sediment that the water can carry. Larger values will result in more erosion. |
| **Iterations** | Number of hydro iterations, more means more erosion but is slower. |
| **Initial Rain Distribution** | Determines whether the rain is applied randomly to some areas and not others or applied to the entire area. |
| **Rain Dist. Scale** | The size of the noise filter for applying initial rain to the surface. |
| **Detail Smooth** | Larger detail smoothing values remove more details, while smaller values preserve more details. |

### Noise Sculpt Tools

These are the additional tools that become available when **Noise** is selected.

[![The Noise sculpt tool settings.](https://dev.epicgames.com/community/api/documentation/image/fa5919b4-5990-4cdb-bdc5-ad7802d59141?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fa5919b4-5990-4cdb-bdc5-ad7802d59141?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Noise Mode** | Whether to apply noise that raises, lowers, or both. |
| **Noise Scale** | The size of the perlin noise filter used. |

### Mirror Sculpt Tools

These are the additional tools that become available when **Mirror** is selected.

[![The Mirror sculpt tool settings.](https://dev.epicgames.com/community/api/documentation/image/2d0ecb0a-e718-4d9e-aec9-4033f095c5bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d0ecb0a-e718-4d9e-aec9-4033f095c5bc?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Mirror Point** | Location of the mirror plane, defaults to the center of the landscape. This doesn’t normally need to be changed. |
| **Operation** | Type of operation to perform, for example, "Minus X To Plus X" copies and flips the - X half of the landscape onto the +X - half. |
| **Recenter** | Recenters the Mirror Point. |
| **Apply** | Applies the mirror sculpt to the select area on the terrain. |
| **Smoothing Width** | Number of vertices either side of the mirror plane to smooth over, |

### Select Sculpt Tools

These are the additional tools that become available when **Select** is selected.

[![The Select sculpt tool settings.](https://dev.epicgames.com/community/api/documentation/image/a76af163-05aa-4ec5-b1a0-b53fb5f336e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a76af163-05aa-4ec5-b1a0-b53fb5f336e0?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Clear Region Selection** | Clears the selected region from the tool. |
| **Use Region as Mask** | Uses the region as a mask for other tools, such as the Copy sculpt tool, or Mirror sculpt tool. |
| **Negative Mask** | If enabled, protects the selected region from changes. If disabled, only allows changes in the selected region. |

### Copy Sculpt Tools

These are the additional tools that become available when **Copy** is selected.

[![The Copy sculpt tool settings.](https://dev.epicgames.com/community/api/documentation/image/e8ee6d1c-905a-4fb8-ae43-7d6b65ee79cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8ee6d1c-905a-4fb8-ae43-7d6b65ee79cb?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Copy Data to Gizmo** | Copies the terrain data within the gizmo bounds, taking into account any masking from selected regions. |
| **Fit Gizmo to Selected Regions** | Positions and resizes the gizmo so that it completely encompasses all region selections. |
| **Fit Height Values to Gozmo Size** | Scales the data in the gizmo to fit the gizmo’s Z size. |
| **Clear Gizmo Data** | Clears the gizmo of any copied data. |
| **Paste Mode** | Whether pasting terrain data will raise, lower, or both, when pasted. |
| **Gizmo copy/paste all layers** | If set, copies/pastes all layers, otherwise only copy/pastes the layer selected in the targets panel. |
| **Snap Gizmo to Landscape Grid** | Determines whether to snap the gizmo to the component or the texel. |
| **Use Smooth Gizmo Brush** | Smooths the edges of the gizmo data into the landscape. Without this, the edges of the data will be sharp. |
| **Advanced > Gizmo Import / Export** | Set of advanced tools that display when Copy is selected. The tools include:   - Heightmap - Heightmap Size - Layers - Import - Export |
| **Heightmap** | Type a Gizmo Heightmap Filename String. Can select a folder on disk to save the heightmap data. |
| **Heightmap Size** | Determines the heightmap size for the gizmo’s import size. |
| **Layers** | Select the layers for import based on the gizmo's import layers. |
| **Import** | Imports a new heightmap |
| **Export** | Exports the current heightmap for the terrain in the viewport. |

Refer to [**Landscape Sculpt Mode**](https://docs.unrealengine.com/landscape-sculpt-mode-in-unreal-engine/) for more information on sculpting landscapes.

## Paint Tools

**Paint** weight data to blend between different layers of the assigned Landscape material. Similar to the Sculpt tools, weight data can be created in different edit layers. In addition, the weight data will be painted for the selected material layer. For example, painting weight with the Sand layer selected will paint sand onto the terrain. The order of the material layers determines their visibility meaning that if an upper material layer is painted it might hide a lower material layer.

[![The selection of tools available under Paint](https://dev.epicgames.com/community/api/documentation/image/f5f8b6e3-2c91-4713-9a2a-4662e33f1bfb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f5f8b6e3-2c91-4713-9a2a-4662e33f1bfb?resizing_type=fit)

- **Paint:** Paints weights within the selected layer. Holding shift while painting removes the weights.
- **Smooth:** Smooths weights within the selected layer.
- **Flatten:** Flattens the weights within the selected layer based on the weight of the initial left-click position.
- **Noise:** Adds noise to the weights within the selected layer to randomly increase or decrease the weights and make it look more natural.

Create more customization with the paint brushes by using the different brush and tool settings in the Landscape panel when **Paint** is selected. Settings available in the Landscape panel depend upon which Paint tool is selected for use. See below for tool settings for:

- [Smooth](https://dev.epicgames.com/documentation/en-us/fortnite/landscape-mode-in-unreal-editor-for-fortnite)
- [Flatten](https://dev.epicgames.com/documentation/en-us/fortnite/landscape-mode-in-unreal-editor-for-fortnite)
- [Noise](https://dev.epicgames.com/documentation/en-us/fortnite/landscape-mode-in-unreal-editor-for-fortnite)

[![The manage options are used to create a landmass.](https://dev.epicgames.com/community/api/documentation/image/59da2784-9698-4aad-9205-1664004321b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/59da2784-9698-4aad-9205-1664004321b6?resizing_type=fit)

| Number | Option | Description |
| --- | --- | --- |
| 1 | Brush Type | The different types of brushes available. |
| 2 | Brush Falloff | The different styles of falloff you can apply to the brush. |
| 3 | Tool Strength | Strength of the brush. |
| 4 | Use Target Value | Enable to make tools bend towards a target value. |
| 5 | Brush Size | The radius of the brush. |
| 6 | Brush Falloff | The falloff at the edge of the brush, as a fraction of the brush’s size:   - 0= no falloff - 1= all falloff |
| 7 | Edit Layers | Names of the edit layers and their alpha blending values that determine how strongly they affect the overall result. |
| 8 | Painting Restriction | Limits painting to only the components that already have data in the selected material layer. |
| 9 | Target Layers | Available material layers. |

### Smooth Tools

These are the additional tools that become available when **Smooth** is selected.

[![The Smooth tool settings.](https://dev.epicgames.com/community/api/documentation/image/8561a855-d6c7-4508-92b6-1ab1b894d63c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8561a855-d6c7-4508-92b6-1ab1b894d63c?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Filter Kernel Radius** | The radius smoothing is performed over higher values to smooth out bigger details, lower values only smooth out smaller details. |
| **Detail Smooth** | Larger detail smoothing values remove more details, while smaller values preserve more details. |

### Flatten Tools

These are the additional tools that become available when **Flatten** is selected.

[![The Flatten tool settings.](https://dev.epicgames.com/community/api/documentation/image/60e586c9-2388-4f76-bc5a-b11f113df8fb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/60e586c9-2388-4f76-bc5a-b11f113df8fb?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Flatten Mode** | Whether to flatten by lowering, raising, both, or terracing. |

### Noise Tools

These are the additional tools that become available when **Noise** is selected.

[![The Noise tool settings.](https://dev.epicgames.com/community/api/documentation/image/9900a3d4-2e37-469d-936c-c62ffe971b7b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9900a3d4-2e37-469d-936c-c62ffe971b7b?resizing_type=fit)

| Option | Description |
| --- | --- |
| **Noise Mode** | Whether to apply noise that raises, lowers, or both. |
| **Noise Scale** | The size of the perlin noise filter used. |

Refer to [**Landscape Paint Mode**](https://docs.unrealengine.com/landscape-paint-mode-in-unreal-engine) for more information on painting landscapes.
