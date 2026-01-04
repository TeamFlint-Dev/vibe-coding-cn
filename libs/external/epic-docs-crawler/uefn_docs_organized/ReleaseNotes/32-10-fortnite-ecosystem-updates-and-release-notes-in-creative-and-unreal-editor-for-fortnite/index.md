# 32.10 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/32-10-fortnite-ecosystem-updates-and-release-notes-in-creative-and-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:35:08.848723

---

We’re excited to see what you've been creating! Starting today, you'll be able to publish **Teenage Mutant Ninja Turtles** islands. What's more, publishing for islands using the **First Person Camera Mode** device will be unlocked on December 11.

In this v32.10 release, there's also a brand new holiday-themed template for LEGO® Island creators, featuring sample Verse code, game examples, and tutorials for building a factory-style game.

## You Can Now Publish Your Teenage Mutant Ninja Turtles Islands!

[![TNMT banner](https://dev.epicgames.com/community/api/documentation/image/6eb0c752-515a-4a46-a67b-7c55fd058a2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6eb0c752-515a-4a46-a67b-7c55fd058a2e?resizing_type=fit)

Starting November 13, you can publish Fortnite islands that have the Teenage Mutant Ninja Turtles (TMNT) assets! Head over to the [Creator Portal](https://create.fortnite.com/welcome) to submit your island for content review.

## New Template and Content for LEGO® Island Creators

[![LEGO banner](https://dev.epicgames.com/community/api/documentation/image/016a2b9a-5bd1-470b-a520-6c5dbc846df1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/016a2b9a-5bd1-470b-a520-6c5dbc846df1?resizing_type=fit)

**Santa's Toy Factory Template** - Developed by The LEGO® Group, the UEFN template is a factory-style game demo providing new tutorials, Verse code, gameplay examples, and assets that LEGO Island creators can use to explore adding persistence and offline progression mechanics to their own LEGO Islands — encouraging return visits from players.

Harvest resources, fulfill orders, and upgrade your factory to manufacture improved toys! To learn more, check out the [Santa's Toy Factory](https://dev.epicgames.com/documentation/en-us/uefn/lego-santas-toy-factory-in-unreal-editor-for-fortnite) guide.

## Chapter 5 Time of Day Manager (TODM) in Creative

The new TODM provides:

- More realistic lighting with Lumen and Nanite.
- Parity with the UEFN TODM.
- No more siloed development for UEFN lighting.

What the TODM conversion affects:

- Custom lighting set with a Skydome device

It is recommended to opt in early to update your old islands to the Chapter 5 TODM lighting. All islands will automatically transfer to the new TODM system in an upcoming release, and the Skydome device will be retired. Any islands using the Skydome device will no longer have custom lighting set with the device.

To create custom lighting, use the [Day Sequence device](https://dev.epicgames.com/documentation/en-us/uefn/using-day-sequence-devices-in-unreal-editor-for-fortnite) as well as the [**Ambience settings**](https://dev.epicgames.com/documentation/fortnite-creative/world-settings-in-fortnite-creative#ambiencesettings) available in World Settings.

## Unreal Revision Control (URC) Status Highlighting

We've released a feature to highlight actors in the viewport based on their URC status, so you can see what parts of your project are in various states.

By default, actors **checked out by others** and actors that are **out of date** will be highlighted. You can also turn on highlights for actors **checked out by you** or for **newly added** actors that haven't been checked in yet. To control which statuses are highlighted, and with what opacity, click **Show > Revision Control**.

We've also improved the Outliner's functionality to enable you to filter by revision control status!

## First Person Camera Mode Device Enters Beta Soon!

The First Person Camera Mode device is entering Beta on December 11, meaning you'll soon be able to publish islands using this device! Starting December 11, head to the [Creator Portal](https://create.fortnite.com/welcome) to submit your island for content review.

Please remember that all content created using the First Person Camera Mode device should follow the [Fortnite Island Creator rules](https://www.fortnite.com/news/fortnite-island-creator-rules) and align with Fortnite's age rating.

## Device Updates

**Orbit Camera**: the new **Clamp Horizontal Mode** option determines the basis for locking horizontal rotation when the camera is attached to the player.

Values include:

- **Player Relative**: Default. This keeps the camera's horizontal rotation clamped in a range based on where the player was looking when they spawned.
- **Device Relative**: This clamps the horizontal rotation of the camera based on the direction the device is facing.
- **World Relative**: This clamps the horizontal rotation of the camera based on the World's 0.0 coordinates.

## Galleries Updates

The **Megalodon Prefabs and Galleries** are now available in Fortnite Creative:

- Shipyard Wall Gallery
- Shipyard Floor & Stairs Gallery
- Shipyard Roof Gallery
- Shipyard Prop Gallery
- Megalodon Ship Wall Gallery
- Megalodon Ship Prop Gallery
- Megalodon Ship Prefab
- Restored Reels Nature Gallery
- Underworld Nature Gallery
- Rocky Desert Nature Gallery

## Community Bug Fixes

The following list of fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed issues with asset localization after loading registry data.

  - [Forum Issue Report](https://forums.unrealengine.com/t/asset-localization-dose-not-work-from-v28/1504811)

## Creative Updates and Fixes

### Devices

**Fixes**:

- Fixed an issue with one of the Sports Car colors not showing up.
- Fixed an issue where the Patchwork Omega Synth on-screen knobs were not updated after changing the option values in the Customize panel.
- Fixed a bug where repeated connections to a carousel on the Patchwork Step Modulator would have the values on the Modulator round down to zero.

## UEFN Updates and Fixes

**New**:

- **Validate Project** added under the Launch Session's submenu. This runs the local validation without uploading or pushing changes.
- New icons were added for landscape mode to improve ease of use.

**Fixes**:

- Reduced the intensity of some of the TMNT Mouser visual effects.
- Reduced the frequency of the **Push Changes button** status indicating that unsupported transactions occurred.
- The existing **Run Validation Fix-up** dialog now closes consistently.
- The right-click context menu for assets is now extended for read-only assets to include more actions, such as Find All Using Selected.
- Optimized the uncontrolled and unsaved filters in the Scene Outliner.
- Fixed frequent crashes when performing Delete, Undo, and Redo operations on Material Expressions, especially when these operations were applied to Function Inputs while a material using the Function was open in the editor.
- The Bake Texture tool's vertex color output now supports writing alpha.
- Fixed a client crash that happened when a DynamicMeshComponent's internal MeshObject was in an invalid state.

## Verse Updates and Fixes

**Fixes**:

- Disabling IDOs in Content Worker cooks. This fixes issues where placeholder types found when cooking will fail the cook.
