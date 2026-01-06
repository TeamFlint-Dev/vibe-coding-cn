# 30.00 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/30-00-fortnite-ecosystem-updates-and-release-notes-in-creative-and-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:32:41.372461

---

Take Recorder is now available in UEFN, allowing you to create multiple takes for the same scene or action. This allows you to experiment with different variations without the need to re-record. The Character device, Character Device Controller, Dance Mannequin device, Guard Spawner, and (UEFN-only) NPC Spawner have been updated with hundreds of new characters and Outfits in v30.00!

In the Creative inventory Content browser for Creative and UEFN, Items have been renamed to Items to improve asset and item labeling.

There are also changes to Effects in Verse and Unreal Revision control now highlights actors in the viewport based on their URC status.

In this release, we've combined Patch Notes and Release Notes into one document. Now you can read all about the updates and changes in one place on the Epic Developer Community!

## Cancel Moderation Feature in Creator Portal

You now have the ability to cancel a moderation submission, providing greater control over your content. Navigate to your submission history within the Creator Portal, then select the submission you want to cancel. If the submission is not already in progress, you'll have the option to cancel it. However, if the moderation process has already begun, cancellation may not be possible.

## “Items” are now renamed as “Items”

The “Items” category has been renamed to “Items” in the Creative inventory Content browser for Creative and UEFN. This change improves the labeling of assets and items, as well as sets things up for when Itemization is released. We’ve applied the “Item” subcategory and applied this tag to items affected by the **Infinite Items** island setting.

