# 3. Create a Portal Material

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/mystic-portal-3-create-portal-material-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:41:09.125998

---

To make the swirl inside the portal, you need to create a material and use it on a Static Mesh disc. To make the swirl material, you can use the provided Green\_Layer\_Swirl.png below, or create your own swirling image and [import it into your UEFN project](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite).

[![Download this image to use in the swirl material.](https://dev.epicgames.com/community/api/documentation/image/2cb78bbc-905d-4347-aec0-49355744d51d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2cb78bbc-905d-4347-aec0-49355744d51d?resizing_type=fit)

## Creating a Swirling Material

Open the Content Browser in the editor and follow these steps to create a material.

1. In the **Content Browser** right-click to open the context menu.
2. Select **Material** from the context menu. A Material thumbnail appears in the Content Browser.

   [![Right-click to open the context menu and select Material from the context menu.](https://dev.epicgames.com/community/api/documentation/image/793e6fd0-1d4f-42b0-a645-ff9a148e779d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/793e6fd0-1d4f-42b0-a645-ff9a148e779d?resizing_type=fit)
3. Name the Material **Mystic\_Swirl\_Mat**.

   [![Name the Material Refraction_Mat.](https://dev.epicgames.com/community/api/documentation/image/a7e03719-acc5-4737-9b5c-b931f2524c81?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a7e03719-acc5-4737-9b5c-b931f2524c81?resizing_type=fit)

## Creating the Main Configuration

Open the Material editor to build the portal material. You’ll need to create 3 main configurations of nodes, then group the nodes by turning Constant material nodes into parameters to control the material color, rotation speed, and opacity.

1. Double-click the Material thumbnail to open the Material editor.

   [![Double-click the Material thumbnail to open the Material Editor.](https://dev.epicgames.com/community/api/documentation/image/b3ec245e-1178-4993-a3da-c340c33b3f84?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3ec245e-1178-4993-a3da-c340c33b3f84?resizing_type=fit)
2. Add the following material nodes to the material graph:

   - Texture Sample
   - Rotator
   - Time
   - Constant3Vector
   - Clamp
   - 2 x Add
   - 4 x Constant
   - 5 x Multiply

     [![An example of the completed Material Graph.](https://dev.epicgames.com/community/api/documentation/image/a52ac648-7982-42dc-b4b3-ef315ae2158b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a52ac648-7982-42dc-b4b3-ef315ae2158b?resizing_type=fit)

     *Click image to enlarge.*
3. On the **Time** node, drag off the pin and plug it into the **A** input on the Multiply node. On the **Constant** node, drag off the pin and plug it into the **B** input on the Multiply node.

   [![Drag off the Time pin and plug it into the A input on the Multiply node, then drag off the Constant node and plug it into the B input on the Multiply node.](https://dev.epicgames.com/community/api/documentation/image/71b7b2bc-a7b5-497a-8644-efa6621f4073?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/71b7b2bc-a7b5-497a-8644-efa6621f4073?resizing_type=fit)

   This node section controls the timing of the material.
4. On the **Multiply** node, drag off the pin and plug it into the **Time** input on the Rotator node.

   [![Drag off the Multiply pin and plug it into the Time input on the Rotator node.](https://dev.epicgames.com/community/api/documentation/image/a6861dd5-ddaf-4c64-b4a9-1b69e620a244?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a6861dd5-ddaf-4c64-b4a9-1b69e620a244?resizing_type=fit)

   The multiply node takes the Constant node value and multiplies it by Time on the rotator node. This determines the speed the material turns.
5. Select the **Texture** node in the material graph and the Texture node options appear in the Details panel.
6. In the Details panel, add the **Green\_Layer\_Swirl.png** to the **Texture** option. The swirl texture is added to the Texture node.
7. On the **Rotator** node, drag off the pin and plug it into the **UV** input on the Texture Sample node.

   [![Drag off the Rotator pin and plug it into the UV input on the Texture Sample node.](https://dev.epicgames.com/community/api/documentation/image/eaaf14f4-afd9-423e-8c90-f954cf2dafc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eaaf14f4-afd9-423e-8c90-f954cf2dafc0?resizing_type=fit)

   This Rotator node targets the UVs of the texture and determines how quickly the UVs rotate.
8. On the Texture Sample node, drag off the **Red** pin and plug it into the **A** input on the Second Multiply node. Drag off the second **Constant** node pin and plug into the **B** input on the Multiply node.

   [![Drag off the Red pin and plug it into the A input on the Second Multiply node. Drag off the second Constant node pin and plug into the B input on the Multiply node.](https://dev.epicgames.com/community/api/documentation/image/4b749260-334e-49bb-b860-9fe08ff0e81a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4b749260-334e-49bb-b860-9fe08ff0e81a?resizing_type=fit)

   The opacity of the texture’s Red channel is controlled by the value entered on the Constant node. The Red channel opacity value is then multiplied by the Multiply node.
9. Click and drag to select the entire node configuration, then press **Ctrll + C** to copy the configuration and **Ctrl + V** to paste the configuration two more times.

   The first configuration set controls the values for the Core material, the second configuration set controls the values for the Vortex, the last configuration set controls the values for the Sparks.
10. On the **Multiply** node at the end of the connection of the second configuration, right-click the **A** input on the **Multiply** node and select **Break This Link** from the context menu. This disconnects the Texture node from the Multiply node.
11. On the Texture node of the second configuration, drag off the **Green** pin and plug it into the **A** input on the Multiply node. This connects the G channel of the texture to the Multiply node.

    [![Drag off the Green pin and plug it into the A input on the Multiply node.](https://dev.epicgames.com/community/api/documentation/image/051324dd-3cdf-4cd6-b245-dae1ff90302e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/051324dd-3cdf-4cd6-b245-dae1ff90302e?resizing_type=fit)

    The opacity value of the texture’s Green channel is now targeted by the Constant node and the Multiply node.
12. On the **Multiply** node, at the end of the connection of the third configuration, right-click the **A** input on the **Multiply** node and select **Break This Link** from the context menu. This disconnects the Texture node from the Multiply node.
13. On the Texture node, drag off the **Blue** pin and plug it into the **A** input on the Multiply node. This connects the B channel of the texture to the Multiply node.

    [![Drag off the Blue pin and plug it into the A input on the Multiply node.](https://dev.epicgames.com/community/api/documentation/image/088c8a61-ff4e-4837-9c78-3fb1c10c6b39?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/088c8a61-ff4e-4837-9c78-3fb1c10c6b39?resizing_type=fit)

    The opacity value of the texture’s Blue channel is now targeted by the Constant node and the Multiply node.

## Creating Parameter Groups

The material is controlled through parameter groups that determine the rotation speed, opacity, and color. They also provide a way to easily adjust these levels when you create a Material Instance from the Mystic Swirl Material.

To control parameters, you will turn the Constant nodes into named parameters.

### Color Group

1. Select the **Constant3Vector** node in the material graph. In theDetails panel, click the **Constant** option to select a color from the Color Picker. Click OK to use the selected color.
2. On the Constant3Vector node, drag off the **white** pin and plug it into the **A** input on a Multiply node. Drag off a **Constant** node and plug it into the **B** input on the Multiply node.

   [![On the Constant3Vector node,drag off the white pin and plug it into the A input on a Multiply node. Then drag off a Constant node and plug it into the B input on the Multiply node.](https://dev.epicgames.com/community/api/documentation/image/82d29310-7d36-4c1a-aa53-423aec6412a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82d29310-7d36-4c1a-aa53-423aec6412a9?resizing_type=fit)

   These nodes control the emissive color of the material.
3. On the **Constant3Vector** node, right-click and select **Convert to Parameter** from the context menu. Name the new parameter **Color**. In the Details panel, change the following options:

   - **Group** = **1**
   - **Set Priority** = **1**

   [![In the Details panel, change the color options Group and Set Priority to 1.](https://dev.epicgames.com/community/api/documentation/image/d2767dcb-eb8c-4e73-b65b-1f737c80d5a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d2767dcb-eb8c-4e73-b65b-1f737c80d5a2?resizing_type=fit)
4. On the Constant node, set the Value to **0.5**. Right-click and select **Convert to Parameter** from the context menu. Name the new parameter **Emissive Color**. In the Details panel, change the following options:

   - **Group** = **1**
   - **Set Priority** = **2**

   [![Convert the Constant node into a parameter and set the Default Value to 0.5, Group to 1, and Sort Priority to 1.](https://dev.epicgames.com/community/api/documentation/image/20bdcb67-7bfd-4aa4-ad70-78ba6f5c1ce1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/20bdcb67-7bfd-4aa4-ad70-78ba6f5c1ce1?resizing_type=fit)

### Speed Group

1. Select the Constant node on the end of the first configuration, then right-click and select **Convert to Parameter** from the context menu. Name the new parameter **Core Rotation Speed**. In the Details panel, set the following parameter options:

   - **Default Value** = **30.0**
   - **Group** = **2**
   - **Set Priority** = **1**

   [![Convert the first Constant node on the first configuration into a parameter and set the Default Value to 30.0, Group to 2, and Set Priority to 1.](https://dev.epicgames.com/community/api/documentation/image/ed3fb554-ee7b-4f2a-ba19-2b594096d48f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ed3fb554-ee7b-4f2a-ba19-2b594096d48f?resizing_type=fit)

   This controls the speed the UVs of the main material turn.
2. Select the Constant node on the end of the second configuration, then right-click and select **Convert to Parameter** from the context menu. Name the new parameter **Vortex Rotation Speed**. In the Details panel, set the following parameter options:

   - **Default Value** = **-5.0**
   - **Group** = **3**
   - **Set Priority** = **2**

   [![Convert the first Constant node on the second configuration into a parameter, set the Default Value to -5.0, Group to 2, and Set Priority to 2.](https://dev.epicgames.com/community/api/documentation/image/e5685e11-20a8-493f-9c3e-6d0d4f602938?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e5685e11-20a8-493f-9c3e-6d0d4f602938?resizing_type=fit)

   This controls the speed the UVs of the vortex material turn.
3. Select the Constant node on the end of the third configuration, then right-click and select **Convert to Parameter** from the context menu. Name the new parameter **Spark Rotation Speed**. In the Details panel, set the following parameter options:

   - **Default Value** = **3.0**
   - **Group** = **3**
   - **Set Priority** = **3**

   [![Convert the first Constant node on the third configuration into a parameter and set the Default Value to -5.0, Group to 2, and Set Priority to 3.](https://dev.epicgames.com/community/api/documentation/image/f008136a-674a-48e5-a0a0-04dd902a9d7a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f008136a-674a-48e5-a0a0-04dd902a9d7a?resizing_type=fit)

   This controls the speed the UVs of the spark material turn.

### Opacity Group

1. Select the second Constant node at the beginning of the first configuration, then right-click and select **Convert to Parameter** from the context menu. Name the new parameter **Core Opacity**. In the Details panel, set the following parameter options:

   - **Default Value** = **1.0**
   - **Group** = **2**
   - **Set Priority** = **1**

   [![Convert the last Constant node on the first configuration into a parameter, then set the Default Value to 1.0, Group to 2, and Set Priority to 1.](https://dev.epicgames.com/community/api/documentation/image/e7e44332-c3ff-4d84-b103-08debf1c6e68?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7e44332-c3ff-4d84-b103-08debf1c6e68?resizing_type=fit)

   This controls the opacity levels for the core material.
2. Select the second Constant node at the beginning of the second configuration, then right-click and select **Convert to Parameter** from the context menu. Name the new parameter **Vortex Opacity**. In the Details panel, set the following parameter options:

   - **Default Value** = **1.0**
   - **Group** = **2**
   - **Set Priority** = **2**

   [![Convert the last Constant node on the second configuration into a parameter and set the Default Value to 1.0, Group to 2, and Set Priority to 2.](https://dev.epicgames.com/community/api/documentation/image/f5266fa9-8fd0-4cfb-977a-a7ff30155149?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f5266fa9-8fd0-4cfb-977a-a7ff30155149?resizing_type=fit)

   This controls the opacity levels for the vortex material.
3. Select the second Constant node at the beginning of the second configuration, then right-click and select **Convert to Parameter** from the context menu. Name the new parameter **Spark Opacity**. In the Details panel, set the following parameter options:

   - **Default Value** = **1.0**
   - **Group** = **2**
   - **Set Priority** = **3**

   [![Convert the last Constant node on the third configuration into a parameter and set the Default Value to 1.0, Group to 2, and Set Priority to 3.](https://dev.epicgames.com/community/api/documentation/image/1fb1be50-7d74-4f6e-a6c1-4c4d73d05b7a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1fb1be50-7d74-4f6e-a6c1-4c4d73d05b7a?resizing_type=fit)

   This controls the opacity level for the spark material.

## Set Up the Main Material Node

To test your material at this stage, you need to set up the Main Material Node (MMN). Select the MMN. In the Details panel, set the following options:

- **Blend Mode** = **Additive**
- **Shading Model** = **Unlit**
- **Two Sided** = **Enable**

This enables the Opacity input and disables other input options you don’t need. It also makes the material cover both sides of the Static Mesh so the portal swirl can be seen on both sides.

[![In the Details panel, set the Blend Mode to Additive and the Shading Model to Unlit.](https://dev.epicgames.com/community/api/documentation/image/a5c0e598-7a19-4d24-ba5e-a6a438582d6a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a5c0e598-7a19-4d24-ba5e-a6a438582d6a?resizing_type=fit)

In the viewport, select the cube mesh to preview the material. Separately plug each node configuration into the MMN by dragging off the last **Multiply** node pin and plugging into the **Emissive Color** and **Opacity** inputs on the MMN. This shows you how each layer of the material behaves.

You’ll need to move the viewport camera to view the material on the cube surface.

| Configurations | GIF |
| --- | --- |
| **Core Configuration** |  |
| **Vortex Configuration** |  |
| **Spark Configuration** |  |

## Clamping the Groups Together

All node configurations and color groups must be added together. You’ll also add a Constant node to control the overall opacity of the material by turning it into a parameter. Last of all, you will clamp these configurations and the Overall Opacity together to control the different layers and color of the swirling material.

1. Place an **Add** node between the **Core** node configuration and the **Vortex** node configuration. Drag off the **Core Multiply** pin and plug it into the **A** input on the Add node, then drag off the **Vortex Multiply** pin and plug it into the **B** input on the Add node.

   [![Drag off the Core Multiply pin and plug it into the A input on the Add node, then drag off the Vortex Multiply pin and plug it into the B input on the Add node.](https://dev.epicgames.com/community/api/documentation/image/35967534-b20a-4e56-8b0c-c65a8e6816b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/35967534-b20a-4e56-8b0c-c65a8e6816b6?resizing_type=fit)

   This layers the Core material and the Votex material by adding themtogether.
2. Place a second **Add** node between the first Add node and the Spark node configuration. Drag off the first **Add** pin and plug it into the **A** input on the second Add node, then drag off the **Spark Multiply** pin and plug it into the **B** input on the second Add node.

   [![Drag off the first Add pin and plug it into the A input on the second Add node, then drag off the Spark Multiply pin and plug it into the B input on the second Add node.](https://dev.epicgames.com/community/api/documentation/image/8adc1307-0891-4b58-af89-27b3ce785a1d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8adc1307-0891-4b58-af89-27b3ce785a1d?resizing_type=fit)

   This adds the Spark material as a third layer to the material through the second Add node.
3. Place a Multiply node between the Color Multiply node and the second Add node. Drag off the **Color Multiply** pin and plug it into the **A** input on the Multiply node.

   [![Drag off the Color Multiply pin and plug it into the A input on the Multiply node, then drag off the Add pin and plug it into the B input on the Multiply node.](https://dev.epicgames.com/community/api/documentation/image/7c01cd2e-e857-4a61-9816-8b6a8592d096?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7c01cd2e-e857-4a61-9816-8b6a8592d096?resizing_type=fit)
4. Right-click the Material Graph and select **Utility** > **Add Reroute Node…** from the Node options. A reroute nodule appears.
5. Drag off the **Add** pin and plug it into the input on the **reroute node**, then drag off the **reroute** pin and plug it into the **B** input on the Multiply node.
6. Place a second Multiply node between the first Multiply node and the reroute node. Drag off the **reroute** pin and plug it into the **A** input on the second Multiply node.

   [![Drag off the reroute pin and plug it into the A input on the second Multiply node.](https://dev.epicgames.com/community/api/documentation/image/d305a0c2-e11f-4524-925a-a93ba40ff267?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d305a0c2-e11f-4524-925a-a93ba40ff267?resizing_type=fit)
7. Behind the second Multiply node, press **1** and **left-click** to place a Constant node, then drag off the **Constant** pin and plug it into the **B** input on the Multiply node. Right-click the Constant node and select **Convert to Parameter** from the context menu. Name the parameter **Overall Opacity**.
8. On the first Multiply node, drag off the **Multiply** pin and plug it into the **Emissive Color** output on the MMN.

   [![Drag off the Multiply pin and plug it into the Emissive Color output on the MMN.](https://dev.epicgames.com/community/api/documentation/image/59e5431e-10a2-47ec-840c-d9335999332d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/59e5431e-10a2-47ec-840c-d9335999332d?resizing_type=fit)
9. Place a **Clamp** node in front of the second **Multiply** node, then drag off the **Multiply** pin and plug it into the **blank** input on the Clamp node.

   [![Drag off the Multiply pin and plug it into the blank input on the Clamp node.](https://dev.epicgames.com/community/api/documentation/image/d912b26e-d665-4458-875a-1e6f5c291dbb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d912b26e-d665-4458-875a-1e6f5c291dbb?resizing_type=fit)
10. On the Clamp node, drag off the **Clamp** pin and plug it into the **Opacity** input on the MMN.

    [![Drag off the Clamp pin and plug it into the Opacity input on the MMN.](https://dev.epicgames.com/community/api/documentation/image/1e69517d-fe85-4c80-83ff-3fcf05c59a38?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e69517d-fe85-4c80-83ff-3fcf05c59a38?resizing_type=fit)

    The viewport displays all configurations of the material swirling together at different speeds.
11. Click **Apply** > **Save** to save the material.

    [![Click Apply > Save to save the material.](https://dev.epicgames.com/community/api/documentation/image/8adf0f2a-9571-4849-8931-e72140a49319?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8adf0f2a-9571-4849-8931-e72140a49319?resizing_type=fit)
12. Exit out of the Material editor and back to the Content Browser. Right-click **Mystic\_Swirl\_Mat** and select **Create Material Instance** from the context menu. A Material Instance is created in the Content Browser.

    [![Right-click the Mystic_Swirl_Mat and select Create Material Instance from the context menu.](https://dev.epicgames.com/community/api/documentation/image/50a5bc3f-9e4c-4749-aec0-e57bd03f25c0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/50a5bc3f-9e4c-4749-aec0-e57bd03f25c0?resizing_type=fit)

Next, you’ll model a disc to place the material on.

## Next Section

[![4. Create the Portal Center](https://dev.epicgames.com/community/api/documentation/image/75ce84bd-5904-499d-bcb1-99e51473e139?resizing_type=fit&width=640&height=640)

4. Create the Portal Center

Use the refraction material in your mystical portal.](https://dev.epicgames.com/documentation/en-us/fortnite/mystic-portal-4-create-the-portal-center-in-unreal-editor-for-fortnite)
