# 34.40 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/34-40-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-27T00:34:05.828813

---

The v34.40 update introduces the Armored Transport spawner from Fortnite Battle Royale,  Rebel’s Roost prefabs and galleries, and new characters and tools for those creating Teenage Mutant Ninja Turtles islands. Plus, don't forget to update your islands to the Chapter 5 Time of Day Manager before the legacy lighting system is retired on May 2!

## Skydome and Legacy Time of Day Manager Will Be Deprecated at 35.00

This is your final reminder to update your UEFN and Fortnite Creative islands to the Chapter 5 Time of Day Manager (TODM) lighting system. The legacy Time of Day Manager and Skydome device will be retired with the v35.00 update on May 2, 2025.

This change affects islands currently using the Skydome device to create custom lighting. After the device is deprecated, all islands using the Skydome device will retain their gameplay, volume data, and positional data, but lighting will default to the Chapter 5 TODM lighting and ignore any settings used with the Skydome device.

If you have not done so already, upgrade your islands to use the Chapter 5 TODM system with the [Day Sequence device](https://dev.epicgames.com/documentation/en-us/fortnite/using-day-sequence-devices-in-unreal-editor-for-fortnite). You can learn more about how to use the device effectively with the [Day Sequence Starter Island Template](https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-starter-island-template-in-unreal-editor-for-fortnite).

After the Chapter 5 TODM goes into effect, you will no longer be able to publish new islands or republish existing ones that use the Skydome device.

Converting your island to the new TODM is a **one-way conversion**, so back up your island before upgrading your islands.

## Teenage Mutant Ninja Turtles Refresh!

With this release, there are some rad updates to TMNT islands! First, four new characters have joined the TMNT pizza party: Casey Jones, Bebop, Rocksteady, and Krang. Check them out in the Character, Guard, and NPC Spawner devices!

[![](https://dev.epicgames.com/community/api/documentation/image/ce8cf47e-5812-438a-b36a-33c99f13bf6f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce8cf47e-5812-438a-b36a-33c99f13bf6f?resizing_type=fit)

It’s not just these new foes who are available–now you can get all the TMNT character outfits in the Character, Guard, and NPC Spawner devices!

We’re also introducing the Dimension X Starter island template, which provides an out-of-this world landscape that is the perfect starting point for building multi-dimensional TMNT UEFN adventures. Sculpt the barren landscape and place pools of ooze beneath the swirling skies of outer space!

Lastly, want to add some TMNT flair to existing Fortnite prefabs? You can now use textures from the Graffiti Wall gallery with the [Decal device](https://dev.epicgames.com/documentation/en-us/fortnite/decal-device-in-unreal-editor-for-fortnite) in UEFN.

Check out [Working with TMNT Islands](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-tmnt-islands-in-unreal-editor-for-fortnite) for more information!

[![](https://dev.epicgames.com/community/api/documentation/image/f4c00d80-c031-44fe-a553-2b33404f2993?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f4c00d80-c031-44fe-a553-2b33404f2993?resizing_type=fit)

## Guard NPCs Can Now Wield Lucille!

You can now assign the hero weapon Lucille to Guards in the NPC Spawner and Guard Spawner devices on The Walking Dead Universe islands! To get your guards fending off Walkers, you can:

1. Guard Spawner Device: Select Lucille from the Item List.
2. NPC Spawner Device: Create a new guard-type NPC Character Definition and use the Inventory Modifier to add Lucille.

To learn more, see [Working with TWDU Islands](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-twdu-islands-in-unreal-editor-for-fortnite).

## New Device: Armored Transport Spawner

The [Armored Transport](https://dev.epicgames.com/documentation/en-us/fortnite/using-armored-transport-spawner-devices-in-fortnite-creative) from Battle Royale is now available for creators to utilize in their island.  Beyond being driven, the vehicle carries a bank vault that players can crack to collect loot. You can use one of the set loot pools or customize it by dropping items on the spawner.

Similar to the Bank Vault, you can control the number of weak points and how they are damaged. You can also control which players can drive the truck and which players can initiate the break-in on the vault.

## Content Browser and Inventory Updates

### Device Updates and Fixes

**Fixes:**

- Removed the on-screen callout for Deploy Rift Point Device after planting the device or dropping the device while in the Rift Point Volume device volume.

### New Weapons and Updates

- Typhoon Blade as a melee weapon is now supported for guards in the NPC Spawner.

### New Prefabs and Galleries and Updates

**New:**

- 1 new **Rebel’s Roost** prefab:

  - Rebel’s Roost
- 4 new **Rebel’s Roost** galleries:

  - Rebel’s Roost Wall
  - Rebel’s Roost Floor & Stair
  - Rebel’s Roost Roof
  - Rebel’s Roost Prop

**Fixes:**

- Fixed an issue where the Level Instance device deleted the first front left floor during placement.
- Fixed some individual icons from the Flooded Frogs Temple prefab.
- Fixed an issue with the Bushido Base Dojo prefab where some floors were self-destructing.
- Fixed the ornament trim from Bushido Base Roof Gallery to appear within its preview boundary box.
- Updated the icons, names and search tags for the Basketball Court Gallery B and Clock Tower Gallery B, to be just Basketball Court Gallery and Clock Tower Gallery.
- Fixed the LODs to display the correct textures for Obstacle Course Window C.
- Fixed some ramps from Nitrodrome Prop Gallery B to show the materials underneath.
- Fixed the blue curtains from Weeping Woods Prop Gallery to be destructible.

## New or Updated Documentation

New and updated docs include:

- Updates to [Vehicle Mod Box](https://dev.epicgames.com/documentation/en-us/fortnite/using-vehicle-mod-box-spawner-devices-in-fortnite-creative) for Armored Transport

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

1. Fixed an issue where absent Verse code was causing errors.

   - [Forum Report](https://forums.unrealengine.com/t/verse-code-that-doesnt-exist-causing-errors/2429336)
2. Fixed an issue where the guard NPC stays in place and waits for the user to come within range of its weapon to attack.

   - [Forum Report](https://forums.unrealengine.com/t/npc-spawner-type-guard-default-behavior-team-wildlife-doesnt-move-after-33-10-update/2320695)
3. Fixed an issue where `PutInStasis()` made players invulnerable to all damage.

   - [Forum Report](https://forums.unrealengine.com/t/putinstasis-makes-a-player-immune-to-damage-both-from-verse-and-from-weapons/2103207)

## Fortnite Ecosystem Updates and Fixes

**New:**

- All players can now favorite Creator Profiles in-game.

- Post Processing device volumes are updated for the Ch5 TODM system to now use negative values, so any creator-authored Post Processing device with priority 0 or above will work as expected.
- Added alphabetical sorting to template sections in the Project Browser.

**Fixes:**

- The pickaxe will no longer incorrectly bounce off of the Assembly device volume.
- Fixed a bug on Team/Class Requirement settings that were not respected by the Movement Modulator device.
- Fixed an issue so when you open a project you now only see errors relevant to your project.
- Fixed a UEFN Validation Error related to the Patchwork Music Manager when opened in older projects.

## The Walking Dead Universe Updates and Fixes

**Fixes:**

- Fixed the impact pellet display not appearing on the Shiva Shotgun.
- Fixed an issue where the Walker's bite would sometimes not do impact damage.
- Fixed an issue where players could get stuck above a horde of Walkers.
- Fixed an issue where NPC character modifiers would not always apply correctly to the prisoner variant of the Walker.
