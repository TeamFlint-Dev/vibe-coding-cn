# Migrating Assets from Unreal Engine

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/migrating-assets-from-unreal-engine-to-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:55:21.915552

---

You can use content originally created in Unreal Engine 5 (UE5) in Unreal Editor for Fortnite (UEFN). UEFN supports a wide range of UE5 asset types.

The preferred asset migration workflow is to use the Migration Tool in the Unreal Editor, and select the Content folder in your UEFN project as the target destination.

This migration path provides a means to reuse your previously-saved assets from UE5 in new UEFN projects, while also leveraging the new features and Fortnite content available in UEFN.

**Unreal Editor for Fortnite (UEFN)** has a way for users to import custom content from a wide range of platforms.

Your Unreal project must be running on Unreal Engine 5.1 or later for the tool to work properly.

UEFN does not support all of Unreal Engine's asset types. Further, some supported asset types have additional limitations to comply with Fortnite performance requirements. For example, Static Mesh assets should not exceed 20k vertices. Read about UEFN asset limitations here.

## Migration Tool

The Migration Tool was updated in Unreal Engine 5.1 to support UEFN as a target destination.

To move content from UE to UEFN with the Migration Tool, your projects must meet the following minimum version requirements.

- Source — An Unreal Engine project running in UE 5.1 or newer.
- Destination — A UEFN project running on Fortnite 23.00UEFN or newer.

1. Open Unreal Engine and select the project with content that you want to migrate to UEFN.
2. Locate the asset(s) or folder(s) you want to import into UEFN and **right-click** to see the context menu.

   1. For a single asset, select **Asset Actions > Migrate...**\*![asset migrate](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/7201be69-acb4-48c9-bb60-e33921b87f3b/asset_migrate.png)
   1. For a folder, select **Migrate...**![folder migrate](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/fea3feba-f857-4931-8926-def6bc7fba11/folder_migrate.png)
3. A Save Content window opens with the selected file, click Save Selected.

   ![Save Content window](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/294cef6c-43fa-4e45-8325-ac524683d09f/save-content.png)
4. A Save Level As window opens, name the level, then click Save.

   ![save Level As window](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/dcb3f66d-2292-44d2-95a9-ee6fc4ad0967/save-level.png)
5. An **Asset Report** dialog opens, showing the contents of the selected assets. Click **OK** to confirm.

   If you don't want to migrate an asset in this list, uncheck the checkbox next to that asset. Keep in mind, however, that this might break other assets you are trying to migrate (for example, a material will no longer show correctly if one of its textures is missing).

   ![asset report](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/4084a7c3-3add-4067-bd81-d126d6574ca2/asset_report.png)
6. A file browser window opens, prompting you to select the UEFN project you want to migrate assets to. Open to your UEFN project folder, then navigate to **Plugins** > **Project\_Name** > **Content** and click **Select Folder**.

   ![destination_folder](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/b079891a-0b4d-4614-8887-b96c400732e5/destination_folder.png)

The assets should now be present in your chosen UEFN project folder and visible from the Content Browser.

![uefn_assets](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/98fc9702-8a71-4ef4-a7bd-4084e2d694a9/uefn_assets.png)

Copy-pasting content directly into your UEFN project directory is not a supported workflow, and will not result in a successful migration.

## Limitations

The Migration Tool is not aware of the content limitations of the destination, so it cannot perform any sort of asset validation when you attempt to migrate content. In other words, the Migration Tool will migrate your assets whether or not they are actually compatible with UEFN.

As noted above, UEFN has many asset limitations. For example, some asset types cannot exceed a certain size, and some UE5 asset types are not supported at all.

The current implementation of the Migration Tool needs to load all the assets in memory to migrate them. This tool is in active development. We expect to provide performance improvements and a better user experience for validating and cleaning up incompatible content in the future.

## Troubleshooting

Whenever you migrate an asset type that is not recognized by UEFN, you will see **unsupported assets** appear in your Content Browser.

![Unsupported Assets](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/7b08f362-0e81-4bb1-800a-f5f4de80bbf8/unsupported-assets.png)

Having unsupported assets in your project can prevent you from testing your experience, so it is recommended that you delete them.
