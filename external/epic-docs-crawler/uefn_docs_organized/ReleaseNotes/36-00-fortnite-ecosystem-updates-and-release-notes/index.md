# 36.00 Fortnite Ecosystem Updates and Release Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/36-00-fortnite-ecosystem-updates-and-release-notes>
> **爬取时间**: 2025-12-27T00:36:16.903978

---

Scene Graph beta is here! Scene Graph is a new foundational engine layer that unifies editor and runtime views, making all scene elements accessible through Verse, and was engineered from the ground up to power the future of UE and UEFN.

Plus say hello to three new devices: Player Movement, Hero Chest, and the Progress Based Mesh. And that’s not all, Test Players have two new behaviors, there is a new version of Unreal Revision Control, and you’ll find new weapons and items.

## Scene Graph Beta Launch

Scene Graph is a new foundation layer of the engine that breaks down all of the objects in a scene and enables you to access, modify, and control them using Verse. Scene Graph brings all the objects on your island — gameplay, visuals, sounds, VFX, and so on — into a single unified structure, letting you work more efficiently and build richer experiences.

With the first release of Scene Graph, users have access to a core set of component capabilities: meshes, materials, collision, sounds, VFX, and player interaction. Alongside the core capabilities, the system also features a new prefab workflow, letting you build reusable content that can then be modified, spawned, and destroyed through Verse code, making development of complex gameplay far more simple.

The initial release of Scene Graph is only the start. We'll be expanding the feature set for Scene Graph continuously, bringing features like:

- Improved workflows for prefabs, such as inline editing in the level editor and a one-file-per-entity solution to better enable multi-user collaboration.
- Support for using Fab referenced content in prefabs and entities.
- An expanded component set to unlock more gameplay.
- Deeper interoperability with existing creative\_props and creative\_devices.

