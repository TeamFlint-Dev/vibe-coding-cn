# 37.50 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/37-50-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-26T23:14:06.492683

---

Fortnite v37.50 adds the ability to convert your islands into brand islands, a whole host of features and enhancements for your LEGO® islands, and a new LEGO® PvP Extraction Template. There are also some monstrous additions to the Wildlife Spawner device and the Chest and Ammo Gallery, adding pumpkin containers and the ability to spawn hive swarmer bugs from the Hive Stash into the mix!

The Butter Barn Prefab and Galleries have also landed in Creative and UEFN for use in your Islands.

Wanting to attract more fans to your KPop Demon Hunters islands? Say no more! You can now add gold and demon auras to your KPop Demon Hunters islands to really make them pop!

## LEGO® Island New Content and Updates!

This release has several exciting new templates, devices, assets, and more!

### LEGO® PvP Extraction Template

Learn to create player vs player extraction gameplay with the **LEGO® PvP Extraction Template** in UEFN. Jump into the template and launch a session to playthrough the extraction example, then head to the teaching zone that highlights the devices used for the gameplay mechanics.

This template uses features like:

- Custom Verse devices to track player levels, and for players to bank studs after completing objectives.
- An unlock zone system where players must reach a certain level to access new tools.
- Cutscenes for the emergence and extraction points.
- Brick Editor assets for environment design.

