# Conversion Function: Setting Material Parameters in UMG

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/conversion-function-setting-material-parameters-in-umg-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:16:56.973573

---

Create dynamic UI with changing materials that update based on gameplay events and data. To make your UI dynamic, you need to use a combination of UI materials, View Bindings, and three of the **Set Material Parameter** conversion functions (Set Texture, Scalar, and Vector Parameter).

In **Unreal Editor for Fortnite** (UEFN) you’re given a basic Material with a number of Parameters. Use the **[Tracker device](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative)** to track eliminations in a progress bar style widget as an example of a material that dynamically updates based on your progression in eliminating enemies.

## Create a Material Instance

For more information about material instances, refer to **[Creating and Using Material Instances](https://dev.epicgames.com/documentation/en-us/fortnite/creating-custom-ui-with-material-instances-in-unreal-editor-for-fortnite)** in Unreal Engine documentation.

All assets used to create these material instances can be found natively in UEFN. To learn how to make the material in this example, refer to **[Meter Material](https://dev.epicgames.com/documentation/en-us/fortnite/meter-material-in-unreal-editor-for-fortnite)** in the [Material tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/ui-materials-in-unreal-editor-for-fortnite) section.

1. Create a **Material Instance** of **M\_Tracker**, name the material instance, **MI\_TrackerExample**.

   [![Create a Material Instance of M_Tracker, name the material instance, MI_TrackerExample.](https://dev.epicgames.com/community/api/documentation/image/b29b41d4-c293-4d00-9f85-8f9dc3581f8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b29b41d4-c293-4d00-9f85-8f9dc3581f8c?resizing_type=fit)
2. In the new **Material Instance**, change the **IconScaleX** and **IconScaleY** based on your preferences. The materials in this example were set to **0.7** each.

   You can customize the elimination ProgressColor that fills the widget based on your progress. Leave TrackerProgress, Icon, and IconColor unchecked. These will be used later with the Tracker device.

   [![You can customize the elimination ProgressColor that fills the widget based on your progress.](https://dev.epicgames.com/community/api/documentation/image/def5875b-0397-4f2b-a32c-4151b9085087?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/def5875b-0397-4f2b-a32c-4151b9085087?resizing_type=fit)

Icons can be found under the **Fortnite** folder in **Textures** > **Icons**.

## Setting Up the Tracker Widget

You'll create a custom Tracker widget in UMG that can be referenced in the Tracker device and track the players eliminations in the custom elimination UI.

1. Right-click in the **Content Browser** and select **User Interface** > **Widget Blueprint** > **User Widget**.

   [![Right-click in the Content Browser and select User Interface > Widget Blueprint > User Widget.](https://dev.epicgames.com/community/api/documentation/image/38137611-ce54-4d5b-9f62-81398e32cc1c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38137611-ce54-4d5b-9f62-81398e32cc1c?resizing_type=fit)
2. Make a simple Tracker widget that shows the Tracker Material and a Tracker title like in the example below.

   [![The Tracker widget shows the Tracker Material and a Tracker title.](https://dev.epicgames.com/community/api/documentation/image/6cb92886-4005-47ff-a59d-598473ae26fa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6cb92886-4005-47ff-a59d-598473ae26fa?resizing_type=fit)
3. Drag an **Overlay** into the widgetgraph. This layers all the pieces that make up the widget. It also provides a way for you to determine where on the screen this widget appears.

   [![](https://dev.epicgames.com/community/api/documentation/image/7871d5cd-3b56-4eb6-861b-6bb579615b90?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7871d5cd-3b56-4eb6-861b-6bb579615b90?resizing_type=fit)
4. Nest a **Stack Box** inside the **Overlay** so you can lay out the **Tracker Material** and Title left-to-right.

   [![Nest a Stack Box inside the Overlay.](https://dev.epicgames.com/community/api/documentation/image/ae5f7dff-dd89-49ce-a528-00bca3cebd77?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ae5f7dff-dd89-49ce-a528-00bca3cebd77?resizing_type=fit)
5. Nest an **Overlay** inside the **Stack Box** so you can create a **Tracker Material** to overlay the Stack Box with a simple dark background.

   [![Nest an Overlay inside the Stack Box.](https://dev.epicgames.com/community/api/documentation/image/f83e673c-4b0e-4816-a91f-eba4c9f93ff5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f83e673c-4b0e-4816-a91f-eba4c9f93ff5?resizing_type=fit)
6. Inside the **Overlay**, nest two **Image** widgets. Press **F2** to rename them **TrackerBackground** and **TrackerMaterial**.

   [![Inside the Overlay, add two Image widgets.](https://dev.epicgames.com/community/api/documentation/image/042eb5b5-9f2a-45bf-9df0-badc6d26fcba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/042eb5b5-9f2a-45bf-9df0-badc6d26fcba?resizing_type=fit)
7. Select **TrackMaterial** to open its options in the **Details** panel. From the **Details** panel, select **Brush** > **Image** and look for the **MI\_TrackerExample** material you created.

   [![Select TrackMaterial to open its options in the Details panel. From the Details panel, select Brush > Image and look for MI_TrackerExample you created.](https://dev.epicgames.com/community/api/documentation/image/b2c8e1e5-fc6e-4e44-a7cc-a2fc8fda2eb2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b2c8e1e5-fc6e-4e44-a7cc-a2fc8fda2eb2?resizing_type=fit)
8. Set the **Image Size** below to **X=96.0**, **Y=96.0**. It should be large enough to be seen in-game.

   [![Set the Image Size below to X=96.0, Y=96.0. It should be large enough to be seen in-game.](https://dev.epicgames.com/community/api/documentation/image/099a5f5d-f35d-4daf-9a67-a36c6c12d5f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/099a5f5d-f35d-4daf-9a67-a36c6c12d5f3?resizing_type=fit)

   Now that the Tracker material is set up, you need to create the background for the material so the Track material is more readable.
9. Select **TrackerBacking**, and in the **Hierarchy**, then from the **Details** panel select **Brush** > **Draw As** > **Rounded Box**.

   [![Select TrackerBacking, and in the Hierarchy, then from the Details panel select Brush > Draw As > Rounded Box.](https://dev.epicgames.com/community/api/documentation/image/cb10b770-3568-44d9-a15f-6d80a82deee5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cb10b770-3568-44d9-a15f-6d80a82deee5?resizing_type=fit)
10. Set the **Tint** option above to a neutral color for better readability. In this example, the tint was set to **3A3A3AFF** in the **Hex sRGB** field.

    [![Select a color for the Tinit option.](https://dev.epicgames.com/community/api/documentation/image/c2e9d692-8128-4500-bbad-c286ab0d1c9f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c2e9d692-8128-4500-bbad-c286ab0d1c9f?resizing_type=fit)
11. Set the **Horizontal Alignment** and **Vertical Alignment** options to **Fill**. This ensures TrackerBacking fills the container that holds the TrackerMaterial.

    [![Set the Horizontal Alignment and Vertical Alignment options to Fill.](https://dev.epicgames.com/community/api/documentation/image/cac8c4e3-fdfb-4c64-884c-baa24c777fd7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cac8c4e3-fdfb-4c64-884c-baa24c777fd7?resizing_type=fit)

Now you have a background for your **TrackerMaterial** that looks easily readable on any in-game scene!

[![The background for the Trackermaterial is set up.](https://dev.epicgames.com/community/api/documentation/image/bf3736a9-486b-49ab-a610-fa89b4ddbf33?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bf3736a9-486b-49ab-a610-fa89b4ddbf33?resizing_type=fit)

## Setting Up the Tracker Text

After the Tracker material is referenced in the Tracker widget, you'll set up text that informs the player what is being tracked in the UI.

1. Nest a **Text Block** to the **Stack Box** that holds the Overlay. Rename the Text Block to **TrackerTitle**.

   [![Nest a Text Block to the Stack Box that holds the Overlay. Rename the Text Block to TrackerTitle.](https://dev.epicgames.com/community/api/documentation/image/3cbdd3e4-7f42-45ee-b59f-c96b9fcc53f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3cbdd3e4-7f42-45ee-b59f-c96b9fcc53f2?resizing_type=fit)
2. Select **TrackerTitle** in the **Hierarchy**, from the **Details** panel set the **Vertical Alignment** to **Center Align Vertically**. This ensures that the text is always center aligned to the TrackerMaterial.

   [![Select TrackerTitle in the Hierarchy, from the Details panel set the Vertical Alignment to Center Align Vertically.](https://dev.epicgames.com/community/api/documentation/image/ae7372a4-2f0c-4531-a01b-2060c06c5e43?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ae7372a4-2f0c-4531-a01b-2060c06c5e43?resizing_type=fit)
3. Make some stylistic changes to the font by reducing the size, adding an outline, or changing the typeface to make it fit your theme.

   In this example, the following changes were made:
   **Font Size** = 24
   **Typeface** = Bold
   **Outline** = Dark Red

   You can customize all the settings related to the Font under the Appearance category.

   [![](https://dev.epicgames.com/community/api/documentation/image/6b6c777c-f252-43ff-93d6-4fe70a6b91c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b6c777c-f252-43ff-93d6-4fe70a6b91c4?resizing_type=fit)

Once all the final design touches are complete, you should have the **TrackerMaterial** and **TrackerTitle** set up.

[![Tracker Text is set.](https://dev.epicgames.com/community/api/documentation/image/20f5765b-212b-44ab-abee-53e1564e3fb1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/20f5765b-212b-44ab-abee-53e1564e3fb1?resizing_type=fit)

To add some space between both items, add padding on the Right to the Overlay containing the TrackerMaterial:

1. Select the **Overlay**.
2. From the **Details** panel, expand **Padding**.
3. Change **Right Padding** to **16px**.

Space is added between the image and the text.

[![Add some space between both items with padding.](https://dev.epicgames.com/community/api/documentation/image/8df372de-b9d3-4332-aeaa-6ddc4edf997a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8df372de-b9d3-4332-aeaa-6ddc4edf997a?resizing_type=fit)

If you want to easily modify spacing between multiple objects, you can insert an Image widget into the Stack Box that holds these objects, set the Image Size X to however much space you want, and set it to Draw As None. What happens is the Image doesn’t show up but it still takes up space in your Stack Box!

It makes it easier to manage spacing between objects and not hunt down Paddings in each widget.

[![](https://dev.epicgames.com/community/api/documentation/image/76977bb6-0c28-4d5b-be0e-02b4bb9c3054?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/76977bb6-0c28-4d5b-be0e-02b4bb9c3054?resizing_type=fit)

## Setting up Set Material Parameters

Next you'll bind the values of the Tracker device to the material parameters in the Tracker widget.

### Adding a Viewmodel

1. Add the **Tracker** viewmodel to the widget by selecting **Window** > **Viewmodel** from the main menu.

   [![Add the Tracker viewmodel to the widget by selecting Window > Viewmodel.](https://dev.epicgames.com/community/api/documentation/image/22340336-32b8-4f49-8835-b0b688839f00?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/22340336-32b8-4f49-8835-b0b688839f00?resizing_type=fit)
2. In your Viewmodel window, select **+Viewmodel**.

   [![In your Viewmodel window, select +Viewmodel.](https://dev.epicgames.com/community/api/documentation/image/a2fa7974-c4ef-4399-8886-b2418530611e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2fa7974-c4ef-4399-8886-b2418530611e?resizing_type=fit)
3. In the popup window, select **Device - Tracker View Model**.
4. From the menu bar, select **Window** > **View Bindings** to open the **View Bindings** panel.

   [![From the menu bar, select Window > View Bindings to open the View Bindings panel.](https://dev.epicgames.com/community/api/documentation/image/713a4589-b22b-44db-94b6-95e458f31add?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/713a4589-b22b-44db-94b6-95e458f31add?resizing_type=fit)

You’re ready to start binding the data from the Tracker to manipulate your widget.

### Set Scalar Parameter

A **Scalar Parameter** takes in an **Int** or **Float** value. For example, the progress bar fills with the TrackerMaterial based on how many eliminations you have in the Tracker.

The Material is set up to convert the number of Eliminations from the Tracker device to fill up the TrackerMaterial. All you have to do is bind that data to the Progress material parameter in MI\_TrackerExample.

![Early eliminations in the tracker](https://dev.epicgames.com/community/api/documentation/image/5d6b5f26-b121-4c96-86e6-0cec955e93e3?resizing_type=fit&width=1920&height=1080)

![Almost full elimination tracker](https://dev.epicgames.com/community/api/documentation/image/ac89ef9d-cc84-49f8-84f2-eaf68ee5f5b4?resizing_type=fit&width=1920&height=1080)

Early eliminations in the tracker

Almost full elimination tracker

A Progress of 3.0 vs 8.0 in MI\_TrackerExample. This is very handy!

1. Select the **TrackerMaterial** widget, then click on **+Add Widget** from the **View Bindings** window.

   [![](https://dev.epicgames.com/community/api/documentation/image/f2efb199-cef7-4588-a28c-210e89227227?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2efb199-cef7-4588-a28c-210e89227227?resizing_type=fit)
2. In the left field select **TrackerMaterial** > **Brush**.

   [![](https://dev.epicgames.com/community/api/documentation/image/4435d456-b9e9-47bc-8575-ab1dcadce1ce?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4435d456-b9e9-47bc-8575-ab1dcadce1ce?resizing_type=fit)
3. In the right field (containing the data you want to bind to the TrackerMaterial’s Brush), select **Conversion Functions** > **Set Scalar Parameter**.

   [![](https://dev.epicgames.com/community/api/documentation/image/e8c5c14a-0c23-4717-927a-cbe32bf0756f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8c5c14a-0c23-4717-927a-cbe32bf0756f?resizing_type=fit)

   This runs the function called **Set Scalar Parameter** on the **Brush** setting. Since your Brush currently has MI\_TrackerExample, it will look for a Scalar Parameter that you specify and pass a value into it.

   [![](https://dev.epicgames.com/community/api/documentation/image/5855ee28-d9ea-4c41-8029-70c994013a25?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5855ee28-d9ea-4c41-8029-70c994013a25?resizing_type=fit)
4. Type **TrackerProgress** into the **Parameter Name** field, this causes the material to fill based on the Tracker’s progress.

   [![](https://dev.epicgames.com/community/api/documentation/image/8b31968b-4ae4-4bf5-bfce-1e876d009fa2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b31968b-4ae4-4bf5-bfce-1e876d009fa2?resizing_type=fit)

   It’s important that you don’t make errors in the parameter because it won’t be able to find the right parameter on your material. If you forgot what your parameter is called, open the Material Instance and look for parameters on the right.
5. Select the **link icon** next to **Value**, select **MVVM\_UEFN\_Tracker** > **Value** from the dropdown menu. This binds the Tracker’s current progress.

   [![](https://dev.epicgames.com/community/api/documentation/image/ad27d147-8327-40f9-bfb9-8f2c2bcd8971?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad27d147-8327-40f9-bfb9-8f2c2bcd8971?resizing_type=fit)

You now have your current Tracker progress feeding directly into your material! The Tracker Material will slowly fill up when the player assigned to the Tracker gets an elimination!

[![](https://dev.epicgames.com/community/api/documentation/image/34cd07cd-c747-4097-a446-1ad7a9ebe9c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/34cd07cd-c747-4097-a446-1ad7a9ebe9c3?resizing_type=fit)

### Set Vector Parameter

A Vector Parameter takes in a Vector4 value. Vectors are typically used for colors - RGBA (the four vectors), you’re going to use a Vector4 to change your icon color based on what is set up in the device.

For more information about Vectors, refer to **[Vector Material Expressions](https://dev.epicgames.com/documentation/en-us/unreal-engine/vector-material-expressions-in-unreal-engine?application_version=5.5)** in Unreal Engine documentation.

1. Select the **TrackerMaterial** in the **Hierarchy**, then open the **View Bindings** window and select **+Add Widget**.

   [![Select the TrackerMaterial in the Hierarchy, then open the View Bindings window and select +Add Widget.](https://dev.epicgames.com/community/api/documentation/image/f1f10fcf-9efd-42dd-b26a-d2fb8294dfc1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f1f10fcf-9efd-42dd-b26a-d2fb8294dfc1?resizing_type=fit)
2. Select the **TrackerMaterial** > **Brush** properties in the empty field on the left.

   [![Select the TrackerMaterial > Brush properties in the empty field on the left.](https://dev.epicgames.com/community/api/documentation/image/5c7bfc4e-f498-4860-b43c-f8f2be182542?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c7bfc4e-f498-4860-b43c-f8f2be182542?resizing_type=fit)
3. Select **Conversion Functions** > **Set Vector Parameter** in the empty field on the right.

   [![Select Conversion Functions > Set Vector Parameter in the empty field on the right.](https://dev.epicgames.com/community/api/documentation/image/6c0d4f82-cbfb-4951-8d43-6124803da95d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c0d4f82-cbfb-4951-8d43-6124803da95d?resizing_type=fit)

   As explainned above, this binding gets the **Brush** from the TrackerMaterial (in this case, it’s MI\_TrackerExample), and sets a **Vector Parameter** that you specify on that material instance. You can set the icon color to follow whatever options the Tracker device has set.
4. Type **IconColor** in the **Parameter Name** field.

   [![Type IconColor in the Parameter Name field.](https://dev.epicgames.com/community/api/documentation/image/36e7173c-e9c2-445d-b8dd-f0d744b90ca0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36e7173c-e9c2-445d-b8dd-f0d744b90ca0?resizing_type=fit)
5. Select the **link icon** next to **Value**, then select **MVVM\_UEFN\_Tracker** > **Color**. This sets the Value to the Icon Color property from the Tracker Viewmodel.

   [![Select the Link icon next to Value, then select MVVM_UEFN_Tracker > Color.](https://dev.epicgames.com/community/api/documentation/image/5fa6b579-1d5b-4940-9e68-0a614339fb58?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5fa6b579-1d5b-4940-9e68-0a614339fb58?resizing_type=fit)

Whatever Icon Color that’s set on the Tracker device is passed to your material. If you want an orange icon, just set it on the device and it will color it for you! The material used in this example is already set up for that.

[![Whatever Icon Color that’s set on the Tracker device is passed to your material.](https://dev.epicgames.com/community/api/documentation/image/d6715fb1-9fbd-48db-92a4-99a6cf48eda0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d6715fb1-9fbd-48db-92a4-99a6cf48eda0?resizing_type=fit)

### Set Texture Parameter

A Texture Parameter takes in a Texture2D value. Textures are typically used for images or icons, so we’re going to use it to change our icon based on what’s set up in the device!

For more information about Textures, refer to **[Textures](https://dev.epicgames.com/documentation/en-us/unreal-engine/textures-in-unreal-engine?application_version=5.5)** in Unreal Engine documentation.

1. Select the **TrackerMaterial** in the **Hierarchy**, then in the **View Bindings** window select **+Add Widget**.
2. In the empty field on the left, select **MVVM\_UEFN\_Tracker** > **Brush**.
3. In the empty field on the right, select **Conversion Functions** > **Set Texture Parameter**.

   [![](https://dev.epicgames.com/community/api/documentation/image/8603136f-20e8-42b1-b786-267e4e6cf086?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8603136f-20e8-42b1-b786-267e4e6cf086?resizing_type=fit)
4. Type **Icon** in the **Parameter Name** field.

   Avoid errors when typing the name of the parameter! If you forget the parameter’s name you can look at the **MI\_TrackerExample** for the list of parameters available to be set.

   [![](https://dev.epicgames.com/community/api/documentation/image/8890dd6c-069a-45cb-b50e-f1668f2f0864?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8890dd6c-069a-45cb-b50e-f1668f2f0864?resizing_type=fit)
5. Select the **link icon** next to the **Value** field and select **MVVM\_UEFN\_Tracker** > **Icon** from the dropdown menu. This ties the value to the Icon property from the Tracker Viewmodel.

   [![](https://dev.epicgames.com/community/api/documentation/image/787ecfd9-f5c9-4a10-89de-9b641b40fa2f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/787ecfd9-f5c9-4a10-89de-9b641b40fa2f?resizing_type=fit)

The Texture Parameter is set. Now whatever icon is set in your Tracker device will pass it into the widget!

[![Whatever Icon Color that’s set on the Tracker device is passed to your material.](https://dev.epicgames.com/community/api/documentation/image/ca71b659-aff9-41e9-89b5-29046b90012e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ca71b659-aff9-41e9-89b5-29046b90012e?resizing_type=fit)

## Bind Tracker Text to Tracker Name

Next you'll bind the Tracker title you created to the same setting in the Tracker device.

1. Select **TrackerTitle** in the **Hierarchy**, then open the **View Bindings** window, and select **+Add Widget**.

   [![Select TrackerTitle in the Hierarchy, then , open the View Bindings window, and select +Add Widget.](https://dev.epicgames.com/community/api/documentation/image/dcd4aa0b-6f01-4f5b-b811-9b24d1123925?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dcd4aa0b-6f01-4f5b-b811-9b24d1123925?resizing_type=fit)
2. In the empty field on the left select **TrackerTitle** > **Text** from the dropdown menu.

   [![Select TrackerTitle > Text from the dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/812b1231-2c4e-4476-97b8-fcf5b355d8e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/812b1231-2c4e-4476-97b8-fcf5b355d8e9?resizing_type=fit)
3. In the empty field on the right select**MVVM\_UEFN\_Tracker** > **Name** from the dropdown menu.

   [![In the empty field on the  right select MVVM_UEFN_Tracker > Name.](https://dev.epicgames.com/community/api/documentation/image/77bd1f2f-186b-452c-a1a1-83a007f3652e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/77bd1f2f-186b-452c-a1a1-83a007f3652e?resizing_type=fit)

This binding passes the title of your Tracker to the Text Block.

[![This binding passes the title of your Tracker to the Text Block.](https://dev.epicgames.com/community/api/documentation/image/0af778e6-5b18-4c13-8c14-06a7e51dd15f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0af778e6-5b18-4c13-8c14-06a7e51dd15f?resizing_type=fit)

## Setting Up the Tracker Device

Next, you'll reference the widget you created in UMG in the Tracker device. This causes the elimination UI to display in the HUD.

1. Add a **[Tracker device](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative)** to your project.
2. Give the **Tracker Title** a name. This name displays in the TrackerTitle text in your widget.

   [![Give the Tracker Title a name.](https://dev.epicgames.com/community/api/documentation/image/c1714dfd-ae2a-469c-9f96-c956e65e221e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c1714dfd-ae2a-469c-9f96-c956e65e221e?resizing_type=fit)
3. Add your widget to the **HUD Widget** field.

   [![Add your widget to the HUD Widget field.](https://dev.epicgames.com/community/api/documentation/image/ca8055cc-3fc6-4607-9901-a76e7538740c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ca8055cc-3fc6-4607-9901-a76e7538740c?resizing_type=fit)
4. Change the **Quest Icon** fields to any icon you want to display on your Tracker. This overrides the default Alien icon on the MI\_TrackerExample.

   [![Change the Quest Icon fields to any icon you want to display on your Tracker.](https://dev.epicgames.com/community/api/documentation/image/a1ee1993-48d6-4cca-8ae1-696f936162af?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a1ee1993-48d6-4cca-8ae1-696f936162af?resizing_type=fit)
5. Select a **color** in **Icon Color**. The icon you set above takes on the selected color.

   [![Select a color in Icon Color.](https://dev.epicgames.com/community/api/documentation/image/627b2c2f-f6e1-4c87-afdc-03fa40a4ed9d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/627b2c2f-f6e1-4c87-afdc-03fa40a4ed9d?resizing_type=fit)
6. Continue to set up the other settings to add the Tracker to your player.

## Final Result

Voila! You have the custom Tracker widget appearing on the top left. Whether you eliminate zombies or other players, the widget slowly fills up! That’s how you link gameplay data to your own custom widgets using Set Material Parameters.

[![](https://dev.epicgames.com/community/api/documentation/image/690d858d-a483-4828-85bd-d6829aee4c76?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/690d858d-a483-4828-85bd-d6829aee4c76?resizing_type=fit)

[![](https://dev.epicgames.com/community/api/documentation/image/421a7e4a-d4c5-4b06-b082-52ab734c2a26?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/421a7e4a-d4c5-4b06-b082-52ab734c2a26?resizing_type=fit)
