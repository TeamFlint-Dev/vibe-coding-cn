# Editing Landscape Material

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/editing-landscape-material-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:08:47.456166

---

**Unreal Editor for Fortnite (UEFN)** has different material instances for custom terrain that you can create using [Landscape Mode](https://dev.epicgames.com/documentation/en-us/fortnite/landscape-mode-in-unreal-editor-for-fortnite). The **Paint** tools in **Landscape Mode** provide a way to edit the top layer of your terrain. Select from the following material instances for your terrain:

- MI\_Landscape\_Chpt2 (Apollo)
- MI\_Landscape\_Chpt4 (Asteria)
- MI\_Fortnite\_Customizable\_01

  [![The different landscape material instances.](https://dev.epicgames.com/community/api/documentation/image/74b27f5f-d0ba-48cb-8f5c-2d92e413cd3c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/74b27f5f-d0ba-48cb-8f5c-2d92e413cd3c?resizing_type=fit)

  *From left to right, the materials are Chapter 2, Chapter 4, and Customizable.*

The Chapter 2 material instance is the classic Fortnite Battle Royale landscape [material](unreal-editor-for-fortnite-glossary#material). The Chapter 4 landscape material is from Fortnite Battle Royale Chapter 4.

Each of the Battle Royale material instances creates a grassland with flowers, and simulates wind blowing through the grass. In addition to these features, the Chapter 4 material instance auto-generates small bushes, and uses Niagara to simulate leaves blowing in the wind and butterflies flying around the terrain.

The Customizable material instance is a flat material. Use the Paint tool in Landscape Mode with this material to create wet grass, dirt patches, and more.

## Selecting the Customizable Material Instance

Use Landscape Mode to create custom terrain for your island. The **Manage** stage of creating terrain is where you decide how large to make your custom terrain, and which landscape material to assign.

Select a material instance from the **Material** dropdown menu, the material instances mentioned above can be found in this dropdown menu with many other landscape material types.

To create a custom look for your landscape material, select **MI\_Fortnite\_Customizable\_01** from the dropdown menu. This sets the customizable material for your terrain mesh, then use the Paint stage tools to open the Material Instance Editor for each layer. By editing the layer information, you can change the look of the layer.

[![Select the material instance for your terrain when creating a custom terrain.](https://dev.epicgames.com/community/api/documentation/image/ed8eaebf-1477-4544-8c8f-e8a605f1a7ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ed8eaebf-1477-4544-8c8f-e8a605f1a7ae?resizing_type=fit)

For more information on creating custom terrain, see the [Create a Custom Landscape](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-custom-landscape-in-unreal-editor-for-fortnite) tutorial.

## Painting Your Landscape Material

1. Create a new landscape using one of the three main material instances.
2. Select the individual landscape streaming proxies to change their material with the custom landscape material you created.
3. Click **Paint** from the Landscape Mode stages.
4. Scroll down to **Layers**.
5. Select any layer from the list to paint onto the landscape.
6. Select **Layer7** from the Layers list. This opens all the layer material instances in the Content Browser.

   [![Double-click the Layer7_LayerInfo thumbnail to edit the paint layer.](https://dev.epicgames.com/community/api/documentation/image/02edef34-45b8-4ec7-9681-efc54834fa91?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02edef34-45b8-4ec7-9681-efc54834fa91?resizing_type=fit)

   Some of the layers you’ll see in the Paint tool are locked and reserved for splines. When you create a path or roadway with splines, these materials are used for the spline mesh.

## Creating a Custom Landscape Material

Create a custom landscape material with layers you can use with the Paint tools to edit your terrain. You’ll create a material with three layers; mud, rock, and gravel. Create a folder to hold your materials, and create a material thumbnail by right-clicking inside the new folder.

### Base Layer

Double-click the material thumbnail to open the material graph. When the graph opens, add the following material nodes:

1. Constant 3Vector node
2. Constant node
3. SetMaterialAttributes node
4. Texture Sample node

Select the Constant 3 Vector material node and add a color. Now you’re ready to create your [node network](unreal-editor-for-fortnite-glossary#node).

1. Select the first **SetMaterialAttributes** node in the material graph.
2. Click on the **+** icon in the **Array field** in the Details panel. A Base Color array slot is created.
3. Repeat step 2 three times, creating three more array slots. As you add array slots in the details panel, the same array inputs are added to the SetMaterialAttributes node.
4. Edit the array slots so the following arrays are selected:

   1. **Base Color**
   2. **Specular**
   3. **Roughness**
   4. **Normal**
5. Change the Constant node value to **0.5**.
6. Drag off the Constant node and plug it into the **Specular input** on the SetMaterialAttributes node.
7. Drag off the Constant node again and plug it into the **Roughness input** on the SetMaterialAttributes node.
8. Drag off the **white pin** on the Constant 3Vector node and plug it into the **Base input** on the SetMaterialAttributes node.
9. Select the **Texture Sample** node.
10. Add **T\_Asteria\_Mud\_01\_N** Normal texture to the Texture slot in the Material Expression Texture Base field.
11. Drag off the **RGB output pin** on the Texture Sample node and plug it into the **Normal input** on the SetMaterialAttributes node.

    [![This is the Base material that will appear on the landscape when  no layers are painted.](https://dev.epicgames.com/community/api/documentation/image/7e8a4188-2339-490f-b73a-fcce5d89ce54?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e8a4188-2339-490f-b73a-fcce5d89ce54?resizing_type=fit)

This is the Base material that appears on the landscape when no layers are painted.

### Layer One

This next node network is the landscape material layer that sits below the landscape base material layer in [Target Layers](https://dev.epicgames.com/documentation/en-us/fortnite/landscape-mode-in-unreal-editor-for-fortnite). This network uses an optimization node, the landscape layer switch. The landscape layer switch makes the material less data-heavy on landscape components that don’t have this layer painted on them.

Add the following material nodes:

1. Constant 3Vector node
2. Constant node
3. SetMaterialAttributes node
4. Texture Sample node
5. Landscape Layer Switch node
6. Blend MaterialAttributes node
7. Landscape Layer Sample node and name it **Layer 1**

Select the Constant 3 Vector material node and add a color. Now you’re ready to create your node network.

1. Select the first **SetMaterialAttributes** node in the material graph.
2. Click on the **+** icon in the **Array field** in the Details panel. A Base Color array slot is created.
3. Repeat step 2 three times, creating three more array slots. As you add array slots in the details panel, the same array inputs are added to the SetMaterialAttributes node.
4. Edit the array slots so the following arrays are selected:

   1. **Base Color**
   2. **Specular**
   3. **Roughness**
   4. **Normal**
5. Change the Constant node’s value to **0.5**.
6. Drag off the Constant node and plug it into the **Specular input** on the SetMaterialAttributes node.
7. Drag off the Constant node again and plug it into the **Roughness input** on the SetMaterialAttributes node.
8. Drag off the **white pin** on the Constant 3Vector node and plug it into the **Base input** on the SetMaterialAttributes node.
9. Select the **Texture Sample** node.
10. Add **T\_Asteria\_RockCliff\_03\_N** Normal texture to the Texture slot in the Material Expression Texture Base field.
11. Drag off the **RGB output pin** on the Texture Sample node and plug it into the **Normal input** on the SetMaterialAttributes node.
12. Drag off the SetMaterialAttributes node and plug into the **B input** on the BlendMaterialAttributes node.
13. Drag off the Landscape Layer Sample node and plug into the **Alpha input** on the BlendMaterialAttributes node.

    \* The Landscape Layer Sample node provides the name for the paintable target layer in the landscape tool.

    \* This material node must be part of the landscape material for it to show up under Layers in the Paint tool.

    \* This node automatically samples the appropriate landscape layer mask texture and appropriate channel of the same name.

    When creating a brand new landscape LayerInfo asset, this material technique requires the layers be set to **Non Weight-Blended Layer** in Landscape Mode when using the Paint tools.
14. Drag off the first SetMaterialAttributes node from the Base Layer and plug into the **A input** on the BlendMaterialAttributes node.
15. Drag off the first SetMaterialAttributes node from the Base Layer and plug into the **LayerNotUsed input** on the Landscape Layer Switch node.
16. Select the **Landscape Layer Switch** and change the Paramter Name to **Layer 1** in the Details panel.
17. Drag off the BlendMaterialAttributes node and plug into the **Layer Used input** on the Landscape Layer Switch node.

    [![This network determines the first layer attribute in the landscape material order.](https://dev.epicgames.com/community/api/documentation/image/b3b400da-c322-43a3-b8a6-14844b193e49?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3b400da-c322-43a3-b8a6-14844b193e49?resizing_type=fit)

    *Click image to enlarge.*

In the image above reroute nodes were used to keep the Material graph organized. Reroute nodes aren’t necessary to complete this tutorial. To learn more about node connections, refer to [**Connecting Nodes**](https://docs.unrealengine.com/connecting-nodes-in-unreal-engine/) in Unreal Engine documentation.

### Layer Two

This next node network is the layer that sits below Layer 1. This network also uses the Landscape Layer Switch to make the material less data heavy on landscape components that don’t have this layer painted on them.

Add the following material nodes:

1. Constant 3Vector node
2. Constant node
3. SetMaterialAttributes node
4. Texture Sample node
5. Landscape Layer Switch node
6. Blend MaterialAttributes node
7. Landscape Layer Sample node and name it **Layer 2**

Select the Constant 3 Vector material node and add a color. Now you’re ready to create your node network.

1. Select the first **SetMaterialAttributes** node in the Material graph.
2. Click on the **+** icon in the **Array field** in the Details panel. A Base Color array slot is created.
3. Repeat step 2 three times, creating three more array slots. As you add array slots in the Details panel, the same array inputs are added to the SetMaterialAttributes node.
4. Edit the array slots so the following arrays are selected:

   1. **Base Color**
   2. **Specular**
   3. **Roughness**
   4. **Normal**
5. Change the Constant node’s value to **0.5**.
6. Drag off the Constant node and plug it into the **Specular input** on the SetMaterialAttributes node.
7. Drag off the Constant node again and plug it into the **Roughness input** on the SetMaterialAttributes node.
8. Drag off the **white pin** on the Constant 3Vector node and plug it into the **Base Color input** on the SetMaterialAttributes node.
9. Select the **Texture Sample** node.
10. Add **T\_Asteria\_FrozenGravel\_01\_N** Normal texture to the Texture slot in the Material Expression Texture Base field.
11. Drag off the **RGB pin** on the Texture Sample node and plug it into the **Normal input** on the SetMaterialAttributes node.
12. Drag off the SetMaterialAttributes node and plug into the **B input** on the BlendMaterialAttributes node.
13. Drag off the Landscape Layer Sample node and plug into the **Alpha input** on the BlendMaterialAttributes node.
14. Select the **Landscape Layer Switch** and change the Paramter Name to **Layer 2** in the Details panel.
15. Drag off the BlendMaterialAttributes node and plug into the **Layer Used input** on the Landscape Layer Switch node.
16. Drag off the first Landscape Layer Switch node and plug into the **A input** on the second BlendMaterialAttributes node.
17. Drag off the first Landscape Layer Switch node and plug into the **LayerNotUsed input** on the second Landscape Layer Switch node.

    [![This network completes Layer 2 of the landscape material.](https://dev.epicgames.com/community/api/documentation/image/eeee207c-6625-4744-9574-d1a8b31e6715?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eeee207c-6625-4744-9574-d1a8b31e6715?resizing_type=fit)

    *Click image to enlarge.*

Since Layer 2 is blended here–after Layer 1, Layer 2 will draw on top of Layer 1. The **Target Layer** arrangement in the Paint tools is irrelevant when using No-Weight Blend Layers.

To complete your material, select the Main Material Node and in the Details Panel toggle on **Use Material Attributes**.

Now drag off the **Layer 2 Landscape Layer Switch** and plug it into the **Main Material Node** to complete you custom landscape material.

The Main Material Node takes the name you assigned to the material.

[![The name of your material shows here](https://dev.epicgames.com/community/api/documentation/image/4ef3690a-bf6f-429e-af5d-e9d723034ca3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4ef3690a-bf6f-429e-af5d-e9d723034ca3?resizing_type=fit)

## Using Your Custom Landscape Material

Now you can use your custom material to paint an existing landscape on the terrain you created. Select the **Landscape Streaming Proxy** from the Outliner panel.

[![Select the parent Landscape from the Outliner panel.](https://dev.epicgames.com/community/api/documentation/image/b6f9d0f3-b641-441a-a69a-d71a85aef2b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6f9d0f3-b641-441a-a69a-d71a85aef2b7?resizing_type=fit)

Assign your custom material to the **Landscape Material slot** in the Details panel.

[![Assign your custom material to the Landscape Material slot in the Details panel.](https://dev.epicgames.com/community/api/documentation/image/68f5cf75-a7c2-49ee-8b06-31fbd6bf8515?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/68f5cf75-a7c2-49ee-8b06-31fbd6bf8515?resizing_type=fit)

Switch to **Landscape Mode** from the Selection dropdown menu and select **Paint** from the Landscape stages. From here you’ll see your new material and all its layers in the **Target Layers** menu amongst the other landscape materials.

[![The custom landscape materials dispalys in the Target Layer tool.](https://dev.epicgames.com/community/api/documentation/image/5b8edcde-7043-4c91-81d6-ce7fdd14e7c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5b8edcde-7043-4c91-81d6-ce7fdd14e7c5?resizing_type=fit)

Before you can use your custom material you have to turn each custom layer into a Non Weight-Blend Layer. To do this select the **+ icon** > **Non Weight-Blend Layer** > **Save**. Repeat this step for each layer of your custom material.

[![Turn each of your custom layers into a No Weight-Blend layer.](https://dev.epicgames.com/community/api/documentation/image/c031f16e-cb33-46e8-937e-f2184d7b6823?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c031f16e-cb33-46e8-937e-f2184d7b6823?resizing_type=fit)

Now you can paint the terrain by selecting your custom material.

## Result
