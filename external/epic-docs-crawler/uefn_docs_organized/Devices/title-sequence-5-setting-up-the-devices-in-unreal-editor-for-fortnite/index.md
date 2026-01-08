# 5. Setting Up the Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-5-setting-up-the-devices-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:17:32.666160

---

Finally, you can set up the following devices to complete the tutorial:

- **2 x [Fixed Point Camera Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-fixed-point-camera-devices-in-fortnite-creative)**
- **3 x [HUD Message Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative)**
- **1 x [Pop-Up Dialog Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-popup-dialog-devices-in-fortnite-creative)**
- **2 x [HUD Controller Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-controller-devices-in-fortnite-creative)**
- **1 x [Trigger Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative)**

The sections below describe the settings to change for each device. After applying the settings, playtest your project to see the title sequence play at the beginning.

## Fixed Point Camera Devices

Add one Fixed Point Camera device to your project and place it in a dark room. This dark room should be made of all walls and floors that have an unlit material with pure black for the [emissive](https://docs.unrealengine.com/using-the-emissive-material-input-in-unreal-engine/). This camera will be the camera that you use with the splash screens.

[![Fixed Point Camera in Dark Room](https://dev.epicgames.com/community/api/documentation/image/103acca0-b25e-419f-8e49-8873936bc1e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/103acca0-b25e-419f-8e49-8873936bc1e0?resizing_type=fit)

In the camera's Details panel, apply the following options:

| Option | Value | Explanation |
| --- | --- | --- |
| **Priority** | 200.0 | Set to a higher priority than all the other cameras in your project so that it's guaranteed to display first. |
| **Add to Players On Start** | True | Enabled so the camera is added to everyone at the beginning of the game. |
| **Transition in Priority** | 200.0 | Set to a higher priority than all the other cameras in your project so that it's guaranteed to display |
| **Transition in Time** | 0.0 | Set to zero so it's instantaneous. |
| **Transition Out Priority** | 200.0 | Set to a higher priority than all the other cameras in your project so that it's guaranteed to display. |
| **Transition Out Time** | 0.0 | Set to zero so it's instantaneous. |

Add a second Fixed Point Camera device to your project and place it where you want your title to display against. In this example, the camera is facing a building and the player spawn pad is in front of the camera, so when the camera transitions out, it'll transition smoothly to where the player is.

[![Fixed Point Camera for Title Screen](https://dev.epicgames.com/community/api/documentation/image/1996a1ba-cda3-4b2b-876a-434c2de2931d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1996a1ba-cda3-4b2b-876a-434c2de2931d?resizing_type=fit)

In the camera's Details panel, apply the following options:

| Option | Value | Explanation |
| --- | --- | --- |
| **Priority** | 0.0 | Set to a higher priority than all the other cameras (except the intro camera) in your project so that it's guaranteed to display first. |
| **Add to Players On Start** | False | The Title Sequence Verse device will add this camera to players. |
| **Transition in Priority** | 190.0 | Set to a higher priority than all the other cameras (except the intro camera) in your project so that it's guaranteed to display. |
| **Transition in Time** | 0.0 | Set to zero so it's instantaneous. |
| **Transition Out Priority** | 190.0 | Set to a higher priority than all the other cameras (except the intro camera) in your project so that it's guaranteed to display. |
| **Transition Out Type** | Ease-In-Out | When the camera is removed, we want to transition the camera smoothly to where the player is. |
| **Transition Out Time** | 0.2 | The time (in seconds) to transition to get the game started. |

## HUD Message Devices

Add three HUD Message devices to your project to display custom images to players.

In the HUD Message devices' Details panel, apply the following options:

| Option | Value | Explanation |
| --- | --- | --- |
| **Show for Duration** | True | Enable this setting so the image only displays for a specified amount of time. |
| **Display Time** | 2.5 | The time (in seconds) to display the image. |
| **Play Sound** | None | Remove sound from the device when it displays. |
| **Placement** | Custom | Set to custom for more control. |
| **Screen Anchor** | Center | Set to Center so the image displays in the middle of the screen. |
| **Intro Animation** | Fade | Fade in the image. |
| **Outro Animation** | Fade and Zoom | Fade out the image and make it smaller as it fades. |
| **HUD Widget** | Set to the Widget Blueprint it should show. | This will change what's shown for the device to the custom widgets you created earlier. |

## Popup Dialog Device

Add one Popup Dialog device to your project to show the start game option to players and handle their interaction.

In the Popup Dialog device's Details panel, apply the following options:

| Option | Value | Explanation |
| --- | --- | --- |
| **Auto Display** | Never | The Title Sequence Verse device will add this dialog to players. |
| **Response Type** | 1 Button | This example only has one button the player can select to start the game. |
| **Button 1 Text** | Start Game | Set the text on the first button. |
| **Template Override Class** | Set to the Widget Blueprint it should show. | This will change what's shown for the device to the custom widget you created earlier. |

## HUD Controller Devices

Add one HUD Controller device to your project to hide all the in-game UI elements during the intro.

In the HUD Controller device's Details panel, apply the following options:

| Option | Value | Explanation |
| --- | --- | --- |
| **Show HUD** | False | Remove all in-game UI elements from the player's view. |

Add a second HUD Controller device with all the in-game UI settings for your game.

## Trigger Device

Add one Trigger device to your level and name it **GameStart**. This device is optional but you can use it to notify other Creative devices that the intro sequence has finished.

## Title Sequence Verse Device

Select the Title Sequence Verse device in the Outliner to open its Details panel, and apply the following options:

| Option | Value | Explanation |
| --- | --- | --- |
| **SplashScreenGameCamera** | Set to the Fixed Point Camera device that's in the dark room. | The Verse device will disable this camera after the splash screens finish showing. |
| **TitleGameCamera** | Set to the Fixed Point Camera device that's for the title view. | The Verse device will add and remove this camera for all players to show the title against. |
| **StartGameDialog** | Set to the Popup Dialog device that has the one button. | The Verse device will show this dialog and handle the player interaction with the button. |
| **TitleScreen** | Set to the HUD Message device that shows the title. | The Verse device will show the HUD Message device to the players. |
| **GameMenuDelay** | 2.5 | The time (in seconds) to show the title before showing the start game dialog. |
| **SplashScreens** | Add two elements to the array and set them to the two HUD Message devices that show the logos. | The order of these elements determines the order of the splash screens. Leaving this array empty means no splash screens will be shown before the title. |
| **IntroHUDController** | Set to the HUD Controller device that hides all the in-game UI elements. | The Verse device will enable and disable this HUD Controller. |
| **GameHUDController** | Set to the HUD Controller for the game. | The Verse device will enable this HUD Controller at the end of the title sequence. |
| **GameStart** | Set to the Trigger device named GameStart. | The Verse device will trigger this device so any Creative devices listening will know when the game is starting. |

[![Title Sequence Verse Device Settings](https://dev.epicgames.com/community/api/documentation/image/87245bee-8a2f-4c31-b49a-aa734865a396?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/87245bee-8a2f-4c31-b49a-aa734865a396?resizing_type=fit)

## On Your Own

By completing this guide, you've learned how to use Verse and Creative devices to create a title sequence that plays before the game starts.

Using what you've learned, try to do the following:

- Change the designs of the Widget Blueprints to make your own custom look.
- Add a [Cinematic Sequence](cinematic-sequence-device-in-unreal-editor-for-fortnite) device with your own [Level Sequence](https://docs.unrealengine.com/cinematics-and-movie-making-in-unreal-engine) to play a [cutscene](unreal-editor-for-fortnite-glossary#cutscene) at the beginning.
- Add more options to the menu, such as selecting a level or a class to start with.
