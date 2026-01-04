# Light Effects

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-light-effects-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:02:47.605154

---

Light effects can be used in a number of ways; to draw the player’s attention to something important on the island or to create a specific atmosphere, such as a ghostly setting.

Before beginning this tutorial, refer to [**Using the Emissive Input**](https://docs.unrealengine.com/5.0/en-US/using-the-emissive-material-input-in-unreal-engine/) documentation from the Unreal Engine documentation site for background knowledge for this workflow.

## Basic Material Node Set Up

Follow along below for a basic tutorial on how to create a pulsing light beacon.

1. Create a new material in your project, then double-click the **material thumbnail** to open the **Material Editor**.
2. Add the following nodes:

   1. **Time** node
   2. **Sine** node
   3. **Constant3Vector** node
   4. **ComponentMask** node
   5. **TextureCoordinate** node
   6. **ConstantBiasScale** node
   7. **MaterialFunctionCall** node
   8. **Saturate** node
   9. 2 X **OneMinus** node
   10. 2 X **Abs** node
   11. 2 X **Vertex NormalWS** node
   12. 5 X **Multiply** node
3. Change the mesh to a **Cylinder** in the **Preview window**.

   [![Change the mesh in the preview window to a cylinder.](https://dev.epicgames.com/community/api/documentation/image/19769a7f-205e-49a8-8f9a-93b88b0777d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19769a7f-205e-49a8-8f9a-93b88b0777d0?resizing_type=fit)
4. Add a color to the **Constant 3Vector expression** node and plug it into the **B** input of the first **Multiply** node.
5. Right-click the **Constant 3Vector expression** node to change it to a **Parameter** node, then plug the **bottom** input into the **B** input on the first **Multiply** node.
6. Drag off the **top** output of the **Constant 3Vector expression** node and plug it into the **A** input of the first **Multiply** node and the **Base Color input** on the **Main Material Node**.
7. Drag off the **Multiply** node and plug it into the **Emissive Color** input on the **Main Material** node.

   [![See how the emissive input turns the cylinder from yellow to a yellow light effect.](https://dev.epicgames.com/community/api/documentation/image/7b0037d7-036d-4744-8fe5-43e5412a3465?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7b0037d7-036d-4744-8fe5-43e5412a3465?resizing_type=fit)

This configuration creates the base color and multiplies the light effect on the emissive input. You can change the brightness of the color by changing the numerical value of the **Alpha** input in **Material Expression Vector Parameter** in the **Details** panel.

[![Changing the Alpha value in the details panel determines the brightness of the emissive input.](https://dev.epicgames.com/community/api/documentation/image/91fdefc0-0258-40a3-a3e1-3c57c7d08f64?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/91fdefc0-0258-40a3-a3e1-3c57c7d08f64?resizing_type=fit)

## Material Function Call Set Up

The **MaterialFunctionCall** node provides a way to use material functions in a material. To create the shape of the light material, a material function called **BreakOutFloat2Component** is used to determine how much space the vertices of the material occupy.

To use the material function, do the following:

1. Select the **MaterialFunctionCall** (UnspecifiedFunction) node in the material graph to open the node's options in the Details panel.

   [![An example of the MaterialFunctionCall node.](https://dev.epicgames.com/community/api/documentation/image/be3581e6-725d-460b-b630-ed7a21f501cc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/be3581e6-725d-460b-b630-ed7a21f501cc?resizing_type=fit)

   MaterialFunctionCall node
2. From the **Details** panel, click the **Material Function** dropdown menu and select **BreakOutFloat2Component**.

   [![Open the Material Function dropdown menu and search for BreakOutFloat2Component.](https://dev.epicgames.com/community/api/documentation/image/521eccfa-b301-4834-beed-5d9bb953c101?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/521eccfa-b301-4834-beed-5d9bb953c101?resizing_type=fit)

   Select BreakOutFloat2Component node

   The UnspecifiedMaterial node turns into the BreakOutFloat2Component node.

   [![The MaterialFunctioonCall node turns into the node selected from the Material Function dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/1b6c276e-f952-414a-a391-e6d8cf008f88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1b6c276e-f952-414a-a391-e6d8cf008f88?resizing_type=fit)

   BreakOutFloat2Component node

## Material Light Effect

Now the mesh is ready for material effects to be applied.

1. Drag off the **TextureCoordinate** node and plug it into the **BreakOutFloat02Components** node. This configuration determines how much space the vertices occupy.
2. Drag off the **G** output from the **BreakOutFloat02Component** node and plug it into the **ConstantBiasScale** node. This provides a parameter for the texture space between -1 and +1.
3. Expand the **ConstantBiasScale** node and change the **Bias** value to **-0.5** and the **Scale** value to **2.0**.
4. Drag off the **ConstantBiasScale** node and plug it into the first **Abs** node. This converts all negative values into positive values.
5. Drag off the first **Abs** node and plug it into the **1 Minus** node.
6. Drag off the **1 Minus** node and plug it into the second **Multiply** node **A** and **B** inputs. This inverts the values of the Y- and X-axes.
7. Drag off the second **Multiply** node and plug it into the third **Multiply** node **A** input.

   [![All nodes are plugged into one another and are awaiting the third configuration.](https://dev.epicgames.com/community/api/documentation/image/1fd0c862-01f8-42a8-966e-ff3de1f65489?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1fd0c862-01f8-42a8-966e-ff3de1f65489?resizing_type=fit)
8. Select the **Main Material Node**, in the **Details** panel select **Blend Mode** > **Translucent**.

   [![Change the Blend Mode to Translucent](https://dev.epicgames.com/community/api/documentation/image/f0d1d8ca-f7ba-4c98-91c3-fc9e8327f64f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f0d1d8ca-f7ba-4c98-91c3-fc9e8327f64f?resizing_type=fit)
9. Drag off the third **Multiply** node and plug into the **Opacity** input on the main root node.

This configuration keeps the cylinder shape intact as the fading effect is applied to the top of and bottom of the cylinder.

[![The top of the cylinder now fades away.](https://dev.epicgames.com/community/api/documentation/image/50651838-61e2-4753-b04e-ce36893683c0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/50651838-61e2-4753-b04e-ce36893683c0?resizing_type=fit)

## Material Shape Effect

1. Drag off the **VertexNormalWS** node and plug it into the **ComponentMask** node.
2. Select the **ComponentMask** node, check only the **B** input in **Material Expression Component Mask** in the **Details** panel.
3. Drag off the **ComponentMask** node and plug it into the second **Abs** node.
4. Drag off the second **Abs** node and plug it into the **Saturate** node.
5. Drag off the **Saturate** node and plug it into the **OneMinus** node.
6. Drag off the **1 Minus** node and plug it into the **B** input on the third **Multiply** node.

   [![All nodes are plugged into one another and then plugged into the main root node.](https://dev.epicgames.com/community/api/documentation/image/88f78aa8-2085-4dc6-a9fc-72201edc503b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88f78aa8-2085-4dc6-a9fc-72201edc503b?resizing_type=fit)

Although the Opacity input isn’t highlighted, the cylinder changes shape in the preview window. It’s now shaped like a light beam from a flashlight.

[![The cylinder has changed shape in the preview window.](https://dev.epicgames.com/community/api/documentation/image/eb00657d-2532-4010-a569-2f8665155a03?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb00657d-2532-4010-a569-2f8665155a03?resizing_type=fit)

## Material Pulse Effect

1. Drag off the **Time** node and plug it into the **Sine** node.
2. Drag off the **Sine** node and plug it into the fourth **Multiply** node **A** input.
3. Drag off the **Constant** node and plug it into the **Multiply** node **B** input and change the numerical value to **15.0**. This provides the scale for the pulsing effect.
4. Drag off the fourth **Multiply** node and plug it into the fifth **Multiply** node **A** input.
5. Drag off the **VertexNormalWS** node and plug it into the fifth **Multiply** node **B** input. This scales the pulsing according to the vertex normals of the mesh.
6. Drag off the fifth **Multiply** node and plug it into the **World Position Offset** input on the Material root node.

   [![All nodes are plugged into one another and then plugged into the main root node.](https://dev.epicgames.com/community/api/documentation/image/88979af0-bd7e-4a0c-a425-620d0af0ed5c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88979af0-bd7e-4a0c-a425-620d0af0ed5c?resizing_type=fit)

Now the cylinder pulses in time to the sine wave.

[![The cylinder pulses in time to the sine wave.](https://dev.epicgames.com/community/api/documentation/image/6c563ee7-d97b-4299-83a8-3b058f7d9c65?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c563ee7-d97b-4299-83a8-3b058f7d9c65?resizing_type=fit)

Apply this effect to a mesh in the viewport. You can edit the speed of the sine wave to create a slower pulse of light.
