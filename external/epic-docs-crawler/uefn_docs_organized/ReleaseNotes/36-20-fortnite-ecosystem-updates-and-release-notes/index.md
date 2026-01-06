# 36.20 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/36-20-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-27T00:36:05.041393

---

The v36.20 update brings new weapons and items like the Unstable Thunderclap DMR, Lightrider’s Surf Cube, and the Unstable Bounce Grenade. Explore Utopia City-themed Prefabs and Galleries, plus a range of other updates and fixes.

## Content Browser and Inventory Updates

Check out all the new devices and items available this release!

### Device Updates and Fixes

**New:**

- **[HUD Controller Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative)**

  - New customizable **PaddingBetweenSlots** setting in UEFN for the Custom Quickbar property.

**Fixes:**

- **[Rift Point Volume Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-rift-point-volume-devices-in-fortnite-creative)**

  - Fixed an issue where a player attacker that gets eliminated in multiple rift point volumes can plant a rift point device anywhere on their next spawn.
- **[Disguise Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-disguise-devices-in-fortnite)**

  - Fixed an issue where the character's head would not render if a disguise was applied with another gadget present in the inventory.
- **[Voting Group and Voting Options Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-voting-group-and-voting-options-devices-in-fortnite)**

  - Fixed a comma typo at the end of the tooltip for the voting option device.
- **[HUD Controller Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative)**

  - Fixed an issue in UEFN where the Custom Quick Menu overlaps the default UI when in Edit Mode.
- **[Carryable Spawner Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-carryable-spawner-devices-in-fortnite)**

  - Fixed an issue where setting the spawn angle in Verse did not apply the value.

### New Weapons

- Unstable Thunderclap DMR

### New Items

- Surf Cube
- Lightrider's Surf Cube
- Unstable Bounce Grenade

### New Prefabs & Galleries

- Utopia City Train Station
- Utopia City Skyrise Towers
- Utopia City Puppuccino Cafe
- Utopia City Orbitz Club
- Utopia City Wall Gallery
- Utopia City Street Gallery
- Utopia City Foundation Gallery
- Utopia City Floor and Stair Gallery
- Utopia City Prop Gallery
- Utopia City Indoor Prop Gallery

## New or Updated Documentation

The [UEFN Viewport Toolbar page](https://dev.epicgames.com/documentation/en-us/fortnite/viewport-toolbar) has all the latest information about the new and improved functionality included in the UEFN toolbar update.

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where players were listed individually on leaderboards on team-based islands.

  - [Forum Report](https://forums.unrealengine.com/t/leaderboard-ui-is-broken-with-36-00/2552508)
- Fixed an issue where Scene Graph Entities were ignored when building NavMesh.

  - [Forum Report](https://forums.unrealengine.com/t/critical-scene-graph-entities-are-completely-ignored-when-building-navmesh/2536725)
- Fixed an issue where props were keeping collision when NoCollision was set.

  - [Forum Report](https://forums.unrealengine.com/t/the-props-without-collisions-dont-work-as-expected/1851178)

## Fortnite Ecosystem Updates and Fixes

**Fixes:**

- Fixed a categorization issue that listed the Typhoon Blade as Epic rarity instead of Mythic rarity in the Creative Inventory.

## Brand Island Updates and Fixes

**New:**

- Fortnite x Squid Game Doll - Control Rig: Bring the iconic CTL doll to life with a control-rigged version (UEFN only).

**Fixes:**

- LEGO® Bloom Tycoon assets now correctly appear under LEGO Content > Prefabs > Bloom Tycoon and LEGO Content > Props > Bloom Tycoon in the Content Drawer.
- Fixed an issue where some assets in the Squid Game galleries could not be interacted with when using the phone tool.
- Adjusted the names of props to reference Squid Game.
- Fixed LOD settings of the quarter full Squid Game Llama Bank.
- Fixed the lighting component on Squid Game Dorm Lights to not display a dot against the mesh.
- Removed minimap and resources UI in the Squid Game Minigame Mastery template.
- Fixed the following string in the Minigame Mastery template: "At least one mesh with a sky material is in the scene but none are rendered in main view."
- Fixed the Ddakji and Flying Stone props to allow the Phone Tool to interact with them after being placed.

## UEFN Updates and Fixes

**New:**

- Static mesh objects that use physics now have additional options for adding sound effects and visual effects.

**Fixes:**

- Fixed an issue where pushing Verse changes resulted in the need to restart the editor to launch a new session or push changes when the editor lost its connection to the server.
- Fixed an issue where the editor UI would not properly reflect when the editor lost its connection to the server.
- Fixed an issue where the Message Log failed to open when the project experienced validation issues.
- The following are improvements to the **Capture Manager**:

  - Fixed an issue resulting in a crash state during thumbnail extraction.
  - Fixed an issue resulting in a crash state when starting the CPS file stream.
  - Fix an issue resulting in a crash state related to BaseIngestLiveLinkDevice.
  - Fixed an issue resulting in a crash state when closing the GetCaptureDevice option.

### Environments and Landscapes

**New:**

- Improved Undo performance on large landscape changes.

### Materials

**Fixes:**

- Fixed a SafeRenameEditorOnlyData() issue that resulted in a crash state in when EditorOnlyCurrent is null.

### Modeling

**Fixes:**

- Fixed an issue resulting in a crash state when deselecting a mesh in Modeling Mode or exiting Modeling Mode.

## Scene Graph

**Fixes:**

- Fixed an issue with light components not being selectable in the viewport after reinstantiation.
- Fixed an issue where entities were ignored when building NavMesh data after restarting a game.
- Fixed an issue where spawning copies of a prefab would not spawn child entities correctly.

## Verse Updates and Fixes

**Fixes:**

- Fixed a crash related to Sleep calls.

## Unreal Revision Control (URC) Updates and Fixes

**New:**

- Check-in speeds should now be faster on projects created in 36.00 and beyond, given some optimizations we’ve made to the new version of Unreal Revision Control.

**Fixes:**

- Fixed an issue in which long delays occurred while saving after adding and subsequently deleting a large prefab.
