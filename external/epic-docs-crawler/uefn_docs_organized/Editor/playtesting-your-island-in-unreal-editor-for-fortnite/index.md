# Playtesting Your Island

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/playtesting-your-island-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T22:55:00.764006

---

As you create your game or experience in UEFN, it's a good idea to routinely [playtest](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#playtest) your project in Fortnite Creative to make sure the [props](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#prop), [materials](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#material), and [devices](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#device) behave exactly as you intended when you set them up in the editor.

This is also a necessary step before [publishing your project](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-projects-in-unreal-editor-for-fortnite).

Playtesting in Unreal Editor for Fortnite (UEFN) is comparable to the Unreal Engine **Play In Editor** function, but instead of opening in the editor, your level is uploaded to the [content service](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-service) and run in an [instance](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#instance) of the Fortnite game [client](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#client).

UEFN also provides a way for you to playtest Verse devices and test your project on console.

When you're ready to test, press the **Launch Session** button.

[![The Play button starts a Fortnite Creative client where you can playtest your project](https://dev.epicgames.com/community/api/documentation/image/120df1fd-b949-4e74-a0ea-a9ba016fdc2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/120df1fd-b949-4e74-a0ea-a9ba016fdc2e?resizing_type=fit)

The icon will indicate that the [level](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#level) is uploading. Note that it may take several minutes for the level to load.

[![The button switches from Play to Uploading while your project loads into the Fortnite creative client](https://dev.epicgames.com/community/api/documentation/image/276454aa-1468-4668-bed3-0f74f185b9b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/276454aa-1468-4668-bed3-0f74f185b9b7?resizing_type=fit)

While Fortnite Creative is importing your level from UEFN, you will see a loading screen:

[![The loading screen appears as your playset is ported over to Fortnite Creative](https://dev.epicgames.com/community/api/documentation/image/577f432f-46fa-4017-8062-7dc3e5766a7a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/577f432f-46fa-4017-8062-7dc3e5766a7a?resizing_type=fit)

The loading screen displays artwork from the current Fortnite Battle Royale season. The loading screen you see will be different from the one pictured above.

When the server finishes loading the island, a [character](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#character) will spawn in your test level.

[![The Office playset uploads into Fortnite Creative](https://dev.epicgames.com/community/api/documentation/image/8df557ef-bfad-422a-af7f-7bd4c765f4ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8df557ef-bfad-422a-af7f-7bd4c765f4ff?resizing_type=fit)

## Playtest Verse Devices

When your code finishes compiling, the options **Push Changes** and **Push Verse Changes** appear in the UEFN toolbar.

**Push Changes** updates your client with all changes made in the editor, such as adding and removing props, modifying object properties, and any changes made to Verse code.

**Push Verse Changes** only updates your Verse code, and is faster than Push Changes. This is helpful in situations where you want to make small, incremental changes to your code without refreshing your session. Click **Push Verse Changes** to update your client.

After making changes to a Verse device in the level click **Push Changes**. This updates the device and makes any new changes playable. Clicking **Push Verse Changes** only picks up and pushes the .verse file changes.

[![Push Verse Changes is how you push changes to your Verse code.](https://dev.epicgames.com/community/api/documentation/image/c3eb4b20-0c48-4de2-b157-772976b5bd75?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c3eb4b20-0c48-4de2-b157-772976b5bd75?resizing_type=fit)

## Playtest on Console

Playtest your island on console to test your game mechanics and visual design on a different platform to ensure players have the game experience you envision.

Click the three dots next to **Launch Session** to open the Session Options dropdown menu.

Select **Connect To Platform**, the click **Launch Session**. This launches the Live Edit session on console instead of PC.

[![Playtest your island on console by selecting Connect to Platform.](https://dev.epicgames.com/community/api/documentation/image/4ff3742d-6b42-488e-8d9f-d7b336700c3f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4ff3742d-6b42-488e-8d9f-d7b336700c3f?resizing_type=fit)

## Performance Checklist

- Confirm that all your props are visible and are [rendering](unreal-editor-for-fortnite-glossary#render) correctly.
- Confirm that [collision](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#collision) is behaving as expected.
- Confirm that props can be destroyed, and that they deliver the expected [resource drop](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#resource-drop). Note that a prop without collision will not drop [resources](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#resource).
- Confirm that device properties in Creative appear as set in UEFN.
- Make sure your game runs as expected from start to finish.

## Live Edit

Should you find something while playtesting that needs editing from the editor, click **End Game** in UEFN to stop the game in the client and return to editing mode.

[![Clicking the End Game button stops the game.](https://dev.epicgames.com/community/api/documentation/image/f01b1c09-bf8b-47af-953a-0057a266d972?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f01b1c09-bf8b-47af-953a-0057a266d972?resizing_type=fit)

During playtesting, there is a live connection between UEFN and the game client. Any changes you make in the editor [viewport](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#viewport) will immediately show in the client.

[![A live link is established between UEFN and the Fortnite Creative client](https://dev.epicgames.com/community/api/documentation/image/656f0164-a9de-4763-8129-4191b4192028?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/656f0164-a9de-4763-8129-4191b4192028?resizing_type=fit)

*Left: UEFN window. Right: Fortnite game client window.*

Press **Alt + Tab** to shift mouse control from the game client back to the editor.

Drag a new element into the scene from the Content Browser and it will immediately appear [in-game](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#in-game).

Click the **Push Changes** button in the toolbar to re-upload your level to the content service.

[![The Start Game button has a Push Changes button when your project is loaded into the Fortnite Creative client](https://dev.epicgames.com/community/api/documentation/image/79049838-d91c-4b29-8db5-02ee53381f85?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/79049838-d91c-4b29-8db5-02ee53381f85?resizing_type=fit)

## Start Game

There are three ways to start a game in Fortnite Creative:

1. Press **Esc** while in the client, and start the game from the [Main Menu](https://dev.epicgames.com/documentation/en-us/fortnite-creative/exploring-the-sidebar-and-game-menu-in-fortnite-creative).
2. Select **My Island** from the Main Menu, and start the game from here after having taken another look at your level’s settings.

   [![The different ways to start a game in Fortnite Creative](https://dev.epicgames.com/community/api/documentation/image/55395e50-9555-4979-a3b0-315c18300a1e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/55395e50-9555-4979-a3b0-315c18300a1e?resizing_type=fit)
3. Press **Start Game** from UEFN.

In the **My Island** menu, double-check the **Game**, **Settings** and **UI** tabs to make sure the Island Settings you modified in the editor were accurately captured.