For an overview of all the changes and where Scene Graph is at launch see, **[Publish Fortnite Islands Created with Scene Graph](https://create.fortnite.com/news/publish-fortnite-islands-created-with-scene-graph-now-in-beta)** blog.

To check out all the new updates, you can get started with the all new Scene Graph Feature Example, which showcases how to use Scene Graph with art and gameplay examples. For new gameplay, [Create a Platformer](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-platformer-with-scene-graph-in-unreal-editor-for-fortnite) is up to date and we have a brand new [Lights and Bridges tutorial](https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-puzzle-in-fortnite).

In addition to the example content, all our documentation has been updated for the Beta launch. You can check out all the [Scene Graph](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite) documentation on the EDC now!

## Forward-Right-Up (FRU) is Changing to Left-Up-Forward (LUF)

With the v36.00 release, we’re switching to the Left-Up-Forward (LUF) coordinate system. This replaces the Forward-Right-Up (FRU) setup from v35.00, and better aligns with common 3D tools like Autodesk® Maya® as well as Universal Scene Description (USD).

This coordinate system change affects anyone using UEFN or transforms in the `/Verse.org` module. Some immediate changes you’ll see are:

- UEFN Details panel
- UEFN viewport and gizmo
- Verse transform

![Old XYZ](https://dev.epicgames.com/community/api/documentation/image/13ca159a-43c2-4f30-9938-981b52ffe85f?resizing_type=fit&width=1920&height=1080)

![New LUF](https://dev.epicgames.com/community/api/documentation/image/6f5318d7-cc3c-4819-ade3-57a29c68a792?resizing_type=fit&width=1920&height=1080)

Old XYZ

New LUF

All transforms in UEFN — both from actors and Verse—now use the LUF coordinates, and rotations are expressed with Euler angles applied in LUF order instead of yaw/pitch/roll style.

You don't need to change the code or content for your published islands to work properly in 36.00.

The shift to LUF coordinates will impact existing content, including environments created with Scene Graph. To learn more about the change and how you might be impacted, see **[Left-Up-Forward Coordinate System](https://dev.epicgames.com/documentation/en-us/fortnite/leftupforward-coordinate-system-in-unreal-editor-for-fortnite)**.

## New Progress Based Mesh Device

Start creating growth mechanics with the Progress Based Mesh device. The device swaps between meshes and materials at different thresholds to visually represent progression. The default mesh in Creative and UEFN is a Slurp Jar.

You can set up buttons, triggers, objectives, and more for players to activate the filling and draining of the jar. Use UEFN to expand your visual system with custom meshes and materials, along with transitional visual and sound effects. With the material parameter, you can create smooth transitions on your material.

Build a range of mechanics like:

- Growing or decaying plants in a garden
- The filling and draining of fuel tanks
- Tip jar for your restaurant tycoon

To learn more, see [Using Progress Based Mesh Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-progress-based-mesh-devices-in-fortnite).

## New Player Movement Device

The Player Movement device manages different types of movement through movement attributes. The customized movement determines how players move beyond what is controlled through Island Settings. This, in turn, adds a level of control to the island that creates a unique feeling to the in-game experience and supports different game genres.

The Player Movement device:

- Does not customize the player input or relevant animations.
- Does not override specific movement configurations to a certain gameplay item or vehicle.

Learn more about controlling player movement on your island with the **[Player Movement Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-movement-devices)** document.

## New Shove Gameplay Item

The [Shove item](https://dev.epicgames.com/documentation/en-us/fortnite/shove-gameplay-item-in-fortnite) is an all-new gameplay-oriented item that players can equip to push another player with a small force a certain distance away. Players cannot see when other players have Shove equipped and the item requires stamina to use.

Shove can be used to give a player a sneaky push from the back or when in melee combat, or while hidden behind a prop. Shove is a versatile item that can be used in many different gameplay scenarios!

At 36.00, the **Shove** item will be listed under **Weapons**, but at 36.10, Shove will be moved under **Items**. Shove is considered an item, not a weapon.

## New Hero Chest Device

The new Hero Chest can be found in the **Chest and Ammo Gallery** in Creative. This is the first chest device with user options, events, and functions!

Each Hero Chest can be locked and unlocked on a per-player or global basis, and has multiple ranks that determine its loot. The Hero Chest also is supported by Verse.

## Conversation Device Updates

The Conversation device has new features and Conversation nodes that support new types of gameplay for your island:

- **Hide Conversations**
- **Show Conversations**

Create conversations where players can interact with two characters at once, add materials and animations to your conversation UI to make conversations more lively with the new **Set Conversation Material** node and the **Play Conversation Animation** node. See the [Conversations](https://dev.epicgames.com/documentation/en-us/fortnite/conversations-in-unreal-editor-for-fortnite) documentation to learn more about using the new Conversation features and more.

## Conversation Template Deprecated

The Conversation Template in UEFN is no longer available from the Feature Template section. You can find the Conversation Template in the **User Interface Template**.

As part of the User Interface template, the Conversation device hall will have future updates and examples of how to create a unique conversation UI for your island.

[![The Conversation template is now part of the User Interface island template.](https://dev.epicgames.com/community/api/documentation/image/cd1a3bae-ef9c-4fb2-b733-8d0465b2cb9d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cd1a3bae-ef9c-4fb2-b733-8d0465b2cb9d?resizing_type=fit)

## Test Players Now Have Behaviors

You can now assign two new behaviors to test players: Random Movement and Follow Player. **Random Movement** will move test players to a random position, then back to their starting position. **Follow Player** will lock a test player onto a nearby player then, when the player crouches, the test player will begin following them. When the player un-crouches, the test player will stop following the player.

You can also assign custom behaviors using NPC Character Definitions. Test players can be configured as a **participant** in the `npc_behavior` class.

## Learn More About Fortnite Discover

We want creators to understand how they can influence their success in the ecosystem, and we know Discover is a big part of that.
 We recently released our most transparent [Discover documentation](https://dev.epicgames.com/documentation/en-us/fortnite/how-discover-works-in-fortnite) yet, providing detailed technical information on how Discover works.

We also shared our long-term vision for Fortnite Discover, which is to become the go-to destination where players find their next favorite game.

Check out the [blog post](https://create.fortnite.com/news/evolving-fortnite-discover-together) to learn more about how Discover is evolving.

To get into the technical behind-the-scenes details, see [How Discover Works](https://dev.epicgames.com/documentation/en-us/fortnite/how-discover-works-in-fortnite).

## Fortnite Data API

On May 28, we launched the [Fortnite Data API](https://create.fortnite.com/news/fortnite-data-api-unlocks-more-island-insights-for-creators) and made engagement and retention metrics publicly available for all Epic-made experiences. On June 9, we’re expanding the dataset in the Data API to include the same metrics for all creator-made islands. This is an important step toward making Fortnite the most open ecosystem for creators, and will help you make data-driven decisions as you build, launch, and grow your games.

To learn more about the API, see the [Fortnite Data API Overview](https://dev.epicgames.com/documentation/en-us/fortnite/using-fortnite-data-api-in-fortnite).

## New Version of Unreal Revision Control

With this release, we’re rolling out a **new version of Unreal Revision Control (URC)**. Starting today, all **new projects** will use it by default. **Existing projects** will be migrated gradually over the coming weeks and months.

For now, this change is on the backend and your experience will mostly remain the same. This is an important technological change because the new system lays essential groundwork for future enhancements.

One immediate benefit of this change is **Automatic personal backups**: every save creates a remote backup to a personal branch, offering a safety net for disaster recovery. This means your work remains accessible even if it hasn't been checked in. These backups can be viewed through the updated command line interface (CLI).

A side effect of personal backups, you may notice gaps in snapshot numbers in the Snapshot History panel. This is expected — personal backups also generate revision numbers, but only main project revisions appear in the panel at this time.

## Content Browser and Inventory Updates

Check out all the new devices and items available this release!

### Device Updates and Fixes

**New:**

- **Fixed Angle Camera**

  - Added a tunable Point Of Interest Framing option that automatically adjusts the focus of the camera to keep multiple players in frame. Creators can choose between having the camera keep all targets in frame through an offset, which shifts the camera from side to side, or Zoom, which pulls the camera out.
- **Armored Transport Spawner**

  - New preview mesh.
- **Prop-O-Matic Device**

  - Added player feedback when a prop is targeted that cannot be used by the player.
- **Character Device**

  - You can now enable Live Link in the UEFN Editor, and capture and record custom motion capture animations directly to Fortnite Characters.
- **Character Device / Character Controller Device / Dance Mannequin Device / Guard Spawner Device / NPC Spawner Device**

  - An additional 105 Character outfits are now available in all these devices. This includes 16 exclusive characters from Crew and 89 from previous Battle Passes.

**Fixes:**

- **Vehicle Spawners**

  - Vehicle Spawners now hide all Respawn options when Enable Respawn is set to Off.
- **Team Settings & Inventory Device**

  - Fixed an issue where the quick bar would not reflect the Maximum Equipment Slots value specified in the Team Settings & Inventory device after switching to the corresponding team.
- **Chests**

  - Fixed an issue where cutting and pasting a chest while editing an island could cause its loot to spawn.
- **Launcher Devices**

  - Launcher trajectory now uses the world gravity to draw the trajectory.
- **Verse Devices**

  - Fixed an issue where a Verse device redundantly showed an editable property at its parent scope when a non-editable property with the same name also existed at the parent scope.

### New Weapons

- Spire Rifle
- Deadeye DMR
- Unstable Voltage Burst Pistol
- HyperBurst Pistol
- Killswitch’s Revolvers
- Unstable Yoink Shotgun
- Unstable Frostfire Shotgun
- Bass Boost
- Myst Gauntlets
- Shove

### New Items

- Lawless Rift Launcher
- Tracking Visor

## Fortnite Documentation is Now Combined

As mentioned in the last release, if you head over to Documentation in the Epic Developer Community, you’ll see that the tabs are gone and the docs are all in one streamlined set!

We’re always evaluating our content and looking for ways to improve the information presentation. Merging the two sets is a major improvement, and has been restructured to follow the game development process. The general flow is now: get started, setup, examples and templates, gameplay, level design, art, and publishing.

This change also consolidates ALL the Game Collections under one section so they are no longer split between Creative and UEFN. This means that all LEGO® Templates are in the same location!

We hope this change significantly improves your ease of use and how you can find our documentation content online! Be sure to check it out and update your bookmarks, and let us know what you think in the forums!

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue with the Prop Mover where prop movement failed to change when given new movement events.

  - [Forum Report](https://forums.unrealengine.com/t/major-almost-all-hidden-properties-are-now-disallowed-they-have-been-allowed-since-uefn-released-until-34-30/2446835)
- Fixed an issue where vehicles were no longer breaking small props on first contact.

  - [Forum Report](https://forums.unrealengine.com/t/vehicles-can-no-longer-break-small-props-instantly/2385037)
- Fixed an issue where the All Jam Loops category was not showing in creator-made islands.

  - [Forum Report](https://forums.unrealengine.com/t/all-jam-loops-do-not-show-up-in-uefn-made-maps/1951406)

## Fortnite Ecosystem Updates and Fixes

**New:**

- When using Spatial Profiler, the **Available Memory** metric is now configured so low values are bad and the heatmap colors will change accordingly.

**Fixes:**

- Fixed an issue where grass fire persisted after the end of a game.
- Fixed an issue where changing bindings caused the editor’s Compile button to not capture the new bindings.
- Fixed perf hitch when dragging brush on navmeshfixed navmesh not updating when changing brush location in a sublevel.
- Fixed an issue where cooldowns would not properly end when changing out of a team or class with **No Cooldowns** enabled.
- Fixed an issue where published Creative islands were unable to use more than 16 teams.
- Fixed the AFK (away from keyboard) system player activity detection while interacting with the UI.
- Fixed an issue where the preview actor would not snap to the grid if grid snapping was enabled, after spawning multiple grid-only props.

## UEFN Updates and Fixes

**New:**

- Added a new UEFN island setting called **Allow Team Indicators**. When set to false, this setting provides a way to remove team indicators from your island, potentially improving performance for large groupings of teammates.
- Added a progressive retry timer for save-data loading attempts to decrease the time players wait when moving between servers.
- Users are now able to modify read-only values of widgets.
- Toast notification functionality for progress bars hasbeen removed.

Fixes:

- Fixed the rendering issues that affected Translate and Rotate gizmos.
- Fixed a Revision Control issue where renaming files resulted in no revision control history for new and moved files within Perforce.
- In URC, deleted assets now display their **descriptive names** in the Submit dialog and Snapshot History panel, resolving a long-reported frustration since previously only asset IDs were shown.

### Editor

New:

- Added a new keyboard control to the Content Browser: **Ctrl+RMB** now creates the **AddMenu**.
- Viewport camera navigation now includes local up-and-down movement with **R** and **F** key controls.
- New material\_block provides a way for a widget to display a UI material.

**Fixes:**

- Fixed an issue where a developer’s in-game copy was not being sent to localization and was not respecting word order in each language.
- When localizing your project, the Volume menu in the Show Flags level editor viewports now pull the display name from the class data instead of looking for an entry in Show Flags.
- Fixed the zoom ratio to be consistent in the Ortho viewport.

### Animation and Cinematics

**New:**

- Control Rig has a new tag filter in the module browser tab under the **Modular Rig Editor**.
- Sequencer has a new button on the toolbar called **Force Whole Frames**.

### Environment and Landscapes

**New:**

- Automatically migrate legacy LandscapePatchManager setups to the new system when a scene is loaded.
- Added an option for landscape sculpt and erase tools to apply only when moving the brush.
- Optimized landscape undo.
- Made autosaves faster by not forcing a build of landscape nanite.

**Fixes:**

- Fixed a refresh issue affecting Undo and Redo Landscape painting.
- Prevented the Water Body River component from greatly increasing memory usage in the editor with large landscapes.
- Removed auto-filling of empty landscape target layers.
- Fixed an issue affecting selections that were getting lost on Landscape Undo.
- Now displays an error message instead of crashing when failing to import an image file to a landscape layer.
- Fixed an issue affecting landscape Smooth, Erosion, and Flatten tools performance.
- Improved responsiveness of landscape edits in scenes using PCG by eliminating redundant invalidation signals.

### Visual Effects / Niagara

**New:**

- Added Niagara event-type structs to the UEFN allow list to enable usage of event read and write nodes.

**Fixes:**

- Fixed the permissions to allow custom categories and Data Interfaces to show up for user parameters in the Details panel of the level editor.

- Fixed an issue with the Niagara Scratch Pad scripts where users were not able to open the scripts.

### Materials

**Fixes:**

- Fixed a bug where MaterialFunctionInstance failed to gather all parameters from the material function.
- Fixed an issue where the editor would crash when renaming materials in certain instances.

## Scene Graph

**New:**

- Added a field name change in the mesh\_component from Collideable to Collidable.
- Changed the scale in the keyframe deltas for the keyframed\_movement\_component to be interpreted in an additive way as opposed to multiplicative. This allows for animation to and from zero scale, which was previously not possible.

**Fixes:**

- Fixed an issue with the light components where they were not selectable in the viewport after reinstantiation.

## Verse Updates and fixes

**Fixes:**

- Fixed an incorrect doc string for the GetCurrentState function on the switch\_device.
- Fixed a bug regarding transform initialisation when teleporting players using Verse.
- Fixed a bug that caused SetMaterial on creative props to not update the material properly.

## Known Issues

The following are a list of known issues for various features in this release.

### Scene Graph

Scene Graph Known Issues are published in the documentation as part of the Scene Graph documentation set and are updated each major release. Check them all out at [Known Issues in Scene Graph](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-known-issues-in-fortnite).

Currently, any version control system, either URC or Perforce, does not work when more than one person is editing an entity in the same map. See [Known Issues](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-known-issues-in-fortnite) for more information and workarounds.

### Player Movement Device

- Players can be eliminated by jumping too high if their jump velocity, hang time, and all jump related settings are set to max.

  - **Workaround**: Enable the glider through island settings.
- Changing the **Sliding Maximum Forward Speed** setting does not affect the sliding speed of the user in any way.
- Setting **Max Players** to 100 and **Test Players on Game Start** to **Fill** will cause issues in functionality after the first game.
- "Follow" behavior cannot be activated in LEGO islands.
- Test Players do not drop Reboot Cards.
- Capture Area Device is not triggered by Test Players.
- Checkpoint Pad is not triggered by Test Players.
- Test Players do not spawn when **Spawn Limit** is set to **1.**
- (UEFN-only) Max Values cannot be set for some options. The following settings are impacted:

  - Jump Maximum Time
  - Jump Velocity
  - Swimming Maximum Speed
  - Swimming Maximum Sprinting Speed
  - Walk Maximum Speed
