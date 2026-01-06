# 38.10 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/38-10-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-26T23:14:31.825453

---

Developer tools for in-island transactions are now live in UEFN! Test in-game item sales now and get ready to publish islands with V-Bucks purchases when publishing opens.

We’ve also added device fixes, new Shogun’s Solitude Prefabs and Galleries, and more tools and updates in the Fortnite Tools mode to help you build and scale faster.

## Tools for In-Island Transactions Now Available

Developer tools for in-island transactions are now available in preview within UEFN. 
Use these to test [in-island item sales](https://www.fortnite.com/news/fortnite-developers-will-soon-be-able-to-sell-in-game-items?lang=en-US#:~:text=In%20December%2C,more%20details%20soon) in your unpublished projects – unlocking new monetization opportunities for Fortnite developers on top of [engagement payouts](https://dev.epicgames.com/documentation/en-us/fortnite/engagement-payout-in-fortnite-creative).

Soon you’ll be able to [publish games](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-islands-in-fortnite-creative) with in-island transactions that players can use to purchase items in your islands using [V-Bucks](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#v-bucks). 
We’ll share more on publishing timelines in the coming weeks.  Once published, you’ll be able to monitor the performance of in-island transactions directly in the Creator Portal.

Check out the [blog](https://www.fortnite.com/news/tools-for-in-island-transactions-now-available-to-fortnite-developers) and [documentation](https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-in-fortnite) for a full breakdown, including what you can (and can’t) sell, how in-island transactions work, an in-island transactions feature example, and more.

Be sure to check out the full **[Fortnite Developer Rules](https://legal.epicgames.com/fortnite/developer-rules)** and the **[In-Island Transactions Restrictions](https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-restrictions-in-fortnite)** document to learn about the new guidelines for integrating transactions into your island.

[![](https://dev.epicgames.com/community/api/documentation/image/ffffa2df-6bb2-46d1-8a11-17377f2c3bc7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ffffa2df-6bb2-46d1-8a11-17377f2c3bc7?resizing_type=fit)

### In-Island Transactions Feature Example

The In-Island Transactions Feature Example explores how products defined in Verse can be associated with a variety of gameplay benefits for players such as items, gameplay attribute increases, access to new areas, and more. Each example progressively builds upon the last using Farm themed assets.  There is additional information about tools to improve iteration and organization.

[![](https://dev.epicgames.com/community/api/documentation/image/e8427a92-0a15-4129-9c32-73f4997cd53d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8427a92-0a15-4129-9c32-73f4997cd53d?resizing_type=fit)

### In-Island Transactions Debug Commands

To help you efficiently debug your projects, we are committed to adding more debug commands to the Beta Debug Command menu. We've added:

- **Grant All Products:** Grants the maximum amount of all products.
- **Grant One of All Products:** Grants one of each product.
- **Force Remove Products:** Removes all owned products.
- **Open Storefront:** Displays a debug storefront populating it with a dynamically generated offer for each product defined in the project.
- **Purchases Always Fail:** On: Store purchases will always fail regardless of if they could succeed or not. Off: Store purchases behave as intended.

## User Interfaces Feature Template Updates

[![The custom In-Island Transactions example in the feature template.](https://dev.epicgames.com/community/api/documentation/image/1d3fb83a-8e93-4691-83d5-4be8f2c02211?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d3fb83a-8e93-4691-83d5-4be8f2c02211?resizing_type=fit)

Click image to enlarge.

Open the template to explore the custom shop UI and see **[Verse Fields Examples](https://dev.epicgames.com/documentation/en-us/fortnite/verse-fields-examples-in-fortnite)** to learn how the custom UI comes together using widgets and Verse! Learn more about creating custom meter materials using the **[Material Collection](https://dev.epicgames.com/documentation/en-us/fortnite/material-assets-in-unreal-editor-for-fortnite)** now available from the **Fortnite** > **UI** > **Materials** folders.

Launching a session or pushing changes in the User Interfaces feature template will cause a compilation error. These errors will reset whenever a project is opened. To workaround this issue, open the `UW_MaterialCollectionScreen` widget and press Compile to clear the error. This bug will be fixed in an upcoming release.

## Fortnite Tools Mode Updates

Fortnite Tools mode has new tools to help you quickly build and scale your islands.

- Create Volume: Create and scale any type of volume you need on your island.
- Find Overlap: Find objects in the viewport that overlap to reduce memory constraints.
- Scatter: Randomly add static meshes to your island.

New tools were also added to **[Snap to Target](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-tools-mode-in-fortnite#snap-to-target-nbsp)** and **3D Select** for precise placement and selection. Check out what’s new, see **[Fortnite Tools Mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-tools-mode-in-fortnite)**.

## Island Localization Tools

Island localization is now exported by default and auto localized when creating a new **Private Version**, either through **Project** > **Upload to Private Version**, or **Project** > **Publish Project**. The localization process has the following options:

- Opt-out of the localization process permanently for your project by unchecking the **Automatically Build Localization** option in your project settings.
- Opt-out temporarily for a single Private Version by unchecking the **Build Localization** option on the Private Version settings dialog.

If you haven’t initialized your project’s localization export settings, follow these steps:

1. Generate a **Private Version** of your island to build the localization data.
2. Specify the **native language** for your project.

This option only appears when the native language hasn’t already been set, and mirrors the native language setting found in **Project Settings**.

## Content Browser and Inventory Updates

Check out all the new devices and items available this release!

### Device Updates and Fixes

**Fixes:**

- **Air Vent**

  Fixed a bug that caused the Air Vent FX to play continually.

  **Air Vent - Physics Enabled**

  Fixed a faulty warning from popping-up.

  Fixed a bug that affected the `FortPhysicsImpulseComponent` and `OnPhysicsImpulseOverlapTriggered` options.

- **Teleporter**

  Fixed an issue that caused the Teleporter device to use impulse instead of direct velocity.

  **Teleporter - Physics Enabled**

  Fixed a bug that caused the Teleporter to teleport players nonstop.

- **Crash Pad & Bouncer Gallery - Physics Enabled**

  Fixed an overlap issue that caused the visual FX and sound FX to retrigger on prop collision with a device from the Crash Pad & Bouncer Gallery.
- **Changing Booth**

  Fixed an issue that caused the Changing Booth UI to remain open on players when the device received the Remove Player events.

- **NPC Spawner**

  Fixed an issue where NPCs spawned during the Warmup phase instead of the Game Started phase.

### New Prefabs & Galleries

- Shogun’s Solitude Castle Prefab
- Shogun’s Solitude Main Square Prefab
- Shogun’s Solitude Floor and Stairs Gallery
- Shogun’s Solitude Wall Gallery
- Shogun’s Solitude Roof Gallery
- Shogun’s SOlitude Prop Gallery

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where the default quick bar was failing to be replaced on mobile UI when selecting Quickbar Slot Widget Override Class.

  - [Forum Report](https://forums.unrealengine.com/t/custom-quickbar-ui-duplicated-on-mobile/2619351)
- Fixed an issue where projects received the error **Encountered unexpected content beacon connection failure** when running Memory Calculation.

  - [Forum Report](https://forums.unrealengine.com/t/critical-error-memory-calculation-fails-to-run/2659070)
- Fixed an issue where the **Pop Up Dialog** device would stop working when the **Do not close on button press** option was chosen.

  - [Forum Report](https://forums.unrealengine.com/t/the-pop-up-dialog-device-stops-working-when-you-turn-on-do-not-close-on-button-press/2654500)

## Fortnite Ecosystem Updates and Fixes

**New:**

- Added season tags to weapons, this provides a way to search for every weapon in Creative by its release season.
- Dynamic resolution is available for DX12 rendering mode when anti-aliasing is disabled.

**Fixes:**

- Fixed performance issues in UEFN caused by placing large numbers of actors at once with the phone tool.
- Fixed an issue where the reticle for the Chain of Hades disappeared in Creative.
- Fixed issue where the original Pumpkin Launchers used the wrong weapon icon.
- Fixed an issue that prevented Frame Rate Limit from updating when the Auto-Set Quality button was selected.
- Changed the minimum from 0% to 1% for 3D Resolution in video settings.

## LEGO Island Updates and Fixes

**New:**

- Fixed a Verse compilation issue in the Santa's Toy Factory island template.
- The Enable Leash and Leash Distance settings are now available for NPC Characters.

## UEFN Updates and Fixes

### Editor

**New:**

- Camera IDs were added to the Capture Manager to ingest asset metadata.

**Fixes:**

- Fixed a live edit issue where quickly placing prefabs or large assets into a project and pushing changes would undo map changes and cause the editor to disconnect.
- Fixed a surface alignment issue for entities by introducing surface alignment when dragged into the Prefab Editor.
- Fixed a regression error in the viewport that caused middle-clicking in the level editor viewport to select objects.
- Fixed a film overlay issue where the tint value would reset every time the configuration menu was opened.
- Fixed the following user interface (UI) issues with template projects in the Project Browser:

  - Template project UI now shows for all plugins and updated fallback images for template categories.
  - New Project dialog now lists template projects from enabled plugins.
  - Users can now see and start from installed templates that include disabled plugins.
  - Empty or invalid background image paths no longer show broken template categories. The updated search now includes template projects from all available plugins.
  - A warning icon and tooltip was added for templates with disabled plugins.

  These changes reduce the risk of project issues and ensure project creation works as expected.

### Environments and Landscapes

**New:**

- Landscape edit layers weight blending improvements:

  The three weight-blending settings have moved to the landscape layer info asset.  These new weight blending tools provide improved weight blending solutions that are compatible with edit layers and are applied at every blend step of the merge algorithm.

  The three methods are now:

  - **None**
  - **Final Weight Blending**: A new landscape setting that defines the default weight blending, Non-Weight Blended or Weight Blended.
  - **Advanced Weight Blending**: Provides a way to let certain layers be weight-blended with each other but remain additive against others.

- Added a **Sort by Blend Method** option in the target layers list of the landscape paint panel.
- Changed the landscape texture patch's texture sampler to **Border** to prevent visual issues with the edges.
- Exposed the patch component's layer to the API:

  - `GetLandscape`
  - `GetFallOff`
  - `GetFallOffMode`
  - `GetBlendMode`
  - `SetLandscape`
  - `SetFallOff`
  - `SetFallOffMode`
  - `SetBlendMode`

- Added a new option to the edit layer called **Collapse All Edit Layers**. This option removes all edit layers and flattens the current data into the base edit layer.
- You can hide the landscape selector in Landscape mode when the New tool in the Manage panel is active.
- Updated the default spline edit layer selection:

  - Selecting the Splines Edit Layer no longer auto-activates the Splines tool.
  - Double-clicking on the Splines layer or using the right-click context menu option to toggle between the Splines Tool and last active tool.
- Removed the landscape option Paint-time weight balancing.

**Fixes:**

- Fixed an issue with the Landscape Patch and Patch Editor that caused a crash state when using the Undo operation.
- Fixed an issue related to the Add Component tool:

  - The tool now properly generates extrapolated height data on each persistent edit layer for continuity on the corners on each layer.
  - Prevents existing neighboring components from causing issues when adding a new component.
  - Automatically applies splines after component creation, so that new components are immediately affected by the splines that overlap with them.
- Fixed an issue that resulted in a crash state when exiting a level instance with the Landscape Editor when the Landscape Copy tool was active.

### Materials

**Fixes:**

- Added stencil masking support to fix issues with the Receive Decals setting on primitives.

### Modeling

**New:**

- Added support for the Tangents tool that provides a way to choose the reference UV layer when computing tangents.

**Fixes:**

- Fixed a crash issue in handling degenerate cases with sparse solvers used for some smooth surface filling and interpolation in modeling tools.
- Fixed a case where the `CollisionEnabled` flag could be incorrectly copied and displayed.
- Fixed an issue where hard edges could be lost on static meshes and skeletal meshes when using modeling tools if recompute normals are enabled and the source mesh has hard edges tagged.
- Fixed issues that resulted in a crash state casued by the Mesh Bevel operation.

## Scene Graph

**New:**

- Added support for map pinging on entities.

## Unreal Revision Control (URC) Updates and fixes

**Fixes:**

- Fixed an issue resulting in the error message “Failed to load immutable data, not found” for which the workaround was deleting/regenerating the .urc folder.
- Fixed an issue where server connection errors were incorrectly reported as “repository not found; metadata not found.” The error message will now correctly reflect the root cause.
- Fixed an issue where, in material conflicts, the viewport focus button could target instances of actors without the material applied.

### Known Issues

- We have temporarily disabled the user interface communicating URC background process progress, given some reports that the editor lagged when it was visible.
