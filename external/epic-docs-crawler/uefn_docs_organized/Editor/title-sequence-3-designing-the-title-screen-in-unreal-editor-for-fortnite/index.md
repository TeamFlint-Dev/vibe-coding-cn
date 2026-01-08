# 3. Designing the Title Screen

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-3-designing-the-title-screen-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:17:13.855465

---

In this section, you'll learn how to create a custom title screen to show on the HUD Message device.

Follow these steps to create a custom title screen:

1. Create a [**Widget Blueprint** with a User Widget variant](ui-widget-editor-in-unreal-editor-for-fortnite#userwidget) named **WBP\_Title**.
2. Add a **Size Box** widget first, then the **Stack Box** widget as its child. The Size Box gives a panel for the Stack Box widget to be positioned in.
3. Add an **Overlay** widget and a **UEFN Text Block** widget to the Stack Box as children.
4. Add an Image widget and a UEFN Text Block widget to the Overlay as children.
5. In the **Details** panel of the Stack Box widget, apply the following settings.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Padding** | 0.0, 0.0, 0.0, 200.0 | This will add 200 pixel padding to the bottom of the widget. |
   | **Horizontal Alignment** | Center Align Horizontally | This aligns the widget in the middle of the screen. |
   | **Vertical Alignment** | Bottom Align Vertically | This aligns the widget to the bottom of the screen. |
   | **Orientation** | Vertical | This stacks the widget's contents vertically. |

6. In the Details panel of the Overlay widget, apply the following settings:
   Option
   Value
   Explanation
   **Padding**
   0.0, 0.0, 0.0, 20.0
   This will add a 20-pixel padding to the bottom of the widget.
   **Horizontal Alignment**
   Fill Horizontally
   The widget will take up as much space as it can.
   **Vertical Alignment**
   Fill Vertically
   The widget will take up as much space as it can.
7. In the Details panel of the Image widget that's a child of the Overlay widget, apply the following settings.
   Option
   Value
   Explanation
   **Image**
   T\_AmberForestTown\_Ceiling
   Set the image for the background of your title.
   **Image Size X**
   620.0
   Set the width of the background.
   **Image Size Y**
   220.0
   Set the height of the background.
8. In the Details panel of the UEFN Text Block widget that's a child of the Overlay widget, apply the following settings.
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
   Your Title Here
   Set the text for your title.
9. In the Details panel of the UEFN Text Block widget that's a child of the Stack Box widget, apply the following settings.
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
   Your Subtitle Here
   Set the text for your subtitle.
10. Save, then click **Compile** for the **Widget Blueprint**.

[![Title Screen Widget Blueprint in the UI Widget Editor](https://dev.epicgames.com/community/api/documentation/image/12312dc2-9d59-46bb-9cf7-957d22a538ed?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12312dc2-9d59-46bb-9cf7-957d22a538ed?resizing_type=fit)

You'll add this custom widget to a HUD Message device later in [step 5](https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-5-setting-up-the-devices-in-unreal-editor-for-fortnite) of this tutorial.

## Next Section

[![4. Creating the Game Menu](https://dev.epicgames.com/community/api/documentation/image/33f2e06c-308f-44b0-a547-3557bd6536ee?resizing_type=fit&width=640&height=640)

1. Creating the Game Menu

Create a custom menu to show on the Popup Dialog device.](<https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-4-creating-the-game-menu-in-unreal-editor-for-fortnite>)
