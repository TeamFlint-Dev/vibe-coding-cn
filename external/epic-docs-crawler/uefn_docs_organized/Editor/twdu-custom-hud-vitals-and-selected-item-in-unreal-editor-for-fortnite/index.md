# TWDU Custom HUD: Vitals and Selected Item

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/twdu-custom-hud-vitals-and-selected-item-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:15:20.680889

---

The **Walking Dead Universe** (TWDU) feature set introduces user interface (UI) assets that you can add to your islands for a unique heads up display (HUD). The custom UI includes a player's vitals and their selected item. The [Walker NPC template](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-walker-npc-template-in-unreal-editor-for-fortnite) uses this design element to let players know that Walkers mean serious business!

## Access UI Assets

[![HUD Controller Device in UEFN](https://dev.epicgames.com/community/api/documentation/image/d9f42f25-9a7b-436f-acc3-e456cc1bae84?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d9f42f25-9a7b-436f-acc3-e456cc1bae84?resizing_type=fit)

HUD Controller device with attached custom widgets.

The UI assets are available in UEFN from the **Content Drawer > The Walking Dead Universe Content > UI** folder.

The UI folder contains material instances, textures, and general materials that form to create elements in the **Unreal Motion Graphics** (UMG) user widgets.

You can not copy the files in the UI folder to your project folder. You must reference the files for use. The table below describes the available UMG widgets in the **Widgets** folder.

|  |  |
| --- | --- |
| **Widget** | **Description** |
| **UW HUD EquippedInfo Block** | Element for your selected item. Includes ammo when applicable. |
| **UW HUD PlayerInfoBlock** | Element design that shows the player's health and shield. This file is connected to the UW HUD TeammateInfo widget. |
| **UW HUD TeammateInfo** | Element design that shows the health and shield for the player's teammates. |
| **UW HUD PlayersInfoStack** | Combines the player and their teammates information. |

## Set Up Vitals and Selected Item UI

To add the UI to your island, follow these steps:

1. In the **Content Drawer**, search for the **HUD Controller**, and drag the device into your island.
2. Navigate to **Content Drawer > The Walking Dead Universe Content > UI > Widgets**.
3. With the device still highlighted, select **UW HUD PlayersInfoStack**.
4. In the **Details** panel, under **User Options**, click **Advanced**, and scroll down to **Player Info Widget Override**.
5. Click the arrow icon to add the selected widget.
6. In the Widgets folder, select **UW HUD EquippedInfo Block**.
7. From the Details panel, scroll to Equipped Item Info Widget Override, and click the arrow icon to add the selected widget.
8. Click save.

[![Info Widget Override in UEFN](https://dev.epicgames.com/community/api/documentation/image/40b8c83f-77b5-41a2-89ce-76bab60acca3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40b8c83f-77b5-41a2-89ce-76bab60acca3?resizing_type=fit)

Info Widget Override

The widgets should now appear in the bottom right corner of your screen in play mode. The location causes an overlap with the text chat feature, making it not visible.

To adjust the location of the text chat, follow these steps:

1. Click the **HUD Controller** device, and navigate to the **Details** panel.
2. Scroll to **Modify Text Chat Layout**, and click the check box.
3. In the **Alignment** dropdown, click **Middle Right**.
4. In the **Anchor** dropdown, click **Center Right**.
5. Click save.

The text chat should now appear to the center right, clearing up your custom UI.

[![Modify Text Chat Override in UEFN](https://dev.epicgames.com/community/api/documentation/image/e2500cef-8dd2-45eb-a82d-057b110a5a4a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e2500cef-8dd2-45eb-a82d-057b110a5a4a?resizing_type=fit)

Modify Text Chat Override

The shield bar appears empty by default. You can place shields in the game to see how the UI will look. The custom UI does not support stamina.

To learn more about the device options, see [HUD Controller Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative). For your own custom UI, you must create widgets and connect them to the device similar to the steps above. To learn more see, [In-Game User Interfaces](https://dev.epicgames.com/documentation/en-us/fortnite/ingame-user-interfaces-in-unreal-editor-for-fortnite).

For additional in-editor practice with various UI feature examples, check out the [User Interface Feature Template](https://dev.epicgames.com/documentation/en-us/fortnite/user-interfaces-feature-template-in-unreal-editor-for-fortnite). To access the template while already in the editor, follow these steps:

1. Click **File > New/Open Project**. The Project Browser opens.
2. Click **Feature Example > User Interfaces**.
3. Create a new project.

## Up Next

Continue to learn about design elements to enhance your TWDU islands.

[![Heavy Linework Post-Process Effect](https://dev.epicgames.com/community/api/documentation/image/d657d067-52bf-445c-a413-bb8851e768ad?resizing_type=fit&width=640&height=640)

Heavy Linework Post-Process Effect

Add a comic book look to your The Walking Dead Universe island with the Heavy Linework post-process effect.](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-heavy-linework-post-process-effect-in-unreal-editor-for-fortnite)
