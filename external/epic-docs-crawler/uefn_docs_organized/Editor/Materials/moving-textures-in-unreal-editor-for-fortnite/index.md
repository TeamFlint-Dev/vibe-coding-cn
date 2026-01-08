# Moving Textures

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/moving-textures-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:03:12.572782

---

When you use an **Absolute World Position** node to create a material, you are returning the world position of the pixel being drawn (including or excluding material offsets). Drawing the pixel across the world position creates movement, which results in the material moving across the mesh that sits in the same world position.

The **Panner** node moves [UVs](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#uv-mapping) in a direction according to the value you assign to the different axes. Play around with the values to see the material change directions.

1. Create a new material in the your project, then double-click the **material thumbnail** to open the **Material Editor**.
2. Use the following nodes:

   1. **Texture Sample** node
   2. **Panner** node
   3. **Divide** node
   4. **Component Mask** node
   5. **Absolute World Position** node
3. Select the **Texture Sample** node and add a patterned texture to the sample in the **Details** panel.

   [![Add a texture to the Texture Sample node.](https://dev.epicgames.com/community/api/documentation/image/3e675e87-d071-4dcc-a774-56157d2a227b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e675e87-d071-4dcc-a774-56157d2a227b?resizing_type=fit)
4. Drag off the Texture Sample node **RGB pin** and plug it into the **Base Color input** on the Main Material Node.
5. Drag off the **Absolute World Position** node and plug it into the **Component Mask** node.
6. Drag off the **Component Mask** node and plug it into the **A input** on the **Divide** node.
7. Drag off the **Divide** node and plug it into the **UVs input** of the **Texture Sample** node.

   [![The texture divides the amount of times the texture is replicated on the mesh.](https://dev.epicgames.com/community/api/documentation/image/a9a315ff-1a58-4ca3-8922-e379bd580d69?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9a315ff-1a58-4ca3-8922-e379bd580d69?resizing_type=fit)
8. Change the **B input** value of the **Divide** node. This determines the size of the patterned texture on the mesh. The higher the number, the larger the pattern appears. Alternatively, the smaller the number, the smaller the pattern.
9. Break the link between the **Divide** node and the **Texture Sample** node, then place the **Panner** node between the **Divide** and **Texture Sample** nodes.
10. Drag off the **Divide** node and plug it into the **Panner** node **Coordinate input**.
11. Drag off the **Panner** node output pin and plug it into the **UVs input** on the Texture Sample node.
12. Change the **Speed** values on the **Panner** node to change the direction the material moves across the mesh.

    Using positive values in the Panner node causes the pattern to move upward. Negative values cause the pattern to move downward.

    To move the texture to the right, set the X-axis to a negative value and the Y-axis to a positive value. Reverse the negative and positive values of the axes to move the texture to the left.

Plugging [WorldPosition](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#world-space) directly into the texture sample produces *a lot* of tiling repeats because the UEFN world units are so small. You can divide the world position by a value to reduce tiling; this is achieved by setting the **Units per Texture** ([texel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#texel) density).

The mask limits the Float3WorldPosition (X, Y, Z) to the float2 for the **X** and **Y** axes.

Because the material is sampling the position of each pixel in the world, the material stays in the same place, regardless of how the mesh is placed, until moved with the **Panner** node.
