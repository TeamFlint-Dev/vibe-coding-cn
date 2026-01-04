# Creating a Body of Water for Your Custom Landscape

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-a-body-of-water-to-your-custom-landscape-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:18:44.322969

---

With your mountain complete, you’re ready to use the [Water tools](water-environment-tools-in-unreal-editor-for-fortnite) to add a body of water to your terrain.

In this tutorial, you’ll add a river and edit the river [splines](unreal-editor-for-fortnite-glossary#spline) to make it curve around your mountain. The Water tools are located in the **Fortnite** folder under **Environment** > **Water**. Open the Water folder and drag the river into the viewport.

With the river in the viewport, move the viewport camera closer to the river to see which way the water flows. This is important if you want to add additional bodies of water, or if you place your river on or through a mountain. It might look odd to have water running uphill rather than down.

## River Basics

There are two things you’ll notice about the river you placed in your viewport — the bend in the river spline, and changes to the terrain around the river bed.

By right-clicking the river spline, you open the **spline options menu**. From here, you can create, delete and duplicate spline points, and more.

Clicking on the river spline initially will select the spline as a whole to move it in the level.

With the spline selected, clicking a spline point will select only that point, and you can move only the selected point.

With a spline point selected, you can also click one of the two tangent control points of the spline point to affect the direction and shape of the curve going through that point.

Move spline points further apart by selecting and [translating](unreal-editor-for-fortnite-glossary#translate) a spline point. To move the whole river, click on the river, or select the river from the **Outliner** and translate using the river’s pivot point.

[![Move the river by the pivot points.](https://dev.epicgames.com/community/api/documentation/image/075ca10c-f574-442d-a482-c008c6cc66d2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/075ca10c-f574-442d-a482-c008c6cc66d2?resizing_type=fit)

By duplicating and translating splines, you can create a basic river and shape it using the tangent controls. Follow your river from the starting point (where the water flows from) to the end, making sure that the edges of the river don't sink too far into the ground.

If you find sections that are too low, grab the nearest spline point and translate the spline along the **Z-axis** to bring it level to the top of the terrain, then go back and make sure the river bank looks natural from the translated spline to the spline points to the left and right.

Add new spline points if needed to keep the river bank and river looking natural. Use the Water settings in the Details panel to edit the river more by adding depth to portions of the river, increasing the river’s width, and playing with the velocity of the water flow.

Once you’ve wrapped your river around the back of the mountain the way you want, decide where in your mountain you’d like to place a cave.

[![The end result of creating a river.](https://dev.epicgames.com/community/api/documentation/image/457ee6b3-f997-4e2b-94b1-3843d6007473?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/457ee6b3-f997-4e2b-94b1-3843d6007473?resizing_type=fit)

## Next Section

[![Making a Cave](https://dev.epicgames.com/community/api/documentation/image/d244afe5-e1aa-464b-bce8-7c6b49b56b27?resizing_type=fit&width=640&height=640)

Making a Cave

Create a cave inside your custom terrain.](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-cave-in-unreal-editor-for-fortnite)
