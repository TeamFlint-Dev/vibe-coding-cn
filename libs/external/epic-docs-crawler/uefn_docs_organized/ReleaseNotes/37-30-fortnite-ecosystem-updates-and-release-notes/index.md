# 37.30 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/37-30-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-26T23:14:59.408007

---

Fortnite v37.30 introduces the Lonewolf Lair prefabs and galleries, the 2025 Birthday Cake prop, and updates to the User Interfaces Feature template. We’ve also added a new multi-island Monetization dashboard in Creator Portal — be sure to check it out!

## General Physics Beta Is Coming Soon (v37.40)

With the Beta release of General Physics coming in v37.40, you’ll be able to publish your physics-enabled islands. Physics provides mechanics for your players to push, topple, hit, and move objects, unlocking emergent physics-driven gameplay. Create experiences that feel more realistic, engaging, and predictably unpredictable. Don't wait! Get your island physics-ready!

To learn more about using the feature in your islands, see the [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) documentation.

## Epic MegaGrants 2025 — Cycle 2

Only a few days left to submit your UEFN island ideas! Get your application in before September 22. More information in [our blog](https://www.fortnite.com/news/epic-megagrants-2025-cycle-2-apply-now-for-uefn-project-support).

## New Multi-Island Monetization Dashboard in Creator Portal

When you click the **Monetization tab** in your main navigation, you’ll now find a brand-new multi-island Monetization dashboard. We’ll continue to expand it with multi-island analytics over time.

[![Fortnite Monetization Dashboard](https://dev.epicgames.com/community/api/documentation/image/df18e495-2b0c-44c6-a82d-189daa2ddb28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/df18e495-2b0c-44c6-a82d-189daa2ddb28?resizing_type=fit)

Monetization Dashboard

Please note that the [legacy analytics site](https://www.epicgames.com/affiliate/en-US/fortnite-games/insights) will sunset on November 3, 2025, and all monetization metrics will be accessible directly from your Creator Portal account navigation.

## Fab in Launcher UEFN Update

The [Import from Fab](https://dev.epicgames.com/documentation/en-us/fortnite/import-from-fab-in-unreal-editor-for-fortnite) page highlights new workflows for using the in-editor application to search and import assets to help build your islands. The workflow includes the new application through the Epic Games Launcher, called **Fab in Launcher**.

## User Interfaces Feature Template

The [User Interfaces Feature Template](https://dev.epicgames.com/documentation/en-us/fortnite/user-interfaces-feature-template-in-unreal-editor-for-fortnite) now includes an example of adjusting the experimental player input to create custom keybinds and UI for your island.

The template utilizes the Keybind User Widget and the Verse file `hud_keybind_demo_device.verse` to create the custom keybinds. To learn more about creating and binding these features for reloading, shooting, crouching, and standing, see [User Interface Devices](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-devices-in-unreal-editor-for-fortnite).

The template is accessible from the UEFN project browser, under the **Feature Examples** tab.

## Content Browser and Inventory Updates

Check out all the new items available this release!

### New 2025 Birthday Cake Prop

Add the new 8th anniversary prop, 2025 Birthday Cake, to your islands. This indestructible prop is available in the **Indoor Residential Prop Gallery**. You can place, resize, and copy-paste it.

[![](https://dev.epicgames.com/community/api/documentation/image/2a7c85d3-b9d9-487b-ad12-bbcb20258115?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a7c85d3-b9d9-487b-ad12-bbcb20258115?resizing_type=fit)

### New Prefabs & Galleries

- Lonewolf Lair Prefab
- Lonewolf Lair Floor and Stairs Gallery
- Lonewolf Lair Wall Gallery
- Lonewolf Lair Roof Gallery
- Lonewolf Lair Prop Gallery

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where UEFN would need to be restarted after losing connection to Unreal Revision Control.

  - [Forum Report](https://forums.unrealengine.com/t/critical-revision-control-connection-issues/2653715)
- Fixed an issue where the Pop-Up device, “Do Not Close on Button Press,” did not work as intended.

  - [Forum Report](https://forums.unrealengine.com/t/pop-up-dialog-device-option-breaks-all-buttons-instead-of-stopping-the-popup-from-disappearing/2635826)
- Fixed an issue where Weapon Canting was not working on published islands.

  - [Forum Report](https://forums.unrealengine.com/t/weapon-canting-not-working-in-published-islands/2645783)
- Fixed an issue with the Item Spawner where the base visibility was disabled, but the spawned item would remain stuck in place.

  - [Forum Report](https://forums.unrealengine.com/t/spawned-pickups-stuck-in-air-and-not-obeying-gravity-after-uefn-37-00-item-spawner-bug/2642081)

## Device Updates and Fixes

New:

- Added ViewModels for the Voting Group device and Voting Option device. These are still under development and not yet functioning with the device.
- Added a configurable user option for when the Skilled Interaction device should hide its UI — either when the player's own interaction completes (existing default behavior) or when all queued interactions complete (new behavior).
- Fixed an issue where players couldn't enter the top half of Skydive Volumes.
- Added a user option to hide the beacon for the Changing Booth device.

Fixes:

- Fixed an issue where the Launch Pad wouldn't account for device rotation when launching the player.
- Fixed issue with the Voting Option device where trying to vote for an option more than once did not produce an error.

## UEFN Updates and Fixes

New:

- Added support to drag assets into the outliner to create entities.
- Added support to drag assets into the entity prefab editor viewport to create entities.
- Added symmetry support to the Paint Vertex tool.
- Added an experimental setting for entity prefab in place editor mode.

Fixes:

- Fixed a potential infinite loop in the serialization of packed integers when loading malformed values.
- Fixed the Gameplay Events for Sequencer not showing the Gameplay Event Function property for Trigger, Enable, Disable, and Reset Times Triggered.
- Resolved playback errors and crashes for Mesh Plate actors configured as spawnable in Sequencer after saving or reloading the level or level sequence.
- Fixed a crash that occurred when force-deleting an entity prefab.
- Fixed an editor crash when saving a map while the landscape material was invalid.
- Fixed landscape weight blending that sometimes left ghost layer masks.
- Fixed a variation of the issue where swapping teams would cause random disguises to revert to a different player’s random disguise. This issue is fully fixed in v37.40.
- Fixed template hyperlinks in the Project Browser that were linked to deprecated documentation sites.

## Scene Graph

Fixes:

- Fixed child entities that were derived from a prefab so they cannot be reparented anymore.
- Fixed the introduction of CanParent utility functions for entities.

## Verse Updates and fixes

Fixes:

- Updated variables declared in default initializers to be local to the initializer expression.

Depreciations:

- Deprecated operations like `var` declarations and reads in initializers. Verse class member default initializers currently must be `<reads><converges>`, aside from instantiating other objects.

## Unreal Revision Control (URC)

Fixes:

- Fixed an issue causing frequent reports of the error message `Request put failed: Server returned error 3…// Failed to store fragments, remote error…`.
