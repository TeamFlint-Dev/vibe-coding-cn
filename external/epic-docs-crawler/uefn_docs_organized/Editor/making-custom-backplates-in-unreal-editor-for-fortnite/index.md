# Making Custom Backplates

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/making-custom-backplates-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:17:08.656528

---

Backplates display various types of information, such as a player’s avatar picture, gamer tag, health, shields, and more, on the HUD.

Backplates perform a number of functions, from helping identify teammates in multi-player cooperative games to identifying low health and shield stats.

In **Unreal Editor for Fortnite (UEFN)**, backplates are made using materials or a mixture of textures and materials. Textures are used as containers that add a decorative flourish to the backplate, to add detail that a material can’t.

However, textures can be memory-intensive. This can add a strain on your memory budget and reduce the performance of your island. Textures and **Texture Sample** nodes in your material take up a large amount of memory.

Materials are best used to create flat designs, and can add animated effects to the backplate. Materials are less memory-intensive as they rely on the GPU to execute simple algebra math. This allows you to do a range of things, from creating simple shapes to animating complex interactions in a material.

|  |  |
| --- | --- |
|  |  |
| Flat UI Design with Materials | UI Design with Textures |

When opting to use textures, be sure to use them sparingly — it is recommended that you avoid anything above 256 x 256 px for UI textures.

Materials are less memory-intensive because they use the GPU to render.

The method you use for your avatar backplates will depend on a number of factors:

- Personal preference for the UI design.
- UI style and design that complement the type of island experience you create
- How much memory you want to save

The avatar backplate design in this tutorial uses three **Material Instances** for the basic design. The following backplate designs were created using the **M\_UI\_Shape\_Rectangle** material to include:

