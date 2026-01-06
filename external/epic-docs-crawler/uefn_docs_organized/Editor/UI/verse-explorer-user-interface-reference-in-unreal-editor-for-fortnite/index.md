# Verse Explorer User Interface Reference

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:54:38.932002

---

**Verse Explorer** is a tool in **Unreal Editor for Fortnite (UEFN)** that creates new [Verse](/documentation/en-us/fortnite/learn-programming-with-verse-in-unreal-editor-for-fortnite) files from templates, organizes your files with [submodules](/documentation/en-us/fortnite/verse-glossary#submodule), and supports renaming and deleting files.

Access Verse Explorer through the **Verse** dropdown menu. You can dock the Explorer tab anywhere in the editor, and next time UEFN opens, the Explorer tab opens in the same place it was last docked.

![Navigate to Verse Explorer through the Verse drop down menu](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/48d81dd1-f683-41de-8112-1ad603c3a8aa/navigate-to-verse-explorer.gif)

The key workflow for using Verse Explorer is:

1. Add a new [Verse file](/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#verse-file),
2. Create a new Verse device from a template, and
3. Open your Verse file in [Visual Studio Code (VS Code)](/documentation/en-us/fortnite/verse-glossary#visual-studio-code) to modify the device.

## Verse Explorer User Interface

To create a Verse file for your project, right-click on your project name at the top of Verse Explorer. Select **Add new Verse file to project** in the menu that opens. See [Create Your Own Device Using Verse](/documentation/en-us/fortnite/create-your-own-device-in-verse) to learn more about creating Verse-authored devices.

![Create a new Verse file](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/c3deb141-8d47-4dd6-a96c-1d594fe61376/right-click-project-name.png)

To open a Verse file in Visual Studio Code, double-click the file name in Verse Explorer.

![Open a Verse file in VS Code](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/3bd0d1da-ab5e-4d54-995b-1cf1d48181e8/open-verse-file.gif)

## File

When you right-click on a Verse file in your project, a menu opens:

![Right-click menu for your Verse file](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/139cae25-d62a-4c72-911d-b2273310d110/right-click-verse-file-in-explorer.png)

| **Option** | **Description** |
| --- | --- |
| **Delete File** | Deletes the file. |
| **Copy Full Path** | Gets the full path to the file’s location. |
| **Open Directory** | Opens the directory containing the file. |
| **Open in Visual Studio Code** | Opens the file in VS Code (if it is installed). |
| **Open in Default Editor** | Opens the file with your default text editor. |
| **Rename File** | Renames the file. |
| **Configure Revision Control** | Configures connection to revision control. |

You are prompted to install VS Code if you do not have it installed already.

## Module

When you right-click on a module in your project file, a menu opens with the following options:

![These menu options open when you right-click on a module](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/21093204-b27e-4d84-8a39-f90766230547/right-click-module-in-explorer.png)

| **Option** | **Description** |
| --- | --- |
| **Create New Verse File** | Open the VerseTemplate browser. |
| **Create Submodule** | Creates a new directory. |
| **Copy Full Path** | Gets the full path to the file’s location. |
| **Open Directory** | Opens the directory containing the file. |
| **Rename Directory** | Renames the directory. |
| **Delete Directory** | Deletes the directory. |

## Directory Watcher

The **Directory Watcher** looks for changes in the **Verse Explorer directory**. Projects should update when files are added, modified, or deleted.

## Search

The search bar at the top of the Explorer can be used to search the directory list for files.

![Use the search bar to search the directory list for files](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/a6ba8c1a-5186-4f44-b2de-2f4f5cf0bafc/search-bar.png)

## Unreal Revision Control Integration

Verse Explorer works with [Unreal Revision Control](/documentation/en-us/fortnite/unreal-revision-control-in-unreal-editor-for-fortnite) for version control of your Verse files and the submodules in your project.

![New menu options are available when you integrate Unreal Revision Control](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/128278cd-356e-4672-bda6-565033d9b661/urc-integration.png)

## Unreal Revision Control Files

Right-clicking on a Verse file with Unreal Revision Control enabled opens a menu with the following options:

![Verse files in URC checked out and marked for Add](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/f20834bc-8110-4871-b47e-5742125a90c7/right-click-urc-options.png)

| **Option** | **Description** |
| --- | --- |
| **Delete File** | Delete the file. |
| **Copy Full Path** | Gets the full path to the file’s location. |
| **Open Directory** | Opens the directory containing the file. |
| **Open in Visual Studio Code** | Opens the file in VS Code (if it is installed). |
| **Open in Default Editor** | Opens the file with your default text editor. |
| **Rename File** | Renames the file. |
| **Check Out** | Checks out the file. |
| **Revert** | Reverts to the previous version of the file unless the file is marked for **Add**. This removes the file from the snapshot but does not delete the file. |
| **Mark for Delete** | Deletes the file. |
| **Mark for Add** | Adds the file to the snapshot. |
| **Refresh** | Refreshes the file to the latest version saved to disk. |
| **Configure Revision Control** | Configures the connection to revision control. |

Verse files in Unreal Revision Control sit in one of several states:

| **State** | **Description** |
| --- | --- |
| **Red Checkmark** | The file is checked out and writable on disk. |
| **Green Plus** | The file is marked for add in a snapshot. |
| **Yellow Question Mark** | The file state is unknown. In some cases this may be remedied by restarting the editor. |
