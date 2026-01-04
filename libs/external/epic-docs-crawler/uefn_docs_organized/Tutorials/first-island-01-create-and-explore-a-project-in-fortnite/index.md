# 1. Create and Explore a Project

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/first-island-01-create-and-explore-a-project-in-fortnite
> **爬取时间**: 2025-12-26T23:53:32.728464

---

Before you can set up your island in UEFN, you will need to create a project.

You'll start your project by selecting an island. For this tutorial, you'll use a blank template that has very little content. As you add content to the project, it is saved within your project.

1. Launch **UEFN**. (If the **News** window opens, close it by clicking **Let's get started!**) The **Project Browser** opens.

   If you have previously created islands in Fortnite, these will appear under your My Projects tab. If this is your first time in Fortnite, this tab will be empty.
2. Click the **Island Templates** tab, then click **Blank**.

   [![](https://dev.epicgames.com/community/api/documentation/image/9af3fa5b-fd77-4813-b73c-5d6f91ab1920?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9af3fa5b-fd77-4813-b73c-5d6f91ab1920?resizing_type=fit)
3. At the bottom of the window, you can **name** and **save** your project. The name defaults to **MyProject**, but you can name it whatever you want.

   Three things to know about naming projects:

   1. Whatever you name your project will be that project's name moving forward for all of eternity.
   2. Only use letters, underscores ( \_ ), and numbers to name it.
   3. Do not use spaces in the name.
4. Name your project.
5. Click **Create**.

   [![](https://dev.epicgames.com/community/api/documentation/image/a2488f01-b93f-45a4-8273-5cbb1a82062c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2488f01-b93f-45a4-8273-5cbb1a82062c?resizing_type=fit)

## Welcome to the Viewport

The **viewport**shows your island and the objects you place on it. At this point, it should only show the default devices.

[![](https://dev.epicgames.com/community/api/documentation/image/f1c4b28f-7478-49ba-b03d-df00bb2dc21d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f1c4b28f-7478-49ba-b03d-df00bb2dc21d?resizing_type=fit)

## Remove a Player Spawner Device

The **Player Spawner** device controls where and how a player spawns into your island. This template starts with two player spawners, but since this is going to be a single player game, you can remove one of the player spawners.

1. Select one of the **Player Spawner** devices in the viewport by clicking it. Note that the device highlights in both the viewport and the **Outliner** panel on the right.

   [![](https://dev.epicgames.com/community/api/documentation/image/46e35e90-8207-4ea4-9251-7e5dd511bbef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/46e35e90-8207-4ea4-9251-7e5dd511bbef?resizing_type=fit)
2. Press the **Delete**key on your keyboard and the spawner will be deleted.

   [![](https://dev.epicgames.com/community/api/documentation/image/97075908-6b0c-4427-b205-2cfa45e40cd4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97075908-6b0c-4427-b205-2cfa45e40cd4?resizing_type=fit)

## Save Your Project

To save, go to **File > Save Current Level**, or press **Ctrl + S**.

UEFN automatically saves your project every 15 minutes. You can change the frequency of saves by going to **Edit > Editor Preferences**.

## Change Some Island Settings

Every island in UEFN automatically includes **Island Settings** that control specific parameters for that island. The settings here are the same settings you can find in Fortnite Creative, but the presentation is more streamlined in UEFN.

These settings affect many of the rules of your game.

Since this tutorial is for a single player shooter game, you will see how to use the island settings to support that type of gameplay.

1. If the **Details** panel is not already open, go to the menu bar at the top of the viewport, click **Window**, then **Details**, then select a **Details** panel.

   [![](https://dev.epicgames.com/community/api/documentation/image/40ccc42d-e6b3-4143-b62f-2e41e2370420?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40ccc42d-e6b3-4143-b62f-2e41e2370420?resizing_type=fit)
2. Go to the **Outliner** panel and type **island settings** in the search bar.

   [![](https://dev.epicgames.com/community/api/documentation/image/7d1f283a-f3be-449b-85ec-31b54aa147a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d1f283a-f3be-449b-85ec-31b54aa147a7?resizing_type=fit)

   You can resize the Outliner panel (or other panels) for better visibility by clicking the edge of the panel and dragging to change its width or height. You can also move the panels around the editor.
3. Click **IslandSettings0 Device** to open the device’s user options in the **Details** panel below the Outliner.
4. In the **Details** panel, scroll to **Mode** and click the triangle icon to the left to expand it.
5. Click the icon next to **Structure**, then click the dropdown icon to expand.

   [![](https://dev.epicgames.com/community/api/documentation/image/d628da83-3bc7-45a0-9f95-5d46261e1b24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d628da83-3bc7-45a0-9f95-5d46261e1b24?resizing_type=fit)
6. Set **Max Players** to **1**. This limits the game to one player.
7. Find and expand **Pickups**. **Allow Item Pick Up** is checked by default. Set both **Auto Pickup Pickups** and **Auto Pickup Weapons** to **Yes**. The player will automatically pick up their weapon at game start.

   [![](https://dev.epicgames.com/community/api/documentation/image/d217df90-7352-4f5b-9f22-2a042aa009a6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d217df90-7352-4f5b-9f22-2a042aa009a6?resizing_type=fit)
8. Under **Build Mode**, set **Allow Building** to **None**. This prevents the player from building on the island.
9. Under **Inventory**, scroll down then check **Infinite Magazine Ammo**. Now the player will never run out of ammo.
10. Under **Equipment**, set **Environment Damage** to **Off**. This prevents the player from inflicting damage to anything but the targets you'll set up later.

Now you’re ready to start adding some devices to your island that equip players with weapons and targets to shoot at!

## Moving the Viewport Camera

You can navigate the viewport with your mouse, your keyboard, or a combination of the two.

- To **pan the camera horizontally**, hold either mouse button, then move the mouse right or left.
- To **move the camera forward or backward**, hold the left mouse button and move the mouse forward and backward.
- To **move the camera up or down**, hold the right mouse button and move the mouse forward and backward.
- To **zoom in and out**, use the mouse wheel.
- If you click an asset and press the **F** key, it will **focus the camera on the asset**, centering it in the viewport. To **unfocus**, left click off the asset to unselect.

The **WASD keys** give you more control over your camera movement.

To move the camera using these keys, hold either mouse button down, then press the **WASD** keys. **A** and **D** pan the camera left and right. **W** and **Z** move it up and down.

## Up Next

[![2. Place and Customize a Device](https://dev.epicgames.com/community/api/documentation/image/8ff5847b-c80c-4bc9-87b2-608dbd346117?resizing_type=fit&width=640&height=640)

2. Place and Customize a Device

Add some devices, customize them, and bind them with other devices for gameplay interactions.](https://dev.epicgames.com/documentation/en-us/fortnite/first-island-02-place-and-customize-devices-in-fortnite)
