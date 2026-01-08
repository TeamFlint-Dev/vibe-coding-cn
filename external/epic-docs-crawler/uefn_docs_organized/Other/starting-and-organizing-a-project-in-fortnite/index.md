# Starting and Organizing a Project

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/starting-and-organizing-a-project-in-fortnite>
> **爬取时间**: 2025-12-26T23:21:06.833365

---

In this guide, you’ll learn how to create and launch a project in **Unreal Editor for Fortnite (UEFN)**.

**You'll also get some** organizational tips and tricks to set yourself up for success. Whether you work as part of a team or on your own, these tips are industry standards that can help you build and develop your island more efficiently.

## Create a Project

To create a project, you’ll launch the editor and create a project by selecting an island to start with. As you add content to the project, it is saved within your project.

Best approaches for starting a new project include:

- Sketching out your ideas on paper or digitally.
- Creating wireframes for [assets](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#asset) you intend to import.
- Working out your game logic, or how project assets should look and interact with other assets.

Launching UEFN opens the Project Browser directly unless you check **Open last project on start up** to automatically open the project you’re currently working on.

1. Launch **UEFN**. (If the **News** window opens, close it by clicking **Let's get started!**) The **Project Browser** opens.

   If you have previously created islands in Fortnite, these will appear under your **My Projects** tab. If this is your first time in Fortnite, this tab will be empty.
2. Click the **Island Templates** tab, then click **Blank** to open an empty island.

   [![](https://dev.epicgames.com/community/api/documentation/image/8ffc4663-9e88-456e-ae6f-671a1401879a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ffc4663-9e88-456e-ae6f-671a1401879a?resizing_type=fit)
3. At the bottom of the window, you can **name** and **save** your project. The name defaults to **MyProject**, but you can name it whatever you want.

   Three things to know about naming projects:

   1. Whatever you name your project will be that project's name moving forward for all of eternity.
   2. Only use letters, underscores ( \_ ), and numbers to name it.
   3. Do not use spaces in the name.
4. Name your project.
5. Click **Create**.

   [![](https://dev.epicgames.com/community/api/documentation/image/7661f79f-24c8-41b8-8d52-5b80a8a30f15?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7661f79f-24c8-41b8-8d52-5b80a8a30f15?resizing_type=fit)

You can also create a new project from an open project:

- From the **File** menu, select **New / Open Project**.

  [![](https://dev.epicgames.com/community/api/documentation/image/1601e14a-763b-439d-92f8-9d08b89b39f9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1601e14a-763b-439d-92f8-9d08b89b39f9?resizing_type=fit)

  Click to enlarge image.
- From the **Project** menu select **New / Open Project**.

  [![](https://dev.epicgames.com/community/api/documentation/image/92ee4648-7cc2-4a03-864d-4cf09b4b42c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/92ee4648-7cc2-4a03-864d-4cf09b4b42c4?resizing_type=fit)

  Click to enlarge image.

### Templates

Templates make creating a [project](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#project) straightforward, whether you start from an empty island [level](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#level) or fully populated tutorial.

Templates are made to be customizable. You can edit the terrain, delete objects and assets you don’t want, and add content and assets the template doesn’t contain natively. All templates contain these common elements:

- Fortnite player spawn(s)
- Level boundaries that mark the edges of the level
- Time-of-day settings
- Island Settings device

Choose from the following template groups:

[![](https://dev.epicgames.com/community/api/documentation/image/7b6bf435-583b-4adc-af12-7c3937a16543?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7b6bf435-583b-4adc-af12-7c3937a16543?resizing_type=fit)

Click to enlarge image.

- **Island Templates** - A series of templates that include:

  - A blank template where you'll build everything.
  - Islands based on Fortnite Battle Royale map destinations. These include [prefabs](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prefab) or assets that you can add, move, delete, or modify.
  - Terrain-specific islands with no prefabs or assets.
- **Brand Templates** - A series of [branded templates](https://dev.epicgames.com/documentation/en-us/fortnite/game-collections-in-fortnite) that includes:

  - Fortnite blank template islands.
  - Brand-specific assets, like LEGO® or some other IP that you can only use with a specific template.
- **Feature Examples** - Templates that help you learn how to use different UEFN features and systems, and the [Verse](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#verse) programming language.

## Project Organization

Setting up your project correctly from the start in UEFN can save you aggravation later.

The organization process starts as soon as you create your project and open it in the editor.

Knowing how to set up a project in UEFN will help you better understand how to use the default features of the editor and how it can benefit your project.

The best approach for organizing a new project includes:

- Establishing and using consistent naming conventions for [levels](https://dev.epicgames.com/documentation/en-us/fortnite/levels-in-fortnite), [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop), [devices](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#device), and so on.
- Deciding how to version asset names when iterating on an asset.
- Using nested folders to store and share files inside UEFN.
- Grouping devices and actors together according to where on the island they’re located and what their function is.
- Color coding folders to keep your organization efforts consistent.

The important thing with naming conventions is to be consistent.

[![](https://dev.epicgames.com/community/api/documentation/image/0fab8084-a38c-4ad4-b05a-c6432a5229b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0fab8084-a38c-4ad4-b05a-c6432a5229b7?resizing_type=fit)

To put these practices in place, you should get to know each section of the editor and how it can be used. See the **[User Interface Reference](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite)** document to learn more about UEFN.

### Use Standard Naming Conventions

Working in game development means working with large numbers of assets in your projects. Following game industry naming conventions is a best practice that’s good to implement early on. This helps you locate assets quickly, which is essential for team collaboration.

Naming conventions typically follow these setups:

- **Asset Type Prefix** - Identifies the type of asset, for example MI\_ for material instance.
- **Asset Name** - The name given to the asset.
- **Descriptor** - Provides context for the asset. For example, if you have a texture that is a normal map, the name would be **T\_WoodenBox\_N**.
- **Optional Variant Number or Letter** - This is used when there is more than one version of an asset. For example, **MI\_Cube\_2**.

Naming conventions improve development efficiency by:

- Categorizing all project assets.
- Tracking different versions of an asset.
- Setting a standard within a project and the project's team.

When naming your assets, do not use spaces between words. You’ll need to decide on the style of naming convention to use. Common naming conventions for files and assets include **snake case** and **camel case**.

#### Snake Case

With snake case, the first letter of each name or part of a name starts with a lower case letter, and the words are separated with underscores to join all of the words in the name. For example: **mi\_userinterface\_background**.

Snake case improves the readability and maintains consistency when creating multi-word identifiers for assets.

#### Camel Case

Camel case combines multiple words by capitalizing the first letter of each word and separates the words using an underscore.

Camel case is another way to improve readability and maintain consistency when creating multi-word identifiers for assets.

In UEFN, camel case is used to name assets. For example: **MI\_UserInterface\_Background**.

### Use Folder Structures

Folder structures also help to organize your project assets.

When you use a consistent folder heirarchy, with similar assets grouped together, it's fast and easy to find an asset when you need to select or edit it.

[![](https://dev.epicgames.com/community/api/documentation/image/9f52e9a3-7b8f-4b99-a7f0-fb8f49c2c328?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f52e9a3-7b8f-4b99-a7f0-fb8f49c2c328?resizing_type=fit)

Click to enlarge image.

It’s best to organize and name your folder structure by:

1. **Content Type** - The category of the assets inside the folder, such as Materials or User Interfaces.

   [![](https://dev.epicgames.com/community/api/documentation/image/1b381f39-2689-4e99-9672-76684b5e851f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1b381f39-2689-4e99-9672-76684b5e851f?resizing_type=fit)
2. **Asset Type** - The type of assets in the sub-folder, such as widgets or level sequences. (Sometimes this folder is the parent folder.)
3. **Asset Use** - How the asset is to be used. You will rarely need to go three levels deep, but if you do, it works well to identify assets by their use in the project in that third nested folder. For instance, you could have a user interface folder and inside that folder, a sub-folder named Materials. Inside the Materials folder you might have the different materials split up by their use, such as Progress\_Bar or Icons.

## Content Browser Setup

The **[Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-browser)** is a useful feature of the editor. All of your project assets accumulate in the browser, whether or not they’ve been added to the viewport.

Following are more tips for the content browser.

- **Create parent folders** - Parent folders provide a way to organize all your assets. This means grouping assets by their basic structure. For instance; User Interfaces, Materials, Verse Devices, Meshes, and so on.
- **Project setup** - Make sure the content is properly configured to recognize asset paths. This ensures that the content browser can locate your assets.
- **Using multiple content browsers** - This is most helpful when you’re set-dressing your island. You can have up to five browsers open at one time.
- **Using the Content Drawer** - Placing the folders you use the most in the [Content Drawer](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-drawer) puts them at the top of the [Sources panel](https://dev.epicgames.com/documentation/en-us/unreal-engine/content-browser-interface-in-unreal-engine?application_version=5.5) and saves you from having to search for a folder.
- **Create asset libraries** - Organize and share assets within a project or across multiple projects.
- **Local vs shared folders** - Decide whether to share assets in a team workspace or keep a local file for your project's assets. Shared workspaces are useful for teams, while local workspaces are suitable for individual projects and edits.
- **Use content browser filters** - Quickly locate an asset or types of assets by using the search bar for quick filtering.
- **Add asset folders to Favorites** - Favoriting folders in the Source Panel and adding commonly used folders to your favorites list eliminates the need to search for them in the content browser.

## Outliner Setup and Organization

All of the assets you place in the viewport are listed in the **[Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#outliner-panel)** under their filenames. Like the Content Browser, you can create folders in the Outliner as well. Using a nested folder system in the Outliner helps to declutter the Outliner list, and provides a way to quickly find assets you want to edit.

- **Parent and child folders** - Name a parent folder after a section of your island, then create child folders for the different assets in that island section, such as prefabs, props, and devices.

  This is an industry organization method that helps developers find and edit their assets more efficiently.

- **Close folders** - Close any folders you are not currently working on so you can focus on the files you are using.

- **Rename assets** - If you have multiple assets of the same type, you can rename them using the Outliner’s right-click menu.

  The editor automatically assigns duplicated assets a number when you duplicate them or pull multiples into the viewport.

- **Hide or reveal assets** - This helps with visualization and concentration. Hide assets when you don’t need set dressing, or hide devices in the viewport as you work. Afterward, reveal the hidden assets again.

  If you forget to reveal your assets, once you save and log out of the project, they’ll automatically be revealed the next time you log into that project.

- **Group like assets together** - Grouping assets, whether in a folder or by category, is more efficient for editing in the Details panel.

  Grouping assets can also be done from the main menu bar, under **Select**. For more information, see the **[User Interface Reference](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite)** document.

For more information on working in the Outliner, see **[Outliner Tips and Tricks](https://dev.epicgames.com/documentation/en-us/fortnite/outliner-tips-and-tricks-in-unreal-editor-for-fortnite)**.
