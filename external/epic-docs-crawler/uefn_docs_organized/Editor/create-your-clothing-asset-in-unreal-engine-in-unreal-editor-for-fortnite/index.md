# Create your Clothing Asset in Unreal Engine

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-your-clothing-asset-in-unreal-engine-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:18:00.205286

---

The process of converting your cloth meshes into cloth assets is performed in Unreal Engine 5. In this section, we will import a USD file from Marvelous Designer. However, you can import assets from any external DCC package in FBX or USD formats.

As part of the Talisman: MetaHuman template, you can access several downloadable assets including an Unreal Engine project with the MetaHuman wearing Captain Roux’s jacket from the Talisman GDC demo. To learn how to access the downloadable files, see the [Talisman MetaHuman Template tutorial](talisman-metahuman-template-in-unreal-editor-for-fortnite).

Once you download the files, follow these steps to convert your meshes into a Cloth Asset:

### Create a New Unreal Engine Project

1. Create a new Unreal Engine 5 project.
2. Click **Settings > Plugins** to open the **Plugins** menu.

   [![Click Settings - Plugins to open the Plugins menu](https://dev.epicgames.com/community/api/documentation/image/92b462d8-b23d-4403-818f-142762555762?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/92b462d8-b23d-4403-818f-142762555762?resizing_type=fit)
3. Search for then enable the **Chaos Cloth Asset** and **Chaos Cloth Asset Editor** plugins.

   [![Enable the Chaos Cloth Asset and Chaos Cloth Asset Editor plugins](https://dev.epicgames.com/community/api/documentation/image/066fa889-a88b-4a2d-a171-725d14e53ee6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/066fa889-a88b-4a2d-a171-725d14e53ee6?resizing_type=fit)
4. Restart the editor, if needed.

### Create the Cloth Asset

You can **download** the source files used in this guide by going to the [Talisman MetaHuman Template tutorial](talisman-metahuman-template-in-unreal-editor-for-fortnite). Once downloaded, go to **T > CaptainRoux\_Cloth\_Learning\_Assets > CaptainRoux\_Cloth\_Learning\_Assets > Cap\_Jacket\_SourceArt** to find the source files used in this tutorial.

[![Source assets available for download](https://dev.epicgames.com/community/api/documentation/image/25986183-f5a4-4a24-b1be-74f463d6b23b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/25986183-f5a4-4a24-b1be-74f463d6b23b?resizing_type=fit)

In this section you will create a physics **cloth asset**. This asset contains the result of the cloth Dataflow graph which may include panel cloth data from Marvelous Designer or static and skeletal meshes. The cloth Dataflow graph includes the logic used to process the panel data and meshes so they can simulate during gameplay.

1. Right click in the **Content Browser** and select **Physics > ClothAsset** to create a new **Cloth Asset**. Name it **CA\_Cap\_Jacket**.

   [![Right click in the Content Browser and select Physics - ClothAsset](https://dev.epicgames.com/community/api/documentation/image/c4e3b9be-9214-481f-ab46-9135d07f6ca6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c4e3b9be-9214-481f-ab46-9135d07f6ca6?resizing_type=fit)

   [![Name the asset CA_Cap_Jacket](https://dev.epicgames.com/community/api/documentation/image/3a9a273e-b385-41ea-a6c4-28c5ef04b375?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a9a273e-b385-41ea-a6c4-28c5ef04b375?resizing_type=fit)
2. Double click **CA\_Cap\_Jacket** in the **Content Browser** to open the asset. This generates a default **Dataflow asset** in the same folder and opens the **Cloth Asset Panel Editor**.

   [![Opening CA_Cap_Jacket will create a default Dataflow asset](https://dev.epicgames.com/community/api/documentation/image/86de23d0-3577-4ce0-ad6e-32398b10c305?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/86de23d0-3577-4ce0-ad6e-32398b10c305?resizing_type=fit)

#### Navigate the Cloth Asset Panel Editor

The Cloth Asset Panel Editor has the following sections:

1. **Cloth Mode Toolbar and Parameters**: Contains the available tools and parameters according to the selected Dataflow node.
2. **2D / 3D Cloth Panel and Mesh View:** Shows the selected view of the clothing meshes. This viewport is also used to paint weight maps and create selections.
3. **3D Render Viewport:** Shows the simulated result of the cloth asset.
4. **Dataflow Graph:** Contains the Dataflow nodes that drive the logic of the cloth asset.
5. **Node Details:** Displays specific details of the selected node.
6. **Details / Preview Scene / Outliner Panel:** Displays the cloth asset details, as well as settings for the preview scene in the 3D Render Viewport.

   [![The Cloth Asset Panel Editor interface](https://dev.epicgames.com/community/api/documentation/image/4d036891-e649-4821-b77f-dbe7339e4d5d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d036891-e649-4821-b77f-dbe7339e4d5d?resizing_type=fit)

#### Import the Cloth Meshes

1. For this example, you will create the Dataflow graph from scratch.

   1. Select all the nodes in the graph and press **Delete** on your keyboard.
   2. Right click in the graph and search for then select **USDImport**.
   3. Go to the **Node Details** panel and click the **ellipsis** next to **USD File**. Select the USD file you exported from your DCC package.

   [![Select the USD file you exported from your DCC package](https://dev.epicgames.com/community/api/documentation/image/fa85678c-ace8-4ca9-ab1d-ac0263f361d2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fa85678c-ace8-4ca9-ab1d-ac0263f361d2?resizing_type=fit)
2. Drag from the **Collection** pin and search for then select **DeleteElement**.

   1. Go to the **Node Details** panel and enable **Delete Render Mesh**. In this example, you want to import a custom render mesh, instead of using the one generated by Marvelous Designer on export. For this reason, delete the render mesh in the USD file.

   [![Add a DeleteElement node and enable Delete Render Mesh](https://dev.epicgames.com/community/api/documentation/image/a9e1573a-48e0-4545-a758-0e1d1ae53954?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9e1573a-48e0-4545-a758-0e1d1ae53954?resizing_type=fit)
3. Drag from the **Collection** pin and search for then select **TransformPositions**.

   1. Go to the **Node Details** panel and enable **Transform 2D Sim Positions**.
   2. Set the **SIM 2D Scale** to **0.1** for X and Y. This will ensure that the 2D and 3D scales look similar in the viewport.

   [![Add a TransformPositions node, enable Transform 2D Sim Positions and set the SIM 2D Scale to 0.1 for X and Y](https://dev.epicgames.com/community/api/documentation/image/a26adc18-5f25-459b-9f65-2a200b181c23?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a26adc18-5f25-459b-9f65-2a200b181c23?resizing_type=fit)
4. Drag your custom render mesh FBX file to the **Content Browser** and select the appropriate import settings for your model, such as Generate Missing Collision and Create New Materials.

   [![Drag your custom render mesh FBX file to the Content Browse**r**](https://dev.epicgames.com/community/api/documentation/image/b4c55f2d-7c3d-40ce-a685-dfd8b33a3598?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b4c55f2d-7c3d-40ce-a685-dfd8b33a3598?resizing_type=fit)

   [![Select the appropriate import settings for your model](https://dev.epicgames.com/community/api/documentation/image/a3901f7d-3ce5-47ee-900e-a8080560408b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a3901f7d-3ce5-47ee-900e-a8080560408b?resizing_type=fit)
5. Right click in the graph and search for then select **StaticMeshImport**.

   1. Go to the **Node Details** panel and click **Static Mesh**. Select the imported static mesh from the list.
   2. Deselect **Import Sim Mesh**.

   [![Add a StaticMeshImport node and add the imported Static Mesh and deselect Import Sim Mesh](https://dev.epicgames.com/community/api/documentation/image/e9e1ee06-029e-42f7-89b6-5318b703a3c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9e1ee06-029e-42f7-89b6-5318b703a3c3?resizing_type=fit)
6. Right click in the graph and search for then select **MergeClothCollections**.

   1. Right click the node and select **AddOptionPin**.
   2. Connect the **Collection** pin from the **StaticMeshImport** node to the **MergeClothCollections** node.

   [![Add a MergeClothCollections node and right click and select Add Option Pin](https://dev.epicgames.com/community/api/documentation/image/84d29454-0f43-4beb-9715-c56a49a6fff0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/84d29454-0f43-4beb-9715-c56a49a6fff0?resizing_type=fit)

   [![Connect the Collection from the StaticMeshImport node to the MergeClothCollections** **node](https://dev.epicgames.com/community/api/documentation/image/eb24786a-8d4b-4715-b456-a3422afe0522?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb24786a-8d4b-4715-b456-a3422afe0522?resizing_type=fit)

## Next step

[![Configure the Clothing Asset Parameters](https://dev.epicgames.com/community/api/documentation/image/580b2e0e-f4cd-4de9-891f-bb1646f13ae4?resizing_type=fit&width=640&height=640)

Configure the Clothing Asset Parameters

Configure the parameters of the cloth asset to ensure proper functionality.](https://dev.epicgames.com/documentation/en-us/fortnite/configure-the-clothing-asset-parameters-in-unreal-editor-for-fortnite)
