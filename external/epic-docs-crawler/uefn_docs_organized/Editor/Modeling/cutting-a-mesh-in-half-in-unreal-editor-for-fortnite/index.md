# Cut a Mesh in Half

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/cutting-a-mesh-in-half-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:02:37.020516

---

You can create a slice effect by first creating an [emissive](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#emissive-material) node graph to create a solid [material](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#material), then using the mesh [world position](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#world-space) data and a TransformPosition material node to determine where to cut the mesh.

This material is effective for halving meshes for things like if you want to place a mesh flush against a wall without it bleeding through to the other side, or for creating a maze path for players using a static mesh as a wall piece.

## Creating the Emissive Node Graph

You can copy a node that's already using the emissive graph and delete the part of the graph that you don’t need, then add the necessary node configuration to create the effect.

1. Select the material root node and check the **Two Sided** option in the **Details** panel.
2. Open the **Blend Mode** dropdown menu and select **Masked1**.
3. Add the following nodes to your material by right-clicking in the node graph and searching for the specified name:

   1. 3 X **Constant** node
   2. 2 X **Constant 3Vector expression** node
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
6. Drag off the pin of the first **Constant** node and plug into the **Roughness input** on the material root node, then change the value to **0.75**.

   [![Change the value to 0.75 on the value node.](https://dev.epicgames.com/community/api/documentation/image/17367192-6a88-4537-99e8-333e14ade616?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17367192-6a88-4537-99e8-333e14ade616?resizing_type=fit)

This configuration creates the base color and the material response to light for the object the material is assigned to. The next configuration creates an emissive material that makes the inside of the mesh appear solid on the interior.

[![This is how the nodes should look for this configuration.](https://dev.epicgames.com/community/api/documentation/image/2b9dab4b-3db1-4d94-8e75-4896d176840d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b9dab4b-3db1-4d94-8e75-4896d176840d?resizing_type=fit)

1. Drag off the **TwoSidedSign** node and connect to the **Clamp** node, then drag off the **Clamp** node and connect to the **Alpha input** on the [Lerp](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#lerp) node.
2. Double-click the second **Constant3vector** node and add a color for the interior of the mesh. Then drag off the white pin of the **Constant3Vector** node and connect to the **A input** on the **Lerp** node.
3. Select the **Lerp** node and set the **B input** value to **0.0**.

   [![Change the value for the B input.](https://dev.epicgames.com/community/api/documentation/image/6dbb3e27-5e6c-4d92-ac3c-d1ce37a6df3f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6dbb3e27-5e6c-4d92-ac3c-d1ce37a6df3f?resizing_type=fit)
4. Drag off the **Lerp** node and connect to the **A input** on the **Multiply** node.
5. Select the **Multiply** node and change the **B input** value to **0.3**.

   [![Change the value for the B input.](https://dev.epicgames.com/community/api/documentation/image/ba99448e-dc8e-4718-96e4-ee93e412daca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba99448e-dc8e-4718-96e4-ee93e412daca?resizing_type=fit)
6. Drag off the **Multiply** node and connect to the **Emissive Color input** on the material root node.

The emissive node graph is complete.

## Cut a Mesh in Half

Next, create the location graph that targets the mesh location to remove the parts of the mesh from the project.

This effect is created by automatically cutting the mesh in half using the material’s [world position](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#world-space) data to transform the material on the mesh in the specified direction input into the node graph.

[![The material cuts the mesh in half.](https://dev.epicgames.com/community/api/documentation/image/45a24436-aafe-4fd5-aa45-e52ba3944bd6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/45a24436-aafe-4fd5-aa45-e52ba3944bd6?resizing_type=fit)

Create and open a new **Material**, and add a **Constant3Vector** material node to the graph. Add a color to the node, then drag off the Constant3Vector node and plug it into the **Base Color input** on the Main Material node.

Create a material function node by right-clicking in the Material Editor and typing **Functions** in the search bar. Select the **MaterialFunctionCall** option. The **Unspecified Function** node appears in the Material Editor.

You cannot search for a specific material function in the Material Editor. Instead, you have to create an unspecified material function node and assign a function to it.

[![Create an Unspecified Function node in the Material Editor.](https://dev.epicgames.com/community/api/documentation/image/78f97242-6947-43e5-b2c7-89d32ffbc141?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/78f97242-6947-43e5-b2c7-89d32ffbc141?resizing_type=fit)

Select the Unspecified Function node and in the Details Panel assign the **ObjectLocalBounds** material function from the **Material Function** dropdown menu. The Object material function node automatically appears in the Material Editor.

1. Add the following nodes to the Material Editor:

   1. **WorldPosition** node
   2. **TransformPosition** node
   3. **Constant** node
   4. **Add** node
   5. **Clamp** node
   6. **Component Mask** node
   7. **Multiply** node
   8. 2 X **Subtract** node
2. Drag off the **WorldPosition** node and plug into the **TransformPosition** node.
3. Select the **TransformPosition** node and change the **Material Expression Transform Position** values to the following:

   1. **Source** = Absolute World Space
   2. **Destination** = Local Space

   [![Change the Material Expression Transform Position values.](https://dev.epicgames.com/community/api/documentation/image/5a65eb99-d511-48ec-934c-02cc588bc1b8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a65eb99-d511-48ec-934c-02cc588bc1b8?resizing_type=fit)
4. Drag off the **TransformPosition** node and plug into the **A input** on the first **Subtract** node.
5. Drag off the **Local Bounds Minimum** pin from the **ObjectLocalBounds** node and plug into the **B input** on the first **Subtract** node.
6. Drag off the first **Subtract** node and plug into the **A input** on the **Multiply** node.
7. Change the **B input** value on the **Multiply** node to **-1.0**.
8. Drag off the **Multiply** node and plug into the **A input** on the **Add** node.
9. Drag off the **Local Bounds Max** pin from the **ObjectLocalBounds** node and plug into the **B input** on the **Add** node.
10. Drag off the **Add** node and plug into the **A input** on the second **Subtract** node.
11. Right-click on the **Constant** node to change it into a Parameter node. Name the Parameter node **ObjectClip**.
12. Set the value for **ObjectClip** to **0.0**.
13. Drag off **ObjectClip** and plug into the **B input** on the second **Subtract** node.
14. Drag off the **Subtract** node and plug into the **Component Mask** node.
15. Select the **Component Mask** node and change the **Material Expression Component Mask** values to **G** and **B** in the Details panel.
16. Drag off the **Mask** node and plug into the **white input** on the **Clamp** node.
17. Change the **Max input** value of the **Clamp** node to **1.0**.
18. Drag off the **Clamp** node and plug into the **Opacity Mask**.

    [![Final configuration of nodes to create the cut effect on the mesh.](https://dev.epicgames.com/community/api/documentation/image/6dc183b0-b4b8-4dd6-b2c1-4ce2c8a8c613?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6dc183b0-b4b8-4dd6-b2c1-4ce2c8a8c613?resizing_type=fit)

    *Click image to enlarge.*
19. Click **Apply**.

Changing the negative B values in the ObjectClip node restores the object and positive values remove more of the object. The range of the clip is also non-normalized so the values are dependent on the scale of the object the material is assigned to.

## Next Section

[![Animate Materials](https://dev.epicgames.com/community/api/documentation/image/38463471-1665-4f21-a8e1-9473e881532e?resizing_type=fit&width=640&height=640)

Animate Materials

Learn how to animate materials to create effects for a mesh's surface.](https://dev.epicgames.com/documentation/en-us/fortnite/animate-materials-in-unreal-editor-for-fortnite)
