# Conversion Functions: Showing Textures from a Viewmodel

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/conversion-functions-showing-textures-from-a-viewmodel
> **爬取时间**: 2025-12-27T02:17:54.991361

---

The **Make Image Brush From Texture** and **Make Image Brush From Material** conversion functions provide a way for you to insert a Texture or Material from a viewmodel into an Image widget directly inside your User Widget.

Unlike the Set Material Parameter conversion functions, these two conversion functions remove the need to have a material with a Texture parameter. These conversion functions insert textures into your UI.

[![The Make Image Brush From Texture and Make Image Brush From Material conversion functions insert textures into your UI.](https://dev.epicgames.com/community/api/documentation/image/d62d06f5-f87d-4480-9ac0-11e6fcf1a7fb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d62d06f5-f87d-4480-9ac0-11e6fcf1a7fb?resizing_type=fit)

This example expands on the Tracker widget from the [To Text tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/conversion-functions-to-text-int-and-to-text-double-in-unreal-editor-for-fortnite) by passing the Icon property from the **Tracker viewmodel** into an **Image widget** using the **Make Image Brush from Texture**.

**Make Image Brush from Material** and **Make Image Brush from Soft Texture/Material** share the same workflow and have identical properties as well. However, this tutorial does not cover how to set them up. Refer to tutorials in **[Making a Custom HUD](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-hud-in-unreal-editor-for-fortnite)** to see how these properties are set up in the widget.

## Widget Setup

The same [User Widget](https://dev.epicgames.com/documentation/en-us/fortnite/ui-popups-in-unreal-editor-for-fortnite) from the [IntToText/Double tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/conversion-functions-to-text-int-and-to-text-double-in-unreal-editor-for-fortnite) is used to create this Tracking widget.

This tutorial has an additional Image widget that passes the Icon from the Tracker device. The existing **Title** and **CurrentValue** fields are wrapped in a **Stack Box** with the Horizontal orientation so the icon displays from left to right alongside the text of the widget.

[![The existing **Title** and **CurrentValue** fields are wrapped in a **Stack Box** with the Horizontal orientation so the icon displays from left to right alongside the text of the widget.](https://dev.epicgames.com/community/api/documentation/image/8b28875b-5b68-4649-9785-6caa7f0c760c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b28875b-5b68-4649-9785-6caa7f0c760c?resizing_type=fit)

1. Add the following widgets to the **Hierarchy** in the same order as laid out in the list below:

   1. **Overlay**
   2. **Image** (Nest the Image widget in the Overlay and rename to Bakcground.)
   3. **Stack Box** (Nest the Stack Box under the Overlay.)
   4. **2 X Image** (Nest under the Stack Box and rename the widgets to Icon and Spacer.)
   5. **Stack Box** (Nest the second Stack box under the first Stack Box.)

   [![Add the following widgets to the event graph: Overlay, Image, Stack Box, two Image, and another Stack Box.](https://dev.epicgames.com/community/api/documentation/image/d51700c1-9d0b-4563-80f4-26ae857c842e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d51700c1-9d0b-4563-80f4-26ae857c842e?resizing_type=fit)
2. Set the **Icon image** widget’s **Horizontal** and **Vertical Alignment** to **Center**. This ensures the icon is always centered.

   [![Set the Icon image widget’s Horizontal and Vertical Alignment to Center.](https://dev.epicgames.com/community/api/documentation/image/cbac950f-ffbd-4c36-8558-31377ebace97?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cbac950f-ffbd-4c36-8558-31377ebace97?resizing_type=fit)

An additional Spacer image widget is used to create space between the Icon and the text below.

## Conversion Function Setup

Open the View Bindings window to bind the icon from the Tracker device to the Icon image widget in your UI.

1. Select the **Icon image** widget in the **Hierarchy**, then click **+Add Widget** in the View Bindings window.

   [![Select the Icon image widget in the Hierarchy, then click +Add Widget in the View Bindings window.](https://dev.epicgames.com/community/api/documentation/image/9a7644e9-9bea-4ea1-ab4f-b7ea727f5a84?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9a7644e9-9bea-4ea1-ab4f-b7ea727f5a84?resizing_type=fit)
2. In the **left field**, select **Icon** > **Brush** > **Select**. This passes a value into the Brush field of the Icon image.

   [![In the left field, select Icon > Brush.](https://dev.epicgames.com/community/api/documentation/image/59216de0-7756-4135-876a-c8ac00580219?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/59216de0-7756-4135-876a-c8ac00580219?resizing_type=fit)

   This Brush field can also be seen in the Details panel for the Icon image widget. Most of the fields in the Details panel are accessible through view bindings.

   [![Most of the fields in the Details panel are accessible through view bindings.](https://dev.epicgames.com/community/api/documentation/image/618684ca-0b4b-405f-9b55-c54b64fb8f2b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/618684ca-0b4b-405f-9b55-c54b64fb8f2b?resizing_type=fit)
3. In the **left field**, select **Conversion Functions** > **Make Image Brush from Texture** > **Select**.

   [![In the left field, select Conversion Functions > Make Image Brush from Texture.](https://dev.epicgames.com/community/api/documentation/image/76752d7b-098b-4c83-b134-d45eab82aff4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/76752d7b-098b-4c83-b134-d45eab82aff4?resizing_type=fit)

A number of fields appear below the binding. Refer to Make Image Brush from Texture/Material Properties to learn more about what each field does.

1. Click the **chain icon** next to **Image**, select **MVVM\_UEFN\_Tracker** > **Icon** > **Select**.

   [![Click the chain icon next to Image, select MVVM_UEFN_Tracker > Icon > Select.](https://dev.epicgames.com/community/api/documentation/image/3d4885a7-e42c-4a86-9e1b-d4d8dd31d05b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3d4885a7-e42c-4a86-9e1b-d4d8dd31d05b?resizing_type=fit)
2. Set the **Image Size** to however large you want the image to be in your Tracker widget.

   The view binding will not inherit the **X** and **Y** sizes from your original Image widget. In this example, Image Size is set to **72x72px** to ensure the icon is legible.

   [![In this example, Image Size is set to 72x72px to ensure the icon is legible.](https://dev.epicgames.com/community/api/documentation/image/d9851f09-e8e3-4b8d-8e7f-d6f85a169158?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d9851f09-e8e3-4b8d-8e7f-d6f85a169158?resizing_type=fit)

## Final Result

Drag a Tracker device into your project and set the following options:

1. In the **Details** panel, set icons in the **Quest Icon fields** for the **Small** and **Large** icons. In this example, the T\_UI\_IconLibrary\_Ham icons were used for the Small and Large icons.

   [![Set icons in the Quest Icon fields for the Small and Large icons.](https://dev.epicgames.com/community/api/documentation/image/4e8aa0fa-7b03-479e-b7be-2ed3c7af4d38?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e8aa0fa-7b03-479e-b7be-2ed3c7af4d38?resizing_type=fit)

The Icon Image widget is filled with the Ham icon set in the Tracker device.

[![The Icon Image widget is filled with the Ham icon set in the Tracker device.](https://dev.epicgames.com/community/api/documentation/image/2d56fbda-27e4-425a-89c5-6950a3e6545b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d56fbda-27e4-425a-89c5-6950a3e6545b?resizing_type=fit)

## Make Image Brush from Texture/Material Properties

Both conversion functions share the same fields unless specified otherwise:

- **Image** (only for *Make Image from Texture*)

  - The Texture variable to pass into the image widget’s Brush.
- **Material** (only for *Make Image from Material*)

  - The Material variable to pass into the image widget’s Brush.
- **Size**

  - The size of the Image or Material that is drawn.
- **Tint Color**

  - The color to tint the Image or Material with.
- **Tile Type** (only for *Make Image from Texture*)

  - Determines whether the Image tiles horizontally, vertically, or both when it’s passed into the image widget’s Brush. If the original Icon size is lesser than the Size specified in the conversion function, the Image will tile.
  - In this example, my icon is 64x64px, while the Size is set at 72x72px, causing it to tile.

  [![Example of tiling an icon texture.](https://dev.epicgames.com/community/api/documentation/image/730c6e85-7c02-4971-91e6-db18e66d0579?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/730c6e85-7c02-4971-91e6-db18e66d0579?resizing_type=fit)

[**Making a Custom HUD**](https://dev.epicgames.com/edc/manage/assets/making-a-custom-hud-in-unreal-editor-for-fortnite)
