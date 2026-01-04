# 37.00 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/37-00-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-26T23:14:17.227913

---

Fortnite v37.00 adds the Fortnite Tools Mode to the UEFN editor, the beta version of new Debug Commands, One File Per Entity to make collaboration easier, new Spire devices for boss fight gameplay, and tons of new weapons, assets and items!

## Heads-Up: Property Validation Warnings Are Now Errors

Starting in v37.00, changing certain hidden properties from their default values will now result in validation **errors**, **not just warnings**, preventing you from publishing your island.

What this means:

- You will no longer be able to publish new or updated islands that use these properties.
- Islands that are already live cannot be updated if these validation errors are present.

To resolve the validation errors, you must use the default values for the following properties:

- bVisibleInRealTimeSkyCaptures
- bReceiveMobileCSMShadows
- bCastDistanceFieldIndirectShadow
- bSelfShadowOnly
- bTreatAsBackgroundForOcclusion
- CastRaytracedShadows

Alternatively, you can stop using the listed properties. If you’re still having issues, please let us know in [this forum thread.](https://forums.unrealengine.com/t/minimum-and-maximum-values-of-user-device-options-creator-suggestions/2633628)

## Coming Soon: Publish Your Squid Game Islands in Fortnite!

Get ready! Starting August 14 at 9 am ET, you can publish your Fortnite islands featuring Squid Game-themed assets! If you’ve created a Squid Game-inspired island, you can now submit it through the Creator Portal and schedule it to go live when publishing opens.

Squid Game islands will be taking the spotlight in Discover with a dedicated Game Collection, following the approach used for previous IP rollouts. Netflix, the IP holder, will also curate a special **Squid Game Picks** row showcasing a diverse lineup of their favorite Squid Game islands.

That’s not all! Squid Game islands will be eligible for additional Discover placement, including Epic’s Picks, so be sure to [submit yours](https://creative.fortnite.com/s/?lang=en-US) for feature consideration.

### Last Call: Squid Game Island Conversions!

Submit your UEFN island by August 12, 9 am ET to request conversion. [See here for details](https://www.epicgames.com/help/c1/a000095080) on how to start your conversion.

## Heads Up: User Options Will Be Locked to Set Minimum and Maximum Values

In an upcoming release, we will be locking user/device options within UEFN and Creative to stay within their existing minimum and maximum values (when a minimum or maximum is shown for that user option). Any option values that are below the minimum will be set to the minimum value, and any above the maximum will be set to the maximum value. This will apply to user/device options in previously published islands.

While you might find ways to make the UI display a user/device option value that is outside of the minimum/maximum range, when the user/device option is loaded on the client it will be reset to be either the minimum or maximum value of that option's range.

If there are any user/device options creators feel need to have their minimum or maximum values changed, please post in the Fortnite [Feedback & Requests forum](https://forums.unrealengine.com/tags/c/feedback-requests/50/fortnite).

Here’s what you need to know:

- The changes to the minimum and maximum values for user/device options won’t arrive until v38.00 at the earliest.
- We’re doing this because some islands that exceed intended limits are crashing or causing performance issues, which isn’t a great experience for players.
- We will expand the minimum and maximum values for many user/device options, based on data and your feedback, before locking the values.
- We’ll give you a heads up in advance when we have a final date so you can make any necessary adjustments.

## New Fortnite Tools Mode in UEFN

New in v37.00, there is a viewport mode called Fortnite Tools. In this mode, several new level-building tools are available that help speed up your workflows. These tools are used internally at Epic to create Fortnite, and now they are available to all creators in UEFN!

In this first release, there are four tools — from a simple **Helper Assets** tool to a sophisticated **Travel Time** tool. The **3D Select** tool greatly speeds up selecting groups of objects (such as buildings) and the **Snap To Target** tool allows quick duplication and placement of selected objects. See [Fortnite Tools](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-tools-mode-in-fortnite) for more information!

## New Debug Commands Menu Beta

Runtime debugging is an important requirement for creator quality of life. That’s why we are releasing a Beta version of the new Debug Commands menu now so we can get this into creators’ hands as soon as possible. This tool provides a consistent and simplified interface for triggering any runtime debugging.

Three commands are included in this release:

- **Spawn Test Players**: Spawn the specified number of test players, up to the Max Players, as defined by your island settings.
- **Despawn Test Players**: Removes the most recently spawned test player as if they were a player who left the session.
- **Eliminate Nearby AI**: Eliminates all Guards, Wildlife, Creatures, and Sentries within X meters.

In future releases, more debug commands will be added. As the number of commands increases, features will be added to improve searching, triggering, and feedback.

Creators can access the Debug menu in either a Fortnite Creative or a UEFN editing session after starting the game. Press **Esc** to open the sidebar, then look for the **DEBUG COMMANDS** button above **END GAME**.

We look forward to your feedback. Let us know what debug commands you want most by completing our **Creator Most Wanted Debug Commands Survey**–you'll find it pinned in our official forums under **Feedback & Requests** [here](https://forums.unrealengine.com/t/fortnite-creator-most-wanted-debug-commands-aug-2025/2623988).

## Easier Collaboration on Scene Graph Projects with One File Per Entity (OFPE) Beta Release

**One File Per Entity (OFPE)** for Scene Graph projects is now in Beta. Until now, edits to Scene Graph entities would lock the entire project file if you were using Unreal Revision Control (URC), making collaboration very difficult. By saving each entity in a separate file, OFPE enables multiple collaborators to work in parallel on projects using SceneGraph with fewer conflicts.

You can choose to enable OFPE in **Project Settings**.

## DirectX 12 Performance Mode for PC

We're rolling out DirectX 12 Performance Mode on PC, as a replacement to the existing DirectX 11 Performance Mode. This new rendering mode will offer a performance increase and improved stability on certain configurations. It uses APIs that work better with modern PC hardware, and benefits from up-to-date driver support.

The old Performance Mode remains available as a legacy option. We encourage users on PC to switch to the enhanced DirectX 12 Performance Renderer, for smoother gameplay and more stable frame rates.

This DirectX 12 Performance mode is only for the Fortnite client. It does not affect UEFN, except for sessions launched in the Fortnite client.

To switch to the new mode in game, press **Esc** to open the **Sidebar** menu and click the **gear** to open User Settings. Go to **Video Settings > Rendering Mode** and choose **Performance**.

We'd like to hear [your feedback](https://forums.unrealengine.com/tags/c/feedback-requests/50/fortnite) on this new option as we continue to refine and improve DirectX 12 Performance Mode.

## User Interface Feature Template Updates

The **User Interface Feature Template** island has new UI examples and assets you can use in your own projects. There are expanded halls featuring the latest UI inclusions and updates. Open the User Interface Feature Template in UEFN to learn how to create **quickbars**.

Browse through the assets to find the new meter materials, explore the new Close button capabilities in the [Pop-Up Dialog device,](https://dev.epicgames.com/documentation/en-us/fortnite/using-popup-dialog-devices-in-fortnite-creative) and you can now use up to 12 buttons in a dialog!

Check out the **Verse UI** section of the template to learn more about using **text\_size** and **material\_block** to create a unique UI with Verse.

Check out the [User Interface Feature Template document](https://dev.epicgames.com/documentation/en-us/fortnite/user-interfaces-feature-template-in-unreal-editor-for-fortnite) to read more about these new features.

## UEFN Memory Calculation Updates

As of v37.00, UEFN now calculates memory usage using data generated at cook time instead of driving the player around the island to sample usage. This update brings several improvements:

- Faster results on large islands.
- Consistent numbers when running calculations on the same island version, Fortnite build and device.
- Expanded support for more asset types and for Scene Graph.

Due to this change, memory usage values for islands will differ from previous versions. While the majority of islands should still remain below the 100,000-unit threshold, some may require optimization before they can be re-published.

Until the release of v37.10, you will be able to publish islands even if they exceed the memory limit. However, to submit new versions for publishing after v37.10, you will need to bring your island’s memory under the limit.

Published islands that are over the memory cap may experience performance issues on low-end devices, and we may manually remove outlier islands that create severe performance issues to ensure a good experience for players.

## New CH6 S3 Spire Devices

Creators will now be able to bring Spire gameplay to their islands using the new **Overlord Spire** device, **Scout Spire** device, and **Spire Spike** device.

The Spire Spike is an environmental prop that drops loot when destroyed, and can be customized to knockback players. The Scout Spire is a mini boss-like environmental encounter. The Overlord Spire is a full boss-like environmental encounter. Both are highly configurable, and you can use events and functions to drive full NPC encounters.

If you love these devices, be sure to let us know by sending us [feedback in the forums](https://forums.unrealengine.com/tags/c/feedback-requests/50/fortnite) — we want to get you the stuff you want, not the stuff you don't. We’re excited to see what you can do with these devices, so make some cool boss fights!

## Content Browser and Inventory Updates

Check out all the new items available this release!

### New LEGO Template Prefabs and Galleries

- Seaport City Galleries and Preabs
- Japanese Dojos Galleries and Prefabs
- Ch6 Nature Galleries

Fencing Fields and Crime City prefabs and galleries on LEGO Islands are currently causing island validation to fail, preventing islands with these assets from successfully launching.

A fix for this issue is currently planned for 37.10. Until then, we advise you to avoid using these assets in your LEGO Islands.

### New Weapons

- Bug Blaster
- Swarmstrike
- Eradicator Shock N’ Slow Shockwave Launcher
- Shockwave Launcher
- Eradicator O.X.R. Rifle
- O.X.R. Rifle
- Leadspitter 3000
- Double (shotgun)
- Trouble (shotgun)
- Sweeper Shotgun
- Wrecker Revolver
- Enhanced Assault Rifle

### New Items

- Exotic SlapBerry Fizz
- Epic Slurp Juice
- Epic Launch Pad (trap)
- Epic Launch Pad (item)

## New or Updated Documentation

The **Project Organization** page has a new name, [Starting and Organizing a Project](https://dev.epicgames.com/documentation/en-us/fortnite/starting-and-organizing-a-project-in-fortnite). The document covers everything you need to know about creating projects and organizing your project content. Learn how organization can make you a more efficient developer and establish consistency on team projects.

The new [Levels](https://dev.epicgames.com/documentation/en-us/fortnite/levels-in-fortnite) page has everything you need to know about creating and using new levels in your project. This page also includes information on how levels can be used for prototyping game mechanics, and more.

Create a unique-looking UI using a **Material Block** in Verse! Learn how to use UI materials and the `material_block` to create dynamic looking UI. The [Material Block page](https://dev.epicgames.com/documentation/en-us/fortnite/material-block-in-fortnite) walks you through using material instances and the steps to creating UI with the `material_block` property. The document includes code blocks you can copy into your own project.

## Improved Text Localization Options

Previously when using the **Text Localization** feature in UEFN you were unable to edit the translations that were automatically generated for your island. Now you can directly edit the PO files exported for your project, either directly on disk or using the Content Browser in UEFN. This enables you to provide custom translations, or to edit the translations provided by auto localization.

PO is a common format, and can be edited locally either by hand or with a translation tool like [Poedit](https://poedit.net/), or collaboratively via something like [Smartling](https://www.smartling.com/) or Crowdin (verify your “PO Format” export setting if using Crowdin).

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue with the Octane vehicle behaving incorrectly.

  - [Forum Report](https://forums.unrealengine.com/t/issue-of-octane-vehicle-movement-speed-after-last-uefn-fortnite-update/2548041)
- Fixed an issue where the Score Manager device score UI would stay on screen.

  - [Forum Report](https://forums.unrealengine.com/t/score-manager-score-ui-stuck-to-my-screen-and-does-not-go-away/2546233)
- Fixed an issue where inventory images were decreasing in size when the client window was resized.

  - [Forum Report](https://forums.unrealengine.com/t/player-resource-inventory-shrinking/2071801)
- Fixed an issue where the Launch Pad was not being granted by item granter.

  - [Forum Report](https://forums.unrealengine.com/t/launch-pad-not-being-granted-by-item-granter/2249636)

## Fortnite Ecosystem Updates and Fixes

#### New:

- Added support for variable periods of Health/Shield/Overshield regeneration, which is configurable in Island Settings, the Class Designer device, and the Team Settings & Inventory device.

  - Increased the default application period from 0.2 seconds to 1 second.
  - Increased the default application amount from 1 to 5.

#### Fixes:

- Fixed an issue where users could create the same island multiple times after approving the island's name due to a delay in the menu closing. This could have resulted in duplicate islands that didn't function correctly.
- Fixed an issue where creators could place prefabs/galleries outside the Creative map boundary.
- Fixed a typo in the Lawless Final Mark Rifle.
- Fixed an issue where the Surf Cube was not fully compatible with third-person controls.
- Fixed an issue where players could push each other through walls with the Shove item.
- Fixed an issue where pressing the left trigger on the gamepad would paste and scale a preview. The left trigger is now used exclusively to access the quickbar when held.
- Fixed an issue where collide with copies didn't work with Terrain mode collision for actors and entities.
- When enabling the Top Center Scoreboard HUD in Island Settings, it will now take into account anything other than Score used as the Stat to End, displaying the goal and current team score values as appropriate.

## Device Updates and Fixes

#### New:

- Added a new style option to the Supply Drop Spawner to allow the spawning of Drop Pods. Drop Pods behave similarly to existing supply drops with two key differences:

  - The drop pod persists on the island after it has been opened.
  - The drop pod can be damaged, and will release its contents when destroyed.

  To support this, the device has a new function **Destroy Spawned Drops** to destroy any drop pods or crates previously spawned by the device, and a new event **On Crate Destroyed** to detect when a drop pod or crate has been destroyed.
- Added a new military-style chest to the Chest & Ammo Gallery.
- Added a **Close** button to the Pop-Up Dialog device options, and increased the maximum number of buttons from 6 to 12.
- Added a Verse API for the Voting Group and Voting Options devices.
- Added user option to the Team Settings and Inventory device to Allow/Prevent impulsing teammates.
- Added 145 approved character outfits in Creative and UEFN, usable with the following devices:

  - Character device
  - Character Controller device
  - Dance Mannequin device
  - Guard Spawner device

#### Fixes:

- Earth Sprite fixes:

  - Fixed an issue where the Earth Sprite idle animation did not loop.
  - Fixed an issue where the Earth Sprite head would not look forward when it was not tracking a player.
- Fixed an issue where the Earth Sprite played the belch montage once it turned visible, after it dropped a weapon while it was invisible.
- When using a disguise set to random, respawning would cause the disguise to re-randomize even if the **Replace Existing** option was set to **False**. Now a player will respawn with the same random outfit they had.
- The Post Process device effects of **Film Noir**, **Sepia**, **Desolate**, and **Horror Movie** are now consistent on all devices and consoles.
- In the Elimination Manager, **Score** removed from a player now reflects as intended the **Penalty Amount** displayed.
- The Launch Pad is now granted by the Item Granter as expected on a published island.
- Players in vehicles will no longer take damage from props moved with the Prop Mover device.
- Non-interactable objects acting as props are no longer highlighted when aimed at by the Prop-o-matic.
- When teleporting and spawning items with the Item Spawner using Verse API, the item or weapon is now spawned on the correct position according to where the device base is.
- A hologram of the item can now be seen above the Item Spawner in edit mode.

## UEFN Updates and Fixes

#### New:

- Increased performance when handling input from mice with high polling rates.
- Added the new sum cell reduction method for the Spatial Profiler.
- Added line trace unit nodes to Control Rig.
- Added two new ways to spawn at different locations when launching a UEFN session:

  - A **Spawn at Viewport Camera** checkbox, which will spawn the player at the UEFN viewport camera location in edit mode and play mode.
  - A **Start Game from Here** (**Launch Session and Start Game From Here** if not connected to a server yet) option, which will launch the session if unconnected and enter play mode at the spot that is right-clicked.
- Added support for validating UTexture2DArray types.
- Added warnings for asset names that are not valid Verse identifiers when you save or validate a UEFN project.
- Updated projects to render unique icons for **owned source** and **referenced read-only** modules respectively.
- Added Performance mode using DirectX 12, and renamed existing Performance mode using DirectX 11 to Legacy Performance.
- Made the Auto-Set Quality button visible when Rendering Mode is set to Performance.
- Resize Texture Import Data now works on Texture2DArray assets.
- Exposed more mesh component properties in UEFN:

  - bDisallowNanite
  - bRenderInMainPass
  - bRenderInDepthPass
  - BoundsScale
- Added Subpixel Morphological Anti-Aliasing.

#### Fixes:

- Fixed an issue with the **collide with copies** option for entities.
- Fixed an issue where billboard backgrounds were hidden in edit mode for the Detonation Feature Example.
- Fixed an issue where the rotation axis visuals on preview didn't reflect the rotation applied on entities.
- Fixed an issue with the user having access to the resize UI when multiselecting an actor and an entity on mobile.
- Fixed an issue where the bounds of an entity preview were not attached to the center of it.
- Fixed an issue occurring with devices containing a list of items when spawned from the quickbar. The issue with the list of items always appearing to be empty on the editor has also been fixed.
- Fixed a problem with renaming issues when opening multiple outliners.
- Fixed an issue where data validation for catalog offers always returned successfully, even when there was a data validation error.
- Fixed an issue where the **Triangulate Curves** tool could sometimes fail to correctly triangulate closed splines.
- Fixed a crash that could occur for large grid dimensions in the Vox Offset algorithm.
- Fixed a crash that could occur when running a cluster simplify on a mesh with partially set UVs.
- Fixed an issue where tools in Modeling Mode would not tick if the viewport had not previously received focus for the current editor session.
- Fixed an issue where the **Triangulate Curves** tool ignored the join method for closed curves.
- Fixed an issue that prevented the UV Editor menu entry from showing if any invalid components were present on the selected actor(s).
- Fixed a crash occurring when creating a new empty level with vertex snapping enabled.
- Fixed a Physics Experimental issue causing a wrong rotation axis when using **simd** for the linear joint solver.

### Known Issues

- There is a known issue where certain outfit VFX blocks player vision when in first-person mode. We are investigating a fix and will provide an update soon.
- There is a known issue around Underground and other first person weapons alongside the Shadow Flopper, where the player model is duplicated. If you respawn, the duplicate model is removed. We are investigating a fix and will update soon.

## Physics

#### Fixes:

- Props are now affected by pickaxe hits in the UEFN/Creative edit mode.
- Regular props are now not knocked back by the explosive device.
- Users now spawn with the skydive animation when spawning inside the Skydive volume device with physics enabled.
- Physics objects no longer resimulate when impulse.
- The grenade launcher now applies force to the pawn upon explosion.
- Impulse should now be applied with projectile weapons and explosive weapons.
- Players no longer fail to enter the skydiving state in the Skydiving Volume.

## Scene Graph

#### New:

- Improved the code for the EntityEntered event example in the **Scene Graph Feature Example**.
- In the entity prefab editor, entities may now be dragged onto their parents, attaching them to the prefab root.
- Added a boolean for MoviePipelineFunctionalTestBase to toggle screenshot comparisons.

#### Fixes:

- Fixed selection issues in the entity prefab editor when the user switched editor modes in the level editor.
- Fixed an issue where entity prefabs would not reinstance properly.
- Multiple fixes:

  - Removed an extra demo display outside of the level.
  - LightPost examples are now all prefabs.
  - Improved code for the Spawning Prefab example.
  - Updated the lantern interact component to have TurnOn and TurnOff methods.
  - Fixed the offset of the collision capsule in FindOverlapHits example.

## Verse Updates and Fixes

#### New:

- Created the `<castable>` tag.

#### Fixes:

- Fixed a bug related to the Sleep function.
- The attribute `<localizes>` is not allowed on local variables, and the compiler now recognizes that. This code will not compile:

  ```verse
  a := class:
    DefaultText<localizes>:message := ""
  b := class: 
    MakeA():void=
      A:a = a{DefaultText := SignMessage<localizes>:message := "+"}
  ```

  This example shows the correct way to instantiate a variable with the `<localizes>` attribute:

  ```verse
  a := class: 
    DefaultText<localizes>:message := ""
  b := class: 
    SignMessage<localizes>:message := "+"
    MakeA():void=
      A:a = a{DefaultText := SignMessage}
  ```

## Unreal Revision Control Updates and Fixes

#### New:

- Improved messaging when a project has invalid Source Control settings.

#### Fixes:

- Fixed an issue that caused a **No files staged for commit** error on check-in if Unreal Revision Control was turned off during project creation and then subsequently turned on.
- Fixed an issue that caused the editor to crash when checking in changes.
- Fixed an issue in which restoring an older snapshot could sometimes trigger a **failed to load fragment payload** error.
- Fixed an issue that caused the **Checking for assets to check in** notification to stay open for longer than needed upon starting the Check-in Changes process, and closing upon submission rather than as soon as the submit dialog loads.
- Fixed an issue in which resolving Verse file conflicts reset the **Mine/Theirs** selections you may have already made for the remaining assets in the conflict resolution dialog.
