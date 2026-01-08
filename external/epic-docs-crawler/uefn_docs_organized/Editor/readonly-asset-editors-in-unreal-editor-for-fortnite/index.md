# Read-Only Asset Editors

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/readonly-asset-editors-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:16:27.549633

---

You can open [cooked](unreal-editor-for-fortnite-glossary#cook) assets in asset editors using a read-only mode. This mode allows you to view any data that is available and deemed appropriate in cooked assets without being able to modify the assets yourself.

The major advantage of being able to view cooked assets shipped with UEFN is seeing all the essential data on how they are set up, which teaches you good practices and serves as a solid point of reference for creating your own assets.

The types of assets that can be viewed in read-only mode are **Static Meshes** and **Textures**.

Assets shipped with UEFN, downloaded from Fab, and any other third-party cooked assets imported into a project can all be viewed in the Read Only Asset Editor.

## Viewing UEFN Assets

1. Open a UEFN project.
2. In the **Content Browser**, go to **All** and press on the **Filter** funnel next to the search bar. Select **Static Mesh** and **Texture** to apply the filters.

   [![Filter results](https://dev.epicgames.com/community/api/documentation/image/0da694e2-04b0-4e3e-be82-e152cbe7b66e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0da694e2-04b0-4e3e-be82-e152cbe7b66e?resizing_type=fit)
3. Double-click on a static mesh or texture to open the corresponding read-only editor.

## Viewing FAB Assets

1. In your UEFN project, open the **Fab Marketplace**.

   [![FAB toolbar](https://dev.epicgames.com/community/api/documentation/image/6d8dde81-83fe-45d0-a463-8a72df2c482b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d8dde81-83fe-45d0-a463-8a72df2c482b?resizing_type=fit)
2. Choose an asset, select **Add as a referenced asset** and click **Add to Content Browser**, or just drag it into your scene.

   [![FAB add to content browser](https://dev.epicgames.com/community/api/documentation/image/48f4b00c-7750-41c6-96a3-9a790273bfd9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48f4b00c-7750-41c6-96a3-9a790273bfd9?resizing_type=fit)
3. Back in The **Content Browser**, go to **All** > **Referenced Content** > **Asset\_Name**, and double-click on the **Static Mesh** file associated with the asset.

   [![Asset in Content Browser](https://dev.epicgames.com/community/api/documentation/image/26d137b6-5766-4e98-b553-91c8dca6aecb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26d137b6-5766-4e98-b553-91c8dca6aecb?resizing_type=fit)
4. This opens the read-only static mesh editor.

Some FAB assets will allow you to edit their properties. In those cases it is possible to select **Add as a modifiable Unreal Engine asset** before adding it to your Content Browser.

[![modifiable asset](https://dev.epicgames.com/community/api/documentation/image/a3fc77ec-373b-4b37-9b8f-e71026a72a82?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a3fc77ec-373b-4b37-9b8f-e71026a72a82?resizing_type=fit)

## Read-Only Editor Differences

In a regular editor window, most settings are available to you. You can change material layers and the collision of the asset.

[![regular editor](https://dev.epicgames.com/community/api/documentation/image/c58d39f5-8f76-4edc-8b3f-0f7602613444?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c58d39f5-8f76-4edc-8b3f-0f7602613444?resizing_type=fit)

*Click on image to expand.*

When you open a cooked read-only asset, you will notice that most options are grayed-out. In addition, you will see a **Read-Only** tag on the top right corner of the editor window.

[![read-only editor](https://dev.epicgames.com/community/api/documentation/image/37ca7b04-7655-4590-aa26-8e760f327d63?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/37ca7b04-7655-4590-aa26-8e760f327d63?resizing_type=fit)

*Click on image to expand.*

### Preview Scene Settings

In read-only you can still change the lighting and environment to preview how the asset will look in different settings. This will not change any of the asset’s properties, but can help you see if the asset is a good fit for your scene.

1. Go to **Window** and check **Preview Scene Settings**.

   [![Preview scene settings](https://dev.epicgames.com/community/api/documentation/image/f48b9be9-83ec-4387-96d2-d56dee747cd7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f48b9be9-83ec-4387-96d2-d56dee747cd7?resizing_type=fit)
2. Change the settings to customize the asset preview.

[Mushroom House](https://sketchfab.com/3d-models/mushroom-house-c98d255da98c4343b903aab07631eadd) by [GraphOrigin](https://sketchfab.com/olivia9900) licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
