# Unreal Revision Control

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/unreal-revision-control-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T22:53:05.818055

---

Unreal Editor for Fortnite (UEFN) integrates [revision control](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#revision-control) as an important part of project management, team processes, and quality control. It maintains a single source of truth for the project and developers.

Enabling Unreal Revision Control in team projects facilitates collaboration between team members, keeps work from getting lost, and speeds up an [island’s](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#island) release by shortening production time. Incorporating project [synchronization](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#sync-content) in daily iteration takes a little work, but is well worth the effort in the end.

## How Unreal Revision Control Works

Unreal Revision Control is available out of the box for [all new islands](https://dev.epicgames.com/documentation/en-us/uefn/project-organization-in-unreal-editor-for-fortnite) in UEFN. It works by taking a "[snapshot](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#snapshot)" of the island and its [assets](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#asset). This snapshot shows the current state of island files and assets after they have been submitted.

[![Select Unreal Revision Control to add source control to your projects.](https://dev.epicgames.com/community/api/documentation/image/9a1d69ce-526f-41fb-8a56-9b413140e787?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9a1d69ce-526f-41fb-8a56-9b413140e787?resizing_type=fit)

*Click image to enlarge.*

Select **Unreal Revision Control** from the **Project Defaults** panel for a new project.

From the **Team Selection** dropdown menu, select **Only Me** if you are working on a project alone, or your team’s name if you are working on a team project. You can disable Unreal Revision Control for your personal projects.

Projects using Unreal Revision Control are hosted on [servers](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#server).

[![Sync changes are marked with a download icon.](https://dev.epicgames.com/community/api/documentation/image/9f37e2f3-b3eb-465f-a474-4cb9a8f33769?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f37e2f3-b3eb-465f-a474-4cb9a8f33769?resizing_type=fit)

*Sync Latest is marked by a download icon.*

You can also use Unreal Revision Control from the **Outliner** panel. An asset's revision control status will display for reference on the right side of an asset's row in the outliner. Additionally, you can right-click an asset from the Outliner panel then select **Revision Control > Check out** from the dropdown menu.

## Use Unreal Revision Control with Your Projects

Enabling source control when you’re creating new projects adds these features to the bottom toolbar:

- **Revision Control**
- **Sync Changes / At Latest**
- **Check-in Changes / No Changes**.

[![Unreal revision control tools on the bottom toolbar.](https://dev.epicgames.com/community/api/documentation/image/c5b901f6-f504-4bde-bb0a-a496820eefff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5b901f6-f504-4bde-bb0a-a496820eefff?resizing_type=fit)

All Unreal Revision Control features appear below the [Details panel](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite) of your project.

### Revision Control

The revision control indicator. A green checkmark indicates that revision control is in use for this project. Click the arrow to open the control menu where you check out modified files and assets and change your revision control settings.

[![Revision control’s control menu.](https://dev.epicgames.com/community/api/documentation/image/c5716177-a572-4df0-b62d-080aa7b516ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5716177-a572-4df0-b62d-080aa7b516ab?resizing_type=fit)

Change your control settings by clicking **Change Revision Control Settings…** from the dropdown menu, this opens the **Revision Control Login**. From here you can toggle on and off automatic settings and review the **Revision Control Log**.

[![Revision control settings.](https://dev.epicgames.com/community/api/documentation/image/dc9b53c6-ef1f-42b9-b227-cd5d1bce8af6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dc9b53c6-ef1f-42b9-b227-cd5d1bce8af6?resizing_type=fit)

*Click image to enlarge.*

### Auto Checkout

**Auto Checkout** is automatically enabled when you create a new project. This feature works by automatically checking out an asset to you when you make changes or move the asset in the viewport.

This feature locks the asset you made changes to and stops another teammate from making changes to the same object while you have it checked out. By looking through the assets listed in the Outliner, you can see which [assets](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#asset) have been checked out by a colleague.

[![Assets checked out by colleagues will have a special icon attached to them in the outliner.](https://dev.epicgames.com/community/api/documentation/image/646b3a26-c5b6-47cb-8525-9ab3248e0ed6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/646b3a26-c5b6-47cb-8525-9ab3248e0ed6?resizing_type=fit)

Using Auto Checkout avoids conflicts and allows you and your teammates to collaborate on projects with as little friction as possible.

If autocheckout is turned off, Unreal Revision Control will ask you to either connect back to the internet or save locally.

### Auto Revert

**Auto Revert** stops you from creating conflicts with team members by automatically undoing your changes to an asset already checked out by another person. You’ll receive a warning about the conflict and reversal of changes.

This feature stops you from putting in hours of work on an asset only to undo all the changes you made in the end. By checking quickly in the Outliner, you’ll know what assets your teammates are currently working on.

### Sync Changes

This feature pulls the latest revision control snapshot of the project and syncs to disk. You’ll need to sync to the latest project version when you see **Sync Latest**. If there are no changes to sync, the button reads **At Latest**.

[![Clicking Sync Changes updates the project version and the button changes to At Latest.](https://dev.epicgames.com/community/api/documentation/image/4b042229-8da4-4d75-b414-70a5287bc2a4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4b042229-8da4-4d75-b414-70a5287bc2a4?resizing_type=fit)

Once you click **Sync Latest** you pull the latest project snapshot down to your local environment where you can continue working on the project.

You can make and save changes without having synced to the latest snapshot as long as the changes you make do not conflict with the changes in the latest snapshot and are not changes made to assets currently checked out by another user.

Refer to [Conflicts in Unreal Revision Control](https://dev.epicgames.com/documentation/en-us/fortnite/conflicts-in-unreal-revision-control-in-unreal-editor-for-fortnite) for more information on the possible conflicts you may encounter.

### Check-in Changes

Checks in all changes and create a new project snapshot with all of the checked-in changes. When you make changes to the project that need to be checked in, the button changes from **No Changes** to **Check-in Changes**.

[![When changes need to be checked in the button reads Check-in Changes. Once changes have been checked in, the button changes to read No Changes.](https://dev.epicgames.com/community/api/documentation/image/1e497589-31b7-4675-8512-006ca87e4204?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e497589-31b7-4675-8512-006ca87e4204?resizing_type=fit)

Unreal Revision Control tracks the revision history of source files with formats native to the [UE](unreal-editor-for-fortnite-glossary#unreal-engine) ecosystem but does not track the revision history of source files with formats native to other software, (for example Blender, Photoshop, and so on).

Clicking **Check-in Changes** opens the **Check-in Changes** window. This creates a new snapshot of your island and opens the snapshot window. List the changes made to the assets in the **Changelist Description**, then click **Submit** to create a new snapshot of the island.

If there's an item on the check-in list that should be reverted to its earlier version, you can do that from the submit window.

Select the asset and right-click, a dropdown menu appears with the **Revert** option. Click **Revert** and any changes to the asset are undone.

[![Revert an asset during the submission process if necessary.](https://dev.epicgames.com/community/api/documentation/image/dff4f800-c060-45be-9622-e92c7cffe2c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dff4f800-c060-45be-9622-e92c7cffe2c7?resizing_type=fit)

[![Revision control requires a change description for all assets checked out and altered. A checkmark means the asset was checked out, a plus sign means it is a new asset added to revision control.](https://dev.epicgames.com/community/api/documentation/image/a2720be2-6317-4274-803e-7f8f45104871?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2720be2-6317-4274-803e-7f8f45104871?resizing_type=fit)

1. **Changelist Description:** Add a description of the changes you made to the asset you checked out. This captures a snapshot of the asset.
2. **Plus Sign:** A new asset added to Unreal Revision Control.
3. **Checkmark:** A checked-out asset.
4. **Keep Files Checked Out:** Selecting to keep the files checked out means that the files will still be checked out to you even after you submit your changes.
5. **Submit:** Submits the changes to Unreal Revision Control.
6. **Cancel:** Cancels the snapshot and takes you back to the project.

After changes are saved then successfully submitted, your teammates will be able to sync to the new project version. The project thumbnail updates for all team members with the download icon on the project thumbnail, informing them the project needs to be synced.

There is a difference between saving your project and checking-in changes. Saving your project saves the project to your disk where checking-in your changes creates a historical snapshot of the project at a moment in time.

These snapshots provide a history for your project assets you can later review to understand how and why an asset was changed, and by whom, over time.

[![Check an assets history by right-clicking on the asset and selecting History.](https://dev.epicgames.com/community/api/documentation/image/5af5f420-23e5-4086-9786-4a41e34ebb1e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5af5f420-23e5-4086-9786-4a41e34ebb1e?resizing_type=fit)

## Check Out a Project Asset

Checking out an [asset](unreal-editor-for-fortnite-glossary#asset) locks that asset from being edited by another teammate. Whoever first checks out the object has control of it as long as it is checked out.

[![The Check-out popup contains the asset names that you have checked-out.](https://dev.epicgames.com/community/api/documentation/image/c65aacd6-531a-4585-838d-47dd00917bdb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c65aacd6-531a-4585-838d-47dd00917bdb?resizing_type=fit)

To check out an individual asset:

1. Right-click on the asset thumbnail to open the asset menu.
2. Select **Revision Control** > **Check Out**.

   [![Select Source Control from the asset menu to check-out the asset for editing.](https://dev.epicgames.com/community/api/documentation/image/a6322074-200d-4ea3-a3ca-74933e6e1953?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a6322074-200d-4ea3-a3ca-74933e6e1953?resizing_type=fit)

The asset is now checked out to you and the asset thumbnail updates with a red checkmark. Teammates see a different icon on the thumbnail that lets them know the asset is checked out.

[![Checked out assets have a red checkmark on the thumbnail.](https://dev.epicgames.com/community/api/documentation/image/e6cf9aff-0e2f-41e5-8213-a434cd204e58?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e6cf9aff-0e2f-41e5-8213-a434cd204e58?resizing_type=fit)

After the object is checked in, anyone with access to the project will need to sync to the latest project version to edit the asset.

From the right-click menu you can also do the following:

| Feature | Description |
| --- | --- |
| **Sync And Check Out** | Syncs your project and checks out the asset. |
| **Mark For Add** | Marks an asset for addition to the project. |
| **History** | Opens a window that shows the edit history for the selected asset or project.  [An example of the history window.](https://dev.epicgames.com/community/api/documentation/image/97186138-04cd-4fc2-a0ae-a4333b5cc4bf?resizing_type=fit)  *Click to enlarge image.* |
| **Revert** | Reverts the selected file back to its previous state. |
| **Merge** | Merges two selected asset files together. |
| **Refresh** | Refreshes the selected assets's status. |

## One File Per Entity with Scene Graph

**One File Per Entity (OFPE)** for Scene Graph projects is now in Beta. Until now, edits to Scene Graph entities would lock the entire project file when using Unreal Revision Control (URC), making collaboration very difficult. By saving each entity in its own asset file, OFPE enables multiple collaborators to work in parallel on projects using Scene Graph with fewer conflicts.

### Enable OFPE In Your Project

To enable OFPE in your Scene Graph project, follow these steps.

1. In the Toolbar, click **Project** and select **Project Settings**.

   [![](https://dev.epicgames.com/community/api/documentation/image/1aed5696-649d-44e8-bc76-a52a3b6a9ebb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1aed5696-649d-44e8-bc76-a52a3b6a9ebb?resizing_type=fit)
2. In the Project Settings, click to expand the Beta Access section. Click to check the box for **One File Per Entity**.

   [![](https://dev.epicgames.com/community/api/documentation/image/6d22f70c-3070-40c8-bca4-71ea8e60bce9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d22f70c-3070-40c8-bca4-71ea8e60bce9?resizing_type=fit)
3. In the **Outliner**, right-click the top level of your project to open the context menu. Under Level Entity, select **Save Owned Entities as External Files**.

   [![](https://dev.epicgames.com/community/api/documentation/image/4916410f-ed64-4875-9c00-4412be852cd7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4916410f-ed64-4875-9c00-4412be852cd7?resizing_type=fit)
