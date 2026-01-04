# Custom UI and Music

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/custom-ui-and-music-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:38:56.991629

---

Make your platformer stand out from the rest, by creating your own music and unique user interface!

The music and user interface (UI) should match the type of island you’re creating. If you’re creating an island experience that’s fun and playful, the music and UI should reflect that.

In this experience, the music has an urgency to it to make the player move forward and warn them of their surroundings.

The UI incorporates the color of the plants on the island to give everything a unified feel. The basic shape of the UI looks simple but complements the game without being in the way or distracting from the game.

## Custom Music

**Patchwork** features **device prefabs** that combine a number of Patchwork devices into music packages. These packages concentrate on rhythm sections that make creating your own music easier.

| Patchwork Prefab | Image | Device List | Explanation |
| --- | --- | --- | --- |
| Melody Prefab |  | - Note Sequencer - Note Progressor - Instrument Player - Echo Effect - LFO Modulator - Speaker | Provides a way for you to create a melody by using specific instruments then modifying their sounds. |
| Bass Prefab |  | - Note Sequencer - Note Progressor - Omega Synth - Distortion Effect - LFO Modulator - Speaker | Provides a way for you to create a bass section for your melody with the Note Sequencer and Progressor devices, and the Omeg Synth device. |
| Drum Prefab |  | - Drum Sequencer - Drum Player - LFO Modulator - Echo Effect - Speaker | Provides a way to create a drum section to add a beat. |

## Custom UI

The example island has a custom player UI, coin collection tracker, and pop-up warning. The custom player UI makes the game feel unique and adds to the experience by replacing the default Fortnite UI.

See the [Making a Custom HUD](https://dev.epicgames.com/documentation/en-us/uefn/making-a-custom-hud-in-unreal-editor-for-fortnite) tutorials to create your own player UI.

[![](https://dev.epicgames.com/community/api/documentation/image/2e8df690-0d73-46e4-ad4d-c35682048060?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2e8df690-0d73-46e4-ad4d-c35682048060?resizing_type=fit)

The custom coin tracker is a fun way for players to see how many coins they’ve collected.

To create your own Collectible tracker, see the [Conversion Functions: To Text (Int) and To Text (Double)](https://dev.epicgames.com/documentation/en-us/uefn/conversion-functions-to-text-int-and-to-text-double-in-unreal-editor-for-fortnite) tutorial from the Using the Viewmodel tutorials.

To learn more about making a custom UI and working in Unreal Motion Graphics(UMG), see  [UI Layout in UMG](https://dev.epicgames.com/documentation/en-us/uefn/ui-layout-in-umg-in-unreal-editor-for-fortnite).

[![](https://dev.epicgames.com/community/api/documentation/image/69e68c9a-a8ba-4390-ac18-bf54fde1e47d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69e68c9a-a8ba-4390-ac18-bf54fde1e47d?resizing_type=fit)

A Tracker device can only display one widget in the upper left corner of the screen at a time.

### Pop-Up Warning

The pop-up message warns players when the time of day jumps forward into night and the game switches from platformer to survival mode. The message in the pop-up tells players that the time is about to switch and what that means.

To create your own popup messages in UMG, see the **Modal Dialog Variant** tutorial in the [UI Pop-Ups](https://dev.epicgames.com/documentation/en-us/uefn/ui-pop-ups-in-unreal-editor-for-fortnite) document.

[![](https://dev.epicgames.com/community/api/documentation/image/2986d698-3325-41f4-bc5f-e2fb263aa878?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2986d698-3325-41f4-bc5f-e2fb263aa878?resizing_type=fit)

To create your own pop-up message, you’ll need the following widgets:

- **Overlay**
- **Image**
- **Text**
- **Quiet Button**

To bind the Quiet Button to close the popup after it displays, follow the instructions below:

1. Open **Window** > **View Bindings**.

   [![](https://dev.epicgames.com/community/api/documentation/image/528dbcf7-2d93-4b5f-a254-cad522a7ebef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/528dbcf7-2d93-4b5f-a254-cad522a7ebef?resizing_type=fit)
2. Select the **Quiet Button** in your widget, then click **+Add Widget** in the **View Bindings** window.

   [![](https://dev.epicgames.com/community/api/documentation/image/e0efef43-9c63-42de-99b8-9b01955136e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e0efef43-9c63-42de-99b8-9b01955136e9?resizing_type=fit)
3. Click the **left field** that contains the Quiet Button and select **Click Event** > **Event** from the **Binding dropdown menu**. This automatically decides the direction of the interaction for the button and creates an event on the Quiet Button.

   [![](https://dev.epicgames.com/community/api/documentation/image/682072a9-b803-4462-8b5e-49d162405b7b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/682072a9-b803-4462-8b5e-49d162405b7b?resizing_type=fit)
4. Click in the empty **right field** and select **CreativeModalDialogViewmodel** > **Response** > **Select**. The Response to the event appears below.

   [![](https://dev.epicgames.com/community/api/documentation/image/dcdba9a2-1df2-4c0f-ab71-5d2f69096ba6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dcdba9a2-1df2-4c0f-ab71-5d2f69096ba6?resizing_type=fit)
5. Click in the empty **Response field** and select **Button 1** from the dropdown menu. Both the event and response are now connected to the Quiet Button.

   [![](https://dev.epicgames.com/community/api/documentation/image/27c72730-1219-4e59-a812-c6849bfbbea7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/27c72730-1219-4e59-a812-c6849bfbbea7?resizing_type=fit)

The widget is now complete and ready to be used with the Pop-Up Dialog device.

### Add the Widget to the Pop-Up Dialog Device

Add a Pop-Up Dialog device to your project. Ensure the **Pop-Up Dialog** device is selected in the **Outliner** panel before you modify its properties.

In the **Details** panel, set the following options:

1. In the **Response** dropdown menu select **Button1**.
2. Set the **Default back button** option to **Button 1**.
3. Add **Button 1 Text**, then type **Close** in the empty field.
4. Change **Enabled During Phase** to **Gameplay Only**.
5. Scroll down to the **Modal Widget** section and select **your pop-up widget** from the **Template Override Class** dropdown menu.

For the pop-up warning that warns players about the time switch and what they can expect after the time switches, set the warning to display before the player steps on the trigger.

### Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| Pop-up Dialog | Show | Collectible Object | On Collected | The warning pop-up displays when the player collects the coin. |
|  |  |  |  |  |
