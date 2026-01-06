# 37.20 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/37-20-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-26T23:14:48.804335

---

Fortnite v37.20 introduces the Roly Poly Spawner device, the Hive Stash Chest, and new prefabs and galleries from the O.X.R. Base and The Hive. This update also adds three new Debug Command menu options, new tutorials, and the ability to subscribe to input action events and mapping contexts directly through Verse.

## New Experimental Character Inputs!

You can now subscribe to input action events and mapping contexts directly through Verse. The following character input actions are supported:

- Jump
- Crouch
- Shoot (Weapon Primary)
- Target (Weapon Secondary)
- Sprint

The inputs are currently Experimental, but over time, more functionality will be added to this list of input actions. We want to provide a clean and clear way to use the various controls available in UEFN.

## My First Island Feature Example!

Get started in My First Island with this new feature example! See how the carnival shooting gallery was set up, including the custom Verse device code to earn points for shooting the good targets, and detracting points for shooting the bad targets — –who wants to hit a cute bear?

This template showcases the full gameplay example set up in the [Build Your First Island](https://dev.epicgames.com/documentation/en-us/fortnite/build-your-first-island-in-fortnite) documentation tutorial series, and even adds a little more, using a HUD Message device to show the player score.

## Deprecation of Creative Custom Input Keybinds

After some consideration, we have decided to deprecate custom Creative keybindings. While the names for these keybinds referenced associated Fortnite actions (like Shoot or Aim), they were referencing the default keybinds for those actions. So if a player changed their "fire" keybind to something that wasn't the default, the Creative keybind would not change, which was by design.

This has created  problems for developers because they don't have a way to "guarantee" an action is lined up to the expectation. This has also created a problem for players, as a creator might say "use your shoot button to do x" but because the player changed their shoot keybind, and the creator is using creative input 1 (shoot), the player is expecting their new shoot keybind, and will be confused about why it doesn't work.

Going forward, we are removing  the Creative Custom inputs from the Settings menu, but not from the Input Trigger device. For creators, there should functionally be no difference.  For players, there could potentially be a difference if they had rebound any of the Creative Custom Input keybinds.

This change will currently only affect:

- Fire
- Target
- Crouch
- Jump
- Sprint

## Advanced Learning: New Coordinate Battle Island and Tutorial!

Deep dive into mathematics to level up your gameplay and get deeper insights into modern game design practices!

With the [Coordinate Battle Tutorial](https://dev.epicgames.com/documentation/en-us/fortnite/coordinate-battle-tutorial), you can learn how some of the ways coordinates in two- and three-dimensional spaces affect gameplay, and learn how to build a two-person battle based on guessing coordinates as you go!

The island code for the Coordinate Battle game will be coming soon! Stay tuned!

## Get Started with Verse: New Combo System Tutorial!

This beginner Verse tutorial uses the Your First Island template to show off how Verse can really level up your island! In this tutorial you will:

- Build a point combo system for the shooting gallery.
- Add timer and bonus timer systems.
- Level up your weapons as you progress.
- Learn about refactoring code, an integral part of iterative programming and design.

To start the tutorial, you can open the My First Island project and jump right into the [Your First Island: Level Up with Verse](https://dev.epicgames.com/documentation/en-us/fortnite/your-first-island-level-up-with-verse-in-fortnite)!

## New Debug Commands

We are committed to improving your efficiency in debugging using the Beta Debug Command menu with frequent releases of new debug commands. This release we are adding:

- Pause Round Timer - Pause or resume the island round timer.
- End Round - Force the current round to end.
- End Game  - Force the current game to end.

## New Roly Poly Spawner Device

The Roly Poly is a bug that wraps around the player for creative gameplay where both player and bug bounce and roll around the map. Use the device to spawn a customizable Roly Poly in your Creative games.

Learn more about using the Roly Poly device on your island with the [Roly Poly Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-roly-poly-devices-in-fortnite) page.

[![roly poly spawner device](https://dev.epicgames.com/community/api/documentation/image/6b0f150f-98a9-494f-b85a-39f016cedca2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b0f150f-98a9-494f-b85a-39f016cedca2?resizing_type=fit)

## New Hive Stash Chest

The Hive Stash is a strange organic structure that may have something — or someone — inside . Find it in the Chest & Ammo device gallery.

[![hive stash chest item](https://dev.epicgames.com/community/api/documentation/image/4874cf02-b693-4753-be27-d695b719090a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4874cf02-b693-4753-be27-d695b719090a?resizing_type=fit)

## New Prefabs & Galleries

- O.X.R. Destroyed Base
- O.X.R. Comms Building
- O.X.R. Base
- O.X.R. Wall Gallery
- O.X.R. Roof Gallery
- O.X.R. Floor and Stairs Gallery
- O.X.R. Prop Gallery
- The Hive Nature Gallery
- The Hive Gallery

[![o x r comms building prefab](https://dev.epicgames.com/community/api/documentation/image/45ea62e0-238e-498c-ba85-1b4c7fb99d1d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/45ea62e0-238e-498c-ba85-1b4c7fb99d1d?resizing_type=fit)

[![the hive nature gallery](https://dev.epicgames.com/community/api/documentation/image/703ae582-4539-4dda-8dac-28a60145c8d1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/703ae582-4539-4dda-8dac-28a60145c8d1?resizing_type=fit)

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where Always Show Nameplate when set to **Always Show To All** was not working correctly and was limited to 150m for enemy users.

  - [Forum Report](https://forums.unrealengine.com/t/issue-enemy-nameplates-disappear-beyond-150m-in-uefn-hurts-open-world-party-games/2623794/27)
- Fixed an issue where entering the Changing Booth during matchmaking hid the UI and trapped the user, requiring a client restart.

  - [Forum Report](https://forums.unrealengine.com/t/changing-booth-matchmaking-issue/2530226)
- Fixed an issue with missing collision on FNEC Chainlink Wall C and FNEC Chainlink Fence C props from the Seaport City gallery.

  - [Forum Report](https://forums.unrealengine.com/t/the-fnec-chainlink-wall-c-and-fnec-chainlink-fence-c-props-from-the-seaport-city-gallery-are-missing-collision/2443955)
- Fixed an issue where the Overlord Spire Elimination Animation got stuck in a loop.

  - [Forum Report](https://forums.unrealengine.com/t/overlord-spire-elimination-animation-gets-stuck-in-a-loop-when-reset-is-called-during-the-animation/2638376)
- Fixed an issue with the Carryable Object Device disregarding settings and exploding.

  - [Forum Report](https://forums.unrealengine.com/t/carryable-object-device-repetitively-exploding-despite-explosion-settings-being-disabled/2575705)

## Fortnite Ecosystem Updates and Fixes

**New:**

- **Chest and Ammo Gallery**

  - New Hive Stash device added to the gallery.
- **Proximity Chat**

  - Minor performance enhancements when Proximity Chat is enabled.
  - When using Proximity Chat, player names now appear in the **Speaking Player** list while they are talking.
  - When using Proximity Chat, the names of other players that are speaking appear more quickly.
  - The voice indicators of other speaking players are more responsive to changes in the talking state. For example, they appear more quickly when other players start talking and disappear more quickly when they stop talking.
- **Island Settings**

  - Enabling HUD Info Type and selecting the information type provides a way to display the goal and current team score values when Show Top Center Scoreboard HUD is also enabled.

**Fixes:**

- **Island Settings**

  - Fixed a bug where matchmaking is not disabled for a second round when setting the Island Setting for **Mode** > **Matchmaking Privacy** to **Public** and using the Round Settings device to control matchmaking at the end of a round. See Device Updates and Fixes below for more information.
- **Items**

  - Fixed an issue where the Slap effect (such as from a Slap Cannon) would not override high energy costs from Island Settings.
  - Fixed issue where Launch Pad material would revert back to Legacy Launch Pad material.
  - Fixed issue where Launch Pad Trap sound effects did not match the Launch Pad Throw version.
- **Weapons**

  - Fixed an issue where the Myst Gauntlets, Ascended Myst, Rocket Drill, and Ballistic Shield did not respect the Weapon Destruction island settings.
  - Fixed an issue that prevented the Precision Air Strike from firing when the consumables Infinite setting was set to On.
  - Fixed wraps for the Wrecker Revolver.
  - Fixed an issue with Precision Air Strike destroying structures when E**nvironment Damage** is **OFF**.
- **Props and Galleries**

  - Fixed a material issue causing bad shadows on cornfield wall props.

### Player Input Known Issue:

Input consumption is broken if you are using:

- Custom 1 (Fire)
- Custom 2 (Target)
- Custom 3 (Crouch)
- Custom 4 (Jump)
- Custom 5 (Sprint)

**Workaround:** Use and consume standard input equivalents. In an upcoming release these inputs will map to standard input keybinds.

## Device Updates and Fixes

**New:**

- **Damage Amplifier Powerup**

  - New option for Affects Damage Cap causes the damage multiplier to also affect the shotgun damage cap.
- **Teleporter**

  - Improved the physical interaction between the Teleporter device and physical props.

**Fixes:**

- **Trigger**

  - Fixed an issue that disabled the Trigger device when the Delayed Instigator setting was set to Queue and the Delay to 0.
- **Fixed Point Camera**

  - Fixed an issue with the Fixed Point Camera device where moving the device via cinematic or script wasn't updating the camera view.
- **Round Settings**

  - Fixed a bug where setting the Disable Matchmaking on Round End option to On and triggering the device to end the round on an event does not result in disabling matchmaking for the second round when the Island Setting for Mode > Matchmaking Privacy is set to Public.
- **Changing Booth & Matchmaking Portal**

  - Fixed an issue where the Changing Booth trapped players inside when the Changing Booth UI would disappear because the Matchmaking Portal device was attempting to matchmake.
- **Carryable Spawner Device**

  - Fixed an issue where on certain islands, the carryable would self-explode shortly after spawn.
  - Fixed an issue where the carryable would occasionally not do damage when thrown at a target at close range.
- **Disguise Device**

  - Fixed an issue with the Disguise device where disguises would not apply if no inventory room was available.
- **Voting Device**

  - Fixed an issue with the voting device where trying to vote for the same option twice wouldn't generate a vote failed event.
- **Bank Vault**

  - Fixed an issue with weak points taking damage from behind.

## Brand Island Updates and Fixes

**Fixes:**

- **Squid Game**

  - LOD fixes for Matrix\_Pillar\_Corner\_A\_A and Matrix\_VentHorizontal\_A.

## UEFN Updates and Fixes

**Fixes:**

- **Editor**

  - Fixed an issue that prevented a StaticMeshActor from saving after it was placed  with the Phone Tool during an edit session.
  - Fixed a spawning issue where the spawn location would be in the wrong spot.
  - Fixed an issue that caused a crash when using DX12 performance mode on some GPUs.
  - Prevented the editor from selecting ES31 feature level, which is not supported.
  - Fixed a crash state that could occur in UpdateWorldEstimation for the LevelPackageDiskSize spatial profiler metric.

- **Environments and Landscapes**

  - Fixed an issue to prevent a crash state when redoing an undo of a Water Zone actor deletion.
  - Fixed an issue where an invalid collision box actor automatically generated when a waterbody's Wave Source property was changed from the Blueprint Editor.
  - Fixed an issue that prevented landscapes from being put in the list of files to save when there were conflicts with proxy actors.
  - Fixed an issue that caused a crash state when trying to save a map with an erroneous landscape materials

- **General**

  - The Launch Pad device now launches players in the direction of the device's rotation.
  - Events are now sent and queued when activating the trigger device event signals when setting Delayed Instigator to Queue.
  - Multiple Prop Movers can be assigned to the same Prop when using Prop Reference.
  - The Volume device now properly triggers when the radius is set at a non-default value.
  - Volume size matches the visuals even when not pushing changes after client modification.
  - Corrected Spire Verse properties to display the actual value when retrieved instead of the original value.
  - Currencies now appear correctly in the HUD.

## Scene Graph

**New:**

- Introduced Outliner and Prefab editor viewport drag & drop for entities.
- Added an experimental project setting for entity prefab in-place editor mode.

**Fixes:**

- Fixed an issue where duplicating an array’s property value entry in the UI prevented instances of a Verse class and prefab from working properly.

## Unreal Revision Control (URC)

**Fixes:**

- Fixed an intermittent crash of the URC library that was caused by an API call.

## General Physics Experimental

**New:**

- Players can now nosedive when spawning in the sky or moving around in a Skydive Volume.
- You can now enable multiple Prop Movers to be assigned to the same prop when using the **Prop Reference** option.
- Gravity limits are now between -10,000 and -10.
- Added new sound options for Leather, Rubber Hard, and Rubber Soft impacts.
- Terminal velocity in physics-enabled islands has been increased from its previous max of 40m/s. New max is 500m/s (in line with certain launch/bouncer devices).

**Fixes:**

- Device Latency is now fixed for Air Vent, Crash Pad, D -Launcher, Env Trap Bouncer, Launch Pad, and Teleporter devices.
- Players can now collide normally while gliding inside a Skydive Volume.
- The player pawn no longer has issues moving up a staircase.
- The transition between crouching and sprinting is now smooth, without any jitters.
- Props can be pushed around by the user's pawn.
- Regarding physics characters, Fortnite’s gravity is now the default when using Experimental Physics.
- The camera now syncs with the pawn movement as intended.
- The selected Sound / VFX Preset is now correctly applied to the associated prop.
- The First-Person Camera is now set to players on game start on an island with Physics enabled.
- The player pawn now correctly repositions to the Player Spawner device after starting a game with no initial damage taken.
- Moving physics props with a sound preset set to **None** correctly remains silent.
- Props do not have any desync when **Start awake** is set to **Disabled**.
- Players can now reach the top of Skydive Volumes.
- The Physics Tree and Boulder are now properly affected by gravity.
- The player is now knocked back in the correct direction by the pinball bumpers.
- The movement animation will no longer play when the player is crouched and stationary on a moving prop.
- Players now float in the Water Volume device.
- The pawn no longer climbs the prop and instead collides with it properly.

### Physics Experimental Known Issues

- Player sprinting is accelerating slowly. This causes foot sliding as the character does not accelerate as it should. This will be addressed in a near future release.
- The Bouncer Forward Launch values do not apply to Physics Props. We are looking into a solution for this to give the device more options.
- Skydive Volume: Push Forces above 0 will not push the player to the top of the volume.
- Skydive Volume: The Launch Velocity option does not work properly. We are aware of the issue and will address it in a subsequent release.
