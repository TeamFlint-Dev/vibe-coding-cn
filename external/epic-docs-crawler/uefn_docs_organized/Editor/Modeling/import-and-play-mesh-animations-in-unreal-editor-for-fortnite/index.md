# Import and Play Mesh Animations

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/import-and-play-mesh-animations-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:04:26.714351

---

You can use **Unreal Editor for Fortnite (UEFN)** to animate [skeletal meshes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#skeletal-mesh).

This tutorial shows you how to import skeletal meshes, animations attached to the meshes, and how the animations on a mesh work in UEFN.

## Import a Skeletal Mesh and Associated Assets

UEFN does not come preloaded with skeletal meshes or animations, so you will have to create or import them.

For an in-depth look at handling custom assets in Unreal Engine, check out the **[Working with Content](https://dev.epicgames.com/documentation/en-us/unreal-engine/working-with-content-in-unreal-engine?application_version=5.5)** section, with attention to the **[FBX Content Pipeline](https://dev.epicgames.com/documentation/en-us/unreal-engine/fbx-content-pipeline?application_version=5.5)** pages.

1. Open your UEFN project.
2. In the **Content Browser**, open the project’s content folder and create a Characters folder for your skeletal meshes.
3. Make a subfolder for each type of character you want to import. Double-click the folder to open it.

   [![Create subfolders for the different kinds of skeletal meshes and animation assets you import.](https://dev.epicgames.com/community/api/documentation/image/bd56c41c-0730-4fa3-8bc0-b2fb5c1925e4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd56c41c-0730-4fa3-8bc0-b2fb5c1925e4?resizing_type=fit)

   Asset subfolders
4. Click **Import** or right-click inside the new folder, and select **Import to Current Folder** from the context dropdown menu.

   [![There are a few ways to import assets into UEFN. Drag and drop, right-click context menu, or the Import button on the content browser toolbar.](https://dev.epicgames.com/community/api/documentation/image/58544c16-3742-4bf3-bce4-830fa0f9e9ba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/58544c16-3742-4bf3-bce4-830fa0f9e9ba?resizing_type=fit)

   Import options

   Select **Preview…** from the bottom toolbar to open a preview window where you can review all the assets you’re importing.

   [![Select Preview... to open the preview window to see all the assets that are part of the import.](https://dev.epicgames.com/community/api/documentation/image/9dead5f1-64a8-4a25-8342-d0ffd5fff6da?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9dead5f1-64a8-4a25-8342-d0ffd5fff6da?resizing_type=fit)

   Click image to enlarge.
5. Choose the [FBX file](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#fbx) containing the mesh you want to import, then click **Open**.
6. The **Import Content** window opens, click **Import** to import the asset and all its associated files.

   Manage the assets that import with your skeletal mesh from the Import Content window by customizing the import options of:

   - Static Meshes
   - Skeletal Meshes
   - Animations
   - Materials
   - Textures
7. Your character and any files associated with it upload to the subfolder.

When you import files other than FBX, the Import Content window [changes the import pipeline](https://dev.epicgames.com/documentation/en-us/fortnite/interchange-import-system-in-fortnite) to accommodate the file type you're importing.

[![When you import files other than FBX, the import pipeline changes to accommodate the file type.](https://dev.epicgames.com/community/api/documentation/image/dcad604a-1995-461f-8eea-2e9d7cca3819?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dcad604a-1995-461f-8eea-2e9d7cca3819?resizing_type=fit)

GLFT import pipeline

## Inspect Your Imported Assets

Inspect your imported assets by opening the different assets in their associated editors.

[![When you import a skeletal mesh, it imports with everything you need to get started so you don't have to import multiple assets separately.](https://dev.epicgames.com/community/api/documentation/image/b95c8c94-18e4-408b-82d4-cc7fc9d77dbd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b95c8c94-18e4-408b-82d4-cc7fc9d77dbd?resizing_type=fit)

Thumbnails for a skeletal mesh, skeleton, and animation

- **[Skeletal Mesh](https://dev.epicgames.com/documentation/en-us/fortnite/import-and-play-mesh-animations-in-unreal-editor-for-fortnite#skeletal-mesh-editor)**
- **[Animation Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/import-and-play-mesh-animations-in-unreal-editor-for-fortnite#animation-editor)**
- **[Skeleton](https://dev.epicgames.com/documentation/en-us/fortnite/import-and-play-mesh-animations-in-unreal-editor-for-fortnite#skeleton-editor)**

You can use these assets in other animation workflows in UEFN:

- [Creating animation presets.](https://dev.epicgames.com/documentation/en-us/fortnite/animation-presets-in-unreal-editor-for-fortnite)
- [Transferring character animations to a different character.](https://dev.epicgames.com/documentation/en-us/fortnite/transfer-character-animations-in-unreal-editor-for-fortnite)
- [Convert a static mesh into a skeletal mesh.](https://dev.epicgames.com/documentation/en-us/fortnite/convert-a-static-mesh-into-a-skeletal-mesh-in-unreal-editor-for-fortnite)

### Skeletal Mesh Editor

Double-clicking the skeletal mesh file opens a new window where you can see the mesh in greater detail. Click the **Skeleton Tree** tab on the right-hand side to navigate to any moving joint and test what parts of the skeleton [articulate](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#articulate).

### SkeletonEditor

Double-clicking the skeleton file opens a new window where you can see the skeleton of your skeletal mesh asset in greater detail. This editor provides a way to create and edit the bone hierarchy of your skeletal mesh asset.

### Animation Editor

Double-click the animation thumbnail to open the Animation Editor. The Animation Editor opens in a new window, from the editor you can ensure that the animations are applied to the right character and play as expected.

## Playing Animations on your Island

[![sequencer_minion](https://dev.epicgames.com/community/api/documentation/image/aaab4b48-15af-4d56-8b63-adceb981ab84?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aaab4b48-15af-4d56-8b63-adceb981ab84?resizing_type=fit)

There are several ways to get animations to play on your island. Each method has merit depending on your needs.

### Drag and Drop from the Content Browser

Select the **Animation Sequence** file you want, and drag it from the Content Browser into the viewport.

The animation will play in a perpetual loop unless otherwise specified in the asset’s **Details** tab under the **Animation** section.

[![Details tab](https://dev.epicgames.com/community/api/documentation/image/1da19587-f62e-44d3-834c-92e8cafcebc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1da19587-f62e-44d3-834c-92e8cafcebc0?resizing_type=fit)

The animation will not play in the editor. To see the animation play, [playtest](playtesting-your-island-unreal-editor-for-fortnite) your island in a Fortnite client.

[![drag_anim](https://dev.epicgames.com/community/api/documentation/image/19670949-d8fc-4f4e-b9ea-ec9f71fe0508?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19670949-d8fc-4f4e-b9ea-ec9f71fe0508?resizing_type=fit)

### Use the Animated Mesh Device

[![animated mesh device](https://dev.epicgames.com/community/api/documentation/image/6922c514-d6c7-4ad4-a171-2dfd6feae34e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6922c514-d6c7-4ad4-a171-2dfd6feae34e?resizing_type=fit)

When this [device](https://dev.epicgames.com/documentation/en-us/fortnite/using-animated-mesh-device-in-unreal-editor-for-fortnite) is paired to your animation, you can control the various animation triggers.

1. Navigate to **Fortnite > Devices** in your Content Browser.
2. Drag the **Animated Mesh** device into the viewport.
3. Configure the device **User Options** as follows:

   1. To bind the device to a skeletal mesh, drag and drop the mesh into the **Skeletal Mesh** field, or select the mesh from the field’s dropdown menu.
   2. Drag the animation you want for your mesh into the **Animation** field, or select it from the dropdown menu.

      [![death animation](https://dev.epicgames.com/community/api/documentation/image/65b8f107-7c64-4a72-984e-a71f57749c27?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/65b8f107-7c64-4a72-984e-a71f57749c27?resizing_type=fit)
4. Drag two **Trigger** devices into the viewport.
5. To [bind](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#bind) the triggers to the animation:

   1. Select the **Animated Mesh** device, and scroll down to **User Options - Functions**.
   2. For **Play Animation Event**, add an array element by clicking **+**, then select **Trigger** and **On Triggered** in the two respective fields.
   3. For **Pause Animation Event**, add an array element by clicking **+**, then select **Trigger2** and **On Triggered** in the two respective fields.

      [![trigger_bind](https://dev.epicgames.com/community/api/documentation/image/b9cca90a-568c-4920-acc0-b0e1329dd64d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9cca90a-568c-4920-acc0-b0e1329dd64d?resizing_type=fit)
   4. Press **Play** to open the client to see the device in action. Stepping on the first trigger starts the animation, and the second trigger pauses the animation.
