# Two-sided Materials

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-twosided-materials-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:28:48.399072

---

Use a two-sided Material to create the leaves of a bush or a depth effect on your mesh. Begin by selecting a base color and add onto it with more Material nodes.

1. Create a new Material in your project and double-click the **Material thumbnail** to open the **Material Editor**.
2. Select the **Main Material** node and check the **Two Sided** option in the **Details** panel.

   [![Check the Two Sided option in the Details panel.](https://dev.epicgames.com/community/api/documentation/image/a51232d9-d103-4286-9301-3cc6a3532e45?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a51232d9-d103-4286-9301-3cc6a3532e45?resizing_type=fit)
3. Add the following nodes:

   1. 2 X **Constant 3Vector expression** node
   2. **TwoSidedSign** node
   3. **Saturate** node
   4. **Interpolate** node
4. Select the first **Constant 3Vector expression** node and add a color, then drag off the node and plug it into the **A input** on the **Lerp** node.
5. Select the second **Constant 3Vector expression** node and add a color, then drag off the node and plug it into the **B input** on the **Lerp** node.
6. Drag off the **TwoSidedSign** node and plug it into the **Saturate** node.
7. Drag off the **Saturate** node and plug it into the **Alpha input** on the **Lerp** node.
8. Drag off the **Interpolate** node and plug it into the Material root node.

   [![The configuration using the steps above.](https://dev.epicgames.com/community/api/documentation/image/d51ff7d2-dda7-4f48-8f45-1839b660f95e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d51ff7d2-dda7-4f48-8f45-1839b660f95e?resizing_type=fit)
9. Change the shape in the preview window to a flat square.

   [![Change the shape in the preview window to a flat square.](https://dev.epicgames.com/community/api/documentation/image/9918f58b-126d-4c4d-9d2c-cacbae2c6504?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9918f58b-126d-4c4d-9d2c-cacbae2c6504?resizing_type=fit)

The configuration above treats the front and back of the mesh differently, it flips the normals so they always face the camera. If you wanted to create the illusion of depth:

1. Select the **Main Material Node** and change the **Blend Mode** option in the **Details** panel to **Masked**. This allows you to use additional input options on the **Main Material Node**, like **Opacity Mask**, which you will need to create the depth effect.

   [![Select the Masked option from the Blend Mode dropdown to add additional inputs to the Main Material node.](https://dev.epicgames.com/community/api/documentation/image/b543e67a-35b7-4a2a-940d-b98a6c483821?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b543e67a-35b7-4a2a-940d-b98a6c483821?resizing_type=fit)
2. Delete one of the **Constant 3Vector expression** nodes and the **Lerp** node.
3. Add a **Multiply** node between the **TwoSidedSign** node and the **Saturate** node.
4. Select the **Multiply** node and change the **B input** value to **-1.0**.

   [![Change the B input value to negative one.](https://dev.epicgames.com/community/api/documentation/image/2693549e-0ba7-41f5-9a57-7f1506ce6b68?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2693549e-0ba7-41f5-9a57-7f1506ce6b68?resizing_type=fit)
5. Drag off the **Saturate** node and plug it into the **Opacity Mask input** on the **Main Material Node**.

   [![The configuration of nodes using the instructions above.](https://dev.epicgames.com/community/api/documentation/image/73439b6e-dfd3-4474-8be6-a41f4f8b3a35?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/73439b6e-dfd3-4474-8be6-a41f4f8b3a35?resizing_type=fit)
6. Click **Apply**. The sphere in the preview window now has a shadow across the top.

   [![A shadow appears across the top of the sphere.](https://dev.epicgames.com/community/api/documentation/image/47eb5d34-4624-4b46-bc33-eb1efa2f95a6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/47eb5d34-4624-4b46-bc33-eb1efa2f95a6?resizing_type=fit)
7. Apply the new Material to a cube mesh. Notice how the cube looks like an empty box.

The configuration above creates a Material that only renders the inside of a solid object, causing the mesh to appear hollow from all angles. This is an interesting Material that could be used in a project to create a hall of mirrors style effect when applied.
