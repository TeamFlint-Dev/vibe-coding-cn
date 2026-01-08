# 33.00 Fortnite Ecosystem Updates and Release Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/33-00-fortnite-ecosystem-updates-and-release-notes-in-creative-and-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:35:14.279663

---

With v33.00, every published Fortnite island now has its own unique deep link, allowing players to jump directly into Fortnite with the island preloaded in the homebar, ready to play. Share your direct island link on the web, social media, or anywhere links can be shared to connect players with your island instantly.

You'll also find a new suite of **Stat Management** devices to help you create and manage custom statistics for players, teams, or the entire match, and use these to influence and evolve the gameplay on your island.

For creators building LEGO® Islands, the new Assembly device lets you manage the assembly and disassembly of LEGO gallery assets using Verse code, unlocking a host of new build-based gameplay possibilities.

As the Fortnite Ecosystem grows, we're testing new ways to present to you all the amazing added features, content, updates, and fixes in the Ecosystem Updates.

The biggest change we made this release is consolidating all assets into the new **Content Browser and Inventory Updates** section! You'll find information on devices, and added content from Battle Royale, along with smaller updates and bug fixes.

Let us know in the forums or on Discord what you think about this format. Also, feel free to suggest any improvements you'd like to see!

## System Update: UEFN Offline Mode Update

We previously announced that you could continue working on your islands while UEFN was offline. We’ve since identified issues that prevent this from working consistently. As a result, UEFN will need to remain offline during Fortnite downtime for now. We hope to restore the ability to work offline in a future update.

## Reminder: Removal of Legacy Time of Day Manager and Skydome Device

