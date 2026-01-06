# 35.10 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/35-10-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-27T00:33:33.479791

---

Get ready to publish your Fortnite islands using the **The Walking Dead Universe** assets. Publishing for these islands unlocks today! In v35.10, you’ll find a new Gunfight template showcasing best practices for creating engaging first-person shooter games with UEFN, plus new Grand Glacier, Snowy Mountain, and Spooky Holiday Prefabs and Galleries. Read on to learn more!

## Publish Your The Walking Dead Universe Islands

[![TWDU Islands in UEFN](https://dev.epicgames.com/community/api/documentation/image/2e3505ba-a54e-44fb-9a3d-f4f6df8564d8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2e3505ba-a54e-44fb-9a3d-f4f6df8564d8?resizing_type=fit)

The wait is over, you can publish your Fortnite islands using The Walking Dead Universe (TWDU) assets, starting May 16 at 12 PM ET! Head to [Creator Portal](https://create.fortnite.com/welcome) to submit your island through content review.

The Walking Dead Universe (TWDU) will be featured front and center in **Discover**, with a dedicated **Game Collections** slot following the approach used for previous IP launches. Skybound, the IP holder, will curate a **TWDU Picks** row to highlight a varied selection of their favorite TWDU experiences. We’re continuing to experiment with and refine Game Collections to promote a wide range of high-effort islands that bring IPs to life.

TWDU islands are eligible for additional Discover placement, including Epic’s Picks — so don’t forget to [submit them](https://creative.fortnite.com/s/)! There will also be a quest for players to complete, encouraging players to explore TWDU islands.

We can’t wait to see what you’ve created!

## New Gunfight Template to Create High-Caliber FPS Games with UEFN

[![Gunfight Template in UEFN](https://dev.epicgames.com/community/api/documentation/image/98dbf1a6-5c41-4bf8-a493-6b962383fd55?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/98dbf1a6-5c41-4bf8-a493-6b962383fd55?resizing_type=fit)

Explore best practices for building engaging first-person shooter (FPS) gameplay with the new Gunfight 2v2 example template in Unreal Editor for Fortnite (UEFN).

This hands-on template offers a practical starting point for creating FPS islands using the [First-Person Camera](https://dev.epicgames.com/documentation/en-us/fortnite/using-first-person-camera-devices-in-fortnite-creative). It includes detailed Verse examples for player management, such as dynamic team balancing and weapon granting, all documented with inline notes.

You’ll also find guidance on efficient FPS game structure and level design, including how to build multiple distinct play areas within a single Fortnite island. Each round shifts the action to a different area, demonstrating how to create varied playspaces in one match.

Try out the playable version of the Gunfight template now (Code: 5043-2939-1074).

Want to find out more about the Gunfight Example Template and other UEFN templates? Check that the coast is clear, then combat roll into the [UEFN Starter Templates](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-starter-templates) documentation.

## New Prefabs & Galleries

- Grand Glacier Hotel
- Grand Glacier Hotel Wall Gallery
- Grand Glacier Hotel Floor & Stair Gallery
- Grand Glacier Hotel Roof Gallery
- Grand Glacier Hotel Prop Gallery
- Grand Glacier Indoor Wall Gallery
- Snowy Mountain Nature Gallery
- Spooky Holiday Prop Gallery

We accidentally included assets from a licensed IP in the Japanese Forest Nature Gallery released in v35.00. For v35.10, we removed the assets from your projects and the gallery. The rest of the gallery will remain intact. We apologize for the inconvenience.

## Twitch Link Added to Creator Profiles

You can now add your Twitch handle to your Creator Profile — joining TikTok, Discord, X, and Instagram as supported platforms.

## Fortnite Ecosystem Updates and Fixes

Fixes:

- Fixed the Matchmaking Portal device from having the default texture on only half of one side when using the Live Edit tool.
- Fixed the Accolade device from failing to display text on the UI in subsequent rounds.
- Fixed the Accolades Award UI failing to appear during Edit mode.
- Fixed unreleased devices and prefabs exposure in both UEFN and VK Edit sessions.
- Improved the loading screen behavior for players who are loading into their island. Added additional checks for loading the terrain, props, and environment.

### Devices

Fixes:

- Fixed an issue where two or more Prop Manipulator devices touching the same asset could not, in some cases, get selected based on their Priority settings.
- Fixed players being immune to Damage Volumes if they enter while driving a Baller.
- Fixed some UI icons that were not showing up when the Input Trigger device was changed.

### Items

Fixes

- Fixed an issue where the Lawless Slap Cannon had the wrong visuals when dropped from the Creative Inventory.

## Brand Island Updates and Fixes

### LEGO® Islands

New:

- Added the Impulse and Shockwave Grenades for use on LEGO Islands.
- Moved the Dialog Background and Dialog Divider textures out of the LEGO Action Adventure template. They are now available in the Content Drawer under **LEGO® Content > Textures > Quests**.

Fixes:

- Fixed a case where the Assembly device could not be interacted with on mobile.

### The Walking Dead Universe

New:

- Added Dynamic Stride Length for Walker animations at increased speeds.
- Added additional color variations for the Walker Prisoner uniforms.

Fixes:

- Optimized Walkers to not do unnecessary animation when offscreen.
- Improved Walkers falling and aerial animations.
- Updated Walkers to better target and damage a player's built walls.

## UEFN Updates and Fixes

Fixes:

- Fixed an issue where transformation emotes would not work in UEFN Islands.
- Fixed a faulty check where the loading screen would dismiss before the environment loaded.
- Fixed the localization support for the Advanced Transform category name of the Transform tool in the UV Editor.

- Resolved an issue where `MaterialFunctionInstance` failed to retrieve all parameters from the associated material function.

## Verse Updates and Fixes

### API

Fixes:

- Added support to `MoveTo` for creative objects to scale something up from zero to a non-zero value.

### Tools

Fixes:

- Fixed false dependency errors in the digests generated by UEFN for VS Code.
