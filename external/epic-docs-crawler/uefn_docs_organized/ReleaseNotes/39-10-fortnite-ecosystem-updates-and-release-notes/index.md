# 39.10 Fortnite Ecosystem Updates and Release Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/39-10-fortnite-ecosystem-updates-and-release-notes>
> **爬取时间**: 2025-12-26T22:53:38.073117

---

The 39.10 release adds new LEGO® NINJAGO® content, including a starter island template and themed assets, and delivers new mobile UI enhancements to support cleaner interfaces on mobile devices. Also included: new Twinkle Terrace Prefabs and Galleries!

## Action Required: Verse API Change for In-Island Transactions

For developers using the experimental release of in-island transactions, we have made a change to the Marketplace module in the Verse API. The `product` class has been renamed to `entitlement`. You will need to update your Verse code for any items you have created, replacing `product` with `entitlement`.

Additionally, the In-Island Transactions feature example and all of the documentation has been updated to account for the entitlement change, if you need additional examples or references.

For 39.10, the experimental flag has been removed for in-island transactions, but publishing will not go live until 39.20 (January 9, 2026).

## Ask Epic: Mobile Development in UEFN — December 18 at 11AM ET

In our upcoming **Ask Epic**, we’ll take your questions on **mobile development** in UEFN. Topics may include how to design and optimize for mobile play, getting started with our recently launched mobile-specific tools (Mobile Preview and Custom Input & Touch Control), working with smaller screens, touch-interface considerations, and more.

Team members will join us **on the EDC forums on December 18 from 11AM to 12PM ET** to answer your posted questions.

