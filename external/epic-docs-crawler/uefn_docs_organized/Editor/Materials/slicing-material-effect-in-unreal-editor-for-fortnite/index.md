# Slicing Material Effect

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/slicing-material-effect-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:02:31.646634

---

This tutorial uses the local spatial value of a material rather than its absolute [world position](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#world-space) to determine where to slice.

You will create a slice effect by first setting up an emissive [node](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#node) graph to make a solid material, then using the mesh local space and a material function to determine where the slice will happen on the mesh.

## Creating the Emissive Node Graph

1. Select the material root node and check the **Two Sided** option in the **Details** panel.
2. Open the **Blend Mode** dropdown menu and select **Masked**.
3. Add the following nodes to your copied material by right-clicking in the node graph and searching for the specified name:

   1. 3 X **Constant** node
   2. 2 X **Constant 3Vector Expression** node
   3. 2 X **Clamp** node
   4. **Append3Vector** node
   5. **WorldPosition** node
   6. **Subtract** node
   7. **Dot Product** node
   8. **Multiply** node
   9. **Linear Interpolate** node
   10. **TwoSidedSign** node
4. Double-click the first **Constant3Vector** node and add an exterior color to the material.
5. Drag off the white pin from the first **Constant3Vector** node and plug into the **Base Color input** on the material root node.
6. Drag off the pin of the first **Constant** node and plug into the **Roughness input** on the material root node and change the value to **0.75**.

   [![Change the value to 0.75 on the value node.](https://dev.epicgames.com/community/api/documentation/image/30559569-e795-41f4-9010-8a506777110f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/30559569-e795-41f4-9010-8a506777110f?resizing_type=fit)

   This configuration creates the base color and the material response to light for the object the material is assigned to. The next configuration creates an emissive that makes the inside of the mesh appear solid on the interior.

   [![This is how the nodes should look for this configuration.](https://dev.epicgames.com/community/api/documentation/image/4e90121a-b9fe-40ab-8706-abb2155b02bf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e90121a-b9fe-40ab-8706-abb2155b02bf?resizing_type=fit)
7. Drag off the **TwoSidedSign** node and connect to the **Clamp** node, then drag off the **Clamp** node and connect to the **Alpha input** on the **Lerp** node.
8. Double-click the second **Constant3vector** node and add a color for the interior of the mesh. Then drag off the white pin of the **Constant3Vector** node and connect to the **A input** on the **Lerp** node.
9. Select the **Lerp** node and set the **B input** value to **0.0**.

   [![Change the value for the B input.](https://dev.epicgames.com/community/api/documentation/image/ea3c8b0d-3c29-424f-89b3-98f2f82b93d6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ea3c8b0d-3c29-424f-89b3-98f2f82b93d6?resizing_type=fit)
10. Drag off the **Lerp** node and connect to the **A input** on the **Multiply** node.
11. Select the **Multiply** node and change the **B input** value to **0.3**.

    [![Change the value for the B input.](https://dev.epicgames.com/community/api/documentation/image/4e99eb0b-f674-4f50-bdd0-cc64a3954d6c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e99eb0b-f674-4f50-bdd0-cc64a3954d6c?resizing_type=fit)
12. Drag off the **Multiply** node and connect to the **Emissive Color input** on the material root node.

The emissive node graph is complete.

## Location Graph

Next, create the location graph that targets the mesh’s location to remove parts of the mesh from the project.

You can copy a node that already uses the emissive graph, delete the part of the graph that you don’t need, then add the necessary node configuration to create an effect.

By targeting the mesh location data, you can use the material to make portions of the mesh disappear. This effect can also be used to [create an animation](https://dev.epicgames.com/documentation/en-us/fortnite/animate-materials-in-unreal-editor-for-fortnite).

Create a material function node by right-clicking in the Material Editor and typing **Functions** in the search bar. Select the **MaterialFunctionCall** option. The **Unspecified Function** node appears in the Material Editor.

You cannot search for a specific material function in the Material Editor, instead you have to create an unspecified material function node and assign a function to it.

[![Create an Unspecified Function node in the Material Editor.](https://dev.epicgames.com/community/api/documentation/image/5fb82b52-7728-47e3-ab2c-42946bcd82dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5fb82b52-7728-47e3-ab2c-42946bcd82dc?resizing_type=fit)

Select the Unspecified Function node, and in the Details panel, assign the **Local Position** material function from the **Material Function** dropdwn menu. The LocalPosition material funtion node automatically appears in the Material Editor.

Create a second **Unspecified Function** node and assign the **ObjectLocalBounds** function to the node.

[![Select Local Position from the Material Function dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/a32c59d5-7dd3-4e14-9bed-e4318f3c2586?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a32c59d5-7dd3-4e14-9bed-e4318f3c2586?resizing_type=fit)

1. Create and open a new **Material Instance**.
2. Select the Main Material Node and change the **Blend Mode** setting to **Masked**.
3. Add the following nodes to the Material Editor:

   1. **Divide** node
   2. **Constant3Vector** node
   3. **ComponentMask** node
   4. **Clamp** node
   5. 2 X **Constant** node
   6. 2 X **Subtract** node
4. Select the **Constant3Vector** node and double-click the node to add a color.
5. Drag off the **white output** pin on the Constant3Vector node and plug into the **Base Color input** on the Main Material Node.
6. Select the **Constant** node and set the value to **.75**.
7. Drag off the **Constant** node and plug into the **Roughness input** on the Main Material Node.
8. Drag off the **Instance Local Position** pin of the **Local Position** node and plug into the **A input** on the **Divide** node.
9. Drag off the **Local Bounds Size** pin of the **ObjectLocalBounds** node and plug into the **B input** on the **Divide** node.
10. Drag off the **Divide** node and plug into the **B input** of the first **Subtract** node.
11. Change the **A input** value of the **Subtract** node to **1.0**.
12. Drag off the first **Subtract** node and plug into the **Mask** node.
13. Drag off the **Mask** node and plug into the **A input** of the second **Subtract** node.
14. Select the second **Constant** node and change its value to **0.1**.
15. Drag off the **Constant** node and plug into the Second **Subtract** node’s **B input**.
16. Drag off the second **Subtract** and plug into the **White input** on the **Clamp** node.
17. Change the **Clamp** node’s **Max** value to **1.0**.
18. Select the material root node, in the Details panel change the **Blend Mode** value to **Masked**. The **Opacity Mask** option becomes available on the main root node.
19. Drag off the **Clamp** node and plug into the **Opacity Mask** on the material root node.

This is the configuration you should have when the nodes are connected.

[![Change the](https://dev.epicgames.com/community/api/documentation/image/a017d3af-4ba1-4883-975f-d1b5f4e7c7ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a017d3af-4ba1-4883-975f-d1b5f4e7c7ab?resizing_type=fit)

When you change the **A input** value on the first **Subtract** node, you change the look of the mesh.

This gets the local position of the object (a gradient in X / Y / Z with everything left / below / behind the center of the object negative, and everything right / above / before the center of the object positive). These values are determined by the world scale of the object.

To normalize the values, for example–put them in the [0, 1] range, we divide those values by their maximum extent (as dictated by the object bounds). The 1 - B input flips the direction of the gradient, so the values at the right / top / front are lower than those of the left / bottom / back.

The **ComponentMask** node is an alternative to the DotProduct node with the blue channel - it gives the same result. You can then subtract the clip value - one of the constants converted to a parameter, as above (which falls within the 0, 1 range), and clamp off any negative values before wiring it to the opacity slot.

## Next Section

[![Cut a Mesh in Half](https://dev.epicgames.com/community/api/documentation/image/80c3c0f4-143f-4595-89b6-7540cc24c62c?resizing_type=fit&width=640&height=640)

Cut a Mesh in Half

Learn how to create a material that cuts a mesh in half.](https://dev.epicgames.com/documentation/en-us/fortnite/cutting-a-mesh-in-half-in-unreal-editor-for-fortnite)
