# Importing Assets

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:55:17.106100

---

Import custom [assets](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#asset) into **Unreal Editor for Fortnite (UEFN)** from **[Fab](https://dev.epicgames.com/documentation/en-us/fab/fab-documentation)**,  **[Sketchfab](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#sketchfab)** or 3D modeling software to create experiences that go beyond **Fortnite Creative** assets. For more information and tips on how to model assets, the documents below have all the information you need to create custom objects:

- **[Modeling Tips](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-tips-in-unreal-editor-for-fortnite)** - The information discusses pivot points, UVs, vertices, and mesh surface integrity.
- **[Architectural Modeling Guidelines](https://dev.epicgames.com/documentation/en-us/fortnite/architectural-modeling-guidelines-in-unreal-editor-for-fortnite)** - Discusses how to create modular architectural sets.
- [Creating Fortnite-Ready Assets in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fortniteready-assets-in-unreal-editor-for-fortnite) - The information discusses scale, rotation, creating materials and textures for custom assets.

  If you attempt to import assets that do not meet the criteria in the documents above, the import will fail.

For more information about setting collision for your imported [static mesh](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#static-mesh), see **[Configuring Collision for a Static Mesh](https://dev.epicgames.com/documentation/en-us/fortnite/configuring-collision-for-a-static-mesh-in-unreal-editor-for-fortnite)**.

## The Project Folder

Get familiar with the folders in the Content Browser before importing assets. The two main folders include:

- **All:** Click the **All** folder icon in the **Content Browser**. This opens the main folders found under **All**.

  [![Creating a folder in the Content Browser](https://dev.epicgames.com/community/api/documentation/image/06c00e88-3f89-4e9d-95f8-f57159fd0304?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06c00e88-3f89-4e9d-95f8-f57159fd0304?resizing_type=fit)

  Content browser folder system
- **Project Content:** The name you provided for the [project](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#project) followed by the word "Content".

When you import or create new assets, you should create new folders in your Project Content folder for each asset type to keep your assets organized. You won’t be able to create new folders or import assets into the **All** or **Fortnite** folders.

[![Create separate asset folders for each asset type.](https://dev.epicgames.com/community/api/documentation/image/e018e801-e4b1-429c-ac57-0011b92f7718?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e018e801-e4b1-429c-ac57-0011b92f7718?resizing_type=fit)

Imported assets folder

Splitting your assets into separate folders allows you to open multiple Content Browser windows at the same time, with each window containing the different assets you need. This can make your workflow more efficient.

## Import an Asset

There are three ways to import an asset: **drag and drop**, **right-click menu**, or with the **Content Browser quick options**.

There are also two different import options depending on the type of file you’re importing. Importing an FBX file uses the FBX Import Options, all other file types open the Interchange Asset Import options.

Each set of importing options optimize your asset to work in UEFN and provides a way for you to control the values and import options for your assets. You’ll automatically be sent to the appropriate import options when importing assets.

Use the UEFN importing settings during the import process to automatically import materials at the same time as your meshes, otherwise you will have to import your materials separately.

### Drag and Drop

To import using the drag and drop method:

- On your drive open Explorer and search for the folder that contains your assets.
- In Explorer select an asset, then drag it into the Content Browser. The asset quickly downloads, and a thumbnail is automatically created for the imported asset.

### Right-Click Menu

To import using the right-click menu:

- In the Content Browser hierarchy list, double-click the **Project Content** folder to open the content folder for your project.

  [![Double-click on the imported asset folder to open that folder.](https://dev.epicgames.com/community/api/documentation/image/478dfe9f-cb25-4052-bcf0-85719ed31fec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/478dfe9f-cb25-4052-bcf0-85719ed31fec?resizing_type=fit)

  Double-click the Imported Assets folder
- Right-click in the **Content Browser** and select the **Import To** option.

  [![Select Import to Current Folder to import your asset into the Imported_Assets folder.](https://dev.epicgames.com/community/api/documentation/image/25a104ee-9882-4f08-bd2d-cc0170063658?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/25a104ee-9882-4f08-bd2d-cc0170063658?resizing_type=fit)

  Click image to enlarge.
- In Explorer, browse to the file you want to import, then select it and click **Open**.

  [![Select the Static Mesh](https://dev.epicgames.com/community/api/documentation/image/e25a6e0e-8058-4ecd-a647-9b23b37dd768?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e25a6e0e-8058-4ecd-a647-9b23b37dd768?resizing_type=fit)

The UEFN Static Mesh Import workflow has the same restrictions on FBX file types for import as the standard UE Static Mesh Import workflow. Refer to **[Importing Static Meshes Using FBX](https://dev.epicgames.com/documentation/en-us/unreal-engine/importing-static-meshes-using-fbx-in-unreal-engine?application_version=5.5)** for more information.

### Content Browser

To import using the Content Browser:

1. Select **Import** from the Content Browser quick options buttons.

   [![When the Import button is highlighted, you can click it to begin importing your asset.](https://dev.epicgames.com/community/api/documentation/image/32e812a8-906c-429e-a1ce-1ddf5b87005b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/32e812a8-906c-429e-a1ce-1ddf5b87005b?resizing_type=fit)

   Content browser buttons
2. In Explorer, browse to the file you want to import, then select it and click **Open**.

   [![Select the Static Mesh](https://dev.epicgames.com/community/api/documentation/image/cf0f982b-62ba-4831-a28e-a6723bf23e2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf0f982b-62ba-4831-a28e-a6723bf23e2e?resizing_type=fit)

## Import Options

Importing a file opens the **Import Content** window. The provides control over the assets you import, you can rename assets, combine static meshes, set collision, and simultaneously import materials and textures. Click Import when you're ready to import and all assets attached to your file import into the folder.

### Import Errors

Sometimes importing assets results in a warning in the **Message Log**. The Message Log opens when the editor detects issues with assets and prompts a warning about the affected assets. Click the **Clear** button at the bottom of the warning and close the window to continue working with your imported asset.

[![The Message Log opens when the editor detects issues with assets and prompts a warning about the affected assets.](https://dev.epicgames.com/community/api/documentation/image/d0c281fa-e1f8-4b17-9056-bbd2ea8aff8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0c281fa-e1f8-4b17-9056-bbd2ea8aff8c?resizing_type=fit)

*Click image to enlarge.*

You can import a mesh as a [skeletal mesh](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#skeletal-mesh). The process is similar. Just make sure the **Skeletal Mesh** checkbox is checked.

## Interchange Asset Import

Importing file types that aren’t FBX opens the **Interchange Asset Import** options. The Interchange Asset Import options are UEFN's import framework. It’s required for different asset types, or for setting options on a specific pipeline.

Selecting **Basic Layout** hides the pipeline stack selector by simplifying the pipeline options.

[![Selecting Basic Layout simplifies the pipeline options.](https://dev.epicgames.com/community/api/documentation/image/a9630c6a-20f8-4731-8d67-5710861ebf00?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9630c6a-20f8-4731-8d67-5710861ebf00?resizing_type=fit)

When Basic Layout is turned off, you can still download all asset packets and filter using the pipeline buttons: **General**, **Static Meshes**, **Skeletal Meshes**, **Animation, Materials**, and **Textures**.

The options you select using Basic Layout are remembered whether the Basic Layout option is on or off.

There is a CVAR to control options whether you import assets using Basic Layout or not. This ensures a project isn’t inconvenienced by Basic Layout being on when the option is unwanted.

For more information on how Interchange Asset Import works, refer to **[Interchange Framework](https://dev.epicgames.com/documentation/en-us/unreal-engine/API/PluginIndex/Interchange)** in Unreal Engine documentation.

### After a Successful Import

Continue to **[Configuring Collision for a Static Mesh](https://dev.epicgames.com/documentation/en-us/fortnite/configuring-collision-for-a-static-mesh-in-unreal-editor-for-fortnite)** to learn how to configure collision for your asset.

To learn more about applying a material to your imported asset, or creating a custom material for your imported asset, refer to the **[Materials](https://dev.epicgames.com/documentation/en-us/fortnite/materials-in-unreal-editor-for-fortnite)** documentation.

## Supported File Types

UEFN allows you to import many different file types for different types of assets. While UEFN and Fortnite Creative do not yet support all file formats, this will change over time. Below is a list of supported file types you can import and use today.

### 3D models

- [FBX file format](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#fbx)
- [OBJ](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#obj)
- gITF
- GLB

### Textures

- JPG
- PNG
- JPEG
- BMP
- DDS
- EXR
- HDR
- PCX
- PSD
- TGA
- TIF
- TIFF

### Audio

- AIF
- FLAC
- OGG
- WAV

### Epic

- .island
- .upack

### Other

- CSV
- JSON

## Convert Asset Files

You may find an asset you want to use but the file format isn’t compatible with UEFN. Alternatively, the OBJ file you want to import won't work with your project. In these cases, you need to convert your file into FBX.

You can use UEFN to edit and create simple meshes, but the best place to convert 3D models is with proper 3D modeling software. Any of the following 3D modeling packages are recommended:

- [**Blender:**](https://www.blender.org/download/) Free open source software, great for anyone just getting started in 3D modeling.
- [**Maya:**](https://www.autodesk.ca/en/products/maya/features) Professional software preferred for use in 3D animation and visual effects software for film, TV, and games.
- **[3DS Max](https://www.google.com/aclk?sa=l&ai=DChcSEwjTyeGlz9yMAxVCc0cBHf28PAYYABADGgJxdQ&co=1&ase=2&gclid=Cj0KCQjwqv2_BhC0ARIsAFb5Ac-Kx_3Eu9jzQGMsecPezbBPpej2Kgh-CId1Iwarwa7-MNqT6gHma-waAt3CEALw_wcB&ei=X6v_Z-zXMbSu5NoPz6TE6A8&sig=AOD64_07bJpcVj5pfXe9QxXh2qeSCot_lA&q&sqi=2&nis=4&adurl&ved=2ahUKEwisg9ulz9yMAxU0F1kFHU8SEf0Q0Qx6BAhNEAE):**Professional-grade 3D modeling, animation, and rendering software.

The following steps use **Blender** to convert files:

1. Open your 3D modeling software and select **File** > **Import** > the type of asset file you're going to convert (the file can be USDZ, GLB, gITF, etc.) An import window opens.

   [![Preparing to import the asset into Blender.](https://dev.epicgames.com/community/api/documentation/image/27ea94f0-791e-4f6e-bd33-790bc593cc7e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/27ea94f0-791e-4f6e-bd33-790bc593cc7e?resizing_type=fit)
2. Choose the file you want to convert and click **Import**.

   [![Select the asset for import.](https://dev.epicgames.com/community/api/documentation/image/c315ef3a-2338-487e-a4ee-5a2456afb224?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c315ef3a-2338-487e-a4ee-5a2456afb224?resizing_type=fit)
3. Click on the model in Blender’s viewport.

   [![Select the asset you're converting.](https://dev.epicgames.com/community/api/documentation/image/dc7165d3-2f12-41a7-8bef-d412a18226cc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dc7165d3-2f12-41a7-8bef-d412a18226cc?resizing_type=fit)
4. Select **File** > **Export** > **FBX**.

   [![Exporting the converted asset from Blender.](https://dev.epicgames.com/community/api/documentation/image/860a6245-5b83-4eaf-a6c9-261dcc236cbe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/860a6245-5b83-4eaf-a6c9-261dcc236cbe?resizing_type=fit)
5. Choose the folder where you want to save your converted asset file. Type a new name for the asset, then click **Export FBX**.

   [![Select the folder where you will save your converted asset file.](https://dev.epicgames.com/community/api/documentation/image/f065590d-6957-4126-8a55-bb6ed769d205?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f065590d-6957-4126-8a55-bb6ed769d205?resizing_type=fit)

Your asset is now converted to FBX and ready for use in your project.

### Attach Materials to a Static Mesh

Not all meshes come with materials. In this case, you will need to make materials to cover the mesh.

To assign a material to an imported mesh, [create a material](https://dev.epicgames.com/documentation/en-us/fortnite/materials-in-unreal-editor-for-fortnite), then follow these quick steps to assign the material to your mesh.

1. Drag your mesh from the thumbnail into the viewport if you haven’t already. If the mesh is already in the viewport, click on the mesh to select it.
2. Open the **Details** panel and scroll down to **Materials**.
3. Select the material you made from the dropdown menu.

[![Select the material you made from the dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/c8e6f705-1388-46da-893d-adda35e7d187?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c8e6f705-1388-46da-893d-adda35e7d187?resizing_type=fit)

The material you made will be assigned to your mesh.

[![The material is assigned to your mesh.](https://dev.epicgames.com/community/api/documentation/image/28fec2f8-6b20-4dc5-8fa3-a2d5b7c24274?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/28fec2f8-6b20-4dc5-8fa3-a2d5b7c24274?resizing_type=fit)

To learn more about creating materials and assigning materials to imported meshes, refer to the following UE documentation:

- **[Essential Material Concepts](https://dev.epicgames.com/documentation/en-us/unreal-engine/essential-unreal-engine-material-concepts?application_version=5.5)**
- **[Setting Up Materials](https://dev.epicgames.com/documentation/en-us/unreal-engine/using-materials-with-static-meshes-in-unreal-engine?application_version=5.5)**
- **[Texture Import Guide](https://dev.epicgames.com/documentation/en-us/unreal-engine/texture-import-settings-in-the-unreal-engine-project-settings?application_version=5.5)**

  [Penguin](https://sketchfab.com/3d-models/penguin-5d5ddab9a9bf4933a7615bb2d5ed0f9d) by [patrakeevasveta](https://sketchfab.com/patrakeevasveta) licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

  [Small Robot](https://sketchfab.com/3d-models/small-robot-9f25361b7e61479c9c44aa2c47e89bf3) by [Pascale Fulle](https://sketchfab.com/pascal.fulle) licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
