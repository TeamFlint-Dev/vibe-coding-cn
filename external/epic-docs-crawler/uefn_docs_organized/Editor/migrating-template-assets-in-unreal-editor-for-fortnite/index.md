# Migrating Template Assets

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/migrating-template-assets-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:12:13.570945

---

All feature template assets can be used in your own projects. That means anything found in the **UI folder** can be migrated into another project.

[![All folders under UI can be migrated.](https://dev.epicgames.com/community/api/documentation/image/444c2f36-9d56-4f99-b86d-c91841c76a49?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/444c2f36-9d56-4f99-b86d-c91841c76a49?resizing_type=fit)

All folders under UI can be migrated.

Only the Textures folder can be migrated on its own, but all device-related assets must be migrated for them to work with the device.

Do the following to migrate assets:

1. In the **Content Browser**, select the **Asset(s)** folder from the asset list.
2. Right-click and select **Migrate...** from the Context Menu. This opens the **Asset Report** window.

   [![Right-click on the asset you wish to export, then select Migrate...](https://dev.epicgames.com/community/api/documentation/image/0abd7add-ae64-4448-a7af-8396683df29e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0abd7add-ae64-4448-a7af-8396683df29e?resizing_type=fit)

   Right-click on the asset you wish to export, then select Migrate...
3. From the **Asset Report** window, select the assets you want to export, then click **OK**.

   [![Checkmark all the assets you wish to migrate into your own project.](https://dev.epicgames.com/community/api/documentation/image/2b40eebb-851c-493c-8cb1-23a14c620388?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b40eebb-851c-493c-8cb1-23a14c620388?resizing_type=fit)

   Checkmark all the assets you wish to migrate into your own project.

   All assets inside the folders will automatically be selected. If you don’t want to migrate all of the assets, deselect the assets you don’t want in the list.
4. Search for the project folder within **Fortnite Projects** where you want to place the assets.

   [![Select a project from inside the Fortnite Projects folder.](https://dev.epicgames.com/community/api/documentation/image/9ee47d7b-7efb-44c6-bcc0-f85f5ba97e24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9ee47d7b-7efb-44c6-bcc0-f85f5ba97e24?resizing_type=fit)

   Select a project from inside the Fortnite Projects folder.
5. Open the project's **Content** folder and click **Select Folder**.

   [![Migrate the assets into the projects' Content folder.](https://dev.epicgames.com/community/api/documentation/image/84b4feb2-4d7e-48d9-b485-e8c1259906f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/84b4feb2-4d7e-48d9-b485-e8c1259906f7?resizing_type=fit)

   Migrate the assets into the projects' Content folder.
6. The asset folders import into the new project Content folder.

   [![The assets have migrated into the Content folder.](https://dev.epicgames.com/community/api/documentation/image/471992d9-3018-4a9e-b12e-e0d88830cfc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/471992d9-3018-4a9e-b12e-e0d88830cfc0?resizing_type=fit)

   The assets have migrated into the Content folder.
