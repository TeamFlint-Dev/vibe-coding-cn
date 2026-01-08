# 4. Creating the Game Menu

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-4-creating-the-game-menu-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:17:38.329500

---

In this section, you'll learn how to create a custom menu to show on the Popup Dialog device.

Follow these steps to create a custom menu:

1. Create a [Widget Blueprint that's a Modal Dialog Variant](ui-widget-editor-in-unreal-editor-for-fortnite#modaldialogvariant) named **WBP\_Dialog\_One\_Button\_Intro**.
2. Add a Size Box widget first then the Overlay widget as its child. The Size Box gives a panel for the Overlay widget to be positioned in.
3. In the Details panel of the Overlay widget, apply the following settings.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Padding** | 0.0, 0.0, 0.0, 40.0 | This will add 40 pixel padding to the bottom of the widget. |
   | **Horizontal Alignment** | Center Align Horizontally | This aligns the widget in the middle of the screen. |
   | **Vertical Alignment** | Bottom Align Vertically | This aligns the widget to the bottom of the screen. |

4. In the Details panel of the Image widget, apply the following settings.
   Option
   Value
   Explanation
   **Horizontal Alignment**
   Fill Horizontally
   The widget will take up as much space as it can.
   **Vertical Alignment**
   Fill Vertically
   The widget will take up as much space as it can.
   **Tint**
   AE4200FF Hex sRGB
   Color for the background.
   **Draw As**
   Rounded Box
   This renders the image with rounded corners.
   **Visibility**
   Not Hit-Testable (Self Only)
   Only the button itself should be selectable in the UI.
5. In the Details panel of the UEFN Button Quiet widget, apply the following settings.
   Option
   Value
   Explanation
   **Min Width**
   300
   Set the width for the button.
   **Min Height**
   48
   Set the height for the button.
   **Horizontal Alignment**
   Fill Horizontally
   The widget will take up as much space as it can.
   **Vertical Alignment**
   Fill Vertically
   The widget will take up as much space as it can. **Visibility**
   Visible
   The button should be selectable in the UI.
   **Text**
   None
   Leave the Text setting blank because we're using a Text Block to create the custom text.
6. In the Details panel of the UEFN Text Block widget, apply the following settings.
   Option
   Value
   Explanation
   **Horizontal Alignment**
   Center Align Horizontally
   This aligns the widget in the middle of the container.
   **Vertical Alignment**
   Center Align Vertically
   This aligns the widget in the middle of the container.
   **Text**
   Button 1 Text
   Placeholder text. The View Bindings will replace the text here with the text in the Popup Dialog device's settings.
   **Visibility**
   Not Hit-Testable (Self Only)
   We don't want the text to hide the button from the user's interaction.
7. Click **View Bindings** in the Widget Editor.
8. Add the following bindings to the UEFN Button Quiet widget.

   - Change the direction of the binding to **One Way to View Model**.
   - Set the left side to **Is Enabled**.
   - Set the right side to **WidgetName > Is Enabled**.
   - Create a new binding and set the left side to **On Clicked**.
   - Set the right side to CreativeModalDialogViewmodel > Response.
   - Set **Response** to **Button 1**.
9. Add the following binding to the UEFN Text Block widget.

   - Change the direction of the binding to **One Way to Widget**.
   - Set the left side to **UEFN Text Block > Text**.
   - Set the right side to **CreativeModalDialogViewmodel > Button 01 Main Text**.
10. Save and click Compile for the Widget Blueprint.

You'll add this custom widget to a Popup Dialog device next in [step 5](https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-5-setting-up-the-devices-in-unreal-editor-for-fortnite) of this tutorial.

## Next Section

[![5. Setting Up the Devices](https://dev.epicgames.com/community/api/documentation/image/de6a98c8-4bb5-4816-9fe4-43002f0c3569?resizing_type=fit&width=640&height=640)

1. Setting Up the Devices

Set up the Creative devices for making a title sequence.](<https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-5-setting-up-the-devices-in-unreal-editor-for-fortnite>)
