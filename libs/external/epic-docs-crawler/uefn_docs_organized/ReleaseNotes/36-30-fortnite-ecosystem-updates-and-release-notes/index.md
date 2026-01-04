# 36.30 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/36-30-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-27T00:36:11.040365

---

Fortnite v36.30 adds hundreds of new LEGO® Styles for NPCs, dynamic team making through emotes, an expanded Squid Game feature set, and exciting new weapons and galleries!

## Squid Game Toolset and Templates Are Updated!

The Squid Game feature set has expanded with new assets for creating voiceovers, Verse gameplay examples, and Squid Game emotes for dynamic team making.

To learn more about the feature set, like devices and the Cuddle Team Leader (CTL) doll control rig, see [Working with Squid Game Islands](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-squid-game-islands-in-unreal-editor-for-fortnite).

### Voiceover Audio

Squid Game voiceover (VO), in both English and Korean, has been added to provide creators with iconic audio to use across Squid Game islands. The announcer, CTL doll, recruiter, and guard are all represented with VO.

### Minigame Mastery and Social Deduction Templates

The [Minigame Mastery](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-minigame-mastery-template-in-unreal-editor-for-fortnite) and [Social Deduction](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-social-deduction-template-in-unreal-editor-for-fortnite) templates now include Verse examples for the following rooms:

