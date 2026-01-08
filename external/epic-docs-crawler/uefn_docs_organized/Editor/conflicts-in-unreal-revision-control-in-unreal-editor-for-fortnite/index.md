# Conflicts in Unreal Revision Control

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/conflicts-in-unreal-revision-control-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T22:56:16.319791

---

A revision control conflict occurs when an individual tries to submit changes made to the local version of their project that cannot be reconciled with the latest source of truth in revision control.

This can happen for a handful of reasons, but most commonly is due to an individual making changes to a portion of a team project that a teammate has since made changes to. Submitting their changes without first syncing the changes of their collaborators causes a conflict.

The best way for you and your teammates to avoid conflicts is to keep auto checkout and auto undo enabled. Use [revision control best practices](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-revision-control-best-practices-in-unreal-editor-for-fortnite#best-practices) to reduce project conflicts and better understand how [revision](unreal-editor-for-fortnite-glossary#revision) control works.

## Conflict Prevention Warnings with Auto Checkout and Auto Undo

Unreal Revision Control helps avoid most conflicts by enabling auto checkout and auto undo by default when a project is created using [revision control](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#revision-control).

These features work together to automatically attempt to check out an asset when a change is made to it, and automatically undo the change if the checkout fails. The system triggers a warning that this has occurred in order to prevent a conflict from occurring.

These warnings trigger primarily in the following two scenarios:

### Attempting to make changes to assets that are checked out by a teammate

If you attempt to make changes to an asset that is currently checked out by a teammate, the changes are automatically undone to prevent you from making changes to assets that your teammate has exclusively checked out.

You do not need to take any action when this happens because the conflict has already been avoided, but if you need to make changes to the asset in question it is best to coordinate with your teammate to check it back in, sync their latest changes, and proceed with your own.

The first time this occurs you will see the following warning modal, informing you which of your changes have been undone and to whom they are checked out. If you wish to see this every time, uncheck the “Don’t show me this again” checkbox.

Subsequently, a toast notification will inform you anytime this occurs.

### Attempting to make changes to assets are not synced to the latest version

If you attempt to make changes to an asset for which you have not yet synced the latest version, the changes are automatically undone to prevent you from making changes that you cannot check in later.

In this case, simply sync latest and proceed with your changes.

The first time this occurs will see the following warning modal, informing you which of your changes have been undone. If you wish to see this every time, uncheck the “Don’t show me this again” checkbox.

Subsequently, a toast notification will inform you anytime this occurs.

## Conflict Error Messages

Conflicts are most common when Auto Checkout and Auto Undo are turned off. Circumstances that cause conflicts in Unreal Revision Control, include:

- Not syncing frequently to latest
- Making changes without first checking out an asset
- Working offline

The following sections cover conflict errors and common causes that you may encounter.

### Not at Latest Conflicts

One type of conflict occurs when you attempt to sync latest or check in changes and have made changes to an asset that has been changed and checked in by someone else in a snapshot that is newer than the one you’ve most recently synced.

A conflict occurs in this case because you’ve made changes to an outdated version of the asset.

In this case, you receive an error message informing you which asset(s) are in conflict and who made the latest changes to them that you must sync. Your only option to resolve the conflict is to sync the latest changes and overwrite yours.

Once you sync latest and overwrite, you may check out the assets you wish to change and subsequently make and check in your changes.

### Checked Out Asset Conflicts

Another type of conflict occurs when you have made changes to an asset that is currently checked out by someone else and attempt to sync latest or check in changes.

The conflict occurs because you’ve made changes to something that you do not have the right to edit since it is exclusively checked out by a teammate.

In this case, you receive an error informing you which asset(s) you have changed that you do not have checked out and instructions to coordinate with your teammate.

If you wish to disregard your change, you can revert your changes to individual conflicting assets via the revision control context menu and reattempt the Sync or Check in.

### Duplicate Asset Conflicts

A third and rare type of conflict can occur If two teammates accidentally create assets with the same name and file path and try to save and check in these objects independently. The first person to check in will be successful, and the second person will receive an error message.

Renaming the second object is the best course of action that does not result in erasing the object. An alternative would be changing the asset’s location in the project’s hierarchy because as long as the file path is different, no conflicts will occur.

## Working offline

Although some work can continue to a UEFN project while offline, this is not advisable. Working offline runs the risk of causing conflicts with colleagues because assets cannot be checked out without an internet connection and two people may end up working on the same thing at once.

If you work offline, it is recommended to:

- Communicate with your teammates beforehand what you intend to work on and if possible check out any assets before losing connection.
- Re-establish your internet connection as soon as possible, sync to latest, and check in any changes you’ve made.
