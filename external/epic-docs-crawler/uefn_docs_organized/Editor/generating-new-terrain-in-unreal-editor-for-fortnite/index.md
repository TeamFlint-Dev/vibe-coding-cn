# Generating New Terrain

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/generating-new-terrain-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:18:29.319030

---

When creating your own terrain, consider what type of landscape works best for the island you want to build. In [Landscape Mode](unreal-editor-for-fortnite-glossary#landscape-mode), you can determine the size of the terrain, or even create multiple pieces of terrain using smaller sections.

Select the **Blank** island template from the Project Browser screen.

[![select the Blank island template](https://dev.epicgames.com/community/api/documentation/image/77edb26b-57eb-4bd8-992b-f6ad2acd936f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/77edb26b-57eb-4bd8-992b-f6ad2acd936f?resizing_type=fit)

Once the project opens, delete the existing [grid plane](unreal-editor-for-fortnite-glossary#grid-plane) by clicking a grid then pressing the **Delete** key. Repeat for any remaining grid planes.

## Create a Landscape Streaming Proxy

Once you've removed the grid plane, it is replaced by a [Landscape Streaming Proxy](unreal-editor-for-fortnite-glossary#landscape-streaming-proxy). This proxy can be edited with the Landscape Mode tools to build a custom landscape, unlike the grid plane, that will only let you place objects on it.

To create a new terrain using Landscape Mode, click the **Select Mode** dropdown menu and select **Landscape Mode**. The **Manage** tools automatically open with **New** selected in the Landscape Mode panel.

[![Select Landscape Mode from the dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/f47c9030-8533-4bd0-b1f9-186eeb5b65f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f47c9030-8533-4bd0-b1f9-186eeb5b65f4?resizing_type=fit)

The properties inside the **New** tool determine the basic characteristics of the new terrain:

- Material
- Location, rotation, and scale
- Sections, components, and resolution

  The section and component properties affect the overall resolution of the terrain. If you are not sure about these settings, change the Overall Resolution property directly.

To create a new terrain from the **New** tool panel, click **Create New** at the top. Use the following dimensions for your landscape area, and click the **Create** button when you're finished.

|  |  |  |
| --- | --- | --- |
| **Option** | **Value** | **Explanation** |
| **World Partition Grid Size** | **9** | This controls the number of components (functionality added to the Landscape Actor) per landscape streaming proxies per axis. [INCLUDE:#new] |
| **Section Size** | **63 x 63** | This creates a terrain that is larger than the original grid plane in the viewport. |
| **Sections Per Component** | **1 x 1** | This reduces the size of the landscape sections and creates more sections simultaneously. |
| **Number of Components** | **8 x 8** | The number of components in the X and Y axis directions (1-32 for each axis). |
| **Overall Resolution** | **505 x 505** | The **Total Components** are automatically calculated for your terrain based upon the component information you entered above. [INCLUDE:#components] |

[![The terrain base.](https://dev.epicgames.com/community/api/documentation/image/09bad6b9-dce6-4bd9-a127-9d021cca555c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/09bad6b9-dce6-4bd9-a127-9d021cca555c?resizing_type=fit)

*Click to enlarge image.*

This creates a flat terrain, and the **Landscape Mode** tools automatically switch to the [Sculpt tools](https://dev.epicgames.com/documentation/en-us/unreal-engine/landscape-sculpt-tool-in-unreal-engine) after you click **Create**. These are the tools you’ll use to sculpt mountains, hills, and valleys.

If you want to set up a terrain with the largest possible size, click **Fill World** > **Create** at the bottom of the **New** tool panel. The size limit to Fill World is the equivalent of **2K x 2K**.

Continue making your custom terrain by learning how to use the [Sculpt tools](https://dev.epicgames.com/documentation/en-us/fortnite/sculpting-the-terrain-in-unreal-editor-for-fortnite).

## Next Section

[![Sculpting the Terrain](https://dev.epicgames.com/community/api/documentation/image/fe35f9c9-639d-484d-b40d-f0ee563a54a9?resizing_type=fit&width=640&height=640)

Sculpting the Terrain

Learn how to sculpt a custom terrain.](<https://dev.epicgames.com/documentation/en-us/fortnite/sculpting-the-terrain-in-unreal-editor-for-fortnite>)
