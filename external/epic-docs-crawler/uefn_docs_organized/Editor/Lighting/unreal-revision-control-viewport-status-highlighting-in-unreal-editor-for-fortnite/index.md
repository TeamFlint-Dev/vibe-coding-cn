# Unreal Revision Control Viewport Status Highlighting

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/unreal-revision-control-viewport-status-highlighting-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:01:23.558547

---

As a creator working with your collaborators, you want instant insight into how your project is evolving at a given time. Revision Control Status Highlighting provides a lens, directly in the viewport, into what your team members are working on, whether certain actors have newer versions, or which actors have been added or modified by you.

[![An example of status highlighting in red, green, and blue.](https://dev.epicgames.com/community/api/documentation/image/1e1970ca-8cb9-453f-b71b-b0a1d5ca6cf4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e1970ca-8cb9-453f-b71b-b0a1d5ca6cf4?resizing_type=fit)

## Default settings

When you open a level, you will see a red highlight (the same color as the corresponding revision control icon) on actors if they are checked out by one of your team members. Hovering on the actor will display a tooltip with the username of the team member who has this actor checked out.

[![An example of an asset checked out my a teammate.](https://dev.epicgames.com/community/api/documentation/image/e7835e6b-ca28-4154-8c24-242dfcaf4066?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7835e6b-ca28-4154-8c24-242dfcaf4066?resizing_type=fit)

Yellow highlights indicate actors that have been updated in snapshots you haven’t yet synced, giving you a sneak peek at what will change when you sync to the latest. When you see yellow highlights, you can either sync to the latest or simply avoid working on that asset to prevent losing any potential changes.

## My changes

If you want to visualize your own local changes within the viewport, you can turn on "✔ **Checked Out by Me**" or “+ **Newly Added**” within the **Show Revision Control** settings dropdown to highlight actors you’ve checked out or those you’ve added but not yet submitted to revision control.

[![Status Highlights options.](https://dev.epicgames.com/community/api/documentation/image/37e3612a-aa5a-4293-9d23-d3c32329c23c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/37e3612a-aa5a-4293-9d23-d3c32329c23c?resizing_type=fit)

## Highlight visibility

If all of these highlight colors are too distracting for you, you can disable/reduce their visibility in one of a few ways:

1. Disable **GameView** (shortcut G)to turn off the visibility of the highlight colors.
2. Turn off the status URC highlights by unchecking the checkbox or clicking the **Hide All** menu item.
3. Select the actor you are interested in, as we do not render the highlight when you have the actor selected.
4. Lower the **Opacity** input of the Status Highlights menu to make it less opaque within the viewport.

## Filter actors in the outliner by URC status

Highlighting and filtering by revision control status aren't just reserved for the viewport. You can also filter the outliner by Revision Control status. This can simplify reverting actors you do not want to submit or help with inspecting actors you’ve modified to make sure you’re happy with the changes.

[![Filter actors by URC status.](https://dev.epicgames.com/community/api/documentation/image/9f1dca34-9c11-48db-b9e9-99b5e049e952?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f1dca34-9c11-48db-b9e9-99b5e049e952?resizing_type=fit)
