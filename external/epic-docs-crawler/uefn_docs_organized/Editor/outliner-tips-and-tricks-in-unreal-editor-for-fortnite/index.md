# Outliner Tips and Tricks

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/outliner-tips-and-tricks-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:21:33.146462

---

The **Outliner panel**, or **Outliner** for short, displays all [actors](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#actor) within a scene in a hierarchical view. You can save time when working in **Unreal Editor for Fortnite (UEFN)** by using the Outliner shortcuts below.

## Make Copies

Creating landscapes or building structures can be monotonous work, especiallly if you're dragging the same [prop](unreal-editor-for-fortnite-glossary#prop) over and over from the [Content Drawer](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-drawer). Instead, use the following workflow to increase your productivity.

[![Make copies of Actors in the Outliner](https://dev.epicgames.com/community/api/documentation/image/c307ae74-87d7-4049-a158-4db855716953?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c307ae74-87d7-4049-a158-4db855716953?resizing_type=fit)

1. Create a group of props by selecting and dragging two or more props from the **Content Drawer** at the same time. They will appear in the [viewport](unreal-editor-for-fortnite-glossary#viewport), and also appear in the Outliner panel.
2. Press and hold **Shift** while selecting props from the Outliner. A gold outline appears around a selected prop in the viewport.
3. Press **Ctrl + C** to copy the selected props, and **Ctrl + V** to paste them.
4. Use the **directional arrows** for the **[pivot point](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#pivot-point)** to place the copied props where you want them.
5. Repeat these steps to create large buildings or expansive landscapes.

Another quick way to copy props is to press and hold **Alt** while [translating](unreal-editor-for-fortnite-glossary#translate) the props you have selected in the viewport.

[![copy floor tiles](https://dev.epicgames.com/community/api/documentation/image/3bb5e6fc-3774-4812-9716-c4a0cc18abbb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3bb5e6fc-3774-4812-9716-c4a0cc18abbb?resizing_type=fit)

## Hide and Reveal Prop Groups

If you are designing a visually engaging experience and need to concentrate on a specific part, you can hide the assets you're not currentely working on.

[![Use the Outliner to hide Actors in the Viewport](https://dev.epicgames.com/community/api/documentation/image/a34caf49-908a-4180-a495-b585e80ef8da?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a34caf49-908a-4180-a495-b585e80ef8da?resizing_type=fit)

1. Press and hold **Ctrl** while selecting multiple items from the Outliner. A gold outline appears around the selected prop.
2. Press **H** to hide the selected items.

To show hidden items again:

1. Press and hold **Ctrl** while selecting the items from the Outliner.
2. Press and hold **Shift** and press **H**. All items will reappear in the viewport.

## Duplicate Objects

Quickly duplicate objects by doing the following:

[![Create Actor duplicates in the Outliner](https://dev.epicgames.com/community/api/documentation/image/f141a84c-0407-41d5-b788-6bee08e414ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f141a84c-0407-41d5-b788-6bee08e414ca?resizing_type=fit)

1. Select the object in the Outliner, a gold outline surrounds the object.
2. Press **CTRL + D**. The object will duplicate in the Viewport.

## Rename Objects

To rename an object in the Outliner:

1. Select the object in the Outliner.
2. Press **F2**. A name field will open in the Outliner over the object name.
3. Type a new name. The new name is automatically saved in the Outliner.

[![Renaming Actors in the Item Label](https://dev.epicgames.com/community/api/documentation/image/28d3a09f-5cde-40ca-9635-44afdd88bd4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/28d3a09f-5cde-40ca-9635-44afdd88bd4e?resizing_type=fit)

## Group Actors

Group props or other actors together to edit, move, and transform as a group.

1. Select the props or actors you want to group together from the Outliner.
2. Press **Ctrl + G**. A new Item Label will appear in the Outliner panel.

[![Group Actors together in the Outliner](https://dev.epicgames.com/community/api/documentation/image/98e2cfaa-b6e3-4995-b754-30f083ccf1b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/98e2cfaa-b6e3-4995-b754-30f083ccf1b7?resizing_type=fit)

To ungroup, select the group, then press **Ctrl + G** again. The group will separate into individual actors.

To prevent grouped actors from being edited, moved, or transformed:

1. Right-click on the group and select **Transform > Lock Actor Movement**. A checkmark will appear next to the selection. This will lock the group to its position in the viewport.
2. To unlock the group, repeat the first step. The checkmark will disappear.

## Create a Folder

You can create folders in the Outliner to organize your work.

1. Select the actors from the **Item Label** column in the Outliner you want in the same folder.
2. Click the **Folder** icon at the top of the Outliner.
3. Name your folder.

The selected actors are automatically added to the new folder.

[![Automatically add Actors to your folder in the Outliner](https://dev.epicgames.com/community/api/documentation/image/a13e6375-a5ce-4694-ac09-c17ed215dfd5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a13e6375-a5ce-4694-ac09-c17ed215dfd5?resizing_type=fit)

## Group Edits

Edit a group of devices by selecting them in the Outliner then editing their device options in **World Settings**. This only works when the selected devices are all the same. After editing the devices in World Settings, save your changes.
