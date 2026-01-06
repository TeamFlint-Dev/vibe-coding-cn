# 38.00 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/38-00-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-26T23:14:43.213529

---

v38.00 is here and adds Verse Fields in UMG, making it possible to build dynamic UI Widgets powered by Verse. This means that you can now use Verse to update UI data, materials, animations, and widget properties, giving you more flexibility when building custom game UIs.

This release also:

- Integrates the Epic Developer Assistant directly into the UEFN Editor
- Includes a new UEFN feature example showcasing best practices for Tycoon-style games using Scene Graph
- Adds new Canyon Crossing Prefabs and Galleries

## Updated Engagement Payout Formula with User Acquisition Rewards

We’re now using the updated engagement payout formula, [announced in September](https://www.fortnite.com/news/fortnite-developers-will-soon-be-able-to-sell-in-game-items), to calculate your payouts. The updated formula introduces User Acquisition Rewards for developers bringing in new players and reengaging lapsed players in Fortnite. This change will be reflected in your monthly payouts, beginning with the November 2025 payout that will be paid starting December 30, 2025. Learn more [here](https://fn.gg/nov-1-engagement-payout-update).

## Create Dynamic UI: Verse Fields Now Available in UMG

Create UI widgets with Verse that can be updated dynamically using the new Verse fields in UMG. Developers can now dynamically drive UI data, materials, animations, and Widget properties using Verse code, unlocking new UI capabilities. Open the Variables window in the UMG Designer to get started.

You can add fields of various types, including logic , int, float, message, material and texture to a User Widget in the UMG Designer. These fields can be bound to widget properties using View Bindings. Fields are reflected in the Verse asset digest for the User Widget, allowing you to reference these Fields in Verse, and pass Verse data into a User Widget! This makes it possible to drive the content of a User Widget using Verse code.

Learn more with [Using Verse Fields in a UMG User Widget](https://dev.epicgames.com/community/learning/tutorials/07ay/fortnite-using-verse-fields-in-a-umg-user-widget).

Communication is only one direct (Verse to User Widget) for this initial release. Widget events (like Button OnClick) will be coming in a future release.

[![](https://dev.epicgames.com/community/api/documentation/image/d5129c4a-2e4a-4820-89e6-50971035e689?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d5129c4a-2e4a-4820-89e6-50971035e689?resizing_type=fit)

## New UI Materials

New UI materials have been added under the **Fortnite/UI/Materials** folder in UEFN. These materials include a variety of progress bars and texture effects to help with UI prototyping and development.

Radial Meters

Pip Meters

Linear Meters

Texture Meters

Texture Effects

[![](https://dev.epicgames.com/community/api/documentation/image/59533b3e-3716-4273-8f66-9e2c0209dfcb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/59533b3e-3716-4273-8f66-9e2c0209dfcb?resizing_type=fit)

Texture Masks

## New: Sidekicks!

Sidekicks are now available as a cosmetic item in Fortnite! You’ll find new island settings for Sidekicks in the Cosmetic section. These settings let you choose whether a player’s Sidekicks are enabled in your game, decide if they’re visible to everyone or just to their owner, and disable the automated reaction animations on a Sidekick. Sidekicks are disabled by default, and can be enabled in Island Settings.

## New Tycoon Feature Example

A new UEFN feature example showcases best practices for building Tycoon games using Scene Graph and interconnected systems. It’s designed as both a learning resource and as a customizable base for building your own Tycoon experiences.

[![](https://dev.epicgames.com/community/api/documentation/image/ee75d1c0-b55e-4933-b9aa-2b5891cf1f3e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee75d1c0-b55e-4933-b9aa-2b5891cf1f3e?resizing_type=fit)

## Epic Developer Assistant Now Available in Editor with Increased Character Limits!

[![](https://dev.epicgames.com/community/api/documentation/image/cf603c4b-cb5c-4ca1-b3f0-a65b32db43c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf603c4b-cb5c-4ca1-b3f0-a65b32db43c2?resizing_type=fit)

The Epic Developer Assistant is now integrated directly into the UEFN editor. A dedicated slide-out panel enables you to ask questions, generate Verse code, or follow step-by-step guidance — all without leaving the editor — so you can stay focused on the task at hand.

In addition to typing questions, you can access the AI Assistant as easily as you would a tooltip: hover your cursor over an interface element and press **F1** to automatically start a  conversation with the AI assistant about that topic.

We’ve also increased the character limit for prompts from 4,000 to 20,000 characters for developers using the Epic Developer Assistant, both in Editor and [on the web](https://dev.epicgames.com/community/assistant/fortnite), enabling you to include longer snippets of Verse code in your queries.

## Scene Graph Entity Changes

### Entities now present to all players by default

By default entities are presented to all players. Using this functionality you can differ what objects are visible to each player in the map. This only affects the rendering/sounds of objects, so players will still hit these objects if they walk into them and collision/queries are enabled on the object.This functionality currently works for dynamically spawned entities, not on entities placed directly in your level.

- Saving prefabs when launching a session refreshes the editor's world instances.
- Applying overrides on prefabs of prefabs are now functional in a cooked build
- Renamed "Edit Prefab" to "Edit Superclass" when editing a prefab's parent from the prefab editor.
- Pressing "H" now hides entities in the viewport
- Fixed issues with AutoSave/SaveAll in both the prefab editor and edit in place

### Agent and Player are now a subclass of entity

Agents will now be inserted into the simulation under the simulation entity. In this release, you are not able to add or remove components or entities from the agent. This will be unlocked in a future release.

Verse code uploaded prior to this release will continue to compile correctly. For code uploaded at 38.00 and beyond, all overloaded functions that are disambiguated on the parameter types entity and agent will need to be updated. For example:

The following function overloads would now collide:

`SetTarget(Target:entity):void`

`SetTarget(Target:agent):void`

Instead, consider a single function that takes type entity:

```verse
SetTarget(Target:entity):void = 
  if (Agent := agent[Target]):
	# Treat Target as an agent
  Else:
	# Treat Target as a generic entity
```

## Debug Commands

To help you efficiently debug your projects, we are committed to adding more debug commands to the Beta Debug Command menu. We've added:

- **Clear Pickups:** Clear all pickups from the map. This doesn’t include any pickups visible in devices like the Item Granter.

## FBX Import Dialog Changes

The legacy Import Framework for FBX files has been replaced with the **Interchange Framework**. This change comes with a brand new File Import UI, provides a common foundation for all file importers, enables better customization of import processes, and eases extension to support more file formats. There is little to no impact on converting FBX to UEFN assets.

## Hive Swarmer

Battle Royale’s Chapter 6 Hive Swarmer bugs are now available as an option in the Wildlife Spawner device. These bugs will attempt to surround enemies and overwhelm them with numbers. Eliminating them while they're nearby will replenish a small amount of shield. The Aggression Level user option works with them as well, where lower aggression reduces the number of swarmers that can attack a specific target at a time.

[![](https://dev.epicgames.com/community/api/documentation/image/411dc209-a414-471c-84eb-9d44124be35e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/411dc209-a414-471c-84eb-9d44124be35e?resizing_type=fit)

## Content Browser and Inventory Updates

Check out all the new assets and device updates this release!

### New Weapons

- **Suppressed Assault Rifle** (Common, Uncommon)
- **Tactical Shotgun** (Epic, Legendary)
- **Infantry Rifle** (Epic, Legendary)
- **Compact SMG** (Common, Uncommon, Rare, Epic, Legendary, Mythic)

### New Prefabs and Galleries

- **Canyon Crossing Cuddle Buns Street Prefab**
- **Canyon Crossing Madbuns Prefab**
- **Canyon Crossing Floor and Stairs Gallery**
- **Canyon Crossing Wall Gallery**
- **Canyon Crossing Roof Gallery**
- **Canyon Crossing Outdoor Prop Gallery**
- **Canyon Crossing Indoor Prop Gallery**
- **Canyon Crossing Foundation Gallery**

[![](https://dev.epicgames.com/community/api/documentation/image/a3c6cc84-7e19-4f86-9173-9b6f04a6b948?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a3c6cc84-7e19-4f86-9173-9b6f04a6b948?resizing_type=fit)

### Device Updates and Fixes

**New:**

- Added 108 new outfits to the following devices:

  - **Character device**
  - **Character Controller device**
  - **Dance Mannequin device**
  - **Guard Spawner device**
  - **NPC Spawner device**
- **Changing Booth device:** Implemented **On Player Enter / On Player Exit** events. Implemented new device events to a send signal when a player enters or exits the changing booth.
- Added stamina for sprint to the **Player Info View Model**.
- **HUD Controller device:** There's a new option to hide the player actions message (elimination message, and so on).
- **Guard Spawner and NPC Spawner:** Increased Maximum Spawn Count from 20 to 90. Increase of the spawn count has been one of the top community requests. This still respects the maximum spawn limit (90 across a single island).
- **Wildlife Spawner:** Increased Maximum Spawn Count from 20 to 90.
- **Item Granter:** Renamed Item to Grant option to **Item to Equip**.

  - When **Grant** is set to **Current Item**: Item to Equip is grayed and not editable.
  - When **Grant** is set to **All Item**and **Equip Granted Item** option is enabled:  **Item to Equip**  is editable.
- Elimination Manager: Added Air Jelly, Wildwasps, and other Wildlife Spawner types.
- Added two new user options to the **Teleporter device**: Conserve Prop Momentum and Prop Momentum Conservation.
- Added a cooldown property to the **Quickbar Slot ViewModel**:
- Added Cooldown, Duration, and Rarity properties to **Equipped Item ViewModel**.
- Added Total Ammo text in the **Quick Bar Slot View Model** that handles infinity symbols automatically.
- **Changing Booth device:** Implemented the `PlayerEnterEvent / PlayerExitEvent` API.

**Fixes:**

- Fixed an issue where Heisted weapons, Lawless weapons, and modular weapons had incorrect visuals in the **Item Placer device**.
- Fixed granting of phantom ammo when granting Chug Jug and Med Mist items through **Item Granter devices**.
- **Creature Placer & Spawner:** Fixed an issue where Despawn Type does not despawn Creatures when set to Distance to enemy.
- **NPC Spawner:** Fixed an issue where the NPC is not tracked on Elimination Manager.
- Fixed an issue with duplication of arrays of device references in the property editor.
- **Guard Spawner and NPC Spawner:** The Despawn API / event now functions correctly when the devices are disabled.
- **HUD Controller device:** Fixed resources (wood, stone and metal) not hiding when calling HideElements with `creative_hud_identifier_all`.
- **HUD Controller device:** Calling `GetPlayspace().GetHUDController()` no longer resets the visibility of everything previously hidden.
- Fixed an issue where Physics props weren't affected by the Effect Radius option in the Teleporter Device.
- **NPC Spawner:** Added SpawnOnEnabled option to Migrate NPC Spawning Issue. Added a new option, SpawnOnEnabled to help devs manage if they want NPC to be spawned on device enabled or not. Default is set to On to stay consistent with live.

## New and Updated Documentation

New Items and Inventories system component documents have been added to the **[Components](https://dev.epicgames.com/documentation/en-us/fortnite/components-in-unreal-editor-for-fortnite)** section. These documents explain how the different components are used to create a customized **Items and Inventories** system. Each document includes generic code snippets that can be copied into a project and customized.

- [Inventory Component](https://dev.epicgames.com/documentation/en-us/fortnite/inventory-component-in-fortnite)
- [Fort Inventory Component](https://dev.epicgames.com/documentation/en-us/fortnite/fort-inventory-component-in-fortnite)
- [Item Component](https://dev.epicgames.com/documentation/en-us/fortnite/item-component-in-fortnite)
- [Item Icon Component](https://dev.epicgames.com/documentation/en-us/fortnite/item-icon-component-in-fortnite)
- [Item Details Component](https://dev.epicgames.com/documentation/en-us/fortnite/item-details-component-in-fortnite)
- [Fort Item Pickup Component](https://dev.epicgames.com/documentation/en-us/fortnite/fort-item-pickup-component-in-fortnite)

There are also updates to the [Custom Keycard](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-custom-keycard-item-in-fortnite) tutorial, making it much more clear, and easier to follow.

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for bringing these issues to our attention.

- Fixed an issue where the Barrier material was visible to users on the ignore list.

  - [Forum Report](https://forums.unrealengine.com/t/barriers-that-have-a-player-added-to-the-ignore-list-now-start-to-show-the-barrier-material-to-the-player/2546573)
- Fixed an issue where `GetViewRotation()` was not working with Physics Enabled.

  - [Forum Report](https://forums.unrealengine.com/t/fort-chararter-getviewrotation-always-returns-a-constant-value/2505564)
- Fixed an issue with the **Save Point device** equipping the wrong weapon when the saved loadout is reloaded.

  - [Forum Report](https://forums.unrealengine.com/t/save-point-device-equips-incorrect-weapon-when-saved-loadout-is-loaded/2623090)
- Fixed an issue where the player inventory layout was not respecting the HUD controller settings

  - [Forum Report](https://forums.unrealengine.com/t/player-inventory-layout-is-not-respecting-the-hud-controller-settings-only-on-published-island/2468607)
- Fixed an issue where, when a Verse device containing an array of device references is duplicated, the copy does not reference the devices correctly.

  - [Forum Report](https://forums.unrealengine.com/t/bug-when-duplicating-a-verse-device-containing-an-array-of-device-references/2659054)

## Fortnite Ecosystem Updates and Fixes

**New:**

- Set a fixed time of day for Creative Hub.
- The **Infinite Loaded Energy** island setting now lets you infinitely fly with the **Rocket Drill** and ride the **Chainsaw**.
- When detecting corrupt installation files on startup, a dialog now asks for verification through Epic Games Store.

**Fixes:**

- Fixed an issue where the camera would be displaced from players who got eliminated while using the Surf Cube in certain situations.
- Fixed an issue where the high tier Burst Assault Rifles would rotate sideway when fired or reloaded.
- Fixed issue where Precision Air Strike ammo count reads as 0 with Infinite Consumables turned on.
- Fixed several issues with the Phone Tool:

  - Fixed control points appearing on UEFN when duplicating spline meshes with the Phone Tool.
  - Fixed Zipline and Grind Rail devices having inconsistent previews when using the Phone Tool.
  - Fixed props with custom materials losing them when placed with the Phone Tool.
- Fixed an issue where the Backpack Button could not be hidden. Added the missing tags to the backpack mobile action to fix the issue. It can now be hidden with either Show Player Inventory or Show Backpack options set to Off.
- Fixed an issue where the Fine Art Gold Rock Sculpture reacted to player damage when set to Non-Interactable.
- Players rejoining the same session are now correctly represented with the same `player` object. Previously, rejoining players were incorrectly assigned new player objects, despite internally representing the same user.

### Matchmaking Updates and Fixes

**New:**

- **Creator Matchmaking Settings:** Added **MMS Backfill** and **Social Joining** options to both the Island Settings and Round Settings device. This allows you to control the initial matchmaking behavior and override it on a per-round basis.
- Replaced Join In Progress with **Join In Progress Behavior** to allow you to select between **Spawn During New Round** (spectate until next round), **Spawn Immediately**, and **Watch Only** (remain a spectator for the rest of the game).
- You can now override the join-in-progress team assignment through a separate **Join In Progress Assigned Team** property. This allows for the same behavior as the old Team Index option.

- **Matchmaking Portal:** Fixed an issue with the modal popup never displaying if the island split teams.

### Known Issues

- **Sidekicks:** Sidekicks will not appear in a Live Edit session unless all players have sidekicks enabled on their loaded islands.
- **UMG:** Widgets containing child widgets that have properties binded to them through View Bindings will cause a compilation error when launching a session/pushing changes. These errors will reset whenever a project is opened. A workaround is to compile the widget to clear these errors every time you open the project. This bug will be fixed in an upcoming release.
- **Creative Templates:** Due to a crashing issue, removed the following templates from 38.00 to address the issues:

  - Design a Speedway Race
  - Design a Zonewars Game
  - Create a Wave Defense Map.

  Creative templates will be restored in a future release.

## UEFN Updates and Fixes

### Editor

**New:**

- There are several new updates and improvements to the Fortnite tools.

  - **3D Select:** Added Filtering. You can exclude or include specific matching labels or classes.
  - **3D Select:** Added additional tool iInformation, such as the dimensions of the bounding box. Also added the **Best Fit Snap Grid** based on the **Bounding Box** size.
  - **Travel Time:** Added Units options for time and distance.
  - Added a **Scatter** tool. You can use this tool to scatter project `StaticMesh` assets in the level as Instanced Static Meshes.
  - Added a **Find Overlap** tool. This tool finds nearly identical overlapping objects. Use this to help optimize your levels by avoiding duplicate objects that needlessly consume memory.
  - Added the **Create Volume** tool. Use this tool to place a volume directly on selected objects.
- There are several updates to **Snap To Target** in the Fortnite tools.

  - **Added grid snapping.** This includes various visualization options.
  - Added visible bounding box side to more easily see the **Snap Axis**.
  - Added vertical offset with the associated hotkey to consistently offset objects when placing them.
  - Added a **Snap Each Object** button that will perform a one-time **Snap Each Object Along Axis**.
  - Added a **Snap to Hidden** toggle. You can use this to control snapping to objects hidden in the editor.
- **Verse toolbar changes:**

  - Changed the **Build Verse Icons** for Editor and VS Code Plugin.
  - Split the Verse button into **Open VS Code** and **Compile Verse**.
- There are several **Capture Manager** updates and improvements.

  - Added device token to the default working directory and download directory.
  - Added tooltips to the ingest job status icon.
  - Added an example stereo ingest device script.
  - Added a camera id to ingested asset metadata.
- Added the ability to assign additional project Verse paths, and to purge unpublished project Verse paths.
- In the **Outliner**, added visibility function versions that work on the selected actor's hierarchy, and set the **H** key as the default to toggle the selected hierarchy.
- For **MetaHuman**, added an example python script for calibration generation.
- Added the Editor Preferences setting Scale Asset Picker Widget Size to allow users to scale the size of asset pickers up or down.

**Fixes:**

- Fixed an issue where cut action was breaking Verse references in Live Edit.
- **Animation Starter Feature Example:** Fixed the interaction issue on the Switch devices in the feature example so it runs more smoothly.
- Fixed `.uefnproject` files being converted to UTF-16 unexpectedly when non-ASCII characters are used. Project files are now always saved as UTF-8.
- Fixed an issue where VFX was not appearing when an entity was added to the quick bar.
- Fixed an issue where entities had larger drop shadows than actors when using the same mesh.
- **Fortnite tools:** In Travel Time, fixed a missing point after a user's first click.
- There are several **Capture Manager (Metahuman)** fixes:

  - Fixed a crash that occurred when ingesting with the -nosound argument.
  - Fixed a crash that occurred when the user accessed an unset `TOptional`.
  - Fixed an issue with build breaks when using `ExampleNetworkIngestDevice`.
- Fixed a number of cases in which **Browse to Asset** would not select the asset in the Content Browser.
- Fixed a crash that occurred when the user loaded content from a corrupted pak or from optional segment files.

### Environment and Landscapes

**New:**

- Improvements to Landscape edit layers weight blending: The three weight-blending methods are now:

  - **None**, previously known as **No Weight Blend.**
  - **Final Weight Blending**, previously known as **Weight-Blended**, also known as **Legacy Weight Blending**.
  - **Advanced Weight Blending,**also known as **Premultiplied Alpha Blending**). An improved weight-blending solution that is compatible with edit layers, and that is applied at every blend step of the merge algorithm instead of at the very end. It relies on the weight sum of the blend group of the current layer as the alpha value.
- Removed Landscape Layer Info asset's sub-menu to create a **Non-Weight Blended** or **Weight Blended** option. There's now a new Landscape setting that defines which blend type is the default. The blend settings have been moved to the Landscape Layer Info asset.
- **Advanced Weight Blending** also has the concept of a blend group, so you can make certain layers weight-blended with each other, but those layers remain additive against others.
- Added the **Sort by Blend Method** option in the target layers list of the Landscape Paint panel.
- Deprecated legacy non-edit layer landscapes:

  - Removed all editor tooling related to non-edit layer landscapes (such as Landscape Retopologize Tool/XY Offset data).
  - Disabled the creation of non-edit layer landscapes and the ability to toggle between edit layers and non-edit layer landscapes.
- Improvements to the Landscape UX:

  - Updated icons to landscape target layers display order methods.
  - Added a sort type (ascending/descending) for this.
  - Removed unused icons.
  - Moved the sort/filter options next to the filter box within the Layers property. Since they affect only the layers that are visible, these buttons should not be present when the property is collapsed.
  - Added a number of target layers in the Layers property header, in order to be similar to standard arrays, and also the Edit Layers property above.
- When non-edit layer landscapes are loaded, an automatic conversion to an edit layer based landscape occurs. During this process, all proxies copy the existing non-edit layer data to a new default edit layer. Any existing Retopologize data is removed and the proxy is flagged as **soft dirty** with an editor viewport warning.

**Fixes:**

- Fixed an issue where landscape final (legacy) weight blending introduced ghosting artifacts in weightmaps.
- Fixed and issue where the Landscape Flatten tool conflicted with Undo.
- Fixed an issue where **Ctrl+Alt+Right-Click** drag increased/decreased the landscape brush continuously even when the mouse was still.
- Added refined Water Body underwater detection to avoid applying post-processing when the camera is underneath or outside the bounds of the collision volume.
- Fixed an issue with deleted landscape spline points/segments coming back after duplicating the spline.
- Fixed an issue where Landscapes only generate Nanite for the first 64 components of any given landscape proxy.
- Removed landscape Paint-Time Weight Balancing for the final (legacy) weight blending layer. This was misleading as it was trying to invent weight values for each landscape component, which could lead to weird painting behavior. This means the user now has to manually decrease the weights of other weight-blended target layers when painting on a given target layer.
- Fixed an issue where using a material instance caused missing updates to landscape physical material.
- Fixed an issue with landscape painting when toggling invert during a brush stroke.
- Fixed an issue with Landscape Flatten tool behavior at the edges of geometry.
- Fixed a crash that occurred when auto-filling target layers from a material.
- Fixed an issue where landscape spline meshes were missing after the merge of two splines was undone.

### Modeling

**New:**

- The **Paint Vertex** tool now supports a Symmetry option.
- The **Mesh Attribute** paint tool now supports a Hit Backfaces option.
- The **Paint Maps** tool can now optionally use a material that more strongly shows the shape of the underlying geometry.
- The **Mesh Attribute** paint tool now supports a **Brush Value** property to allow users to specify the target value that is painted, rather than always accumulating to 1.0.
- Changed the pre-simplification pass in the mesh to collision's convex decomposition to use a faster simplifier.
- Added support for the Tangents tool to choose which reference UV layer to use when computing tangents.
- The Inspect tool can now be used on skeletal meshes.
- Added some optimizations to the **fast winding** algorithm, which should improve performance of mesh Booleans and some other related operations.

**Fixes:**

- Fixed some cases where the ollision Enabled flag would be incorrectly copied/reported.
- Fixed an issue where hard edges could be lost when recomputing normals on a static or skeletal mesh after modifying the mesh with modeling tools.
- Reduced confusion during displace tool computations by adding a slight delay to the appearance of the in progress material.
- Created a real-time warning for Modeling mode and Scriptable Tools mode that only updates when the app has focus, to avoid spurious warnings when the background task override disables real time mode.
- Fixed an issue where an ensure occurred if the Sculpt tool was used on an empty mesh.
- Fixed an issue where brush stamps skewed on meshes with non-uniform scale in the Mesh Attribute Paint tool.
- Fixed an issue with material ID handling in the Modeling mode tools, which could incorrectly transfer material IDs in some cases.
- Fixed an issue where the bevel operation could crash.
- Fixed a bug which displayed random gizmo orientation in local space in the Poly Edit tool.
- Fixed a crash that occurred when hovering over Mesh Element Selection before a viewport is focused for the first time in an editor session.
- Fixed a localization issue for the Advanced Transform category label in the UV Editor.

## Scene Graph Updates and Fixes

**New:**

- The name of the feature in the Project Settings has changed from Inventory System to **Custom Items and Inventory.**
- By default, when a custom Item is added to an inventory, any mesh\_components on the item entity or its subentities will now be disabled (in other words, its collision and visibility are disabled).
- The inventory\_component has new functions: `GetEquippedItems` returns entities that are in the inventory and equipped.
- There are two new implementations of `GetItems` and FindItems which take in an item\_component subclass and return an array of entities with the specified item\_component type.
- The inventory\_component has two new events: `EquipItemEvent` and UnequipItemEvent.

  - EquippedChangedEvent is now `ChangeEquippedEvent`.
  - InventoryChangedEvent is now `ChangeInventoryEvent`.
- New extension functions added to entities which provide control over whether an entity, its components, and its child entities render on each player's machine.

  - `(Entity:entity).SetPresentableToPlayers(Players:?[]player):void` and

    `(Entity:entity).GetPresentableToPlayers():?[]player`
- The item\_component now includes Equip() and Unequip() functions.
- There are new scene events: equip\_item\_query\_event and unequip\_item\_query\_event.
- Custom Items and Inventory function **agent.GetInventory[]** has been removed. The new method to get the root inventory from an agent (or other entity) requires getting a descendant component. Here is an example of an alternative function:

```verse
GetAgentInventory(Agent:agent)<decides><transacts>:inventory_component
    Inventory := (for (I :
Agent.FindDescendantComponents(inventory_component)) { I })[0]
```

## Verse Updates and Fixes

**New:**

- **VerseUI:** Expose SetFocus method to player\_ui.
- Added validation support for checking for `enum` properties with missing / invalid enumerator values. Added localization support in the Verse property validator's messages.
- **classifiable\_subset:** Added experimental class for working with sets of Verse types. This class may be removed in a future release as use cases for it are evolving significantly.
- Improved a Verse compile error.

### Known Issues

- The VS Code Verse extension’s `VerseWorkflowServer` will not be able to connect in 38.00 due to a regression. It will be fixed in 38.10.

## URC Updates and Fixes

**New:**

- Improved the speed of various revision control operations by moving many processes to the background rather than operations that block user interaction.
- To improve understanding of when URC’s background processes are running, you’ll now see an intermittent non-blocking progress bar in the bottom right corner.
- We’ve improved preemptive conflict warnings with a new design and messaging to clearly distinguish them from active conflicts.
- Added a **Type** column to the submit window to more easily differentiate changes to files of different types with the same name.
- Improved locking so that if you undo a change to an asset, returning it to an unchanged state, the lock is again released rather than remaining checked out.
- Added pre-submit data validation to provide similar context to what is provided on session launch additionally when submitting changes.

**Fixes:**

- In cases when the .urc folder needs to be deleted/regenerated, we’ve improved the experience to attempt to bring the user to their last known location in the project’s history, rather than always latest.
- Fixed an issue in which reverting local changes to a previous snapshot did not restore project settings until the project was closed and re-opened.
- Fixed an issue in which checking in changes could fail once with **Failed to push new head pointer to branch**, then subsequently succeed.
- Fixed an issue that caused a developer to hit a long stall when reconnecting to revision control, while also expanding their log file unnecessarily.
- Fixed an issue with locking in which deleted actors could become unlocked after save, enabling other collaborators to check them out and cause conflicts.
- Fixed an issue where admin tool to **Unlock All** did not work for users who had left the team.
- Fixed an issue that caused a casing mismatch on a project folder name that resulted in failed revision control operations.
- Fixed an issue that caused a few users to encounter an extremely long dialog on sync or check-in that appeared to reload every material and also caused additional slowness during Revert operations.
- Fixed an issue in which a user made/saved a change but the check-in button remained disabled.
- Fixed an issue that triggered a **Failed to find Node** error when reverting a prefab.
- Fixed an issue causing a collaborating user to not get latest assets statuses quickly after their collaborator resolves conflicts with **All Mine**.
- Fixed an issue causing **Previewing sync file(s) from revision control** to take an unexpectedly long time.
- Fixed an issue with locking that could keep actors checked out after checking in changes.
- Made a follow-up, more robust fix for an issue that could end up with a user in conflict with their own recent changes.
- Fixed an issue in which the viewport cursor froze after a user acknowledged the warning after choosing to rewind.
- Fixed URC incorrectly reverting modified PO files during the localization export.
