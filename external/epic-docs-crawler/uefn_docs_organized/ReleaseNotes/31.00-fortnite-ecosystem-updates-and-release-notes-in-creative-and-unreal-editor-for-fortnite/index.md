# 31.00 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/31.00-fortnite-ecosystem-updates-and-release-notes-in-creative-and-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:36:36.286650

---

The v31.00 update introduces a fresh face to the content browser for the Creative Content inventory, available today to users who opt in for the updated user interface.

Explore a new Song Sync device for Patchwork that helps keep your islands rocking to the beat. The update also brings enhanced options for optimizing Patchwork memory usage in your islands.

LEGO® Islands see a host of new devices available, including the NPC Spawner device, additional weapons, and new futuristic Space galleries.

Finally, creators adding NPC Spawners to the Sequencer in UEFN should make sure they’re aware of new changes to Sequencer, and how it affects the NPC Spawner device.

## Island Moderation Feedback Now Includes Screenshots

The Creator Portal now features screenshots of violations within your island along with moderation decisions. Moderation screenshots can be found in the Public Release tab, with the reason the island failed review. Note that screenshots containing restricted or sensitive imagery will not be shared. This additional context should make it easier for you to diagnose and resolve issues before resubmitting your island to moderation.

## Creative Content Browser Improvements

Creators using Creative can now opt in to an updated version of the Content Browser. The update speeds up and improves creator workflows in Fortnite Creative, helping you create and iterate on content faster.

We now provide direct access to categories and filters on both gamepad and mouse & keyboard platforms, making it easier and faster to switch categories and filter.

You also now have the option to hide the Category and Filter panels and access them only when you need them, increasing the number of items shown, and a new filter mode option that makes it easier to narrow down your search results.

