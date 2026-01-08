# Memory Management

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/memory-management-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:17:11.485504

---

To help your islands run on all supported platforms, **Fortnite** has some memory limitations in place.

In **Unreal Editor for Fortnite (UEFN)**, you can use expanded memory capabilities to make larger and more diverse experiences. To fully take advantage of this, it helps to understand the way that memory use is calculated in UEFN.

## World Partition

**World Partition** is the magic behind building a large island experience. This feature automatically divides the world into a grid, and streams only the necessary cells.

[![world partition](https://dev.epicgames.com/community/api/documentation/image/0a907ed8-2039-4b8c-99ab-34d1b19f68de?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0a907ed8-2039-4b8c-99ab-34d1b19f68de?resizing_type=fit)

World Partition uses **Streaming**, which loads and unloads cells, and **Hierarchical Level of Detail (HLOD)**, that groups and decreases the amount of detail on assets as the player camera moves away.

For more information on World Partition, Streaming, and HLODs, see [Streaming and HLODs](https://dev.epicgames.com/documentation/en-us/fortnite/streaming-and-hlods-in-unreal-editor-for-fortnite).

## How Memory Gets Calculated

UEFN calculates memory use from data produced at cook  time. This means:

1. Fast results on large islands.
2. Consistent numbers every time you run the calculation on the same island version, Fortnite build and device.
3. Broad support for more asset types and for SceneGraph.

The memory calculation system in UEFN runs only at Edit time, and cannot be used to evaluate memory use at Play time. It is used to verify that the baseline memory use of an island does not exceed a reasonable threshold.

However, custom runtime logic can lead to high memory use that can cause issues for players, limiting their ability to play your island. We advocate using [Spatial Profiler](https://dev.epicgames.com/documentation/en-us/fortnite/spatial-profiler-in-unreal-editor-for-fortnite) to get a better idea of how your island uses memory and performs at Play time, to avoid causing stability or performance issues for your players.

## The Session Layout

[![New HUD Image](https://dev.epicgames.com/community/api/documentation/image/f05cc2c3-cb33-40cd-b168-549b001f4acf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f05cc2c3-cb33-40cd-b168-549b001f4acf?resizing_type=fit)

 When you load into your session, you see a **Current Memory Usage** bar on your HUD.

The bar shows a maximum of 100,000 memory units to give you a picture of the memory usage on your island.

With streaming enabled, memory is calculated based on the player's position on the island rather than the total memory used by all the assets on the island. Performing a [memory calculation](https://dev.epicgames.com/documentation/en-us/fortnite/memory-management-in-unreal-editor-for-fortnite) will give you the most accurate memory consumption values for each streaming cell.

Some assets will stay in memory regardless of the player's position, and will add to the memory usage anywhere in the map.
Most assets will load and unload as they stream in and out, and the bar will update to reflect this.

All assets referenced by the level (including **Devices**, **Landscapes**, custom **Meshes** and **Textures**, etc.) count toward total memory usage.

Note that if any area in your level exceeds 100,000, **you will not be able to publish your island**.

As a UEFN user, you can exceed the 100,000 thermometer limit as long as you don't publish. Keep in mind that people collaborating with you on a console might hit a hardware limit of available memory that will kick them out of the session. They can reconnect once the issue is resolved.

### Making Content Changes

The system requires up-to-date cooked data to calculate memory usage accurately. After you make content changes with [Live Edit](https://dev.epicgames.com/documentation/en-us/fortnite/live-edit) or the [Phone Tool](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#phone), you’ll see a **Push Changes** prompt even if the Edit Mode indicator shows **Up to Date**, because Live Edit does not refresh the cooked data used for memory calculations.

Until you push changes, the usage bar will continue to update but show an out-of-date value. The cost of content modifications will not be reflected.

[![](https://dev.epicgames.com/community/api/documentation/image/6976a790-1017-4b90-a7c8-55216dc1b625?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6976a790-1017-4b90-a7c8-55216dc1b625?resizing_type=fit)

## Launch a Memory Calculation

Your island needs to be able to run on all supported hardware platforms for you to successfully publish.

Before publishing, it is vital to make sure your project does not exceed memory limits. From the **Project** dropdown, select **Launch Memory Calculation**.

[![Launch Memory Calculation](https://dev.epicgames.com/community/api/documentation/image/a22a1fd5-e0d5-41e7-ac61-85abc0264329?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a22a1fd5-e0d5-41e7-ac61-85abc0264329?resizing_type=fit)

This process calculates the memory used in every cell.

1. A dialog box will prompt you to **Upload Private Version**. Click the button and observe the progress bar.

   [![Memory Calculation Dialog](https://dev.epicgames.com/community/api/documentation/image/3a28a29d-8d70-4f08-bb93-e74cb3778b64?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a28a29d-8d70-4f08-bb93-e74cb3778b64?resizing_type=fit)
2. Optionally, you can add a description for your project version.

   [![private version description](https://dev.epicgames.com/community/api/documentation/image/14e2be2c-1412-4bbf-aa16-0a3ae3a2c02b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/14e2be2c-1412-4bbf-aa16-0a3ae3a2c02b?resizing_type=fit)
3. A pop-up on the bottom of your screen will tell you that Memory calculation is in progress.

   [![Memory Calculation in progress](https://dev.epicgames.com/community/api/documentation/image/b0efb82c-6e7d-4a26-a106-b7afc55b8a09?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b0efb82c-6e7d-4a26-a106-b7afc55b8a09?resizing_type=fit)
4. Once the upload is complete, the pop-up changes to indicate that the Calculation is started.

   [![Memory Calculation is started](https://dev.epicgames.com/community/api/documentation/image/b3022c0a-da05-4812-97d6-4a52645984fa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3022c0a-da05-4812-97d6-4a52645984fa?resizing_type=fit)
5. In the client, the memory calculation result appears. Pressing **Continue** will return control of your player character.

   [![calculation result](https://dev.epicgames.com/community/api/documentation/image/f4b3cf32-b335-4cdf-853b-7af7c0347e51?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f4b3cf32-b335-4cdf-853b-7af7c0347e51?resizing_type=fit)
6. Once finished, the player character teleports back to the original location before calculation started and you’ll see one of two statuses:

   [![Calculation success](https://dev.epicgames.com/community/api/documentation/image/9c832d88-7342-42e9-a657-8be375111d9f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9c832d88-7342-42e9-a657-8be375111d9f?resizing_type=fit)

   [![Calculation over budget](https://dev.epicgames.com/community/api/documentation/image/ba1f6541-608f-4b60-bdcc-95d832f85e40?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba1f6541-608f-4b60-bdcc-95d832f85e40?resizing_type=fit)

If you have Streaming enabled on your project, you can now fly around to see the amount of space different areas take up.

If Streaming is enabled, the **Memory Used** bar changes during the flythrough. You can use this to identify the areas in the level that might be over budget.

If your island is over budget, you will need to fix the local memory issues before publishing.

## My Island Is Over Budget. What Can I Do?

There are many strategies to save on memory once you hit the limit. Try any combination of the following:

- After the memory calculation, you can open a sheet with top 100 memory-heavy assets on your island. Go to **Window** > **Message Log** > **Memory Test Results**.

  [![memory calculation results](https://dev.epicgames.com/community/api/documentation/image/4bfa0e8e-3538-46e1-a785-57bfd015cd1d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4bfa0e8e-3538-46e1-a785-57bfd015cd1d?resizing_type=fit)

  The table below defines each term:

  | Term | Explanation |
  | --- | --- |
  | **Resource** | This is usually the name of an asset in the Content Browser. Some resources may be displayed as “Fortnite Asset” - this is a name we assign to resources not authored in your project, but still add to the memory use of your island. |
  | **Type** | This is the type of resource/asset. Examples include Texture, Material, Level and more. |
  | **# Actor Refs** | The number of actors referencing the resource, directly or indirectly. |
  | **# Package Refs** | The number of cooked packages referencing the resource. This number will generally increase if a resource is referenced by multiple World Partition cells. |
  | **Size** | The size of the resource. This is the amount that a particular resource contributes to the Current Memory Usage bar at the sampled location. |

- Stream textures where possible. This means authoring textures to be streaming-friendly (power of two dimensions), and configuring the textures so mipmaps are generated. If textures can’t be streamed, they will always use the maximum amount of memory, regardless of how far away it is being used. More information can be found on [Resizing Textures](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite).
- **[Turn Streaming ON](https://dev.epicgames.com/documentation/en-us/fortnite/streaming-and-hlods-in-unreal-editor-for-fortnite)** in the World Partition panel. Although this is a must for large islands, smaller islands may also benefit from streaming, especially if the content gets too dense.
- When streaming is turned on, make sure that actors have Is Spatially Loaded enabled where possible. If not, they will be cooked into the main level package and will always be loaded. This is specially relevant for Landscape streaming proxy actors, as these can contain a lot of collision data that you generally want to stream in on demand.

  [![](https://dev.epicgames.com/community/api/documentation/image/8b32726b-ba15-429c-83eb-e3f1895e02cd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b32726b-ba15-429c-83eb-e3f1895e02cd?resizing_type=fit)
- Spread your island's content evenly. Concentrating too many actors in a small area will not allow content to be streamed out, and will contribute to exceeding your memory budget.
- **Reduce the number of devices your island is using**. Devices are among the most expensive actors you can place. However, placing instances of the same device incurs a much lower memory cost.
- Take a look at the Project Size window. If you see some memory-heavy objects on disk, chances are they’ll also be heavy on memory at runtime. To check your project size, click the **Project** dropdown and select **Project Size**.

  [![project size](https://dev.epicgames.com/community/api/documentation/image/e5015d53-1657-4bdc-aae4-4976310f4252?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e5015d53-1657-4bdc-aae4-4976310f4252?resizing_type=fit)
- [Reduce the quality level on custom asset LODs](setting-the-level-of-detail-in-unreal-editor-for-fortnite), especially on those assets that are only visible from a distance.
- **Reuse assets multiple times**. In a forest made of 100 trees, use 5 variations and duplicate them around instead of using 100 unique trees. This will make a huge difference on the memory footprint.
- If using [HLODs](https://dev.epicgames.com/documentation/en-us/fortnite/streaming-and-hlods-in-unreal-editor-for-fortnite), generate them throughout the process of the project and ensure that you're only generating them for objects you can see from far away.
- Make use of [Data Layers](https://dev.epicgames.com/documentation/en-us/fortnite/streaming-and-hlods-in-unreal-editor-for-fortnite) if your islands can be subdivided into configurations that aren't all meant to be displayed all at once. For example, an underground dungeon that isn't reachable unless the player enters a shrine.
- Lower the mesh complexity of your custom content. High-poly meshes incur a higher memory cost. Edit the mesh by double-clicking on it in the Content Browser, and adjust the **Keep Triangle Percent** value under **Nanite Settings**. Using a lower value will lower the complexity of the mesh and reduce the actor's memory cost.

  [![Lower Triangle Percent](https://dev.epicgames.com/community/api/documentation/image/1c79a53f-c258-4030-9587-33bb3a71ba89?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c79a53f-c258-4030-9587-33bb3a71ba89?resizing_type=fit)

## Troubleshooting Other Issues

For proper validation, creators are expected to have streaming enabled, and also expected to have mipmaps being generated for textures. If any of your textures had the **MipGenSettings** option set to **No Mipmaps**, previously it was not flagged when your island is submitted for publishing. However, now if a texture in your project has MipGenSettings set to No Mipmaps, it will fail validation.

Note the following exceptions to this requirement for streaming and mipmaps:

- This rule only applies to textures with more than 1 million texels. So for example, if a texture's dimensions, when multiplied, come out to less than 1,048,576 then it will pass validation even with **MipGenSettings** set to **No Mipmaps.**
- Textures in the UI group are not required to have streaming enabled.
