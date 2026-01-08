# 2. Landscaping

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-02-landscaping-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:17:54.644453

---

In this section, you’ll learn how to create custom terrain, build a basement and sub basement section, create a driveway and road, add foliage, and create the cut scene area.

## Creating Terrain

Create a new terrain in **Landscape Mode** using the settings in the table below. Use all the other default settings in [Manage](https://dev.epicgames.com/documentation/en-us/fortnite/landscape-mode-in-unreal-editor-for-fortnite) to create your terrain.

| Option | Value | Explanation |
| --- | --- | --- |
| **Material** | MI Creative Landscape Chapter 4 | This landscape material used in Chapter 4 features a number of Niagara effects that makes the natural environment seem more wild and enhances the look and feel of the game. |
| **Section Size** | 31 x 31 Quads | You need a terrain that is big enough to hold the cabin and the foliage you’ll need to make the cabin hidden from the road, and create an area you’ll use for your cinematic sequence. |

For this example, mountains were sculpted behind and around the edges of the terrain, except for one side of the terrain in front of the cabin.

[![Sculpt mountains on the edges of the terrain except on one side.](https://dev.epicgames.com/community/api/documentation/image/73092367-bfc3-44d7-b257-5020de479ccf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/73092367-bfc3-44d7-b257-5020de479ccf?resizing_type=fit)

Next you need to create a driveway and a road. To create a feeling of remoteness and abandonment, you’ll create a dirt driveway by painting a dirt landscape layer on top of the grass.

## Creating the Driveway and Road

The driveway you create will feature a dirt layer that adds to the remote and hidden feeling of the cabin. The driveway you design doesn’t need to be a straight line, you can make the driveway bend away from the road.

1. Select **Landscape Mode** again and select **Paint** from the Landscape tools.

   [![Select the Paint tool from the Landscape Mode tools.](https://dev.epicgames.com/community/api/documentation/image/c2903fdd-1e29-46a5-8df2-9a64bb7f190d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c2903fdd-1e29-46a5-8df2-9a64bb7f190d?resizing_type=fit)
2. Expand the **Layers** options and select **Layer 2**.

   [![Select the dirt layer to paint over the grass layer.](https://dev.epicgames.com/community/api/documentation/image/6c94cafe-7482-4e3e-8046-3a4d3b98331a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c94cafe-7482-4e3e-8046-3a4d3b98331a?resizing_type=fit)
3. Left-click on the ground to paint over the grass layer. Continue painting the ground in an uneven way until you have a long driveway.

   [![Paint the driveway using the dirt layer.](https://dev.epicgames.com/community/api/documentation/image/b2597748-5a42-4bda-a2e9-0150cceb3b82?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b2597748-5a42-4bda-a2e9-0150cceb3b82?resizing_type=fit)
4. Select **Manage** > **Splines** from the Landscape tools.

   [![Select splines to create the road.](https://dev.epicgames.com/community/api/documentation/image/57b34b7f-ee23-44a0-a40a-dc4995cdc5a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57b34b7f-ee23-44a0-a40a-dc4995cdc5a9?resizing_type=fit)
5. Press **CTRL** + **left-click** to set the first spline point. Place the first spline point on one of the edges of the terrain.
6. Select the first spline point then choose a second spot to place the next spline point and press **CTRL** + **left-click** to place the second spline point. Continue to place spline points by selecting the previous spline point and choosing another place to set the next spline point. This workflow connects all spline points.
7. Press the **Segments** button under **Select All** from the Spline tool settings to select all the splines in the terrain.

   [![Select segments to select all splines.](https://dev.epicgames.com/community/api/documentation/image/7a69c838-7908-47d8-9382-fdf0d0535fcd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a69c838-7908-47d8-9382-fdf0d0535fcd?resizing_type=fit)
8. In the Details panel, select **Spline Meshes** > **+** (Array) under **Landscape Spline Meshes**. The Mesh options open, from here select the **Road Straight** mesh type and scale.

   [![Select the Road Straight mesh for your road mesh.](https://dev.epicgames.com/community/api/documentation/image/71852ff6-20b2-4aca-90d7-1f24acda03e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/71852ff6-20b2-4aca-90d7-1f24acda03e0?resizing_type=fit)

The road mesh automatically appears once the road mesh is selected. You can further add details to your road and terrain by painting the sides of the road with the dirt layer. You can even add gravel to the end of the driveway by selecting the gravel layer and painting gravel on the end of the driveway.

[![Paint gravel at the end of the driveway.](https://dev.epicgames.com/community/api/documentation/image/3345549b-0f34-4207-9732-546e20ec61bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3345549b-0f34-4207-9732-546e20ec61bc?resizing_type=fit)

## Cut Scene Area

To create the area for the cut scene, you’ll need to paint away the grass and flowers in the landscape material so they don’t bleed through the Durr Burger prefab and parking lot.

1. Select **Landscape Mode** again and select **Paint** from the Landscape tools.

   [![Select the Paint tool from the Landscape Mode tools.](https://dev.epicgames.com/community/api/documentation/image/4cbbcfa4-15ed-4b6a-9649-22914ff10d1a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4cbbcfa4-15ed-4b6a-9649-22914ff10d1a?resizing_type=fit)
2. Expand the **Layers** options and select **Layer 2**.

   [![Select the dirt layer to paint over the grass layer.](https://dev.epicgames.com/community/api/documentation/image/6d7d434d-fa42-4a42-8162-f08ab4b135e7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d7d434d-fa42-4a42-8162-f08ab4b135e7?resizing_type=fit)
3. Left-click on the ground to paint over the grass layer. You should have enough space for a parking lot and the restaurant.

   [![Paint the layers of grass to prepare an area for a restaurant prefab.](https://dev.epicgames.com/community/api/documentation/image/d10a5fd9-0437-4d98-bd11-dba93cac50ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d10a5fd9-0437-4d98-bd11-dba93cac50ef?resizing_type=fit)

## Next Section

Once the escape room terrain is prepared, add the Cozy Cabin and Durr Burger prefabs and additional props to enhance the look and feel of creepiness and isolation.

[![3. Setting Up the Level](https://dev.epicgames.com/community/api/documentation/image/ff3043eb-754e-435f-9c3f-266d72e54e39?resizing_type=fit&width=640&height=640)

1. Setting Up the Level

Create the spaces you'll feature in your cinematic and the cabin players escape from.](<https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-03-setting-up-the-level-in-unreal-editor-for-fortnite>)