To learn more about designing extraction gameplay for your LEGO® Island, see [LEGO® PvP Extraction Template](https://dev.epicgames.com/documentation/en-us/fortnite/lego-pvp-extraction-template-in-unreal-editor-for-fortnite).

### New LEGO® Tools and Items

Expand your LEGO® Islands with new tools and items.

New tools with rarity variants:

- Burst Laser
- CX Pulse Laser
- Pulse Rifle
- Sting Blaster
- Double Saucer
- Good Ol' Trusty
- Kymera
- Snowball Launcher
- Burst Pulse Rifle

New ammo:

- Light ammo
- Heavy ammo
- Shell ammo
- Energy ammo
- Medium ammo (reworked visuals)

New Items:

- Chronosteel Shard
- Diamond
- Mechanical Parts
- Monster Shard
- Pumpkin
- Red Mushroom
- Vampire Tooth

To learn more, see [LEGO® Asset Inventory](https://dev.epicgames.com/documentation/en-us/fortnite/lego-asset-inventory-in-fortnite-creative).

### Over 250 New LEGO® Styles for NPCs

Add more characteristics to your LEGO Islands with over 250 new [LEGO Styles](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#lego-styles),  compatible with the [NPC Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite) device.

### Stat Powerup Device

The [Stat Powerup](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-powerup-devices-in-fortnite-creative) device is now available in LEGO® Islands. You can pair the device with the [Stat Creator](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-creator-devices-in-fortnite-creative) device to design custom statistics (stats), like player levels as shown in the Extraction PvP template.

## KPop Demon Hunters VFX Auras for Objects

You can now add the gold and demon aura visual effects (VFX) to objects in your KPop Demon Hunters islands. The feature set is updated with a static mesh version of the aura VFX. This means you can drag the VFX on to any object in the viewport.

## Convert Your Islands to Brand Islands

Have an existing island you think fits as a [brand island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#brand-island)? You can now easily add your favorite IP content into your islands.

To learn more see, [Converting Your Island into a Brand Island](https://dev.epicgames.com/documentation/en-us/fortnite/converting-your-island-into-a-brand-island-in-fortnite).

## Pumpkin Container

The pumpkin container can now be found in the Chest and Ammo Gallery — ready to use. Perfect for the upcoming spooky season!

[![](https://dev.epicgames.com/community/api/documentation/image/2c7d0b45-4dc9-464d-8fd8-cd39a942de5f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2c7d0b45-4dc9-464d-8fd8-cd39a942de5f?resizing_type=fit)

## Voting Device UI

Add a custom widget to your voting group device, and in your widget, you can bind to the Voting Group ViewModel and Voting Option ViewModel to update your UI from your voting devices in real time.

## New Prefabs & Galleries

Check out all the new items in this release!

- The Butter Barn Prefab
- Butter Barn Floor, Roof and Stairs Gallery
- Butter Barn Wall Gallery
- Butter Barn Props Gallery

[![](https://dev.epicgames.com/community/api/documentation/image/99850ae6-6975-4876-89d3-d48e4cbc59a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/99850ae6-6975-4876-89d3-d48e4cbc59a9?resizing_type=fit)

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where the Scout and Overlord Spires were ignoring certain effects.

  - [Forum Report](https://forums.unrealengine.com/t/some-items-can-not-hit-the-spires-in-certain-ways/2645123)
- Fixed an issue where Unreal Revision Control (URC) was failing.

  - [Forum Report](https://forums.unrealengine.com/t/revision-control-check-in-fails-with-warning/2652878)
- Fixed an issue where activating the do not close on button press setting inside the Pop-up Dialog device was not behaving as expected.

  - [Forum Report](https://forums.unrealengine.com/t/pop-up-device-do-not-close-on-button-press-bugged/2633708)
- Fixed an issue where the flashlight does not function as expected in first-person perspective.

  - [Forum Report](https://forums.unrealengine.com/t/player-cant-use-the-flashlight-as-expected/2655815)

## Fortnite Ecosystem Updates and Fixes

Fixes:

- VFX Pickaxe CadetFrog: Fixed the TOD night yellow color so that impacts are now non-directional.
- VFX Emote LanternStroll: Edited material to reduce artifacting, and adjusted daytime brightness.

## Device Updates and Fixes

New:

- Added Ash VFX from Fortnitemares Haunted POI to VFX Spawner Device.

Fixes:

- Ch5 Time of Day Manager: Identified and removed a fog start distance value that prevented fog from appearing closer than 100 meters to the camera, affecting medium and low platform scalabilities. This fix allows creators to adjust the fog settings through the Day Sequence device and visualize fog closer to the camera across all platforms. It's recommended that you balance fog density and max opacity, and dial to taste while adjusting viewport scalability in UEFN.
- Fixed an issue where Guards / AI couldn't pass through shield bubbles.

## UEFN Updates and Fixes

Fixes:

- The Impulse on Hit Multiplier option now correctly disables when Impulse on Hit option is disabled.
- Stopped changing the rendering mode when resetting to defaults in the settings screen.
- Tamed Hive Lobbers from the Wildlife Spawner now show the expected overhead icon that conveys that they are tamed.

## Verse Updates and fixes

Fixes:

- No more Verse and json files being added in sys folder under UEFN project directory.
- Verse vectors are now copy / pasted in engine format.
- The Verse compiler now errors when initializing a field after calling a delegating constructor in an archetype expression. This fixes missing validation, and now correctly enforces Verse’s object construction semantics.

For example, the following is now a compiler error:

```verse
base_class := class:
    # base_class fields

MakeBaseClass<constructor>() := base_class:
    # base_class initializers

derived_class := class(base_class):
    Field:int

MakeDerivedClass<constructor>() := derived_class:
    MakeBaseClass<constructor>() # Delegating constructor call

    # Error 3690: All field initializers must come before
    # constructor calls in archetype instantiation.
    Field := 42
```

The fix for these errors is to move the delegating constructor call below all field initializers - move `MakeBaseClass<constructor>() below Field := 42`.

Live islands will still function as they are, but you will need to fix your object construction semantics using the method above to republish.

## Unreal Revision Control Fixes

Fixes:

- Fixed an issue where 'Check-In Changes' sometimes failed without any error reported back to the user.
- Fixed an issue where 'Resolve Conflicts' sometimes failed because a file was still in conflict.
- Fixed an editor stall that would last until VS Code was closed.
