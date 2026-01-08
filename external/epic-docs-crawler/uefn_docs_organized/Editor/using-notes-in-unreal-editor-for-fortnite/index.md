# Using Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-notes-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:01:34.404960

---

Providing feedback to collaborators and reminders for yourself are key parts of the iterative project workflow. Notes is a feature within UEFN that brings this real-time feedback loop directly into the editor.

In this article, we’ll give an overview of the feature including *creating*, \_reviewing, \_and \_resolving \_notes.

## Creating Notes

Let’s start creating some notes! The easiest way to get started is by pressing the shortcut **C**. This will replace your cursor with a blue gizmo that aligns with the mesh you are pointing to. Click on the desired location within your level to create an **Anchored** note—a note attached to a specific object in your level.

[![The letter icon in the image represents a note left on an asset.](https://dev.epicgames.com/community/api/documentation/image/e055567f-8a08-48c8-be9d-c723d9435f8e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e055567f-8a08-48c8-be9d-c723d9435f8e?resizing_type=fit)

This will open the editing widget where you can type a description to give context to your note.

Notes do not get counted as part of your project memory calcualtion. Notes are a cloud feature that loads note data into transient actors that do not get saved as a file.

A simple description may be all you need since Notes are captured with a screenshot of the viewport at the time of creation as well as other contextual data to help you or your collaborators navigate back to the original perspective from which they were created. Simply click Create, and the note is immediately accessible to you and any collaborators working on the project.

[![Creating a note for the Taco sign.](https://dev.epicgames.com/community/api/documentation/image/9f50aafb-0ede-4ec3-a366-638913ecc76d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f50aafb-0ede-4ec3-a366-638913ecc76d?resizing_type=fit)

If you’d like to add additional context, whether before you create or through subsequent edits, you can optionally choose to attach additional actors, capture additional screenshots, or attach external images for reference.

[![Seelct the Attached Actors icon to take a screen shot of the asset for the note.](https://dev.epicgames.com/community/api/documentation/image/ad08d3ad-8480-4c21-83ed-185a2410d66e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad08d3ad-8480-4c21-83ed-185a2410d66e?resizing_type=fit)

When capturing more screenshots, you can choose to take a full viewport screenshot or a cropped one.

[![Taking a screen shot of the asset in Notes.](https://dev.epicgames.com/community/api/documentation/image/4c1fe6e9-96a8-44de-a45d-5f749f3cde6c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c1fe6e9-96a8-44de-a45d-5f749f3cde6c?resizing_type=fit)

*Click image to enlarge.*

There is also a second creation mode for notes other than Anchored notes called **Camera** notes—notes that are placed at the position of the viewport camera. They are especially helpful when reviewing cinematics or capturing feedback on an area of the map from the player's perspective. You can trigger the creation of a Camera note with the shortcut **Shift + C**.

Have trouble keeping track of shortcuts? No problem. You can also create both types of notes by using the right-click context menu in the viewport. Selecting either option immediately opens the note widget for editing.

[![Select Add Anchor Note to anchor a note to an asset.](https://dev.epicgames.com/community/api/documentation/image/c364f990-4c06-476a-a733-760c3f9c07f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c364f990-4c06-476a-a733-760c3f9c07f7?resizing_type=fit)

## Interacting with Notes in the viewport

Once you or your collaborators have created some notes, you’ll see note markers placed throughout the level. You can hover your cursor above the icon to see a small preview of the note.

[![An example of a note.](https://dev.epicgames.com/community/api/documentation/image/ba8b6b8d-abe8-4ad1-b0ca-5bfd94df6856?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba8b6b8d-abe8-4ad1-b0ca-5bfd94df6856?resizing_type=fit)

Clicking the marker will open up the note widget within the viewport and select the actors associated with the note. If you would like to view the note from the exact point of view from which it was created, click the **Reframe to Note** option in the widget’s context menu.

To review notes quickly, you can also page through a level’s notes sequentially by clicking the arrows toward the bottom right of a note widget. Each time you click, your viewport refocuses to the exact coordinates and orientation the selected note was created.

[![An example of an open note left by a colleague.](https://dev.epicgames.com/community/api/documentation/image/27d7f5a8-5f7b-40be-8d02-bb288289bdf2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/27d7f5a8-5f7b-40be-8d02-bb288289bdf2?resizing_type=fit)

[![The available Notes options.](https://dev.epicgames.com/community/api/documentation/image/762cf19e-2e8f-48c5-bc57-6b76cff467b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/762cf19e-2e8f-48c5-bc57-6b76cff467b1?resizing_type=fit)

An additional way to review notes is with the Notes panel, where you’ll see a list of all the notes within the level.

To open it you can either:

1. Click **Open in Notes Panel** from the context menu of a currently selected note in the viewport, or
2. Click **Notes** in the **Window** menu in the UEFN [menu bar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite).

Selecting a note in the side panel will open it in the viewport and align it to the viewpoint from which it was created.

[![An example of the Notes tab.](https://dev.epicgames.com/community/api/documentation/image/d6768acb-69d1-4c54-afc1-e5a16cadf924?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d6768acb-69d1-4c54-afc1-e5a16cadf924?resizing_type=fit)

By default, the side panel list will display all unresolved notes for the project. If you’d like to additionally review resolved notes or drill down into notes created by a particular subset of your team, you can change the list’s filters via the filter dropdown. Changing the filter applies to both the notes that appear in the list and the markers you see in the viewport.

[![An example of the available filters on Notes.](https://dev.epicgames.com/community/api/documentation/image/12bd2a41-4091-4278-8dea-22caf6e48559?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12bd2a41-4091-4278-8dea-22caf6e48559?resizing_type=fit)

If you’re using Unreal Revision Control in your project, your notes list also filters by default to only show Notes that were created in or before your currently-synced snapshot, since notes created in future snapshots are likely not relevant. You can override this filter if you wish by turning on the **Show Future Snapshot Notes** option.

[![Setting the Show Future Snapshot Notes feature.](https://dev.epicgames.com/community/api/documentation/image/581f2eb2-2e67-430c-8fa8-d151c3b9b9d9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/581f2eb2-2e67-430c-8fa8-d151c3b9b9d9?resizing_type=fit)

## Resolving Notes

A note’s life cycle ends when it is **Resolved**. Once the feedback in a note has been actioned and any tasks related to it have been completed, you can resolve it simply by clicking the **Resolve** icon with the Note outline with a check mark inside, found either on the viewport widget for a note or in the side panel. On unresolved notes, this icon will be gray and on resolved notes, it will be green.

With default filters applied, resolving a note makes it disappear from the Notes panel and the viewport. If you ever need to review resolved notes, showing them again is as simple as changing your Notes panel filter to include resolved notes. You can reopen a Note simply by clicking the **Resolve** icon again.

[![Examples of the Resolve icon status.](https://dev.epicgames.com/community/api/documentation/image/bfe6d1e8-4553-4a37-8a16-f184a2f8fcc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bfe6d1e8-4553-4a37-8a16-f184a2f8fcc0?resizing_type=fit)

*Click image to enalrge.*
