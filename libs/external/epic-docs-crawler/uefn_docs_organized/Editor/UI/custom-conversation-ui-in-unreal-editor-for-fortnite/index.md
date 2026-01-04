# Custom Conversation UI

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/custom-conversation-ui-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:16:11.771992

---

The **Widget Editor** allows you to design the look of the buttons and backgrounds for your conversations. You don't need to add text to any of the widgets in the Widget Editor to create custom modals. All the buttons and text block widgets pull the text and dialogue from your Conversation Bank.

Using the Widget Editor means you can import:

- Images
- Pre-designed dialog boxes
- Font files

[![UI Preview](https://dev.epicgames.com/community/api/documentation/image/a97f59fd-a501-4dd0-800d-7f43ae981b29?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a97f59fd-a501-4dd0-800d-7f43ae981b29?resizing_type=fit)

A cool example of building a custom UI using the Widget Editor can be found on the [TMNT Arcade Template](https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-arcade-template-in-unreal-editor-for-fortnite) tutorial page.

To open the Widget Editor:

1. Right-click inside the Content Browser and select **User Interface** > **Widget Blueprint**.
2. Select **Modal Dialogue Variant** from the **Widget Blueprint Selection** window.
3. Name your Widget Blueprint and double-click the widget thumbnail to open the **Widget Editor**.
4. Creating custom conversation boxes uses the workflows outlined on the [Widget Editor](https://dev.epicgames.com/documentation/en-us/fortnite/ui-widget-editor-in-unreal-editor-for-fortnite) page.

The widgets you’ll most likely use with the Conversation device include:

- **Canvas Panel** - A panel to place all the widgets with alignment control, and more.
- **UEFN TextBlock for ConversationModalDialogViewModel** - For the conversation title text.
- **UEFN TextBlock for ConversationModalDialogViewModel** - For the conversation body text.
- **UEFN Button for ConversationModalDialogViewModel** - For all buttons/text choices.

### Binding Values

Binding values refers to the text entered in the Conversation Graph. All the text entered in the conversation nodes is added to the widgets during gameplay when the widgets are properly bound to widgets in the Viewmodel.

Binding the text values for the custom conversation box begins with the **Hierarchy** panel in the Widget Editor.

1. Select a widget from the Hierarchy panel. You can start at the top of the hierarchy and work down to the bottom of the list.
2. Click View Bindings from the bottom toolbar. The Viewmodel panel opens.

   [![Click View Bindings to open the bindings for the widget selected from the Hierarchy panel.](https://dev.epicgames.com/community/api/documentation/image/0f5f5a09-30de-4753-8b2c-1b5db4fe4f34?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0f5f5a09-30de-4753-8b2c-1b5db4fe4f34?resizing_type=fit)

   Click image to enlarge.
3. Select the element you need, then click **+ Add Widget** from the **Viewmodel** panel. This automatically adds the widget to the viewmodel list.

   [![](https://dev.epicgames.com/community/api/documentation/image/c03e5d0d-6512-4ccc-b319-e3876ea3723d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c03e5d0d-6512-4ccc-b319-e3876ea3723d?resizing_type=fit)

   Widgets can also be added to the viewmodel by clicking in the **Widget** field and selecting the widget from the dropdown menu.

   [![](https://dev.epicgames.com/community/api/documentation/image/781e0ff5-c6c7-412e-bd09-8b4ad57f4edb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/781e0ff5-c6c7-412e-bd09-8b4ad57f4edb?resizing_type=fit)
4. Select the property to bind the on the widget by clicking the **Edit icon** on the **UEFN Text property** and selecting **Text** > **Select**.

   [![Select the Text property of the Viewmodel then click Select.](https://dev.epicgames.com/community/api/documentation/image/d6d21078-493b-439c-8abe-d6307f578348?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d6d21078-493b-439c-8abe-d6307f578348?resizing_type=fit)

   Click to enlarge image.
5. Select either a **text value** or a **button value** from the **CreativeModalDialogueViewmodel** dropdown menu. This adds the selected value to the widget. The selection should be made based on the type of widget in the hierarchy.

   [![Select either a text value or a button value from the CreativeModalDialogueViewmode**l** dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/812b56e3-4d08-4624-af41-94409b4b0993?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/812b56e3-4d08-4624-af41-94409b4b0993?resizing_type=fit)

   Click to enlarge image.
6. Click **Select** to finish binding the values to the widgets.

   1. **Text values** include **Title**, **Body** or **Button# Main Text**:
   2. **Title** is the value set in the Speaker Name field in the Conversation device or the value set in Title in the Popup Dialog device.
   3. **Body** is the text that follows and usually presents the player with options in the conversation. These would be the Speech nodes that link to the Default Entry Point node.
   4. **Button# Main Text** is the text that shows up in the response nodes, as they are ordered in the Conversation Graph.

   [![](https://dev.epicgames.com/community/api/documentation/image/a9745e9d-6f21-4cef-9c4d-a7cf38396696?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9745e9d-6f21-4cef-9c4d-a7cf38396696?resizing_type=fit)

**Button values** should be numbered according to the number of button widgets used. The values are set in the same numerical order that the button widgets were added. The buttons are the **Response nodes** in a Conversation Graph. This binds the button text to each of the buttons accordingly.

### Binding Buttons

Binding buttons refers to initiating events after a button selection. This can be a single event where an NPC provides an item, or a complex exchange where the NPC has goods to sell, which sets off a series of events.

To program the events firing in the custom button widgets you need to add the event logic to the button from the viewmodel.

1. Click **View Bindings** from the bottom toolbar.

   [![](https://dev.epicgames.com/community/api/documentation/image/51c79f4b-c66d-4f52-aa5d-8d38eac5e971?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/51c79f4b-c66d-4f52-aa5d-8d38eac5e971?resizing_type=fit)
2. Select one button at a time from the **Hierarchy** panel in the Widget Editor. Selecting the widget from the Hierarchy panel automatically places the selected button widget in the Widget field.
3. Click **+ Add Widget**. The widget is added to the list again.

   [![](https://dev.epicgames.com/community/api/documentation/image/0f1c596b-e8a4-4fd8-a9d7-d42e5a33373c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0f1c596b-e8a4-4fd8-a9d7-d42e5a33373c?resizing_type=fit)
4. Select the arrow field and choose **One Way to View Model**.

   [![](https://dev.epicgames.com/community/api/documentation/image/81b8d49f-d120-4e01-b50f-00e70b4dcda6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/81b8d49f-d120-4e01-b50f-00e70b4dcda6?resizing_type=fit)
5. Select the button and choose the **On Clicked** value. Make sure to click **Event** in the selection window, **not Select**.
6. Select the **Response** value in the viewmodel.
7. Choose the **Response** value you want for the button in the line below. The resulting binding should look like this:

   [![](https://dev.epicgames.com/community/api/documentation/image/1f7ea13b-5b5d-4878-aef6-2d0db21d9ce5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1f7ea13b-5b5d-4878-aef6-2d0db21d9ce5?resizing_type=fit)

You can also set up your buttons to hide/unhide depending on whether values are assigned to them:

1. Select the button from the Hierarchy and add a widget to the button.
2. Choose the **Visibility** value.
3. Find the corresponding **Button # Visibility** on the right hand side of the binding, and select it. The resulting binding should look like this:

   [![](https://dev.epicgames.com/community/api/documentation/image/225fe4e9-f8ec-46d4-a036-2543ae699215?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/225fe4e9-f8ec-46d4-a036-2543ae699215?resizing_type=fit)
4. Now the button will only be visible if there is a response to select.

*Click gif to enlarge.*

Without the **Visibility** binding, the text would clear from the response field and leave an empty choice box for the players:

*Click gif to enlarge.Text > Select*

### Binding Materials

Materials can be used in UMG to populate the **Image widget**. Materials used with UMG must be in the **UI material** format for the widget to recognize the Material file and use it with the Image widget. To learn more about UI materials, see the **[UI Materials](https://dev.epicgames.com/documentation/en-us/fortnite/ui-materials-in-unreal-editor-for-fortnite)** documentation.

Materials can be used to populate the **Materials Conversation** array. You can create custom materials with imported files which can be converted to textures in the Material Graph. The following file types aren't an exhaustive list of accepted file types, but are standard for importing raster image assets:

- .png
- .webp
- .jpg

In the Conversation device, add your materials to the **Conversation Material** array. Then, in the Conversation Graph, the Set Material node must be present in the Conversation Graph. The materials are referenced from the graph in the bindings.

[![Create an array in the Conversation Material option then add your custom material to it.](https://dev.epicgames.com/community/api/documentation/image/b9b0d518-91f2-4152-8c48-0b3a96b97094?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9b0d518-91f2-4152-8c48-0b3a96b97094?resizing_type=fit)

Click image to enlarge.

[![You must set the material slot in use with the device for the material to appear for the speaker.](https://dev.epicgames.com/community/api/documentation/image/789e32a3-4fd5-4561-bc48-4ed8d22ef4f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/789e32a3-4fd5-4561-bc48-4ed8d22ef4f2?resizing_type=fit)

Click to enlarge image.

To bind a material to a Conversation device, do the following:

1. In the [UI Widget Editor](https://dev.epicgames.com/documentation/en-us/fortnite/ui-widget-editor-in-unreal-editor-for-fortnite), click the **Image widget** in the **Hierarchy panel**.

   [![Highlight the widget you want to add to the View Bindings panel before opening View Bindings.](https://dev.epicgames.com/community/api/documentation/image/1818f9b2-6947-4dfc-a1c5-c902bc08442b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1818f9b2-6947-4dfc-a1c5-c902bc08442b?resizing_type=fit)

   Click image to enlarge.
2. Click **View Bindings** to open the bindings panel. The panel opens with a binding line for the Image widget.

   [![Click the View Bindings button to add the widget to the View Bindings panel and open the View Bindings panel.](https://dev.epicgames.com/community/api/documentation/image/8b70a5fd-687f-46c4-b3e6-94e3fdd828ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b70a5fd-687f-46c4-b3e6-94e3fdd828ff?resizing_type=fit)

   Click image to enlarge.
3. Click **+AddWidget** button to add the Image widget to the View Bindings panel.

   [![Selecting +Add Widget adds your widget to the View Bindings panel.](https://dev.epicgames.com/community/api/documentation/image/c71cb80b-5deb-422b-a3ae-90d6f3bbb8fe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c71cb80b-5deb-422b-a3ae-90d6f3bbb8fe?resizing_type=fit)

   Click image to enlarge.
4. Click the **Edit icon** on the Image widget in the left field to open the widget options.

   [![Clicking the edit icon opens the widget binding options.](https://dev.epicgames.com/community/api/documentation/image/9d8ff7b0-4fec-4f98-a743-05651f648158?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d8ff7b0-4fec-4f98-a743-05651f648158?resizing_type=fit)

   Click image to enlarge.
5. Select **Image Widget** > **Brush** > **Select**. This adds selectable Brush bindings to the right field.

   [![Select the Image widget, then select Brush and Select to add the Brush bindings to the Image widget.](https://dev.epicgames.com/community/api/documentation/image/02a33cd8-b66e-4c56-a5bd-894c6c681f3d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02a33cd8-b66e-4c56-a5bd-894c6c681f3d?resizing_type=fit)

   Click image to enlarge.
6. Click the **Edit icon** in the right field to open the binding options.

   [![Click the edit icon to open the Brush binding options.](https://dev.epicgames.com/community/api/documentation/image/0f2ee341-0a5c-4d23-9471-11c236b2e92a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0f2ee341-0a5c-4d23-9471-11c236b2e92a?resizing_type=fit)

   Click image to enlarge.
7. Select **Conversion Function** > **Make Image Brush From Material** > **Select**. This opens further options to pinpoint the material you want to use for this widget.

   [![Select conversion functions, then Make Image Brush from Material to be able to add and control your material using the Brush options.](https://dev.epicgames.com/community/api/documentation/image/bb3171c7-36de-4950-85fd-784d58f24680?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb3171c7-36de-4950-85fd-784d58f24680?resizing_type=fit)

   Click image to enlarge.
8. From the **Material** slot select the **Link icon** then from the menu choose **Creative Modal Dialog Viewmodel** > **Art 01 Material** > **Select**.

   [![Click the Link icon to choose the material to bind to the Material slot.](https://dev.epicgames.com/community/api/documentation/image/2cb761e4-7826-44ba-81e0-b76c193cbe2f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2cb761e4-7826-44ba-81e0-b76c193cbe2f?resizing_type=fit)

   Click image to enlarge.
9. From the **Image Size** slot, input the same size that you used in the **Image** widget's **Image Size** option in the **Details** panel.

   [![Ensure that you use the same Image Size in this option as you did with the Image widget's Image Size Brush setting.](https://dev.epicgames.com/community/api/documentation/image/e21cc009-5124-4a45-802c-a4a40b265a66?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e21cc009-5124-4a45-802c-a4a40b265a66?resizing_type=fit)

   Click image to enlarge.

The end result is a material that identifies the character speaker.

### Creating Conversation UI Animations

You can also use Conversation Material in a **UI animation**. The **[Conversation Type](https://dev.epicgames.com/documentation/en-us/fortnite/using-the-conversation-device-in-unreal-editor-for-fortnite#conversation-types)** must be set to **Box** or **Custom** in the Conversation device. From the Material Graph, the Conversation material can be referenced from the Conversation device when you use the **Play Conversation Animation node**.

[![Using the Play Conversation Animation node provides a way for you to add a small animation to your conversation.](https://dev.epicgames.com/community/api/documentation/image/fc3e9c0f-4e34-4fb9-95ab-a0b2d5717506?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc3e9c0f-4e34-4fb9-95ab-a0b2d5717506?resizing_type=fit)

Click to enlarge image.

To bind this Conversation node to your UI widget, you must use the **Progress** value in the Viewmodel to link to the UI animation you create in Sequencer. 
To learn how to animate your material see the [Animating UI](https://dev.epicgames.com/documentation/en-us/fortnite/aninmating-ui-in-unreal-editor-for-fortnite) document.

[![Use the Progress value in the Viewmodel link to be able to use the animation you create for the Conversation Material.](https://dev.epicgames.com/community/api/documentation/image/254b4fc5-187f-4f56-a0d4-2516e0fac14d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/254b4fc5-187f-4f56-a0d4-2516e0fac14d?resizing_type=fit)

You can even use a sprite sheet for your texture with a Flipbook material node to animate the material.
