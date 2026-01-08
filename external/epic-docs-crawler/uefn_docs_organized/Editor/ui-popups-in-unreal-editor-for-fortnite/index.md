# UI Pop-Ups

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/ui-popups-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:07:45.795478

---

You can create custom user interface (UI) elements for your island in Unreal Editor for Fortnite (UEFN) by using a [widget](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#widget) Blueprint with the [HUD Message device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative) and [Pop-Up Dialog device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-popup-dialog-devices-in-fortnite-creative).

There are two widget Blueprint categories for creating a custom UI:

- **User Widget** - Used to create a custom HUD Message.
- **Modal Dialog Variant** - Used to create custom clickable buttons.

  The Pop-Up Dialog device will only work with a **Modal Dialog Variant** Blueprint. A HUD Message device works with both types of Blueprints.

To learn more about the Widget Editor, refer to the [**UI Widget Editor**](ui-widget-editor-in-unreal-editor-for-fortnite) document.

## User Widget

This widget uses the HUD to display a custom UI message to players. Use this to send players on a quest, or as a narrative device for characters on your island. You can add buttons to your message within the workflow for Modal Dialog Variant below.

Drag a HUD Message device into the viewport. The device will be ready to connect to a widget Blueprint.

### Create the Blueprint

1. Right-click in the Content Browser to open the **Content Browser menu**.

   [![Right-click menu in the Content Browser.](https://dev.epicgames.com/community/api/documentation/image/71c55f9f-f52a-4193-82f3-7eb8f5b6330c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/71c55f9f-f52a-4193-82f3-7eb8f5b6330c?resizing_type=fit)
2. Select **User Interface** > **Widget Blueprint**. The widget path opens.
3. Select **User Widget**. The widget Blueprint thumbnail appears in the Content Browser.

   [![Widget Path](https://dev.epicgames.com/community/api/documentation/image/3611f11a-5811-4ea1-914b-e28581ea0258?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3611f11a-5811-4ea1-914b-e28581ea0258?resizing_type=fit)
4. Rename the thumbnail.

   [![Thumbnail](https://dev.epicgames.com/community/api/documentation/image/6a238334-81b9-4d37-9fd3-63f1e851b45a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6a238334-81b9-4d37-9fd3-63f1e851b45a?resizing_type=fit)
5. Select the HUD Message device in the viewport, search for the Advanced option **HUD Widget** in the Details panel, then select **your widget Blueprint** from the dropdown menu.

   [![Select NEW_HUD from the dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/ccd1d5d8-8148-41b1-bcdf-ebe788faf1f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ccd1d5d8-8148-41b1-bcdf-ebe788faf1f5?resizing_type=fit)
6. Double-click the thumbnail to open the Widget Editor.
7. Select a **Panel widget** from the Panel menu. For this example, a Canvas Panel was used.

   This step must be done **before** adding any elements to the widget.

   [![Select a panel type.](https://dev.epicgames.com/community/api/documentation/image/860528eb-30f9-4ce9-8d24-8dff4772595b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/860528eb-30f9-4ce9-8d24-8dff4772595b?resizing_type=fit)

   Whatever you place in this panel will display in the HUD Message.
8. Resize the panel widget by clicking the corner and dragging to the desired size. In this example, the panel is **1920 x 1080** for full high definition (HD).

   [![Drag the corner of the panel to resize it.](https://dev.epicgames.com/community/api/documentation/image/cb52a28a-cbea-4882-901a-3d0f9ffe839e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cb52a28a-cbea-4882-901a-3d0f9ffe839e?resizing_type=fit)

   *Click to enlarge image.*
9. [Import](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite) an image into the Content Browser, then drag the image widget into the Widget Blueprint Editor. This will be your HUD background image.
10. Resize the image from the Details panel using the **Image Size** option under **Appearance**.

    [![Resize the image.](https://dev.epicgames.com/community/api/documentation/image/fb5fbecc-3ce4-4a32-ba69-f7fefbefb16e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fb5fbecc-3ce4-4a32-ba69-f7fefbefb16e?resizing_type=fit)
11. Move the image around using the **Translation** fields. Dragging in the first field moves the image to the left and right. Dragging in the second field moves the image up and down.

    [![Move the image inside the panel using the Translate fields.](https://dev.epicgames.com/community/api/documentation/image/30530f3e-6e0d-4673-b91b-924cd7b98fbb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/30530f3e-6e0d-4673-b91b-924cd7b98fbb?resizing_type=fit)
12. Drag a **UEFN Text Block widget** onto the panel. The text block widget is where you’ll create your custom HUD message.

    Where you place the text box widget is where the text will appear on the HUD message.
13. Add your custom UI message to the **Text** field in the Details panel.
14. Add color to your text and change your font style with the Appearance options **Color and Opacity**, **Font Family**, and **Size**.

    You can adjust your text further by skewing the letters, using custom letter spacing, or adding an outline or drop shadows to the text.

When your HUD Message device is triggered, your custom UI message will appear in the HUD.

## Modal Dialog Variant

This widget uses a button interface to connect a Pop-Up Dialog device and to an Item Granter device to supply players with an item. To begin, drag a Pop-Up Dialog device and Item Granter device into the viewport.

### Create the Blueprint

1. Right-click in the Content Browser to open the **Content Browser menu**.

   [![Right-click menu in the Content Browser.](https://dev.epicgames.com/community/api/documentation/image/4f86224b-4e7f-4022-b0b1-576483c12b1d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f86224b-4e7f-4022-b0b1-576483c12b1d?resizing_type=fit)
2. Select **User Interface** > **Widget Blueprint**. The widget path opens.
3. Select **Modal Dialog Variant**. The widget Blueprint thumbnail appears in the Content Browser.

   [![Widget Path](https://dev.epicgames.com/community/api/documentation/image/9d60059b-2335-4063-b604-1db05eaf0ba3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d60059b-2335-4063-b604-1db05eaf0ba3?resizing_type=fit)
4. Rename the thumbnail.

   [![Thumbnail](https://dev.epicgames.com/community/api/documentation/image/7992ad50-52e6-4aa2-ba41-074f9e1e8a92?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7992ad50-52e6-4aa2-ba41-074f9e1e8a92?resizing_type=fit)
5. Double-click the thumbnail to open the Widget Editor.
6. Drag a panel widget into the viewport and resize it.

   [![Drag the corner of the panel to resize it.](https://dev.epicgames.com/community/api/documentation/image/ecf05d10-1039-4eb2-83f6-2afb65756a48?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ecf05d10-1039-4eb2-83f6-2afb65756a48?resizing_type=fit)

   *Click to enlarge image.*
7. Drag an image widget into the viewport or import of a weapon or item and drag the image from the Content Browser into the viewport.
8. Select the alignment of the image. There are different horizontal and vertical alignments.

   [![Select the alignment for the image](https://dev.epicgames.com/community/api/documentation/image/b1877d25-715e-419e-bbd3-0e53c6747e71?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1877d25-715e-419e-bbd3-0e53c6747e71?resizing_type=fit)
9. Translate the image inside the viewport using the **Translate tools**. Dragging in the first field moves the image right and left, dragging in the second field moves the image up and down.

   [![Move the image inside the panel using the Translate fields.](https://dev.epicgames.com/community/api/documentation/image/e14fe1bb-7499-42f9-b44e-60658b0c2623?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e14fe1bb-7499-42f9-b44e-60658b0c2623?resizing_type=fit)
10. Drag a button widget into the viewport, select an alignment, then translate the button using the **Translation** fields.
11. Name the button in the **Text** field and add an action in the **Text Secondary** field.

    [![Name the button.](https://dev.epicgames.com/community/api/documentation/image/f7203972-c52c-4564-801f-90b66f12cae1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f7203972-c52c-4564-801f-90b66f12cae1?resizing_type=fit)

    If you only want to use an action on the button, then add the action to the Text field only. This means your button can simply read "Press Here".
12. Set the following **Selection** options:

    1. **Selectable** - On
    2. **Interactable when Selected** - On

    [![Turn the following selection options on.](https://dev.epicgames.com/community/api/documentation/image/fd3295c3-5cc3-4424-9d61-79bf00a26a24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fd3295c3-5cc3-4424-9d61-79bf00a26a24?resizing_type=fit)

    This causes the buttons to use **button behavior** when receiving input.
13. Select the Pop-Up Dialog device in the viewport and search for **Modal Widget** > **Template Override Class** in the Details panel. Select the **UI button** from the Template Override Class dropdown menu.

    [![](https://dev.epicgames.com/community/api/documentation/image/3c862789-3e29-4502-8d15-96b2029d1460?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c862789-3e29-4502-8d15-96b2029d1460?resizing_type=fit)
14. Set the **Auto Display Option** to **Game Start**. When you playtest, the button will automatically spawn at game start.

    You can also set this option to **Never,** then set up another device to trigger the Pop-Up Dialog device.
15. Select the Item Granter and add the weapon or item to the **Item List**.

    The item you equip should match the image you use unless you use a question mark, in which case you can use any item you want.
16. Select the **Pop-up Dialog** device from the **Grant Item** dropdown menu and select **On Responding Button1** from the **Function list**.

    [![Set the Function options for the Item Granter.](https://dev.epicgames.com/community/api/documentation/image/eb0f7f21-1e19-44cd-94bf-e0ce887d044e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb0f7f21-1e19-44cd-94bf-e0ce887d044e?resizing_type=fit)

### Button Logic

Now you're ready to make the button logic for the widget Blueprint.

1. Open the Widget Editor.
2. Click the **View Bindings** button at the bottom of the editor.

   [![Click the View Bindings button to add button logic.](https://dev.epicgames.com/community/api/documentation/image/6d73373b-24bf-4252-bcd0-a0b053229b78?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d73373b-24bf-4252-bcd0-a0b053229b78?resizing_type=fit)
3. Click Create Viewmodel.

   [![Create Viewmodel](https://dev.epicgames.com/community/api/documentation/image/411ea1ae-ff04-413c-b708-7cbd5a4982c0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/411ea1ae-ff04-413c-b708-7cbd5a4982c0?resizing_type=fit)
4. Select **Creative Modal Dialog Viewmodel** > **Select** > **Close**. This adds all the possible button logic you can edit to the widget Blueprint.

   [![Add the button logic to the widget Blueprint.](https://dev.epicgames.com/community/api/documentation/image/effb38dc-518a-460a-92a5-33f735e95188?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/effb38dc-518a-460a-92a5-33f735e95188?resizing_type=fit)
5. Click **View Bindings** > **Add Widget** to open the menu for widget selection.

   [![Open the functionality panel.](https://dev.epicgames.com/community/api/documentation/image/2a500160-ffa6-466c-bf59-fc8870e8f9b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a500160-ffa6-466c-bf59-fc8870e8f9b7?resizing_type=fit)
6. Select the **button widget** from the Creative Modal Dialog Viewmodel dropdown then click **Select**.
7. Select **One Way Widget** and set to **One Way To Viewmodel** from the Binding Mode dropdown menu.)

   [![](https://dev.epicgames.com/community/api/documentation/image/85b2d6a9-1d79-4aca-af6a-27a14be1ac01?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/85b2d6a9-1d79-4aca-af6a-27a14be1ac01?resizing_type=fit)
8. Click in the first field and select **Conversion Functions** > **Get Response Button 1** > **Select**.

   [![](https://dev.epicgames.com/community/api/documentation/image/9ff5b156-e304-492e-9c51-4928db019ef1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9ff5b156-e304-492e-9c51-4928db019ef1?resizing_type=fit)

   These button numbers refer to the placement in the panel.
9. Click into the second field and select **Creative Modal Dialog Viewmodel** > **Response** > **Select**.

   [![](https://dev.epicgames.com/community/api/documentation/image/76a62c26-b38b-4bfc-bb4e-0554e4009127?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/76a62c26-b38b-4bfc-bb4e-0554e4009127?resizing_type=fit)
10. Select the **UEFN button widget** you dragged onto the panel from the **Field** dropdown menu and select **Click Event** > **Select**.

    [![Enter the relevant information into the fields.](https://dev.epicgames.com/community/api/documentation/image/15f83735-c7f2-4fe6-a764-83a8611f2099?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/15f83735-c7f2-4fe6-a764-83a8611f2099?resizing_type=fit)
11. Click **Compile**.

Playtest to ensure the button spawns and works as intended when pressed.
