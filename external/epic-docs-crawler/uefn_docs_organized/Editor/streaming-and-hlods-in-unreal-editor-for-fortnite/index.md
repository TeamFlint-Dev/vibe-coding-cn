# Streaming and HLODs

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/streaming-and-hlods-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:17:37.132176

---

[World Partition](unreal-editor-for-fortnite-glossary#world-partition) paves the way for creators to build large and complex islands, and enables them to do so while [improving memory](memory-management-in-unreal-editor-for-fortnite) costs and ensuring smooth performance across different platforms.

Two important components that World Partition uses to make this possible are **Streaming** and **HLODs (Hierarchical Level of Detail)**.

## Streaming

World Partition uses **Streaming** to load grid cells around a player, or [streaming source](unreal-editor-for-fortnite-glossary#streaming-source), in and out of memory. This reduces the amount of data that your machine has to remember to the cells surrounding a player character.

[![Streaming Grid](https://dev.epicgames.com/community/api/documentation/image/b996adac-7e52-480e-ae8d-d95d7ba0760f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b996adac-7e52-480e-ae8d-d95d7ba0760f?resizing_type=fit)

If the island exceeds 1 km at it's widest axis, you will see a popup prompting you to turn on Streaming.

[![Prompt to enable streaming](https://dev.epicgames.com/community/api/documentation/image/c72afd5e-5b6c-45fe-8b69-2c1f796a4260?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c72afd5e-5b6c-45fe-8b69-2c1f796a4260?resizing_type=fit)

Checking **Enable Streaming** makes only the cells surrounding the player's current position count toward the **Current Memory Usage**, with a few exceptions.

[![current memory usage](https://dev.epicgames.com/community/api/documentation/image/c17dd1a5-fb27-4dff-b9f9-db8f250d5f59?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c17dd1a5-fb27-4dff-b9f9-db8f250d5f59?resizing_type=fit)

Click **Window** > **World Settings** to see if **Enable Streaming** is enabled.

[![Enable Streaming](https://dev.epicgames.com/community/api/documentation/image/aaa44941-2723-45fa-bfec-08ff0d267134?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aaa44941-2723-45fa-bfec-08ff0d267134?resizing_type=fit)

When you check the box for the first time, you will have to confirm your selection.

[![dialog enable streaming](https://dev.epicgames.com/community/api/documentation/image/fc788148-ca55-4264-bb04-bb78e3e26a77?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc788148-ca55-4264-bb04-bb78e3e26a77?resizing_type=fit)

Your project should now have streaming enabled.

To visualize the grid for your island, check **Preview Grids** in World Settings.

[![Preview Grids Check box](https://dev.epicgames.com/community/api/documentation/image/1cfef81f-1bb4-45ea-b934-af0f3819b8e7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1cfef81f-1bb4-45ea-b934-af0f3819b8e7?resizing_type=fit)

You can modify the size of each cell and the loading range, but keep in mind that the default settings are optimized for Fortnite Battle Royale-sized islands.

For more in-depth information, see the [World Partition](https://docs.unrealengine.com/5.0/en-US/world-partition-in-unreal-engine/) page in the Unreal Engine 5 documentation..

## HLODs

**Hierarchical Level of Detail** or **HLOD** is an optimized grouping of nearby [actors](unreal-editor-for-fortnite-glossary#actor) where the group is simplified into one static mesh once it is far enough away from the streaming source.

HLODs are generated from the asset's lowest fidelity Level of Detail (LOD). If your custom assets have no set [LODs](setting-the-level-of-detail-in-unreal-editor-for-fortnite), the HLOD will be very costly as it will be generated from full resolution assets.

LOD0 is the highest fidelity asset. LOD1 is a lower fidelity mesh, and keeps getting lower as the LOD number increases.

|  |  |
| --- | --- |
| [No HLOD](https://dev.epicgames.com/community/api/documentation/image/b184781b-d7e7-43c6-a118-fa6fa01de504?resizing_type=fit) | [Yes HLOD](https://dev.epicgames.com/community/api/documentation/image/dbed1419-a546-4ce1-9cc0-205395a80d22?resizing_type=fit) |

The image on the left shows the assets in full detail, and the one on the right is an HLOD asset
generated from that grid cell.

Building HLODs adds new assets to your project, which adds to your island's total memory usage.

Based on your decisions regarding Streaming and HLODs, memory usage is impacted in the following ways:

|  |  |  |
| --- | --- | --- |
| **Streaming OFF** | Assets are never unloaded from memory and HLODs are not used. | **Highest memory usage** |
| **Streaming ON** and **HLODs generated** | Assets will still appear at a distance, but in lesser detail as the camera moves further away. | **Moderate memory usage** |
| **Streaming ON** and **HLODs not generated** | Assets will disappear at a distance, as the camera moves further away. | **Lowest memory usage** |

### Build HLODs

To build HLODs, ensure that your project has **Streaming** enabled, then go to **Build** in the toolbar and select **Build HLODs**.

[![Build HLODs](https://dev.epicgames.com/community/api/documentation/image/7a7305d0-5d5c-4468-b759-3445737e5e9a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a7305d0-5d5c-4468-b759-3445737e5e9a?resizing_type=fit)

Depending on your machine and on the complexity of your world, building HLODs can potentially take a while. The good news is that if you run this process again, it will only build HLODs for regions of your world that have changed, and so will take less time.

To learn more about how HLODs work, check out the [World Partition - Hierarchical Level of Detail](https://docs.unrealengine.com/5.0/en-US/world-partition---hierarchical-level-of-detail-in-unreal-engine/) page in the Unreal Engine 5 documentation.

### Exclude Assets from Generating HLODs

Some assets will not require HLODs. Here are some examples of assets you can exclude:

|  |  |
| --- | --- |
| **Indoor props and building assets** | Any asset that can't be seen from a distance should not require HLODs. Examples include furniture, indoor walls, interior floors, etc. |
| **Underground assets** | Any part of the island that is underground and will never be in a player's line of sight. Examples include basements, caves, trenches, bunkers, and so on. |
| **Small actors** | Small actors that don't take up a big part of the player's screen should not require HLODs. Examples include boxes, plants, and street lamps. |
| **Large actors** | Any large background actors like skyscrapers or mountains do not need HLODs. If you exclude them from HLODs, make sure that they always stay loaded by unchecking **Is Spatially Loaded** in the **Details** panel. |

Select any asset that will not require HLODs. In the **Details** panel, uncheck **Include Actor in HLODs** or **Include Component in HLODs**, depending on the asset.

[![include in HLOD](https://dev.epicgames.com/community/api/documentation/image/d83bc17a-fd05-4560-ab6d-9ff5208a56c9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d83bc17a-fd05-4560-ab6d-9ff5208a56c9?resizing_type=fit)

A good rule of thumb for deciding whether to include an asset in HLODs is to zoom out in the editor, then see if it makes sense to exclude any unimportant assets from generating HLODs.

### Push Back Loading Range

The quality of HLODs is tied to their expected [draw distance](unreal-editor-for-fortnite-glossary#draw-distance). When using streaming, the shortest distance at which your HLODs will be seen is the loading range you configured for your World Partition grid.

If HLODs only load when they are already small on the player's screen, they will take up less storage.

To change the loading range:

1. Select the **World Partition Setup** tab.
2. Expand **Runtime Settings**, then expand **Grids**.
3. Modify the loading range by left-clicking and dragging the number value to the left or to the right, or by entering an exact value.

   [![expand grids](https://dev.epicgames.com/community/api/documentation/image/eaf23cf6-053c-45fa-90c6-492a6c8a13a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eaf23cf6-053c-45fa-90c6-492a6c8a13a5?resizing_type=fit)

## Use Loading Regions for Better Editor Performance

When working on large projects in UEFN, you might start to notice performance issues appearing as your island reaches a certain size. By default, your entire island is loaded into memory. To improve the framerate and viewport responsiveness, you can **load and unload** regions when working on different areas of your island.

When working on a large or dense island in the UEFN editor, use the World Partition minimap to **load and unload** sections of the island, drastically reducing load times.

To do this:

1. Make sure that **Streaming** is enabled on your level.
2. Select **Edit** from the Menu Bar, then choose **Editor Preferences...**

   [![Editor Preferences](https://dev.epicgames.com/community/api/documentation/image/2940cf01-a50b-4650-9576-6de2b1a9bd2b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2940cf01-a50b-4650-9576-6de2b1a9bd2b?resizing_type=fit)
3. Go to the **World Partition** section and uncheck the "Disable Loading in Editor".

   [![disable loading](https://dev.epicgames.com/community/api/documentation/image/1c030007-a905-4a3d-88cc-269b282ac269?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c030007-a905-4a3d-88cc-269b282ac269?resizing_type=fit)
4. Reload your project. This feature will not work unless the project is reloaded!
5. In the **World Partition** tab, left-click and drag across the area you would like to unload.
6. Right-click inside the selection, and choose **Unload Selected Regions**.
7. To reload a region, click and drag across the desired region, right-click and select **Load Region From Selection**

   [![Gif of minimap load and unload](https://dev.epicgames.com/community/api/documentation/image/1ec6e221-f2d7-4317-8184-d7c01d172601?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1ec6e221-f2d7-4317-8184-d7c01d172601?resizing_type=fit)

Be aware that all **landscape** and **devices** will not be affected by loading and unloading. The same goes for any asset that has "Is Spatially Loaded" unchecked in the **User Options**.

## Data Layers in UEFN

Data Layers are a system in UEFN that organizes your Actors into different layers. These layers can be loaded and unloaded to organize your world, manage complex levels, and create unique gameplay experiences. Imagine a game with randomized levels. By setting different level layouts on different layers and randomly selecting one when the game starts, you can add variety and excitement to your experience. You can use data layers for even larger transitions, for instance changing an entire level from summer to winter or adding destruction to a castle after a battle.

For more detailed information on creating and managing data layers, see the data layers page on the [Unreal Engine Documentation site](https://docs.unrealengine.com/5.2/en-US/world-partition---data-layers-in-unreal-engine/)

### Manipulating Data Layers using Cinematic Sequencer

You can use the Cinematic Sequence in UEFN to load, activate, and unload data layers at runtime and in response to events.

In the **Sequencer** tab, click on the **Track** button and select **Data Layer** to add an existing Data Layer to your sequencer track.

[![Add Data Layer to Sequencer Track](https://dev.epicgames.com/community/api/documentation/image/2ec49fc7-5a17-4fdb-aecd-f6061c55fb32?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2ec49fc7-5a17-4fdb-aecd-f6061c55fb32?resizing_type=fit)

With the track set, right-click on the **Data Layer** track and select **Edit Section**. Then click **Add Element** under the **Data Layer Assets** tab and select the data layer you want to use with the cinematic sequencer.

[![Edit Data Layer Section](https://dev.epicgames.com/community/api/documentation/image/3dee7a74-e32a-4bd4-b686-409327a13675?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3dee7a74-e32a-4bd4-b686-409327a13675?resizing_type=fit)

If you right-click your data layer on the timeline, you can view its properties. Here you can choose the **Desired State**, the state you want the layer to be in when the timeline evaluates. You can also modify the **Preroll State**. The **Preroll** state is the state the layer is in before the track starts, and the **Postroll** state is the state after it ends. For instance, if you wanted to activate a data layer, you would set the desired state to **Activated**, and the preroll state to **Loaded**. Setting the preroll state to **Loaded** and increasing the number of preroll frames will give your layer more time to load before it activates, and may lead to smoother performance.

[![Edit Sequencer Properties](https://dev.epicgames.com/community/api/documentation/image/6f6c6f52-729a-41d2-a4f6-b3d83b62141f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6f6c6f52-729a-41d2-a4f6-b3d83b62141f?resizing_type=fit)

By moving the playhead, you can preview the state your layer will be in as the timeline evaluates.

To learn more about using the cinematic sequencer device, [see the Cinematic Sequencer Device page](cinematic-sequence-device-in-unreal-editor-for-fortnite).

## Generate the Editor Minimap

An optional step is to generate a high fidelity minimap in your editor session. This can help you quickly find the various areas of the level that you want to work on.

1. Select **Build** from the Menu Bar, then choose **Build World Partition Editor Minimap**.

   [![Build Minimap](https://dev.epicgames.com/community/api/documentation/image/753dff65-6f72-4281-a962-35bcfe8f4e8f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/753dff65-6f72-4281-a962-35bcfe8f4e8f?resizing_type=fit)
2. A **Build Status** dialog will appear on your screen. Be patient, as this step may take several minutes to complete depending on the complexity of your island.

   [![Build Status](https://dev.epicgames.com/community/api/documentation/image/72150a00-3b7b-4cef-83ac-672331ce2c0d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/72150a00-3b7b-4cef-83ac-672331ce2c0d?resizing_type=fit)
3. Your minimap now matches your viewport. Regions can still be loaded and unloaded in the same way.

## Troubleshooting

#### Q: Why can't I see any HLODs after having built them ?

**A**: HLOD actors aren't loaded by default by the editor. To inspect them, use the **Outliner** to search for and **Pin** them.

[![HLOD pin](https://dev.epicgames.com/community/api/documentation/image/00cf99e1-c045-4d40-84b4-c06e9f6fb048?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00cf99e1-c045-4d40-84b4-c06e9f6fb048?resizing_type=fit)

#### Q: Why are assets generating HLODs when actors are far from each other?

**A**: Check to see if actors are attached/nested under a parent actor. Click the actor and select **Attach: none** to detach them.

#### Q: Some of my important assets disappear when the cells are unloaded

**A**: Certain UEFN-ready assets will not have **Include Actor in HLOD** checked by default. If you're seeing issues, check the asset's properties.

#### Q: Why is the Streaming prompt triggered when my island does not exceed 1 km?

**A**: The Streaming prompt may be triggered if your landscape exceeds 1 km at its widest axis, or if any actor is located more than 1km from the point of origin on the level.

#### Q: Why is my large actor not being replaced by HLODs at a distance?

**A**: One or many of the actors in a prefab's hierarchy may have been copied and moved so far away that World Partition considers them as meshes that always need to be loaded. Remove the faraway actor(s) from hierarchy to fix this issue.
