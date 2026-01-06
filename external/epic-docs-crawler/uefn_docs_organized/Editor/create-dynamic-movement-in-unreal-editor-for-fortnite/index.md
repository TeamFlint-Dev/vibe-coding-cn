# Dynamic Movement

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-dynamic-movement-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:03:17.859190

---

Use material nodes to make a material that seems to be alive. To create this effect, you’ll configure your material nodes and plug them into the **World Position Offset input** of the **Main Material** node.

Follow the instructions below to create a dynamic material.

1. Create a **new material** in the mesh’s **Material folder** and name it **Moving\_Mesh**.
2. Change the sphere to a flat surface in the **preview window**.
3. Add the following nodes:

   1. 3 X **Multiply** node
   2. **Sine** node
   3. **VertexNormalWS** node
   4. **Add** node
   5. **Time** node
   6. **TextureSample** node
4. Use a **TextureSample** node and add a badge texture to the sample in the **Details** panel.

   [![Add a badge texture sample to the node.](https://dev.epicgames.com/community/api/documentation/image/62581c65-2118-4392-adc8-3e51a3b04696?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/62581c65-2118-4392-adc8-3e51a3b04696?resizing_type=fit)
5. Drag off the **RGB** input on the **Texture Sample** node and plug into the **Base Color** input on the **Main Material Node**.
6. Drag off the **VertexNormalWS** node and plug it into the first **Multiply** node **A** input.
7. Drag off the first **Multiply** node and plug it into the second **Multiply** node’s **A** input.
8. Drag off the second **Multiply** node and plug it into the **Main Material Node** **World Position Offset input**.
9. Drag off the **Texture Sample** node and plug it into the first **Multiply** node **B** input from the **R** input (red UV channel input).

   [![Image shows how the nodes are connected as instructed above.](https://dev.epicgames.com/community/api/documentation/image/c943c455-3749-4a40-a318-7c694db1f758?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c943c455-3749-4a40-a318-7c694db1f758?resizing_type=fit)

   You can drag off any of the color channels (R, G, B) to focus the movement on a certain color in the material.
10. Drag off the **Time** node and plug it into the **Sine** node.
11. Drag off the **Sine** node and plug it into the **Add** node **A input**.
12. Drag off the **Add** node and plug it into third **Multiply** node **A input**.
13. Change the value on the **Add** node to **1.0**.
14. Change the value of the **Multiply** node to **10.0**.
15. Expand the **Sine** node and change the **Period** value to **10.0**.
16. Drag off the third **Multiply** node and plug it into the **B input** of the second **Multiply** node.

    [![Image shows how the nodes are connected as instructed above.](https://dev.epicgames.com/community/api/documentation/image/e685f4f5-4630-4171-bc97-447931268cc5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e685f4f5-4630-4171-bc97-447931268cc5?resizing_type=fit)

By multiplying all vertices along the red channel, colors that have red in them move, except for those that are completely red or that lack any color. The VertexNormals are then multiplied by the Time and Sine nodes, moving the red channel in time to the Sine wave.

The length of the Sine wave along the red channel is determined by the Add node numerical value between -1.0 and +1.0, then multiplied by 10 in the third Multiply node, which defines how much movement is taking place in the direction of the vertex.

The higher the numerical value of the third **Multiply** node, the more movement there is in the material along the red channel.

When using light to make colors, red, green and blue combine to make white light. That is why the white parts of the mesh move as well.

The amount of movement on the mesh depends upon the amount of vertices on the mesh. Therefore, a low-poly mesh will only move a few vertices, but a more complicated mesh will move more vertices, creating a greater effect on the mesh.
