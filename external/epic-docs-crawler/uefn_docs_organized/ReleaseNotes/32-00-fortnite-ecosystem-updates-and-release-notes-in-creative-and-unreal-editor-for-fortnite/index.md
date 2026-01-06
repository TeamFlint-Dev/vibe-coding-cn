# 32.00 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/32-00-fortnite-ecosystem-updates-and-release-notes-in-creative-and-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:35:19.637287

---

With v32.00, the Skilled Interaction device and the Conversation device are now available! Use these devices to bring your island to life with narrative and role-playing gameplay. The new auto-localization feature for text lets you take your UEFN islands worldwide by providing a way for you to make them available in every Fortnite language. Want to learn more about using Verse to create a complex procedural building system like the one recently shown off by [Re:Imagine London](https://create.fortnite.com/news/fortnite-s-re-imagine-london-bringing-london-to-life-in-uefn?team=personal)? Check out the new **Verse - Procedural Building** feature example project to learn more!

## New Skilled Interaction Device!

Expand the ways players can interact with an environment by providing a new, skill-based interaction mechanic in Fortnite Creative and UEFN! Make your own fishing or lockpicking mini-games by using the hold and release interaction (Charge and Release) or by making a selection at the right time. To learn more, see [**Skilled Interaction Devices**](https://dev.epicgames.com/documentation/fortnite-creative/using-skilled-interaction-devices-in-fortnite-creative).

[![example of gold mini game with bar timer](https://dev.epicgames.com/community/api/documentation/image/7805c2f9-dfae-4f80-b0a6-ae83735f0d96?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7805c2f9-dfae-4f80-b0a6-ae83735f0d96?resizing_type=fit)

The device includes many customization options in Fortnite Creative for functionality and visuals, including:

- Layout options
- Layout colors
- Success and failure icons
- Timing values
- Number of successes and failures
- Sizes of zones
- Speeding up after each success
- Shrinking zone sizes after each success
- Zone position randomization

Add these to your interactions in UEFN with View Models to create custom widgets. (Verse API support will be available in a future release.)

## New Conversation Device for UEFN!

The [Conversation Device](https://dev.epicgames.com/documentation/en-us/uefn/conversations-in-unreal-editor-for-fortnite) lets you create dialogue trees for players to engage with NPCs in your islands, making their encounters more interactive. You can build custom conversation graphs using player choices and outcomes to enhance and drive gameplay.

To get started, explore the [Creating Conversations](https://dev.epicgames.com/documentation/en-us/uefn/creating-conversations-in-unreal-editor-for-fortnite) in UEFN. You'll learn how to use the Conversation Editor—a custom tool for crafting dialogue in your projects—alongside asset creation and options to customize the conversation menu styles. Take a look at [Conversations in UEFN](https://dev.epicgames.com/documentation/en-us/uefn/conversations-in-unreal-editor-for-fortnite) for device documentation, workflows, and tutorials on building custom conversations.

[![example conversations graph](https://dev.epicgames.com/community/api/documentation/image/ada7b4ee-8496-496e-89d5-23cd08f0174c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ada7b4ee-8496-496e-89d5-23cd08f0174c?resizing_type=fit)

## New Verse - Procedural Building Example

The **Verse - Procedural Building** feature example is available in this release. This feature example utilizes complex performant code written in Verse that can be used as a starting point for other projects!

This example features Verse code snippets from the recent Re:Imagine London island, which showcases complex procedural building systems written entirely in Verse (including Shape Grammar and Wave Function Collapse algorithms).

Check out the [Procedural Building template](https://dev.epicgames.com/documentation/en-us/uefn/procedural-building-template-in-unreal-editor-for-fortnite) documentation to learn more.

[![top view of procedural building template](https://dev.epicgames.com/community/api/documentation/image/bb4d77f6-cb6b-4fde-b985-e902b722fe59?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb4d77f6-cb6b-4fde-b985-e902b722fe59?resizing_type=fit)

## Chapter 5 Time of Day Manager in Creative

Fortnite Creative is getting a whole new look! New islands created in Fortnite Creative will feature the new Chapter 5 Time of Day Manager (TODM). This update brings enhanced lighting using Lumen and Nanite, giving new islands created in Creative a more realistic look. Plus, the new TODM will now match the UEFN version, bringing parity between Creative and UEFN lighting.

To create custom lighting use the [Day Sequence device](https://dev.epicgames.com/documentation/en-us/uefn/using-day-sequence-devices-in-unreal-editor-for-fortnite) as well as the [Ambience settings](https://dev.epicgames.com/documentation/en-us/fortnite-creative/world-settings-in-fortnite-creative#ambiencesettings) available in the World category of Island Settings.

The TODM conversion affects custom lighting setups with a Skydome device. This means that as lighting develops in UEFN, the lighting in Creative keeps parity with new TODM lighting settings.

Before opting in, back up your island. Opting into the new TODM is a one way conversion, and only the Skydome volume and location data will be retained. You cannot return to the old TODM once you've converted your island. To learn how to convert your island, see the [Day Sequence device](https://dev.epicgames.com/documentation/en-us/uefn/using-day-sequence-devices-in-unreal-editor-for-fortnite) page.

All devices set up for gameplay will continue to work as expected.

It is recommended to opt in early to update your old islands to the Chapter 5 TODM lighting. All islands will automatically transfer to the new TODM system in an upcoming release, and the Skydome device will be retired. At that time, any islands using the Skydome device will no longer have custom lighting set with the device.

[![create custom lighting with the Day Sequence device in Fortnite Creative](https://dev.epicgames.com/community/api/documentation/image/c3a2897b-acf1-49db-86f2-ed9c3f7a25b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c3a2897b-acf1-49db-86f2-ed9c3f7a25b1?resizing_type=fit)

## Fab and UEFN Integration Updates

Creators have had access to the Fab library from inside Unreal Editor for Fortnite (UEFN) since last year, but [Fab.com](http://Fab.com) is now live for all creators!

Fab is a one-stop marketplace where users can discover, buy, sell, and share digital assets, supporting all types of creators with content for use across Unreal Engine, Unity 3D and UEFN.

Check out the updates to the Fab UEFN integration below and learn more about what's coming in the future!

### UEFN Integration Updates

- Megascans content that has been acquired under a Reference license within UEFN will remain free through 2025 and beyond.
- The Fab UEFN integration now features an updated and refreshed Megascans catalog, offering higher-quality versions of many of the assets.

### Future Improvements

- There will be even more high-quality UEFN content available on Fab when Scene Graph moves into Beta.
- We're building a pipeline to make it easy for you to publish content directly from UEFN to Fab. We'll share more details as we get closer to launch.

[![fab social image](https://dev.epicgames.com/community/api/documentation/image/4d1a40bc-6295-45b5-9ec0-4a588df5f459?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d1a40bc-6295-45b5-9ec0-4a588df5f459?resizing_type=fit)

## Auto Localization for UEFN Islands

With Auto Localization in UEFN, you can now translate the text in your Fortnite islands into all fourteen supported languages, making your content appealing to a larger global player base.

This feature generates machine translations for text-elements like gameplay instructions, dialogues, and objectives. It works alongside the existing Asset Localization workflows to offer players an experience fully tailored to their preferred language. Manual localization from creators’ chosen sources is not available yet. We’ll share updates on this in the near future.

For details on exporting text and assets for translation, see [Text Localization in UEFN](https://dev.epicgames.com/documentation/en-us/uefn/text-localization-in-unreal-editor-for-fortnite).

## UEFN Now Available During Downtime

It is now easier to stay productive during Fortnite downtime. While some features may be temporarily disabled, you're now able to work on your island offline in UEFN. You can expect the editor to support continued project editing during maintenance. Although testing capabilities will be unavailable during downtime, they will resume once Fortnite servers are back online, so you can continue your progress during server maintenance.

Please note that occasional downtime across all products, including UEFN, may still be required for backend upgrades or other essential maintenance.

## Scene Graph Updates (Experimental)

Some of the Scene Graph Verse APIs have been updated to return generators instead of raw arrays. The function `FindComponents` is one example, and you will need to update your Verse code.

Generators can be used in many ways just like arrays, but they do not support random access. This means that Verse code that looked like `MyEntity.FindComponents(my_component_type)[0]` will have to be written like `(for (Y : MyEntity.FindComponents(my_component_type)) { Y })[0]` until another more condensed syntax is supported.

## Update to Verse Language V1

In the 32.00 release, we have stabilized Verse language V1 and added a new unstable Verse Language V2.
Since the first public release of the Verse language, we have continued to add to and evolve the Verse language, with those changes transparently rolling out to users without requiring an upgrade to a new language version. We anticipate that will continue, with most language changes being made in a way that is backward-compatible with previous versions of the language and rolled out to users with new releases of UEFN.
You have the option to upgrade your project from Verse V0 to Verse V1, which we recommend so you are always on the latest and greatest version of the language. For more details on the changes to the language between versions, see [Verse Language Version Updates and Deprecations](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-version-updates-and-deprecations-in-verse).

## Consoles Preview in UEFN

We have added the ability to preview what your island will look like in consoles like Generation 8 and portable consoles. You can use this to preview how your island will appear to players on those consoles so you can adjust your content accordingly:

- Settings > Preview Platform > Console > Gen8 Console
- Settings > Preview Platform > Console > Portable Console

Note these are just approximations, and ultimately, loading up your island code on a given console will always be a good check.

## New NPC Sequencer Bindings

There are now two new ways to bring NPCs into your sequences in UEFN: the **Spawnable** NPC binding and the **Replaceable** NPC binding. These bindings are created from an NPC Character definition.

The spawnable NPC binding will spawn a mannequin based on an NPC Character definition into the world as part of a sequence.

The replaceable NPC binding will take control of an NPC spawned into the world using the NPC spawner and animate it as part of a sequence. To learn more, see [Using the NPC Spawner with Animations](https://dev.epicgames.com/documentation/en-us/uefn/using-the-npc-spawner-with-animations-in-unreal-editor-for-fortnite).

## MetaHuman Animator: Audio to Animation

You can now use audio data to create high-quality facial animations for MetaHuman and Fortnite characters. Quickly generate facial animations for NPCs in your islands from recorded audio, with support for multiple languages and non-verbal sounds, all within the familiar MetaHuman Animator workflow.

## New LEGO® Island Updates

- New traps are available on LEGO® Islands: Bouncer, Chiller, and Launch Pad devices (Ceiling, Wall, and Floor variants). *Safety Disclaimer: Minifigure helmets, elbow pads, knee pads, goggles, and protective gear not included!*
- Creator Profile devices are now enabled on LEGO Islands.

## Patchwork Time Signature and other Updates

Patchwork devices can now play music at different time signatures. You can directly change the time signature of your mix using the [Patchwork Music Manager](https://dev.epicgames.com/documentation/fortnite-creative/using-patchwork-music-manager-devices-in-fortnite-creative#deviceoptions), or automate time signature changes with an imported MIDI file played by the [Patchwork Song Sync](https://dev.epicgames.com/documentation/fortnite-creative/using-patchwork-song-sync-devices-in-fortnite-creative#midifiles).

Other Patchwork updates:

- Blend Time controls have been added to the [Value Setter](https://dev.epicgames.com/documentation/fortnite-creative/using-patchwork-value-setter-devices-in-fortnite-creative#deviceoptions) and [Step Modulator](https://dev.epicgames.com/documentation/fortnite-creative/using-patchwork-step-modulator-devices-in-fortnite-creative#deviceoptions), allowing you to ramp between Patchwork device values over time.
- The [Patchwork Speaker](https://dev.epicgames.com/documentation/fortnite-creative/using-patchwork-speaker-devices-in-fortnite-creative#otherdeviceoptions) has new Fade time options to smoothly bring audio in or out so it starts or stops being audible to a player.
- The [Patchwork Note Trigger](https://dev.epicgames.com/documentation/fortnite-creative/using-patchwork-note-trigger-devices-in-fortnite-creative#events) can now trigger events at the start or stop of a note.

## Device Updates

- **Orbit Camera**: New Auto Rotate Terrain Offset Enabled option added. If enabled, the camera automatically adjusts its pitch up and down based upon the slope of the terrain the player is traveling on. For example, if the player is running uphill, the camera will pitch up.
- **Third Person Controls, Fixed Angle Camera, and Fixed Point Camera** devices are no longer Beta.
- **Analytics device**: The number of times this device can be placed has increased from 50 to 100. As a reminder, the first device you place uses 39 memory, and each one placed after the first uses 9 memory.
- The **Grind Vine** device has been deprecated. Instead, you can now add grind vines as a Visual Type option in the **Grind Rail** device. Use the **Vine Tip Type** and **Apply Additional Moss** options to recreate the aesthetics of the vine.
- **Scarecrow Hiding Prop**: New user options exist to change clothing color and add a pumpkin to the head of the scarecrow.
- The following options were added to the **Race Manager** device:

  - **Update Lap Time Stat Each Lap** (True by default, False for existing devices to match old behavior): When set, this will update the Lap Time Stat in the scoreboard on every lap, rather than just at the end of the race.
  - **Use Lap Time Stat as Initial Lap Time**: When set, it uses any saved Lap Time Stat from the scoreboard as your Best Lap time when starting the race. This allows best laps to persist across multiple races.
- Added an option for **Show Contextual Controls** on the **HUD Controller** device. This shows or hides the HUD element to the left of the screen that displays available inputs the user can activate, such as vehicles, melee weapons, or input triggers.
- The default skybox can now be hidden using a **Day Sequence** device.

## New Weapons and Weapon Updates

### New Weapons

- Kaboom Bow - Mythic
- Pistol (Full Auto) - Common, Uncommon, Rare

### Weapon Updates

- The "Full Auto" pistol is now renamed to **Pistol**. All other pistols are renamed to **Semi-Auto Pistol**.
- Added the following melee weapons for the Guard Spawner and NPC Spawner: Basic Sword, Basic Hammer, Shockwave Hammer.

### New Infinite Ammo Island Settings

The Infinite Reserve Ammo setting has been split into multiple settings to give creators greater control over the ammo economy of their experience. The new settings are:

- No Cooldowns
- Infinite Magazine Ammo
- Infinite Loaded Energy
- Infinite Reserve Energy
- Infinite Charges

The value of Infinite Reserve Ammo prior to this update will be migrated to all of these settings except No Cooldowns. These settings are also added to the Team Settings and Inventory and Class Designer devices, and retain any of the previously set options.

## Two New Device Design Examples!

Two new documentation pages have been added to the growing inventory of [Device Design Examples](https://dev.epicgames.com/documentation/fortnite-creative/device-design-examples-in-fortnite-creative) to change up you gameplay:

- [Big Rig Device Design Example](https://dev.epicgames.com/documentation/fortnite-creative/big-rig-device-design-examples-in-fortnite-creative): Looking for a crazy way to use a Big Rig on your island? Slap on some off-road tires and your players can drive this Big Rig anywhere!
- [Conditional Button Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite-creative/conditional-button-device-design-examples-in-fortnite-creative): The Conditional Button device is a flexible mechanic for setting up all kinds of interactive gameplay. See three great examples of how to use this device!

## Community Bug Fixes

The following list of fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where the Prop Disguise could be canceled even if disabled in Prop-o-Matic Manager.

  - [Forum Issue Report](https://forums.unrealengine.com/t/prop-disguise-can-be-canceled-even-if-disabled-in-prop-o-matic-manager/2064789)
- Fixed an issue where NPCs with cosmetics added were not displaying nameplates.

  - [Forum Issue Report](https://forums.unrealengine.com/t/important-npc-with-cosmetic-doesnt-display-name/2024114)

## Creative Updates and Fixes

**New:**

- Improved the FOV Setting description by spelling out "Field Of View" in all of the settings.

**Fixes:**

- Fixed an issue where the Creative Sword and Hammer did not pop balloons when a player performed an in-air attack.
- Fixed an issue where the Ballistic Shield Charge was not hitting creatures.
- Fixed an issue where the Anvil Rocket Launcher was not showing the targeting UI.
- Fixed an issue where heavy stuttering occurred when a player walked on certain plant props.
- Fixed a bug that caused the map indicator to be placed above the top point of some islands.
- Fixed an issue where the Guardian Shield would be invisible while a player blocked with it.
- Fixed a typo in the description of the Double Barreled Shotgun.
- Fixed an issue where the Business Turret Out Of Range message persisted if the player returned to the hub.

## Devices

**New:**

- Set the Firefly Spawner option **Only Spawn During Night** to default to **ON**. When set, fireflies will only spawn between dusk and dawn, regardless of other settings.
- Added the **Explosive Fishing** option to the Fishing Zone device, and set it to **True** by default. If set to **False**, explosives will not work in the fishing spot.

**Fixes:**

- Fixed an issue where devices were showing in-game when they were supposed to be hidden.
- Fixed an issue where scene lighting components hidden by a Day Sequence Device would never get unhidden.
- Fixed the **Target Cursor** Twin Stick Mouse Aim Mode of the Control: Third Person device so it shoots at the intended chest height and is consistent with Dial Aiming in the **Control: Third Person** device.
- Fixed an issue with the Timer device where **For All** functions would not activate when the device was set to **Scope: Everyone**.
- Fixed an issue with the Player Counter device where Join In-Progress players wouldn't see the correct target player count.
- Fixed an issue where the Lap Time Stat wasn't updating in a single lap race.
- Fixed an issue where the Channel device showed incorrect information in the debug message.
- Fixed a typo in the Video Player **Stream Priority** tooltip.
- Fixed the Ball Spawner ball from going through players.
- Players can no longer vault over the Ball Spawner ball.
- Fixed the Visual Effect (VFX) Powerup device Outline effect on mobile platforms.
- Fixed an issue with the Map Controller device where the device would not properly display larger-size maps.
- Fixed an issue with the Item Granter where the **Grant Timer** option did not allow for numeric input in Creative. Also improved the description of the **Grant on Timer** option.
- Fixed an issue where the Nitro Hoop device cooldown state could fail to properly end.
- Fixed an issue with the Video Player device where the **Enter Full Screen When Receiving From** option did not work on Android. The reload button now triggers fullscreen mode and is always visible when this option is enabled.
- Fixed an issue where elimination and explosion audio was not triggering with the Objective device.
- Fixed an issue where players hiding in props would no longer be counted by zone devices.
- Fixed an issue with the Tracker device where updating the target or text through events or Verse would not update the UI widget until the value next changed.
- Fixed an issue with the Objective device where `DestroyedEvent()` was not starting in Verse.
- Fixed an issue with the Barrier device where registered players leaving the game would cause a Verse runtime error.
- Fixed an issue with Character device cosmetics duplicating when editing in a Live Edit session.
- Fixed an issue where the `OnStopped` event was using the wrong tooltip in the Cinematic Sequence device.

### Verse API Updates

**New:**

- Deprecated `GetCreativeObjectsWithTag` in favor of a set of extension methods named `FindCreativeObjectsWithTag` for devices and entities.

## UEFN Updates and Fixes

**New:**

- Improved diagnostic messages for **Graph Linked to External Private Object** errors.
- Fixed the Drop On placement issue with the phone tool in Live Edit session. Devices can be properly snapped to the ground.
- New icons for Landscape mode UI.
- Added filters to the Landscape mode Paint Panel to help find and target specific layers in the list.
- Various UX improvements for landscape **Select** tool:

  - You can refresh the landscape mode details panel when clearing the selection in order to hide the Select tool options immediately.
  - Moved the Select tool-specific options into a **Select Mask** category.
  - Moved the Select button to the end of the tool list for both Sculpt and Paint panel, since this is not really an editing tool and acts in both modes
- Added Async MakeBrush & LoadTexture / Load Material Nodes for loading MVVM from Verse.
- Added `FloatToUInt` and `UIntToFloat` material expressions.

**Fixes:**

- Fixed a warning message in landscape code when creating a map from a template island that still has MIPs in its edit layer data.
- Made several fixes for the landscape tool brushes and Select tool.
- Fixed water bodies not retaining their landscape weightmap settings, leading to incorrect landscape painting.
- Fixed several technical issues that caused the editor to crash.
- Fixed frequent crashes when performing delete, undo, and redo operations on Material Expressions, especially when these operations were applied to Function Inputs while a material using the function was open in the editor.

### TMNT Updates and Fixes

**New:**

- Improvements were added to City Starter template.
- Creators can now remove stars from the skybox material.
- Improvements to Mouser animation, including a new turn animation that is used when Mouser is not in combat.

**Fixes:**

- Reduced the intensity of the red eye glow on the Mouser.
- Several technical fixes were made to the City Starter template.
- Background windows no longer cast shadows.
- Fixed a bug where the TMNT version of the Driftboard used the incorrect VFX.
- Air attacks with the TMNT weapons no longer cancel when traveling a long distance.
- Fixed an issue where the Mouser enemy would not show the red eye glow when taking damage from players that are outside of its alert range.
- Fixed an issue where the Mouser wouldn't show the shield UI when taking damage if it had shields.

### UEFN Editor

**New:**

- Added support for importing .tif files containing multiple directories through Interchange.
- Added support for importing .tx files through Interchange.
- Disabled the Asset Search plugin.
- Added validation of UMaterial and UMaterialInstance on project publish:
- Fixed issues with wall movement when using the Gizmo in local space.
- Fixed an issue preventing walls from snapping to the correct location when being added to a level.
- Texture validation will now check the source texture size to ensure it is within upload limits.
- Updated validation messages to differentiate those that can be fixed via texture properties as opposed to those that require updating the source texture.
- Added a new preview window for .abc files to inspect assets, animations, with interactive controls.
- Added console command tooltips when displaying the history. Also, for the console command text box, there is now a tooltip for the command currently being typed (if it's valid), which also displays the current value for CVars. (To avoid typing the variable without parameter, switch to the log window to peek at the current value then back to the console command to enter a new value.)
- The Push Changes button no longer indicates that changes need to be pushed after the Push Verse Changes button is pressed.
- Added an **Auto Push Verse Changes** toggle in the Push Changes dropdown menu that will automatically upload Verse updates after successful compilations.
- Added the ability to provide custom LOD Screen Sizes values in Interchange Import Dialog for mesh assets.
- Added a brand filter to the Brand Templates category.
- Added an EditorPerProjectUserSettings override for Texture import PNG infill setting.
- Increased support for more properties to be live-editable.
- Interchange Import Dialog now shows a warning icon when imported or reimported assets have conflicts.

**Fixes:**

- Made **Browse to Asset** more robust when copying actors, or when they are placed via LiveEdit.
- Fixed an issue where closing a standalone viewport resulted in a crash.
- The editor no longer crashes when launching a Live Edit session if you have more than 65,000 actors in your project.
- Updated the Project Size tool to respect the last locally uploaded module version, if known.
- Fixed a performance issue when source control is enabled on a project with large numbers of actors.
- Fixed Live Edit failing to initialize in some cases.
- Creating or deleting folders in the outliner no longer indicates that changes need to be pushed when Live Edit is enabled.
- Modifying editor-only properties no longer indicates that changes need to be pushed when live edit is enabled.
- Fixed an issue where the client Refresh Requested status would not match the UEFN Push Changes button status when new assets are created.
- Fixed an issue where a warning was not being displayed if a project was created in a folder managed by external backup systems such as OneDrive or Dropbox in UEFN.
- Fixed an issue where placing actors would incorrectly indicate changes needed to be pushed when Live Edit was enabled.
- The function property dropdown on keys for gameplay events in Sequencer will now only display properties that are enabled.
- Fixed an Interchange Import Dialog bug where pipeline settings were not saved when the pipeline stack changed.

### Modeling

**New:**

- Added a **Snapshot Tool** in the UV Editor. This allows users to easily export a texture asset of a UV Layout, and to customize the look and resolution of the image to be exported.
- Sculpt tools now support stylus pressure sensitivity.
- The Edit Pivot tool now supports orientation snapping to match the pivot orientation to another surface in your level.
- Added a UVShell output type to the BakeTexture tool to render UV wireframes to texture.
- Added new settings to the UV Editor **Display** menu. These allow customization of the following:

  - Unwrapped Viewport: Boundary Line Thickness, Boundary Line Color, Wireframe Thickness.
  - Live Preview Viewport: Selection Line Color, Line Thickness, and Point Size.
- Added **Thicken Shells** options to the Vox Wrap tool.
- The Cube Grid tool now initializes the grid origin based on the active element selection (if any).
- Added proto mesh.
- Limits the number of background tasks modeling tools can run simultaneously to generate preview results.

**Fixes:**

- Updated the behavior when deleting PolyGroup Edges in Mesh Element Selection. Now, upon PolyEdge deletion, the edge's adjoining groups are merged. This behavior now matches the PolyEdge deletion functionality found in the PolyGroup Edit tool.
- Fixed a bug where the Mesh to Collision tool would sometimes auto-fit oriented boxes with an incorrect orientation.
- Fixed an issue where edge selections were not always preserved on tool accept for the PolyGroup Edit and Triangle Edit tools.
- Modeling mode now warns the user when their selection includes engine assets that cannot be modified.
- Disabled **Ctrl+Alt+Drag** select when a tool is active, as this caused conflicting visuals relating to the active selection.
- Fixed a crash that occurred when exiting the editor while Mesh Element Selection was active
- Fixed an issue where the Level Editor scale snapping affected the UV Editor scale snapping.
- Fixed an issue where the Simplify tool **Prevent Normal Flips** option was treated as always on so did not affect the result.
- The Tri Select tool is now properly labeled as **Tri Select**.
- Fixed an issue where box and cylinder UV projections could introduce bow ties in the UV layout.
- Fixed an issue in the UV Editor's Seam Tool which displayed incorrect seam placement in some cases involving multiple selected meshes or rotation.
- Fixed an issue that did not allow for snapping when scaling a mesh in the XForm >Transform tool.
- Fixed issue where custom PolyGroup layers could not be selected in the Mesh to Collision tool when multiple input meshes were selected.
- Fixed an issue where some primitives could be created slightly off-center when generated with very low triangle counts.
- Fixed some cases where operations on edge selections, like contraction, did not give the expected result.
- Fixed an issue where the Edit Normals tool would sometimes not correctly update tangents.
- Fixed issues where the PolyGroup Edit and Triangle Edit tools could lose or incorrectly handle the mode-level mesh element selection on tool start.
- Fixed an issue that caused undo and redo to not behave as expected or crash when deselecting edges in Mesh Element Selection.
- Fixed an issue where the Mesh to Collision tool's convex decomposition option could crash on some inputs.

## Verse Updates and Fixes

### Scene Graph (Experimental)

**New:**

- Updated `tag_component` to actually implement `tag_view` instead of providing one through a `get` method.
- Entity queries now use the new generator return type.

**Fixes:**

- Fixed an incorrect disposal of spawned tasks when spawned inside the Scene Graph component code (previously spawned tasks could not outlive the component they were spawned).

### Language

**New:**

- Weakened the effect of reading a var from 'transacts' to 'reads'.

**Fixes:**

- The compiler now prevents incorrect qualifications that were previously ignored silently. One example is:

  ```verse
        Module1 := module: 
            (Module1:)Misc := module: 
        Module2 := module:
            (Module1:)Misc := module:
  ```

  The fix to existing code is to use the correct qualified name. In the above example, the `Misc` in `Module2` should be qualified with `(Module2:)`, so `(Module2:)Misc`.
- Fixed an issue where the default tuple fields would cause the editor to crash when compiling Verse. No existing published code is affected by this change since using default tuple fields crashed the compiler before this fix.

### Verse.org APIs

**New:**

- Changed some Verse tag functions in `tag_view` to use the `reads` effect instead of `transacts`.

### Tools

**Fixes:**

- Fix for an issue where an `editable` optional property would appear in the object property panel twice.
- Fixed the `VerseAssist` autocomplete from omitting inherited members.
