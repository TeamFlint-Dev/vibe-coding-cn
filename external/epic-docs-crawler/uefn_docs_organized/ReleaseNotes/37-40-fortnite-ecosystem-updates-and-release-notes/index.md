# 37.40 Fortnite Ecosystem Updates and Release Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/37-40-fortnite-ecosystem-updates-and-release-notes>
> **爬取时间**: 2025-12-26T23:15:04.451205

---

Fortnite v37.40 adds General Physics in Beta, Reckless Railways Prefabs and Galleries, new debug commands, and experimental Custom Inventory and Items.

KPop Demon Hunters has also landed in UEFN and Fortnite Creative! You can now build, publish, and share your KPop Demon Hunters islands. No publishing hold this time!

## General Physics in Beta — Publish Your Islands Today

With the Beta release of General Physics, you can now publish your physics-enabled islands. Physics lets your players push, topple, hit, and move objects — unlocking emergent, physics-driven gameplay that feels realistic, engaging, and predictably unpredictable.

Publish your islands now and tag us on [@fncreate](https://x.com/FNCreate)!

To learn more about using Physics in your islands, see [Getting Started with Physics](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-with-physics).

## KPop Demon Hunters Comes to UEFN and Fortnite Creative

KPop Demon Hunters has landed in UEFN and Fortnite Creative! Developers can now build, publish, and share their KPop Demon Hunters islands. No publishing hold this time!

With HUNTR/X taking down foes in style across Fortnite, developers can now ride the wave from the start. Dive into features inspired by Rumi, Mira, and Zoey — perfect for building bold, melee-focused islands or remixing existing ones! Get the lowdown in our blog post.

### KPop Demon Hunters Starter Island for UEFN

[![KPop Demon Starter Island with bathhouse](https://dev.epicgames.com/community/api/documentation/image/4a0419c4-df27-40b9-a553-1d5d18ffdd76?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4a0419c4-df27-40b9-a553-1d5d18ffdd76?resizing_type=fit)

Get started creating with the KPop Demon Hunters starter island. Explore a Fortnite-inspired take on the colorful KPop Demon Hunters streets! Fight demons with friends in the moody bathhouse, then celebrate on the beautiful plaza!

### HUNTR/X and Demon NPC Devices

Spawn HUNTR/X into your island to help players protect the honmoon and defeat demons. You can add the hero characters, each with their own unique pickaxe, using the **KPop Demon Hunters Character Spawner** device.

[![Rumi, Zoey and Mira from KPop Demon Hunters](https://dev.epicgames.com/community/api/documentation/image/e11ac85f-9113-45d4-9690-9dbb0ba3d84e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e11ac85f-9113-45d4-9690-9dbb0ba3d84e?resizing_type=fit)

The feature set also includes a new enemy type — demons — inspired by the movie. Use the **Demon Spawner** or **Demon Placer** devices to summon demons from the underworld.

### KPop Demon Hunters Assets

Build your island with themed assets like gameplay items, honmoon shaders, props, and a background vista of Gwi-Ma collecting souls.

[![Use KPop Demon Hunters assets like Rumi's Empowered Sword](https://dev.epicgames.com/community/api/documentation/image/6fcb53e6-8eed-42c9-a5ce-816168c117a3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6fcb53e6-8eed-42c9-a5ce-816168c117a3?resizing_type=fit)

To learn more about the available brand content, see [Working with KPop Demon Hunters Islands](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-kpdh-islands-in-fortnite).

Also, make sure to read and follow the [KPop Demon Hunter Brand and Creator Rules](https://dev.epicgames.com/documentation/en-us/fortnite/kpop-demon-hunters-brand-and-creator-rules-in-fortnite)!

## Custom Inventory and Items (Experimental)

[![Example showing custom inventory created with Custom Inventory and Items system](https://dev.epicgames.com/community/api/documentation/image/afd261de-1bfc-4ac7-a03f-a6ec5cb372c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/afd261de-1bfc-4ac7-a03f-a6ec5cb372c1?resizing_type=fit)

The Experimental release of Custom Inventory and Items allows developers to modify, customize, or completely replace the default player inventory. Developers can design original items with unique properties, and build gameplay systems centered around inventory interactions.

From in-game economies to crafting mechanics and beyond, this system supports a wide range of gameplay styles, unlocking even more ways to create distinct and engaging player experiences.

Custom items are made up of Scene Graph components, more of which will be released regularly. You can also create your own components with Verse.

Learn more in [Custom Inventory and Items Overview](https://dev.epicgames.com/documentation/en-us/fortnite/custom-inventory-and-items-overview-in-fortnite).

## Best Practices for Building Mobile-First Islands

This [new documentation](https://dev.epicgames.com/documentation/en-us/fortnite/mobile-design-and-optimization-in-fortnite) aims to guide developers with design best practices and tips to optimize island performance for mobile devices. As UEFN continues to enhance the mobile development experience for developers, we’ll update and expand this content as needed.

## Hive Lobbers

A new wildlife type has been added to the Wildlife Spawner device: the **Hive Lobber**. This large insect fires ranged projectiles at its enemies, and will burrow and tunnel away from them when they get close. Hive Lobbers can be tamed by players like other wildlife types (such as the Wolf and Boar) using device events. However, Hive Lobbers currently do not work with patrol paths.

The Wildlife Spawner also has a new option called **Aggression Level**. This option determines how often the Hive Lobbers perform their ranged attack, so you can control their behavior and how threatening they are.

## Verse API for Hive Stash Device

Verse API for the Hive Stash device is now live! You can now use Verse to dynamically track and adjust the Hive Stash state, appearance, and behavior. You can also link Hive Stashes directly to Guard and NPC Spawner devices for even more control over rescued characters. Check it out in the [Verse API documentation](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hive_stash_device)!

## New Prefabs and Galleries

[![Reckless Railways Grand Station Prefab](https://dev.epicgames.com/community/api/documentation/image/d820257e-0f90-4d22-98d5-12d3d95b7afe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d820257e-0f90-4d22-98d5-12d3d95b7afe?resizing_type=fit)

- Reckless Railways Grand Station
- Reckless Railways Villa
- Reckless Railways Houses
- Reckless Railways Floor and Stairs Gallery
- Reckless Railways Wall Gallery
- Reckless Railways Roof Gallery
- Reckless Railways Props Gallery
- Reckless Railways Foundation and Street Gallery

## New Debug Commands

To help you efficiently debug your projects, we are committed to adding more debug commands to the Beta **Debug Command** menu. We've now added:

- **Set Health**: Adds health as a percentage of max health.
- **Increase Gold Resources**: Instantly adds the requested number to the player’s gold resources.

## Epic Developer Assistant for UEFN

The [Epic Developer Assistant for UEFN](https://dev.epicgames.com/community/assistant/fortnite), launched earlier this year, now supports Scene Graph code generation in addition to Verse and UEFN documentation guidance.

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where the Pinball Bumper device's animation would trigger, but the user remained on top of the device.

  - [Forum Report](https://forums.unrealengine.com/t/top-bounce-for-pinball-bumper-device-broken-since-update/2655377)
- Fixed an issue where explosive weapons were not dealing enough damage.

  - [Forum Report](https://forums.unrealengine.com/t/rocket-launchers-vehicle-damage-is-same-as-its-player-damage/2656057)
- Fixed an issue where DBNO players were entering a broken state after being revived.

  - [Forum Report](https://forums.unrealengine.com/t/players-breaking-when-revived-from-the-down-but-not-out-state-in-a-volume/2628846)
- Fixed an issue where Verse code based on a subscription for DestroyEvent was ignored.

  - [Forum Report](https://forums.unrealengine.com/t/scout-spire-destroyevent-is-not-working-correctly/2642858)

## Fortnite Ecosystem Updates and Fixes

**New:**

- Added utility functions to query private states in the widget. This can be useful when creating widget validators.
- The Speaking Players widget on the right side of the screen is now more responsive during game chat.
- When players speak, their player name is displayed in the Speaking Players widget on the right side of the screen.

**Fixes:**

- Fixed an issue where the Boom Box dealt no damage to objects around it.
- Fixed an issue where many explosive items and weapons dealt reduced damage to vehicles.
- Fixed several weapons not respecting the **Weapon Destruction** options in **Island Settings**.

## Device Updates and Fixes

**New:**

- The Player Movement device has been temporarily disabled when Physics is enabled.
- The Carryable Spawner device now has the ability to set the **Carryable Mesh** and **Material** in Verse using new `SetMesh` and `SetMaterial` functions.

**Fixes:**

- Fixed an issue where clearing a Hive Stash's link to a spawner device could result in character and container visual overlapping inside of the Hive Stash.
- Fixed a validation error that sometimes prevented starting a session when using the Map Indicator device in UEFN.

## UEFN Updates and Fixes

**Fixes:**

- Cleaned up some editor-only material localization that was being gathered as game localization data.
- Disabled the **Dynamic Possession** menu in UMG since it's not supported for UEFN.
- Removed **Edit In Sequencer** because it relies on something that is not yet supported in UEFN.
- Fixed a crash that occurred when publishing an island or saving a project while the landscape material was invalid.

## UEFN General Physics Updates and Fixes

**New:**

- The Pinball Flipper and Pinball Bumper devices are now physically based. This means that objects will be propelled by the flipper action. This also addresses previous device latency for these devices.

**Fixes:**

- The Prop Mover device's **On Player Collision Behavior** option is now functioning with translation movement.
- A new error message now warns that the `FortPhysics` component cannot be added to devices. It should only be applied to props.
- The sound presets no longer play after ending a game.

- The sound effects (SFX) selected in the FortPhysics component now follow the prop movements consistently.
- The **Impulse on Hit Multiplier** setting is now greyed out when the **Impulse On Hit** Island setting is set to **Disabled**.
- Players can now use emotes when standing anywhere on props that are moved with the Prop Mover device.
- The player no longer returns to standing state when crouching.
- The player now moves correctly while being impulsed upward with a Player Movement device.
- The Explosive device default impulse now has a greater effect on physics props and on players.
- The player is now launched consistently when they collide with the D-Launcher device.
- Weapon positioning and ADS animations are now correctly replicated for other clients.
- The Angled Environmental Trap Bouncer (Ceiling) trap now launches physics props in the right direction.
- Props with a sound preset now produce sounds when hit by a second player using a weapon or pickaxe.
- Props now consistently keep moving when they are pushed or hit.
- Props no longer simulate physics when **Simulate Physics** is set to **False**.
- The transition between standing still and sprinting is now smoother.
- Movement is now much more fluid when characters or players fall from heights.
- The crosshair now remains above the weapon when a player is crouching and aiming down the sights.

## Known Issues

**General Physics:**

- Devices can no longer be attached to a prop when physics is enabled. This means that no devices can be the child of a physics-enabled prop. We are investigating solutions to address this.
- **Prop Mover device**: when movement type is set to **Rotation**, Prop Mover collision detection is at world zero instead of on the prop itself.
- **Pinball Bumper device**: there exists a visual artifact issue where after a prop bounces off of the bumper, it will reappear by the bumper and bounce again. We are working on a fix for this in a subsequent release.
- **Pinball Bumper device**: the **Knockback Physics Prop** option default is changed from **50,000** to **800**.
- **Pinball Flipper device**: the **Reset Time** option does not work currently.
- **Pinball Flipper device**: the **Hit on Backswing** option appears with Physics enabled.
- **Pinball Flipper device**: the device is always enabled when the game starts.
- **Hop Flower device**: the **Maintained Momentum** settings do not function properly with physics props at this time.
- **Air Vent device**: currently this device does not conserve prop momentum. When a prop hits the Air Vent, it stops lateral movement and is impulsed perpendicular to the Air Vent. We will be fixing this in a future release.
- **Air Vent device**: props do not have VFX or SFX when entering air vents.
- **Skydive Volume device**: the Launch Velocity option does not work with Physics.
- **Skydive Volume device**: The glider can appear sideways after exiting the volume and then entering the Water Volume device area.
- The physics character will still be enabled even after disabling the Physics feature and pushing changes. Until we fix this, please close your session and relaunch it after you disable the Physics feature in **Project Settings**.

**Experimental Custom Inventory and Items:**

- Players are unable to select some or all items in the Inventory menu after having been in Edit Mode. WORKAROUND: Close and relaunch UEFN session.
- NPCs are currently unable to use the new custom items and inventories.
- Remapped keys are not respected by some of the inventory inputs.
- Items are sometimes placed in the wrong inventory.
- Some icons for gamepad input binding are absent when a controller is used.
- Picking up an item entity can result in the player's movement being broken. WORKAROUND: Close and relaunch UEFN session.
- Other UI and presentation issues.

**Scene Graph:**

- `Calling Entity.RemoveFromParent()` is not replicating correctly. Entities are not being removed from client instances as expected.

## Verse Updates and Fixes

**Fixes:**

- Fixed a bug where `(InEntity:entity).FindCreativeObjectsWithTag` would not return anything.

## Unreal Revision Control Fixes

**Fixes:**

- Mitigated the cause of an issue that resulted in the following error: **Deserialize node block failed: Failed to load immutable data, not found** to significantly reduce chances of the error occurring. Further fix coming in 37.50