[![screenshot of updated items and items page](https://dev.epicgames.com/community/api/documentation/image/2f9cc067-5272-4d79-b4e7-17c127c2b040?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f9cc067-5272-4d79-b4e7-17c127c2b040?resizing_type=fit)

It should be noted that “Weapons” are also considered items, but they are distinct enough to have their own category. Items that have a body, do damage, use ammo/charges/energy, or do melee damage will be found under **Weapons**. Some items were moved from Weapons to Items with this release, such as the Coal and Signal Remote items.

## Over 800+ Fortnite Characters are available!

Devices where you can select a Fortnite character have been updated with hundreds of new outfits and characters to choose from. This includes the Character device, Character Device Controller, Dance Mannequin device, Guard Spawner, and NPC Spawner (UEFN only).

Additionally, the **Character Icon Picker** is a new option in all of these devices that allows you to quickly preview and choose a character. You can browse the picker or search by character name.

## Take Recorder is now available in UEFN!

You can now record with **Take Recorder** into Sequencer and use those takes directly in a sequence directly for playback. Take Recorder can be used in several different ways, including but not limited to:

- **Animation Recording:** Record animations and motions of characters or objects in the editor world. This provides a way to create custom animations from motion-capture data. Motion capture data can be accessed using [LiveLinkHub](https://dev.epicgames.com/documentation/en-us/uefn/using-livelink-hub-in-unreal-editor-for-fortnite) and the new Performer Component and LiveLink Controller components.
- **Sequencer Integration:** Seamlessly integrates with Sequencer, which is the timeline-based cinematic editing tool. This integration can use recorded takes directly in Sequencer for further editing and compositing.
- **Multiple Takes:** Create multiple takes for the same scene or action. This gives you the flexibility to experiment with different variations or performances without having to re-record everything from scratch.

[![take recorder location under windows and take recorder window](https://dev.epicgames.com/community/api/documentation/image/55d6fcc2-1f4e-4df2-8393-d752a643a840?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/55d6fcc2-1f4e-4df2-8393-d752a643a840?resizing_type=fit)

For more information about Take Recorder and how to use it, see the [UE5 Take Recorder](https://dev.epicgames.com/documentation/en-us/unreal-engine/take-recorder-in-unreal-engine) documentation.

## Spatial Profiler and Metrics in UEFN

**Spatial Profiler** is a UEFN Editor widget that allows you to capture, save, and visualize a 2D top-view heatmap overlay of a metric sampled in the context of your project. The Spatial Profiler includes four metrics that you can use to evaluate the performance of your experience and identify hot spots to optimize:

- **Actor Count:** Tracks the number of actors so you can assess how your experience is streamed in and out.
- **Game Update Time:** The time spent updating the next frame of your experience.
- **Render Time:** The time spent drawing the next frame of your experience.
- **Memory usage:** The total physical memory a client uses when connected to your session.

We plan to provide additional metrics to expand the profiler in later releases. To learn more, see the [Spatial Profiler](https://dev.epicgames.com/documentation/en-us/uefn/spatial-profiler-in-unreal-editor-for-fortnite) documentation.

[![example of the spatial profiler map](https://dev.epicgames.com/community/api/documentation/image/2c575d7a-116f-43b5-b048-714edb0b7e06?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2c575d7a-116f-43b5-b048-714edb0b7e06?resizing_type=fit)

## Changes to Effects in Verse

With 30.00, the effect lattice has been broken down into a finer granularity, adding the `reads`, `writes`, and `allocates` effects. Broadly, these indicate whether a function (or class) has a dependency on the heap or anything else not explicitly mentioned as an input. Additionally, `allocates` is required for functions that instantiate `unique` classes. These effects are orthogonal to `decides` and `computes`.

With this change, many math functions in `Verse.org` and `UnrealEngine.com/Temporary/SpatialMath` have been updated from having the `varies` effect to having both `computes` and `reads` effects. There are currently things that still have the `varies` effect and we will eventually start migrating other methods to have the more specific effects, but these will be backward-compatible.

The API documentation will also be updated to reflect these changes. The following are the updated definitions:

- **`varies`**: This effect indicates that the same input to the function may not always produce the same output. The `varies` effect also indicates that the behavior of the function is not guaranteed to stay the same with new versions of its containing module.
- **`reads`**: This effect indicates that the same inputs may not always produce the same output. The behavior depends on factors external to the specified inputs, such as memory or the containing module version.
- **`writes`**: This effect indicates that it may change values in memory.
- **`allocates`**: This effect indicates that it may instantiate an object in memory. Allocating `unique` classes requires the `allocates` specifier.
- **`transacts`**: This effect implies the effects `allocates`, `reads`, and `writes`.

## New Devices, Weapons, and Items

### New Devices

There are several new devices this release:

- **[War Bus Spawner](https://dev.epicgames.com/documentation/fortnite-creative/using-war-bus-spawner-devices-in-fortnite-creative):** An armored battle bus, but with the ability to fire a burst EMP in the area around it that can disable other vehicles.
- **[Healing Cactus](https://dev.epicgames.com/documentation/fortnite-creative/using-healing-cactus-devices-in-fortnite-creative):** Creators can configure who it heals, its visibility, and its growth.
- **[Vehicle Service Station](https://dev.epicgames.com/documentation/fortnite-creative/using-vehicle-service-station-devices-in-fortnite-creative):** The station can both repair and refuel vehicles, and additional options are available for damage, health, visibility, and use by team and/or class.
- **[Zipline Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-zipline-devices-in-fortnite-creative):** These are now available when creating LEGO® Islands, giving your players fun and interesting ways to traverse the environment.

### Device Updates

There are major updates to the Third Person Controls (Control: Third Person) device and the VFX Spawner device. For smaller updates and bug fixes, see the [30.00 Fortnite Ecosystem Updates and Release Notes](https://dev.epicgames.com/documentation/en-us/fortnite/30-00-fortnite-ecosystem-updates-and-release-notes-in-creative-and-unreal-editor-for-fortnite) section below.

**Third Person Controls Device**

- The new option **Turn Speed Multiplier When Sprinting** allows you to set how quickly the player turns on a radius. A lower multiplier means the player turns more slowly and a higher multiplier means the player turns faster.
- Players can now break out of auto-targeting when using twin stick controls by moving the right stick or mouse after they have locked on to a target.
- Items and Weapons that target allies are now included in auto targeting behavior.

**VFX Spawner Device**

- This device now uses Niagara systems instead of the older Cascade system.
- The Cascade system has been deprecated.
- Redundant systems, like colored lanterns, have also been deprecated.
- You can now assign custom colors with the VFX Spawner.
- Some effects were renamed with more accurate names.

### New Weapons

- Enhanced Hand Cannon
- The Machinist's Combat Assault Rifle
- Ringmaster’s Boom Bolt
- Boom Bolt
- Megalo Don’s Combat Shotgun
- Combat Shotgun
- Megalo Don’s Nitro Fists
- Nitro Fists

### New Items

- Nitro Splash

## Community Issue Fixes

The following list of fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed issues with asset localization after loading registry data.

  - [Forum Issue Report](https://forums.unrealengine.com/t/asset-localization-dose-not-work-from-v28/1504811)
- Directional inputs now work correctly on PlayStation.

  - [Forum Issue Report](https://forums.unrealengine.com/t/input-trigger-device-input-bug/1733867)
- When using Control Rig, the **Spring interpolate (Quaternion)** node now works correctly.

  - [Forum Issue Report](https://forums.unrealengine.com/t/unable-to-use-quaternion-spring-interpolation-in-control-rig/1315764)
- Added error messaging to indicate when islands are beyond the Verse Persistence size limit.

  - [Forum Issue Report](https://forums.unrealengine.com/t/map-is-unplayable-after-todays-update/1795616)
- Players joining a game in progress now correctly spawn at the start of the next round.

  - [Forum Issue Report](https://forums.unrealengine.com/t/critical-when-join-in-progress-is-set-to-spawn-next-round-players-still-spawn-before-the-next-round-when-they-join/1795529)
- Fixed an issue that prevented audio from playing after a game started.

  - [Forum Issue Report](https://forums.unrealengine.com/t/no-sound-after-the-game-starts/1818300)
- Child actors now correctly transform when the parent actor is transformed or moved.

  - [Forum Issue Report](https://forums.unrealengine.com/t/child-devices-no-longer-move-with-there-parents-since-29-40-update/1838187)
- Enums now support 32 bits, expanding the amount of enums allowed in a project.

  - [Forum Issue Report](https://forums.unrealengine.com/t/enum-with-256-elements-crashes-uefn/1534502)
- UEFN Content Service now correctly displays Verse runtime errors.

  - [Forum Issue Report](https://forums.unrealengine.com/t/uefn-content-service-shows-no-verse-runtime-errors/1846669)
- Fixed an issue where GetTransform() on an empty property crashed the server.

  - [Forum Issue Report](https://forums.unrealengine.com/t/verse-gettransform-on-empty-property-crashes-the-server/1773534)

## Creative and UEFN Updates and Fixes

**Fixes:**

- Skeletal mesh animations that use montages now trigger correctly.
- Scrolling on the Island Settings tab now works correctly.
- Fixed an issue where weapon mods did not properly display in published islands.
- Fixed a few issues for LEGO® islands:

  - Neighbor tiles no longer get destroyed when placed with the Phone tool.
  - Fixed an issue in which trying to use the phone tool to place something inside of the volume of a Campfire device would affect placement.
  - Locker emotes now work correctly.

### Devices

**New:**

- The user interface for the **Mod Bench** device has been updated to match the new version from Battle Royale.

**Fixes:**

- The **Third Person Controls** device is now correctly re-applied to the player after the player has been eliminated inside a vehicle.
- The **Third Person Controls** device effect is now correctly removed when a player is eliminated.
- When placing a **Patchwork LFO** device, the cable head now oscillates on initial placement instead of after first action.
- When holding a Patchwork cable and leaving an island, the cable will now be returned to the device.
- Fixed the **Round Settings** device incorrectly disabling join-in-progress.
- The **Advanced Storm Controller Beacon** device now correctly functions when playtesting.
- The **Advanced Storm Controller** device now correctly activates the safe zones to update the minimap.
- Fixed an issue with the **Mod Bench** where changing a player's class or team during a game didn't correctly update the interaction UI.
- Fixed an issue with the Barrier and VFX Spawner devices where ignoring class and team settings would not function correctly until the game refreshed.
- Fixed the **Additive Color** option on the VFX Spawner device not using the correct picker.

## UEFN Updates and Fixes

### Animation and Cinematics

**New:**

- Sequencer now accounts for non-zero playback start times when trimming/splitting sub-sequences.
- Added Queue Animations, which perform better when multiple animation transitions occur in one frame.

**Fixes:**

- Fixed the evaluation of motion vectors using the custom task scheduler.
- Weighted blendables no longer incorrectly duplicate when included in a camera animation.
- Sequencer now correctly handles multiple instances of a sequence playing audio at the same time.
- Sequencer now correctly invalidates everything in the sequence when restoring a pre-animated state.
- Fixed an issue where female character NPCs crossing their arms were not animating correctly.

### Devices

**New:**

- On the **Day Sequence** device, the **Maximum Volume** slider range now goes to 2500, and there is no longer a preset max value for the range.
- Unavailable options in the **Skydrome Volume** device are now hidden instead of disabled to prevent confusion.
- Unavailable options in the **Fire Volume** device are now hidden instead of disabled to prevent confusion.

**Fixes:**

- Patchwork devices now correctly show the green and red backdrop of the enable/disable toggle.
- Fixed a bug that caused the **Day Sequence** device to disable too early when the player was eliminated inside the trigger volume.
- Fixed an issue with the **VFX Powerup** device that caused custom VFX on players to not display correctly for users that joined a game in progress.
- Fixed an issue with the player XP widget showing level -1 in unpublished UEFN islands.

### UEFN Editor

**New:**

- Optimized editor startup time when Editor Preferences tab is left open.
- Added a Content Browser filter to show only the assets that are not being used but are part of the project. This is useful to help clean up your project and manage your assets.
- Game View can now be toggled when in the orthogonal viewport views.
- Shape array properties now show the Title Property in the asset metadata.
- Added a check to make sure your project only has one Island Settings device (multiple instances of the device will cause issues on your island).
- Menu search fields show by default for menus with 10 or more entries. You can adjust this number via the new editor setting **General > Appearance > User Interface**.
- Pressing the **Esc** key will reset an ongoing menu search after you have typed into a menu.
- Reduced the vertical space consumed by the title bar by shortening the min/max/close buttons and decreasing paddings around the buttons.
- The scaling gizmo is now hidden for non-scalable actors.
- UMG animations are now available in UEFN.
- Added support for copy/paste into the Mobility field of the Details panel.

**Fixes:**

- Pilot actor now functions correctly.
- In the Details panel, the progress indicator now resolves and disappears correctly.
- Fixed an issue where widgets on previously set objects did not delete correctly.
- Fixed a Material Editor crash that occurred when trying to restore a previously open shader code tab before shader instances were populated.
- Fixed an issue where actors would be deleted after submitting changes.
- Fixed an issue with actors where assets were incorrectly unloaded.
- Fixed an issue where a `USkinnedMeshComponent` validation error would spam the log with `USkinnedMeshComponent (min LOD validation)`.
- Logging was updated to prevent spam since log spam was not valid and could be misleading.

### Environments, Landscapes, and Lighting

**New:**

- Added the **Allowed Density Range** setting to the Grass Variety landscape. This can be used to prevent a variety from spawning on a given range of grass density (specified as an interval between 0 and 1).
- Made several improvements to flattening a landscape UX:

  - The flatten target value and terrace interval properties are defined in absolute world-space so both the min and max slider values are bound to what that the landscape can actually reach. This means the interval is always valid, regardless of the landscape scale.
  - The preview grid now adjusts in real time when the target value is changed from the slider.
  - Prevented the flatten target value eyedropper tool to validate changes when clicking anywhere outside the viewport or when leaving Landscape Mode.
  - The user setting values in the preview grid can now be saved.
- Added a **Use Legacy Detail Mode** island setting to allow existing UEFN projects to continue to use the legacy detail mode by default.

  - This setting affects actors with the High detail mode set, as that was detail mode previously unavailable.
  - Any actors using the High detail mode should be changed to Epic to preserve the old behavior when disabling the legacy detail mode setting.

**Fixes:**

- Fixed an initialization error in the Local Light Component.

### Materials

**New:**

- When a material is not flagged as Persistent, the material translation DDC is skipped.
- Added the **Automatically set Material usage flags in editor default** project setting to enable/disable making new Materials automatically set usage flags.
- The Material editor now only puts results to DDC after successful translation if the DDC query finished in time, that is, before the full concurrent translation finished. This is to avoid polluting the DDC with the results of small materials that will never be fetched by the DDC because they're faster to directly translate instead.
- Minor material and textures changes to make the Fortnite backpack look more dirty and used.

**Fixes:**

- Added calls `ConditionalPostLoad()` to texture assets referenced by parameters in Material Function when it is loaded, and made sure that `ConditionalPostLoad()` is called on layers and blends from Material Instances when loaded even outside of the editor.
- Added a null check to `FHLSLMaterialTranslator::GetMaterialEnvironment()` to avoid crashing when a referenced Parameter Collection fails to load (no longer exists).
- The Material Instance Editor now automatically disables overrides of CurveAtlas parameters when the new parameter in the new parent references a different Atlas texture (as the original curve would no longer make sense).
- Fixed an occasional crash when trying to create the preview of a deleted expression.

### Modeling

**New:**

- Added support for several new geometry element selections:

  - Weld Tool
  - Displace Tool
  - Split Tool
  - Smooth Tool

**Fixes:**

- Fixed an issue where materials would be lost when using the modeling tools on some meshes.
- Fixed an issue where lumen would not work correctly on meshes created by the modeling tools.
- Fixed an issue where dynamic mesh components would not update their collision preview visualization.

## Verse Updates and Fixes

### Language

**New**

- You can now use `float` as map keys in Verse.
- Added warning messages when using `struct` with non-public members. At a future date, struct will only allow public fields, so you should now use a class for non-public members instead.
- Made the editable attribute work with `type` and `subtype`. Added UEFN support for editable `type` (except for the `any` type which is not allowed as editable by design currently). Example:

  ```verse
        a_class := class<concrete>:
         @editable MyInt:int = 1

        b_class := class(a_class):
         @editable ExtraFloat:float = 1.0

        # This will now display in UEFN and can be changed to anything which has a base of a_class such as b_class in this example.
        @editable
        MyType:subtype(a_class) = a_class
  ```

**Fixes:**

- Fixed an assertion failure that occurred on the game server in some cases when loading a project that contains an optional instance of a `struct`.
- Type system escape using `False:false`. This is more of a problem about sneaking in a data member in a concrete class without giving it a default value.
- Fixed a class that inherits from a class that inherits from a unique interface being considered incomparable.
- Incorrect class codes are now identified and generate an error message. In the following example `False` has no value and neither does `X`, but concrete classes must have default values.

  ```verse
        c := class<concrete>:
            X:false = False:false
  ```

### API

**New:**

- Added Verse support for the new Healing Cactus device.

#### Tools

**New:**

- Updated the Verse Template Selector to be inline with UE5 style.
- When a Verse Runtime error is encountered, the editor will now show a message to let you know that you can stop the session.
