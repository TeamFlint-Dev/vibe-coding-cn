# Create a Puzzle with Prefabs

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-05-create-a-puzzle-with-prefabs-in-fortnite
> **爬取时间**: 2025-12-27T02:38:45.553476

---

To create a simple puzzle with the [prefabs](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#prefab) from the previous step, follow these steps:

1. Navigate to the folder in the **[Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-browser)** containing your prefabs.
2. Add the following prefabs by dragging them into the [level](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#level) from the **Content Browser**:

   - **1 Prefab\_PuzzleManager**
   - **2 Prefab\_Trigger**
   - **2 Prefab\_TriggerableLight**
   - **1 Prefab\_TriggerableMovingMesh**
3. [Hierarchically](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#hierarchical) structure them as follows in the outliner:

   [![The hierarchical structure of the prefabs.](https://dev.epicgames.com/community/api/documentation/image/b0f12b2a-7f19-4279-b1fe-1f16c7408aba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b0f12b2a-7f19-4279-b1fe-1f16c7408aba?resizing_type=fit)

   Click to enlarge image.
4. Add two **[Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative)** Creative devices to the level by navigating to the **Content Browser** and searching for **Volume**, then dragging them into the level. Rename the volumes **TriggerVolume1** and **TriggerVolume2**.
5. Move the **TriggerVolume1** to overlap one of the **Prefab\_Trigger** prefabs and [scale](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#scale) it appropriately. Do the same for **TriggerVolume2** with respect to the other **Prefab\_Trigger**.
6. Set a reference to **TriggerVolume1** on the relevant **Prefab\_Trigger** by selecting the relevant **Prefab\_Trigger** in the **Outliner**, navigating to the **Details** panel, and choosing **TriggerVolume1** under the **trigger\_component**.

   [![Add the Trigger devices to the InteractiveVolume option under the trigger_component.](https://dev.epicgames.com/community/api/documentation/image/be6329a1-9a63-4732-a436-655be9287d02?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/be6329a1-9a63-4732-a436-655be9287d02?resizing_type=fit)

   Click to enlarge image.
7. Repeat the previous step for **TriggerVolume2** and the other **Prefab\_Trigger**.
8. On the **Prefab\_TriggerableMovingMesh**:

   - Set the first child entity **Forward** scale to **2.0**
   - Set the second child entity **Left** scale to **4.0**
   - Uncheck the **PuzzlePiece** checkbox.

## Result

The puzzle is now solved when the player lights both of the triggerable lights by standing on the trigger planes. When both lights are turned on, the **Prefab\_TriggerableMovingMesh** is triggered to scale up in size and the puzzle is solved.

[![](https://dev.epicgames.com/community/api/documentation/image/4aeb9de6-7cf6-4408-8f42-e264c3c4c346?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4aeb9de6-7cf6-4408-8f42-e264c3c4c346?resizing_type=fit)

## On Your Own

Here is a more complex example of what these components are capable of with custom meshes created with [Modeling mode](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite) in UEFN and changing the materials on those meshes. This puzzle uses the same prefabs as the simpler puzzle above, but with custom materials and meshes for the pedestals, lights, and bridge.

And here is another example that can be created using the **Prefab\_TriggerableMesh** and chaining the two puzzles together:
