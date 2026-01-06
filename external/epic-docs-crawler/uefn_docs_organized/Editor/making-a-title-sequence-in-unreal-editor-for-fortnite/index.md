# Making a Title Sequence

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/making-a-title-sequence-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:07:23.243020

---

This feature is in Early Access. You can publish an island with this feature, but be aware that through the Early Access period, changes may break your island and may require your active intervention.

A title or intro sequence can add polish to your experience and convey information to your players. Sequences like these can provide backstory, set the mood, and even display who was involved in making the experience!

By completing this guide, you will learn how to create a title sequence that shows splash screens on a black screen with logos before transitioning to a title screen where the player can choose when to start the game. This example uses:

- [Fixed Point Camera](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-fixed-point-camera-devices-in-fortnite-creative) devices to set the different camera views, including the black background at the beginning.
- [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative) devices to show the logos and titles with a custom UI.
- [Pop-Up Dialog](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-popup-dialog-devices-in-fortnite-creative) devices to handle the player UI selection to start the game.
- [Verse](https://dev.epicgames.com/documentation/en-us/fortnite/programming-with-verse-in-unreal-editor-for-fortnite) to manage the timing and transitions for camera views and UI elements.

Follow the steps below to create a title sequence.

[![1. Coding the Verse Device](https://dev.epicgames.com/community/api/documentation/image/c67d9146-8597-4de0-a873-52d938069a75?resizing_type=fit&width=640&height=640)

1. Coding the Verse Device

Create the Verse device to manage timing and transitions for the camera views and UI elements.](https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-1-coding-the-verse-device-in-unreal-editor-for-fortnite)[![2. Customizing the Splash Screens](https://dev.epicgames.com/community/api/documentation/image/44a027b3-aefa-44d3-b10b-e1f1fe8dc807?resizing_type=fit&width=640&height=640)

2. Customizing the Splash Screens

Create custom images to show on the HUD Message devices for the splash screens.](https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-2-customizing-the-splash-screens-in-unreal-editor-for-fortnite)[![3. Designing the Title Screen](https://dev.epicgames.com/community/api/documentation/image/e5592e22-2c93-4db5-ae17-ac725401dc70?resizing_type=fit&width=640&height=640)

3. Designing the Title Screen

Create a custom title screen to show on the HUD Message device.](https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-3-designing-the-title-screen-in-unreal-editor-for-fortnite)[![4. Creating the Game Menu](https://dev.epicgames.com/community/api/documentation/image/33f2e06c-308f-44b0-a547-3557bd6536ee?resizing_type=fit&width=640&height=640)

4. Creating the Game Menu

Create a custom menu to show on the Popup Dialog device.](https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-4-creating-the-game-menu-in-unreal-editor-for-fortnite)[![5. Setting Up the Devices](https://dev.epicgames.com/community/api/documentation/image/de6a98c8-4bb5-4816-9fe4-43002f0c3569?resizing_type=fit&width=640&height=640)

5. Setting Up the Devices

Set up the Creative devices for making a title sequence.](https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-5-setting-up-the-devices-in-unreal-editor-for-fortnite)
