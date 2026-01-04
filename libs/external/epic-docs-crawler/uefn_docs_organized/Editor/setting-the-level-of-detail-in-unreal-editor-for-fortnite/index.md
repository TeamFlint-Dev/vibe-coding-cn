# Setting the Level of Detail

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/setting-the-level-of-detail-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:17:25.842184

---

[**Level of Detail (LOD)**](unreal-editor-for-fortnite-glossary#lod) is important for [rendering](unreal-editor-for-fortnite-glossary#render) your [asset](unreal-editor-for-fortnite-glossary#asset) across different platforms. Setting LODs also helps to improve performance for players since the LODs render according to a player's proximity to [props](unreal-editor-for-fortnite-glossary#prop).

## Setting Up the LOD Transition Distances and Reduction Settings

Expand the **LOD Settings** section in the **Details** panel on the right side of the **Static Mesh Editor**.

### LOD Group

[![LOD Group Settings](https://dev.epicgames.com/community/api/documentation/image/06fc2fb8-07f0-40f7-a51e-4aea1a080da3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06fc2fb8-07f0-40f7-a51e-4aea1a080da3?resizing_type=fit)

The [LOD Group](https://docs.unrealengine.com/4.27/en-US/WorkingWithContent/Types/StaticMeshes/HowTo/LODs/) dropdown provides a list of asset types and assigns default LOD settings based on your selection.

Recommended LOD groups for Fortnite Creative assets:

| Asset Type | LOD Group |
| --- | --- |
| **Props** (chairs, plants, crates, etc.) | Default |
| **Modular building pieces** (walls, floors, ceilings, etc.) | LevelArchitecture |

### Setting the LODs

[![Set your LOD settings for your Static Mesh](https://dev.epicgames.com/community/api/documentation/image/d7aa80ee-a8c7-4fa4-8605-1206575c48c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d7aa80ee-a8c7-4fa4-8605-1206575c48c5?resizing_type=fit)

1. Select the **Default** option for the **LOD Group** if it is not already selected.
2. Make sure the **Auto Compute LOD Distances** is unchecked. Unchecking this option means you can input LOD transition distances manually.
3. Expand the **LOD Picker** section and choose **LOD 1** from the **LOD** dropdown menu.

   [![Select from the LOD dropdown menu](https://dev.epicgames.com/community/api/documentation/image/48f09e9c-91be-4a3a-9274-5b70047783d1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48f09e9c-91be-4a3a-9274-5b70047783d1?resizing_type=fit)

   1. Under **Reduction Settings**, ensure that **Percent Triangles** is at **50**.
   2. Switch to **LOD 2** from the **LOD** dropdown menu.
   3. Under **Reduction Settings**, ensure that **Percent Triangles** is at **25**.
   4. Switch to **LOD Auto** from the **LOD** dropdown menu.
4. Under **General Settings**, make sure **LOD for Collision** is set to **2**.
5. Click **Save**.

### Screen Size Starting Values

The **Screen Size** value determines how much space on the screen your asset can occupy before the asset drops to a lower level of detail. As you move away from an asset, its screen size shrinks. In the above example, when the screen size of the chair hits **0.3**, the prop drops from LOD 0 to LOD 1.

The **Screen Size** values given above work well for the DarkVillage Chair, but they are not necessarily the best values for your asset.

These tables list recommended starting values, but you can adjust as you see fit. Zoom in and out of the [Static Mesh](unreal-editor-for-fortnite-glossary#static-mesh) Editor viewport to test LOD transitions.

| Screen Size Starting Values (Architecture) |  |  |  |
| --- | --- | --- | --- |
| **LOD 0 (Render Mesh)** | **LOD 1** | **LOD 2** | **LOD 3** |
| 1.0 | .4 | .1 | .03 |

| Screen Size Starting Values (Props) |  |  |  |
| --- | --- | --- | --- |
| **LOD 0 (Render Mesh)** | **LOD 1** | **LOD 2** | **LOD 3 (Optional)** |
| 1.0 | .2 | .08 | .02 |

## Configuring Platform Minimum LOD Settings for Your Static Mesh

[![Setting minimum LOD quality settings](https://dev.epicgames.com/community/api/documentation/image/048aab52-e1b4-4e46-833b-ffd22f99f5ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/048aab52-e1b4-4e46-833b-ffd22f99f5ab?resizing_type=fit)

1. Return to the **LOD Settings** section in the **Details** panel.
2. Scroll to **Quality Level Min LOD**.
3. Click the **+** next to **Default**.
4. Select **Low** from the menu and change the value to **2**.
5. Repeat steps 3 and 4 to add inputs for the Medium and High quality levels.
6. Change the **Medium** value to **2** and the **High** value to **1**. Your settings should look like this:
7. Click **Save**.

The Static Mesh is now covered in a checkerboard pattern.

[![Static Mesh is now covered in a checkerboard pattern](https://dev.epicgames.com/community/api/documentation/image/747a4146-614c-40e9-8459-3e4fe1f9e152?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/747a4146-614c-40e9-8459-3e4fe1f9e152?resizing_type=fit)

**The Quality Level Min LOD** setting determines the minimum LOD your asset uses at each quality setting. Each of these levels corresponds to a different set of target platforms. These are the assigned values for the chair asset:

| Quality Level | Platform | Minimum LOD Value |
| --- | --- | --- |
| **Low** | Mobile/Performance Mode | 2 |
| **Medium** | Nintendo Switch | 2 |
| **High** | PC/ PS4 / Xbox One | 1 |
| **Epic** | High-end PC / PS5 / Xbox Series X | 1 |

This means that on **Mobile** and **Nintendo Switch**, the minimum LOD for this asset is LOD 2, and on **PC**, **PS4**, and **Xbox 1** the minimum LOD is 1.

The **Epic** quality level is intended for future use with high-end PCs, PS5, and Xbox Series X.
