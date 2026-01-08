# 35.00 Fortnite Ecosystem Updates and Release Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/35-00-fortnite-ecosystem-updates-and-release-notes>
> **爬取时间**: 2025-12-27T00:33:39.270341

---

V35.00 is here! General Physics is now available in UEFN as an Experimental feature, enabling dynamic, physics-based gameplay. This update also brings improved devices, new Burd and Nature Galleries, a new "Popular in Your Region" creator row in Discover, and much more.

## General Physics (Experimental)

[General Physics](https://create.fortnite.com/news/experimental-feature-general-physics-brings-enhanced-interactivity-to-fortnite-islands) enables physical interactions and simulations within Fortnite islands and is being released with v35.00 as Experimental. Physics must be explicitly opted into in Project Settings. Physics and provides creators with foundational physics functionality to create physics-based gameplay experiences. For a more in-depth look and beginner tutorials, check out the [Physics in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-with-physics) documentation.

- **Publishing**: Enabling Physics while it is experimental disables publishing. You can't publish your island while experimental features are enabled. If you disable Physics, your island will be publishable again.
- There is a **Physics** option in **Project Settings**, and setting it to **True** enables the following:

  - The **Player Spawner** device will spawn the player as a physics-based character.
  - Fortnite Props can have the new “Fort Physics” component added to enable, which enables physical simulation.
  - You can enable physics options and interactions on certain devices (see the Devices bullet below).
- **Interaction**: Players can interact with physics objects, for example:

  - **Moving** into the objects, including jumping into/onto them.
  - Striking the objects with the **Pickaxe**.
  - Using Fortnite “hitscan” weapons such as shotguns, pistols, assault rifles and SMGs on the objects.
- **Devices**:

  - Devices that have been updated for physics are in the **Fortnite > Devices > !Experimental** folder in your project.
  - All devices are available, but some may be incompatible with Physics.
- **Prop Mover**: Objects animated with the Prop Mover device will interact with physics objects.
- **Sequencer**: Objects animated with the Sequencer will not interact with physics objects.
- **Verse API**:

  - Added new Verse API to the **Volume** device:

    - PropEnterEvent
    - PropExitEvent
  - Patterns, naming and structure of Physics API might change to accommodate Scene Graph changes.
- **Player Movement Modes**: The physics-based character will have a limited set of player movement modes.
- **Weapons**: All weapons will be available, but only “hitscan” weapons will affect physics objects.
- **Items**: All items will be available, but some might not function correctly with the physics-based character.
- **Props**: All Fortnite props will be available.
- **Live Edit Known Issue**: There is a known issue where changing physics settings on a prop component requires pushing changes. This will be addressed in a future release.

### Physics Soccer Tutorial

Create a simple 3v3 soccer game using the new experimental physics feature! Import a custom soccer ball asset, set physics properties and score points by hitting the ball into the goal with a pickaxe. Check out [Make a Soccer Game](https://dev.epicgames.com/documentation/en-us/fortnite/make-a-soccer-game) and experiment with physics-based gameplay today!

[![Screenshot of a soccer arena for the physics-based soccer game](https://dev.epicgames.com/community/api/documentation/image/5bccd1b6-aefa-4349-88df-24b31fa6f4a3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5bccd1b6-aefa-4349-88df-24b31fa6f4a3?resizing_type=fit)

Make a soccer game with a ball that uses physics.

## New Time of Day Manager for Fortnite Creative

Fortnite Creative has a new Time of Day Manager (TODM)! The upgrade guarantees:

- More realistic lighting with Lumen and Nanite.
- Parity with the UEFN TODM and future TODM updates.

With the upgrade to the new TODM comes the retirement of the **Skydome** device. All islands using the Skydome device will retain their gameplay, volume data, and positional data. However, the island lighting will default to Chapter 5 lighting, and will ignore any settings used with the Skydome device. New islands using the Skydome device will not be publishable.

To customize your lighting, use the [Day Sequence device](https://dev.epicgames.com/documentation/en-us/fortnite/using-day-sequence-devices-in-unreal-editor-for-fortnite) and the [Ambience settings](https://dev.epicgames.com/documentation/en-us/fortnite/world-settings-in-fortnite-creative#ambience-settings) available in the **World Settings** category under **Island Settings**.

UEFN templates that are still using legacy lighting will be updated in the 35.10 release. Between 35.00 and 35.10, if you create a project using a UEFN template that has legacy TODM and a Skydome device, you will receive a prompt to convert to the new TODM.

To learn how to upgrade the lighting in the maps or how to replace the Skydome device, see the [Upgrading Legacy Lighting in Multi-Level Projects](https://dev.epicgames.com/documentation/en-us/fortnite/upgrading-legacy-lighting-in-multilevel-projects-in-unreal-editor-for-fortnite) document for more information.

## Matchmaking and Queues Documentation

Learn how to increase player satisfaction and player engagement by customizing matchmaking settings and queue controls. With the new queue controls, you can adjust matchmaking times and player targets to deliver the best-quality experience for your island. Learn how to take advantage of these new settings with the [Matchmaking and Queues](https://dev.epicgames.com/documentation/en-us/fortnite/matchmaking-queue-controls-in-fortnite-creative) document.

## AFK In FNE

Players on any Creative or UEFN island will be automatically disconnected after 60 minutes of inactivity. A warning message will appear one minute before the player is disconnected, giving players a chance to stay in the session. Performing regular movements or interactions will reset the timer and prevent disconnection.

This is a temporary workaround while we work to resolve a bug related to AFK detection when a player is viewing video in full screen mode.

## UI Template Updates

### Material Assets

Learn more about **Signed Distance Field (SDF)** textures and how these can be used to upgrade your UI materials and the overall look of your UI. Signed Distance Field (SDF) is a function that uses position as an input, and outputs the distance from that position.

For example, in an SDF texture the center of the image is **1**, meaning fully white, but as it progresses towards the edge of the image, it transitions to **0**, fully black. Using this concept, SDFs provide a way to specify a range of values between 0 to 1 to apply an effect. Learn more about SDF textures, and how to use them in UI materials, in the [Material Assets](https://dev.epicgames.com/documentation/en-us/fortnite/material-assets-in-unreal-editor-for-fortnite) document.

[![SDF textures in UI Materials](https://dev.epicgames.com/community/api/documentation/image/afb3dbd3-1723-4e37-84a0-cc2e88d1f932?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/afb3dbd3-1723-4e37-84a0-cc2e88d1f932?resizing_type=fit)

SDF textures in UI Materials

### Conversation Template Now Available in the UI Template

The Conversation template project can now be found inside the UI template. Future updates to the Conversation device feature examples will focus on how to improve and expand your conversation UI.

The Conversation template is still available in the Feature Examples section in the Project Browser.

## Creator Portal, Discover and Creator Rules Updates

### Fortnite Creator Rules Updates: Music Lyrics

It’s important that all island content aligns with Fortnite’s game ratings, including music lyrics.

We’ve added a new subrule (1.15.8) to our [Creator Rules](https://fn.gg/Creator-Rules), as a specific reminder that lyrics in your island must not exceed what your island's age rating allows. Also, now you’ll see this subrule referenced if you receive a music-related violation so you know where to address the issue.

Read our [IARC FAQ](https://fn.gg/IARC-FAQ) to learn about IARC and how to apply age ratings to your island.

### Thumbnail A/B Testing

The publishing and development process now has A/B testing for island thumbnails, to help you find the optimal thumbnail image for an island. This testing provides a way to compare the performative results of thumbnails to see which thumbnail had better engagement based on click-through rates. This helps you optimize engagement, use real player data to reduce guesswork, and iterate faster.

[![Thumbnail A/B testing in Creator Portal](https://dev.epicgames.com/community/api/documentation/image/84aca40d-eb64-4c77-956d-548ba6923cbf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/84aca40d-eb64-4c77-956d-548ba6923cbf?resizing_type=fit)

Thumbnail A/B testing in Creator Portal

For more information, see the [A/B Thumbnail Testing](https://dev.epicgames.com/documentation/en-us/fortnite/ab-thumbnail-testing-in-fortnite-creative) document, and check out the [Thumbnail A/B Testing blog](https://create.fortnite.com/news/ab-test-thumbnails-to-optimize-player-engagement-in-your-fortnite-islands).

### New Creator Row Now Available in Discover

Get more visibility to your Creator profile through the new dedicated Creator row added in Discover. The new **Popular Creators in Your Region** row automatically populates recommended creators based on a player's country, helping you grow your community.

## Content Browser and Inventory Updates

### Flashlights Now Work in First Person

We've added updated animations for flashlights in **First Person mode**, to ensure crouching does not break the action.

### Recently Used Content in the Creative Content Browser

You can now find the content or devices you’ve most recently used in the Home page of the Creative Content Browser to help you quickly get to the assets you use most often.

### Display Empty Ammo Slots

All inventory resources are now shown in players’ inventoriesy by default, so they can Request Ammo or Request Materials. The new **Display Empty Ammo Slots** island setting has been added so creators can show or hide ammo and materials when the player has none.

### Device Updates and Fixes

##### Updates

- **Grind Rails**: Added a new user option for disabling grinding when a player is walking over the rail, and new user options to control grinding direction and minimum speed.
- **Bank Vault and Armored Transport**: Added new functions to destroy or restore the current active weak point.
- **Camera devices**: Added a new option to allow them to be used as **Elimination Cameras**. If this option is enabled, the selected camera will be used as the active camera as soon as a player is eliminated. This doesn't affect the camera while a player is spectating.
- The **Wildlife Spawner** and **NPC Spawner** devices now support Patrol Path usage on Wildlife and NPCs. New user options have been added to the two devices:

  - Spawn on Patrol Path Group
  - Enable Resuming Patrol Path
  - Change Patrol Path Target
  - Change Patrol Path Timer
  - Should Randomly Select Path
  - Can Assign to Disabled Paths
- The **Barrier** device has a new user option, **Can NPC Added To Ignore List**. This determines if NPCs can be added to the ignore list of the barrier. Once any NPC is added, all NPCs will be ignored by the device since they share the same navigation data.
- The **Movement Modifier** device has a new user option, **Apply To Non-Player Character**. This option supports usage with Guards, NPCs and Wildlife. The default value is **Off**. When this option is set to **On**, AI characters can be affected by the device.
- Shoe Cosmetics are now supported on both the **Player Reference** device and **Dance Mannequin** device.

##### Fixes

- Fixed an issue where the Timer device would not synchronize for users joining in progress.
- Fixed an issue where having two or more Prop Manipulator devices on the same prop would result in the one with the highest priority not being selected.
- Fixed an issue where the Accolade device's Award UI wouldn't appear after placing it while in Edit mode.
- Fixed an issue where the Matchmaking Portal device displayed a default texture on half of one side.
- Fixed an issue where the Target Dummy's preview box was too large when placing the device.
- Fixed an issue where the Accolade device failed to display text on the UI in subsequent rounds on published islands.
- Fixed an issue where the Day Sequence device **Enabled During Phase** option was not being disabled properly when entering the island, when the option was set to any value other than **All phases**.
- Fixed an issue with the Patchwork Music Manager's **Tempo** user option, where fractional tempo values set from UEFN or the Creative Customize panel were rounded off.

### New Prefabs & Galleries

- 2 New **Burd Prefabs**

  - Burd Gas Station Store
  - Burd Gas Station Restaurant
- 3 New **Burd Galleries**

  - Burd Gas Station Floor & Stair Gallery
  - Burd Gas Station Wall Gallery
  - Burd Station Prop Gallery
- 6 New **Nature Galleries**

  - Japanese Spring Nature Gallery
  - Japanese Fall Nature Gallery
  - Japanese Winter Nature Gallery
  - Shogun’s Solitude Nature Gallery
  - Japanese Forest Nature Gallery
  - Lawless Gold Forest Nature Gallery

## Documentation and Learning Content

### New Build Your First Island Tutorial

It’s been two years since UEFN’s launch! Now, we've completely overhauled the first-island experience to match all of the changes the Fortnite tools have gone through in that time.

Spend one hour following the [Build Your First Island in Fortnite](https://dev.epicgames.com/documentation/en-us/fortnite/build-your-first-island-in-fortnite) tutorial to come out the other end with a carnival shooting gallery you'll build from the bottom up! You’ll start a project in UEFN, make some changes in Live Edit, and add some Verse code to customize and streamline your mini-game. You'll also get a sense of the core basics of creating an island and how to use all the tools Fortnite has to offer. For brand new Fortnite creators, you'll get a carefully curated tour of some features that will get you started creating your own islands.

Stay tuned for more documentation and learning updates improving our onboarding experience over the next couple of releases!

### Install and Launch Fortnite Overhaul

Installing, downloading, and launching Fortnite documentation has now been combined and streamlined into one page that covers all you need to know about getting set up in Fortnite and UEFN in [one location](https://dev.epicgames.com/documentation/en-us/fortnite/install-and-launch-fortnite-creative-and-unreal-editor-for-fortnite)!

### Math in UEFN Video Series

Ever wondered how the transforms – Translation, Rotation, and Scale – work in UEFN? Now you can learn all about them in our video series [Math in UEFN](https://www.youtube.com/watch?v=e2QNJs-p5Fk&list=PL9niUMaDJY72aG6K85Np9Q9V4eOGlZcd1)! Using Fall Guys obstacles, check out how each of these transforms can affect and change your gameplay!

Math in UEFN: Translation

### New First Hour in UEFN Videos

There are two new videos showcasing UEFN’s systems and capabilities. The videos are on the FN Create YouTube channel.

First is [UEFN First Hour: Niagara VFX](https://youtu.be/2o_u2PqcwN4)! Get a brief breakdown of how the Niagara system works to create cool particles and environmental effects. In this video we take a simple fountain effect and show how you can manipulate its size, color, and spread!

Niagara VFX I Your First Hour in UEFN

Next is [UEFN First Hour: Environmental Lighting](https://youtu.be/4VJDAy-f9bM)! While we do talk about prop lighting in the course, this video talks about lighting your island as a whole to get the right mood and design feel for your experience. This video touches on using the Day Sequence device, the Environment Light Rig, and Lumen Exposure Manager.

Environmental Lighting I Your First Hour in UEFN

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where numerous warnings caused by Niagara assets used by Fortnite occurred when launching the project.

  - [Forum Report](https://forums.unrealengine.com/t/numerous-warnings-caused-by-niagara-assets-used-by-fortnite-occur-when-launching-the-project/1875102)
- Fixed an issue with Scene Graph where adding a child entity to a new parent does not function properly.

  - [Forum Report](https://forums.unrealengine.com/t/scene-graph-adding-a-child-entity-to-a-new-parent-does-not-function/2343130)
- Fixed an issue where agents respawning with Verse show as eliminated in the team info UI.

  - [Forum Report](https://forums.unrealengine.com/t/respawning-agents-with-verse-shows-them-as-eliminated-in-the-team-info-ui/1879311)

## Fortnite Ecosystem Updates and Fixes

##### Fixes

- Fixed an issue where some team members' pings appeared white.
- In Island Settings, fixed an issue where setting **Team** to **Custom**, **Coop** or a **Number** would put all players in the same team when the **Team Size** was set to **1** when two clients were connected, or **Team Size** was set to **2** when three clients were connected.
- Fixed an issue where the Lava Floor piece couldn't be deleted from the Lava Tiles Gallery.
- Fixed an issue with the Fall Guys characters that was causing incorrect network corrections.
- Updated the defaults for **Force Start at Max Players** in Island Settings. This results in behavior that players expect, where the game start timer will short-circuit so you don't have to wait the full duration once the game is at capacity.

  - **Force Start at Max Players** option now defaults to **Enabled/On**.
  - Increased the **Force Start Delay** option default to **5 seconds**.

## Brand Island Updates and Fixes

### LEGO Islands Updates and Fixes

- Added the ability for NPC Spawner guards to equip the sword.
- Clamped the minimum and maximum Selection Radius of the LEGO Assembly device.
- Fixed several issues with the LEGO Assembly device:

  - Fixed an issue where the device could fail to play build SFX.
  - Fixed an issue where objects disassembled by device could still be destroyed.
  - Fixed an issue where the device could assemble buildings out of order.

### The Walking Dead Universe Updates and Fixes

- Added the ability to select a color variation for the prisoner Walker's jumpsuit.
- Added the option to block applying the Walker's damage over time effect if a player is bitten while shielded.
- Added a slight buff to Lucille’s damage and range:

  - Range of Primary Attack Increased (to 140 from 128)
  - Damage of Primary Attack Increased (to 75 from 70)
  - Damage of Heavy Attack Increased (to 180 from 150)

## UEFN Updates and Fixes

##### Fixes

- Fixed a crash that occurred in the signaling connection code that can happen after the connection has been destroyed.

### UI

##### New

- Added support for dragging widget and viewmodel properties into the bindings list.
- Added **On Selected** and **On Unselected** events to UEFN Buttons.
- Added support for duplicating ViewModel bindings in the UMG Editor. There is now a context menu item you can use to duplicate binding entries in the ViewModel Binding list.

##### Fixes

- Fixed an issue that was causing soft-lock when disabling or hiding buttons using Verse code.

### Scene Graph Experimental

##### New

- Introduced a specialized text widget in the Scene Outliner. The Scene Outliner now shows the ID suffix of entities in dark gray, and rename operations don't affect it so it doesn't need to be manually managed.
- You can now set the `Receives` property onto Decals in the mesh\_component.

##### Fixes

- Fixed a problem with entities not being added correctly using AddEntities if the entities that are being added are already simulating.

### Editor

##### New

- Localization export now only modifies PO files when their localization data changes.
- Actor discovery has been optimized within the localization export.
- Spatial Profiler: Rearranged the buttons for the main tool bar. The new order is: Save/Open/Record/Stop.
- Added a Navigation Bar to the Asset Browser dialogs.
- Modified the Maximize/Restore button so that it drops you out of windowed-fullscreen.
- Removed the gray background from Viewport layout icons and decreased the icon size based on UX feedback.
- Updated the Project Browser's Details panel to display more info about the selected project. The project's last edited time, engine version, brand, and Verse path (if applicable) will now show.
- Added the **Show in Content Browser** option for plugins in the Plugin Reference Viewer.
- Added a **Reimport Options** popup dialog to DataTable Import Options that will display when the Curve Table reimport button is pressed. This allows an interpolation mode to be selected.

##### Fixes

- Fixed the cause of OOM crashes. These were caused by high peak memory usage when adding a large number of meshes into a scene.
- Fixed the AssetPicker filters going out of scope when selecting them from a UtilityRig.
- Fixed an issue where disabling `stat fps` after manually removing the viewport override could cause an ensure warning.
- Fixed an issue that could cause a texture's tooltip to incorrectly display a Source Size is too large validation error. This did not impact actual validation.
- Fixed an issue where scale changes were allowable through mirror functions if the component or selected actor had disallowed it.
- Fixed  an issue where spin boxes were not getting their context menu extenders passed through, when they were created by vector input boxes. Updated mirror axis menu strings to pull from axis info.
- The SDockTab can no longer be closed when `CanEverClose` is set to **False**.
- Spin boxes now revert to the previous value when the Escape key is pressed.
- Fixed an issue where the level editor toolbar started to clip items while there was still free space.
- Fixed an issue where DPI scaling was being double-applied in the transform toolbar width calculations.

### Environments and Landscapes

##### New

- Changed the default landscape edit layer method to BatchMerge. The Landscape.EditLayersLocalMerge.Enable default value is changed to **2**.
- When saving, pending work related to landscape layers and physical material will now be flushed.

##### Fixes

- Disabled TAA when in landscape mode because landscape brushes don't play well with temporal algorithms.
- Re-entrant calls to UpdateLayersContent or other main entry points to add or remove layers during UpdateLayersContent are now correctly detected.
- Fixed an issue where landscape splines were always dirtying the proxies on load when they affected the weightmaps.
- Crash resistance has been added for ALanscapeSplineActor when it is in a bad state.
- Fixed an issue with landscape weightmap import comparison vs heightmap resolution.
- Fixed an issue with landscape corruption when the Smooth tool was used with a Nanite landscape.
- Fixed a crash in the actionable message system that occurred when users reloaded a level without clicking **Update**.
- Fixed an assert that occurred with BatchMerge when a weightmap layer was only written by a BP brush.
- Fixed a crash that occurred when destroying a landscape after an undo.
- Fixed an issue with randomly disappearing water.

### Modeling

##### New

- Added height map bake support to the BakeVertex and BakeTextures tools.
- In ScriptableTools, made the gizmo respect the Scale Uniform flag, and added the free translate and rotate flags so that uniform scale, arcball, and screen translation can be used.
- The Simple Collision editor tool in Modeling mode now uses interval gizmos to control capsule and box dimensions, and supports toggling world and local spaces for the transform gizmos.

##### Fixes

- Fixed an issue in the PivotActorTool that prevented the output object to be named using the input object name.
- Fixed an issue in the PaintVertexColors tool that caused the resulting colors to be transformed incorrectly on Accept.
- Fixed an issue in the UV Editor where notifications/warnings emitted from Actions (for example, Sew) would not post.
- Fixed an issue in the PaintVertexColors tool where it displayed the incorrect values in Unlit Vertex Color mode.
- Fixed a crash that occurred when running the Subdivide tool using the Loop subdivision scheme on a volume.
- Fixed a rare issue where the free rotation gizmo could become stuck in an invalid state.
- Fixed a crash that occurred when accepting the Duplicate tool on a volume.
- Fixed a rare crash that could occur when editing a static mesh component.

## Verse Updates and Fixes

### API

- Added <transacts> to GetTags for creative objects so it can be used in failure contexts.
- Fixed some NaN issues with Verse spatial math types.
- Fixed an issue where the Volume device could not be found when trying to find it using FindCreativeObjectsWithTag.

### Language

- Added a clearer error message for qualified named parameters, which are not yet implemented.
- Removed a spurious compile error when defining a module in multiple parts, some parts with qualification, and others without.

### Tools

- Fixed an issue with Verse VS Code workspace symbol searches, for which the first result was a built-in definition (for example `int`).