You will be able to opt into this new browser via the **"..."** menu, and can begin testing and providing feedback. [Please share your feedback here](https://forums.unrealengine.com/t/creative-content-browser-feedback-thread/1956852).

## New Patchwork Song Sync Device

The Patchwork Song Sync device is now available to help creators synchronize music, visuals, and gameplay in their experiences. Use the Song Sync in conjunction with level sequences, MIDI data, and other Patchwork devices to have them all follow the same timeline. This device should be especially helpful for creators building concerts or other musical gameplay experiences. For more information, check out the [Song Sync device documentation](/documentation/fortnite-creative/using-patchwork-song-sync-devices-in-fortnite-creative).

## New Patchwork Memory Mode Island Setting

A new Patchwork Memory Mode option has been added to Island Settings. Enabling it will reduce the memory usage of Patchwork devices but limit your ability to adjust device controls in-world with the Patchwork Tool. This is intended for creators who want to use Patchwork devices to control their game audio, but don’t plan to make the Patchwork devices accessible for in-game player control. When the option is enabled, the devices will still function as normal, but certain visual effects and interface elements on the devices and cables will be hidden.

In UEFN, you’ll also see that all Patchwork devices have new Screen State options. Setting the Screen State to **Closed** before launching your game will also reduce memory usage for Patchwork devices.

## Update to NPC Spawner in Sequencer

We have updated how the NPC Spawner device works in Sequencer. Going forward, an NPC Spawner device dragged into Sequencer will require a binding lifetime track. This update could impact your existing islands and future creations.

In v31.00, this track will be added automatically when an NPC Spawner device is dragged into Sequencer. However, existing sequences that contain an NPC Spawner will not have this track automatically added, and will fail validation if set on a cinematic sequence device to remind you to add the binding lifetime track. Throughout the v31.00 release, sequences will remain backward-compatible to prevent disruptions.

This backward compatibility will be removed in the v32.00 update. Any sequences using the NPC Spawner without the binding lifetime track could break your island experience. We strongly recommend that you re-publish your island after adding the binding lifetime track to sequences that use the NPC Spawner device during the v31.00 release cycle.

## New Content for LEGO® Islands!

### New Tools

![LEGO tools](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/15eaa278-c225-4d65-827e-c303471eedfb/lego-tools.jpg)

- **Sword**: Have fun swinging around this weapon utilizing the same move set as LEGO Fortnite. This weapon currently does not support Dodge roll, but keep your eyes out for Dodge roll in an upcoming release!
- **Hand Axe**: Donk your enemies with the new Hand Axe!
- **Crossbow**: This Crossbow uses the new Crossbow ammo type. When a player shoots, its bolts will stay stuck where they landed and can be picked up to be reused.

### New Devices for LEGO Islands

- **NPC Spawner**: This device supports a set of LEGO Minifigure characters.
- **Physics Boulder**: Play around with the physics boulder. Currently, the physics boulder and physics tree do not destroy LEGO assets. Keep your eyes out for a future update where that has been resolved.
- **Chair Device**: This device is now compatible for use with Minifigure characters, including the scaling of chair assets in order to match the scale of seated Minifigures.
- **VFX Powerup**: Bring your islands to the next level with the VFX powerup!

  - Developer note: The VFX Powerup is an incredibly powerful device in the hands of creators, and can be used to accomplish some unique effects and behaviors. This is why we have decided to release this powerup despite some issues that we were unable to resolve for its release.

### Known Issues for VFX Powerup:

- **Level Up VFX** option does not appear when triggered. This occurs for both Fortnite and Minifigure characters.
- **Spark Aura VFX** option color changes are not being respected. This occurs for both Fortnite and Minifigure characters.
- **Outline VFX** option does not appear when triggered. This occurs for both Fortnite and Minifigure characters.
- VFX can be seen on the player even when the **Effect Visible To Local Player** option is set to **Not Visible To Local Player**. This occurs for both Fortnite and LEGO islands.
- **Outline VFX** option does not function on Minifigure characters.
- **Glow VFX** option does not function on Minifigure characters.
- Sound effects still play when the **Pick-Up Audio** option is set to **Off** in LEGO islands.
- The **Persist on Elimination** option is not respected for Minifigures in cases where the elimination is not caused by other players.

### LEGO Galleries (Early Access)

**Space galleries**: Add a fun space theme to your island using new prop and building galleries. This set is based around the idea of a spaceship or space station, and can add a futuristic, or sci-fi vibe to your island!

**Early Access notes:**

- These galleries are not releasing with prefabs at this time, but look forward to the companion prefabs in the 31.30 release.
- As these assets are in early access, some details may need to be changed when they fully release in 31.30. While we don’t expect any changes right now, be aware the following elements may be changed or modified for 31.30 full release:

  - Collision
  - Visuals
  - Resources Granted
  - Support Structures

## New Technical Tab in Creator Portal

We’ve released a new **Technical Tab** in the Creator Portal which includes Verse runtime error diagnostics. Visit the new tab from the project [navigation panel](/documentation/en-us/fortnite-creative/project-navigation-in-fortnite-creative), where you can investigate any Verse errors that are impacting your published or private island, as well as project versions in playtesting. This tab is the future one-stop shop for your performance metrics and island troubleshooting. Any Team Owners, Administrators, and Publishers are able to view this new tab.

## Asset-Level Actions in URC Snapshot History

We’ve added asset-level actions to the URC Snapshot History panel to provide contextual information and workflow connections when you need them. With these actions, you have the ability to jump directly from an asset in the list to:

- Focus on it in the viewport.
- Inspect it in the Content Browser.
- Open it in the reference viewer.

## Updates to the URC VS Code Plugin

We've also made improvements to the URC VSCode plugin with this release. You can now use the **File History** panel to navigate and explore the change history of a single file. And you can use the **Snapshot History** panel to view the before-and-after states of a given file.

## Parameterized Materials in Verse

You can now expose parameters for your materials to Verse. When you create a material and add parameters to it, those parameters appear as fields on the material class in the **Assets.digest.verse** file. When you set your material on a mesh, you can then modify the parameters on the material in Verse at runtime. Only scalar, vector4, and texture parameters are currently supported.

## Property validation

Property validation for UEFN is now enabled as a warning. Validation is the process of ensuring the validity of data in many ways.

There is a new fix-up feature for two common UEFN validation issues:

- Illegal Property Overrides, which involve modifying a property that UEFN shouldn’t have access to.
- Illegal Property Values, which involve referencing something that UEFN shouldn’t have access to.

The fix-up feature detects which properties output an invalid state and reverts them to their default value.

Any changes made by the fix-up feature are fully transacted (so they can be undone), and will only affect the in-memory state of your content until you decide to save it.

Additionally, any automatic fix-up will provide a report stating which properties were reverted, why, and what their original value was. This gives you the ability to make an informed decision on whether to keep the automatic fix-up result, or undo it and manually fix things yourself. For more information about property validation, see [Validation and Fix-up Tool](/documentation/uefn/validation-and-fix-up-tool-in-unreal-editor-for-fortnite).

## Side Scroller Controls Device Updates

New device options have been added to the Side Scroller Controls device!

- **Crouch** and **Jump** device options:

  - Disabled - Players cannot jump/crouch.
  - Dedicated - Players use the control already bound to Jump or Crouch.
  - Movement - Players use the control bound to Up for Jump and Down for Crouch.

    - NOTE: Crouch will be a **hold** rather than a **toggle** after 31.10
- Ranged Direction - Determines how the player aims while in side scroller mode:

  - Facing - Uses the direction the player is facing to aim.
  - Cardinal Movement - Players can use the Up/Down/Left/Right controls to aim in those directions.
  - Full Range Movement - Uses the direction the player is moving to aim, so if the player is holding forward and up, they will aim forward and up.
  - Full Range Manual - Players aim using the mouse or right stick, similar to a twin-stick shooter.

## Grind Rail Device Updates

The **Grind Rail** device now has new visual settings. Using the new **Visual Style** device option, creators can swap between the standard Neon City grind rails and a wire version similar to the one that was introduced in Battle Royale Chapter 5. There is also an additional device option to add one of two different types of Wire Decorations to the rail: **Patio Lights** or **Festive Lights** (only available when the Visual Style option is set to **Wire**).

## New Weapons

- Striker Burst Rifle
- Monarch Pistol
- Dual Micro SMGs
- Sovereign Shotgun

## New Prefabs & Galleries

- Restored Reels Pool Building
- Restored Reels Center Building
- Restored Reels Amphitheater
- Restored Reels Wall Gallery
- Restored Reels Roof Gallery
- Restored Reels Floor Gallery
- Restored Reels Amphitheater Gallery
- Restored Reels Prop Gallery

## Community Bug Fixes

The following list of fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed the Sneaky Snowman item and its snowballs not working as intended.

  - [Forum Issue Report](https://forums.unrealengine.com/t/the-sneaky-snowman-consumable-and-its-snowballs-do-not-work-as-intended/1291633)
- Fixed an issue where the Tracker device would ignore a weapon category / headshot-only settings.

  - [Forum Issue Report](https://forums.unrealengine.com/t/tracker-device-options-not-working/1586797)
- Fixed an issue where the Objective device collision could remain off when activated.

  - [Forum Issue Report](https://forums.unrealengine.com/t/objective-device-gallery-shield-collision-bug/1530061)
- Valet SUV class is now exposed to Verse.

  - [Forum Issue Report](https://forums.unrealengine.com/t/suv-class-is-not-export-in-verse/1707417)
- Fixed an issue where multiple SUV and Armored Battle Bus spawners might not all spawn when close to each other.

  - [Forum Issue Report](https://forums.unrealengine.com/t/suv-device-not-working/1706269)
- Fixed parametric methods that were crashing servers in large projects.

  - [Forum Issue Report](https://forums.unrealengine.com/t/parametric-methods-crash-server-in-bigger-projects/1783828)
- Fixed an issue with the @editable\_container attribute.

  - [Forum Issue Report](https://forums.unrealengine.com/t/the-attribute-of-editable-container-is-not-working-at-29-40/1851637)
- Fixed an issue with unmanned vehicles not being affected by Damage Volumes.

  - [Forum Issue Report](https://forums.unrealengine.com/t/affects-unmanned-vehicles-option-does-not-work-in-the-damage-volume-device/1874596)
- Fixed the aiming accuracy with the twin-stick and top-down cameras.

  - [Forum Issue Report](https://forums.unrealengine.com/t/twin-stick-mode-inaccurate-aiming/1882435)
- Fixed an issue with the twin-stick camera and mouse usage when HUD scale is less than 100%.

  - [Forum Issue Report](https://forums.unrealengine.com/t/twin-stick-option-on-mouse-and-keyboard-scale-with-the-hud-size-option-making-some-gameplay-unplayable/1884072)
- UEFN projects can now be in paths that contain directory junctions.

  - [Forum Issue Report](https://forums.unrealengine.com/t/can-t-launch-session-getfilenameondisk-returned-a-non-matching-filename/1893888)
- Fixed an issue with Scene Graph FindComponents not returning all components.

  - [Forum Issue Report](https://forums.unrealengine.com/t/scene-graph-custom-verse-components-can-be-ignored/1902050)
- Fixed Anchored Notes persisting across levels.

  - [Forum Issue Report](https://forums.unrealengine.com/t/the-notes-added-in-version-30-10-are-being-shared-across-different-levels/1904997)
- On mobile platforms, the Chair device now correctly shows a prompt to dismount.

  - [Forum Issue Report](https://forums.unrealengine.com/t/chair-device-gets-a-player-stuck/1702218)
- Fixed an issue where NPCs would not spawn on some meshes.

  - [Forum Issue Report](https://forums.unrealengine.com/t/npcs-do-not-spawn-from-an-npc-spawner-placed-on-a-specific-fortplaysetitemdefinition/1941425)

## Creative Updates and Fixes

**Fixes:**

- Fixed an issue where scrubbing forward or backward in a replay could make applied weapon mods disappear.
- Removed the "Place a Building/Gallery in an instant" generic description text for galleries and prefabs in the Creative Content browser.
- Fixed an issue where the player was able to deal damage during the game countdown in the Creative game mode.

### Devices

**Fixes:**

- Changed the Patchwork Speaker SFX ducking to only be affected by the SFX Ducking device option. The Volume knob no longer affects ducking.
- Fixed an issue where the Fang Spawner did not spawn a vehicle after the player came back to the island from the lobby.
- Fixed an issue where disabling the Healing Cactus device while editing the island then making it hidden would prevent further interaction with the device while editing.
- Fixed a bug where the character item picker didn’t respond to button or touch inputs on the Guard Spawner, Character, Character Controller, and Dance Mannequin devices.

## Creative and UEFN Updates and Fixes

**New:**

- If your project originally had sentries targeting neutral guards, you will need to turn on the new option to target neutrals.
- If you are using the **Play at Location: Registered Players** setting, it should now behave as you would expect instead of playing from all players.

**Fixes:**

- Fixed the collision and physics of snowballs made by destroying a Sneaky Snowman. The snowballs can now be properly picked up, carried, dropped, thrown, and stacked.

### Devices

**New:**

- Added a **Tracked Stat** option to the Attribute Evaluator device to track any mini-game stat rather than just score. Renamed the **Min Player Score** and **Min Team Score** options to **Min Player Stat** and **Min Team Stat** respectively.
- Fixed a navigation issue on the prop **Concert StageBase 03 Celebration**. It can now generate navigation data on top of the prop.
- Added several updates to AI and spawners:

  - New options to better control how the Guard Spawner device selects the path on which to spawn a guard.
  - New function to the Patrol Paths device to send the AI to the next path in the group. Added an option to order paths within their group.
  - Added a function to assign an AI to a path which was previously only available in Verse.

**Fixes:**

- Fixed AI Guards not going into patrol mode after the path they were following is disabled. Added a new option to the Guard Spawner device to control if guards should go back to following the path once it's been enabled.
- Fixed the Sentry device not targeting neutral team guards and untamed wildlife. Both defaults are now set to **Off**.
- Moved the Healing Cactus device into the Environment folder in the Content Browser.
- Moved the Nitro Hoop device into the Traversal folder in the Content Browser.
- Fixed the Tracker Device incorrectly tracking non-players.
- Fixed an issue where the **Offset To Water** option on the Fishing Zone device was not properly affected by an overlapping Water device when editing an island. Now, if a new Water device is placed over an existing Fishing Zone device, the Fishing Zone device will not adjust itself until it is customized or the island is reloaded.
- Fixed a bug on the Damage Volume device so it can apply damage on NPC characters assigned to the affected team.
- Fixed an issue where placing a copied Vehicle Service Station would always show its fuel pump and repair pad regardless of its **Display Fuel Pump** and **Display Repair Pad** device options.
- Fixed the **Play at Location** device option on Patchwork Speakers to behave as documented. When set to Registered Players, that speaker's audio will play from the players who have registered with that speaker, and is attenuated based on the speaker's settings.
- Fixed a bug on the Patchwork Value Setter where the connected device text might not update correctly on all clients when the cable is connected to another device's control.
- Disabled the first-person ADS camera for scoped weapons when using a twin-stick setting for the Third Person Controls device to allow aiming.
- Improved weapon accuracy on Twin Stick mode for the Third Person Controls device.
- Fixed an issue where a user could not place a Nitro Barrel device when they had the Phone tool's Collision setting on Everything.
- Fixed an issue preventing the red hologram mesh from rendering after duplicating a Nitro Barrel device.

## UEFN Updates and Fixes

**New:**

- If you need an invisible wall that does not block projectiles, the Barrier device can be used instead.
- Any existing sequences that have an NPC spawner in a level sequence will need a binding lifetime track added to them, otherwise they will fail validation when attached to a cinematic sequence device.

**Fixes:**

- Removed the health bar from a cinematic in the Speedway Race with Verse Persistence template.
- Fixed projectiles going through volumes using the InvisibleWall collision profile.
- Nintendo Switch now supports correctly lit decals, light functions and particle lights.

### Devices

**Fixes:**

- Fixed a bug on the ItemList option of Guard Spawner. It now only shows supported weapon items when trying to pick assets in UEFN.
- Fixed validation errors that occurred when using the Automated Turret device with non-default static mesh assets.
- Fixed a bug where a newly placed Teleporter device appears invisible in Game View mode.
- Added search tags to the following devices: Animated Mesh, Cinematic Sequence, Day Sequence, Environmental Light Rig.
- Moved the Creator Profile device to the to System folder.
- Fixed a bug where the NPC Spawner could not be selected with the Phone Tool.
- Fixed validation errors that occurred when using the Objective device with the Beacon option set to non-default values.
- Fixed an issue where some traps were not created correctly when converting a Fortnite island to a UEFN project.

### Editor

**New**:

- Added the ability to fix Texture Warnings directly from the Message Log by clicking the "Fix Texture" link below the warning.
- Content Browser tooltips for 2D and cube texture arrays now show array size.
- Added Conversion Functions to set Material Params for Model-View-ViewModel (MVVM).

**Fixes:**

- Fixed an issue where in rare instances, excessive texture warnings could print to the Output Log, slowing down project loading.
- Fixed panning of texture atlas visualizer.
- Fixed an issue where UEFN could crash if multiple instances were open and one instance was logged out and back in.
- Fixed an issue where a warning wasn't displayed when a project was about to be created in folders used by external backup systems such as OneDrive or Dropbox.
- Fixed 1-frame glitch in texture editor when changing Mip level
- The editor now accounts for LOD bias when determining the volume depth slice count in the texture editor.
- Fixed actionable landscape messages:

  - Added a tooltip when the widget is collapsed to help the user understand what it's about without having to expand it.
  - Now showing the number of affected landscape actors to help the user assess how out-of-date the overall landscape is.
- Fixed an issue where the Landscape Flatten eyedropper tool was canceling when clicking on the landscape while keeping the mouse still.

### Modeling

**New:**

- LODManager Tool only modifies the target static mesh during acceptance on tool shutdown.
- Added a Cut Outside option to the polycut tool.
- Various Mesh to Collision tool improvements around convex decomposition:

  - Split out convex decomposition from single convex hulls as a separate shape type rather than hiding the feature under the 'max hulls' count
  - Added a pre-simplify option to make the decomposition compute faster for very large meshes
  - Using an enum rather than bool to select the decomposition algorithm, and only showing options relevant to each algorithm
  - Better defaults for the navigable space protection algorithm
  - The Max Count collision shape option is not enabled by default.
- Added a capsule primitive tool.
- Modeling mode element selections now auto-convert when the user changes the active selection mode.
- Allowed edit tri tool to collapse seam edges.
- The edit pivot tool now uses the mesh element selection, if available, as an initial pivot point.
- Added support for converting a selection when changing between the mesh element and/or topology types in Mesh Element Selection.
- Improved the Add Capsule tool with a cylinder section subdivision parameter, and made the UVs more consistent for varying capsule parameters.
- Added a preview visualization to the split tool, and added options to split by mesh topology, vertex overlap with a distance tolerance, material ID or polygroup. Meshes with selection will not have these options and will continue to split by selection.
- The transform tool now works on more component types.
- Added option to toggle off the cubegrid grid plane visualization.
- Made draw polygon, draw polypath, and draw-and-revolve tools initialize with a reasonable drawing frame instead of starting at the origin. If a geometry element is selected, tools will also align to that (e.g., aligning to the plane of a selected triangle).
- The weld tool can now optionally split bowtie vertices, which can enable welds that otherwise would not be allowed.
- Clarified the Rotation setting name and tool in the Add Primitive tools, and disabled it when it is not applicable.

**Fixes:**

- Fixed gizmo not showing up for modeling mode geometry selection after a selection element type or topology mode change.
- Fixed an issue where the modeling tools would not correctly focus on the active tool mesh in some cases.
- Poly edit bevel tool refuses to start when there are no edges to add bevels to in the current selection, and bevel of polygroup faces succeed when only some of the selection-bordering edges are boundary edges.
- Improved robustness of mesh bevels near bowtie vertices.

### Visual Effects

**New:**

- Added support for addition, removal and stiffness adjustment for dynamic springs.
- Added Gauss Seidel dynamic weak constraints.
- Rewrote Gauss Seidel weak constraints using new data structure.
- Added Mac compile fix for ChaosFlesh.

## Verse Updates and Fixes

### Verse API

**New:**

- HUD Message Device: Added `Hide(Agent:agent)` to allow creators to hide a message for a specific user.
- Automated Turret Device: Added `healthful` and `healable` interfaces to the class, and added the following functions:

  - `GetTarget`
  - `ClearTarget`
  - `SetDamage`
  - `SetActivationRange`
  - `SetTargetRange`
- Class Selector UI Device: Added `ClassChangedEvent(Agent, Int)` subscribable event that returns the agent and class index when a player changes class from the Class Selector UI device.
- Powerup Devices: Added `IsSpawned[]` function that can be used to check whether a powerup is currently spawned.
- Objective Device: Added `SetInvulnerable(Invulnerable:logic)` function to enable or disable invulnerability for the objective. Added `healthful`, `healable`, and `damageable` interfaces to the device class.
- Item Granter: Added `AwardItemIndex` functions.
- Valet SUV class now exposed in Verse.

**Fixes:**

- Fixed the `EliminateCreatures` function not working in UEFN when called after a creature spawned.
- Fixed issue where the Item Granter device did not function with AI agents.
- Fixed unsupported material texture parameters being represented in the Verse asset digest.

### Verse Language

**New:**

- UEFN will now emit a Verse compilation warning whenever it compiles map accesses that will always fail at runtime, e.g.: `map{1 => 2}["not an int"]`.
- The compiler now makes it impossible to define concrete classes with uninitialized members.
- Prevent a crash when Verse code uses both a tuple of types, e.g.: `(t:type, u:type)` and a tuple of parametric type `(:t, :u) where t:type, u:type.`
- The compiler now creates scopes for the code inside `race` / `sync` / `rush` / `spawn`.
  This will cause some code to fail that didn't before.

```verse
race:
 X := F()
 G() # some suspend code I know will lose the race
H(X) # X was possible to access here before, but not anymore.
Copy full snippet
```

If possible, rewrite using the fact that race returns the value of the winning code.

```verse
X := race:
 F()
 G() # Might need to change G to have the correct return type
H(X)
Copy full snippet
```

- The compiler is now better at detecting members without default values in a class. The following code compiled before:

  ```verse
        C := class<concrete>:
  		
           False: false = X:false 
  Copy full snippet
  ```

This is incorrect since `X` has no value, and hence the class cannot be `concrete`, but the compiler failed to detect this.

If a user program fails due to this, then add a default value to members that don't have any (`X` in the example), or make the class non-concrete if this is more suitable for the program.

**Fixes:**

- Fixed exploit of concurrency macros not introducing a scope. Made each branch of a concurrency macro have its own scope.
- Refined the joins of classes with a common base class that has some interface inheritance. The compiler would previously infer a type of `[]any` for array literals containing instances of such classes, but this should allow it to infer that the result is an array of the common base class.
- Fixed a bug that could cause a crash when executing a `suspends` function that overrides archetype fields that have the same name as a local variable elsewhere in the function.

**Deprecated**

- Deprecated the use of the unique specifier on classes that lack the allocates effect, e.g.:

  ```verse
  		
        my_class := class<unique><computes>{...}
  Copy full snippet
  ```

The deprecation will be presented as a warning in Verse version 0, but will become an error in Verse version 1.

### Verse Tools

**Fixes:**

- Fixed a crash issue when a Verse script contained errors found after analysis.
- Updated clipboard operations in WindowsPlatformApplicationMisc to report an error instead of asserting if clipboard ownership is stolen before CloseClipboard is called.

## Known Issues

- Placing the Nitro Barrel is blocked when Collision is set to Everything in the Quick Menu.
- The Verse Commander minigame in the Verse Device Feature example project currently has an issue where the NPC navigation cannot be completed. There is a workaround to teleport the player during the minigame near the boards in order for navigation to be generated around the NPC.
- We are aware of a regression in `31.00` that occurs if you make calls to `GetPlayspace` from within the `block` of a class or a class constructor of a `creative_device` subtype. You may cause a crash when the device runs this code when opening the level, or dragging-and-dropping the creative device into the level. You may also encounter problems when attempting to publish the island, since it will fail the cook process. This will be fixed in a future release of UEFN.
  In the meantime, you can remove any such calls within `block` or class constructor functions as a workaround. You may have to do so before opening your project.
