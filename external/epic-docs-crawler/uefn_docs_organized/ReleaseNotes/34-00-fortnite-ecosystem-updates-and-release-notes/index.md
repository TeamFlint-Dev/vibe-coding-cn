# 34.00 Fortnite Ecosystem Updates and Release Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/34-00-fortnite-ecosystem-updates-and-release-notes>
> **爬取时间**: 2025-12-27T00:33:50.258572

---

Power up your UI with the new User Interface feature template! It's packed with examples and assets you can export to your own projects. The v34.00 update also brings new testing capabilities, including automated multiplayer testing with simulated test players and enhanced spatial profiling tools. Plus, explore fresh learning content with the new Time of Day Platformer and Survival Tutorial, along with new Device Design examples.

Read on to find out more!

## New User Interface Feature Template

The newest project template features assets you can export into your own projects, and comprehensive widget setups that you can easily use in your own game. The feature template showcases the different Creative devices that support UMG widgets and demonstrates the level of customization capable in UEFN.

[![Collectible quest indicator in the User Interface Feature Template](https://dev.epicgames.com/community/api/documentation/image/38e19c3e-da26-438a-b437-517d5633b96d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38e19c3e-da26-438a-b437-517d5633b96d?resizing_type=fit)

With this template, you can open the different User Widgets to see how they were set up, browse the custom materials and textures, then use them in your projects to design your own unique user interfaces. See the [User Interface Feature Template](https://dev.epicgames.com/documentation/en-us/fortnite/user-interfaces-feature-template-in-unreal-editor-for-fortnite) companion documentation to learn more about the Materials and Material Instances used in the samples, discover the available UI tutorials, and better understand how widgets are designed.

## Forward-Right-Up (FRU) Coordinate System for Scene Graph Experimental

This is an experimental feature. If you are not using Scene Graph, you will continue to use the XYZ coordinate system for all transforms and are not impacted by this change.

For creators using Scene Graph Experimental, there are new changes in the 34.00 release to the UEFN coordinate system. This means that in some instances, you will need to update existing transform functions.

Currently, the XYZ transform (Transform, Rotate, and Scale) coordinates are based on vector3 types that live in the `/UnrealEngine.com/Temporary/SpatialMath` module.

We are introducing a new /Verse.org/SpatialMath module that redefines the XYZ coordinates and vector3 as: **Forward, Right, Up (FRU)**.

- Forward (was X)
- Right (was Y)
- Up (was Z)

These experimental updates are currently limited to the Scene Graph API. This means you will continue to see XYZ in the outliner across the rest of the editor:

- Both the Verse module transforms and the Unreal Engine module transforms are running concurrently within the Verse API and UEFN. If you use Verse module transforms, it uses FRU. If you use Unreal Engine module transforms, it uses XYZ.

- If you are using API functions that use Verse module transforms and Unreal Engine module transforms in the **same file**, the type names need to be qualified by their **path** to avoid any ambiguity between the two modules:

  - `/UnrealEngine.com/Temporary/SpatialMath`
  - `/Verse.org/SpatialMath`

```verse
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/SpatialMath }

my_class := class:
 MyUnrealEngineVector:(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = (/UnrealEngine.com/Temporary/SpatialMath:)vector3{}
 MyVerseVector:(/Verse.org/SpatialMath:)vector3 = (/Verse.org/SpatialMath:)vector3{}
```

To learn more about the FRU coordinate change, see Forward-Right-Up Coordinates System documentation. To learn more about the coordinate system in general, see [Coordinate System and Spaces in Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/coordinate-system-and-spaces-in-unreal-engine).

### Converting from XYZ to FRU

If you are using any existing API functions that have switched to the Verse module transforms (FRU), you will need to convert your user-defined Unreal Engine transforms (XYZ) to use FRU, or to use the newly created FromTransform conversion functions.

To learn more about the conversion process, see Forward-Right-Up Coordinates System.

## Automated Multiplayer Testing with Test Player Settings

You can now spawn simulated test players to verify multiplayer functionality without the need for multiple accounts, devices, or volunteers to join a session. After enabling debug, the **Test Player** settings become available. You can configure whether or not test players are spawned on start and how many test players will spawn on the island, up to the maximum number allowed.

For more information, check out [Multiplayer Previewing](https://dev.epicgames.com/documentation/en-us/fortnite/multiplayer-previewing-in-unreal-editor-for-fortnite). See **Test Player Known Issues** further down in the release notes for known issues and workarounds.

## New Bank Vault Device

The new **[Bank Vault](https://dev.epicgames.com/documentation/en-us/fortnite/using-bank-vault-devices-in-fortnite-creative)** device adds break-in vault gameplay to your island and is used with the Thermite item. The Bank Vaults have weak points that must be destroyed using Thermite before the vault implodes. There are several options available to control which players can initiate the vault break-in, the number of weak points, and how the weak points take damage. You can also script your own events for when a break-in has started and use functions to control the state of the door.

[![bank vault device with thermite activated on the door](https://dev.epicgames.com/community/api/documentation/image/8bb53045-76ba-495f-b23d-2e4f62e24afb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8bb53045-76ba-495f-b23d-2e4f62e24afb?resizing_type=fit)

## New Rift Point Volume Device and Rift Point Device Item

The [Rift Point Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-rift-point-volume-devices-in-fortnite-creative) device is based on Ballistic mechanics and specifically works with the **Rift Point Device** item to replicate the bomb set up and diffuse mechanics. This includes options like **Plant Time**, **Defuse Time**, and **Detonation**.

[![deploying the rift point device item](https://dev.epicgames.com/community/api/documentation/image/807e3b7e-5eb7-4aca-b3cd-953ff23380a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/807e3b7e-5eb7-4aca-b3cd-953ff23380a2?resizing_type=fit)

## Spatial Profiler Updates and Improvements

There are several major improvements to Spatial Profiler that optimize and expand on the current capabilities. Learn more about these changes on the [Spatial Profiler](https://dev.epicgames.com/documentation/en-us/fortnite/spatial-profiler-in-unreal-editor-for-fortnite) documentation.

Spatial Profiler now allows you to:

- Load multiple files to better compare previously saved metric data.
- Sample multiple sources in the live session, allowing you to gather client and server metrics simultaneously.
- Remember previous metric selections to streamline capture sessions.

There are also several updates for viewing and expanding how to view data:

- A session browser allows navigation between a live session where metrics are captured and any previously saved sessions.
- A tree view represents the metrics contained within a session. Each metric has a status indicator to communicate its performance state.
- A histogram view provides a timeline to signal performance spikes for each metric during a live session capture.

## Time of Day Platformer and Survival Tutorial

Learn how to create basic level-up and time-jump mechanics that change the gameplay based on time of day. By day, the game is a platformer where a player collects coins, but by night, the game turns into a fight for survival where the player defends against Creature hordes.

See the [Time Jumping Platformer and Survival Game](https://dev.epicgames.com/documentation/en-us/fortnite/time-jumping-platformer-and-survival-game-in-unreal-editor-for-fortnite) tutorial for more on how to set up the game, and for art direction on set dressing, creating a custom UI, and adding music.

[![scenery showcasing coins to collect](https://dev.epicgames.com/community/api/documentation/image/dcd33f7b-88f0-4c21-87a7-aebcf4067051?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dcd33f7b-88f0-4c21-87a7-aebcf4067051?resizing_type=fit)

## New Device Design Example Documentation

Want to learn some fun new ways to use devices? See our two new device design example  docs!

- The [Barrier Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/barrier-device-design-examples-in-fortnite-creative) page starts by showing how to make a basic border, then how to build a protected spawn zone. It brings things home with the steps you'd need to make a Melee Time Trial game!
- The [Tracker Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/tracker-device-design-examples) page provides different ways to use the Tracker device, from building a timed escape room to creating a farming game!

[![tracker device example showing a farm plot with crops](https://dev.epicgames.com/community/api/documentation/image/c06b87f6-25fc-4ed4-a583-573de44001bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c06b87f6-25fc-4ed4-a583-573de44001bb?resizing_type=fit)

## Content Browser and Inventory Updates and Fixes

Check out the latest content additions, updates, and bug fixes for the Content Browser inventory!

### Content Browser New UI Is Default

The new Content Browser UI and navigation is now the default UI. You can learn more about how to navigate the new UI at [Exploring the Content Browser Menu](https://dev.epicgames.com/documentation/en-us/fortnite/exploring-the-content-browser-menu-in-fortnite-creative).

### Device Updates and Fixes

**New:**

- Player Marker Device - **Primary Color** and **Secondary Color** options are now available only when the **Show Marker** setting is set to **Yes**.
- Player Marker Device - **Visible for tracked player** and **Beacon Duration** options are no longer dependent on the **Position Update Frequency** setting.
- Reticle status such as the **No Ammo** text can be hidden by the new **Display Reticle** option in the HUD Controller device.
- Added a **Destroy** option to Hiding Props.
- Grind Rail devices have a new selection to the Visual Style option: **Mine Rail**. As of now, the only difference is the mesh applied to the spline. VFX/SFX and everything else should be identical to the Standard variant

**Fixes:**

- Barrel explosion behavior now works correctly when in the game reset state.
- Fixed an issue where Earth Sprite would not stop chewing after spitting out an item.
- Flag Item restrictions can no longer be avoided by using Quick Weapon.

- Fixed an issue where the timer did not reset when the **Reset Timer if Failing Team** or **Class Check** option was turned on.
- Fixed an issue where users were unable to modify the Timed Objective Device after starting and ending the game.
- Fixed an issue where the top half of the Automated Turret device was immune to damage from weapons.
- Fixed an issue where the countdown on the HUD did not appear after the Timed Objective device was activated.
- Fixed an issue where users were unable to interact with props or devices within a Campfire's volume.
- Fixed an issue where the Prop-O-Matic's countdown animation was broken when another user was present.
- Fixed an issue where users in Changing Booths could not interact with devices when the pre-game countdown ended.
- Fixed for creatures not spawning between player-built walls where there is space to do so: The **Destroy Structures** player option is now hidden if **SpawnThroughWalls** is turned off in the island settings.
- Fixed an issue where the Prop Mover device failed to start moving via the Begin function in Verse unless the Sleep function was called first.
- Fixed an issue where the Trigger device failed to activate when in contact with water.
- Fixed a bug that allowed players to use weapons while invisible after changing cosmetics inside a Changing Booth.
- Tank Spawner Device - Thermal vision now works during aim in tank.

### New Weapons

1. The Kneecapper
2. Plasma Burst Laser
3. Collateral Damage Assault Rifle
4. Falcon Eye Sniper Rifle
5. Baron’s Double Down Pistol
6. Mythic Suppressed Pistol
7. Pump & Dump Shotgun

### New Items

1. Med-Mist Smoke Grenade
2. Legendary Chug Jug (the existing Legendary Chug Jug was renamed to Legacy Chug Jug)
3. Port-A-Cover
4. Pulse Scanner
5. Gold Splash
6. Thermite

### New Prefabs

1. Japanese Dojo Watchtower
2. Japanese Dojo Kenjutsu Crossing
3. Japanese Dojo Fireglow Sanctuary
4. Japanese Dojo Coldwater Sanctuary
5. Shady Stilts Building C
6. Shady Stilts Building D
7. Redline Rig Platform
8. Redline Rig Drill

### New Galleries

1. Japanese Dojo Zen Garden Gallery
2. Japanese Dojo Wall and Fence Gallery
3. Japanese Dojo Roof Gallery
4. Japanese Dojo Foundation Gallery
5. Japanese Dojo Floor and Stair Gallery
6. Japanese Dojo Prop Gallery
7. Rainforest Plane Prop Gallery
8. Redline Rig Wall & Roof Gallery
9. Redline Rig Floor & Stair Gallery
10. Redline Rig Prop Gallery A
11. Redline Rig Prop Gallery B
12. Redline Rig Prop Gallery C

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

1. Fixed an issue where the Conversation Bank did not display the Speaker Name and Speech for join-in-progress players.

   - [Forum Issue Report](https://forums.unrealengine.com/t/conversation-device-bugged-for-join-in-progress/2107724)
2. Fixed an issue where the Explosive device would fall through the map after interacting with the Button device twice in quick succession.

   - [Forum Issue Report](https://forums.unrealengine.com/t/explosive-device-falls-through-the-map/1721347)
3. Fixed an issue where the RemoveWidget function did not clean up properly.

   - [Forum Issue Report](https://forums.unrealengine.com/t/removewidget-function-does-not-clean-up-properly/1934515/20)
4. Fixed an editor crash that occurred when submitting changes for a map material.

   - [Forum Issue Report](https://forums.unrealengine.com/t/map-controller-custom-material-crashed-client/2230903)

## Fortnite Ecosystem Updates and Fixes

**New:**

- Added missing tags to several items and weapons.
- Force Max Touchpad Sensitivity: Added a Windows PC-only keyboard/mouse user setting that changes the touchpad sensitivity while the game is focused so that touchpad input is not suppressed while using the keyboard. The setting is on by default and can be disabled by the user.

**Fixes:**

- Fixed an issue where slow motion at the end of the round was not working properly.
- Fixed an issue where player-built structures did not persist correctly between games when set to persist between rounds.

- Fixed path patrolling AI not currently moving to a new assigned path when assigned one after its current path became unreachable.
- ixed NPCs stopping emoting when the player swaps emotes.
- Fixed a bug for the First Person Camera where the visual effect from the flashbang grenade would disable the rendering effect that prevents the weapon from clipping with world geometry.
- Fixed the phone tool deleting the last actor hovered over if the phone was no longer hovering over a target.
- Fixed the delete action of the phone tool deleting the most recent hovered object even if no object is currently hovered over.
- Cleared the active move tool target when there are no valid targets to select from.

- Fixed an issue with an override on vehicles and chairs that allowed invisible players to sit on them.
- Fixed an issue where the Flare Gun incorrectly responded to the Infinite Consumables island setting.
- Fixed an issue where firing the Flare Gun or Firework Flare Gun with infinite ammo forced them to be discarded.

- Fixed an issue so the Stat Creator UI now shows correctly when when a player joins a game that’s in progress.
- Fixed issue that prevented the storm overlay from rendering on the minimap in creative experiences.

### Test Player Known Issues

- Test Players do not spawn the first time when Auto-Start is enabled on the island.

  - **Workaround:** Stop and start the game again.
- Test Player model may appear stretched when DBNO and far away from the player.
- Player count on screen may be inaccurate after eliminating Test Players and ending the round.
- Test Players do not drop reboot cards.
- Stopping a session before all Test Players have spawned will cause the incorrect number to spawn the next time
- Spawning close to 100 Test Players can break spawning and cause them to no longer spawn.
- The number of Test Players cannot be manually set higher than 30 in UEFN without using the Fill option.
- Using Test Players is not representative of the performance cost of playing with real players.
- Test Players are not enabled in LEGO® Islands and Fall Guys islands.

  - This will be added in a future release.
- The following cannot currently be triggered by Test Players:

  - Switch Device
  - Powerup Device
  - Capture Area Device
  - Checkpoint Pad

## Brand Island Updates

### LEGO® Islands

**Fixes:**

- Fixed the Assembly device audio loop getting stuck.

### TMNT Islands

**New:**

- The Mouser NPC now supports the use of the Patrol Path Character Modifier, which can be added to the Character Definition. This allows the Mouser character to be assigned to and patrol along patrol paths.

### Rocket Racing

New:

- Added a new **Cooldown Delay** option to the Rocket Racing Nitro Hoop device. This setting controls the delay between the cooldown state being triggered by someone going through the hoop and when the cooldown actually starts. The delay can be anywhere from 0 to 5 seconds long. The delay can also be accessed with Verse in UEFN, using `SetCooldownDelay` and `GetCooldownDelay`.
- Maximum server time for building Rocket Racing islands has been increased to 4 hours.
- Creators can now change the duration for Speed Run mode in Rocket Racing islands with the `MatchTimeLimitSeconds` option in the `RR Speed Run Race Manager` device.

## UEFN Updates and Fixes

**New:**

- Static mesh actors are now supported by the Phone Tool. There's now a `EnabledForPhoneTool` flag that can be unset on static mesh actors to prohibit phone tool interactions. The `EnabledForPhoneTool` flag is unset for static mesh actors that are used as floors to avoid accidental interaction. This will force a resave for some actors in existing maps upon starting a session.
- Added a check when starting a session in UEFN for static mesh actors. If names are matched among common names used as terrain, interaction with the move tool is disabled.

**Fixes:**

- Fixed an issue where the UEFN minimum scaling was inconsistent with Creative, preventing the client from reselecting assets.

### Animation and Cinematics

**New:**

- The Animation Layer tab is now available in UEFN.
- Exposed the acceleration mode for angular and linear joint drive.

**Fixes:**

- Sequencer: Fixed root motion paths in the case of swap root bone actor so that the actor walks along the path rather than the path moving along with the character.
- Sequencer: Fixed root motion and authoring of root motion in cases where the Skeletal Mesh Component is not the root component and has a rotational offset (such as 90 degrees).
- Sequencer: The Animation Track 'root motion' now works with Evaluate Nearest Section. Previously, using evaluate nearest section with animation sequence tracks would only grab the previous pose from the section, but not apply the root motion properly.
- Fixed an issue with Take Recorder where transform tracks would store incorrect values and result in incorrect sequencer playback.
- Fixed a particle jittering issue when involved in a free joint. Disabled inertia conditioning on a particle when it is involved in a free joint.
- Fixed the pushing cube's different behavior under different FPS. Scale impulse applied in `UCharacterMovementComponent::ApplyImpactPhysicsForces` to be consistent with time scale.
- Fixed the issue of particles not going to sleep from an external `SetObjectState(Sleeping)` call in async mode.
- Corrected the COM and new inertia computation with the COM nudge.
- Fixed the root bone root motion to match between sections by adding an Ignore Root Lock option to the extraction settings. This wasn't working because the calculations to compare root bone positions weren't working when 'force root lock' was selected on the animation sequence options.

### Audio

- Exposed the modulation as a property on Metasound sources in UEFN.
- Fixed the audio repeating in a sequence when time dilation was set below 1 and audio was not set to looping.

### Editor

**New:**

- Fixed assets missing from UEFN Content Browser when starting the editor with Open Last Project on Startup enabled.
- Streamlined the various dialog boxes that appear when launching a session on a non-default map into a single dialog that only appears when user intervention is necessary.
- Export Localization now runs within the current editor instance, which offers a significant performance improvement (running in seconds rather than minutes) compared to running it as a separate editor instance.
- Various improvements to trap placement and manipulation in the editor:

  - Traps now reevaluate their placement whenever they are moved during placement, which makes it much easier to visualize how a trap will place.
  - Buildings with attached traps now move their attached traps in a way that correctly preserves their existing attachment. This also ensures that wall traps stay attached to the correct side of the building, as previously flipping a wall 180 degrees would cause the trap to flip its attachment side.
- Blueprints are no longer auto-sanitized prior to upload.

  - Instead, they will be validated prior to upload to verify they have no restricted content. If a Blueprint is found to have restricted content, then a Sanitize Blueprint fixer option will be offered to explicitly sanitize the Blueprint.
  - This avoids issues where Blueprints containing restricted content (typically those migrated from UE) would silently check themselves out prior to upload, causing contention issues for teams.
- Improved wording for various tooltips.
- Updated the Launch Session button tooltip to indicate that it may be disabled due to UEFN being out of date.

**Fixes:**

- Fixed some menu entries that didn't show up when right-clicking game assets in the Content Browser.
- Fixed an issue with the anchored note tool that  the selection mode to become unset.
- Fixed cut actors not syncing their labels to UEFN with Live Edit.

### Environments and Landscapes and Lighting

**New:**

- Made several optimizations for landscape sculpting.
- Added Landscape Visualizers and LOD options to the UEFN level editor view modes menu.
- Added a Perform Fortnite Cell Snap While Dragging editor preference that toggles Fortnite cell snapping on building pieces when dragging them in the level editor viewport.

**Fixes:**

- Replaced the Disable Editor Cell Snap world setting with an Enable Fortnite Cell Snap editor preference which can be conveniently toggled from the level editor viewport.
- Fixed a crash that occurred when showing landscape collision mesh after a material asset failed to load.
- Fixed landscape heightmap import from a tiled image set when the file path contains brackets.
- Fixed landscape heightmap import in expand mode when the target region extends outside the landscape.
- Fixed landscape heightmap export tile filenames when regions are not loaded. Also hid the UI control for export mode (loaded-only vs all) when export is selected, since it has no effect.
- Updated the physical material mask correctly when unpainting or clearing the weightmap. The mask also catches the component weightmaps that have lost their last non-zero texels and follows through with the correct update notifications.
- Fixed the generation of bad landscape physical material data after opening a map.

- Fixed minor issues with the GTAO console command.

### Materials

**Fixes:**

- Removed the `cvars r.MaterialEditor.AllowIgnoringCompilationErrors` and all `r.Material.ContextMenu.*` entries, replacing them with corresponding options in the Material Editor settings.
- Fixed occasional crashes that occurred when changing scalability settings, possibly due uniform expression data not being reached. Changing the scalability settings now always triggers updating materials uniform expression data when some setting has changed.
- Fixed a bug occurring when trying to duplicate a default Material with an incorrect EditorOnlyData name.

### Modeling

**New:**

- Added Mesh Element Selection and its related functionality to the new viewport toolbar in Modeling Mode.

**Fixes:**

- Fixed an issue that could cause the edit pivot tool to hang on undo/redo.
- Ensured that users will not be able to prematurely accept the UV Snapshot tool as it's busy computing, and added clarification through visual feedback to be displayed as this computation occurs.
- Fixed an issue where the Dynamic Sculpt tool would log 'unknown brush type' warnings when using Kelvinlet brushes.
- The Mesh to Collision tool's Convex Decomposition algorithm now works on flat input meshes. It will generate convex hulls with width based on the 'thicken on hull failure' setting.

### Unreal Revision Control

- Added POST\_NOTIFICATIONS permission to `AndroidTargetDevice` to avoid application hangup.

### Scene Graph

**New:**

- Added `<final_super>` to scene graph components.
- Removed some old spatial shapes.
- Removed deprecated spatial queries.

## Verse Updates and Fixes

**Fixes:**

- Fixed a validation error. Updated scripts to accommodate test players.
- Made various fixes with the heartbeat not playing and prop score timer not working.
- Updated the compiler to generate an error message if a class inherits from a struct, instead of crashing. `s := struct{} c := class(s){}`
- Made changes to fix the function `GetButtonText()` in verse on the Popup Dialog Device so it returns the correct value of the text.

### Verse Language Updates and Fixes

**Fixes:**

- Made rationals comparable. Made `int` a subtype of `rational`.
- Fixed the `<localizes>` handling of comments in the string, and comments and whitespace inside the string interpolants.
- Methods in interfaces can now have default implementations. It's possible to override the implementation in a class, but not in another interface.

  Interfaces can contain data fields without default values. It's possible to override an interface data field in a class, but not in another interface. A class that inherits from an interface along more than one path still only gets one copy of each data field in the interface.

  There is only one `V0` in `c`.

  ```verse
  i0 := interface { V0:int }
  i1:= interface(i0){ V1:int }
  i2:= interface(i0){ V2:int}
  c := class(i1,i2) {}

  O:c=c{ V0:=1, V1:=2, V2:=3 }
  ```

  ```verse
  O.V0 access the unique V0
  O.(i1:)V access the V in i1
  O.(i2:)V access the V in i2
  ```

### API Updates

**New:**

- Creator code that make use of both the types in `/UnrealEngine.com/Temporary/SpatialMath` and `/Verse.org/SpatialMath` will need to fully qualify the usage of those types. For example:

```verse
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/SpatialMath }

my_class := class():
  OldVector:(/UnrealEngine.com/Temporary/SpatialMath:)vector3 := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{}
  NewVector:(/Verse.org/SpatialMath:)vector3 := (/Verse.org/SpatialMath:)vector3{}
```
