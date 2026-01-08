# Resizing Textures

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:17:19.819281

---

Game [textures](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#texture) have specific requirements to render properly in-game. When creating textures in Unreal Editor for Fortnite (UEFN) with [imported](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite) images make sure the source image file uses the power of two for height and width. This increases the compatibility and stability of your island across [platforms](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#platform).

Compressed file formats for graphics processing units (GPUs) must use power of two textures across all consoles, PCs, and mobile. Textures that don’t conform to the power of two rule will become unstable on lower-end platforms and possibly cause game crashes. Power of two is also used in texture streaming to lower texture resolution on platforms with less memory.

Texture streaming helps with:

- Changing a texture’s resolution.
- Determining how quickly a game loads.
- Increasing the visual quality of the game.
- Saving GPU memory.

## What Power of Two Is

Computers and consoles manage and process data in limited chunks rather than all at once. This is a similar principle to how backgrounds are rendered using [World Partition](https://dev.epicgames.com/documentation/en-us/fortnite/streaming-and-hlods-in-unreal-editor-for-fortnite).

When the chunks of game data respect the power of two rule, the data chunks establish a set of hard-coded, physical restrictions on media. Unless these restrictions are conformed to, the game engine will waste resources trying to properly [render](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#render) [assets](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#asset).

Power of two is a way to optimize game data and render images to efficiently display visual experiences.

Examples of acceptable image sizes are: **256x256,** **512x512**, or **1024x2048**. Textures that don’t use the [power of two](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite#what-power-of-two-is) will not be optimized and cause both instability and poor island performance.

Power of two textures allow UEFN to use three key features:

- Texture compression: Reduces memory size by approximately eight times at a minimal visual cost.
- Mipmapping: The automatic generation of lower-resolution variants
- Texture streaming: Shows a lower-resolution variant before higher-resolution data can be streamed into memory.

Combined, these features allow even a high-end asset with 4K textures to render on any [platform](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#platform). This is because the textures will have high-quality variants at a reduced resolution.

For example, a 4000x4000 texture with no alpha layer would require 64 megabytes of memory. This would have to be loaded at once and will still display at 4000x4000 even if it was causing [aliasing](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#aliasing) on a small billboard, far away from the player. Texture sizes that are too large can crash devices that do not have enough memory.

By contrast, a 4096x4096 version of a texture that uses Default compression will consume only 8 megabytes, stream progressively, and produce less aliasing at a distance. Texture sizes that are too large will also increase its package size but will not cause the gameplay to crash.

## Texture Validation

Textures must be validated for performance purposes before being used in a project. If a texture is not validated, it will cause the following issues:

- Out of Memory (OOM) crash due to source textures being too large.
- Platforms crashing due to cooked textures being too large.
- Platform performance issues due to suboptimal textures.

Textures that don't pass validation will prevent a project from being able to publish.

## Validation Rules

Validation rules include a universal rules that apply to all assets, and three main rules that apply only to textures.

#### Universal Rule

- No source dimension can be greater than **4096** texels.

#### 2D Textures in UI

- Any cooked textures less than **1,048,576 texels** (1024 X 1024) automatically passes validation.

#### 2D Textures

- Cooked textures less than **1,048,576** texels (1024 X 1024) automatically pass validation.
- Cooked dimensions cannot be greater than **2048** texels.
- Cooked dimensions must be power of two.
- Must be streamable and allow the creation of mips.

#### Cubemap Textures

- Any cooked texture (per face) *less* than **1,048,576** texels automatically passes validation.
- Cooked dimensions cannot be greater than **1024** texels. This is per face, not the asset.
- Cooked dimensions must be power of two.
- Must be streamable and allow the creation of mips.

## Finding Invalid Textures

UEFN has strict [size requirements](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite#texture-sizing-requirements-for-uefn) for textures, to ensure all imported textures are using the proper size constraints, UEFN contains additional validators beyond what Fortnite offers. These validators use rules to catch and surface issues earlier in the building process to avoid uploading projects that inevitably fail to cook.

There are two areas where a texture is validated; during the [project validation process](https://dev.epicgames.com/documentation/en-us/uefn/project-size-tool-in-unreal-editor-for-fortnite), and also when added to the Content Browser.

### Project Validation

The texture’s validation errors display after a project goes through the validation process. The process always uses the actual texture data (as opposed to asset tags). All results are printed to the Message Log with an “Auto Fix” token.

[![An example of a project failing validation.](https://dev.epicgames.com/community/api/documentation/image/cc44762d-dbba-40aa-96da-b55e6f9d0ddb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cc44762d-dbba-40aa-96da-b55e6f9d0ddb?resizing_type=fit)

### Content Browser Validation

The texture’s thumbnail and tooltip displays an icon and summary respectively. The context menu offers a “Conform Texture” option. Conform Texture attempts to use actual texture data, and for performance reasons falls back to asset tags if the texture isn’t loaded. If it reads asset tags, it could be slightly less accurate if certain tags are missing. However, the next time the texture’s actual data is validated (Project Validation, OnObjectTransacted) the tooltip and thumbnail will be updated accurately.

Texture assets that do not conform to the requirements laid out above are marked in the Content Browser by an error icon. Hovering over the asset shows more detail about the specific problem at the top of the tooltip:

[![An example of a texture error message.](https://dev.epicgames.com/community/api/documentation/image/4d83f1a1-b931-43ce-8ded-07430f570a32?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d83f1a1-b931-43ce-8ded-07430f570a32?resizing_type=fit)

For information on using Conform Texture, see the [Conforming Invalid Textures](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite#conforming-invalid-textures) section below.

## Texture Sizing Requirements for UEFN

To ensure that all islands work well on all target platforms, UEFN enforces certain requirements on texture assets.

If your project contains texture assets that do not conform to these requirements, those textures will fail validation, and you will be blocked from uploading your project.

- If your texture is assigned to the UI texture group, its dimensions must be less than the maximum size of **2048x2048**. However, the texture’s dimensions do not need to be powers of 2. (UI textures do not typically stream, so that they will always appear as sharp as possible.)
- If your texture is \_not \_assigned to the UI texture group, its dimensions must be less than the maximum size of **4096x4096**. In addition, if it contains more pixels than the minimum threshold (1024x1024, or 1048576), it must be streamable. This means that;

  - Each of its dimensions must be a power of two (for example, 256x256, 512x512, 1024x1024, and so on).

    The image does not have to be square, as long as each dimension is a [power of two](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#power-of-two). For example, 256x512, 512x1024, 256x1024, and so on.
- The texture's **Never Stream** property must be disabled.
- The texture must be set to generate mipmaps.
- The total memory cost of all non-streaming textures in your project must be less than a preset maximum budget. The memory cost for your project is determined by adding up the memory cost of all textures whose Never Stream property is enabled. This includes:

  - All textures whose dimensions are not powers of two (and that have not been padded or stretched to powers of two using the Padding and Resizing property). The Never Stream property is always automatically enabled for these textures.
  - All other textures whose Never Stream property has been manually enabled.

Every texture has a Texture Group setting that indicates its expected usage. You can set this group, and the other texture properties referred to above, by double-clicking the texture asset in the Content Browser to open the Texture Editor.

## Resizing Textures

In UEFN, old imported textures that use uneven dimensions or bloated sizing can be scaled according to the power of two. Find and fix failing textures by following the steps below:

1. Open the **Content Drawer** or the **Content Browser**, and make sure to select your project’s **root content folder,** located in **FortniteGame** on the left-side file tree panel.
2. Under **All**, find the folder named **YourProjectName Content**.
3. Type `NeverStream==true&&TextureGroup!=UI` in the search bar at the top of the Content Drawer. This runs a query to identify any affected assets.

   [![Use the **Content Browser's** search bar to find assets that need to be fixed.](https://dev.epicgames.com/community/api/documentation/image/85d9ece5-ebd3-4d73-924a-ac3ad4abc68c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/85d9ece5-ebd3-4d73-924a-ac3ad4abc68c?resizing_type=fit)

All assets that appear in this filtered view are impacted. Though this takes a while to fix, it will improve your level’s performance.

There are two ways to update affected textures that aren't in the UI group.

[Option A](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite) uses UEFN’s [bulk editing](https://dev.epicgames.com/documentation/en-us/fortnite/editing-components-in-unreal-editor-for-fortnite) capabilities to group textures and edit them in one step. This is the quickest way to automatically correct your textures by padding them to the correct aspect ratio; however, this padding could result in unnecessary memory usage.

[Option B](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite) takes a little longer but will make the best use of your memory budget if you need multiple affected textures resolved. This option will let you edit and re-upload textures to avoid unnecessary padding.

### Option A

1. Click the **hamburger menu** in the **Content Browser** next to the search bar and select **Textures**. All textures are isolated in the Content Browser.

   [![Click the **hamburger** menu to search for textures.](https://dev.epicgames.com/community/api/documentation/image/3a357758-efea-4c20-89d2-e583dfbc1ef1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a357758-efea-4c20-89d2-e583dfbc1ef1?resizing_type=fit)
2. Click the **Settings** icon and turn on **Columns**. All textures are now listed in columns in the Content browser.

   [![Select **Columns** from the **Settings** menu.](https://dev.epicgames.com/community/api/documentation/image/8a4141b1-e14e-4ae2-bc3a-fe9d962bbff3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8a4141b1-e14e-4ae2-bc3a-fe9d962bbff3?resizing_type=fit)
3. Search through the **Dimensions** column for any asset that is not using the power of two sizing.

   [![Search for dimensions that do’t use the power of two rule.](https://dev.epicgames.com/community/api/documentation/image/43b77fac-63f9-41f6-842a-2df4c30ea6d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/43b77fac-63f9-41f6-842a-2df4c30ea6d0?resizing_type=fit)
4. Select all Textures that don’t conform to the power of two rule.
5. Right-click in the **Content Browser** and select **Asset Actions** > **Edit Selection in Property Matrix**. This opens the bulk editor tool where all the selected textures will be itemized in the Component Editor tab.

   [![Select **Asset Actions** > **Edit Selection in Property Matrix**.](https://dev.epicgames.com/community/api/documentation/image/007351c1-20a4-42e8-bbc8-454b65e3b73b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/007351c1-20a4-42e8-bbc8-454b65e3b73b?resizing_type=fit)
6. Select all **texture file names** in the **Root** section.

   [![Select all files under the **Root** section.](https://dev.epicgames.com/community/api/documentation/image/8409a40b-3ba5-4308-8ec5-dae75cd47e2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8409a40b-3ba5-4308-8ec5-dae75cd47e2e?resizing_type=fit)

   *Click image to enlarge.*
7. Open the **Texture** option in the **Pinned Columns** tab.
8. Select **Pad to Power Of Two** from the **Padding and Resizing** dropdown menu. A progress bar appears at the bottom of the editor window.

The textures have all been converted to power of two and will work across platforms now.

### Option B

1. Double-click the texture to open the **texture editor**.
2. In the search bar at the top of the **Details** panel, enter the name of your **source file**. The result will showthe file path on your PC that will be used as the texture's original source file.

   [![Find the original file path for your texture.](https://dev.epicgames.com/community/api/documentation/image/d217e602-c2e7-48f5-8229-d7f84e8f3984?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d217e602-c2e7-48f5-8229-d7f84e8f3984?resizing_type=fit)

   *Click image to enlarge.*
3. Resize the texture to the closest power of two size using an image editor such as GIMP or [Paint.NET 5](http://getpaint.net/download.html). You can even use Paint if the texture doesn’t feature an alpha layer.

   1. A power of two size includes **256**, **512**, **1024**, etc.
   2. For example, a 500x500 texture should be 512x512, and a 600x256 texture could be 512x256.
   3. Changes in aspect ratio should not have adverse effects on your island.
4. Right-click the texture in the **Content Browser** and select **Reimport**.

   [![Select **Reimport** to reimport your updated texture.](https://dev.epicgames.com/community/api/documentation/image/4f136500-c579-4eeb-8bf2-b13fa0bbcf23?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f136500-c579-4eeb-8bf2-b13fa0bbcf23?resizing_type=fit)

If the original texture image is missing from your files:

1. Right-click the texture in the **Content Browser** then select **Asset Actions** > **Export** to get a new copy.

   [![Export the asset if you can’t find the original file source.](https://dev.epicgames.com/community/api/documentation/image/2824cde1-4b27-4e18-ae2b-b65cc7db62b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2824cde1-4b27-4e18-ae2b-b65cc7db62b1?resizing_type=fit)
2. Resize the texture to the closest power of two size. Then in the **Content Browser** right-click the texture and select **Reimport With New File**. When the file imports, double-click the texture to open the **texture editor**.

   [![**Reimport With New File** imports the new file in place of the one not using power of two.](https://dev.epicgames.com/community/api/documentation/image/a91f024a-0235-4589-af43-fe89f5450d47?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a91f024a-0235-4589-af43-fe89f5450d47?resizing_type=fit)
3. In the **Details** search bar, type **Never Stream** then set the option as **False**. If it cannot be set to **False**, then make sure the **Imported** specification at the top shows your image has a power of two size.

   [![Check the **Imported** size of the texture.](https://dev.epicgames.com/community/api/documentation/image/49d2ed30-722b-48ba-bc26-58eb7e02ce54?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/49d2ed30-722b-48ba-bc26-58eb7e02ce54?resizing_type=fit)
4. In the **Details** panel, search for the **Mip Gen Settings** option. Then in the dropdown menu, select **From Texture Group**.

   [![Set **MIP Gen Settings** to **From Texture Group**.](https://dev.epicgames.com/community/api/documentation/image/d17ebee3-af26-4dc6-9774-0b200e24bdc6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d17ebee3-af26-4dc6-9774-0b200e24bdc6?resizing_type=fit)
5. In the **Details** panel, search for the **Compression Settings** option, then select **Default (DXT1/5)** from the dropdown menu.

   [![From the **Compression Settings** doprdown menu, select **Default (DXT1/5)**.](https://dev.epicgames.com/community/api/documentation/image/4dff40bf-3d19-46a1-a45c-81b2d3b0612a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4dff40bf-3d19-46a1-a45c-81b2d3b0612a?resizing_type=fit)

Once you’ve completed these steps, check to see if you have successfully removed the restricted texture by searching `NeverStream==true&&TextureGroup!=UI` in the **Content Browser** search bar again. The asset(s) you have updated should no longer appear here now.

## Change an Individual Texture

Use the directions below if you only have one texture that doesn’t follow the power of two rule.

1. Double-click the texture to open the **texture editor**.

   [![Open the **texture editor**.](https://dev.epicgames.com/community/api/documentation/image/db29bf1d-5980-4410-9b72-460ca702483d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/db29bf1d-5980-4410-9b72-460ca702483d?resizing_type=fit)

   *Click image to enlarge.*
2. In the **Details** search bar, type **Power of Two Mode.** Then in the **Padding and Resizing** dropdown menu, select **Pad to Square.**

   [![Change the size of your texture with **Pad to Square Power Of Two**.](https://dev.epicgames.com/community/api/documentation/image/975454c8-8e3e-4760-b57b-92fe33d7526d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/975454c8-8e3e-4760-b57b-92fe33d7526d?resizing_type=fit)
3. Search for the **Never Stream** option and set it to **False**.

   [![Turn off **Never Stream**.](https://dev.epicgames.com/community/api/documentation/image/d537bc5b-7432-406a-8cb7-22f812a56ff1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d537bc5b-7432-406a-8cb7-22f812a56ff1?resizing_type=fit)
4. Search for the **Mip Gen Settings** option. Then from the dropdown menu, select **From Texture Group**.

   [![Select **From Texture Group** in the **MIP Gen Settings** dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/3f957797-87fa-4fd4-bae9-8c71d8f2cbce?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f957797-87fa-4fd4-bae9-8c71d8f2cbce?resizing_type=fit)
5. Search for the **Compression Settings** option, then from the dropdown menu, select **Default (DXT1/5)**.

   [![Select **Default (DXT1/5)** from the **Compression Settings** dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/b5e9ad6e-73c6-4adf-8326-ffc098ffd0e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b5e9ad6e-73c6-4adf-8326-ffc098ffd0e9?resizing_type=fit)

Once you’ve completed these steps, check that you’ve successfully removed the restricted texture by searching `NeverStream==true&&TextureGroup!=UI` in the **Content Browser** search bar. The asset(s) you updated should no longer appear in the list.

## Conforming Invalid Textures

The best way to fix invalid textures that you’ve imported from external files is to edit them in the original application that you used to create them, and then reimport the asset. You can also use another dedicated image editing application to edit the textures before reimporting them into UEFN.

Make sure the dimensions of each image are less than the maximum dimensions outlined above. If you’re not using the image for UI, make both the image height and width powers of two. The image does not have to be square, as long as each dimension is a power of two.

As an alternative, the UEFN offers a built-in way to make your texture sizes conform with UEFN requirements automatically. To do this:

1. In the **Content Browser**, select one or more invalid textures.
2. Right-click on a texture thumbnail and choose **Conform Texture** from the contextual menu.

The editor attempts to adjust the properties of the selected textures to avoid validation problems, and writes its results to the Output Log.

This operation has the following effects:

- If the texture is in the UI texture group, and its dimensions are larger than the maximum permitted, the texture’s **Compression > Advanced > Maximum Texture Size** setting is adjusted to limit the maximum resolution of the texture that can be loaded at runtime.
- If the texture is not in the UI texture group, and its dimensions are larger than the maximum permitted, the texture’s **LOD Bias** setting is adjusted so that the largest mipmaps of the texture are discarded. This effectively limits the maximum resolution of the texture that can be loaded at runtime.
- If the texture is not in the UI texture group, and its dimensions are not powers of two, the texture’s **Padding and Resizing** setting is set to **Stretch To Power of Two**.
- If the texture is not in the UI texture group, its **Never Stream** setting is disabled.
