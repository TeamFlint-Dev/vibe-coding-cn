# Import from Fab

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/import-from-fab-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:55:53.894939

---

Unreal Editor for Fortnite (UEFN) has a [Fab](https://dev.epicgames.com/documentation/en-us/fab/fab-documentation) integration that provides direct access to Fab where you can import third party assets into your UEFN projects to create a truly unique island. Browse the different asset categories to find the perfect custom assets for your island.

Browse assets in Fab from the Epic Games launcher before opening UEFN. For more information, see **[Exporting Assets from Fab in Launcher](https://dev.epicgames.com/documentation/en-us/fab/exporting-assets-from-fab-in-launcher)**.

Assets compatible with UEFN and Fortnite Creative are curated and modified to work with Fortnite islands. Look for the **UEFN** tag in [Included formats](https://dev.epicgames.com/documentation/en-us/fortnite/fab-user-interface-reference-in-unreal-editor-for-fortnite#product-preview) when browsing Fab. Fab is available from the **Window** menu or by clicking the **Fab** button in the [Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-browser).

[![You can open Fab from the Window menu.](https://dev.epicgames.com/community/api/documentation/image/9cd47eb6-398e-4bc4-8011-eef913cfd5ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9cd47eb6-398e-4bc4-8011-eef913cfd5ac?resizing_type=fit)

Click to enlarge image.

[![You can open Fab from the Content Browser by clicking the Fab button.](https://dev.epicgames.com/community/api/documentation/image/ce16a8b2-6d48-4481-91b8-1ac0d5a624d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce16a8b2-6d48-4481-91b8-1ac0d5a624d7?resizing_type=fit)

Click to enlarge image.

You can dock the Fab window into the UEFN interface.

If you don’t have Fab in the **Window** options list, an [end user license agreement](https://www.fab.com/eula) opens in a popup. You must accept all the terms and conditions to get the Fab entitlements and to continue on to Fab.

## Browsing Custom Assets

Use the [Fab UI](https://dev.epicgames.com/documentation/en-us/fortnite/fab-user-interface-reference-in-unreal-editor-for-fortnite) to navigate through the thousands of assets available. To view a larger selection of assets, toggle the [Include 3D compatible formats](https://dev.epicgames.com/documentation/en-us/fortnite/fab-user-interface-reference-in-unreal-editor-for-fortnite#navigation-controls) button.

- Assets have a unique look and feel, and are optimized to work in Fortnite while running on different platforms. Assets are free of advertisements and promotional material.
- Adding these customized pieces and packs to your project makes your island stand out because they aren’t Fortnite assets.

When using 3D models from Fab, be aware that some require a lot of memory and may not perform well on some platforms.

## Importing Fab Assets

Follow the instructions below to import an asset into UEFN.

1. Click **Window** > **Fab** from the menu bar. The Fab window opens.
2. Select an **asset tile**.

   [![An example of an asset tile in Fab.](https://dev.epicgames.com/community/api/documentation/image/9f183290-5cc8-4b37-bd8a-9e04be727bda?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f183290-5cc8-4b37-bd8a-9e04be727bda?resizing_type=fit)

   Click to enlarge image.
3. Select a **[License](https://dev.epicgames.com/documentation/en-us/fortnite/import-from-fab-in-unreal-editor-for-fortnite#license-types)** from the License dropdown.

   [![You must select a License type before you can purchase a Fab asset.](https://dev.epicgames.com/community/api/documentation/image/5b3024a7-749b-4ef7-8528-c472b48029b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5b3024a7-749b-4ef7-8528-c472b48029b6?resizing_type=fit)

   Click to enlarge image.
4. Click the **Buy Now** button to [purchase an asset](https://dev.epicgames.com/documentation/en-us/fab/purchasing-and-downloading-assets-in-fab) and add it to your files in the Content Browser.

   [![Click the Buy Now button to purchase an asset and add it to your files in the Content Browser.](https://dev.epicgames.com/community/api/documentation/image/57f51ac4-d40b-4512-a5a8-c1a6f30d0862?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57f51ac4-d40b-4512-a5a8-c1a6f30d0862?resizing_type=fit)

   Click to enlarge image.
5. If the asset is free, click **Add to Content Browser** to add the asset to your files in the Content Browser.

   [![If the asset is free, click Add to Content Browser to add the asset to your files in the Content Browser.](https://dev.epicgames.com/community/api/documentation/image/925a46c4-3355-4aa2-a0b9-75f7343b8e95?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/925a46c4-3355-4aa2-a0b9-75f7343b8e95?resizing_type=fit)

   Click to enlarge image.

Imported assets appear in the **Content Browser** under the **main project folder** in a new folder entitled, **Referenced Content**.

[![Imported assets appear in the Content Browser under the main project folder in a new folder entitled, Referenced Content.](https://dev.epicgames.com/community/api/documentation/image/2e98e942-2942-43d0-80fa-2033b30fd9c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2e98e942-2942-43d0-80fa-2033b30fd9c3?resizing_type=fit)

Click to enlarge image.

Some Fab assets have an option to select [Modifiable Content](https://dev.epicgames.com/documentation/en-us/fortnite/import-from-fab-in-unreal-editor-for-fortnite#using-modifiable-content).

For information about selling your creations on Fab, see [Publishing Assets for Sale](https://dev.epicgames.com/documentation/en-us/fab/publishing-assets-for-sale-or-free-download-in-fab).

### Referenced Content

**Referenced content** refers to assets that are compatible with UEFN and Fortnite  . These assets can be used in UEFN projects by using a [Verse path](https://dev.epicgames.com/documentation/en-us/fortnite/import-from-fab-in-unreal-editor-for-fortnite#verse-path) to reference assets imported from Fab in Verse code.

[![The asset description contains information important to the referenced content.](https://dev.epicgames.com/community/api/documentation/image/5ce0a32e-4366-48b0-9002-cb5ca01bc29e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5ce0a32e-4366-48b0-9002-cb5ca01bc29e?resizing_type=fit)

Click to enlarge image.

When purchasing an asset through Fab, the **[Included formats](https://dev.epicgames.com/documentation/en-us/fortnite/fab-user-interface-reference-in-unreal-editor-for-fortnite#product-preview)** section provides asset update information as well as UEFN compatibility data, such as:

- The collision ready status.
- Optimization for Fortnite vertex, materials, and textures.
- Scale of the asset in [Fortnite units](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#unreal-units).

The benefits of using a referenced asset are:

- Faster moderation times.
- Your asset is always current with the latest version from its asset creator.
- Reduced disk space and cook times.

### Verse Path

A [Verse path](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#path) is the global namespace for identifying your Fab assets. These paths are persistent, unique, and discoverable by any Verse programmer.

[![Assets can be referenced through their Verse path.](https://dev.epicgames.com/community/api/documentation/image/4221b104-6189-4739-a199-a55c2921bb2b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4221b104-6189-4739-a199-a55c2921bb2b?resizing_type=fit)

Click to enlarge image.

Exposing your Fab assets to Verse provides a way to use them from your Verse code to create unique gameplay or events. Adding assets using their Verse path means you will not be able to set [LODs](https://dev.epicgames.com/documentation/en-us/fortnite/setting-the-level-of-detail-in-unreal-editor-for-fortnite), [collision](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#collision) or destructibility.

For more information about using a Verse path, see [Exposing Assets with Asset Reflection to Verse](https://dev.epicgames.com/documentation/en-us/fortnite/exposing-assets-with-asset-reflection-to-verse-in-unreal-editor-for-fortnite).

### License Types

All available assets in Fab use licensing agreements to legally authorize you to use someone else's intellectual property. You must select a [pricing tier](https://dev.epicgames.com/documentation/en-us/fab/licenses-and-pricing-in-fab) before completing a purchase. Free assets are licensed through [Creative Commons Attribution](https://dev.epicgames.com/documentation/en-us/fortnite/import-from-fab-in-unreal-editor-for-fortnite#creative-commons-attribution).

Purchasable assets are categorized with one or more of the following standard license types:

- **UEFN - Reference only**: A license that covers an individual creator or a small team with no more than $100k of revenue or funding in the last 12 months. This type of license only includes a referenced version of the asset.
- **Personal**: A license that covers an individual creator or a small team with no more than $100k or revenue or funding in the last 12 months.
- **Professional**: For studios or other entities with over $100k in revenue or funding in the past 12 months.

Pricing tiers vary by asset and standard license type.

#### Creative Commons Attribution

[Creative Commons Attribution](https://creativecommons.org/licenses/by/4.0/) requires you to give appropriate credit to the asset’s creator when using their work, along with providing a link to the license and indicating if changes were made to the asset.

This license type has a set of predefined permissions for the use of the asset within specific limits. These permissions typically cover allowance for common uses, such as:

- Copying
- Distributing
- Displaying
- Creating derivative works that credit the original creator

Regardless of license type, you must provide attribution to third party assets used on your island when you publish. To learn more about providing attribution, see [Third Party Assets](https://dev.epicgames.com/documentation/en-us/fortnite/attribution-screen-in-fortnite-creative) in the [Using Creator Portal](https://dev.epicgames.com/documentation/en-us/fortnite/using-creator-portal-in-fortnite-creative) documentation.

## Using Modifiable Content

Modifiable content refers to assets you can modify in line with the constraints of the license agreement. After importing modifiable content, the asset’s folder appears in the **Content Browser** under the **main project folder**. This folder contains all the import data for your imported asset: [materials](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#material), [meshes](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#mesh), and [textures](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#texture).

In UEFN, modifiable content means:

- The asset is detached from any updates its creator makes and results in slower moderation times.
- You can set the [LODs, collision, and destructibility](https://dev.epicgames.com/documentation/en-us/fortnite/configuring-collision-for-a-static-mesh-in-unreal-editor-for-fortnite) to make the asset unique.

## Importing Packs

Packs are multiple assets sold together in a single file and are purchased the same way you would any other asset. Packs are usually modular with all assets inside a pack created using the same style. Packs may include some unique assets that cannot be found elsewhere on their own. The singular assets of a pack are not always available for individual sale on [Fab.com](http://fab.com).

[![Search for packs using the search bar.](https://dev.epicgames.com/community/api/documentation/image/b09e9195-bef1-4af0-9704-991e5f28a7e1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b09e9195-bef1-4af0-9704-991e5f28a7e1?resizing_type=fit)

Click to enlarge image.

Packs can be delivered as referenced assets through a single Verse path. The assets in a pack can be individually referenced within UEFN by dragging pack items from the Content Browser into the viewport.

Removing a pack asset from a project does not remove that asset from the pack listed under **[My Purchases](https://dev.epicgames.com/documentation/en-us/fab/purchasing-and-downloading-assets-in-fab)**.

## Limitations

- If the total file size of all assets exceeds 256 MB, you will not be able to deploy the level to Fortnite Creative. This limitation is to minimize download times.
- You can check the size of all content by going to File Explorer/Finder and locating the project under Fortnite Projects > ProjectName > Plugins > ProjectName > Content, and right-clicking the Referenced Content folder.
- Referenced assets are not compatible with Scene Graph Beta. Source assets are compatible with Scene Graph Beta, be sure to select the correct content type to use with Scene Graph.
