# Unreal Revision Control Extensions

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/unreal-revision-control-extensions-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:01:06.923240

---

The **Unreal Revision Control** (URC) extension for Visual Studio Code (VSC) provides instant revision control feedback in your Verse script and [Snapshot History](https://dev.epicgames.com/documentation/en-us/uefn/snapshot-history-and-conflict-resolution-in-unreal-editor-for-fortnite). The URC extension adds features and functionality that complement pre-existing VSC tools and makes tracking changes in Verse code easier for you and your team.

The extension allows you to view the snapshot history inside VSC and highlights all Verse code changes in the file editor and Explorer.

## Unreal Revision Control Extension

The URC extension is installed by default on VSC. To read information about the URC extensions, select **Extensions** from the left column menu. Different extensions appear in the left column of the VSC window. Selecting the **Unreal Revision Control extension** opens the extension window where you can read the list of extension features.

[![](https://dev.epicgames.com/community/api/documentation/image/0037de6a-a89d-4f8a-8a26-4e4c5ec2970f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0037de6a-a89d-4f8a-8a26-4e4c5ec2970f?resizing_type=fit)

## Source Control View

The URC extension captures all changes in the Verse code of your UEFN projects and enables you to view the snapshot history for all the changes in the Verse script.

The extension adds **Source Control** and Snapshot History panels to VSC. The **Source Control** panel records all uncommitted changes made to the Verse code since the project's last snapshot. All committed changes are recorded in the Snapshot History panel.

[![The Source Control panel.](https://dev.epicgames.com/community/api/documentation/image/69e06310-1e15-438d-9b36-a1fade045bdb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69e06310-1e15-438d-9b36-a1fade045bdb?resizing_type=fit)

Clicking on your Verse file from the **Source Control** panel opens your file in two side-by-side windows so you can review and compare the changes in your code. The window on the left is the current version of your code. The window on the left is the version you're synced to, the version on the right has your local changes.

[![Clicking on the changes you made opens a comparison window where you can see the changes you made vbersus the live content.](https://dev.epicgames.com/community/api/documentation/image/12710776-c904-4a85-8ec2-47d271b6ebc1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12710776-c904-4a85-8ec2-47d271b6ebc1?resizing_type=fit)

*Click image to enlarge.*

You can submit your changes to UEFN from the **Source Control** panel. Clicking on the **Create Snapshot** icon opens the editor’s **Submit File** window. Enter all the snapshot details into the **Changelist Description** field and click **Submit** to save a new snapshot.

[![Create a new snapshot from VSC.](https://dev.epicgames.com/community/api/documentation/image/f9b2adc3-21b6-49d4-aee1-9613e771cae3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f9b2adc3-21b6-49d4-aee1-9613e771cae3?resizing_type=fit)

You cannot sync to the latest snapshot from VSC, you must sync all changes in UEFN.

## Editor Windows

As you’re working on your Verse code, items that have been added, deleted, and modified appear in the **Source Control** panel. The place in the Verse script where the changes occurred becomes highlighted. This allows you to see the difference between your changes and the current file.

All changes are marked with a letter in the **Source Control** panel:

- **M** - Modified
- **A** - Added
- **D** - Deleted

[![Changes highlight in the code and are marked with a letter in the Source Control panel.](https://dev.epicgames.com/community/api/documentation/image/c1bf525e-6149-451a-9c99-5b7910b2623d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c1bf525e-6149-451a-9c99-5b7910b2623d?resizing_type=fit)

*Click image to enlarge.*

## File Level Changes

**File Level Changes** can change the way you edit and update code versions. Instead of working solely on the current version of code, browse older versions in your **File History**, and select to review an older file while editing a new file.

[![Instead of working solely on the current version of code, browse older versions in your **File History**, and select to review an older file while editing a new file.](https://dev.epicgames.com/community/api/documentation/image/c3d0f49c-fd95-4b48-8cb8-eb02facb4b36?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c3d0f49c-fd95-4b48-8cb8-eb02facb4b36?resizing_type=fit)

Use your project’s File History to open an existing file in a read-only mode to review older code files next to the new file versions. This provides you with the ability to compare your code changes live with an older version.

Read-only view opens new tabs beside the currently edited file to avoid overwriting the new file you’re working on.