- [Multiplayer Quick Time Events Room:](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-multiplayer-skill-checks-in-unreal-editor-for-fortnite) Contains a  Verse example that optimizes the tower setup, removing the need for repeating devices on each floor.
- [Giftbox Device Room:](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-giftbox-device-for-hiding-and-teleportation-in-unreal-editor-for-fortnite) Contains a Verse example that reduces the manual setup, captures event bindings, and tracks conditionals.
- [Voting Devices Room:](https://dev.epicgames.com/documentation/en-us/fortnite/using-voting-group-and-voting-options-devices-in-fortnite) Contains a Verse example that expands the voting options. You can create a list of questions where the Verse device picks the next question for each round.

Additionally, there were many updates and fixes to the Minigame Mastery and Social Deduction templates for this release. For more information, see the [Squid Game General Template Updates and Fixes](https://dev.epicgames.com/documentation/en-us/fortnite/36-30-fortnite-ecosystem-updates-and-release-notes#squid-game-general-template-updates-and-fixes) section below.

[![Squid Game in UEFN Gameplay Example](https://dev.epicgames.com/community/api/documentation/image/f8b728c4-533a-4b3c-bca1-0862478fae6e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f8b728c4-533a-4b3c-bca1-0862478fae6e?resizing_type=fit)

Multiplayer Quick Time Event Room

### Squid Game Dynamic Team Emotes

Provide opportunities for players to create or leave teams with Squid Game [emotes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#emote). These specialized emotes are attached to the dynamic team-making system, and help keep to the theme of the show.

The Social Deduction template includes a new room that shows how to use the **Dynamic Team Emotes**. To learn more, see [Creating Temporary Teams with Emotes](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-create-temporary-teams-through-emotes-in-unreal-editor-for-fortnite).

[![Squid Game in UEFN Emotes](https://dev.epicgames.com/community/api/documentation/image/245c39c3-e63b-4d40-8a4d-83dc01a58d4c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/245c39c3-e63b-4d40-8a4d-83dc01a58d4c?resizing_type=fit)

Invite to Team

### Updated Brand Rules

Based on community feedback, the [Squid Game Brand and Creator Rules](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-brand-and-creator-rules-in-fortnite) were updated to clarify what is permitted in promotional assets for your islands.

## Over 800 New LEGO Styles for NPCs

Expand your LEGO Islands with 882 [LEGO Styles](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#lego-styles) for NPCs that were added to this release. Create more relationships and deeper storylines with a wider range of Minifigures. These styles are compatible with the [NPC Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite) device.

[![LEGO Styles in Fortnite Creative and UEFN](https://dev.epicgames.com/community/api/documentation/image/db138b9e-6469-4adb-8f1d-f056b19db3f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/db138b9e-6469-4adb-8f1d-f056b19db3f6?resizing_type=fit)

LEGO Styles

## Property Validation Warnings Becoming Errors in v37.00

As a reminder, starting in v37.00, modifying certain hidden properties from their default values will cause validation errors instead of warnings. Please migrate away from these properties now to avoid errors. If there are any properties that you can't work around, please let us know in [this forum](https://forums.unrealengine.com/t/major-almost-all-hidden-properties-are-now-disallowed-they-have-been-allowed-since-uefn-released-until-34-30/2446835/23) thread.

**It is not possible to publish islands with validation errors.** As a result, following v37.00, you won’t be able to publish updates to already live islands or publish new islands that use these properties. To resolve the validation errors, you will need to migrate off of the following properties:

- `bVisibleInRealTimeSkyCaptures`
- `bReceiveMobileCSMShadows`
- `bCastDistanceFieldIndirectShadow`
- `bSelfShadowOnly`
- `bTreatAsBackgroundForOcclusion`
- `CastRaytracedShadows`

## New Options for the Prop Mover Device

The [Prop Mover](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative) device comes with new reference and rotation options in this release!

### New Prop Reference Options in UEFN

In UEFN, you can now assign a Prop Mover device directly to a specific prop using the new Prop Reference setting.

To enable this:

1. In the **Details** panel, locate the **Prop Selection** user option.
2. Click the dropdown, and select **From Reference**. This makes the Prop Reference option active.
3. Click the **Prop Reference** dropdown to select a prop.

This setup is especially useful for precise control when rotating props. The original **Overlap** behavior remains available, and is still the default option.

### New Rotation Options

The Prop Mover device can now rotate props in addition to moving them!

Under the **Movement Mode** option, you can now choose between **Translation and Rotation**.

When **Rotation** is selected, the available options include:

- Rotation Direction
- Rotation Axis
- Rotation Angle
- Rotation Duration
- Rotation Pivot Point
- Rotation Complete Action (corresponds to the **Path Complete Action** option when **Movement Mode** is set to **Translation**)

With the new **Rotation Pivot Point** setting, you can define the point around which the prop rotates. You can select the prop’s **origin point** or **center**, or the **Prop Mover’s position**, providing more flexibility in how your props animate.

## Dynamic Team Emotes

You can now create opportunities for players to join and leave teams dynamically within your Fortnite islands. Using the new **Invite to Team**emote, players can join forces with another player they’ve encountered in your Island. You can also choose to enable the **Leave Team** emote for players to dynamically leave a team during a session.

Leave Team Emote

The feature includes two settings: **Dynamic Team Emotes** and **Dynamic Team Leave**. You can access the settings in either the [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-uefn-and-fortnite-creative) or the [Team Settings & Inventory](https://dev.epicgames.com/documentation/fortnite/using-team-settings-and-inventory-devices-in-fortnite-creative) device. You also must set the **Team Size** option to **Dynamic**, plus the **Teams** option to either **Team Index**, **Free for All**, or **Custom** in the Island Settings.

There are known issues with this feature. To learn more, see the [Known Issues with Dynamic Team Emotes](https://dev.epicgames.com/documentation/en-us/fortnite/36-30-fortnite-ecosystem-updates-and-release-notes#known-issues-with-dynamic-team-emotes) section below.

## Epic’s Picks Updates!

This release, we made several updates to the **Epic’s Picks**:

- We added our guidelines for featuring islands, and a policy summary.
- We listed the Epic’s Picks **Three Pillars** for selection, the criteria we use to select islands.
- We outlined the review process to clarify how we determine if your island is eligible for featuring.

To learn more, see [Epic’s Picks documentation](https://dev.epicgames.com/documentation/en-us/fortnite/epics-picks-in-fortnite).

## Project Cooks Initiated on Pre-Publish

UEFN now automatically cooks projects for all platforms when you select **Publish Project** or **Upload to private version**. This means no more waiting for your island to cook after publishing, solving the `cold island` issue, and making the publish flow smoother and faster.

## Content Pre-Checks and Discover Filtering for Fortnite Islands

We recently launched two updates to improve the publishing experience and encourage originality in the Fortnite islands promotional content.

1. **Content Pre-checks:** Your title, thumbnail, and lobby background images are now automatically reviewed for potential [Rule 1.13 Keep it Authentic](https://www.fortnite.com/news/fortnite-island-creator-rules#:~:text=1.13%20Keep%20It%20Authentic) violations or similarity to existing islands. You’ll get a warning so you can fix issues before submitting.

- **Discover Filtering:** If creators don’t address pre-check warnings related to originality, Discover Filtering will remove islands from top rows in Discover to help promote original content in the ecosystem.

For more details, check out the [blog post](https://create.fortnite.com/news/introducing-content-pre-checks-and-discover-filtering-for-fortnite-islands), along with the [Publishing Page Features](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-page-features-in-fortnite-creative) and [How Discover Works](https://dev.epicgames.com/documentation/en-us/fortnite/how-discover-works-in-fortnite) documentation.

## New or Updated Documentation

The [Hiding Prop Gallery device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hiding-prop-gallery-devices-in-fortnite-creative) now includes a Verse example of the updated device API. The example covers features such as hidden travel groups, ejecting players, and hiding players within a specified range.

## Content Browser and Inventory Updates

Check out all the new devices and items available this release!

### Device Updates and Fixes

Fixes:

- Fixed an issue with the Carryable Spawner device where carryables could be thrown through floors and ceilings.
- Fixed an issue with the Disguise device where a disguise would prevent certain inventory back-bling items, like the jetpack, from displaying.
- Improved the throw arc of the Carryable Spawner device to better match the preview trajectory.
- Fixed the Carryable Spawner and Progress Based Mesh devices not being findable with Verse tags.
- Fixed a rare assertion crash during Voting Option device initialization.
- Added new verse API functions to the Team Settings & Inventory device so that temporary teams can be abolished through verse.

### Creator Most Wanted Weapons

You wanted it, you got it!

- Midas’ Gilded Eye Drum Gun
- The Foundation’s MK-Seven Assault Rifle

### New Prefabs & Galleries

- Outlaw Oasis Reception Prefab
- Outlaw Oasis House Prefab
- Outlaw Oasis Roof Gallery
- Outlaw Oasis Wall & Fence Gallery
- Outlaw Oasis Floor & Stair Gallery
- Outlaw Oasis Prop Gallery

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where objects that were spawned by the Carryable Spawner device would cause players to teleport.

  - [Forum Report](https://forums.unrealengine.com/t/critical-issue-carryable-spawner-device-picking-up-while-overlapping-causes-teleport-to-world-origin/2588293)
- Fixed an issue with Scene Graph where an editable creative\_prop\_asset always resets to default.

  - [Forum Report](https://forums.unrealengine.com/t/scene-graph-editable-creative-prop-asset-always-resets-to-default/2544114)
- Fixed an issue where the Ready Up toast would remain on the screen throughout the game.

  - [Forum Report](https://forums.unrealengine.com/t/major-large-hud-readying-up-covers-10-of-screen-and-never-goes-away/2071874)
- Fixed an issue where some of the Oni Hunters prefabs were not built properly on the grid.

  - [Forum Report](https://forums.unrealengine.com/t/oni-hunters-prefabs-are-not-built-on-grid-properly/2502370)

## Fortnite Ecosystem Updates and Fixes

Fixes:

- Fixed HUD Actions text to show Wraith Form instead of Myst Form.
- Fixed an issue where weapons with two magazines like the Twin Mag SMG and Twin Mag Assault Rifle did not switch between magazines after emptying one.
- Fixed the Bouncer, Launch Pad, and Chiller Trap items not appearing in the Creative inventory.
- Fixed characters getting stuck in an animation if they initiated a primary attack while doing an air attack with the Kinetic Blade or Thorne's Vampiric Blade.
- Resolved an issue where a QR code in Creative was pointing to the wrong docs link.
- Fixed the Myst Form item to enable weapon unholster when catching a zipline in air after coming out of myst form.

### Known Issues with Dynamic Team Emotes

Dynamic Team Emotes is releasing in a Beta state. As such, there are expected to be issues with compatibility and stability. Our team is looking to expand and improve the feature in later versions.

The following are some known issues with Dynamic Team Emotes:

- Some devices that support team-specific indexes can fail to recognize that players have switched teams using the Dynamic Team Emotes.

  - Timer Device: Players cannot interact after switching teams if this device is set to team index.
  - Camera Device:  Does not update when players switch between teams using Dynamic Team Emotes.
  - Save Point Device: Prevents users from rebooting teammates via the 'Reboot Van' if the 'Dynamic Team Making' is on.
  - Post Process Device: Does not respect players switching teams in terms of visible VFX.
  - Player Counter Device: Does not update correctly when players switch teams if it’s set to track a team index.
  - Volumes: Such as the Skydive Volume device, do not update if players switch teams while inside them.
- There may be more team-specific device functionality which doesn’t work as expected with Dynamic Team Emotes.

## Brand Island Updates and Fixes

New:

- Added new stairway color options to the Squid Game Stairway Galleries.

Fixes:

- Resolved an issue that was preventing the Squid Game characters from showing up in the Cosmetic section of the Guard Spawner. Guards and contestant characters are now usable in Creative.
- Fixed Aggroed LEGO NPCs not immediately attacking players after entering an aggressive state.
- Reduced roughness noise on Squid Game stairway assets.
- Replaced placeholder visuals in preview thumbnails for some Squid Game assets.
- Fixed issue with some Squid Game Stairway Galleries breaking when placed.
- Fixed issue with camera position when a player is hidden in Squid Game Giftbox device.
- Improved Squid Game Ddjaki VFX.

### Squid Game General Template Updates and Fixes

The following bug fixes and updates have been made to the Squid Game Social Deduction and Minigame Mastery templates.

- Minigame Mastery

  - Removed the out-of-bounds teleporter when leaving the Voting minigame.
  - Improved lighting in Shove arena.
  - Improved teleportation when entering a room from the lobby.
  - Fixed being able to activate the Throwables minigame from too far back, locking the player out of it.
  - Fixed pendulums on the Carryable object minigame from jittering.
  - Fixed the Multiplayer Skilled Interaction device minigame not ending when a team is eliminated.
  - Fixed typo of the word ‘Ddakji’ in the Throwables example room.
- Social Deduction

  - Swords from the Hiding Props room can no longer be kept by respawning.
  - Fixed the seeker in the Giftbox minigame not getting stunned after the first incorrect search.
  - Fixed the seeker not getting any HUD messages in the Giftbox minigame.
  - Fixed the voting VFX glows not applying correctly in the stand on shape voting example.
  - Fixed the door not opening at the start of the Giftbox minigame.
  - Fixed the Blue Team Win switch on the pedestal voting example not triggering correctly.
  - Fixed validation errors on running the template.
  - Added a room for the Dynamic Team Emotes feature.
  - The Sniper minigame now switches a player's team when choosing a role.
  - Fixed an issue with the pedestal voting example resetting when a vote is switched to a different option.
- Both Templates

  - Building is no longer enabled in Play mode.
  - Fixed warnings when creating or opening either template.
  - Added a new map for verse examples to both templates.

## UEFN Updates and Fixes

Fixes:

- Fixed the renaming of actors when opening multiple outliners.
- Resolved duplicated array items from pointing back to the source item when editing.
- Fixed a regression where the 2D Snap Layer menu was not available in the new viewport toolbar.
- Fixed a few buttons not appearing in the Details panel.
- Physics Experimental: Fixed for player jump and movements after they join a game in progress.

## Unreal Revision Control (URC) Updates and Fixes

Fixes:

- Fixed an issue in which actions such as restoring an older snapshot could fail without much context. The underlying issue was determined to be connection and/or authentication related. Users will now receive clearer errors when this issue arises.
- Fixed an issue in which disabling URC could occasionally cause an unclear and indefinite stall if operations were still in flight behind the scenes.
- Fixed an issue where a checked out actor could not be reverted after subsequently disabling and reenabling revision control.

## Verse Updates and Fixes

Fixes:

- Changed `GlobalTransformInternal`, `LocalTransformInternal`, and `OriginInternal` to `<private>` in `transform_component`, these should have been `<private>` from the beginning.
