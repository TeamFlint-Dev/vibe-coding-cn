# TMNT Custom UI: Player Info

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-custom-ui-player-info-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:08:48.196632

---

In this section, you will learn how to create fully customized UI overlays for your games by following the steps to recreate the TMNT Arcade Template player UI.

[![TMNT Player UI](https://dev.epicgames.com/community/api/documentation/image/d1222496-b9a8-4dc8-95b8-5a81ebf38f23?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d1222496-b9a8-4dc8-95b8-5a81ebf38f23?resizing_type=fit)

The basic breakdown of the steps is:

1. [Set up the look of your custom widgets.](https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-custom-ui-player-info-in-unreal-editor-for-fortnite)
2. [Add view bindings to each interactive widget element.](https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-custom-ui-player-info-in-unreal-editor-for-fortnite)
3. [Create a player info stack for multiple concurrent players.](https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-custom-ui-player-info-in-unreal-editor-for-fortnite)
4. [Set up the HUD Controller device to display the custom UI.](https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-custom-ui-player-info-in-unreal-editor-for-fortnite)

Download the [UI Material Lab](https://www.unrealengine.com/marketplace/product/ui-material-lab) texture pack for free and experiment with your own UI configurations!

[![UI Material Lab](https://dev.epicgames.com/community/api/documentation/image/a68643c8-86a4-448d-bbb8-4c70c470b3cc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a68643c8-86a4-448d-bbb8-4c70c470b3cc?resizing_type=fit)

UI Material Lab

*Click image to expand.*

Let’s dive right in!

## Set Up Custom Widgets

In your Content Browser, go to **All** > **[Your Project NAME]** > **UI** > **Widgets** and open the **UW\_HUD\_PlayerInfoBlock**widget Blueprint.

[![TMNT Player UI](https://dev.epicgames.com/community/api/documentation/image/2abee9b6-cd73-4e62-80d6-22449700a5bf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2abee9b6-cd73-4e62-80d6-22449700a5bf?resizing_type=fit)

On the left side, you will see the **Hierarchy** tab, which works just like the Outliner from the main editor window and displays the various components of the finished widget.

[![Hierarchy Tab](https://dev.epicgames.com/community/api/documentation/image/a5cab60a-f00c-4a54-bd31-971c5d637abe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a5cab60a-f00c-4a54-bd31-971c5d637abe?resizing_type=fit)

### Backplate

The top section is made up of three backplate images that define the layered look of the UI. These include:

- **Backplate1\_Image** - the gray-tinted background layer
- **Backplate2\_Image** - the orange outline layer
- **Backplate3\_Image** - the white outline layer

Together, these images create the framed style of the player information panel.

When importing images to use for your UI, make sure to choose **Texture Group** to **UI** and **Compression Settings** to **UserInterface2D(RGBA8)**.

[![Texture and compression settings](https://dev.epicgames.com/community/api/documentation/image/3f1e604a-c14d-4cfb-9e11-72c70d63d0f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f1e604a-c14d-4cfb-9e11-72c70d63d0f3?resizing_type=fit)

### Player Name

This component is made up of two elements, an **Active Player name**, and an **Inactive Player name**, which will show up when the player is alive, eliminated or disconnected in game.

[![Active Player Name UI](https://dev.epicgames.com/community/api/documentation/image/db910c92-bce0-494b-b097-d81bd633e58b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/db910c92-bce0-494b-b097-d81bd633e58b?resizing_type=fit)

[![Inactive Player Name UI](https://dev.epicgames.com/community/api/documentation/image/0197676a-92b1-4930-bc82-a961271f954a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0197676a-92b1-4930-bc82-a961271f954a?resizing_type=fit)

Pick two distinct colors that will inform the players who on their team is currently active and who is eliminated.

For the Active player name, set the **Visibility** to **Visible**, and for Inactive, set it to **Hidden**. This will be shown only under certain conditions.

Set the **Width Override** to **220.0** so that longer player names do not overlap with the player avatar icon.

### Player Avatar Icon

This component shows the player’s character portrait based on their chosen skin in game.

The component is bound to a material instance called **MI\_UI\_PlayerCard**, found under the **UI** > **Material Instances** folder.

You can customize this material instance to your liking by changing the settings in the Details panel. Try importing your own image and adding some outline colors!

[![Avatar Material Instance Settings](https://dev.epicgames.com/community/api/documentation/image/bdeedf3d-57f0-451a-8925-6efd08f08e6b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bdeedf3d-57f0-451a-8925-6efd08f08e6b?resizing_type=fit)

In this example, the chosen image is an empty transparent image that will be connected later to the character skin.

### Health

This component contains the regions that will display the player’s health and shield levels.

[![Health Component](https://dev.epicgames.com/community/api/documentation/image/8f94c377-45e9-40a6-9476-7e1b93b73123?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f94c377-45e9-40a6-9476-7e1b93b73123?resizing_type=fit)

On the parent level, you can see the size box that determines how large the overall region is allowed to be.

Next is the health backplate image, called **MI\_UI\_Health\_Backplate**. This UI material is also provided under **Fortnite** > **UI** > **Materials**. It is very customizable and can provide lots of options for showing the player’s health bar right out of the box.

On top of the backplate is a stack box made up of two components: a health bar and a shadow called **Health\_Image** and **Health\_Shadow**, respectively.

[![Health Shadow](https://dev.epicgames.com/community/api/documentation/image/dc3adf99-bcd6-44bc-adb0-14cfd867571d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dc3adf99-bcd6-44bc-adb0-14cfd867571d?resizing_type=fit)

The **Health\_Image** is a customizable progress bar UI material. If you open up the material instance, you can zoom in by changing the **Preview Size**.

[![Preview size](https://dev.epicgames.com/community/api/documentation/image/1d8c925e-886f-4014-8f16-db94b4eddea7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d8c925e-886f-4014-8f16-db94b4eddea7?resizing_type=fit)

Try changing some of the settings in the Details panel to see how they affect the existing material.

Since scalar parameter values (the progress bar fill state) range from **0** to **1**, and Fortnite’s health and shield values typically range from **0** to **100**, it is important to set the **Multiplier** to **0.01** so that health and shield values are correctly displayed to players.

[![Scalar Parameter Values](https://dev.epicgames.com/community/api/documentation/image/0ef019c3-7bf0-45ec-83f9-91ebb54f8597?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0ef019c3-7bf0-45ec-83f9-91ebb54f8597?resizing_type=fit)

The **Health\_Shadow** bar is a simple shaded overlay added for aesthetic purposes.

### Shield

The shield component is made up of a **Shields\_Container** background that shows the empty shield area in dark gray, and a **Shields\_Image** that contains the progress bar UI material.

[![Shield Bar](https://dev.epicgames.com/community/api/documentation/image/722efc7a-4c41-4188-ad0b-597d250c464f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/722efc7a-4c41-4188-ad0b-597d250c464f?resizing_type=fit)

The **Shield\_Image** uses a basic progress bar material instance, which is a simplified version of the **Health\_Image** material.

## Add View Bindings

Now that you’ve built up the core components of the UI for your game, let’s practice adding view bindings that will allow each of the components to update based on data they receive from a live session.

### Player Name

To get a player name to appear in the correct field, follow these steps:

1. Open the **View Bindings** tab by clicking **Window** > **View Bindings** or by selecting **View Bindings** on the bottom of the screen and docking it.

   [![View bindings tab](https://dev.epicgames.com/community/api/documentation/image/c2016ac3-4efb-4f53-8b8f-3d77cd8399de?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c2016ac3-4efb-4f53-8b8f-3d77cd8399de?resizing_type=fit)

   To see the **HUDPlayerInfoViewModel** list of view bindings:

   1. Open the Viewmodels window by selecting **Window** > **Viewmodels**.

   1. Go to **+Viewmodel** and select **HUD - Player Info Viewmodel Base**.

   1. Click on **Device - HUD Controller Player Info Viewmodel** and click **Select**.

   [![HUD Player Info Viewmodel](https://dev.epicgames.com/community/api/documentation/image/5d928a85-ea7b-4572-b437-60390c36cdcb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5d928a85-ea7b-4572-b437-60390c36cdcb?resizing_type=fit)
2. Select **NameActive\_Text** from the **Hierarchy** list or by clicking the Playername area of the UI Preview screen.
3. Click **+ Add Widget NameActive\_Text** and select **Text** from the dropdown menu.

   [![Text Widget](https://dev.epicgames.com/community/api/documentation/image/183428fb-0d06-4766-a8fb-40888ad8ca38?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/183428fb-0d06-4766-a8fb-40888ad8ca38?resizing_type=fit)
4. In the empty field to the right, select **HUDPlayerInfoViewmodel** and **Player Name** from the ensuing dropdown.

   [![Get Player Name](https://dev.epicgames.com/community/api/documentation/image/4c00be75-b908-4a13-90cf-cf98567386ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c00be75-b908-4a13-90cf-cf98567386ae?resizing_type=fit)
5. The final binding should look like this:

   [![View bindings Name](https://dev.epicgames.com/community/api/documentation/image/f743bd75-571b-4506-be99-1cc7a259566f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f743bd75-571b-4506-be99-1cc7a259566f?resizing_type=fit)
6. Repeat steps **1** to **3** for the **NameInactive\_Text** element.
7. To modify visibility settings on the inactive name, add a new widget to **NameInactive\_Text** and select **Visibility** from the dropdown.
8. Click the empty field to the right, and select **Conversion Functions** > **To Visibility (Boolean)**.

   [![Visibility Conversion Function](https://dev.epicgames.com/community/api/documentation/image/cbef3617-39f2-454c-b24c-3a80efe06f64?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cbef3617-39f2-454c-b24c-3a80efe06f64?resizing_type=fit)
9. Selecting this option causes three new fields to pop up. Click the **Link** icon next to **Is Visible**. From the menu, select **HUDPlayerInfoViewModel** and **Is Eliminated**.

   [![Is Eliminated](https://dev.epicgames.com/community/api/documentation/image/0d52ab36-f184-4652-a29c-68590ad72f02?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0d52ab36-f184-4652-a29c-68590ad72f02?resizing_type=fit)
10. Set **True Visibility** to **Not Hit-Testable (Self Only)** below. Leave **False Visibility** on **Collapsed**. When the player gets eliminated or disconnects, the name will replace the **NameActive\_Text**, but when the player is alive, it will remain collapsed.
11. The final **NameInactive\_Text** binding should look like this:

    [![Name Inactive Text Binding](https://dev.epicgames.com/community/api/documentation/image/b9018fb2-8834-485b-b344-58fc7b5b6aad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9018fb2-8834-485b-b344-58fc7b5b6aad?resizing_type=fit)
12. Press **Compile** to submit the changes, and you’re done with the player names!

### Player Avatar Icon

1. Choose **Profile\_Image** from the **Hierarchy**, or click the player icon area on the UI preview screen.
2. Click **+ Add Widget Profile\_Image**.
3. Go to **Profile\_Image** > **Brush** and press **Select**. This binding is essentially looking at the selected Brush setting from the **Profile\_Image** details panel.

   [![Profile Image](https://dev.epicgames.com/community/api/documentation/image/ca62afb6-32f1-4662-a827-563541383044?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ca62afb6-32f1-4662-a827-563541383044?resizing_type=fit)
4. Click inside the empty field to the right, and select **Conversion Functions** > **Set Texture Parameter**.

   [![Set Texture Parameter](https://dev.epicgames.com/community/api/documentation/image/f1dc50c0-cef7-4ad4-b7f4-3ac113c63df2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f1dc50c0-cef7-4ad4-b7f4-3ac113c63df2?resizing_type=fit)
5. Type **Texture** in the **Parameter Name** field. To find the name of this field, open the player avatar material instance.

   For **Set Vector/Scalar/Texture Parameter** functions, make sure the material instance parameter names are an exact match to the Parameter Name field.
6. Click on the Link icon next to the **Value** field and select **HUDPlayerInfoViewModel** > **Player Avatar Icon**.
7. The finalized binding should look like this:

   [![Profile Image binding](https://dev.epicgames.com/community/api/documentation/image/40b0ead8-05ec-4097-a412-c2cd8adb02e1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40b0ead8-05ec-4097-a412-c2cd8adb02e1?resizing_type=fit)

### Health and Shield

1. Choose **Health\_Image** from the **Hierarchy**, or click the health bar area on the UI preview screen.
2. Click **+ Add Widget Health\_Image**.
3. Go to **Profile\_Image** > **Brush** and press **Select**.
4. Click inside the empty field to the right, and select **Conversion Functions** > **Set Scalar Parameter**.
5. Type **Progress** in the **Parameter Name** field. To find the name of this field, open the player avatar material instance.
6. Click the **Link** icon next to **Value** and select **HUDPlayerInfoViewModel** > **Health**.

   1. The progress gives a percentage of the player’s remaining health, and since the **Multiplier** has been set to 0.1, every percentage point will move the progress bar by 1/100th. You can test this by arbitrarily changing the percentage value in the Material Instance to see the progress bar moving.

      [![Health Percentage](https://dev.epicgames.com/community/api/documentation/image/19a7cab0-6b71-4b1f-b772-4056f3dc1e11?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19a7cab0-6b71-4b1f-b772-4056f3dc1e11?resizing_type=fit)

      Health Percentage

      *Click image to expand.*
7. The finalized binding should look like this:

   [![health binding](https://dev.epicgames.com/community/api/documentation/image/ec00b05c-ad0f-48f2-a8d1-b5a571646292?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ec00b05c-ad0f-48f2-a8d1-b5a571646292?resizing_type=fit)
8. For the shield bar, Repeat steps 1 to 6, but choose **Shield** instead of **Health**.
9. The finalized binding for Shield should look like this:

   [![shield binding](https://dev.epicgames.com/community/api/documentation/image/fee949c9-07c8-4a5c-8326-1455341dc4fe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fee949c9-07c8-4a5c-8326-1455341dc4fe?resizing_type=fit)
10. Press **Compile** to submit the changes.

### Full Widget

This binding ensures that the entire widget displays only after a player is connected to the game.

1. Choose **PlayerInfoBlock\_Overlay** from the **Hierarchy**.
2. Select **+ Add Widget PlayerInfoBlock\_Overlay**, then choose Visibility from the dropdown menu.
3. Click the empty field to the right, and select **Conversion Functions** > **To Visibility (Boolean)**. Selecting this option causes three new fields to pop up.
4. Click the **Link** icon next to **Is Visible**. From the menu, select **HUDPlayerInfoViewModel** and **Is Disconnected**.
5. Set **True Visibility** to **Collapsed** and **False Visibility** to **Not Hit-Testable (Self Only)**.
6. The final binding should look like this. Press **Compile** to save your changes.

   [![Player Info Block Visibility](https://dev.epicgames.com/community/api/documentation/image/02226edb-2af2-4924-9470-372ededfaf3a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02226edb-2af2-4924-9470-372ededfaf3a?resizing_type=fit)

That’s it, you now have a fully set up UI widget that will display in-game information!

## Create a Player Stack

This section will show you how to create a user widget that displays additional squad players along with the controlling player.

1. To start off, create a new Widget Blueprint by right-clicking in the Content Browser and selecting **User Interface** > **Widget Blueprint**.

   [![New Widget Blueprint](https://dev.epicgames.com/community/api/documentation/image/eed5e2c9-b2c4-44e4-96f8-b049d9f32d7e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eed5e2c9-b2c4-44e4-96f8-b049d9f32d7e?resizing_type=fit)
2. Select **User Widget** from the dialog box, and rename it to **HUDInfoStack**.
3. Double-click the User Widget to open a new Editor window.
4. From the **Palette** panel, drag an **Overlay** element into the **Hierarchy** panel to get started.
5. Drag a **Stack Box** to the level below the Overlay, and rename it to **PlayerInfoStack**.

   [![Player Info Stack](https://dev.epicgames.com/community/api/documentation/image/36944718-f042-45a7-bb1e-35501ab3f82d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36944718-f042-45a7-bb1e-35501ab3f82d?resizing_type=fit)
6. From the Viewmodels panel, press **+Viewmodel** and select a **Device - HUD Controller Team/Squad Player Info List**.
7. Go to the **Details** panel, and press **+Add Viewmodel Extension**. This allows the PlayerInfoStack to accept an Entry Widget Class.

   [![Viewmodel Extension](https://dev.epicgames.com/community/api/documentation/image/976f0a4f-c2bd-4087-a859-8f2aca47f380?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/976f0a4f-c2bd-4087-a859-8f2aca47f380?resizing_type=fit)

   If you do not see these options, try compiling the widget one more time.
8. For the Entry Widget Class, select the **PlayerInfoBlock** previously created. Below, select **HUDPlayerInfoViewmodel** as the **Entry Viewmodel**.

   [![Entry Viewmodel](https://dev.epicgames.com/community/api/documentation/image/c0bba60f-117f-48c1-bd8f-ec141a7a9ac8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c0bba60f-117f-48c1-bd8f-ec141a7a9ac8?resizing_type=fit)
9. Under the **Slot Template** section, you can adjust the spacing between each widget and alignment, and preview what a certain number of widgets would look like in game.

   Spacing between widgets

   *Click gif to expand.*
10. In the **View Bindings** panel, click **+Add Widget**, then choose **HUDInfoStack**. Choose **PlayerInfoStack\_Viewmodel\_Extension** and expand it to see **Set Items**, then select it. If **PlayerInfoStack\_Viewmodel\_Extension** doesn't appear in your list, press **Compile** and it should appear.

    [![Stack Viewmodel Extension](https://dev.epicgames.com/community/api/documentation/image/5859496e-c1ac-467a-9464-022cd29ef51e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5859496e-c1ac-467a-9464-022cd29ef51e?resizing_type=fit)
11. In the empty field to the right, select **HUDPlayerInfoListViewModel** > **Team/Squad Players Info Array**. This passes the array of player info viewmodels into the newly set up extension with a function called **Set Items**.

    [![Full Stack Viewmodel Extension](https://dev.epicgames.com/community/api/documentation/image/3e93a87d-fa0d-48c8-a8d8-129c2c064a38?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e93a87d-fa0d-48c8-a8d8-129c2c064a38?resizing_type=fit)
12. Press **Compile** to save your changes. You are now ready to add these to your game using the **HUD Controller** device.

If you would like to make a widget for the controlling player that is separate from the rest of the squad:

1. Create a new widget for your controlling player and set up the view bindings just like you had previously using the **Device - HUD Controller Player Info Viewmodel**.
2. Bring this widget under the parent widget holding the Stack Box.
3. Create a binding for that widget. In the left field, select **Device - HUD Controller Player Info Viewmodel**. In the right field, select **Device - HUD Controller Team/Squad Player Info List** > **Controlling Player Info**.

[![Parent Child Widgets](https://dev.epicgames.com/community/api/documentation/image/f8041d64-dade-43a8-999d-a7f3a4bd7da2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f8041d64-dade-43a8-999d-a7f3a4bd7da2?resizing_type=fit)

## Set Up the HUD Controller Device

1. Search for the **HUD Controller device** in the Content Browser, and drag it into your scene.

   [![HUD Controller](https://dev.epicgames.com/community/api/documentation/image/3e92296d-a36b-429c-b8d7-f2d084208ae2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e92296d-a36b-429c-b8d7-f2d084208ae2?resizing_type=fit)
2. In the User Options, choose what you want the player to see, and ensure that **Show HUD** is set to **Yes** and **Show Team Info** is set to **No**.
3. Scroll down to **Player Info Widget Override** and drag the **HUDInfoStack** widget into the empty field. Make sure this is the newly-created stack widget, not the original widget you created.

   [![HUD Controller Options](https://dev.epicgames.com/community/api/documentation/image/081af0e7-4eda-4eb0-ac29-83148fb9b9aa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/081af0e7-4eda-4eb0-ac29-83148fb9b9aa?resizing_type=fit)
4. Click **Save**.

That’s it! Your fresh UI should now appear when you playtest your game!

## Up Next

Next, you will learn about setting up the cameras and controls devices for your side scroller game!

[![TMNT Cameras and Controls](https://dev.epicgames.com/community/api/documentation/image/ba83e833-317a-41f1-8210-db800b701234?resizing_type=fit&width=640&height=640)

TMNT Cameras and Controls

Set up the cameras and controls for a side scroller game using the TMNT Arcade template.](https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-cameras-and-controls-in-unreal-editor-for-fortnite)
