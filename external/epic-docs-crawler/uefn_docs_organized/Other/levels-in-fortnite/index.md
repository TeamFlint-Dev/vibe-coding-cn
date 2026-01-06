# Levels

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/levels-in-fortnite
> **爬取时间**: 2025-12-26T23:21:12.235617

---

A great feature of Unreal Editor for Fortnite (UEFN) is the option to create multiple [levels](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#level) within a single [project](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#project). Adding multiple levels to a project provides a way to prototype your game design and development ideas by creating a secondary (or more) blank environment where you can create Verse devices, [graybox](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#grayboxing) designs, and more.

Additional levels in UEFN are assets and should not be confused with how Unreal Engine uses levels. You cannot link levels within the project to create a multi-level island, and you cannot link them to projects created in Unreal Engine. Only one level can be the **Default Map** in a UEFN project.

Creating a level in UEFN means:

- A new blank level is available from the Content Browser.
- The level can only be accessed by opening the project.
- Levels can be promoted within the project to become the Default Map.

There several things to consider when adding a level to your project:

- Levels can be duplicated, this provides a way for you to prototype a game mechanic or Verse device in the new level without breaking your main level.
- Additional levels contribute to the overall size of your project, so be sure to delete the extra levels before you publish your island.
- Creating a new level inside a project that uses an island template results in a completely blank level. You’ll need to create your own landscape in the new level.

## Create a New Level

Although you can’t link levels to create a multi-island experience, you can use additional levels to prove your game concepts without adding Verse devices, imported assets, and more to the Default Map. Here are a few ways to add a level to your project.

### From the File Menu

1. Click **File** to open the File menu options.
2. Select one of the following options from the File menu.

   - **New Level**

     [![](https://dev.epicgames.com/community/api/documentation/image/411d7f3e-3e91-4e61-b2f0-6cfc5f9694c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/411d7f3e-3e91-4e61-b2f0-6cfc5f9694c7?resizing_type=fit)

     Click to enlarge image.
   - **New Level From Island**

     [![](https://dev.epicgames.com/community/api/documentation/image/0385f9cd-9ad1-4ac2-bb2b-0c89def4329d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0385f9cd-9ad1-4ac2-bb2b-0c89def4329d?resizing_type=fit)

     Click to enlarge image.

   A new level thumbnail appears in the Asset View.
3. You are prompted to name the new level.

### From the Content Browser

1. Inside the Content Browser’s **Asset View**, right-click to open the **context menu**.

   [![](https://dev.epicgames.com/community/api/documentation/image/f3d67747-86e7-4217-81d3-730710e4ed00?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f3d67747-86e7-4217-81d3-730710e4ed00?resizing_type=fit)

   Click to enlarge image.
2. Select **Level** from the context menu. A new level thumbnail appears in the Asset View.
3. You are prompted to name the new level.

If you’re testing out a concept it’s helpful to name the additional level after the concept. For example, **Graybox\_Ideas**.

### Duplicate a Level

Another way to create a new level is to duplicate an existing one. Duplicating a level provides a way to explore ideas in gameplay, level design, and more without breaking the original. This workflow only works if the level being duplicated is not currently open in the viewport.

If you only have one level and want to duplicate it, you need to create a temporary second level you can switch to. You can then keep it or delete it once duplication is complete.

To duplicate a level, follow these steps.

1. From the **Content Browser**, open a level that you do not want to duplicate. In the image below, the level labeled **A** is the level open in the viewport. The level labeled **B** is the level to be duplicated.

   [![](https://dev.epicgames.com/community/api/documentation/image/711d13fc-c82e-4b50-b541-84e2be870dea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/711d13fc-c82e-4b50-b541-84e2be870dea?resizing_type=fit)
2. In the asset view, right-click the **level thumbnail** to open the context menu.
3. Select **Duplicate** from the dropdown menu. The level duplicates in the Content Browser.

   [![](https://dev.epicgames.com/community/api/documentation/image/913a9a7a-3a39-493e-8b47-0f3cc09e6796?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/913a9a7a-3a39-493e-8b47-0f3cc09e6796?resizing_type=fit)
4. You are prompted to rename the new level.

The duplicated level contains all the same content as the original.

## Open a Level

There are a few ways you can open a level in your project.

### From the File Menu

Inside an open project, you can use the **File menu** to open a new level. To open a level follow these steps.

- Select **File** > **Open Level**. A window appears with all the levels you've created within this project. Select a level and it will open in the [viewport](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#viewport). This will also cause the currently open level to save and close.

  [![](https://dev.epicgames.com/community/api/documentation/image/50de8101-7df3-4ee2-9c7d-01deeb151a43?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/50de8101-7df3-4ee2-9c7d-01deeb151a43?resizing_type=fit)

- Select **File** > **Recent Levels**. Select the arrow to select from the list of recent levels you were working on.

### From the Content Browser

To open a level inside the Asset View, follow these steps.

1. Navigate to the **Asset View** in the **Content Browser**.
2. Double-click the **level thumbnail** from the project’s main folder in the Content Browser.

## Promote a Level

If one of the project levels becomes the one you want to publish, you can promote that level to **Default Map** status in **GameFeatureData**. Promoting a level means:

- The level becomes publishable.
- The level opens when you open the project.

To promote a level, follow these steps.

1. Double click the **GameFeatureData** thumbnail. The GameFeatureData window opens.

   [![](https://dev.epicgames.com/community/api/documentation/image/512d8844-1a14-4479-af4e-b8a5e5cd60fc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/512d8844-1a14-4479-af4e-b8a5e5cd60fc?resizing_type=fit)

   Click to enlarge image.
2. Select the Default Map dropdown menu and select the level to promote from the list. The level automatically becomes the default map.

   [![](https://dev.epicgames.com/community/api/documentation/image/8b87bafe-4c47-457d-a006-b82059221173?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b87bafe-4c47-457d-a006-b82059221173?resizing_type=fit)

## Map Data

Map Data refers to the multiple levels within the project. All levels you create within a project can be added to the **MapData array**. Multiple test levels drastically increase the package size of your project, which makes your project less performant and can create memory issues when you’re ready to publish.

[![](https://dev.epicgames.com/community/api/documentation/image/c128c434-2e3d-4423-b8b6-4afba0340350?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c128c434-2e3d-4423-b8b6-4afba0340350?resizing_type=fit)

This option provides a way for you to ensure all project data is cooked and distributed to the server at runtime and removes references to additional levels that have been deleted from the project.

### Remove Level References and Delete Levels

To remove references to additional levels, do the following:

1. Click the **+ icon** to open the additional level list.
2. Select a level to add it to the **MapData array**.

   [![](https://dev.epicgames.com/community/api/documentation/image/2752fd68-b44c-40fb-aba3-b31d78c501b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2752fd68-b44c-40fb-aba3-b31d78c501b1?resizing_type=fit)
3. Select the **trash icon** on **MapData**. Now you can delete the additional levels from the Content Browser.

   ![](https://dev.epicgames.com/community/api/documentation/image/0ff775a1-312c-49b0-8166-063ff88a8eee?resizing_type=fit)
4. Select the **extra level thumbnail** in the Content Browser to highlight it.
5. Right-click in the **Content Browser** to open the context menu, then select **Delete** from the list of options. A pop-up warning will appear.
6. Select **Force Delete** from the pop-up window. The level is deleted from the project.

This task takes some time to complete.

The level data is removed from the project and no longer contributes to the overall size of the project.

## Additional Level Information

The following is important information about working in a project with multiple levels.

- A new level doesn’t open automatically when the project is selected from the Project Browser.
- There is no limit to the number of levels you can add to a project.
- Team members can work in different levels within the project without blocking one another.
- On rare occasions a whole level may be blocked from editing when a team member is working in the level.
- Editing Scene Graph entities in a level will lock that level from teammembers because Scene Graph doesn’t support one file per actor.
- Editing props, devices, Island settings, and more should be fine as they support one file per actor.
