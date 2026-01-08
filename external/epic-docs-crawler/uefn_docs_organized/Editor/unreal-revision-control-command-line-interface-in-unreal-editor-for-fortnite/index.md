# Unreal Revision Control Command Line Interface

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/unreal-revision-control-command-line-interface-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:01:18.591246

---

Projects created after the 36.00 release will not be able to use the file path given below to use CLI commands. When browsing for the file path, search for **urc2.exe**.

Use the following CLI commands for projects after 36.00:

- **See all revisions in your repository**

  - `urc2 revision list`
- **Sync to the latest revision of the project**

  - `urc2 revision sync`
- **Sync to a previous revision in your repository history**

  - `urc2 revision sync @[revision]`
- **Get an overview of all assets and their status within a certain revision**

  - `urc2 repository status`
- **Roll back to a specific revision to continue working from a previous backup**

  - `urc2 revision promote "description"`
- **Revert an asset to the current revision to undo your changes**

  - `urc2 file reset .\pathname`
- **Release assets signed out by a specific team member to unblock yourself**

  - `urc2 lock release --force --owner <username>`

The **Unreal Revision Control (URC) Command Line Interface (CLI)** enables you to perform revision control actions on your project using a third-party command line tool such as PowerShell. Although these actions can often be performed with the user interface, some allow you to go beyond what the interface currently supports.

This document provides an overview of:

- How to get started with CLI
- Common use cases and how to achieve them with the CLI

## Before You Start

To use command lines you need to know where the URC files are located in Windows Explorer and set up an environment variable to create and use command lines with URC.

Before setting the environment variable, make sure to set your folder where the **urc.exe** exists within your path variable.

