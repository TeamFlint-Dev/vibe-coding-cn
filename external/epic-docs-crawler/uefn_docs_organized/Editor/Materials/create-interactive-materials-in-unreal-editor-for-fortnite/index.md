# Interactive Materials

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-interactive-materials-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:03:03.381296

---

An interactive material reacts on a mesh when it intersects with or is in close proximity to another mesh. This effect is achieved using a **Distance field**.

Below are three ways to create a reactive material:

- Using distance to create a mask that changes the color of a mesh,
- Using a sine wave to cause ripples on the surface of the mesh where the two meshes intersect, and
- Using a vector mask to cause the mesh surface to pull toward another mesh in close proximity and drape over the intersecting mesh.

The DistancetoNearestSurface node only works on platforms that have distance fields enabled. Therefore, the material may not work as expected on low performance PCs and mobile because distance field computation is often either a performance bottleneck, because of high-resolution fields, or a nearly impossible task because of degeneracies in input meshes.

Therefore, use the **ShadingPathSwitch** to force the shaders in the **DistancetoNearestSurface** to work as configured with mobile platforms and low performance PCs.

First, start by making a material that changes color when it intersects with another mesh:

1. Create a new material in the **Content Browser** and double-click the **material thumbnail** to open the **Material Editor**.
2. Create the following nodes:

   1. **DistancetoNearestSurface** node
   2. **ShadingPathSwitch** node
   3. **Divide** node
   4. **Saturate** node
   5. **OneMinus** node
   6. **Time** node
   7. **Sine** node
   8. **Add** node
   9. **VertexNormalWS** node
   10. **Mask** node
   11. 3 X **Multiply** node
3. Drag off the **DistancetoNearestSurface** node and plug into the **Default** input on the **ShadingPathSwitch** node.
4. Select the **Divide** node and change the **ConstB input** value to 50.0. This determines the distance between objects for the effects to take place.

   [![Change the ConstB value in the Details panel to 50.0.](https://dev.epicgames.com/community/api/documentation/image/4f45b61d-2615-42f6-87ca-281c57871b22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f45b61d-2615-42f6-87ca-281c57871b22?resizing_type=fit)
5. Drag off the **Divide** node and plug it into the **Mobile** input on the **ShadingPathSwitch**. This will ensure that the shading mask will work properly across all platforms.
6. Drag off the **ShadingPathSwitch** node plug into the **Saturate** node. This saturates the color on the mesh.
7. Drag off the **Saturate** node and plug it into the **OneMinus** node. This inverts the shaders on the mesh.
8. Drag off the **OneMinus** node and plug it into the **Base Color** input on the material root node.

   [![The previous steps create a distance field configuration.](https://dev.epicgames.com/community/api/documentation/image/a2d71a67-be97-4e8b-8ae2-de13c75451e5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2d71a67-be97-4e8b-8ae2-de13c75451e5?resizing_type=fit)

This creates the basis for the distance field configuration with a mathematical representation of distance between objects. The shaders create a masking effect on the mesh. Try this out on a mesh by intersecting that mesh into another mesh to see how the material reacts.

Notice how the material creates a line around the shape of the automobile the closer it gets.

### Rippling Effect

Now create the second configuration of the reactive material:

1. Drag off the **Time** node and plug into the **B** input of the **Add** node.
2. Drag off the **Add** node and plug into the **Sine** node.
3. Drag off the **Sine** node and plug into the **B** input of the first **Multiply** node.
4. Select and expand the **Sine** node and change the **Period** value to **0.2**.
5. Drag off the **OneMinus** node and plug into the **A** input of the first **Multiply** node.
6. Drag off the first **Multiply** node and plug into the **Base Color** input on the material root node. This will break the link between the **OneMinus** node and the material root node.

   [![This is what the second configuration looks like.](https://dev.epicgames.com/community/api/documentation/image/fab41bb9-31c8-485b-b0fe-41df871d5c08?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fab41bb9-31c8-485b-b0fe-41df871d5c08?resizing_type=fit)

This configuration applies color to the mesh that is now reactive, using the previous configuration of the distance field. The material interacts with the environment and meshes around it. When the mesh intersects with another mesh, the material causes ripples along the surface.

This configuration is commonly used to create water.

### Enveloping Effect

Now to create the third configuration of the reactive material:

1. Drag off the **OneMinus** node and plug into the **Base Color** input on the material root node. This breaks the link between the first **Multiply** node and the material root node.
2. Drag off the **VertextNormalWS** node and plug into the **Mask** node.
3. Drag off the **Mask** node and plug into the **A** input on the second **Multiply** node.
4. Select and expand the second **Multiply** node, change the **B** input value to **50.0**.
5. Drag off the second **Multiply** node and plug into the **B** input of the third **Multiply** node.
6. Drag off the **OneMinus** node from the first configuration and plug into the **A** input of the third **Multiply** node.
7. Drag off the third **Multiply** node and plug into **World Position Offset** input on the material root node.

[![This is what the second configuration should look like.](https://dev.epicgames.com/community/api/documentation/image/c4422ec8-1baa-4f95-af1d-51df1b073688?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c4422ec8-1baa-4f95-af1d-51df1b073688?resizing_type=fit)

This is what the second configuration should look like.

[![The sphere in the preview window appears spikey.](https://dev.epicgames.com/community/api/documentation/image/04b2c356-4576-4aaa-a4dc-589bacdb6910?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/04b2c356-4576-4aaa-a4dc-589bacdb6910?resizing_type=fit)

Notice how the material in the preview window changes to appear spikey. When applied to the mesh, the mesh’s shape also changes. As the mesh is moved closer to the automobile, the material causes the mesh to wrap around the vehicle.
