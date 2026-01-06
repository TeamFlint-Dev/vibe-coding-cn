# 28.00 Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/28-00-release-notes-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:32:12.222006

---

## 28.30 What's New

See the [Fortnite Ecosystem Patch Notes - V28.30 Update](https://create.fortnite.com/news/fortnite-ecosystem-v28-30) for the latest news and release highlights.

## Creative

**New:**

- Changed the Ballistic Shield category from Item to Weapon.
- Changed the hold time on the **Drop** button from 3.0 seconds to 0.5 seconds.

**Fixes:**

- When a player attacks with the Shockwave Mace, it will now pop any attached balloons. This avoids triggering an infinite animation.
- Fixed several appearance-related bugs on Fortnite characters.
- Fixed an issue in the Creative Island Settings where the UI category disappeared when certain options were changed.
- Fixed an issue where the Mythic Goldfish appeared in an extraneous Mythic category in the Creative inventory.

### Devices

**New:**

- Added an option to disable VFX on the Movement Modulator device.

**Fixes:**

- Fixed an issue with the Campfire device where it was not respecting the Start Lit option when the device was activated.
- Fixed an issue with the Character device showing as a dot during placement.
- The Air Vent device is no longer destroyable.
- Fixed the Rate Scale on VFX Spawner device.
- Fixed an issue on the Chair device where the Phone tool could not interact with invisible chairs.
- Fixed broken Race checkpoints.

## Creative and UEFN

**Fixes:**

- Fixed an issue with blending camera POV data for UEFN/Creative camera devices during transitions, where the blend type from both cameras was being used to calculate the blended POV, instead of the transition data for the highest priority camera.
- Creative/UEFN camera devices now use spherical linear interpolation when blending camera rotations to make sure the shortest path is used for transitions.

### Devices

**New:**

- Added an option to the Class Selector device to increase the speed of class changes, which could previously only be applied once every three seconds. The VFX used for a change in class now applies the color of the Class Selector.
- You can now configure the Prop Mover so it doesn't move a prop back past its starting position.

**Fixes:**

- The Transition Out Time option for the Camera devices is now used when transitioning from a custom camera to a standard Fortnite camera.
- Fixed an issue where weapons and items previews were not centered on the Item Spawner.
- Fixed an issue with missing hologram presets in the Dance Mannequin device.
- The Dance Mannequin now correctly dances when properly configured, instead of remaining static.
- Fixed a Chair device issue where the OnPlayerExit event would execute twice.
- Fixed an issue with the VFX Powerup device where Custom VFX was not showing up correctly when the device was too far from the player.

## UEFN

**New:**

- The Sparkplug and Rustler character cosmetics can now be used with the Character, NPC Spawner, and Guard Spawner devices.
- Changed the default value for the **Join In Progress** island setting to **Spawn On Next Round**. Existing projects are not affected and will continue to use the previously-set value.
- Added the **WorldTimeOfDayManagerRotationZ** property on World Settings to control the rotation of the Time of Day Manager at spawn time.

**Fixes:**

- Fixed the Audio Clock source dialog in the Sequencer, which was not closing after being dismissed.
- Fixed an issue where the in-editor event-binding cache failed to update.

### Devices

**Fixes:**

- Fixed an issue where the Race Manager UI was not visible in Edit mode.
- Fixed an issue where the Verse resize function for the Map device was not affecting the Trigger Zone.
- The Beacon device now displays in UEFN regardless of team and class settings.
- Patchwork Note Sequencer devices with non-default Timing Styles will no longer try to save after entering Play mode if there were no other changes made to the device.
- Patchwork devices no longer re-enable themselves after returning from Play mode to Edit mode.
- Renamed **SpawnCharacterAtGameStart** on the NPC Spawner device to **EnabledAtGameStart**.

## Verse

**New:**

- Added support for using paths in qualifiers. You can now do things like `(/path/to/A:)A := 5`.
- Restored the legacy behavior of how mixed semicolon/newline/comma blocks were being treated to avoid changing the behavior of how we find conflicting definitions. In some cases, the compiler was treating code that used mixed separators inconsistently, resulting in different behavior depending on the context. This is now consistent across all usage.
- The LSP now reports global diagnostics appropriately (that is, diagnostics that are not associated with a particular locus).

**Fixes:**

- Amalgamates now respond to source control events in Verse Explorer instead of triggering a refresh on every single source control event. Now everything will happen once per 0.5f interval at the most.

### API

**Fixes:**

- Fixed a crash when accessing `fort_playspace` from default constructed devices.
- No returns an error state for a negative play rate when using the PlayAnimation API.

**Known issue:**

- The particle system API that appears in Verse API and VFX assets is reflected into the Assets.digest.verse file, but users will be unable to launch a session with projects that use this feature.

## 28.20 What's New

See the [Fortnite Ecosystem Patch Notes - V28.20 Update](https://create.fortnite.com/news/fortnite-ecosystem-v28-20) for the latest news and release highlights.

## Creative

**New:**

- All Splash items are now properly tagged as **Throwable**.

**Fixes:**

- Fixed a bug where the NPC AIs would stack when navigating on the Citadel Village Stair.
- Fixed a bug where the sliding effect of the Chiller Grenade lasted indefinitely.

### Devices

**Fixes:**

- Balanced the volumes for Piano and Horns in the Patchwork Instrument Player (I-PLAY) device.
- Audio device cables are now clamped to prevent them from scaling too large when large amplitude values are played.
- Fixed an issue where Patchwork devices caused Fortnite to crash. You can now create a sustain in a row that already has 2 or more other sustains.
- The preview mesh for the Character device now works correctly when using the Phone tool to interact with the device.

## Creative and UEFN

### Devices

**New:**

- Updated the Tracker device for consistency and ease.

**Fixes:**

- The Transition Out Time option for the camera device is now used when transitioning from a custom camera to a standard Fortnite camera.
- Fixed an issue where a Level Loader device could prevent creators from using the Phone tool.
- Fixed an issue where previews for Weapons and Items weren't centered on the Item Spawner.
- Clearing persistence data now works correctly on all Powerup devices after the player respawns.
- Custom effects set by the VFX Powerup device now correctly persist through elimination.
- Fixed an issue where the Mutator Zone was not affecting the player if they entered it in a Baller vehicle.

## UEFN

**New:**

- Compiling materials for mobile is now automatically part of the compiler process.
- Added several updates to Day/Night Cycles:

  - Added a new time of day manager for **Day/Night Cycle - Chapter 5** that fixes an issue that was preventing the Day Sequence device Sky/Cloud settings from applying.
  - The former Day/Night Cycle - Chapter 5 is now labeled **Day/Night Cycle - Chapter 5 Deprecated**. Levels that are using this deprecated time of day manager are recommended to update to **Day/Night Cycle - Chapter 5**.

**Fixes:**

- Fixed issues with Sequencer when splitting or adding new sections to the Binding Lifetime track.
- Fixed the audio clock source dialog in Sequencer so dialogue now dismisses properly when the player selects No.
- Removed a duplicate option from the UEFN Experience Settings.
- Fixed an issue where rounded borders were not cropping with materials.

### Devices

**Fixes:**

- The Beacon device now always displays in UEFN no matter what the Team and Class settings are.
- Fixed a bug where the Automated Turret didn't properly damage NPCs from the NPC Spawner.

## Verse

**New:**

- Devices supporting Verse can now be placed in a data layer.
- More logging was added for when Verse project workspaces fail to get written to disk.

**Fixes:**

- Fixed a bug where the character teleport was not behaving the same in VKEdit and VKPlay.
- Added boilerplate to asset digests and marked them as read-only. This now correctly removes empty modules from amalgamated digests.
- Fixed an issue where user source packages were inadvertently getting pruned from the VS Code workspace, causing the `.vproject` file to be written out (since they do not have digests generated for them when user `.verse` scripts have errors).

### Known Issue: Mixing semicolons/commas/newlines to separate sub-expressions

Previously, mixing semicolons/commas/newlines to separate sub-expressions was allowed, and resulted in something like:

```verse
A,
B
for (A := 0..2):
# more code here
```

Internally this code desugared to something like:

```verse
block:
    A
    B
for (A := 0..2):
# more code here
```

This meant that either definition of `A` did not conflict with each other, as there was an implicit `block` created that had its own separate scope.

In an upcoming version of the Verse compiler, this will not be allowed. Now the same code will actually treat each sub-expression separately, resulting in the following:

```verse
A
B
for (A := 0..2):
# more code here
```

This means that the first `A` and the second definition of `A := 0..2` now shadow each other and cannot be disambiguated.

To resolve this issue, creators (and anyone else who relies on this behavior) will need to change instances where they mix semicolon/commas/newlines to separate sub-expressions across all their Verse code.

For example, here there is a comma after `.Translation,`:

```verse
PropPosition := Prop.GetTransform().Translation,

if(Round[PropPosition.Z] = Round[ROOT_POSITION.Z]) { break }
Sleep(0.0)
```

In the new format, the comma should be removed from `.Translation`:

```verse
PropPosition := Prop.GetTransform().Translation # note the trailing comma here has been removed

if(Round[PropPosition.Z] = Round[ROOT_POSITION.Z]) { break }
Sleep(0.0)
```

Starting with this release, a warning will appear whenever any mixed separators are detected. Additionally, you may also see symbol disambiguation errors with the warning. We recommend you update your code as soon as possible to avoid your projects breaking in future releases.

### API

**New:**

- Added `MakeComponentWiseDeltaRotation` to verse rotation type.
- Added Public Verse API for the Map Controller Device.

## 28.10 What's New

See the [Fortnite Ecosystem Patch Notes - V28.10 Update](https://create.fortnite.com/news/fortnite-ecosystem-v28-10) for the latest news and release highlights.

## Creative

**Fixes:**

- Fixed an issue with the **Patchwork Note Sequencer** device where crashes occurred while creating a sustain in the same row that already had two or more other sustains.
- Fixed an instance where rounds concluded with a draw in matches that were set to **Free for All** and **Last Standing Ends Game**.
- Fixed an issue that could cause the player's camera to automatically pitch downward if they slide then aim with a sniper rifle.
- Fixed an issue where wheels were disappearing on dynamic structures when crossing from one tile to another after being loaded from persistence.
- Fixed issue where **Jules' Drum Gun** used the same visuals as **Midas' Drum Gun**.
- Fixed an issue where the **Midas Flopper** was unable to upgrade the player's weapons.

### Devices

**Fixes:**

- Fixed a case where the **Matchmaking Portal** device could become unresponsive.
- Fixed an issue where the **Audio Player** device displayed a blank mesh option.
- The **Damage Volume** device no longer ignores selected team settings vehicles.

## Creative and UEFN

**New:**

- The **Fire** trap, alongside many other traps, was moved from **Devices** to the **Items** tab and is now accessible to players.
- The Phone Tool's **Invulnerable** and **Flight Phase** will now persist on the character while enabled.

### Devices

**New:**

- The **Patchwork Speaker** device now always allows players to hear the speaker's output in **Create mode** regardless of the **Can Be Heard By** setting, allowing an easier preview of the speaker's content.

**Fixes:**

- Fixed an issue where the **Camera: Fixed Angle** and **Camera: Fixed Point** device view locations would start from the world origin when returning from being blocked or disabled (such as when exiting a vehicle).
- Fixed an issue where the Camera device modes blocked cinematic camera sequences from showing.
- The Patchwork Value Setter device no longer triggers after moving Patchwork devices or disconnecting and reconnecting cables.
- Disabling the **Patchwork Music Manager** device no longer causes other Patchwork devices to play at an extremely slow rate and will instead stop completely as intended.

## UEFN

**Fixes:**

- Fixed the missing Asset Family toolbar in animation editors.
- Fixed an issue where the camera view becomes detached from a player if they respawn during a cinematic.
- Traps placed in UEFN will no longer destroy themselves after a certain number of uses.
- Fixed incorrect shading on mirrored Nanite meshes when a two-sided material is used.

### NPC Spawner Device Limitations and Known Issues

**Known Limitations**

- Existing devices may not yet fully support spawned characters or events. Examples include Mutator Zone, Trigger Device, and Tracker Device.
- Guards spawned from the NPC Spawner don’t have feature parity with guards spawned from the Guard Spawner.
- Wildlife spawned from the NPC Spawner doesn’t have feature parity with wildlife spawned from the Wildlife Spawner.
- Currently unable to modify movement speed and velocity.
- Nested hierarchies in Character Blueprints aren’t currently supported.

**Known Bugs**

- NPCs using a Cosmetic modifier and Character Blueprints do not play Spawn/Despawn VFX.
- Awareness does not propagate between NPC Guards.
- Guards can't use ziplines.
- Wildlife can be ridden when assigned to a different Team Index by the player.
- Display Names don’t appear for Wildlife and Custom NPC types.

### Devices

**Fixes:**

- Fixed validation errors that occurred for **Explosive Barrel** devices with the Health Bar Style option are now set to **Badge Style**.
- The **Tracker** device will now track stats between rounds in UEFN when set to do so.

### Unreal Revision Control

**New:**

- Added a Conflict Resolution dialog that allows in-editor conflict resolution when working in teams.

## 28.00 What's New

See the [Fortnite Ecosystem Patch Notes - V28.00 Update](https://create.fortnite.com/news/fortnite-ecosystem-v28-00-update) for the latest news and release highlights.

## Creative

**Fixes**:

- Joining a party in Fortnite Creative no longer results in a Game Full message, players now receive the proper **Party Full** message.
- The **Flush font** has been optimized for use across all platforms.

### Devices

**Fixes**:

- Devices appear in the Creative Inventory and rotate to face the player when spawning a fresh device from the Quickbar. If the **Grid Snap** setting is set to **On**, devices rotate to the nearest point on the Creative Compass. This does not apply to galleries or devices copied from the world.
- Devices that register a class or team change now receive the proper **Class/Team Changed** event before or during the play start countdown. For example, if you link a Class or Team Changed event to a Trigger, the device's event now correctly activates the Trigger.
- All devices that register class changes now receive the **Class Changed** event during play after the countdown. For example, the HUD Device now register’s a player’s class change during gameplay.
- **Falcon Scouts** no longer shows collision visual effects when boosting through a Teleporter Device while editing an island.
- The **Grappler Bow** is no longer categorized as an Explosive weapon.
- Players are no longer stuck in a firing animation when using Infinite Ammo in Creative.

## Creative and UEFN

**Fixes**:

- The user option **LocalFogVolume Actor** can now be set to True or False using a tick.

### Devices

**Fixes**:

- The **Automated Turret** is now destructible during games regardless of the device options.

### Camera and Control Devices Limitations

Because the new camera and control devices in this release are still in Early Access, there are a few limitations.

**Cameras**

- Camera transitions may have a slight delay.
- Certain full-screen effects may look out of place when using a subset of weapons and devices.
- Camera roll is disabled.
- Cameras are disabled when entering vehicles.

**Controls**

- Controls are not compatible with all weapons and devices.
- Sprint and mantling is disabled with the current control modes.
- Diving during freefall is not enabled during Early Access and is not enabled within the custom control.
- Building is disabled.
- Controls are disabled when entering vehicles.

**Known Issues**

- Fixed Point Camera and Fixed Angle cameras are unable to reset to their original states in experiences with multiple rounds using the cameras. There are several workarounds to address this issue:

  - Exit and load back into Creative mode.
  - Add the option **Remove on Elimination** to the active cameras and set the event to **Add the Camera to Player on Player Spawned** on all player spawners

### Fortnite Patchwork

**Fixes**:

- The **Preview VFX** pink outline effect now appears properly based on the player's distance from the Patchwork device.
- The **Patchwork Value Setter Device's** FX is responsive and animates when the value is set.
- The front mesh of the **Patchwork Instrument Player** now highlights correctly.
- The **Patchwork Step Modulator's** preview VFX are now positioned correctly when the device is sized up or down from its default scale.
- The player's camera follows the User’s input and does not rotate when dragging a sustain quickly on a Note Sequencer.
- The **Patchwork tool reticule** now displays and works properly after swapping from it to another weapon or to an unarmed state.
- **Patchwork devices** feature an adjusted grab position on cables to make them more intuitive for players to position the cable head on the cable port when connecting devices.
- Environmental audio effects are no longer applied to Patchwork audio.
- The **Patchwork Modulator** no longer sets its output value to **0** when connected to another device while the modulator is disabled.
- **Patchwork Speaker** features an adjusted music priority order to prevent speakers from muting musical emotes.

## UEFN

**New**:

- New **Gameplay Event Tracker for Sequencer** functionality provides a way to trigger gameplay events on a device at a specific point in time in Sequencer. This new feature also works with Verse. Use a call on any Verse function, including a function on an authored Verse device.

  Gameplay Events in Sequencer do not work with Verse authored custom devices, this feature only works with the devices found in the Content Browser's **Device folder**.
- New **Rigid Body with Control** node option on the parent space transform of each constraint in a physics asset to compensate for any difference between the skeleton used to create the physics asset and the current skeleton.

  Using the new Rigid Body with Control node option it’s possible to use a single physics asset with multiple skeletons, as long as the bones associated with each body in the physics asset exist in all the target skeletons.
- Exposed **Curve Metadata** tabs in the Animation, Skeletal, and Skeletal Mesh editors.

**Fixes**:

- Improved packaging on **SkeletalMeshComponent** for a 16 byte gain. This improvement results in additional variables to this class hierarchy in C++. Optimize the class hierarchy to fit a static assert. Disabling the assert uses an additional 288 bytes per SkeletalMeshComponentBudgeted in the game.

  Use the CruncherSharp tool provided in the Engine\Extras\ThirdPartyNotUE\crunchersharp folder to help optimisation.
- Improved Audio functionality:

  - **SoundWave Resampling** now reflects the frame positions when resampling SoundWave audio in editor and package builds.
  - **CuePoints** reflect Resampling of sound waves in editor and in package builds.
  - **Rescale CuePoints** uses a similar process as CurrentPlatformSampleRate at editor time, during Serialization and during Initialization of SoundWaveDataPtr.

### Devices

**Fixes**:

- The **Patchwork Music Manager** in UEFN now displays beats properly.
- The Map Indicator device has a new user option for **Custom Icon Material**, **Custom Icon Size** and **Use Custom Widget**.
- Devices no longer show internal options not meant for public use which could negatively affect the functionality of those devices.

### Editor

**New:**

- Fortnite’s **Building Grid Snapping** is now visible while dragging actors.
- Updated tooltips for several Post-Processing settings.

**Fixes:**

- The **Actor Context Menu** now respects **IsLockLocation()** on the actor.
- The 0-360 limit has been removed from rotation sliders to provide a way to scroll into negative rotations and beyond 360 rotations.
- Morph targets can now be imported via FBX.
- Resolved validation errors related to Materials when using HLODs with certain types of Fortnite assets.

## Verse

Below are new features for the Verse API.

### API

**New**:

- Patchwork devices now feature Verse support.

## Creator Portal

**Fixes**:

- Creators can resubmit a version for publishing if the moderation process times out or expires.

## Unreal Revision Control

**Fixes**:

- Fixed a sporadic crash when reverting changes.
- Optimized download speed for projects with many assets.