- A translucent pink background
- A pink container that surrounds the name text and the translucent background
- An aqua circle that will contain the player’s avatar

  [![A name plate is designed using 3 textures](https://dev.epicgames.com/community/api/documentation/image/82a7df89-55fc-4801-81c9-13c5efe58244?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82a7df89-55fc-4801-81c9-13c5efe58244?resizing_type=fit)

  Create your own UI with materials! See [Creating Custom UI with Material Instances](https://dev.epicgames.com/documentation/en-us/fortnite/creating-custom-ui-with-material-instances-in-unreal-editor-for-fortnite).

## Set Up a Custom Widget

Use the [UI Pop-Ups](https://dev.epicgames.com/documentation/en-us/fortnite/ui-popups-in-unreal-editor-for-fortnite) document’s **User Widget** workflow to:

1. Create a User Widget.
2. Rename the thumbnail to **Player\_Info**.
3. Double click the thumbnail to open the **UMG Widget Editor**.

   [![Create a User Widget named Player_Info, then double click the thumbnail to open the UMG Widget Editor.](https://dev.epicgames.com/community/api/documentation/image/4d9f6c20-b84c-43a1-86c5-823bf41d5b9e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d9f6c20-b84c-43a1-86c5-823bf41d5b9e?resizing_type=fit)

The Widget Editor is where you’ll lay out the appearance and screen placement for your backplate design. Afterward, you’ll add a **Viewmodel** to create binding functionality to capture existing player information and bind it to the backplate design.

In the **Event Graph**:

1. Select the **Fill Screen** setting in the top-right corner and set it to **Desired** instead.

   Through this setting, you can change your widgets to a specified size so that your UI can appear seamless during gameplay.

   To layout the UI design for your custom HUD, you’ll begin by adding panels to the Event Graph.
2. In the **Palette** panel, navigate to the **Panel** section and drag a **Canvas** panel into either the **Event** or directly into the **Hierarchy** panel. Then, rename the panel **HUD\_Canvas**.

   The **Canvas** **Panel** provides a way to anchor different UI elements to specific places on the screen. Make sure to have a UI design plan before adding more panels to the canvas to ensure your design layout is mirrored in the **Canvas Panel**.

   Only use the **Canvas panel** when you need to use specific UI elements as part of your design. For example, use this panel if you’re building a HUD and need to lay out different child widgets to specific places on the screen.

   Instead of changing the **Fill Screen** setting to **Desired,** you can resize the **Canvas Panel** to either **1920 X 1080** or **2560 X 1440**, which are the most common screen aspect ratios (16:9).
3. From the **Palette** panel's **Panel** section, nest a **Stack Box** under **HUD\_Canvas** in the **Hierarchy** panel and rename it **Backplate\_StackBox**. This is the container for the backplate UI, which will nest the widgets that make up your UI variables.

   As you add variables to the **Stack Box**, they’ll automatically stack left to right in the panel.

   You can also use the **Stack Box** to stack your UI elements from top to bottom.
4. From the **Palette** panel's **Common** section, nest an **Image** under **Backplate\_StackBox**, and the **Hierarchy**. Then rename the **Image** to **Avatar\_Image**, which will contain the avatar's border.
5. From the **Palette** panel's **Panel** section, nest an **Overlay** under **Backplate\_StackBox** and rename it to **Nameplate\_Overlay**. The **Overlay** provides a way for you to layer widgets on top of one another.

   [![Nest an Overlay under  Backplate_StackBox and rename to Nameplate_Overlay.](https://dev.epicgames.com/community/api/documentation/image/072e7b75-e636-46e1-8cc0-8297d968b24f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/072e7b75-e636-46e1-8cc0-8297d968b24f?resizing_type=fit)
6. From the **Palette** panel, drag and nest two **Images** under **Nameplate\_Overlay**.

   [![Nest two Images and two Text Blocks under Nameplate_Overlay. Rename the Text Blocks Active and Inactive.](https://dev.epicgames.com/community/api/documentation/image/c01d6fea-1503-45b4-bf32-d382c6bdd243?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c01d6fea-1503-45b4-bf32-d382c6bdd243?resizing_type=fit)

   Rename the images after the materials, **Background** and **Border**.
7. Drag and nest a **Size Box** panel under **Nameplate\_Overlay**.

   Use the **Size Box** to set the properties of its nested children. This stops anything inside the **Size Box** from bleeding out and possibly covering other UI elements or gameplay.

   [![Nest a Size Box panel under Nameplate_Overlay.](https://dev.epicgames.com/community/api/documentation/image/3bb75578-884f-48bc-b5e1-aac7fa675536?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3bb75578-884f-48bc-b5e1-aac7fa675536?resizing_type=fit)
8. Drag and nest an **Overlay** under the **Size Box** and rename it **Text\_Overlay**.

   Without an **Overlay**, you can only child one widget under the **Size Box**.

   [![Nest an Overlay under the Size Box and rename it Text_Overlay.](https://dev.epicgames.com/community/api/documentation/image/e099babe-517a-43ff-adf9-836e3fdcc570?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e099babe-517a-43ff-adf9-836e3fdcc570?resizing_type=fit)
9. From the **Palette** panel's **Common** section, drag and nest two **Text Blocks** under **Text\_Overlay**. Rename the **Text Blocks** to **Active** and **Inactive**.

   [![Nest two Text Blocks under Text_Overlay.](https://dev.epicgames.com/community/api/documentation/image/14712fa0-6d9c-49a3-a164-bb793064dfbd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/14712fa0-6d9c-49a3-a164-bb793064dfbd?resizing_type=fit)

The UI layout is complete. Next, you will set the widget's properties to make the size of the backplate UI elements relative to the screen size.

### Set Widget Properties

A container panel automatically adjusts its size to the largest widget inside it. The parent panel must contain all of its children before you begin editing its properties. Otherwise, the proportions of the parent element could shift as child UI elements are added in the **Hierarchy** tab.

Start setting the properties for the **Backplate\_StackBox** panel to decide the screen placement and the boundaries of the backplate.

The following properties were edited for this backplate's design:

[![The Stack Box moves to the appropriate placement in the Event Graph to be closer to the anchor.](https://dev.epicgames.com/community/api/documentation/image/21b1509c-0c8c-4392-bd8f-d8d346521d10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21b1509c-0c8c-4392-bd8f-d8d346521d10?resizing_type=fit)

*Click image to enlarge.*

| Setting | Value |
| --- | --- |
| **Anchors** | Bottom-Left Corner |
| **Alignment** | Should be set to a pair of coordinates that provide padding for your widget from the edges of the screen. |
| **Size to Content** | True |
| **Orientation** | Horizontal (All the child widgets will display left to right.) |
| **Shear X** | -20.0 (Skews the Stack Box negatively to the right.) |

Hold **Shift + Control** and click the bottom-left corner to automatically update the position and alignment of your widget.

The basic backplate layout pieces are in place. Now you’re ready to add the materials you created and edit the nameplate **Text Blocks**.

## Add and Edit Backplate Assets

The **Widget Editor** has settings for selected widgets to add materials and text as well as modify the asset properties used in the **Brush** setting.

It is important to note the material's arrangement order in the **Hierarchy** panel. When adding your assets, make sure they display properly. Background assets should be layered at the bottom with the additional assets layered on top.

### Edit Material Instances

Select your widgets in the **Hierarchy** panel to begin adding your materials and text.

1. Select **Avatar Image** under the **Stack Box** to highlight the widget and open its properties in the **Details** panel.

   [![Select the first image widget under Nameplate_Overlay.](https://dev.epicgames.com/community/api/documentation/image/453bd4b1-bd57-4df8-815d-edb8a7026f79?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/453bd4b1-bd57-4df8-815d-edb8a7026f79?resizing_type=fit)
2. In the **Details** panel, add the **Avatar Border Material** to the **Brush** setting. Adjust the **Image Size** settings to fit the **Image** widget with the material.

   [![In the Details panel, add the avatar border material to the Brush setting.](https://dev.epicgames.com/community/api/documentation/image/107a1e9a-a70f-4ae2-8356-b84fa813a7c9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/107a1e9a-a70f-4ae2-8356-b84fa813a7c9?resizing_type=fit)

   *Click image to enlarge.*

   Materials are like paint. When added to the **Brush** setting, the material fills the space of the image widget.

   If you have specific avatars for your experience, do the following:

   \* Create an overlay to layer an avatar image under a border material.

   \* Add your imported avatar images to an **Image** background layer.

   \* Use the border material on the top layer.
3. Select the **Background Image** in the **Hierarch**y panel to open the **Overlay** options in the **Details** panel.

   [![Select the Background image in the **Hierarchy** tab.](https://dev.epicgames.com/community/api/documentation/image/163c289d-b430-4343-aa80-f9897a52401b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/163c289d-b430-4343-aa80-f9897a52401b?resizing_type=fit)
4. In the **Details** panel, set the **Horizontal** and **Vertical Alignment** settings to **Center Alignment** and add the **Background Material** to the **Brush** setting. Adjust the **Image Size** settings to fit the **Image** widget with the background material color.

   [![Add the background material to the Brush setting.](https://dev.epicgames.com/community/api/documentation/image/fcfcf495-c99a-4186-a15d-fd43a073453f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fcfcf495-c99a-4186-a15d-fd43a073453f?resizing_type=fit)

   *Click image to enlarge.*
5. Select the **Border Image** under **Nameplate\_Overlay** to highlight the widget and open its properties in the **Details** panel.

   [![Select the second image widget under Nameplate_Overlay.](https://dev.epicgames.com/community/api/documentation/image/a1ec55b9-975d-48ba-9aac-04a1cd656252?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a1ec55b9-975d-48ba-9aac-04a1cd656252?resizing_type=fit)
6. In the **Details** panel, set the **Horizontal** and **Vertical Alignment** to **Center Alignment** and add the **Border Material** to the **Brush** setting. Adjust the **Image Size** settings to make the border go around the background color.

   [![Select Center Alignment for Horizontal and Vertical Alignment.](https://dev.epicgames.com/community/api/documentation/image/c42bba44-b9c1-4a5c-8eab-5037193ffe09?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c42bba44-b9c1-4a5c-8eab-5037193ffe09?resizing_type=fit)

   *Click image to enlarge.*

The backplate takes on a basic look and now you’re ready to edit the **Text Blocks**.

### Edit the Nameplate

The nameplate displays the player's gamer tags. The backplate designed above contains both **Size Box** and **Text Blocks**.

By editing the **Size Box** properties you can prevent the text from extending outside of its boundary into other UI elements or obstructing the player's view.

1. Select the **Size Box** in the **Hierarchy** to open its properties in the **Details** panel.

   [![Select the Size Box in the Hierarchy.](https://dev.epicgames.com/community/api/documentation/image/7d6d1b6e-e533-44f5-92e9-6e967fd4a01d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d6d1b6e-e533-44f5-92e9-6e967fd4a01d?resizing_type=fit)
2. In the **Details** panel, set **Horizontal** and **Vertical Alignment** settings to **Center Alignment**. This automatically centers the **Text Blocks** in the **Nameplate** images. Set the **Size Box's** **Width** and **Height Override** options to **True** and set the Nameplate\_Overlay's desired size.

   The Green box displays the border of the Size Box.

   [![In the Details panel, set the Size Box to Center Alignment for Horizontal and Vertical Alignment and turn on the Width and Height Override options then adjust the Size box to the size you need.](https://dev.epicgames.com/community/api/documentation/image/8c6d79f9-b9cf-4c1c-9b04-f1956239fa88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c6d79f9-b9cf-4c1c-9b04-f1956239fa88?resizing_type=fit)

   *Click image to enlarge.*
3. In the **Hierarchy** panel, right-click on **Size Box** and select **Wrap With…** > **Size Box** for the **Text Blocks** to wrap the player text according to the **Size Box's** properties.

   [![Right-click on Size Box and select Wrap With… to determine the Text Blocks wrapping properties.](https://dev.epicgames.com/community/api/documentation/image/b4fb3a1d-7517-41ca-b9e0-3afec1aa1b29?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b4fb3a1d-7517-41ca-b9e0-3afec1aa1b29?resizing_type=fit)

The basic setup of the nameplate UI is complete. All the child elements take on the properties of their parent so the amount of editing you have to do to those widgets is minimal.

From the **Details** panel, you’ll edit the **Active** and **Inactive Text Blocks** by setting the alignment and font size, color, stroke, and much more.

Make sure the Active text is a separate color from the Inactive text. In this example, the Active Text Block font is a size of 145 in white with a Stroke of 6, and the Inactive font is a size of 145 in SlateGrey with a Stroke of 6.

![Active player name.](https://dev.epicgames.com/community/api/documentation/image/cfc4d4ce-df2c-459f-8652-24f92dd7ba15?resizing_type=fit&width=1920&height=1080)

![Inactive player name.](https://dev.epicgames.com/community/api/documentation/image/2a4698c7-90e1-4b78-ae64-57494f3f8ba2?resizing_type=fit&width=1920&height=1080)

Active player name.

Inactive player name.

Set the Inactive text box’s **Visibility** setting to **Hidden**. This prevents the text from displaying until the binding to the widget is triggered in-game.

[![Set the Inactive text box’s Visibility setting to Hidden.](https://dev.epicgames.com/community/api/documentation/image/2b631322-4fe2-47b9-b2d7-f9238061a4a8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b631322-4fe2-47b9-b2d7-f9238061a4a8?resizing_type=fit)

This pulls all the pieces together, the nameplate and the avatar backplate.

## Add View Bindings

Now that the UI design is built, it’s time to add bindings to the **Text Boxes** and **Avatar\_Image** based on data they need to receive during a live session.

The **HUD Controller Player Info Viewmodel** provides a way to replace parts of your HUD with a custom widget. To take advantage of this setting, you need to create a Viewmodel of your backplate.

### Player Name Text

To get a player name to appear in the correct field, follow these steps:

1. Open the **View Bindings** tab by clicking **Window** > **View Bindings** or by selecting **View Bindings** on the bottom of the screen and docking it.

   [![View bindings tab](https://dev.epicgames.com/community/api/documentation/image/7627c016-7121-42d1-9eea-498419e1144f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7627c016-7121-42d1-9eea-498419e1144f?resizing_type=fit)

   To see the **HUDPlayerInfoViewModelBase** list of view bindings:

   1. Open the **Viewmodels** window by selecting **Window** > **Viewmodels**.

   1. Go to **+Viewmodel** and select **HUD Controller Team/Squad Player Info Viewmodel Base**.

   The **HUD Controller Team/Squad Player Info Lis**t provides a way to show the Controlling Player’s information without their squad or team.

   1. Click **Select**.

   [![View bindings tab](https://dev.epicgames.com/community/api/documentation/image/e0bc9736-ffba-45ac-9929-5c0c3bf7f6a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e0bc9736-ffba-45ac-9929-5c0c3bf7f6a7?resizing_type=fit)
2. Select the **Text Block** from the **Hierarchy** list or by clicking the Player Name area of the UI Preview screen.
3. From the View Bindings tab, click **+ Add Widget Active\_Name**.

   [![Click **+ Add Widget Active_Name** in the View Bindings tab.](https://dev.epicgames.com/community/api/documentation/image/311cc76c-418e-4532-885d-1f8c31bea881?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/311cc76c-418e-4532-885d-1f8c31bea881?resizing_type=fit)
4. Select the Active "PlayerName" field and select **Text** > **Select**.

   [![View bindings tab](https://dev.epicgames.com/community/api/documentation/image/1a1f7b5f-6eec-48f1-a3aa-89a0fcf2be93?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1a1f7b5f-6eec-48f1-a3aa-89a0fcf2be93?resizing_type=fit)
5. In the empty field to the right, select **HUDPlayerInfoViewModel**> **Controlling Player Info** > **Player Name** > **Select** from the dropdown.

   [![View bindings tab](https://dev.epicgames.com/community/api/documentation/image/89c8f8f1-108e-4059-80e7-4ee30b2a05b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/89c8f8f1-108e-4059-80e7-4ee30b2a05b2?resizing_type=fit)
6. The final binding should look like this:

   [![View bindings tab](https://dev.epicgames.com/community/api/documentation/image/80ebcdb9-b527-4cca-ac22-86b59ece6894?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/80ebcdb9-b527-4cca-ac22-86b59ece6894?resizing_type=fit)
7. Repeat steps **2** to **3** for the **Inactive\_Name** element.
8. To modify visibility settings on the inactive name, add a new widget to **Inactive\_Name**. Select in the first field and select **Visibility** > **Select** from the dropdown.

   [![](https://dev.epicgames.com/community/api/documentation/image/796002f8-5fdc-467c-80fe-21c2bbd3e70a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/796002f8-5fdc-467c-80fe-21c2bbd3e70a?resizing_type=fit)
9. Click the empty field to the right, and select **Conversion Functions** > **To Visibility (Boolean)** > **Select**.

   [![Click the empty field to the right, and select Conversion Functions > To Visibility (Boolean) > Select.](https://dev.epicgames.com/community/api/documentation/image/52c666fd-5f63-4c4c-9e0c-76bd4f80063c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/52c666fd-5f63-4c4c-9e0c-76bd4f80063c?resizing_type=fit)
10. Selecting this option causes three new fields to pop up. Click the **Link** icon next to **Is Visible**. From the menu, select **HUDPlayerInfoViewModel** > **Controlling Player Info** > **Is Eliminated** > **Select**.

    [![Click the Link icon next to Is Visible. From the menu, select HUDPlayerInfoViewModel and Is Eliminated > Select.](https://dev.epicgames.com/community/api/documentation/image/15b20e4b-7935-43c4-ae70-3186917ea5cc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/15b20e4b-7935-43c4-ae70-3186917ea5cc?resizing_type=fit)
11. Set **True Visibility** to **Not Hit-Testable (Self Only)** below. Leave **False Visibility** on **Collapsed**. When the player gets eliminated or disconnects, the name will replace the **Active\_Name**, but when the player is alive, it will remain collapsed.
12. The final **Inactive\_Name** binding should look like this:

    [![The final Inactive_Name binding should look like this](https://dev.epicgames.com/community/api/documentation/image/3dfdd6fc-c663-47fe-b7bc-03ecad3ead6f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3dfdd6fc-c663-47fe-b7bc-03ecad3ead6f?resizing_type=fit)

    *Click image to enlarge.*
13. Click **Compile** to submit the changes, and you’re done with the player names!

### Player Avatar Icon

1. Choose **Avatar\_Image** from the **Hierarchy**, or click the player icon area on the UI preview screen.
2. Click **+ Add Widget Profile\_Image**.
3. Go to **Avatar\_Image** > **Brush** and press **Select**. This binding is essentially looking at the selected **Brush** setting from the **Avatar\_Image** **Details** panel.

   [![Add the Avatar Background image to the Avatar Image Brush settings.](https://dev.epicgames.com/community/api/documentation/image/88207489-93ff-485a-9610-9cf42802e8ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88207489-93ff-485a-9610-9cf42802e8ac?resizing_type=fit)
4. Click inside the empty field to the right, and select **Conversion Functions** > **Make Image Brush from Material** > **Select**.

   [![Click inside the empty field to the right, and select Conversion Functions > Set Texture Parameter > Select.](https://dev.epicgames.com/community/api/documentation/image/5270a6ec-228f-457f-9cc4-8c067d9da6a3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5270a6ec-228f-457f-9cc4-8c067d9da6a3?resizing_type=fit)
5. Set the empty **Image Size** fields to the size of your icon border material in the widget. In this example the border material is X=50 and Y=45.
6. The finalized binding should look like this:

   [![The finalized binding should look like this.](https://dev.epicgames.com/community/api/documentation/image/b618abb9-132f-47ba-b9b4-fb4db9660da4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b618abb9-132f-47ba-b9b4-fb4db9660da4?resizing_type=fit)

   *Click image to enlarge.*
7. Click **Compile** to save your widget.

Next, you’ll drag a **HUD Controller** device into your project and add your UMG widget to the device in the Player Info Widget Override field.

Playtest the look of the custom avatar nameplate. It should look something like the following image.

[![The custom UI replaces the default Fortnite UI as you designed.](https://dev.epicgames.com/community/api/documentation/image/9721c413-cdd7-41e3-b55a-192a48d50b6e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9721c413-cdd7-41e3-b55a-192a48d50b6e?resizing_type=fit)

*Click image to enlarge.*

### Next Up

[![Making Custom Health and Shield Bars](https://dev.epicgames.com/community/api/documentation/image/79ff27c4-b164-4df1-9408-373681cb0967?resizing_type=fit&width=640&height=640)

Making Custom Health and Shield Bars

Create custom Health and Shield Bars for your custom HUD.](https://dev.epicgames.com/documentation/en-us/fortnite/making-custom-health-and-shield-bars-in-unreal-editor-for-fortnite)
