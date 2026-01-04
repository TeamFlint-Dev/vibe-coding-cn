# Creating Roads and Pathways

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-roads-and-pathways-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:18:55.088789

---

In Fortnite Battle Royal, the roads and pathways make traveling between points easy whether a player is on foot or in a vehicle. These were all created using the [Spline tool](https://docs.unrealengine.com/landscape-splines-in-unreal-engine/).

You can add roads and pathways to your project using the architectural props from Street Gallery B or the Racetrack Gallery, but these props require the flat grid plates to lay on top of.

The Spline tool in Landscape Mode provides greater control because you determine the number of splines needed to create the path, the mesh type, and the amount of brush falloff to work with the weight and height maps of the terrain.

If you want to add dirt along the path around your mountain, you could use the Spline tool, but using the Paint tool to add small dirt patches is an easier way to create a worn path. Select the dirt layer as the material, then paint small patches of the landscape.

In the editor, select **Landscape Mode** > **Manage** > **Spline**.

[![Select the Spline tool from Landscape Mode.](https://dev.epicgames.com/community/api/documentation/image/329f21cf-47c9-4586-b89d-2ba438a3c5a0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/329f21cf-47c9-4586-b89d-2ba438a3c5a0?resizing_type=fit)

Click **All Splines** in the Spline settings to make sure that as you lay a spline point the terrain and spline work together, blending the spline mesh with the terrain mesh to create a natural looking path as you set down each spline segment.

Before putting down a spline point, make sure the Viewport setting **Game View** is turned off. When Game View is on, you won’t see the spline points you create, and you won’t be able to connect them.

To set your first spline point, press **CTRL + left-click**. To add spline segments, select the previous spline point by right-clicking on the spline then press **CTRL + left-click** to connect the spline points together. You’ll see the wireframe of your path around the splines as you create and connect them.

When you’ve finished creating the road, you should have a green path on your map that runs from the first spline to the last. Each spline can be translated by its pivot point. Click an individual spline to make its pivot point appear.

[![The connected splines create a green path on your terrain.](https://dev.epicgames.com/community/api/documentation/image/3087e02e-56dc-42a5-a2af-e6b0c548fdf5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3087e02e-56dc-42a5-a2af-e6b0c548fdf5?resizing_type=fit)

Add a road material to the road mesh you created in your terrain:

1. Press the **Segments** button under **Select All** from the Spline tool settings to select all the splines in the terrain.
2. In the Details panel, select **Spline Meshes** > **+** (Array)under **Landscape Spline Meshes**. The Mesh options open, from here select the **Road Straight** mesh type and scale.

The spline segments update in the viewport with the mesh and scale you set. You will need to scale sections of the road along the Z-axis to stop the grass layer from permeating the road mesh. Select the spline and increase the Z-axis location in the Details panel.

[![Edit the spline segment to create a piece of your road.](https://dev.epicgames.com/community/api/documentation/image/7c54f78c-7853-4d7f-8310-80f81d4af137?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7c54f78c-7853-4d7f-8310-80f81d4af137?resizing_type=fit)

Another way to add the roadside is to paint the terrain next to the road rather than scale the mesh. This allows you to paint layers without grass or debris. If you want small patches of grass sporadically in your roadside, you’ll find different grass types in the **Galleries** > **Nature** folders.

You can change the mesh of a single or group of spline points at any time to create a fork in the road or transition from a paved road to a dirt road. You’ll need to scale the new road sections to match the previous sections.

You can create an overpass, but you must use the Fort Underground Volume for the road that passes under the overpass or the two road meshes will intersect and not display each road on their own layer in the landscape.

When the road is finished, you’re ready to [add foliage](https://dev.epicgames.com/documentation/en-us/fortnite/placing-foliage-in-a-custom-landscape-in-unreal-editor-for-fortnite) to your terrain.
