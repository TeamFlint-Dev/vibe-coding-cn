# Color-Changing Material

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/colorchanging-material-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:02:42.417922

---

If you create a tree or a sign, you might want to apply an effect to the [material](unreal-editor-for-fortnite-glossary#material) that the changes the color of the [mesh](unreal-editor-for-fortnite-glossary#mesh), depending on its location in the world.

To apply a color-changing texture to the leaves of a tree mesh, for example, you would use the **Sine** node to target the [world position](unreal-editor-for-fortnite-glossary#world-position) of the mesh and modify the color as it changes position along the Z-axis.

To create this effect:

1. Add the following nodes to the configuration above in the **Material Editor**:

   1. **Linear Interpolate** node
   2. **Sine** node
   3. **Divide** node
   4. **Component Mask** node
   5. **Absolute World Position** node
   6. 2X **Constant 3Vector expression** node
2. Drag off the **Absolute World Position** node and plug it into the **Component Mask** node.
3. Select the **Component Mask** node, then check only the **B** option in the **Material Expression Component Mask** on the **Details** panel.

   [![Only select the B input from the Material Expression Component Mask options.](https://dev.epicgames.com/community/api/documentation/image/c7c69c77-f1e5-46d6-8acd-9d8e88077f38?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c7c69c77-f1e5-46d6-8acd-9d8e88077f38?resizing_type=fit)
4. Drag off the **Component Mask** node and plug it into the **Sine** node.
5. Select the **Sine** node and change the **Material Expression Sine** value to **1200** in the **Details** panel.

   [![Change the Period value to 1934 in the Material Expression Sine option of the Details panel.](https://dev.epicgames.com/community/api/documentation/image/24f9582e-f668-4e5f-87cf-874865ee6cd1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/24f9582e-f668-4e5f-87cf-874865ee6cd1?resizing_type=fit)
6. Drag off the **Sine** node and plug it into the **Divide** node **A input**.
7. Change the **Divide** node **B input** numerical value to **3.0**.
8. Drag off the **Divide** node and plug it into the **Lerp** node **Alpha input**.

   Sine node values can produce less than desirable results. If you find the sine wave does not add value to your material, you can get away with losing the sine output and saturating the divide output to keep everything within nominal range.
9. Select the first **Constant 3Vector expression** node and add a color.

   [![Select a color for the first.](https://dev.epicgames.com/community/api/documentation/image/f9e88173-6854-4b7d-99ba-785ec7eacb56?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f9e88173-6854-4b7d-99ba-785ec7eacb56?resizing_type=fit)
10. Select the second **Constant 3Vector expression** node and add a color.

    [![Select a color for the second Constant 3Vector expression.](https://dev.epicgames.com/community/api/documentation/image/2c4a30f6-fba8-4a21-b478-248d3a0d356d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2c4a30f6-fba8-4a21-b478-248d3a0d356d?resizing_type=fit)
11. Drag off the first **Constant 3Vector expression** node and plug it into the **Lerp** node **A input**.
12. Drag off the second **Constant 3Vector expression** node and plug it into the **Lerp** node **B input**.
13. Drag off the **Lerp** node and plug it into the **Basic Color input** of the **Main Material** node.

    [![This is the material node configuration to create the color changing effect.](https://dev.epicgames.com/community/api/documentation/image/e611c3ea-c716-4e2e-a65b-67bb4ad028e7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e611c3ea-c716-4e2e-a65b-67bb4ad028e7?resizing_type=fit)

    *Click image to enlarge.*
14. Click **Apply** in the toolbar.
15. Add the new material to a mesh in the viewport.
16. Move the mesh up and down along the Z-axis. Notice how the color changes from one to the other, depending on where the mesh is in the world.

The **Mask** node determines where the color change is happening along the sine wave. The **Divide** node then determines how frequently the color change repeats in the world position.

The two **Constant 3Vector expression** nodes determine the colors that remain constant in the world position, while the **Lerp** node interpolates between the colors in the world position, creating a gradient at times, depending on where the mesh is located.

Play around with the different node values to get a feeling for where the color change should happen in the world position.

You do not have to create a new material every time you want to change the color values for your material. If you familiarize yourself with the [**Material Instance Editor**](https://docs.unrealengine.com/5.0/en-US/unreal-engine-material-instance-editor-ui/), you can change your material instance by changing material parameters.
