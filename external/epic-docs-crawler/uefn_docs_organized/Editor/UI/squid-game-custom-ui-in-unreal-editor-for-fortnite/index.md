# Squid Game Custom UI

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-custom-ui-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:13:05.065316

---

You can set the tone of your **Squid Game** islands with branded user interface (UI). Both the [Minigame Mastery](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-minigame-mastery-template-in-unreal-editor-for-fortnite) and [Social Deduction](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-social-deduction-template-in-unreal-editor-for-fortnite) templates feature the custom UI.

[![Squid Game Squid Game HUD in UEFN](https://dev.epicgames.com/community/api/documentation/image/12bbb621-8a0d-4232-bad5-788d7caae5e7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12bbb621-8a0d-4232-bad5-788d7caae5e7?resizing_type=fit)

Squid Game HUD

## Access UI Assets

The UI assets are available in UEFN from the **Content Drawer > All > Squid Game > UI** folder.

The UI folder contains material instances, textures, and general materials that form to create elements in the **Unreal Motion Graphics** (UMG) user widgets.

You can not copy the files in the UI folder to your project folder. You must reference the files for use.

The table below describes the available UMG widgets in the **Widgets** folder.

| Widget | Description |
| --- | --- |
| **UW HUD EquippedInfoBlock** | Element for your selected item. Includes ammo when applicable. |
| **UW HUD PlayersInfoStack** | Combines the player and their teammates' information. It references the following widgets:   - **UW HUD PlayerInfoBlock:** Element design that shows the player's health and shield. - **UW HUD TeammateInfo:** Element design that shows the health and shield for the player's teammates. |
| **UW HUD QuickbarSlot** | Element design for your inventory UI. |

## Set Up Vitals and Selected Item UI

To add the UI to your island, follow these steps:

1. In the **Content Drawer**, search for the **HUD Controller** device, and drag the device into your island.
2. Navigate to **Content Drawer > All > Squid Game > UI > Widgets**.
3. With the device still highlighted, select **UW HUD PlayersInfoStack**.
4. In the **Details** panel, under **User Options**, click **Advanced**, and scroll down to **Player Info Widget Override**.
5. Click the arrow icon to add the selected widget.
6. In the **Widgets** folder, select **UW HUD EquippedInfoBlock**.
7. From the **Details** panel, scroll to **Equipped Item Info Widget Override**, and click the arrow icon to add the selected widget.
8. Click **Save**.

[![Squid Game UI](https://dev.epicgames.com/community/api/documentation/image/a44750f2-f2b8-4372-88ec-901a3591a2cd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a44750f2-f2b8-4372-88ec-901a3591a2cd?resizing_type=fit)

Widget Override

The widgets should now appear in the bottom right corner of your screen when in play mode. **Text Chat** appears briefly over the Player Vitals UI. If you would like to move it, you can adjust the location by following these steps:

1. Click the **HUD Controller** device, and navigate to the **Details** panel.
2. Scroll to **Modify Text Chat Layout**, and click the check box.
3. In the **Alignment** dropdown, click **Middle Right**.
4. In the **Anchor** dropdown, click **Center Right**.
5. Click **Save**.

The text chat should now appear to the center right, clearing up your custom UI.

[![](https://dev.epicgames.com/community/api/documentation/image/8fbf0c20-edc9-4f71-a3f6-7cb103409dcb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8fbf0c20-edc9-4f71-a3f6-7cb103409dcb?resizing_type=fit)

Text Chat Layout

The shield bar appears empty by default. You can place shields in the game to see how the UI will look. The custom UI does not support stamina.

## Add a Custom Inventory Bar

Complete the UI look with a design update to the quickbar slots.

[![Squid Game UI Quickbar Slots in UEFN](https://dev.epicgames.com/community/api/documentation/image/5b2442bc-2aa7-43da-9346-f9d38645915b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5b2442bc-2aa7-43da-9346-f9d38645915b?resizing_type=fit)

UI Quickbar Slots

To add the UI to your island, follow these steps:

1. Click the **HUD Controller** device.
2. Navigate to **Content Drawer > Squid Game > UI > Widgets**.
3. With the device still highlighted, select **UW HUD QuickbarSlot**.
4. In the **Details** panel, under **User Options**, click **Advanced**, and scroll down to **Quickbar Slot Widget Override Class**.
5. Click the arrow icon to the right to add the selected widget.
6. Click **Save**.

[![Squid GAME Quickbar Settings in UEFN](https://dev.epicgames.com/community/api/documentation/image/6b6835db-6dde-4662-9632-519afb407887?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b6835db-6dde-4662-9632-519afb407887?resizing_type=fit)

Quickbar Settings

To learn more about the device options, see [HUD Controller Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative). For your own custom UI, you must create widgets and connect them to the device similar to the steps above. To learn more see, [In-Game User Interfaces](https://dev.epicgames.com/documentation/en-us/fortnite/ingame-user-interfaces-in-unreal-editor-for-fortnite).

For additional in-editor practice with various UI feature examples, check out the [User Interface Feature Template](https://dev.epicgames.com/documentation/en-us/fortnite/user-interfaces-feature-template-in-unreal-editor-for-fortnite).

To access the template while already in the editor, follow these steps:

1. Click **File > New/Open Project**. The **Project Browser** opens.
2. Click **Feature Example > User Interfaces**.
3. Create a new project.

## Creating Anonymous Gameplay

Add anonymity to your island by adjusting the HUD to encourage deception and betrayal. The following are examples of adjusting the HUD:

- Use the [HUD Controller](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative) device to hide elements like the minimap and team information.
- Hide nameplates that are on by default in the [island settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite).
- Further adjust the display of nameplates with the [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative) device.
