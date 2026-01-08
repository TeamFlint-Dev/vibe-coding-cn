# Snapshot History and Conflict Resolution

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/snapshot-history-and-conflict-resolution-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T22:58:16.632275

---

Unreal Revision Control (URC) lists all submitted [snapshots](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#snapshot) from the beginning of the project in the **Snapshot History tab**. This tab allows you to quickly find important snapshot information, asset conflicts, and filter snapshots by date.

When you press **Sync Latest**, the conflicts found cause a conflict change popup message. Opening the **Conflict Resolution tab** provides a way for you to view which assets are in conflict and open all asset changes made in the [viewport](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#viewport) or the associated asset editor.

After reviewing the asset changes, select which change to use as the current state of the project from the Conflict Resolution tab. This easily resolves the asset in conflict and creates a new snapshot for the project state.

These features reduce project blockers and free teammates to resolve conflicts independently. Conflict resolution results in a new snapshot in the Snapshot History tab where team members can view all snapshots and resolved conflicts.

## Snapshot History Tab

Open the Snapshot History tab by selecting **Revision Control** > **View Snapshot History**.

[![Open the Snapshot History tab from the Revision Control button.](https://dev.epicgames.com/community/api/documentation/image/d6925bad-074a-4555-8e22-04d040af4ed9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d6925bad-074a-4555-8e22-04d040af4ed9?resizing_type=fit)

Double-click on a snapshot or click on the **Expand icon** to open the snapshot details. Here you can view the asset and its state as well as the date and time of the change.

[![Expand the snapshot by double-clicking on it or clicking the expand icon.](https://dev.epicgames.com/community/api/documentation/image/08823a56-ab54-4fe3-b1ad-bc2820424528?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/08823a56-ab54-4fe3-b1ad-bc2820424528?resizing_type=fit)

You can work with the Snapshot History tab open. From the top of the tab you can check in changes, sync to the latest snapshot, and filter snapshots to a particular time stamp.

[![Filter your snapshot view, sync to latest and check in changes from the Snapshot History tab](https://dev.epicgames.com/community/api/documentation/image/39ad0e81-cbfe-4d2e-a810-1ab6e3dbd4cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/39ad0e81-cbfe-4d2e-a810-1ab6e3dbd4cb?resizing_type=fit)

As you add assets and actors to your project, the **Check in Changes** button highlights. Click the button to submit a new snapshot. The new snapshot is added to the top of the snapshot history list.

View an earlier snapshot by clicking on the **Rewind icon**.

[![](https://dev.epicgames.com/community/api/documentation/image/dd7156dc-1e01-4810-a7e0-58cce723ab17?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd7156dc-1e01-4810-a7e0-58cce723ab17?resizing_type=fit)

After syncing to the latest you can also find assets in conflict from the Snapshot History tab. Conflicts in the list appear with the conflict icon and the number of conflicts in the snapshot.

[![Conflicts in the list have the conflict icon and the number of conflicts in the snapshot.](https://dev.epicgames.com/community/api/documentation/image/1dab5b9b-fe16-4bac-9951-58787e45206d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1dab5b9b-fe16-4bac-9951-58787e45206d?resizing_type=fit)

You can view the assets in conflict by clicking on the conflicts in the right-hand side of the list.

### Rewind Snapshot

The **Rewind Snapshot** feature allows you to return to an earlier snapshot and continue working from a previous point in the snapshot history. You might want to return to an earlier snapshot if you’re not satisfied with the changes made after a previous snapshot.

Rewinding snapshots ignores all the changes made from the selected point in the snapshot history to the current snapshot you’re working on.

Use Rewind Snapshot by doing the following:

1. Select a snapshot from the **Snapshot History** and click the **Rewind** icon. A new button option appears on the Snapshot History tab and the bottom toolbar, Restore as Latest.

   [![An example of the rewind icon.](https://dev.epicgames.com/community/api/documentation/image/6c05441b-1b8b-48af-8353-d112888459b4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c05441b-1b8b-48af-8353-d112888459b4?resizing_type=fit)
2. Click the **Restore as Latest** button. The Restore as Latest window opens.

   [![The Restore as Latest buttons.](https://dev.epicgames.com/community/api/documentation/image/0af00143-6349-4679-9fee-fd2041dba0d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0af00143-6349-4679-9fee-fd2041dba0d0?resizing_type=fit)
3. Provide a reason for returning to the previous snapshot and a description of the snapshots that will be replaced.
4. Click the **Restore as Latest** button at the bottom of the window.

   [![An example of the Restore as Latest window.](https://dev.epicgames.com/community/api/documentation/image/44809f15-6d57-4d66-abd6-e3ccf4496573?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/44809f15-6d57-4d66-abd6-e3ccf4496573?resizing_type=fit)

The snapshots between the selected point in the Snapshot History and the current snapshot you’re working on will become greyed out and a perforated line appears beside the ignored snapshots.

[![An example of ignored snapshots.](https://dev.epicgames.com/community/api/documentation/image/72bae9df-9b18-478a-989c-168e30ac494b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/72bae9df-9b18-478a-989c-168e30ac494b?resizing_type=fit)

You can sync to an ignored snapshot in the snapshot history timeline simply by selecting to return to a snapshot that is greyed out.

## Asset Level Actions

Asset level actions provide a way for editing assets from the snapshot history. Expand the snapshot to view the assets within the snapshot. Hovering on an asset in the Snapshot list equips asset level editing tools. Click on an editing icon to use the tools.

[![Expand the snapshot to view the assets within the snapshot.](https://dev.epicgames.com/community/api/documentation/image/42674fef-2cf1-4fe9-8b5d-8f4c4ceb13a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42674fef-2cf1-4fe9-8b5d-8f4c4ceb13a2?resizing_type=fit)

Each of the tools serve different purposes:

- Snapshot centric editing
- Open the asset in the Content Browser
- View asset dependencies

[![Hovering on an asset equips asset level editing tools.](https://dev.epicgames.com/community/api/documentation/image/3984b952-653a-404d-ba83-f9fb1171d9da?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3984b952-653a-404d-ba83-f9fb1171d9da?resizing_type=fit)

### Snapshot Editing

Snapshot editing can be done on the asset level. There are two options for snapshot editing on the asset:

1. Sync to Snapshot Number
2. View in Current Snapshot

Sync to Snapshot Number means syncing the asset to that snapshot. View in Current Snapshot provides a way to view the asset in the Viewport at that snapshot level. To select from the list, click on the editing icon, then your selection.

[![click on the editing icon and choose between Sync to Snapshot Number and View in Current Snapshot.](https://dev.epicgames.com/community/api/documentation/image/1524d322-dbd1-4f93-aa4f-e8869f57bbf0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1524d322-dbd1-4f93-aa4f-e8869f57bbf0?resizing_type=fit)

### Open the Content Browser

Selecting to open the asset in the Content Browser will open the Content Browser with the asset pre-selected.

### View Dependencies

Some assets have dependencies which can undo changes to other assets. This view provides a way for you to view all dependencies and make an informed decision before syncing an asset to an outdated snapshot, or making changes to the asset from that snapshot.

Select the link icon to open the Dependency Viewer and review all the dependencies for the asset.

[![Selecting the link icon opens the dependency viewer.](https://dev.epicgames.com/community/api/documentation/image/533dc969-b7c7-48ff-afba-887481355bd9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/533dc969-b7c7-48ff-afba-887481355bd9?resizing_type=fit)

## Conflict Resolution

Resolving conflicts can only be done from the Conflict Resolution tab. The tab only appears when you have assets in a state of conflict. There are four different types of conflicts that can be resolved from the Conflict Resolution tab:

1. Changes you made after losing connection and working offline on an asset.
2. Changes you made with **Auto Checkout** turned off and working on assets without syncing to the latest snapshot or without checking in your changes.
3. When you make changes to project files from Windows Explorer.
4. Two teammates working on the same Verse code.

Clicking **Sync to Latest** reveals asset conflicts. Attempting to sync your project files when there’s a conflict with an asset results in a **Conflicting Changes popup message**. You can start to resolve the conflict by clicking the **Review Conflicts** button on the popup message.

[![](https://dev.epicgames.com/community/api/documentation/image/af675405-d5cb-4647-bd02-715f28745b58?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/af675405-d5cb-4647-bd02-715f28745b58?resizing_type=fit)

This opens the **Conflict Resolution tab** where you’ll resolve the conflict by choosing whether to save the snapshot of your changes or the snapshot of your colleague’s changes. At the top of the tab list, you can select between **All Mine** and **All Theirs**, or you can select which individual changes should be kept from All Mine or All Theirs.

Asset conflicts are represented by two thumbnails. You can select an asset change from the conflict list and click **Reload level to preview**. The changes made to the asset appear in the associated asset editor or in the viewport. Once you select which changes you’re keeping, click **Resolve Conflict**.

[![Select which changes you’re keeping and select Resolve Conflict.](https://dev.epicgames.com/community/api/documentation/image/5cd1a1e2-cfc1-4225-ba17-4ed13b7c17d9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5cd1a1e2-cfc1-4225-ba17-4ed13b7c17d9?resizing_type=fit)

To further examine the information for each thumbnail, click on the expand icon next to the asset name, this opens the conflict view. Each thumbnail becomes more detailed to provide a brief look at the changes applied to the asset by each team member.

[![Expand the asset conflict to get more information about the asset and the changes made.](https://dev.epicgames.com/community/api/documentation/image/3ddb22ac-f0eb-43af-acb0-492cab6dd050?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ddb22ac-f0eb-43af-acb0-492cab6dd050?resizing_type=fit)

On each thumbnail there are three icons:

[![The conflict thumbnails become more detailed and have clickable icons on them.](https://dev.epicgames.com/community/api/documentation/image/573f3f63-0cd6-4401-9718-fd9647537c24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/573f3f63-0cd6-4401-9718-fd9647537c24?resizing_type=fit)

1. **Focus Icon** - Finds and focuses on the asset in the viewport.
2. **Folder Icon** - Shows the asset in its folder in the Content Browser.
3. **Link Icon** - Displays the **Dependency Tree** with all the changes applied to the asset and what other assets are affected by this change.

You can view a summary of changes in the **Conflict Details panel** by clicking the expand icon next to Summary at the bottom of the asset preview window in the tab. This shortcut allows you to review the difference between the changes you made and those made by your teammate. The summaries reveal the following information about the changes:

- Size
- Asset
- Date of change
- Snapshot description
- Snapshot ID

[![Open the Conflict Details panel to preview more information about the asset in conflict.](https://dev.epicgames.com/community/api/documentation/image/49d31d81-de56-4339-a741-cdba8799e576?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/49d31d81-de56-4339-a741-cdba8799e576?resizing_type=fit)

### Choose Mine, Choose Yours

View your teammate’s asset changes in the [viewport](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#viewport) by selecting the thumbnail representing their changes and clicking the **Reload level to preview** button at the bottom of the **Conflict Resolution tab**. The changes they made to the asset appear in the viewport.

You can use the icons on the thumbnail or open the **Conflict Details** panel to review more information about the asset change while you examine the changes your colleague made to the asset.

View your changes by clicking on the thumbnail representing your changes and clicking the **Reload level to preview** button at the bottom of the **Conflict Resolution tab**. This produces a side-by-side comparison of the asset changes in the viewport.

Decide which asset change to promote, select the thumbnail representing those changes, then click the **Resolve Conflict** button at the bottom of the tab. A snapshot description window opens. Add a brief description of the conflict resolution and the snapshot being promoted, then click **Submit** to add the snapshot to the Snapshot History list.

### Choose Mine, Choose Yours in Verse

Verse conflicts do not appear as thumbnails and can’t be found in the Snapshot History list. Opening **Visual Studio Code** and making changes to a file without syncing to latest first will put you into a conflict state if a colleague has already made changes to the file before you.

[![Example of a Verse conflict state.](https://dev.epicgames.com/community/api/documentation/image/f4fc587e-cba4-456c-bef8-8198b5be133f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f4fc587e-cba4-456c-bef8-8198b5be133f?resizing_type=fit)

Click either the **Check in Changes** or **Sync to Latest** button at the bottom of the UEFN screen to reveal the conflict warning popup message. Click **Review Conflict** or **Review** icon to open the **Conflict Resolution tab**.

Click **Resolve in VS Code** button in the **Conflict Resolution tab**. The conflicting Verse files open in Visual Studio Code in a three-way merger window. One set of changes is in green on the left, the other changes are in purple on the right, and the current state of the file is in yellow on the bottom of the window.

[![VS Code opens in a 3-way merger window so you can review all changes side-by-side.](https://dev.epicgames.com/community/api/documentation/image/31c6cf3f-5075-4f1b-98a0-f464094c1f66?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/31c6cf3f-5075-4f1b-98a0-f464094c1f66?resizing_type=fit)

*Click image to enlarge.*

Clicking on the overflow menu of the changes on the left, right, and current state of the Verse file reveals different options.

On the left you can select **Accept All Changes from Left** to accept the changes to the Verse file on the left. On the right you can select **Accept All Changes from Right** to accept the changes to the Verse file on the right, or compare the changes from the left or right against the base file at the bottom. On the current version you can select **Reset** to reset the file.

|  |  |  |
| --- | --- | --- |
|  |  |  |
| Resolve Left | Resolve Right | Reset |
| *Click image for full size.* | *Click image for full size.* | *Click image for full size.* |

Resolve the conflict by selecting a file to accept the changes and put the file in a resolved state. Next click the **Resolve Conflict** button to save the changes to the project. Afterward, you’ll go through the URC workflow of creating and submitting a snapshot.
