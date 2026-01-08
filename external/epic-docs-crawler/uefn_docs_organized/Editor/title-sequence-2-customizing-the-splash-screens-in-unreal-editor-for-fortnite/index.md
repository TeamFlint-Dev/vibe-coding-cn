# 2. Customizing the Splash Screens

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-2-customizing-the-splash-screens-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:17:26.077971

---

In this section, you'll learn how to create custom images to show on the HUD Message devices for the splash screens. For how to add your own images to your project, check out [importing textures](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite).

Follow these steps to create a custom [splash screen](unreal-editor-for-fortnite-glossary#splashscreen):

1. Create a [**Widget Blueprint** with a User Widget variant](ui-widget-editor-in-unreal-editor-for-fortnite#userwidget) named WBP\_Logo1.
2. Add a **Size Box** widget first, then add the **Image** widget as its child. The Size Box gives a panel for the Image widget to be positioned in.
3. In the Details panel of the Image widget, apply the following settings.

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Horizontal Alignment** | Center Align Horizontally | This makes the image appear in the middle of the screen horizontally. |
   | **Vertical Alignment** | Center Align Vertically | This makes the image appear in the middle of the screen vertically. |
   | **Image** | T\_UI\_IconLibrary\_Bicycle\_128 | The image that will show in the UI. |
   | **Image Size X** | 128.0 | Set the width of the image. |
   | **Image Size Y** | 128.0 | Set the height of the image. |

4. Save and click **Compile** for the **Widget Blueprint**.

[![Logo Widget Blueprint in the UI Widget Editor](https://dev.epicgames.com/community/api/documentation/image/b7822f94-6fd5-4e54-a14b-3782b43c8087?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b7822f94-6fd5-4e54-a14b-3782b43c8087?resizing_type=fit)

Duplicate the **WBP\_Logo1** asset for the second splash screen, then change the image.

You'll add these custom widgets to the **HUD Message** devices later in [step 5](https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-5-setting-up-the-devices-in-unreal-editor-for-fortnite) of the tutorial.

## Next Section

[![3. Designing the Title Screen](https://dev.epicgames.com/community/api/documentation/image/e5592e22-2c93-4db5-ae17-ac725401dc70?resizing_type=fit&width=640&height=640)

1. Designing the Title Screen

Create a custom title screen to show on the HUD Message device.](<https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-3-designing-the-title-screen-in-unreal-editor-for-fortnite>)