You can submit your mobile questions now directly in the [forum post](https://forums.unrealengine.com/t/ask-epic-mobile-development-in-uefn-december-18-11am-et/2681203).

## LEGO® NINJAGO® Assets Are Now Available

Spinning into this launch are NINJAGO assets for you to create ninja-themed LEGO islands.

### Art Template

Kick start your island design with the **NINJAGO Starter Island** template. This art template provides prebuilt environment designs to spark your imagination. The environment structures include brick-built modules that you can add to or disassemble with the Brick Editor.

[![Use the NINJAGO Starter Island template to start building a ninja-themed LEGO island.](https://dev.epicgames.com/community/api/documentation/image/d257ccef-2fc1-4c2a-b737-6976bc6c8560?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d257ccef-2fc1-4c2a-b737-6976bc6c8560?resizing_type=fit)

To learn more about using templates, see [LEGO Templates](https://dev.epicgames.com/documentation/en-us/fortnite/lego-templates-in-fortnite).

### LEGO Styles

Learn the ways of the ninja with four new Ninjago-themed styles for use as NPCs:

- **Earth Master Cole**
- **Fire Master Kai**
- **Lighting Master Jay**
- **Ice Master Zane**

[![Use the NPC Spawner device to create NINJAGO characters as NPCs on your island.](https://dev.epicgames.com/community/api/documentation/image/4c56e374-93b8-4a27-83fc-e9b862589838?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c56e374-93b8-4a27-83fc-e9b862589838?resizing_type=fit)

You can add these LEGO Styles to your island with the [NPC Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite) device.

### Weapons

Immerse players into the action with the NINJAGO Shuriken and Nunchuck weapons.

This launch also introduces the **Fortnite Kinetic Blade**, redesigned to fit Minifigures.

[![Now you can use the Fortnite Kinetic Blade weapon in your LEGO NINJAGO islands.](https://dev.epicgames.com/community/api/documentation/image/f831dd99-1366-411f-aa19-3689a660c396?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f831dd99-1366-411f-aa19-3689a660c396?resizing_type=fit)

### Gallery and Brick Modules

Build your dojo with theme props and brick-built modules. The **NINJAGO Props Gallery** contains training pieces for players to practice their ninja skills. For UEFN projects, you can start building with the **Ninjago Monastery** brick modules and expand with your own designs from the Brick Editor.

[![Use props from the NINJAGO Props Gallery to create training areas for players to practice their ninja skills.](https://dev.epicgames.com/community/api/documentation/image/2dfdd112-c10e-430f-8c0f-edda6a79715a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2dfdd112-c10e-430f-8c0f-edda6a79715a?resizing_type=fit)

To learn more about the available assets, see [LEGO Asset Inventory](https://dev.epicgames.com/documentation/en-us/fortnite/lego-asset-inventory-in-fortnite-creative).

### Brick Editor Updates

This update introduces 23 new bricks in the Brick Editor, giving you more options for creating custom builds. See [Working with the LEGO® Brick Editor](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-the-lego-brick-editor-in-fortnite) for details on these bricks, and explore how they can support your unique creations.

## Debug Commands

To help you efficiently debug your projects, we are committed to adding more debug commands to the Beta Debug Command menu. We've added:

- **Infinite Reserve Ammo****:** Enable or disable infinite reserve ammo.
- **Infinite Magazine Ammo**: Enable or disable infinite magazine ammo.

## Content Browser and Inventory Updates

Check out all the new assets and items available this release!

### New Weapons

- Vengeful Sniper Rifle

### New Prefabs & Galleries

- Twinkle Terrace Tanuki Twinkle Prefab
- Twinkle Terrace Street Prefab
- Twinkle Terrace Floor and Stairs Gallery
- Twinkle Terrace Wall Gallery
- Twinkle Terrace Roof Gallery
- Twinkle Terrace Prop Gallery

### Device Updates and Fixes

##### Fixes

- Fixed an issue where the Reboot Van device user options did not seem to work and materials would flicker.
- Fixed an issue where the Reboot Van device displayed "Not Enough Gold" instead of "Missing Items: ITEM NAME (RARITY)".
- Exposed Henchfan Cosmetics for use in for NPC Character Spawner.
- [General Physics] Fixed a problem with VFX/SFX retriggering on prop collision with Crash Pad devices: Implemented virtual OnBeginOverlap that triggers when an object is overlapping now, but wasn't seen overlapping for over a second. It's a per-object implementation so that objects that are already stuck on the crash pad don't stop other objects from triggering the FX; the overlapping tracks the objects independently.
- [General Physics] Fixed a problem with VFX/SFX retriggering on prop collision with Bouncer Gallery devices. This is the same modification done on the Crash Pad, but for the Bouncer devices.
- [General Physics] Fixed an issue where gliding could appear broken when a player was falling from an elevated teleporter.
- [General Physics] Events are now sent to the Explosive device which triggers an explosion.
- [General Physics] SFX and VFX are now displayed properly for all bouncers of the Bouncer Gallery when a prop activates them.
- [General Physics] Emoting on a moving prop no longer keeps characters in the emote animation.
- [General Physics] Contrails in the Skydive Volume are now visible at all times.
- Fixed an issue where the Air Vent FX played constantly. This also fixed anything that used the FortPhysicsImpulseComponent and that used OnPhysicsImpulseOverlapTriggered.
- Fixed an issue where the Teleporter device did not apply direct velocity (it applied impulse instead).
- Fixed an issue where the Teleporter device was teleporting non-stop.
- Fixed an issue where the Pinball Flipper would rotate abnormally on game start.

## Mobile UI Enhancements

You now have additional tools to create cleaner interfaces for players on mobile devices.

- A new setting in the Cinematic Sequence device hides unused mobile inputs during active cinematics (this is set to Off by default).
- Mobile gameplay inputs (jump, crouch, fire) are hidden while players interact with popups.
- Two new settings in the HUD Controller device feature the ability to **Hide** or **Show** the vehicle UI. The **Fuel**, **Speed**, **Boost** and **Vehicle Health** options have also been added to the Verse API. With these updates, you have the option to add custom vehicle UI using Verse.

  [![You can now use Verse to add custom vehicle UI for players on mobile platforms.](https://dev.epicgames.com/community/api/documentation/image/90f26a4b-e513-4392-8c36-440e0db900c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/90f26a4b-e513-4392-8c36-440e0db900c7?resizing_type=fit)

## New Device Design Examples

- [Visual Effect Powerup Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/visual-effect-powerup-device-design-examples-in-fortnite)

  [![Follow these design examples to learn new ways to use the Visual Effect Powerup device.](https://dev.epicgames.com/community/api/documentation/image/b4b4efb1-f263-438f-8585-462d515b7b29?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b4b4efb1-f263-438f-8585-462d515b7b29?resizing_type=fit)

  These design examples show you how to use the **Visual Effect Powerup** device in your island gameplay to validate player behavior with a visual effect, such as when the player picks up an item or reaches a destination. Use this device to reinforce in-game information, communicate the importance of an event, or make characters sparkle just for fun!

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where the scoreboard was not displaying all of the players on an island.

  - [Forum Report](https://forums.unrealengine.com/t/scoreboard-broken-after-v38-00/2670849)
- Fixed an issue where asset names were failing to display in the memory calculation results summary.

  - [Forum Report](https://forums.unrealengine.com/t/unknown-assets-in-memory-calculation/2651212)
- Fixed an issue with the Save Point device not saving items.

  - [Forum Report](https://forums.unrealengine.com/t/players-lose-all-items-when-leaving-a-game-even-if-the-save-point-device-is-turned-on/2676582)
- Fixed an issue where memory calculation would not launch when using auto-localization

  - [Forum Report](https://forums.unrealengine.com/t/unable-to-launch-memory-calculation/2676027)

## Fortnite Ecosystem Updates and Fixes

##### Fixes

- Fixed the size reduction on large actors when a user selects them with the phone tool.
- The maximum scaling restriction on props has been removed.
- The three large multi-panel doors in the corner of the Classified Canyon Prop Gallery can now be opened and closed with the Lock device.
- Fixed an issue with Lock On Pistol bullets not hitting the locked-on target.
- Fixed the size reduction on large actors when a user selects them using the phone tool.
- The maximum scaling restriction on props has been removed.

## UEFN Updates and Fixes

##### Fixes

- Fixed an issue where some gallery props would revert their materials after being spawned from the quickbar in UEFN.
- Filtered out mesh properties called "Mesh" in the digest.
- [MetaHuman] Fixed a crash that occurred when running calibration generation on monocular footage.
- Entities now collide with actors during drag-and-drop placement in the viewport.
- Removed the word "permanently" from the note about disabling Automatically Build Localization for your project, as you can freely toggle the setting on or off at any point.
- Fixed an issue that was triggering Verse-only pushes while exporting localization data, such as what happens when trying to run the memory calculation.
- When displaying the Island Conversion Failed message box, the raw error message is no longer displayed. Instead, a friendly message instructing the user to look at the Output Log is displayed.
- Fixed an issue where there was potentially inaccurate log spam related to a missing plugin.
- Fixed various issues that occurred when rotating multiple actors that use the Fortnite Grid.
- [Environments and Landscapes] Fixed an issue where objects were translating in the opposite direction than expected when using the Combined Translate and Rotate Mode on the Y-axis.
- [Modeling] Fixed a crash that occurred when using the Modeling Mode Convert tool to convert multiple dynamic meshes to static meshes.
- [VFX] Fixed an issue where SFX and VFX were not reactivated when their network relevancy changed. This typically occurred at the start of a match.

## Scene Graph

##### New

- **Custom Items and Inventories**: In the item component the `StackSize` and `MaxStackSize` variables are now private and must be modified through `SetMaxStackSize` and `SetStackSize` functions.

##### Fixes

- Added an option to create a prefab subclass from the content drawer context menu.
- In the Entity Editor, when selecting multiple entities that have the same asset component (such as each having a mesh\_component that is the same asset), the thumbnail in the Details panel should now show the common asset.
- In the Entity Prefab Editor, added a Group Under New Entity menu item to the context menu.
- In the Entity Prefab Editor, added the ability to create new prefab subclasses from an existing prefab within the editor.
- In the Entity Prefab Editor, clicking on an entity now selects the parent prefab.
- In the Entity Prefab Editor, fixed an issue where Outliner rows were disappearing on autosave.

## Verse Updates and fixes

##### New

- [API] Added Verse class wrappers for Chapter Seven: Season One Items for usage with Custom Items and Inventories.

##### Fixes

- Fixed an issue with items (Custom Items and Inventories) instantiated through Verse not having the correct `StackSize` or `MaxStackSize` after being granted.

## Unreal Revision Control Updates and Fixes

##### Fixes

- Made many performance optimizations, including reducing the frequency of Revision Control status checks, following an investigation into creator reports of unnecessary lags in the user experience.
