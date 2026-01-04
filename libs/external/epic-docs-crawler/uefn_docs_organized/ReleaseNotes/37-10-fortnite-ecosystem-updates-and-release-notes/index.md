# 37.10 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/37-10-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-26T23:15:44.374693

---

Fortnite v37.10 introduces two new commands to the Debug Command menu, the exciting addition of The Front Man character to Squid Game islands, and several new weapons, prefabs, and galleries.

## Reminder: UEFN Memory Calculation Enforcement

As of v37.10, islands exceeding the 100,000-unit memory limit cannot be published or updated. To submit a new version for publishing, you’ll need to reduce your island’s memory usage below the threshold.

Read the updated [Memory Management documentation](https://dev.epicgames.com/documentation/en-us/fortnite/memory-management-in-unreal-editor-for-fortnite) for optimization tips.

This enforcement follows the [v37.00 update](https://dev.epicgames.com/documentation/en-us/fortnite/37-00-fortnite-ecosystem-updates-and-release-notes), which moved memory calculation to cook-time data for faster, more accurate results and expanded support for more asset types and Scene Graph.

Driven by creator feedback, this change helps reduce the long wait times for memory calculations that creators have experienced, and is part of our ongoing effort to provide accurate, timely insights so you can focus on building complex, compelling experiences without unnecessary delays.

We’re committed to improving performance and stability for creators. Upcoming updates will further address memory challenges. See the roadmap for additional details.

Published islands above the limit may cause performance issues on low-end devices. Severe outlier islands may be removed to ensure a good player experience.

## New Debug Commands

We are committed to improving your efficiency in debugging using the New Debug Command menu with frequent releases of new debug commands. This release we are adding:

- **Increase Score** - Instantly adds the requested number to the players score
- **Decrease Score** - Instantly subtracts the requested number from the players score

We appreciate the thoughtful responses in the [Fortnite Creator Most Wanted Debug Commands](https://forums.unrealengine.com/t/fortnite-creator-most-wanted-debug-commands-aug-2025/2623988) forum post. Your input is helping us better understand the community's priorities. We’re keeping the thread open a bit longer to gather even more great suggestions, keep ‘em coming!

## Hammerhead Choppa Spawner

[![](https://dev.epicgames.com/community/api/documentation/image/c5e34dc1-814d-4b29-bc6b-99b2216eb4d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5e34dc1-814d-4b29-bc6b-99b2216eb4d5?resizing_type=fit)

The new Hammerhead Choppa from BR is now available in UEFN and Creative. This new helicopter has unique qualities, like the ability to boost. It also hovers for an extended period of time, which allows the pilot to swap seats to fire at enemies without having the Choppa immediately begin to fall to the ground. Players will also enjoy playing music from the loudspeaker while swooping down to attack enemies.

The option exists to allow players to skydive after exiting the Choppa in flight. This option has also been added to the existing helicopter device.

## Content Browser and Inventory Updates

Check out all the new items available this release!

### New Weapons

- Veiled Precision SMG
- Eradicator Shadow Precision SMG
- Eradicator Hop Rock Fury Assault Rifle
- Eradicator Marksman Wrecker Revolver

### New Items

- Precision Air Strike

### New Prefabs & Galleries

- Demon's Domain Wall Gallery
- Demon's Domain Floor and Stairs Gallery
- Demon's Domain Roof Gallery
- Demon's Domain Foundation Gallery
- Demon's Domain Props Gallery
- Demon's Domain Nature Gallery
- Demon's Domain Storage Building
- Demon's Domain Temple

## Apply for an Epic MegaGrant by September 22

[![](https://dev.epicgames.com/community/api/documentation/image/3858f2fe-f6f3-40b7-9717-684aa61209da?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3858f2fe-f6f3-40b7-9717-684aa61209da?resizing_type=fit)

Got a bold and creative UEFN project idea? Bring it to life with support from a MegaGrant!  We’re accepting submissions until September 22 at 11:59 PM ET. Find out more here: <https://www.fortnite.com/news/epic-megagrants-2025-cycle-2-apply-now-for-uefn-project-support>

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where some debug settings, such as navigation debug, could not be turned on while in-game during an edit session.

  - [Forum Report](https://forums.unrealengine.com/t/nav-mesh-debug-preview-no-longer-appears/2606106)
- First Person Camera sequences now function correctly by reducing awkward camera angles when assigned to a player.

  - [Forum Report](https://forums.unrealengine.com/t/first-person-camera-device-completely-broken/2633510)
- Fixed an issue where the Thunderbolt of Zeus was failing to function correctly in Creative games.

  - [Forum Report](https://forums.unrealengine.com/t/the-thunderbolt-of-zeus-item-is-not-working/2638460)
- Fixed an issue where Proximity Chat was activated on all islands by default, even though the setting was unchecked

  - [Forum Report](https://forums.unrealengine.com/t/the-proximity-chat-is-activated-by-default-on-all-islands-despite-the-fact-that-it-is-unchecked-in-the-island-settings/2634103)
- Fixed an issue where Siphon settings were not working as expected.

  - [Forum Report](https://forums.unrealengine.com/t/siphon-is-not-working-after-latest-update/2633846)

## Fortnite Ecosystem Updates and Fixes

**New**:

- **Island Settings**

  - New Dynamic Team Emotes in the Team Settings category.

**Fixes**:

- **Weapons**

  - Fixed a bug affecting Wraps that were applied to the Spire Rifle.
  - Fixed an issue causing TNTina's Ka-Boom Bow from using the Infinite Charges Island Setting.
  - Fixed an issue where activating the Thunderbolt of Zeus triggered its cooldown without doing anything.
  - Fixed an issue where the Typhoon Blade's sprint ability could persist after the player is eliminated.
  - Fixed an issue where the Grappler and Grapple Glider UI claimed the weapon had more uses available than what was possible.
- **Consumables**

  - Fixed Overdrive not respecting the Infinite Consumables Island Setting.
- **Prefabs and Galleries**

  - Fixed validation issues in the Fencing Fields and Crime City prefabs and galleries.
- **Island Settings**

  - The Manage Team emote page is no longer visible on islands that do not enable Dynamic Team Emotes.

## Device Updates and Fixes

**New**:

- **Hiding Prop Gallery**

  - The Port-a-Potty has a new option, Hiding Prop Mesh, that swaps the default Port-a-Potty look for the Military model.
- **Verse API**

  - Added Verse support for the new Supply Drop Spawner functionality for Drop Pods — supply\_drop\_spawner\_device now has a function. DestroySpawnedDrops to destroy any supply drops spawned by the device, and an event DestroyCrateEvent to detect when the crate is destroyed.
- **New Verse API for the Disguise device**:

  - Added RemoveANYDisguise
  - Added ApplyANYDisguiseEvent / BreakANYDisguiseEvent / RemoveANYDisguiseEvent
  - Added IsANYDisguiseApplied
- **New Verse API for the Carryable Spawner device**:

  - Added AgentCollideEvent

**Fixes**:

- **General**

  - Several devices now work as expected when Dynamic Team Emotes is enabled.
- **HUD Controller**

  - Fixed a validation error that prevented the Custom Widget Quickbar from appearing at first launch.
- **Carryable Spawner**

  - Fixed an issue where the Carryable asset collided with the player carrying the device when thrown from Force-Pickup.

## Brand Island Updates and Fixes

**New**:

- **LEGO® Islands**

  - Added a new audio cue for the LEGO Gold Stud collectibles.
- **Squid Game**

  - Added Squid Game-specific player participant characters as options in the Disguise device.
  - Player Participant Disguises & Player Participant NPCs display random jumpsuit numbers.
  - Added the Front Man character as both an NPC and a Guard cosmetic option.
  - Added the Front Man character to the Disguise device.
  - Added the Front Man character as a new disguise kit.

**Fixes**:

- **LEGO® Islands**

  - Fixed and updated questing language as well as the “Affected Fade Distance” Barrier device options in the LEGO Action Adventure and LEGO Bloom Tycoon templates.
  - NPCs in LEGO Islands always spawned with an angry face, even if they were friendly or not actively attacking you. They now spawn with a neutral expression, and switch to the angry face when attacking.

### Squid Game Known Issues: Cuddle Team Leader

The current selected collision preset with the Cuddle Team Leader only includes player collisions but not bullets or SpectatorDroneCamera collisions.

To change the collision preset for the Cuddle Team Leader asset to allow for these extra collisions, follow these steps:

- Drag the Cuddle Team Leader asset into your level.
- In the Details panel, find the Collision section.
- In the Collision section, locate and change the Collision Preset to:

- **FortDynamicMesh** - To allow player collisions and bullet collisions.
- **BlockAll** - To allow player collisions, bullet collisions and additionally block `FCC_Object_SpectatorDroneCamera`, which then allows the camera to collide with the mesh.

## UEFN Updates and Fixes

**New**:

- **Editor**

  - Updated the in-editor localized asset tooling to fully support Verse identifiers.
- **Editor UI**

  - New iconography to help distinguish between modules that are owned source and modules that are referenced read-only.
- **Animation and Cinematics**

  - Added permissions for MovieSceneTimeWarpDecoration.

**Fixes**:

- **Editor**

  - Fixed an issue that caused actors to be renamed when opening multiple outliners.
  - Fixed a regression error where the 2D Snap Layer menu was not available in the new viewport toolbar.
  - Fixed an issue that caused a crash state after creating a new empty level with vertex snapping enabled.
  - Actors created in UEFN via LiveEdit are now given a default unique label.
  - Fixed an issue that caused UEFN to fail when launched against GPUs that support DX11 and are outside of the DX12 support range.
  - Fixed a data validation error for catalog offers that always returned a successful state even when there was a data validation error.
  - Set Overrides of SetHiddenInEditor so components can be hidden in the viewport via their internal actor proxy.
- **In-Game UI**

  - When enabling the Top Center Scoreboard HUD in Island Settings, it will now take into account, when using anything other than Score as the Stat to End setting, displaying the goal and current team score values as appropriate.
- **Fortnite Tools Mode**

  - The 3D Select tool has been fixed so it no longer affects the Visibility Component of the static mesh on an actor. Instead, it uses the Outliner's Eyeball. This means that if you change the eyeball (temporary visibility) while using 3D Select, the 3D Select Tool will override it. However, whatever visibility each actor has when you start the tool will be correctly remembered.
- **Environments and Landscapes**

  - Fixed an issue where landscape proxies were updated without user intervention.
  - Crash states are now preventable when redoing an undo of a Water Zone actor deletion.
- **Modeling Mode**

  - A new realtime warning for modeling mode and scriptable tools mode prevents false warnings from popping up.
- **Animation and Cinematics**

  - Now allows Time Warp Tracks in Sequencer.

## Unreal Revision Control (URC)

**New**:

- Reduced save times have been added by moving more processes related to the automated backups on-save to be asynchronous and non-blocking.
- Reduced time spent waiting for Updating Revision Control status by making optimizations to fetch status less often has also been added.

**Fixes**:

- Fixed an issue that caused restoring an older snapshot to latest to intermittently fail.
- Fixed an issue that resulted in lock status not being reliably reported across collaborating users, and the Snapshot History not automatically refreshing, due to the client ceasing to receive URC events after a stream disconnect.
- Partially fixed an issue resulting in users getting locked out of assets that they had just added/edited. This issue should now only occur if there are active unresolved conflicts, and normal behavior will resume once conflicts are resolved. A further fix to address this case as well will come in a future release.
- Fixed an issue causing high CPU use and slow FPS, which resolves after checking in changes if the user has not checked in for a considerable time.