The Season 14 Time of Day Manager (TODM) and Skydome device in Creative are being retired in an upcoming release. Right now, converting an island to the new TODM and Day Sequence device is opt-in. However, when the old TODM and the Skydome device are retired, all existing islands will be converted automatically to the new TODM, and any Skydome devices will be replaced with Day Sequence devices (translation and volume dimensions only). This change affects islands using the Skydome device to create custom lighting. For more details on this change, check out the [forum post](https://forums.unrealengine.com/t/chapter-5-time-of-day-manager-in-fortnite-creative/2100460).

## Deep-Linking Fortnite Islands Now Available on PC and Android

Every published Fortnite island now has its own unique deep link, which sends players instantly into Fortnite with the island preloaded in the homebar, ready to play. Share your direct island link on the web, social media, or anywhere links can be shared to connect players with your island instantly. This feature is currently available for players on PC and Android, with iOS support coming soon.

You can easily copy your island's **Direct Island Link** from the Creator Portal.

[![From the navigation menu for your island, click Share Link.](https://dev.epicgames.com/community/api/documentation/image/3c0012db-26a8-43b4-9ae6-d09d83fe1d6f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c0012db-26a8-43b4-9ae6-d09d83fe1d6f?resizing_type=fit)

## Ecosystem Wide Server Session Updates

We have adjusted the server shutdown timings across Fortnite Creative, UEFN edit sessions, and all published islands.

Previously, newly spun-up servers (such as from private matches, edit sessions, or non-backfill matchmaking) would last 4 hours before shutting down.

Now, servers react gracefully to their host's shutdown timing, and will have session lengths equal to the Host up time +4 additional hours.

This means that servers you join will now last between 4.5 and 19 hours long, depending on when the server was spun up in comparison to the lifetime of the server's host. This will give you better variability in having an active server that matches your desired working hours, and you won't be forced to requeue for a new server part way through your work.

## Updated Default Creative Hotkeys (Keybinds) in Creative

[![Updated default creative hotkeys](https://dev.epicgames.com/community/api/documentation/image/5646f1df-cb61-48a6-9112-0861dbb98920?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5646f1df-cb61-48a6-9112-0861dbb98920?resizing_type=fit)

The hotkey menus in Create mode have been updated to make it easier for creators to access their favorite features faster! Quick Menu now has a setting to set the default tab when opening the Creative Menu. These options have also been added to Keyboard Controls in Settings for even more customization.

For all the details on these changes, see [Hotkeys and Keybinding Shortcuts](https://dev.epicgames.com/documentation/fortnite-creative/hotkeys-and-keybinding-shortcuts-in-fortnite-creative).

## New Assembly Device for LEGO® Islands

Block out the world and build a new one with the Assembly device. With this new device, LEGO® Island creators can manage the assembly and disassembly of LEGO gallery assets using Verse code, or even empower players to do so through switches, triggers, and more.

No more stepping on Lego bricks! You can watch your building pieces neatly fall into place as you build your creations. Check out the [Assembly Device documentation](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-lego-assembly-devices-in-fortnite-creative) for more details. We can’t wait to see your creations!

## New Scene Graph Components and Updates

This release features several significant updates to components and the overall system ahead of the upcoming Beta release.

Scene Graph is an experimental feature, so check out the [documentation](https://dev.epicgames.com/documentation/en-us/uefn/scene-graph-in-unreal-editor-for-fortnite) for more details, and for the list of [known issues.](https://dev.epicgames.com/documentation/en-us/uefn/scene-graph-in-unreal-editor-for-fortnite#known-issues) We want to hear [your feedback on this feature in the forums](https://forums.unrealengine.com/t/scene-graph-feedback-thread/1901696/https://forums.unrealengine.com/t/scene-graph-feedback-thread/1901696/)!

### New Component Type, Asset-Generated Components

We added several new components and introduced a new way to work with assets in components called the **asset-generated component**. An asset-generated component is a component class that is automatically created based on preexisting content in your project, such as a mesh, sound, or particle system asset. These assets may also expose properties that you can modify on the generated component.

[![An example of a mesh_component in a prefab.](https://dev.epicgames.com/community/api/documentation/image/1d860675-2ccb-4ad3-9006-2fe8d52d186c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d860675-2ccb-4ad3-9006-2fe8d52d186c?resizing_type=fit)

*The stairs and the floor are individual entities, each using the asset-generated mesh\_component. The light on the stairs is a prefab that uses two asset-generated components — the mesh\_component and the capsule\_light\_component.*

For more details about components changes and updates, check out the 33.00-Fortnite-Ecosystem Updates and Release Notes below. Also, check out the new documentation in [Components](https://dev.epicgames.com/documentation/en-us/uefn/components-in-unreal-editor-for-fortnite).

### Deprecated the Collision Component

We've also deprecated the **collision\_component** and added the properties **Collidable** and **Queryable** to the **mesh\_component**. You can now handle collisions using the events **EntityEnteredEvent** and **EntityExitedEvent**, which occur whenever entities overlap and no longer overlap. Another difference with the mesh\_component is that you can also now change materials on them at runtime.

## Removed Scene Graph Prefab Feature Example from UEFN

Because of the significant changes to Scene Graph in this release, we removed **Prefab** from the list of Feature Example templates in UEFN. We plan to update the template and make it available again in an upcoming release. The documentation associated with the Prefab template was also taken offline and will be updated alongside the template project.

## New Stat Creator, Stat Counter, and Stat Powerup Devices

The new suite of stat management devices helps you create custom statistics (stats), as well as manipulate and track statistics for players, teams, or the entire match.

- **Stat Creator**: This device allows you to create a statistic for a player, team, or match. This can be displayed on the HUD or used for Scoreboard End / Win conditions. Can also be used to create levels for a stat, to allow you to create RPG-style systems. For more information, check out the [Stat Creator documentation](https://dev.epicgames.com/documentation/fortnite-creative/using-stat-creator-devices-in-fortnite-creative).
- **Stat Counter**: This can track the current stat value for a player or group of players and fire events when the value changes or reaches predetermined thresholds. You can apply this to either custom stats or the existing game stats (Score, Eliminations, Assists, etc). For more information, check out the [Stat Counter documentation](https://dev.epicgames.com/documentation/fortnite-creative/using-stat-counter-devices-in-fortnite-creative).
- **Stat Powerup**: This pickup can increase or decrease the value of a specific stat instantly, or repeatedly over time. This can apply to either custom stats or the existing game stats (Score, Eliminations, Assists, etc). For more information, check out the [Stat Powerup documentation](https://dev.epicgames.com/documentation/fortnite-creative/using-stat-powerup-devices-in-fortnite-creative).

## New Vehicle Mod Box Spawner

The Vehicle Mod Boxes from Battle Royale Ch5S3 are now available in Creative. Creators can quickly place the default randomizing mod box. Additionally, controls exist to customize the timing, types, and randomization. Creators using Verse can intercept granting the mod to trigger custom effects, and increased control over applying vehicle mods.

The following vehicles work with all available mods:

- Big Rig
- Fang
- Nitro Drifter
- Pickup Truck
- Sedan
- Sports Car
- SUV

The following vehicles work with most mods except:

- Armored Battle Bus, without the Bulletproof Tires
- Taxi, without the Rooftop mods
- War Bus, without the Bulletproof Tires

All other vehicles currently only work with the Repair Box.

## Live Edit Only Syncs "Edit Events" by Default

Starting this release, when you make changes in Live Edit mode, UEFN only syncs "edit events" by default. Edit events are significant changes, like adding or destroying assets from the Phone Tool (including buildings), editing user options on devices, or manipulating connections via the Patchwork tool. This means that assets destroyed with weapons or the pickaxe are not also deleted in the UEFN editor.

If you want to keep the previous behavior where all destruction in Live Edit results in deleting the asset from the project, you can change the default option with the **Live Edit: Non-Edit Destruction** setting.

## MetaSounds are now available in UEFN

MetaSounds presets are now available in UEFN! The presets inherit from SoundBase and are playable with Audio devices so you can play them with your existing UEFN content. By adding the MSS PlayRandom Loop and MSS PlayRandom Oneshot sounds, you can randomize the volume and pitch of a sound and either play it on a loop or in a specified timeframe.

While MetaSounds are currently read-only, this is a first step in the process of fully exposing MetaSound creation and use in the context of UEFN. In the future, with Verse and Scene Graph, and with full MetaSound exposure, you will be able to do much more powerful things with MetaSounds! To learn more about MetaSounds in UE, check out our [general UE documentation](https://dev.epicgames.com/documentation/en-us/unreal-engine/metasounds-in-unreal-engine) to see what power will be available in the future to UEFN.

## Documentation Updates

### New Custom UI Documentation

As part of an ongoing effort to bring you the latest information on UMG in UEFN, the [In-Game User Interfaces](https://dev.epicgames.com/documentation/en-us/fortnite/ingame-user-interfaces-in-unreal-editor-for-fortnite) section of the UEFN documentation has been updated and reorganized to feature more tutorials and in-depth information about using new and old features of UMG in UEFN:

- [Setting Material Parameters in UMG](https://dev.epicgames.com/documentation/en-us/uefn/conversion-function-setting-material-parameters-in-umg-in-unreal-editor-for-fortnite)
- [Animating UI](https://dev.epicgames.com/documentation/en-us/uefn/aninmating-ui-in-unreal-editor-for-fortnite)
- [Making a Custom HUD](https://dev.epicgames.com/documentation/en-us/uefn/making-a-custom-hud-in-unreal-editor-for-fortnite)
- [Conversion Function: IntToText and IntToDouble](https://dev.epicgames.com/documentation/en-us/uefn/conversion-functions-to-text-int-and-to-text-double-in-unreal-editor-for-fortnite)
- [Conversion Function: Showing Textures from a Viewmodel](https://dev.epicgames.com/documentation/en-us/uefn/conversion-functions-showing-textures-from-a-viewmodel)

We're continuing to work on expanding and adding to this section, so keep an eye out for new content in future releases!

### Other New Documentation and Updates

- [Updates to the Spatial Metrics Panel](spatial-profiler-in-unreal-editor-for-fortnite):

  - New settings added to the Hamburger Menu.
  - New Summary View added.
  - New metrics added.
- [New Ascender Device Design Examples](https://dev.epicgames.com/documentation/fortnite-creative/ascender-device-design-examples-in-fortnite-creative): See several ways to use the ascender to speed your players to greater heights!
- Discover everything you need to know about the new **Satisfaction tab** in [**Project Analytics - Satisfaction Tab**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/project-analytics-in-fortnite-creative#satisfactiontab).

## Content Browser and Inventory Updates and Fixes

This section includes new minor updates, quality-of-life improvements, and bug fixes for all Content Browser and Inventory assets.

### Device Updates and Fixes

**New:**

- Orbit Camera and Side Scroller devices are no longer in Beta and are now considered fully released.
- Added several updates to the TMNT Character Spawner:

  - Added new device option: **Control Foot Elite Loadout**.
  - Created a new Katana weapon for use by Foot Elite.
  - Added a new device option to control the Foot Elite soldier loadout: **Foot Elite Weapon Type**. Values are:

    - Sword (Default)
    - Katana (New katana weapon)
    - Random (Randomly select one of the supported weapons)
- Skilled Interaction Device Verse API support added. You can now bind events that trigger when either Perfect, Good, or Bad input has been triggered on the device. You can also set events for when an interaction has been started, succeeded, failed or canceled.
- The Patchwork Drum Player device has been updated so that you can assign any available drum sample to any Drum Player slot. The user options have also been reconfigured to make them easier to navigate.
- The Patchwork Song Sync device now allows you to select tracks from a synced MIDI file by name instead of by number.
- Added a **Clear Save Data for Player When Receiving From** option to Item Granter device.
- Added options to the Creative Changing Booth device to remove players and disable the changing booth.
- Added new device options to the Map Controller device:

  - **Minimap Shape Override**: forces circular vs square minimaps.
  - **Minimap Opacity Toggle**: the minimap draws slightly transparent.
- **Demonic Grunt Light** and **Demonic Grunt Dark** have been added as available cosmetics for NPCs.
- Added new Boost options to the Sportbike Spawner.
- Added **Allow Weapon Knockback** option to the Creature Manager device.
- Updated the Prop Manipulation device by adding resources nodes.
- Added several Elimination Manager device updates:

  - Revised Team and Class settings.
  - Random Drop Updates.
  - Enemy Type Option.
  - Elimination Penalties.
- Made several updates to the Item Remover device to fix in-game visibility based on feedback.

  - Removed the **None** option from **Affected Items**.
  - Changed the default for 'Affected Items' from 'All' to 'Items in Device'.
  - Changed the default for 'Amount to Remove' from '100%' to 'Number in Device'. These two option changes mean that it won't default to wiping out your entire inventory. Instead, they have the same default behavior as the Item Granter and a lot of our other devices, acting on the items placed within.
  - Also set the device to be hidden during gameplay, which was intended (same as the item granter, no option, there's no reason for this to ever show).
- Added the new Elemental Chest device to the Chests & Ammo Gallery.

**Fixes:**

- Fixed an issue where Nitro Splash no longer affected vehicles.
- Fixed an issue with players were unable to Shakedown other players, as configured using the Down But Not Out device.
- Fixed a bug with the Patchwork Omega Synth device where on-screen knobs might not update after changing the option values in the Customize menu.
- Fixed a bug with the Patchwork Step Modulator device where repeated connections to a carousel would have the values on the modulator round down toward 0.
- Fixed an issue with the Capture Item Spawner where players were able to switch out of the Capture The Flag-equipped item using the Quick Weapon feature.
- Fixed several issues for the Creature Spawner device:

  - Fixed the GetSpawnLit API so it returns proper SpawnLimit defined in the Device option.
  - Fixed an issue with the GetSpawnLimit by replacing the legacy integer to the proper spawn limit config from the device (1, 2, 3, 4, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100).

### LEGO® Assembly Device Known Issues

- The Assembly Device is using the incorrect icon. It currently uses the Prop Mover device icon.
- It is currently harder than intended to hide the Hologram previews for the Assembly device. In 33.10, we have a fix planned that will add new options to set the hologram to be Hidden in-game when the actor it is holograming is also hidden in-game.

### Items

- Void Oni Mask
- Decoy Grenade

### Prefabs and Galleries

- The LEGO® Toy Factory Outdoor Prop Gallery includes an additional log pile, gnome, and red fish.
- Added the new Ambient Light Gallery with customizable lights.

### Weapons

**New:**

- Typhoon Blade
- Oni Shotgun
- Sentinel Pump Shotgun
- Twinfire Auto Shotgun
- Fury Assault Rifle
- Holo Twister Assault Rifle
- Veiled Precision SMG
- Surgefire SMG
- Fire Oni Mask

**Fixes:**

- All Ch5 modular weapons have had **Modular** appended to their name to indicate their unique functionality. Legacy versions of those weapons have had **Legacy** removed.
- The **Infinite Durability** island setting has been added into Player settings in the Inventory section. This can prevent the Typhoon Blade from losing durability as it is used.
- **No Cooldowns After Swap** has been added to the Island Settings, Class Designer device, and the Team Settings & Inventory device. The setting gives creators control of Double Pump, which disables cooldowns caused by swapping weapons or items during the game.
- The No Cooldowns island setting has been renamed **No Cooldowns After Use** to avoid confusion with the new **No Cooldowns After Swap** island setting.

## Community Bug Fixes

The following list of fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Capturing Insights Snapshots is now off by default in the Editor Performance tool. Some developers have seen this lead to performance degradation. It should be an opt-in.
- Demon gate - fixed issues with a Niagara asset and reduced texture size for better performance.

## Fortnite Ecosystem Updates and Fixes

**New:**

- New player movements from Battle Royale CH6S1 are also available for you to use on your own islands. You can see each of the movement types and adjust the options in the Island Settings.

  - Fall Damage Type
  - Allow Boosted Jump
  - Allow Roll Landing
  - Allow Wall Kick
  - Allow Wall Scramble
- To give creators finer control, the **Infinite Building Materials** island setting has been split into **Infinite Building Resources**, **Infinite Gold**, and **Infinite World Resources**. Building Resources include: Wood, Stone, and Metal. Infinite World Resources are available under Items in the Create tab.
- Under the **Team** settings, you can now toggle the **Quintet** option to allow up to five players, either fill or no fill.

**Fixes:**

- Fixed an issue where sometimes multiple objects of the same type would highlight when hovering with the phone tool.
- Fixed a case where players on LEGO® islands could dodge-roll in place during pre-game countdown.
- Fixed an issue with the **Disable Player Collision** island setting that allowed players to move through NPCs (Guards, Wildlife, Creatures, etc.). It should now only disable Player-Player collision, as intended.
- For Creatures: Only grant shields when not in DBNO. Add a DBNO state check to only allow shields to be granted when eliminating Creatures if the instigating player is not in DBNO.
- Fixed an issue where the Elimination Manager item removal penalty did not apply.

## UEFN Updates and Fixes

**New:**

- Backward compatibility for NPC Spawners bound in sequencer without a binding lifetime track has been removed. The requirement for it was added in 31.00. Without this track, NPCs bound by Sequencer will no longer pause behaviors while a sequence is playing. To fix this issue, ensure your bindings to an NPC Spawner have a binding lifetime track, as failure to do this will cause a validation failure.
- Added the ability to set a Custom Widget in the Timer device. To use this functionality, just override the **Custom Widget** option on a Timer Device with your own **User Widget**. Add a Timer View Model to your widget in order to bind to the Timer device's properties.
- The Message Feed device Message field now supports localization.
- Added an editor preference to disable cell snapping while transforming a Fortnite building piece.
- Widget switcher is now available to use in UEFN. Its ActiveWidgetIndex property can be used in MVVM bindings.
- Assets that are not compatible with Modeling Mode no longer allow you to access modeling tools when editing that asset. Modeling tools now cannot be started for engine assets that the tools cannot edit.
- The collision inspector tool now has a **Show Target** option to toggle visibility of the target mesh(es).
- Users can now override Wireframe Material of Dynamic Mesh.
- Mesh element selection in Modeling mode is now enabled by default.
- Added alpha support for vertex color bakes in the BakeTexture tool.
- Appended a MetaSound instance unique ID to the graph name for Print Log MetaSound nodes.

**Fixes:**

- Fixed the issue where if you rename a UEFN project, Verse hot-reload no longer works.
- Fixed a bug in HLSLMaterialTranslator that caused some materials not to translate properly.
- Fixed various crashes caused by deleting expressions inside Material Functions as well performing undo/redo operations after deletion.
- Fixed frequent crashes when performing delete, undo, and redo operations on Material Expressions, especially when these operations were applied to Function Inputs while a material using the Function was open in the editor.
- Addressed a bug which did not preserve Mesh Element Selection after the user entered the Path Extrude or Extrude Polygon tool and canceled it or did not complete the operation.
- Fixed a crash that could occur in the convex decomposition mesh to collision algorithm for some inputs.
- Fixed an issue where focusing the viewport when using Sculpt tools could focus on world origin.
- Fixed an issue where switching from one conversion function to another in a view binding would not update the type of the input values.

## Editor

**New:**

- Added support for gameplay tag query columns with chooser tables.
- Added the No Primary Result chooser type. This creates a smoother user experience for writing output values (especially integral ones), and does not return an asset or class.
- Validate Project has been added to the Launch Session menu to preview validation without requiring an upload.
- Fixed an issue in the Project Browser where the **Browse** button wasn't available if a user had no projects in **My Projects**.
- Updated the Documentation Help menu button to open the UEFN editor documentation.

**Fixes:**

- Fixed auto-save failing to update the state of source controlled files when using an uncontrolled changelist.
- Fixed an issue so that you can correctly convert a deletion to a checkout when restoring (such as with undo) a deleted actor in an interactive save.
- Fixed users getting logged out while running a localization export.
- Fixed the **Save All** and **Choose Files to Save File** menu buttons not showing up in some situations.
- Fixed which menus show when right-clicking assets in the Content Browser that are not part of the project.
- Fixed the blueprint component tree losing its selection when editing a child's properties.
- Fixed an issue by hiding the Teleport menu in the scene outliner since the teleport location is not valid in this context.
- Fixed overlapping log lines in the texture editor.

## Scene Graph

**New:**

- We've refactored the **transform\_component** in how to set and get transform values:

  - The component now has the Verse methods `SetGlobalTransform` and `SetLocalTransform`
  - You can now also call `GetGlobalTransform` and `SetGlobalTransform` as well as `GetLocalTransform` and `SetLocalTransform` directly on an entity without having to get a reference to its transform\_component first.
- We deprecated the **parent\_constrant\_component**. By default, child entities are now constrained to the parent entity.
- We refactored the **light\_components** into the following types. Note that capsule is a direct replacement for point, and a sphere is a capsule without length:

  - **directional\_light\_component**
  - **rect\_light\_component**
  - **capsule\_light\_component**
  - **sphere\_light\_component**
  - **spot\_light\_component**
- We have temporarily removed the **text\_display\_component** in this release.
- We added **keyframed\_movement\_component** to handle animating entities efficiently.
- Scene Events were added to be able to Send and Receive events on Entities:

  - SendDirect sends to only that entity and returns true if the event was consumed
  - SendUp sends a Scene Event to this entity and its ancestors. Consuming this event will halt propagation to the next ancestor. Returns true if the event was consumed.
  - SendDown sends a Scene Event to this entity and its descendants. Consuming this event will halt propagation down that subtree. Returns true if the event was consumed.
- The `Dispose` function was removed.
- **TOptional Details** customization should handle abstract base classes and interfaces.
- Updates the UI for setting an optional value in the details panel to use a dropdown menu for abstract classes and interfaces. This allows picking a instantiable sub-type of the abstract/interface to set the optional to which was not possible before with the 'Set to Value' button.
- Removed old API for spatial queries.
- Renamed `Find` *and `FindParent`* queries to `FindDescendant` *and `FindAncestor`*
- Changed `GetSimulationEntity` behavior when called on the simulation entity itself, previously nothing was returned when calling `GetSimulationEntity` on the simulation entity whereas now the simulation entity itself will be returned.
- Added the `final_super` specifier to various Scene Graph components.
- Circular dependencies when picking entities are no longer allowed.
- Removed collision\_component. Use mesh\_component instead for collision.

**Fixes:**

- Fixed issue with querying for base component type.
- Fix for crash when calling GetComponent[component] on an entity.
- Only adds uninitialized alerts to editor entities, not PIE entities.

## Verse Updates and Fixes

**New:**

- Added a `ToDiagnostic(:any):diagnostic` function to `/Verse.org/Verse` that allows printing any Verse value as it would appear in a debugger. The `diagnostic` values are opaque to Verse code, but can be printed using `(log:)Print` or the global `Print` function.
- Updated doc strings for `FindCreativeObjectsWithTag` to clarify when an empty result can be expected.
- Added the function `FindCreativeObjectsWithTag` for `npc_behavior`.

**Fixes:**

- Added missing normalization in `ApplyWorldRotation` for Verse rotations.
- Improved the speed at which UI driven from Verse updates on clients.
