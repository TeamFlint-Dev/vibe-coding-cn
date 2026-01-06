# User Interface Reference

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:00:56.756528

---

**Unreal Editor for Fortnite**, or **UEFN** for short, is a suite of editing tools powered by [**Unreal Engine**](unreal-editor-for-fortnite-glossary#unreal-engine) you can use to create and edit [props](unreal-editor-for-fortnite-glossary#prop) and [devices](unreal-editor-for-fortnite-glossary#device).

[![The main user interface for Unreal Editor for Fortnite](https://dev.epicgames.com/community/api/documentation/image/f89125ac-ac9d-4339-ab2c-c92f47354250?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f89125ac-ac9d-4339-ab2c-c92f47354250?resizing_type=fit)

Click image to enlarge.

1. [Menu Bar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite)
2. [Toolbar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#level-editor-toolbar)
3. [Viewport](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#viewport)
4. [Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#outliner)
5. [Details panel, World Settings, and World Partition](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite)
6. [Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite)
7. [Output Log](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#output-log)
8. [Unreal Revision Control](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#unreal-revision-control)
9. [Island Settings Device](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#island-settings)

## Menu Bar

All editors in UEFN have a menu bar located in the top-left corner of the editor window. Most menus provide access to basic tasks in UEFN like saving, editing, and much more. Other menu bars are more editor-specific .

[![The menu bar in UEFN](https://dev.epicgames.com/community/api/documentation/image/ca44551b-119d-4f60-ad1a-8e4c59120913?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ca44551b-119d-4f60-ad1a-8e4c59120913?resizing_type=fit)

Click image to enlarge.

The options for the menu bar in UEFN include the following:

### File

| Command | Description |
| --- | --- |
| **New Level...** | Create a new level from a template in this project. |
| **Open Level...** | Open an existing level in the current project. |
| **Recent Levels** | Select from a list of levels in your project. |
| **New Level From Island...** | Creates a new level from an existing island. |
| **Recent Assets** | Open a list of recently selected assets. |
| **Save Current Level** | Save the current level. |
| **Save Current Level As...** | Save the level in your project folder under a different name. |
| **Save All** | Save all unsaved levels and assets. |
| **Choose Files to Save** | Open a dialog with save options for content and levels. |
| **New/Open Project...** | Open a dialog where you can either create a new project or select from available projects. |
| **Exit** | Exit the application. |

### Edit

| Command | Description |
| --- | --- |
| **Undo** | Undo the last action. |
| **Redo** | Redo an action that was undone. |
| **Undo History** | View the entire undo history. |
| **Cut** | Cut the selected object. |
| **Copy** | Copy the selected object. |
| **Paste** | Paste the contents of the clipboard (which holds what you have cut or copied). |
| **Duplicate** | Duplicate the selected object. |
| **Delete** | Delete the selected object. |
| **Editor Preferences** | Configure the behavior and features of the editor. |

### Window

| Command | Description |
| --- | --- |
| **Cinematics** | Open a menu of cinematic options for [Sequencer](https://dev.epicgames.com/documentation/en-us/fortnite/sequencer), [Take Recorder](https://dev.epicgames.com/documentation/en-us/unreal-engine/BlueprintAPI/VirtualCamera/TakeRecorder?application_version=5.5), and Takes Browser. |
| **Content Browser** | Open additional Content Browser windows. |
| **Details** | Open additional Details panels to edit properties. |
| **Outliner** | Open additional Outliner panels to organize and group objects. |
| **Viewports** | Open additional viewports and select which viewport window to work in. |
| **World Partition** | Open a list of options that provide a way to open the World Partition Editor and Data. |
| **Place Actors** | Open the Actors panel. |
| **World Settings** | Open the World Settings panel |
| **Message Log** | Open the Message Log in a new window. |
| **Output Log** | Open the Output Log panel. |
| **Notes** | Open the Notes panel. Notes contain messages left by team members or project owners on the project development. |
| **Fab** | Opens [Fab](https://dev.epicgames.com/documentation/en-us/fab/fab-documentation) in a window. Fab is Epic's open marketplace that gives all digital content creators a single destination to discover, share, buy, and sell digital assets. |
| **MetaHuman Importer** | Launches the [MetaHuman](https://dev.epicgames.com/documentation/en-us/fortnite/realistic-assets-characters-and-environments-in-unreal-editor-for-fortnite) importer tool. |
| **Load Layout** | Load an editor layout configuration from disk. Dropdown option:   - **Import Layout** - Selecting Import Layout allows you to import different files saved to disk. |
| **Save Layout** | Save your current editor layout configuration to your local disk. Dropdown options:   - **Save Layout As** - **Export Layout** |
| **Remove Layout** | Remove a layout configuration from disk. Dropdown option:   - **Remove All User Layouts** |
| **Enable Fullscreen** | Click to toggle between UEFN full screen view and your PC application bar view. |

### Tools

| Command | Description |
| --- | --- |
| **Capture Manager** | Opens the [MetaHuman motion capture and animation tool](https://youtu.be/WWLF-a68-CE?t=121) . |
| **Project Size** | Provide information about the size of your project in megabytes (MB). |
| **Spatial Profiler** | Open the [Spatial Profiler](https://dev.epicgames.com/documentation/en-us/fortnite/spatial-profiler-in-unreal-editor-for-fortnite) tool. |
| **Debug** | Open a debug tool from the list. |
| **Audit** | Provide data about the lighting, textures, and primitives on your island. |
| **Open Snapshot History** | Opens a dialog displaying the Snapshot changelist history for the project. |
| **Check Out Modified Files** | Opens a dialog to check-out any assets that have been modified. |
| **Change Revision Control Settings** | Open the revision control options window to change revision control settings. |
| **Live Link Hub** | Launches [Live Link Hub](https://dev.epicgames.com/documentation/en-us/fortnite/using-livelink-hub-in-unreal-editor-for-fortnite). |

### Verse

| Command | Description |
| --- | --- |
| **Build Verse Code** | Build all Verse code in the project and check for errors. |
| **Verse Build Message Log** | Open a log with information about the status of your Verse code. |
| **Verse Explorer** | Explore and manage your Verse project to add, remove, and manage files. These options can be accessed by right-clicking. |
| **Open project in VS Code** | Open your current Verse project in Visual Studio Code. |

### Build

| Command | Description |
| --- | --- |
| **Build HLODs** | Build the hierarchical level of detail for your project. |
| **Build World Partition Editor Minimap** | Generates a [high fidelity minimap](https://dev.epicgames.com/documentation/en-us/fortnite/streaming-and-hlods-in-unreal-editor-for-fortnite)  during your editor session. |
| **Build Landscape** | Build the grass map and physical materials when assets change. It can be handy if there are "holes" in the workflow (for example a waterbody not updating properly in the landscape, it will remerge everything). |
| **Export Localization** | Export the localized text within this project so that it can be translated. |
| **Build Auto Localization** | Automatically translates all text within your project into the languages you select. |

## Select

| Command | Description |
| --- | --- |
| **Select All** | Select all actors. |
| **Unselect All** | Unselect all actors. |
| **Invert Selection** | Invert the current selection. |
| **Hierarchy** | Open options for:   - **Select Immediate Children:** Select the immediate children of the current selection. - Select All Descendants:  Select all the descendants of the current selection. |
| **All Same Classes** | Open options for   - **Select Matching (Selected Classes):** Select all actors with the same static mesh and actor class as the selected. - **Select Matching (All Classes):**  Select all actors with the same static mesh as the selected. |
| **Lights** | Open options for:   - **Select Relevant Lights:**  Select all lights relevant to the current selection. - **Select Stationary Lights Exceeding Overlap:** Select lights that exceed the overlap limit. |
| **Materials** | Open **With Same Material** to select all actors with the same material as the selected. |
| **Skeletal Meshes** | Open the following options:   - **Select All Using Selected Skeletal Meshes (Selected Actor Types) :** Select all actors with the same skeletal mesh and actor class as the selected. - Select All Using Selected Skeletal Meshes (All Actor Types) : Select all actor types of skeletal meshes. |
| **Static Meshes** | Open options for:   - **Matching Selected Class:** Select all actors with the same static mesh and actor class as the selected. - **Matching All Classes:** Select all actors with the same static mesh as the selected. |

### Help

| Command | Description |
| --- | --- |
| **Level Editor Documentation** | Opens the editor documentation. |
| **Viewport Controls** | Open the Viewport Controls cheat sheet. |
| **UEFN Documentation** | Opens the documentation site for UEFN. |
| **Dev Community** | Opens the Epic Games dev community forum. |
| **Learning Library** | Open a library of UEFN learning content. |
| **Forums** | Open the UEFN forum and connect with other UEFN developers. |
| **Snippets** | Open a library of Verse code snippets and code blocks. |
| **About Unreal Editor** | Open the Unreal Editor Fortnite page where you can learn more about Unreal Editor. |
| **Credits** | List the credits for the application. |
| **Visit UnrealEngine.com** | Open the Unreal Engine documentation site. |
| **Report Issue** | Report an issue you found with Unreal Editor Fortnite. |

## Toolbar

The **Main Toolbar** includes quick buttons and settings for frequently used and settings. It is divided into the following areas:

[![The UEFN Toolbar](https://dev.epicgames.com/community/api/documentation/image/9431dce4-c36e-4f1a-ab12-d97c8c139a7d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9431dce4-c36e-4f1a-ab12-d97c8c139a7d?resizing_type=fit)

Click image to enlarge.

### 1. Save Button

Saves the current level to disk. Use **File** > **Save All** if you have additional project assets to save, such as Blueprints, materials, or imported textures.

### 2. Content Drawer

Quick access to the Content Drawer to open and edit custom made assets.

### 3. Selection Mode

Choose from a number of editing modes available from the Select Mode dropdown menu:

- Select
- [Landscape](https://dev.epicgames.com/documentation/en-us/fortnite/environments-and-landscapes-in-unreal-editor-for-fortnite)
- [Foliage](https://dev.epicgames.com/documentation/en-us/fortnite/foliage-mode-in-unreal-editor-for-fortnite)
- [Modeling](https://dev.epicgames.com/documentation/en-us/fortnite/modeling-mode-in-unreal-editor-for-fortnite)
- [Animation](https://dev.epicgames.com/documentation/en-us/fortnite/animation-and-cinematics-in-unreal-editor-for-fortnite)

### 4. Project Settings

The **Project** menu contains options for publishing content from the editor. The table below lists the options available.

[![The Project menu](https://dev.epicgames.com/community/api/documentation/image/28a12fcf-f22a-48a6-9db5-2506cd809756?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/28a12fcf-f22a-48a6-9db5-2506cd809756?resizing_type=fit)

Click image to enlarge.

| Menu Option | Outcome |
| --- | --- |
| **New / Open Project…** | Create a new project or opens an existing one. |
| **Project Settings** | Open the current project settings. |
| **Close Project** | Close the current project. |
| **Show Project in Explorer** | Open a File Explorer window showing the project files. |
| Project Size | Provide a view of the breakdown of the current project’s size. |
| **Launch Memory Calculation** | After playtesting your project, this option becomes available.  Selecting Launch Memory Calculation calculates the total memory used in your project. This is a mandatory step in the publication process. |
| **Upload to Private Version** | Generate a test code for your project in the Creator Portal. |
| **Share with Team** | Select a team to share the current project with. |
| **Publish Project** | Create a snapshot of the project and generates a publishing candidate from the current project. |
| **Open Creator Portal** | Open the Creator Portal in your browser. |
| **News** | Open the News popup window for access to news and information on UEFN and Fortnite. |
| **Log Out User** | Logs you out of your Fortnite account. If you are not logged in, the option will change to **Login**, and when selected, logs you into your Fortnite account. |

### 5. Place Actors

Open a list of usable actors. Drag the actor into the viewport to use it.

An [Actor](https://dev.epicgames.com/edc/manage/assets/unreal-editor-for-fortnite-glossary#actor) is any object that can be placed into a Level, from [Static Meshes](https://dev.epicgames.com/edc/manage/assets/unreal-editor-for-fortnite-glossary#static-mesh) that create your game's environment, to sounds, cameras, and so on. This page will show you how to place these Actors into your Level so you can bring your world to life.

[![The Place Actors menu access different types of actors you can add to your project.](https://dev.epicgames.com/community/api/documentation/image/7ce90eb5-5d49-4996-81bb-9a97e5e58ba0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7ce90eb5-5d49-4996-81bb-9a97e5e58ba0?resizing_type=fit)

Refer to the [**Placing Actors**](https://docs.unrealengine.com/placing-actors-in-unreal-engine/) documentation for more information.

### 6. Verse

The Verse button opens Visual Studio Code where you can edit your Verse code. To compile your Verse code and find any compilation errors, select **Verse > Build Verse Code** in the Menu Bar. All messages for your Verse project will be in the message log. See Verse Explorer below to learn more about how to use Verse in UEFN.
The button has four different states:

| Verse State | Color | Description |
| --- | --- | --- |
| [The Verse button has a green circle on it](https://dev.epicgames.com/community/api/documentation/image/562d5044-257b-4aaf-aac1-aaafbcdb83e1?resizing_type=fit) | Green | Your Verse project has no errors. |
| [The Verse button has a red mark on it](https://dev.epicgames.com/community/api/documentation/image/911a72eb-56c8-49f0-ad14-fc07948ce082?resizing_type=fit) | Red | Your Verse project has errors. |
| [The Verse button has an ornage mark on it](https://dev.epicgames.com/community/api/documentation/image/9b2d3d87-986b-4127-bb2e-63b9148e7b18?resizing_type=fit) | Orange | Your Verse project has warnings, but will still compile and run. |
| [The Verse button has an upwards arrow on it](https://dev.epicgames.com/community/api/documentation/image/6630f6f2-6b23-4f6d-b176-ccbb16780d9c?resizing_type=fit) | Arrow | Your changes to the Verse project are detected. Click the Verse button to push your changes. |

#### Verse Explorer

  From Verse Explorer you can:

- Create a new [Verse](https://dev.epicgames.com/edc/manage/assets/unreal-editor-for-fortnite-glossary#verse) file from a template.
- Create Submodules to organize your Verse files.
- Delete and rename Submodules and Verse files.

[![Using Verse Explorer from the Tools menu](https://dev.epicgames.com/community/api/documentation/image/02295880-5590-4285-881b-fbe415e3b33c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02295880-5590-4285-881b-fbe415e3b33c?resizing_type=fit)

Click image to enlarge.

Verse Explorer can be used to manage your files alongside Unreal Revision Control. Enable **Revision Control** to check out, mark for add / delete, and rename Verse files and modules.

[![Accessing Verse Explorer in UEFN](https://dev.epicgames.com/community/api/documentation/image/4a0775b1-e42d-4f60-9c80-45d617bf7497?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4a0775b1-e42d-4f60-9c80-45d617bf7497?resizing_type=fit)

Click image to enlarge.

Refer to the [Verse Explorer User Interface Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite) document for more details on how this specific tool works.

### 7. Live Edit Options

**Live Edit** provides a way to use both Fortnite Creative and UEFN to edit your project simultaneously.  Live Edit works by uploading your island to the [content service](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#content-service) and opening an instance of the Fortnite [client](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#client).

Live Edit has a few standard states:

| State in UEFN | State Name | Description |
| --- | --- | --- |
| [Launch a session in Fortnite Creative.](https://dev.epicgames.com/community/api/documentation/image/87e02234-eb75-48f9-a8b4-c2ee30026205?resizing_type=fit) | **Launch Session** | Attempts to create a connection with a Fortnite Creative client. |
|  | **Exit Session** | Closes the Live Edit session, which closes the connection between the Creative session and UEFN. |
| [Connecting to the Fortnite Creative client.](https://dev.epicgames.com/community/api/documentation/image/3e853ae7-aeeb-4bd8-835a-e73c59abda29?resizing_type=fit) | **Session Loading** | Loading state before opening a session of Fortnite Creative. |
|  | **Session Connected** | The project is connected to the Fortnite client. |
|  | **Game in Progress** | The Live Edit session is connected and the project is playable in Fortnite Creative. |
|  | **Session Disconnected** | Warns that the previous session has been disconnected. |
| [Starts a game in Fortnite Creative.](https://dev.epicgames.com/community/api/documentation/image/057476ff-242f-40c1-a3fa-ebb1b3cd20c3?resizing_type=fit) | **Start Game** | Starts the game in the Fortnite Creative client. |
| [Ends the game in the connected client.](https://dev.epicgames.com/community/api/documentation/image/322c9dff-1855-463f-94db-931dc418ce3f?resizing_type=fit) | **End Game** | Ends the game in the Fortnite Creative client. |
| [Pushes changes you make in UEFN to the Fortnite client.](https://dev.epicgames.com/community/api/documentation/image/ffae4b73-4249-4426-a16a-04d49ac97ea2?resizing_type=fit) | **Push Changes** | Refreshes your project in the Fortnite Creative client after you make changes to your project in UEFN. |
|  | Push Changes Pending | There are new changes that need to be pushed live to the client in order for you to test them in Fortnite Creative |

#### Launch Session

[![The Launch Session button](https://dev.epicgames.com/community/api/documentation/image/758ea4a9-d0b8-4125-a9cd-fe1e768198da?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/758ea4a9-d0b8-4125-a9cd-fe1e768198da?resizing_type=fit)

When you click **Launch Session**, a progress bar appears and Fortnite Creative is launched.  Once the level successfully uploads, Fortnite Creative opens.

[![Launch Session button upload status bar](https://dev.epicgames.com/community/api/documentation/image/cff16732-757a-43af-8286-4bcdf1aecf1e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cff16732-757a-43af-8286-4bcdf1aecf1e?resizing_type=fit)

The **Launch Session** button has a dropdown menu with multiple options related to [playtesting](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#playtest) your UEFN project.

#### Launch Session Menu

The Launch Session menu contains options to test your map content before you publish to Fortnite Creative. The table below lists the options available.

| Menu Option | Description |
| --- | --- |
| **Live Edit** | If checked, enable live updates in a connected session where you are editing. |
| **Auto Start Game** | If checked, it will automatically push to all connected clients and game servers. |
| **Launch on This PC** | Launch the Fortnite Creative client on the local machine. |
| **Connect to Platform** | Launch the Fortnite Creative client onto another device logged in with the same Epic account as the editor. |

### 8. Team Connected Session

When in a live edit session with your team members, this button becomes highlighted. Click on the button to see who is in the live edit session, change the camera view to one of your colleagues, and teleport team members to you.

[![The Team Connected Session button highlights and becomes active when you’re editing in live edit mode.](https://dev.epicgames.com/community/api/documentation/image/15531bfa-174f-43c4-a03b-343ffa9302fb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/15531bfa-174f-43c4-a03b-343ffa9302fb?resizing_type=fit)

## Viewport

The **Viewport** is where you assemble the world and gameplay elements for your Fortnite Creative experience. [Viewport controls](https://docs.unrealengine.com/viewport-controls-in-unreal-engine/) and navigation are largely unchanged from Unreal Engine.

[![The Viewport window](https://dev.epicgames.com/community/api/documentation/image/aae63256-6691-4c54-9c0f-2424abc7ddab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aae63256-6691-4c54-9c0f-2424abc7ddab?resizing_type=fit)

Click image to enlarge.

Important Viewport settings for UEFN are displayed in the table below.

| Viewport Option | Optimal Setting | Reason |
| --- | --- | --- |
| **Field of View** | 90.0 | If this setting is too low, your movement inside the viewport becomes restricted. If too high, you will zoom out from your build, and the build will look distorted. |
| **Far View Plane** | 00.0 | Setting this to zero shows an infinite view. |
| **Screen Percentage** | 100 | If the percentage setting is lower than 100, your build looks fuzzy. If the setting is high, the appearance of the build improves, but could use a lot of memory in Fortnite Creative. |
| **Game View** | Toggle On | Turns off all device visual properties for a runtime view of your project. |

[![Viewport option list](https://dev.epicgames.com/community/api/documentation/image/eea263f5-3224-4d6c-bdff-b5ff1b6fb687?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eea263f5-3224-4d6c-bdff-b5ff1b6fb687?resizing_type=fit)

Click image to enlarge.

For more information, see [Editor Viewports](https://docs.unrealengine.com/editor-viewports-in-unreal-engine/).

## Outliner

The **Outliner** panel displays all the actors within the scene in a [hierarchical](unreal-editor-for-fortnite-glossary#hierarchical) tree view. In the panel, you also have the option to search for an actor element in the level,  create folders to group actor elements together, and sign out assets to work on them.

[![The Outliner and Layers panel](https://dev.epicgames.com/community/api/documentation/image/fa8534f0-97f1-487e-8d0c-97f9b853c782?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fa8534f0-97f1-487e-8d0c-97f9b853c782?resizing_type=fit)

Click image to enlarge.

Use the Outliner settings menu to select your actor's settings. For more information, refer to [World Outliner](https://docs.unrealengine.com/world-outliner-in-unreal-engine/).

## Details Settings Partition

[![The Details panel has options to modify how a device or actor behaves, the world settings determine island-wide settings, and world partition is used with large islands to make all scenic details render properly.](https://dev.epicgames.com/community/api/documentation/image/8ef926a3-878f-4e22-ae89-aa3ac3bac8c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ef926a3-878f-4e22-ae89-aa3ac3bac8c4?resizing_type=fit)

The **Details** panel contains information for the current selection in the Viewport. This panel provides information on location, scalability, shadows, lighting, meshes, instance, structural support, weak spots, and more.

In the Details panel you can:

- Add new components to the selected Actor element.
- Convert Actor behavior with User Options.
- Lock Actor details in place.
- Toggle through your favorite settings.
- Set specific settings for the selected actor element as well.

For more information, see the [Details Panel](https://docs.unrealengine.com/level-editor-details-panel-in-unreal-engine) documentation.

World Settings contains options you can enable and disable that affect the Time of Day and Nanite settings. For more information, see the [World Settings](https://docs.unrealengine.com/world-settings-in-unreal-engine/) documentation.

World Partition settings control how data is sent and rendered depending on the HLOD of the scenery in relation to the camera view. Refer to the following documentation to better understand how to use World Partition:

- [Streaming and HLODs](https://dev.epicgames.com/documentation/en-us/fortnite/streaming-and-hlods-in-unreal-editor-for-fortnite)
- [Memory Management](https://dev.epicgames.com/documentation/en-us/fortnite/memory-management-in-unreal-editor-for-fortnite)

## Content Drawer and Content Browser

The **Content Drawer** is a folder that contains all your custom assets. You can toggle instantly to the Content Drawer by clicking the **Content Drawer button** on the toolbar. Clicking the Content Drawer button on the bottom toolbar opens the Content Drawer while the Content Browser open.

The **Content Browser** is where you create, organize, and modify your creations in UEFN. Manage your folders in the Content Browser by copying, moving, renaming, and viewing references to your assets.

[![The Content Browser](https://dev.epicgames.com/community/api/documentation/image/67d8643e-f116-4c4b-ba21-96986b40e878?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/67d8643e-f116-4c4b-ba21-96986b40e878?resizing_type=fit)

Click image to enlarge.

From the Content Browser you can:

- Search for assets in the search bar.
- Import assets into the Content Browser.
- Open Fab to browse and purchase custom assets.
- Add a collection.
- Add asset filters.
- Choose an asset path.

## Output Log

The **output log** panel contains output information about the level you are currently working on. You can search for output information about Verse devices and actor elements in your level, and filter the output log messages to tailor the log you want to review and edit.

[![The Output Log](https://dev.epicgames.com/community/api/documentation/image/6f9d67cd-2af6-4ea8-95af-453da675290b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6f9d67cd-2af6-4ea8-95af-453da675290b?resizing_type=fit)

In the Settings menu, you can enable World Wrapping, clear the output log on PIE startup, open folders with output log sources, and select to open the output log in the default external editor.

## Unreal Revision Control

Unreal Revision Control is a custom embedded [revision control](unreal-editor-for-fortnite-glossary#revision-control) feature in UEFN. Revision control creates [snapshots](unreal-editor-for-fortnite-glossary#snapshot) of your project as it progresses and has many features that make working collaboratively easy:

- [Snapshot History](https://dev.epicgames.com/documentation/en-us/fortnite/snapshot-history-and-conflict-resolution-in-unreal-editor-for-fortnite#snapshot-history-tab)
- [Conflict Resolution](https://dev.epicgames.com/documentation/en-us/fortnite/snapshot-history-and-conflict-resolution-in-unreal-editor-for-fortnite#conflict-resolution)
- Auto Check-out
- Auto-undo
- [Notes](https://dev.epicgames.com/documentation/en-us/fortnite/using-notes-in-unreal-editor-for-fortnite#creating-notes)
- And other [collaboration tools](https://dev.epicgames.com/documentation/en-us/uefn/collaborate-and-publish-in-unreal-editor-for-fortnite)

[![The revision control tools can be found on the bottom toolbar](https://dev.epicgames.com/community/api/documentation/image/19c59b60-74eb-437b-8510-4f1682adb0f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19c59b60-74eb-437b-8510-4f1682adb0f4?resizing_type=fit)

Refer to the following documentation for more information.

- [**Unreal Revision Control**](unreal-revision-control-in-unreal-editor-for-fortnite)
- [**Unreal Revision Control Best Practices**](unreal-revision-control-best-practices-in-unreal-editor-for-fortnite)
- [**Conflicts in Revision Control**](conflicts-in-unreal-revision-control-in-unreal-editor-for-fortnite)

## Island Settings Device

All projects in UEFN have an **IslandSettings** device in the **Outliner** panel. When you click it, IslandSettings opens in the **Details** panel with option settings similar to those found in **Fortnite Creative** under **My Island**.

[![The Island Settings under the Details panel](https://dev.epicgames.com/community/api/documentation/image/0fa5225b-2d89-4fb2-bf40-68b6fe279c45?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0fa5225b-2d89-4fb2-bf40-68b6fe279c45?resizing_type=fit)

*IslandSettings in UEFN*

You can use these options to set the parameters of your game, from how the game begins to how a game successfully completes, including the game duration, matchmaking, and other interactions and configurations.

To see the full list of settings, see the [Island Settings](island-settings-in-unreal-editor-for-fortnite) device documentation.
