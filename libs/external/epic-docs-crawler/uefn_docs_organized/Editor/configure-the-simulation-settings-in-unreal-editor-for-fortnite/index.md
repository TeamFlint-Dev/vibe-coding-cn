# Configure the Simulation Settings

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/configure-the-simulation-settings-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:18:11.645957

---

To configure your simulation settings, you first need to set the proxy deformer. Then you can simulate collision and set up the solver, which controls the quality of the simulation.

## Set the Proxy Deformer

In this section, you will set up the **Proxy Deformer**. This deformer uses the simulation mesh to deform the render mesh. You will also set up two selections for the jacket and holster to make sure they do not interfere with each other during simulation.

1. Drag from the **Collection** pin and search for then select **WeightMapToSelection**, then connect the **Name** pin of the **MaxDistance Weight Map** to the **Weight Map Name** pin of the **WeightMapToSelection** node. The WeightmapToSelection node converts the painted weight map into a selection of vertices that can be processed by the Proxy Deformer.

   [![Add a WeightMapToSelection node and connect it to the AddWeightMap_MaxDistance node](https://dev.epicgames.com/community/api/documentation/image/2a050195-1b59-42bb-b057-445e47afc168?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a050195-1b59-42bb-b057-445e47afc168?resizing_type=fit)
2. Drag from the **Collection** pin and search for then select **Selection** under the **Cloth** category. Name the node **Selection\_Holster**. Go to the **Node Details** panel and set the **Name** to **HolsterFaces** and the **Group** to **SimFaces**.

   [![Add a Selection node and set the Name to HolsterFaces and Group to SimFaces](https://dev.epicgames.com/community/api/documentation/image/bc60a766-08ec-4c9d-b485-8b62e6f7a66b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bc60a766-08ec-4c9d-b485-8b62e6f7a66b?resizing_type=fit)
3. The **Cloth Mesh Selection** tool is now active.

   [![The Cloth Mesh Selection tool is now active](https://dev.epicgames.com/community/api/documentation/image/1744333b-15df-4002-8f9d-c81000481d2f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1744333b-15df-4002-8f9d-c81000481d2f?resizing_type=fit)

   The Cloth Mesh Selection tool interface contains the following sections:

   | Section | Description |
   | --- | --- |
   | 1. **Operations:** | Imports a selection from a collection or toggles between the primary and secondary selections. |
   | 2. **Selection tools:** | ***Flood Selection:** Selects the entire mesh from a current selection.* **Grow Selection:** Increases the selection area within the current mesh.  **Shrink Selection:** Decreases the selection area within the current mesh. |
   | 3. **Visualization:** | Shows the cloth collection vertices and edges. |
   | 4. **Selection Actions:** | ***Invert Selection:** Inverts the current selection.* **Select All:** Selects all meshes in the collection. |
   | 5. **Selection Filter:** | Toggles between selecting mesh vertices or polygons. |
   | 6. **Additional Selection Options, Ortho Viewport Behavior, Advanced:** | Contains additional selection options, such as Ignore Occlusion and Hit Back Faces. |
   | 7. **Accept** or **Cancel** | Accepts or cancels your selection. |
4. **Click and drag** to select the **holsters** in the cloth collection. Click **Accept**.

   [![Click and drag to select the holsters in the cloth Collection](https://dev.epicgames.com/community/api/documentation/image/d0256f27-0799-43bc-9629-1be6bc9fe484?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0256f27-0799-43bc-9629-1be6bc9fe484?resizing_type=fit)
5. Drag from the **Collection** pin and search for then select **Selection** under the **Cloth** category. Name the node **Selection\_Jacket**. Go to the **Node Details** panel and set the **Name** to **JacketFaces** and the **Group** to **SimFaces**.

   [![Add a Selection node and set the Name to JacketFaces and Group to SimFaces](https://dev.epicgames.com/community/api/documentation/image/e18f9329-a878-47d4-a2d4-b2ef4129dfa5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e18f9329-a878-47d4-a2d4-b2ef4129dfa5?resizing_type=fit)
6. Select the faces of the **jacket** you want to isolate in the cloth collection. Click **Accept**.

   [![Select the faces of the jacket you want to isolate in the Cloth Collection](https://dev.epicgames.com/community/api/documentation/image/0953cd79-d648-4d0f-8892-c2babc6e5cea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0953cd79-d648-4d0f-8892-c2babc6e5cea?resizing_type=fit)
7. Drag from the **Collection** pin and search for then select **ProxyDeformer**. This node informs the cloth collection how to deform during simulation.

   1. Connect the **Selection Name** pin from the **WeightMapSelection** node to the **Sim Vertex Selection** pin.
   2. Connect the **Name** pin of **Selection\_Holster** to the **Selection Filter Set 0** pin.
   3. Right click on the **ProxyDeformer** node and select **AddOptionPin**. Connect the **Name** pin of **Selection\_Jacket** to the **Selection Filter Set 1** pin.

   [![Add a ProxyDeformer node and connect the WeightMapSelection node and the Holster Selection node](https://dev.epicgames.com/community/api/documentation/image/6481c7f0-6778-413e-a462-374b129887c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6481c7f0-6778-413e-a462-374b129887c3?resizing_type=fit)

   [![Add an option pin and connect the Jacket Selection node](https://dev.epicgames.com/community/api/documentation/image/0a7c01f0-f4dd-44b3-83d0-146c793976f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0a7c01f0-f4dd-44b3-83d0-146c793976f6?resizing_type=fit)

## Set the Simulation Self Collision

In this section, you will set up self collision for the simulation. You will create **collision layers** for the belt loops, the belt, and the jacket to ensure they do not interfere with each other during the simulation. In addition, you will also create weight maps for **thickness** and **friction**, and set up **kinematic collision**.

1. Create a new **Selection** node and name it **Selection\_BeltLoops**.

   1. Go to the **Node Details** panel and set the **Name** to **BeltLoops** and **Group** to **SimFaces**.
   2. Select the **Belt loops** in the cloth collection.

   [![Add a Selection node and set the Name to BeltLoops and the Group to SimFaces](https://dev.epicgames.com/community/api/documentation/image/f35f1b66-8e32-4e23-bbd7-28b55b30a42d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f35f1b66-8e32-4e23-bbd7-28b55b30a42d?resizing_type=fit)

   [![Select the Belt loops in the cloth collection](https://dev.epicgames.com/community/api/documentation/image/a7285526-3032-4124-9706-081dedd74e39?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a7285526-3032-4124-9706-081dedd74e39?resizing_type=fit)
2. Drag from the **Collection** pin and search for then select **SelectionToIntMap**. Name the node **SelectionToIntMap\_BeltLoops** and connect the **Name** pin to the **Selection Name** pin. The **SelectionToIntMap** node sets which simulation layer the selection will run on. The simulation executes layers in order, with the lowest layer (layer 0) executing first.

   [![Add a SelectionToIntMap node and connect the Name pin to the Selection Name pin](https://dev.epicgames.com/community/api/documentation/image/81ed6bc6-d02c-4cb2-9774-bdccf336138e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/81ed6bc6-d02c-4cb2-9774-bdccf336138e?resizing_type=fit)
3. Create a new **Selection** node and name it **Selection\_Belt.**

   1. Go to the **Node Details** panel and set the **Name** to **Belt** and **Group** to **SimFaces.**
   2. Select the **Belt** faces in the cloth collection.

   [![Add a Selection node and set the Name to Belt and the Group to SimFaces](https://dev.epicgames.com/community/api/documentation/image/61fc53c2-5e81-4e1c-ba62-be7d4df3d5d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/61fc53c2-5e81-4e1c-ba62-be7d4df3d5d7?resizing_type=fit)

   [![Select the Belt faces in the cloth collection](https://dev.epicgames.com/community/api/documentation/image/9e6333fa-1b70-4cf2-86c0-d5d0639e0e08?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9e6333fa-1b70-4cf2-86c0-d5d0639e0e08?resizing_type=fit)
4. Drag from the **Collection** pin and search for then select **SelectionToIntMap.** Name the node **SelectionToIntMap\_Belt** and connect the **Name** pin to the **Selection Name** pin.

   [![Add a Selection To Int Map node and connect the Name pin to the Selection Name pin](https://dev.epicgames.com/community/api/documentation/image/83511563-efe6-4fa0-a8ad-9f0d23bf88f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/83511563-efe6-4fa0-a8ad-9f0d23bf88f6?resizing_type=fit)
5. Create a new **Selection** node and name it **Selection\_JacketCol.**

   1. Go to the **Node Details** panel and set the **Name** to **JacketUnderBelt** and **Group** to **SimFaces.**
   2. Select the **Jacket** faces in the cloth collection.

   [![Add a Selection node and set the Name to JacketUnderBelt and Group to SimFaces](https://dev.epicgames.com/community/api/documentation/image/3430337c-25dc-4396-950f-2004336fd015?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3430337c-25dc-4396-950f-2004336fd015?resizing_type=fit)

   [![Select the Jacket faces in the cloth collection](https://dev.epicgames.com/community/api/documentation/image/b145a54f-6bbd-4204-b55c-9f2f8b00e77f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b145a54f-6bbd-4204-b55c-9f2f8b00e77f?resizing_type=fit)
6. Drag from the Collection pin and search for then select **SelectionToIntMap.** Name the node **SelectionToIntMap\_Jacket** and connect the **Name** pin to the **Selection Name** pin.

   [![Add a Selection To Int Map node and connect the Name pin to the Selection Name pin](https://dev.epicgames.com/community/api/documentation/image/6e514b93-dfcc-4d60-9fd2-34d64ce8f0ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e514b93-dfcc-4d60-9fd2-34d64ce8f0ca?resizing_type=fit)
7. Connect the **Int Map Name** pin of the **SelectionToIntMap\_BeltLoops** to the **Int Map Name** pin of **SelectionToIntMap\_Belt.** Connect the **Int Map Name** pin of the **SelectionToIntMap\_Belt** to the **Int Map Name** pin of **SelectionToIntMap\_Jacket.**

   [![Connect the SelectionToIntMap_BeltLoops to SelectionToIntMap_Belt and SelectionToIntMap_Belt to SelectionToIntMap_Jacket](https://dev.epicgames.com/community/api/documentation/image/80da84f1-7a6e-4680-b0fd-7782d278ca21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/80da84f1-7a6e-4680-b0fd-7782d278ca21?resizing_type=fit)
8. Create a **WeightMap** node and name it **AddWeightMap\_Thickness.** Set the **Name** to **Thickness.** Paint the Cloth Collection to represent the thickness of the cloth during simulation.

   [![Add a WeightMap node and set the Name to Thickness](https://dev.epicgames.com/community/api/documentation/image/2f6f6bc3-94f8-459e-9be5-8683750abd90?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f6f6bc3-94f8-459e-9be5-8683750abd90?resizing_type=fit)

   [![Paint the cloth collection to represent the thickness of the cloth during simulation](https://dev.epicgames.com/community/api/documentation/image/715ae057-2610-4c19-a05d-6ad9508beef2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/715ae057-2610-4c19-a05d-6ad9508beef2?resizing_type=fit)
9. Create a **WeightMap** node and name it **AddWeightMap\_Friction.** Set the **Name** to **Friction.** Paint the cloth collection to represent friction during simulation.

   [![Add a WeightMap node and set the Name to Friction](https://dev.epicgames.com/community/api/documentation/image/8c05cc2a-0b12-41e7-80f4-dd9aa110d647?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c05cc2a-0b12-41e7-80f4-dd9aa110d647?resizing_type=fit)

   [![Paint the cloth collection to represent friction during simulation](https://dev.epicgames.com/community/api/documentation/image/7be52bb0-baa5-4e63-8d06-2ad906d9482e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7be52bb0-baa5-4e63-8d06-2ad906d9482e?resizing_type=fit)
10. Now you will create a selection for the **kinematic collision** used by the self collision node.

    1. Add a **StaticMeshImport** node and name it **StaticMeshImport\_Collider.** Click the **Static Mesh** dropdown and select the appropriate static mesh.
    2. Drag from the **Collection** pin and search for then select **TransferSkinWeights.** Name the node **TransferSkinWeights\_Collider.**
    3. Drag from the **Collection** pin and search for then select **Selection.**

    [![Add a Static Mesh Import node and set the static mesh. Add a Transfer Skin Weights node and a Selection node](https://dev.epicgames.com/community/api/documentation/image/4f175083-376d-42c7-b88c-68f1d312cd3b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f175083-376d-42c7-b88c-68f1d312cd3b?resizing_type=fit)
11. Drag from the **Collection** pin of the **Selection** node and search for then select **MergeClothCollections.**

    1. Name the node **MergeClothCollections\_Kinematic.**
    2. Right click the **MergeClothCollections\_Kinematic** node and select **AddOptionPin.**
    3. Connect the **Collection** pin of the **AddWeightMap\_Friction** node to the **Collection 1** pin of the **MergeClothCollections\_Kinematic** node.

    [![Add a Merge Cloth Collections node and add an option pin. Connect the Selection and AddWeightMap_Friction nodes](https://dev.epicgames.com/community/api/documentation/image/b8ac295f-8cdf-4728-ba9d-a17f757a7215?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b8ac295f-8cdf-4728-ba9d-a17f757a7215?resizing_type=fit)
12. Drag from the **Collection** pin of the **MergeClothCollections\_Kinematic** node and search for then select **SimulationSelfCollisionConfig.**

    1. Connect the **Int Map Name** pin from the **SelectionToIntMap\_Jacket** node to the **Self Collision Layers** pin of **SimulationSelfCollisionConfig.**
    2. Connect the **Name** pin from the **Selection** node to the **Self Collision Enabled Kinematic Faces** pin of **SimulationSelfCollisionConfig.**
    3. Connect the **Name** pin from the **AddWeightMap\_Friction** node to the **Self Collision Kinematic Collider Friction Weighted** pin of SimulationSelfCollisionConfig.
    4. Connect the **Name** pin from the **AddWeightMap\_Thickness** node to the **Self Collision Thickness Weighted** pin of **SimulationSelfCollisionConfig.**

    [![Add a Simulation Self Collision Config node and connect the inputs as described above](https://dev.epicgames.com/community/api/documentation/image/5550df53-2001-4ab4-991c-307b2c5b7196?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5550df53-2001-4ab4-991c-307b2c5b7196?resizing_type=fit)

## Set the Simulation Solver and Cloth Asset Terminal

In this section, you will set up the **Simulation Solver**, which controls the quality of the simulation. In addition, you will complete the asset by creating a **Cloth Asset Terminal.** This node evaluates the entire Dataflow graph and sets its result to the cloth asset in the Content Browser.

1. Drag from the **Collection** pin of the **SimulationSelfCollisionConfig** node and search for then select **SimulationSolverConfig.**

   1. Set the Num Iterations to 2.
   2. Set the Max Num Iterations to 2.
   3. Set the Num Substeps to 13
   4. Enable Num Self Collision and set it to 2.

   [![Add a Simulation Solver Config node and set Num of Iterations and Max Num Iterations to 2, Num Substeps to 13, and Num Self Collision to 2](https://dev.epicgames.com/community/api/documentation/image/8346f69d-2184-402d-ba72-5e1cd9108323?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8346f69d-2184-402d-ba72-5e1cd9108323?resizing_type=fit)
2. Drag from the **Collection** pin of the **SimulationSolverConfig** node and search for then select **ClothAssetTerminal.** You should now see the cloth collection in the viewport.

   [![Add a ClothAssetTerminal node](https://dev.epicgames.com/community/api/documentation/image/8ed471c0-b16a-4d20-89fa-7c9bd6aa3d68?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ed471c0-b16a-4d20-89fa-7c9bd6aa3d68?resizing_type=fit)

   [![You now see the Cloth Collection in the viewport](https://dev.epicgames.com/community/api/documentation/image/20d06eb4-abcd-437a-b939-c409f588ba75?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/20d06eb4-abcd-437a-b939-c409f588ba75?resizing_type=fit)
3. Click the **Preview Scene Details** panel and set a **skeletal mesh asset** and an **animation asset** to preview the simulation. In this example, we selected a forward walking animation to preview.

   [![Set a skeletal mesh asset and an animation asset to preview the simulation](https://dev.epicgames.com/community/api/documentation/image/752d649b-f356-4010-a64f-49fc826cad5f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/752d649b-f356-4010-a64f-49fc826cad5f?resizing_type=fit)

   [![The preview mesh plays the selected animation](https://dev.epicgames.com/community/api/documentation/image/e592ec58-0f45-4d23-878c-1b22689ae47c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e592ec58-0f45-4d23-878c-1b22689ae47c?resizing_type=fit)

## Next Steps

[![Import your Clothing Asset into UEFN](https://dev.epicgames.com/community/api/documentation/image/bf4e04b8-ace3-4f62-871c-45b43af044ca?resizing_type=fit&width=640&height=640)

Import your Clothing Asset into UEFN

A guide on migrating the clothing asset from Unreal Engine to Unreal Editor for Fortnite.](https://dev.epicgames.com/documentation/en-us/fortnite/import-your-clothing-asset-into-unreal-editor-for-fortnite)
