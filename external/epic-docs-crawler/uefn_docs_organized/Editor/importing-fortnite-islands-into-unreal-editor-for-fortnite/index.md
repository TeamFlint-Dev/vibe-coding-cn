# Importing Fortnite Islands

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/importing-fortnite-islands-into-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:55:48.047526

---

You can import an existing Fortnite island into **Unreal Editor for Fortnite (UEFN)** to upgrade the look and feel of your experience with the tools and editing power of UEFN.

You can also push the boundaries of your island design by adding [Verse devices and functionalities](/documentation/en-us/fortnite/uefnonly-devices-in-fortnite)  not available in **Creative**.

![How the FNC island looks before being imported into UEFN](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/4b18c577-97db-46d5-a15b-39a9f841f16e/creative-view.png)

## Import a Fortnite Island

Player data will not transfer from your Creative island to a UEFN project. If you revert your island back to its Creative state, your player data is retained.
![The warning popup inside UEFN](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/10838e23-5abd-4716-838f-365583fe1e81/save-point-warning.png)

Importing a Fortnite island into UEFN creates a **fork** in the editing access for a [project](/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#project). Once converted to UEFN, a Fortnite island project can only be edited within UEFN, using UEFN tools and features.

Whether you create islands in Fortnite or in UEFN, all of the islands you create show in both the UEFN project menu and the Fortnite island menu. Projects created in UEFN have the Unreal Engine icon next to the project in the menu in Fortnite.

Alternatively, Fortnite islands have a **download cloud icon** on the project thumbnail in UEFN.

In the image below, the project menu for UEFN is on the left, and the island menu for Fortnite is on the right.

[![undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/beb18d0f-6075-494c-b9bd-b5afeefcf52a/project-menus1.png)](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/beb18d0f-6075-494c-b9bd-b5afeefcf52a/project-menus1.png)

Click image to enlarge.

1. From the **UEFN Project** screen, select the thumbnail for the Fortnite island you want to import. You are automatically notified that selecting a Fortnite island for import will change the editing eligibility of the island by converting it to a UEFN project.
2. Click the **Convert** button. Your Fortnite island information will import into UEFN.

   ![Select the Fortnite island to import, then click the Open button.](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/70172cb4-d6c6-4431-b25b-e11cb3205edc/import-island1.png)

   Projects will be saved to your hard drive. Devices not supported by UEFN will not import with the project.
3. If any Creative devices do not import with the project files, you’ll receive a popup message asking if you want to continue. It will also display a list of devices that could not be copied into UEFN.
4. Click **Yes** in the Verse popup to enable Verse with your project.

![The Fortnite island is imported into UEFN.](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/19182546-17bd-419d-bd68-5eb1315a2bfe/imported-island1.png)

When the import process finishes, the project will be accessible through UEFN, and the project thumbnail will change to a UEFN thumbnail.

You’ll be able to playtest your island in a Fortnite client and play the island from your golden rift in Creative, but to make any changes to the island from Fortnite Creative, you must first open the project in UEFN.

The point when the UEFN version of the project becomes playable in Creative is after the first time it has been run ("Launch Session") from UEFN.

## Roll Back to Fortnite

You can revert your project back to a Fortnite island at any point through the [Creator Portal](https://fn.gg/island-creator). For example, you might want to revert if you’re not satisfied with the changes you made in UEFN and want to test game mechanics and device programming in another UEFN project before making final changes to your Fortnite island in UEFN.

![revert using Creator Portal](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/20c0e405-a11f-41d5-a544-63f7de19ab6c/revert-cp.png)

To use the Creator Portal, you must have a [Creator Profile](/documentation/en-us/fortnite-creative/join-the-island-creator-program-in-fortnite-creative).

1. Open the [Creator Portal](https://fn.gg/island-creator) and select **Publishing** from the side menu.
2. Select the project from the **Project Type: UEFN** panel. If the project is eligible to roll back to Fortnite, a drop down appears beside the project.
3. Click the drop down menu and select **Revert to Creative Project**.

You cannot convert a brand new UEFN project to a Fortnite Creative island, you can only revert a UEFN project that was previously converted from a Fortnite Creative island.

The page automatically refreshes and the project is now listed as **Project Type: FNC**. Any previous releases under UEFN will be visible on the list but greyed out.

The island is now accessible through the golden rift in the Creative hub.

If the project is reverted while being edited in UEFN, the person using UEFN cannot playtest the project. Instead, they are prompted to import the island again to continue editing in UEFN.

At this point, either the project must be imported, or UEFN must be closed.