[![Follow the file path](https://dev.epicgames.com/community/api/documentation/image/0c42619c-a16d-4d01-a284-599c19032f64?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c42619c-a16d-4d01-a284-599c19032f64?resizing_type=fit)

1. Open your Windows settings and select **System** > **About** > **Advanced system settings**. The **System Properties** panel opens.
2. Click **Environment Variables…**

   [![Open the System Properties panel.](https://dev.epicgames.com/community/api/documentation/image/d9ea0875-3233-4a44-8121-7ea799b9bc96?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d9ea0875-3233-4a44-8121-7ea799b9bc96?resizing_type=fit)

   *Click to enlarge image.*
3. Select **Path** > **Edit** from the **User variables** list to edit the Environment Variables for the path.

   [![Select path from the User variables list and click edit.](https://dev.epicgames.com/community/api/documentation/image/166c6295-6c27-4745-8322-2a602af91125?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/166c6295-6c27-4745-8322-2a602af91125?resizing_type=fit)

   *Click to enlarge image.*

   Your name appears after C:\Users\
4. Select **Browse** and choose the file path that leads to your **urc.exe** files.
   This can usually be found at `C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64`

   [![Browse for the file path where your urc.exe files are located.](https://dev.epicgames.com/community/api/documentation/image/f20d6ee6-af59-45b4-a614-e4a76d395efb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f20d6ee6-af59-45b4-a614-e4a76d395efb?resizing_type=fit)

   Click to enlarge image.
5. Click **OK** until all the open panels are closed.

You’ve successfully edited an environment variable.

## Launching PowerShell

Open the Unreal Editor for Fortnite (UEFN) project you’re working on with Windows Explorer.

[![Open the project file you’re currently working on.](https://dev.epicgames.com/community/api/documentation/image/cde97bf2-30a1-4c63-9fbe-9f30a2f81cbf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cde97bf2-30a1-4c63-9fbe-9f30a2f81cbf?resizing_type=fit)

Make sure to log into UEFN first before using other URC CLI commands.

This depends on whether you have recently logged into UEFN. You won’t need to call `urc auth login` if UEFN is open and you’re logged in unless the token expires. If you use the CLI without UEFN open or after the token expires, you’ll have to log into the CLI.

[![Successfully logged into powershell.](https://dev.epicgames.com/community/api/documentation/image/88fb8993-fb69-4563-bafa-1d9b06edc71d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88fb8993-fb69-4563-bafa-1d9b06edc71d?resizing_type=fit)

1. **Shift + right-click** to open the **contextual menu**.
2. Choose **Open** **PowerShell window here**.

   [![Open Powershell in your project.](https://dev.epicgames.com/community/api/documentation/image/65f8ccf0-856b-4336-8150-0acbc4262811?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/65f8ccf0-856b-4336-8150-0acbc4262811?resizing_type=fit)

## Common CLI Use Cases

#### Listing all the projects that you have access to with your account logged in

| CLI Commands |
| --- |
| urc project list |
| urc p list |

[![List your projects using CLI commands.](https://dev.epicgames.com/community/api/documentation/image/d0df3d29-6798-480a-a921-d49b9dd9ade3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0df3d29-6798-480a-a921-d49b9dd9ade3?resizing_type=fit)

*Click to enlarge image.*

#### Seeing all the snapshots of your project

| CLI Commands |
| --- |
| urc project snapshot list |
| urc p s list |

[![List your project snapshots.](https://dev.epicgames.com/community/api/documentation/image/9fc807d5-2705-4a7f-ad36-6668c70544ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9fc807d5-2705-4a7f-ad36-6668c70544ca?resizing_type=fit)

#### Syncing to a previous snapshot to go back in project history

Close the project or editor before syncing to a specific snapshot to avoid failing to sync project files.

| CLI Commands |
| --- |
| urc project snapshot get <number of snapshot> |
| urc p s get <number of snapshot> |

[![List your project snapshot history](https://dev.epicgames.com/community/api/documentation/image/ef48dfb9-cc7b-41f8-9910-18bc4e56fe89?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ef48dfb9-cc7b-41f8-9910-18bc4e56fe89?resizing_type=fit)

*Click to enlarge image.*

#### Syncing to latest so you can retrieve everyone’s updates to the island

| CLI COmmands |
| --- |
| urc project snapshot get |
| urc p s get |

[![Sync to latest to get all updates to the project.](https://dev.epicgames.com/community/api/documentation/image/cf008a3c-44b2-4914-96a3-4f5806177e73?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf008a3c-44b2-4914-96a3-4f5806177e73?resizing_type=fit)

*Click to enlarge image.*

#### Getting an overview of all assets and their status within the current snapshot before submitting

| CLI Commands |
| --- |
| urc project status –-extended |
| urc p status –-extended |

[![Get an overview of project asset statuses](https://dev.epicgames.com/community/api/documentation/image/abafbec0-c55c-4549-9db9-3c01e7e75ce6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/abafbec0-c55c-4549-9db9-3c01e7e75ce6?resizing_type=fit)

*Click to enlarge image.*

#### Rollback to a specific snapshot to continue working from a previous backup

Sync your project to a previous snapshot

| CLI Commands |
| --- |
| urc projects snapshots get <number of snapshot> |

If you need to see a list of snapshots so you can select which project version you want to sync to, use the command:

| CLI Commands |
| --- |
| urc projects snapshots list |

[![See a list of project snapshots.](https://dev.epicgames.com/community/api/documentation/image/b231eed6-f98d-4962-a46a-732c0f023611?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b231eed6-f98d-4962-a46a-732c0f023611?resizing_type=fit)

*Click to enlarge image.*

Copy and paste the **Plugins** folder to your desktop to keep a backup of your assets.

[![Copy and paste a copy of the Plugins folder of your desktop.](https://dev.epicgames.com/community/api/documentation/image/1310c815-6e9b-424d-b446-83e477429c3a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1310c815-6e9b-424d-b446-83e477429c3a?resizing_type=fit)

Afterward, sync back to the latest snapshot.

| CLI Commands |
| --- |
| urc projects snapshots get |

Once you've successfully synched the project to the latest snapshot, do the following:

1. Delete Plugins from your current UEFN project folder.
2. Copy and paste the previous **Plugins** folder from the desktop into the project folder.
3. Open your project in UEFN and confirm the state of the project looks as you intend it.
4. Click **Check In Changes** if you project looks as you expect to create a new snapshot reflecting the new state of your project.

#### Reverting an asset to the current snapshot to undo your changes

| CLI Commands |
| --- |
| urc asset revert .\pathname |
| urc a revert .\pathname |

[![Revert an asset to the current snapshot.](https://dev.epicgames.com/community/api/documentation/image/4d57f649-a4ef-4b68-a93c-9976a041a0e4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d57f649-a4ef-4b68-a93c-9976a041a0e4?resizing_type=fit)

*Click to enlarge image.*

#### Releasing assets that are checked out by a specific team member, so you can continue working without someone blocking your work

Get the projectID, opening in the project in the Creator Portal. You can see the project id in the url.

[![Get the project id from the Creator Portal url.](https://dev.epicgames.com/community/api/documentation/image/4d5e1870-d3eb-4550-b91f-4ab1e74012e3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d5e1870-d3eb-4550-b91f-4ab1e74012e3?resizing_type=fit)

*Click to enlarge image.*

This function can only be performed by a team admin. Make sure to check your team role in the Creator Portal.

| CLI Commands |
| --- |
| urc project forcerelease <projectID> –-user **UserName** |
| urc p forcerelease <projectID> –-user **UserName** |

[![Force an asset to release in PowerShell.](https://dev.epicgames.com/community/api/documentation/image/19a8b6a6-80dd-4006-919b-ef955dcd7267?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19a8b6a6-80dd-4006-919b-ef955dcd7267?resizing_type=fit)

*Click to enlarge image.*
