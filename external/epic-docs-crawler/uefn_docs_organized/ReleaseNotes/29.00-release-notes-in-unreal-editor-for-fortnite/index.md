# 29.00 Release Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/29.00-release-notes-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:32:17.393894

---

## 29.40 What's New

See the [Fortnite Ecosystem Patch Notes - V29.40 Update](https://create.fortnite.com/news/fortnite-ecosystem-v29.40) for the latest news and release highlights.

## Creative and UEFN

**Fixes**:

- Player Passenger Animation: Fixed an issue where it was possible for the player's animation to be out of sync with the vehicle when leaning out of vehicle windows.
- Fixed an issue where a custom camera was no longer active after a player respawned from inside a vehicle.
- Fixed a bug with First Person edit mode that was preventing object placement and instead opening the Quick Menu with the assigned hotkey.
- Fixed an issue where the Grapple Glider was unable to properly function.
- Fixed an issue in Creative/UEFN that prevented players from joining during round transitions.

### Devices

**New**:

- Added new options to the Team Settings and Inventory device: **Respawn player** and **Spawn the instigating player at the most appropriate player spawner**.
- Added a **Respawn Player** event in the Player Spawner device — when toggled, the instigating player is respawned from that spawn pad if able.
- Added a new option in the **Player Spawner** and **Team Settings and Inventory** devices that determines whether players that respawn are active when the **Respawn Player** event is called.
- Added the **Respawn Spectate Behavior** option in Island Settings > Spectate. This determines whether eliminated players will enter the usual respawning spectate mode (following teammates) or if the screen should quickly fade to black after their elimination.
- Added the **Do Not Spawn** option in **Spawn Location** in the island settings.

**Fixes**:

- Fixed the remaining instances of old terminology in the Pulse Trigger device, removing all references to the old Sequencer terminology.
- Fixed an issue where a number of the **Input Trigger** device input names were not localizing.
- Reduced the hit target size for Patchwork Modulator cable heads, making it easier to target other nearby controls when the cable is connected.
- Fixed the Patchwork device screens not saving their open state after changes in Create mode.
- Fixed a bug on the **Patchwork Value Setter** where connected device text might not update correctly on all clients when the cable is connected to another device's control.

## UEFN

**New**:

- 'Curve Atlases' and 'Curve Linear Color' are now visible inside of materials in UEFN.
- Sound compression is now exposed in UEFN when importing Sound Wave assets, allowing a user to choose between Bink and PCM. Previously, only Bink was supported.
- The AttenuationSettings property on Sound Cues is now exposed.
- Game View can now be toggled in orthographic viewports.
- Added support for viewing Item Definitions in a Read Only Asset Editor when running UEFN.
- Added **Copy Template Ids to Clipboard** to the Context Menu for all item definitions when running UEFN.
- Added source control filters to the Outliner.

**Fixes:**

- Fixed the "in progress" spin box in the Details panel that would not complete transactions and would hold undo transactions open until the editor restarted.
- Fixed an issue where widgets from previously set objects in a Details panel were never removed if the Details panel was set to have no objects.
- Fixed a few situations where actors could be deleted in-editor after pushing changes.
- Fixed a crash when attempting to add a MetaHuman before a project was loaded.

### Devices

**Fixes**:

- Fix a bug where the **NPC Spawner** device was facing the opposite direction from the player when placed through the Phone tool.
- Fixed a bug where the **Creature Manager** device base mesh was missing when duplicated on **Live Edit**.
- Unavailable options for the **Skydive Volume** deviceare now hidden instead of showing as disabled, to prevent confusion.
- Fixed an issue where sound cues were not populating in the dropdown for audio devices on LEGO Islands in UEFN.
- Fixed a bug in the **NPC Spawner** device where the Taming function was not working on wildlife.

## Verse

**Fixes**:

- For the Pulse Trigger device, the Verse function `ResumeSequence()` has been deprecated and `ResumePulse()` has been added. The original function will still compile and work as before, but with a Verse compiler warning.
- Updated the `fort_character` function `TeleportTo()` to provide log feedback when the teleport fails.
- Improved the Verse `TeleportTo()` error message printout to include target destination.

## 29.30 What's New

See the [Fortnite Ecosystem Patch Notes - V29.30 Update](https://create.fortnite.com/news/fortnite-ecosystem-v29.30) for the latest news and release highlights.

## Creative

**New**:

- Added **Building as Prop** to the **LEGO Creator** toolset.

**Fixes**

- Fixed an issue for **Edit Mode** where objects could not be placed and the **Quick Menu** shortcut key was not functional.
- Fixed a bug where the **Character** device's preview mesh behaved incorrectly while editing its scale and positioning.
- Fixed an issue where the **Skydive Volume** device placed players in a constant skydive state when the **Phase** option was set to **On**.
- Fixed a bug where **Patchwork** device screens might not save their open state after changing it.
- Fixed some instances where **Patchwork** devices appeared disabled but would still play, or appeared enabled but wouldn't play.
- Fixed an issue where players could not interact with a **Patchwork** device if there was previously a **Collectibles** object in front of the device screen.
- Fixed an issue where the **Cozy Campfire** and **Proximity Mine** did not appear in the Rare category.
- Fixed the **Skydive Volume** device's overlapping events.

## Creative and UEFN

**New**:

- **Player Spawner** devices have a new **Respawn Player** option.
- Added **Do Not Spawn** option in **Spawn Location** in the Island Settings.
- Reduced the hit target size for **LFO** and **Step Modulator** device cable heads.
- Hub-type islands are no longer available when selecting Starter Islands. Islands that have already been created with the hub type are unaffected by this change.
- The **Advanced Storm Beacon** device now updates storm information more efficiently.

**Fixes**:

- Adjusted the meta sound used to play the open and closed sounds on **Patchwork** devices.
- Improved the description of **Island Settings - Player** option **Structure Damage** world setting to reference that it needs **Environment Damage** enabled to work properly.
- Fixed a bug where custom cameras were not restored on respawn for **Lego** template islands.
- Fixed a bug where respawning during camera restricting actions did not restore the camera on respawn.
- Fixed the issue where **Basic Sword** and **Basic Hammer** could not use the sprint attack.
- Fixed the issue where ledges inconsistently generate on stone and metal walls.

### Devices

Fixes:

- **Control: Third Person** device's control options are reapplied correctly on spawn after a player is eliminated inside a vehicle.
- Fixed an issue with the **Input Trigger** device where the number of the input names were not localizing.
- The **Control: Third Person** device no longer causes players to jitter when trying to perform a 180º turn on high FPS environments when the selected **Facing Direction** option is set to **Movement**.
- Adjusted the minimum and maximum values for the **Patchwork Filter** device.
- The **Pinball Bumper** device's **Custom Side Lift Strength** option now functions as intended.
- The **Advance Storm Beacon** device's **Phase** settings can now update the storm information without affecting the battle royale flow.
- Fixed a bug where part of the **Patchwork** devices' tooltip text could be accidentally hidden.
- Fix a bug where the **AI Patrol Path Node** device icon would not properly display on the first placement.

## UEFN

**New**:

- When publishing or uploading an island, users will now be prompted to rebuild the landscape if any inconsistencies are detected.
- New Niagara effect types are available for selection in Niagara systems.
- Added functionality to filter the **Outliner** by Revision Control Status when using **Unreal Revision Control**.

**Fixes**:

- Fixed an issue where **Trap** devices could crash if colliding with a component that has no parent actor.
- Fixed a bug where the **Creature Manager** device's base mesh is missing when being duplicated on **Live Edit**.
- Fix a bug where the **NPC Spawner** device is facing the opposite direction from the player when placed through the **Phone Tool**.
- The editor no longer crashes when launching a session while a non-finish line **RR Checkpoint** device references the start line RR Checkpoint device in their **Next Checkpoints** array.
- **SkyLight** intensity levels are now correct.
- Fixed Niagara asset tag definitions from appearing in the **Niagara Asset Browser** when the originating asset isn't visible in the Content Browser.
- Fixed Niagara Systems created with default Niagara emitters not validating due to a thumbnail issue.

## Verse

**Fixes**:

- Fixed the following issues related to the final specifier. These changes aren't backwards compatible but are dormant for UEFN projects that were uploaded prior to 29.30 to avoid breaking live projects.

  - Final fields can no longer be overridden by an archetype.
  - Final fields must now have a default value.
  - The final specifier is no longer allowed on local definitions.
- Fixed an issue with the serialization of `logic` variables that could cause cooking to fail.
- Functions with the `localizes` specifier can now use named parameters. Errors in parameter definitions of functions with the `localizes` specifier are now reported when defining the function. It is no longer necessary to use the function to get an error message.

## 29.20 What's New

See the [Fortnite Ecosystem Patch Notes - V29.20 Update](https://create.fortnite.com/news/fortnite-ecosystem-v29-20) for the latest news and release highlights.

## Creative

**Fixes:**

- Fixed a bug where the keybind for the build tool quick menu was disabled during Create mode.
- Fixed a bug that prevented placing and moving objects in Create mode.

### Devices

**Fixes:**

- Fixed an issue where devices like the Item Spawner didn't show the proper mods on certain weapons during Create mode.

## Creative and UEFN

**New:**

- Renamed the **Infinite Ammo** option to **Infinite Reserve Ammo** in the Island Settings to better signify what the option is doing. This setting does not affect magazine ammo.
- Corrected and improved some option names and tooltips for the Island Queue Privacy settings.

**Fixes:**

- Fixed an issue where AIs would not be properly highlighted by thermal vision right after spawning.
- Fixed an issue where weapons spawned with the Creative Inventory **Drop** button had no ammo.
- The Self-Damage island setting now works correctly.
- Fixed a bug on LEGO® template islands where the custom camera system wasn't reactivating on respawn.

### Devices

**Fixes:**

- Fixed an issue where the **On Class Selected** event wouldn't fire when a player's class was selected through the **Class Selector UI** on the map screen.
- Fixed an issue where ignored players would sometimes be unable to interact with objects inside the **Barrier** device.
- Fixed an issue where items thrown onto a **Bouncer** device did not get the forward velocity defined in the device settings.
- Fixed a bug that prevented the **Despawn Range** option from working correctly on the **Creature Spawner** device.
- Fixed a bug that prevented the **Character** device from updating with the **Character Controller** device.

## UEFN

**New:**

- The Bone Influence Limit property is now editable in the Skeletal Mesh Editor.
- Updated the UEFN Project Browser to auto select the first item when choosing a category.
- Added properties to allow more granular control over cracks and wobble for FN props.
- Added the option **Affect Indirect Lighting While Hidden** for static meshes.
- Added **Curve Linear Color Atlases** and **Curve Linear Color Curves** to UEFN so users can incorporate gradients inside their materials

**Fixes:**

- Various fixes to the LiveLink Hub:
  - Fixed the LiveLink subject status from disappearing in read-only mode.
  - Fixed the timecode setting so it no longer incorrectly sends out to clients that weren't enabled.
  - Now sends updated timecode settings when a client is enabled.
- Sequencer now correctly clears UMG widget cache.
- Docs link URL for the Verse Stand-Up template now points to the correct location on the EDC.
- Fixed an issue where actors placed from Fab were not being synced by Live Edit.
- Fixed polygroup colors that were not rendering due to incorrect material in subdivide, tri select, and materials tools
- Fixed a crash that could occur when trying to convert a cooked-for-editor geometry collection.

## Verse

**Fixes:**

- Fixed an issue where the `IsOnTeam[agent]` API would always fail in the Team Settings & Inventory device.
- Fixed an issue where an incompatible project snapshot combined with invalid Verse code in a user project was causing the editor session to be invalidated until a restart.
- Fixed an issue publishing an experience with persistent data when overloaded constructor functions were defined before the related type definition.
- The Content Service Portal now correctly shows Verse runtime errors for all projects, both published (live) experiences and in-editor sessions.

## 29.10 What's New

See the [Fortnite Ecosystem Patch Notes - v29.10 Update](https://create.fortnite.com/news/fortnite-ecosystem-v29-10) for the latest news and release highlights.

## Creative

**Fixes:**

- The Half Damage Rail and Full Damage Rail traps are now visible in Creative.

### Devices

**Fixes:**

- Fixed an issue where the Class Selector device displayed an incorrect texture during a player's class change.
- Fixed an issue with the VFX Spawner device where the Sky Lanterns effect did not use custom colors.

## Creative and UEFN

**New:**

- Exposed the **Bone Influence Limit** property in the Skeletal Mesh editor.

**Fixes:**

- Fixed a few different crashes related to replicated level sequence actors.
- Users can now report their own private islands.
- The Matchmaking Portal now always shows the island code.

### Devices

**New:**

- The **Patchwork Control Bus** option is now available in the Audio Mixer device in Creative and can now also be accessed in UEFN.
- The Input Trigger device now allows for blocking base input. Standard Input actions were added, as well as options for creators to block other input assigned to the same key.
- Added the **Hide Map Info Panel** device option to the Map Controller device to hide the fullscreen Map Info panel.

**Fixes:**

- Fixed an issue where a melee weapon in the player's inventory would be unintentionally removed after exiting a Changing Booth device.
- Fixed a bug where the Sword In The Stone interaction text would display as "Customize" instead of the correct interaction text for removing the sword from the stone.
- Fixed a key bind conflict issue on the Rocket Racing Vehicle Spawner device where activating turbo would also ping the map on KBM.

## UEFN

**Fixes:**

- Fixed external actors not being considered dirty if their world fails validation.
- Fixed issues that caused inconsistency in pre-upload validation.

### Animation and Cinematics

**Fixes:**

- Fixed LEGO® Minifigures not lowering their arms when sprinting.
- Removed collision on the Cooked Meat item.

### Audio

**New:**

- Added the ability to mark up Sound Wave and Sound Cue assets so that they get muted in Stream Safe mode.

### Devices

**Fixes:**

- Fixed an issue where setting the capture size area on the Map Controller device in Verse didn't also affect the trigger size.
- Fixed an issue with the Rocket Racing Track Spline device where selecting a track spline after having a landscape spline selected causes UEFN to crash.
- Fixed an issue with the Rocket Racing Speed Run Manager device where Speed Run matches would fail to go into overtime.

### Editor

**New:**

- Textures now always use the latest Oodle Texture SDK version in UEFN rather than the sticky version number on the texture asset.
- Optimized editor startup time when the preferences tab is open.
- Added additional config validation when importing or updating solver or face-fitting configs.
- Added support for custom face tracker models trained on different-sized images.

**Fixes:**

- Fixed an issue where actors from Fab were not being synced via LiveEdit.
- Fixed an issue creating an Identity asset from multiple frames via Python API. Also fixed a couple of issues in the Python example code.
- Removed OpenCV dependency from the MetaHumanCore module.
- Fixed the Mesh2MetaHuman config warning for teeth fitting.
- Fixed a rare crash during save.
- Fixed a memory leak when the level editor viewport is set to real-time but it's not visible.
- Fixed an issue where placing a Niagara VFX asset into a Rocket Racing project would cause validation to fail.

### Editor UI

**New:**

- Added the DPad translation and rotation multipliers, which allow tweaking of translation and rotation when in joystick fly mode in the viewport.
- Updated the UEFN Project Browser to auto select the first item when selecting a category.
- Texture thumbnails now display with correct transparency and gamma/srgb modes.
- The depth track in the MetaHuman Performance asset editor is now automatically muted when **Depth Preview** is disabled.

**Fixes:**

- Fixed a crash when opening a Performance or Identity asset.

### Environments and Landscapes

**Fixes:**

- Fixed changing river width/velocity/audio intensity from the Details panel not applying changes.
- Improved robustness of the triangulation method used by the water system.

### Materials

**New:**

- Added a safety code that prevents Material Functions from saving expression collections with nulls in them, causing continuous material invalidations on PostLoad().
- The material translation DDC now gets skipped when a material is not flagged as Persistent.
- Added more debug information if null expressions are detected on `PostLoad()`, displaying the name and type of the missing expression (this requires the function to have been saved with this change before).
- Added a message box on a MaterialFunction save that informs the user if their function is corrupted and needs to be checked or resaved. GUID invalidation when null expressions are detected on `MaterialFunction::PostLoad()` is now deterministic to prevent bloating the DDC with new shadermaps.

**Fixes:**

- Fixed a crash by removing debugging data used to print missing expressions on material function post-load.
- Added a null check to `FHLSLMaterialTranslator::GetMaterialEnvironment()` to avoid crashing when a referenced Parameter Collection fails to load (such as when it no longer exists).

### Modeling

**Fixes:**

- Fixed a bug in the Geometry Tools LODManager that could leave the mesh hidden after deleting the highres mesh. Also made sure the displayed information was correctly updated after the undo function in the tool.
- Fixed an issue where the UV Layout tool could show a preview UV layout wireframe even though the layout preview was disabled.
- Fixed an issue where the Boolean or Merge tool could set incorrect materials when updating an existing mesh.
- Fixed a crash in Tri Edit edge extrude.
- Clamped the bevel distance ranges to avoid weird results for negative, zero, and very large bevel distances.
- Fixed the undo for the AutoLOD tool.
- Fixed an issue where modeling tools would, in a rare case, fail to move a selected edge or vertex.
- Geometry Tools: Fixed the undo function within the tool.
- Fixed an issue that required some tools (edit pivot, bake transform) to create two undo items instead of one in some cases.
- Fixed a crash that could occur in the static mesh editor when interacting with sockets if the socket window was never opened.
- Fixed an ensure in PolyEdit on edge loop selection.
- Fixed a rare crash when smoothing a mesh that had inconsistent triangle orientations.
- Fixed an ensure that could occur in the hole fill tool when processing a mesh with a complicated border.
- Fixed a crash caused by running the Convert tool on read-only cooked assets.

### Immersive Camera Mode Known Issue

We're aware of an issue where players cannot place objects or open the Quick Menu when Immersive Camera mode is enabled on the Editor Camera. We are working on a fix, but in the meantime, you can use this workaround to disable Immersive Camera mode from the Main Creative Menu:

1. Open the Main Creative Menu.
2. Navigate to the Quick Menu Tab.
3. Set the Editor Camera setting to **External**.

### NPC Spawner Device Known Issue

We're aware of an issue with the NPC Spawner failing to spawn an NPC when using the default NPC character definition. We are working on a fix, but in the meantime, you can use this workaround:

- Select the affected NPC Spawner device.
- Click the NPC Character Definition option.
- In the pop-up window, choose Creative New Asset > NPC Character Definition.
- Configure the definition data with Character Type and associated Modifiers (see this [documentation](/documentation/en-us/fortnite/npc-character-definitions-in-unreal-editor-for-fortnite) for details).
  The NPC Spawner device should now work properly and spawn the NPCs.

## Unreal Revision Control

**New:**

- Added an in-editor interface in the Outliner context menu to enable project admins to unlock assets locked by a collaborator to allow others to work on it.

## Verse

**Fixes:**

- Fixed an issue where if the snapshot project was created with different code in external packages, and if a user UEFN project contained invalid Verse code during compilation that during rollback to the old snapshot project, the linker would fail to find symbols and release/obliterate generated types for an external package that was in cooked content, thus invalidating the rest of the editor session until a restart.
- Fixed issue where UEFN became unresponsive after removing or adding a file in VerseExplorer

### Language

**Fixes:**

- Fixed a bug that caused classes that indirectly inherited from a `<unique>` interface to be considered incomparable.
- Fixed the rollback for the equals operators `+=`, `-=`. `/=`, and `*=` . Previously, there was a difference in how `a+= b` and `a = a+b` respectively behaved during rollback for array, string, and float operations for each of these operators. That difference has now been fixed, and the code will restore during rollback in all cases. Code that depends on this behavior must be changed. There is, unfortunately, no generic way to do so.

## 29.00 What's New

See the [Fortnite Ecosystem V29.00](https://create.fortnite.com/news/fortnite-ecosystem-v29-00) update for the latest news and release highlights.

## Creative

**Fixes**:

- All healing items have been renamed as **Legacy**.
- The Launch Pad device no longer appears in the **Epic** category in the Creative inventory.
- Placement of ledges on Player Built Walls (PBWs) was improved, resulting in a better user experience for players who jump between ledges.

### Devices

**Fixes**:

- Players hiding in the Bush item can now enter a Hiding Prop device without the bush giving away their position.
- The Campfire device now correctly starts already lit if the **Start Lit** option is enabled.
- Moddable weapons display correctly when available from devices like Item Spawners while in Create mode.

## Creative and UEFN

**Fixes**:

- Spectators now see the proper health and shield values when following a player.
- The following Camera device transition issues were addressed:

  - The blend functions for camera devices only use the camera with the highest priority. This results in a smoother transition between camera views.
  - Camera devices now use the time set for the **Transition Out** option when blending to a default Fortnite camera.

### Devices

**Fixes**:

- Fixed an issue where maps could get disallowed when saved through the **File** > **Save As** workflow in the editor.
- The Teleporter device now correctly teleports NPC Characters.
- The Matchmaking Portal device no longer shows an error message for an island code containing any combination of numbers.

## UEFN

**Fixes**:

- The gameplay Targeting System has a new option to **Sort By Distance**, resulting in more accurate distance calculation based on the nearest collision surface instead of actor location.
- World validation now runs consistently when UEFN performs an Incremental Validation check.
- The beacon is always visible in UEFN, regardless of team and class settings.

### UEFN Devices

**New**:

- There's new context menu options for spline-based devices in UEFN:

  - **StraightenToNext** - Auto sets the tangent of a spline point so that it points straight to the next point.
  - **StraightenToPrevious** - Auto sets the tangent of a spline point so that it points straight to the previous point.
  - **ToggleClosedLoop** - Quickly toggles the Closed Loop property of the spline.
  - **ToggleSnapTangentAdjustments** - Toggles behavior that would reset tangents after a snap or align action.

### Animation and Cinematics

**Fixes:**

- The following Camera improvements result in a better user experience:

  - The cut track camera no longer locks.
  - Gameplay cameras now restore correctly even if the previous view target is no longer valid.
- The following Sequencer improvements result in a better user experience:

  - Sets the last known sequence position to fix issues with non-zero start frame sequences.
  - Additional checks were added for disable and disallow creation of the Level Sequence Director.
  - The sequence observer can be queried to solve networking bugs where sequences didn't start playing because observer information (Instigator Only or Instigator Team) wasn't replicated to the client in time.
  - Sequences run using the correct update after the sequence’s creation.
  - Looping sub-sections now display properly.
  - Looping sub-sections can now be split or trimmed properly.
  - The audio clock source dialog suppresses when **No** is selected to dismiss the dialog.
  - Play rate speeds have been correctly adjusted for non-1 play-rates.

### Modeling Tools

**New:**

- There's a new **At Origin** option for the desired Target Position in the Create tool.
- Visualization of level sets when using collision tools was improved.
- A new **Local Frame Mode** toggle in the Mesh Element Selection Toolbar Settings lets you edit with the gizmo frame based on whether you selected specific geometry or the entire object.
- The **Skeletal Mesh Modeling** toolkit has been enabled in the skeletal mesh editor.
- The following are options are now available for the Attributes tool:

  - New options for convex decomposition methods in the Mesh to Collision tool.
  - New shape protection options for convex decomposition in the Mesh to Collision tool.
  - New collision shape merging options in the Mesh to Collision tool.
  - New solid collision visualization support for the Mesh to Collision and Inspect Collision modeling tools.
  - The Physics Inspector tool now automatically updates its preview when collisions are updated externally.

**Fixes:**

- The following are general Modeling Mode improvements resulting in a better user experience:

  - Modeling tools work when Undo is pressed during a click-and-drag interaction.
  - Improved visualization of Convex hulls for scaled actors.
  - Build Scale in modeling tools now perform as expected.
  - Interacting with sockets in the static mesh editor no longer results in a crash.
  - Modeling tools no longer need a separate transaction for collision updates for target meshes with convex collision.
  - The cursor no longer moves to the origin when modifier keys are pressed.
  - The Static Mesh Editor simple collision visualization and editing UI now support level sets.
  - Meshes with non-uniform build scale now have proper tangents.
  - Modeling tools are more robust when creating blocking volumes. The cone and arrow primitives now work as blocking volumes.
  - Improved consistency of collision shape editing in modeling tools for meshes that are scaled and rotated.
- The following Transform tool improvement results in a better user experience:

  - Extruding an edge in the TriEdit modeling tool no longer results in a crash.
- The following Deform tool improvement results in a better user experience:

  - The Lattice tool's gizmo now correctly applies scale.
- The following Model tool improvements result in a better user experience:

  - Clamped PolyEdit tool's bevel distance now has a variety of bevel distances from negative units, equal units, zero units, to very large untis.
  - The PolyEdit tool features a new gizmo placement for looping edges.
  - The name of PolyEdit tool insert edge loop is now correctly named **Complete**.
  - PolyEdit's Bevel operation no longer results in a crash.
  - The Mirror tool no longer ignores the scale transformation when writing to new objects.
  - The Union, Boolean, and Voxel modeling tools now preserve input mesh simple collision shapes in their output.
  - The hotkey for **Lock Rotation** was changed from **Q** to **Ctrl+R** in Polygroup Edit.
  - The Generate PolyGroups tool now allows the PolyGroup preview to display in the viewport.
  - The Boolean and Merge tools now set component materials when updating an existing mesh.
- The following Mesh tool improvements result in a better user experience:

  - The Mesh to Collection tool features improved robustness of sphere and capsule auto-detection.
  - The Mesh Element Selection gizmo now appears at the selected geometry's pivot, rather than the object's pivot when the Local Frame Mode is set to **From Object**.
- The following Bake tool improvement results in a better user experience:

  - Vertex colors no longer affect the selection visualization in the modeling tools.
- The following UVs tool improvements result in a better user experience:

  - AutoUV now handles meshes that don’t have colliding components properly.
  - The UV Layout tool preview wireframe now disables for the overall preview.
- The following Attributes tool improvements result in a better user experience:

  - Updating convex collision and mesh geometry in the same transaction no longer results in a crash.
  - The Mesh to Collision tool sphere auto-detection is more reliable for low-poly meshes.
  - The Collision to Mesh tool no longer transforms actors when Output Separate Meshes is enabled.
  - The Simple Collision Editor tool is now disabled for Volume actors, which auto-generate their simple collision shapes.
  - Simple Collision now supports Undo on dynamic meshes.
  - The Weld Edges setting in Mesh to Collision tool now works as expected.
  - Clean Materials now removes the correct material in the LOD Manager tool.
  - There is now improved visibility of the preview mesh in the Collision to Mesh tool.
  - The viewport updates immediately with the new brush size in the Group Paint tool.
- The following Miscellaneous tool improvement results in a better user experience:

  - Undo works as expected for the AutoLOD tool.

### Editor

**New:**

- New Texture networks are available.
- The editor map has updated features for a better user experience.

  - Menu search fields now show by default in menus with 10 or more items. You can change this threshold using a new setting under **General** > **Appearance** > **User Interface**.
  - The size of the editor user interface was reduced.

**Fixes:**

- TableUpdates now update with the correct information.
- Transform to actors no longer results in a crash.
- The **Push Verse Changes** button in UEFN will now be visible only if the content previously pushed to the server already contained Verse classes.
- You can now paste into the Mobility field of the Details panel.
- The Virtual Keyboard shows up on the first tap of a touch on UMG Editable Text.

## Verse

### Language

**New**:

- Digests now include public type alias definitions, and use type aliases where appropriate.

**Fixes**:

- The body of the parametric class following an explicit return statement in a method no longer returns an unreachable error message with methods in parametric classes and interfaces.

### API

**Fixes**:

- Documentation for the popup\_dialog\_device button now specifies the correct maximum length of 24 characters.

**Known issue:**

- New Verse editable attributes appear in the Verse API digest, but users will be unable to use the API in their projects until a future release.

### Tools

**New**:

- New Verse snippets can be used as autocomplete suggestions in the Verse VSCode extension.

## Creator Portal

**New**:

- There is now a backward compatibility check for Verse Persistable in the publish workflow.
- Creators can now submit their islands for Epic’s Picks.

## Unreal Revision Control

**Fixes:**

- The KeyValue pair and ElementType for a given KeyArgumentType is now accessible.
