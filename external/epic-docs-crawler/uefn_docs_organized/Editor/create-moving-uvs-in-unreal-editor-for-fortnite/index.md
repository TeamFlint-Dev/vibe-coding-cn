# Moving UVs

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-moving-uvs-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:02:57.947638

---

You can create a moving material with a panning effect that causes the material to slide by using material nodes plugged into the **Base Color input** of the **Main Material** node.

Before beginning this tutorial, you should already have made a basic material using the [**Creating and Using Material Instance**](https://docs.unrealengine.com/5.0/en-US/creating-and-using-material-instances-in-unreal-engine/) page. You will expand upon your basic material with the tutorial below.

1. Add a **Panner** node to your Color node configuration above and plug it into the **UV input** of the **Texture Sample** node.
2. Change the **Speed** coordinates from **0.0** to **0.1** for the **X** coordinate.

The **Panner** node moves UV coordinates along any axis of your choosing, and pans from any direction, based on the numerical values you add to the **Speed** axis coordinates. But you can do even more dynamic movements in your base material by adding a few more material nodes.

Adding a noise on top of the Panner node and the configuration above can add another layer of movement to the base material.

1. Add these nodes to the configuration above:

   - **Add** node
   - **Time** node
   - **Texture Sample** node
2. Add a noise to the **Texture Sample** node to cause a texture effect as the color shifts.
3. Drag off one of the color output pins from the **Texture Sample** node and plug it into the **A input** of the **Add** node.
4. Drag off the **Time** node and plug it into the **B input** on the **Add** node.
5. Drag off the **Add** node and plug it into one of the inputs on the left side of the **Panner** node to see what effect it creates.

The noise added to the texture causes the texture to move by distorting the UVs used to sample the texture, but the movement only occurs within the boundaries of the mesh, but to cause the material to move off of the mesh, you need to use a different set of nodes and configurations.
