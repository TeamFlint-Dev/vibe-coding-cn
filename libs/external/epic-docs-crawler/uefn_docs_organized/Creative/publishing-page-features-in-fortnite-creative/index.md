# Project Publishing Page

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/publishing-page-features-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:14:12.641080

---

Each project has its own Publishing page where you’ll find everything you need to successfully publish your island, and manage it throughout the publishing lifecycle.

Click **Projects** from the Creator Portal sidebar menu to open the **Projects** page.

[![Open the Projects page, and click the tile for the project you want to see information for.](https://dev.epicgames.com/community/api/documentation/image/17c6d6f7-3e87-4579-aceb-87bf35fd80e4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17c6d6f7-3e87-4579-aceb-87bf35fd80e4?resizing_type=fit)

This page contains all your personal or team projects, depending on whether you have a team selected or "No Team (Just Me)". Each project has a project tile, which you click to open the **Publishing** page for that project. You can use the [Project Navigation menu](https://dev.epicgames.com/documentation/en-us/fortnite/project-navigation-menu-in-fortnite) to view other information about the selected project.

[![Selecting a project opens that project's Publishing page.](https://dev.epicgames.com/community/api/documentation/image/20ff253b-9d36-4ef0-a7f5-cf24be6872c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/20ff253b-9d36-4ef0-a7f5-cf24be6872c1?resizing_type=fit)

When you are on any of the project-specific pages in Creator Portal, you will see the top-level menu options in a vertical toolbar on the left side of the screen. With this, you can navigate between project-specific information and account-wide information.

[![The top-level Creator Portal menu is minimized when you are on a project-specific page.](https://dev.epicgames.com/community/api/documentation/image/0a56411f-6b09-4226-a09b-6497a114a19f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0a56411f-6b09-4226-a09b-6497a114a19f?resizing_type=fit)

  The Project Publishing page has three tabs: **Releases**, **Playtests**, and **Private Versions.**

## Releases

[![Image of the Releases tab, with Discover Performance snapshot, Published section, and Unpublished section.](https://dev.epicgames.com/community/api/documentation/image/023bc11e-fe7a-46a3-8048-0e168ad78807?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/023bc11e-fe7a-46a3-8048-0e168ad78807?resizing_type=fit)

This tab lists the current release and unpublished past releases of this island. Unlisted projects will also be displayed in the Release tab, and the island code associated with an unlisted project can be shared with anyone. Listed islands are eligible to be surfaced through the Discover page in Fortnite. You can manage the releases of your project from this tab.

### Released Project States

Releases can be in one of three states: **Listed**, **Unlisted**, and **Unpublished**.

- **Listed**: This means your project has successfully passed moderation, and it is available for people to find in Discover. Listed projects will appear on your Creator Page in Fortnite. Listed islands are displayed on the project's Publishing page under **Published**.
- **Unlisted**: This means your project has successfully passed moderation, and it has an island code, but is not available in Discover. An unlisted version of your project will still be displayed under **Published**, since it is available to anyone who uses its island code.
- **Unpublished**: This means your project isn't published and isn't available for people to play. These islands are still being worked on and don’t have a live island code assigned to them. If you create an updated version of a listed island and it passes moderation, the previous version will also be displayed under **Unpublished**.

### Discover Performance Snapshot

Above the lists of releases, you will see a box that displays a snapshot of your listed island's performance in Discover. You will see statistics for impressions, clicks, click-through rate (CTR), average session length, and the percentage of sessions lasting more than ten minutes.

You can view more detailed analytics for your listed island by clicking the **View Analytics** button at the bottom of the snapshot box, or by clicking **Analytics** in the Project Navigation menu.

[![Click the View Analytics button in the Discover Performance Snapshot, or click Analytics in the sidebar.](https://dev.epicgames.com/community/api/documentation/image/6236c64e-714c-48df-9f18-377cce1f2de7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6236c64e-714c-48df-9f18-377cce1f2de7?resizing_type=fit)

### Published

Projects that have passed moderation are considered published, and are listed in this section of the Publishing page.

A project's island code can only have one published release at a time. This applies whether that published release is listed or unlisted.

### Unpublished

Any versions of your project that have not been submitted for moderation are listed here, along with previously published versions that were replaced by an updated version.

## Playtests

[![You can create and manage playtests on this tab of the Publishing page.](https://dev.epicgames.com/community/api/documentation/image/cce7432b-fda6-4198-b670-e04299c0c149?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cce7432b-fda6-4198-b670-e04299c0c149?resizing_type=fit)

On this tab, you can [create a playtest](https://dev.epicgames.com/documentation/en-us/fortnite/playtesting-your-island-in-unreal-editor-for-fortnite) for a private version of the project. This will generate a special playtest island code that you can give to a selected group of playtesters. If you have created a playtest for this project, you can manage it on this tab. You can also change the private version used for your playtest on this tab. For more information see [Adding Playtesters](https://dev.epicgames.com/documentation/en-us/fortnite/adding-playtesters-in-fortnite-creative).

## Private Versions

Any private versions of this project you have created are listed on this tab. You can create a private version of your project in Creative, or in UEFN.

In UEFN, click the **Project** dropdown in the Toolbar, and select **Publish Project**. In Creative, navigate to **Island Settings** and in the **Overview** category click **Publish Island**. Either method will create a private version island code.

If you use the [In-Island Transactions feature](https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-in-fortnite), you can check the list of products offered in your island.

[![Click View Products to open a list of products in your project.](https://dev.epicgames.com/community/api/documentation/image/36ccc5b4-fbbe-4f2a-803e-25dd19b43f32?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36ccc5b4-fbbe-4f2a-803e-25dd19b43f32?resizing_type=fit)

Click **View Products** in the line for that private version to open a pop-up window with the list of products.

[![Products you have in this private version are listed in a pop-up box.](https://dev.epicgames.com/community/api/documentation/image/1b78ff32-97f6-4597-8a3c-a3f62436cff9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1b78ff32-97f6-4597-8a3c-a3f62436cff9?resizing_type=fit)

### Review States

## Failed Review
