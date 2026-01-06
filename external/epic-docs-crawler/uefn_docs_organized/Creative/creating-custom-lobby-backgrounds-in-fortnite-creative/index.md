# Creating Custom Lobby Backgrounds

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-custom-lobby-backgrounds-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:55:59.273294

---

Each game now has its own [lobby](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) where players can gather and wait for the island to load, just like the original Fortnite lobby. You can use the default lobby background image Epic Games provides, or you can create your own lobby background that showcases some aspect of your game.

Select a spot on your island that represents your game, then use **Photo Capture Mode** to capture an image for your lobby background.

This tool is only available in Fortnite Creative. To capture a background image in UEFN, you'll need to use a different screen-capture tool.

See [Lobby Background Image Guidelines](https://dev.epicgames.com/documentation/en-us/fortnite/lobby-background-image-guidelines-in-fortnite-creative) for information about what makes a good custom lobby background image and supported file types.

Creating your own image is not a prerequisite for publishing your island. If you don’t want to create a custom lobby background, your island will use the default background for the current Fortnite season.

You can use the Photo Capture Mode to take your images, however the images will not be used in the Lobby until 26.30.

## Photo Capture Mode

**Photo Capture Mode** can be found under **My Island** > **Tools**. The Photo Capture Mode toolset uses a preview overlay on the camera to show you how the final image will look. To get started, press the **Capture** button to open the Lobby Background tools.

[![An example of the overlay preview.](https://dev.epicgames.com/community/api/documentation/image/eb1e0013-8e12-40e2-bac4-15a435e96422?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb1e0013-8e12-40e2-bac4-15a435e96422?resizing_type=fit)

| Number | Feature | Descriptiom |
| --- | --- | --- |
| 1 | **Header** | Fortnite navigation:   - Search - Play - Locker - Shop - Battlepass - Quests - Compete - Career - V-Bucks |
| 2 | **Horizon Line** | Align this line with the horizon of the background. |
| 3 | **Stage** | The place where players spawn into the lobby. |
| 4 | **Tool Functions** | See the list of tool functions below. |
| 5 | **Game Details** | Island thumbnail overlay position. |
| 6 | **News** | News overlay position. |

### Tool Functions

| Tool | Value |
| --- | --- |
| **Capture** | Captures an image. |
| **Last Position** | Enables the camera to take additional screenshots from the previous position. This option would be disabled if no other screenshots were taken.  Shows where the capture tool was used the last time you took a picture for the lobby.  This feature is useful for Island versioning. If you update your scene for a holiday, this can position the camera exactly where it was previously for consistency. |
| **Toggle Overlay** | Shows or hides the preview overlay. |
| **Back** | Cancels the tool and returns to the island to Create mode. |
| **Confirm** | Takes a photo of your current view and saves it to your PC or console. |
| **Retake** | Returns to the preview overlay view. |

To quickly reach an area of your island that you want to capture, increase your fly speed while in Create mode before opening the toolset for capturing your lobby background image.

## Creating Your Custom Lobby Background Image

To create a custom lobby background image, follow the steps below.

1. Navigate to **My Island** > **Tools** > **Lobby Background**.

   [![Click Capture to begin taking your background lobby image.](https://dev.epicgames.com/community/api/documentation/image/761d723d-d6b6-4350-923f-9886be135332?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/761d723d-d6b6-4350-923f-9886be135332?resizing_type=fit)

   *Click image to enlarge.*

   To view previous images you’ve captured for this island, press **My Photos** > **Open Folder**.
2. Press the **Capture** button. A frame covers the camera with the preview overlay tool and controls.

   [![An example of the overlay preview.](https://dev.epicgames.com/community/api/documentation/image/f36fa938-a3be-4e29-8a86-fdc1898b6b35?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f36fa938-a3be-4e29-8a86-fdc1898b6b35?resizing_type=fit)

   If you don’t like what’s in the frame, click **Cancel**, then move to the area you want to capture, or move the camera using the **WASD** keys.
3. Use the WASD keys to move the camera around the landscape in the frame until you find the area you want to capture.

The image is captured and added to your  **FortniteGame** app data directory in the **Documents** > **Windows Explorer** folders. The **AppData** folder is hidden on Windows. PCs using macOS and Linux will find the images in their regular Fortnite folders.

You can capture an image from a console as long as the console is connected to a PC. You cannot use Android to take images with the Photo Capture Mode tools.

### Using Third-Party Tools

You can also use third-party tools to take images and clean the photo up by removing all Fortnite Creative user interface from them. Lobby images are governed by the same policies that apply to thumbnails.

Any image taken for the purpose of a lobby background must:

- Be true to the island experience
- Have no advertisements or hidden suggestions in the background
- Contain no explicit language
- Contain no images of real people or people’s personal identifiable information
- Contain no one else's intellectual property

You can take images for your lobby in another software, such as Blender, as long as the image adheres to the Lobby Background Image Guidelines.

Images you prepare for the custom lobby background must be **2048 x 1024** and no more than **10 MB** and must be one of the supported file types; **.png**, **.jpeg**, **.jpg**. Once you’ve captured a custom lobby background image, you can upload the image to the Creator Portal during the publishing process.

### Using Stock Images

If you don’t have access to photo editing software or don’t feel comfortable making your own custom lobby background images, Epic Games has a series of stock images you can use for your custom lobby background. The images cover a range of island styles and game types. Search through the stock images to find one that best represents your island.

You can find them using this [Dropbox link](https://epicgames.box.com/s/vlczqwhzxonxhl7ba1lmw0pymxpfymjf?sa=D&source=docs&ust=1694640199252646&usg=AOvVaw1S1ZFwYYzuOBYhdDgJ27T9). There is nothing special you must do to access these images, and there’s no limit to the number of images you can download. All lobby images are for the strict use of lobby backgrounds only and will not be approved for use as thumbnails or other supporting media for your island.

## Uploading Your Lobby Background Image to the Creator Portal

To publish the custom lobby background you’ll need to add it to your island’s list of images during the [publishing process](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-from-the-creator-portal-in-fortnite-creative).

Add the custom lobby background image by doing the following:

1. Click the **Add Image** field under **Lobby Background Image**.

   [![Upload your lobby background image during the publishing process.](https://dev.epicgames.com/community/api/documentation/image/f3a6065a-7ca8-4c28-9124-b9261681bb6f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f3a6065a-7ca8-4c28-9124-b9261681bb6f?resizing_type=fit)
2. Select the lobby image from your files. The image uploads to the Creator Portal.

You’ll continue through the publishing process as normal. The lobby background image is part of your island’s supporting assets. Once the project is submitted, wait for confirmation that your island is published.

Your custom lobby image is subject to the same publishing policies and [moderation](https://dev.epicgames.com/documentation/en-us/fortnite/island-moderation-tips-and-faqs-in-fortnite-creative) as all your other supporting materials for your island.
