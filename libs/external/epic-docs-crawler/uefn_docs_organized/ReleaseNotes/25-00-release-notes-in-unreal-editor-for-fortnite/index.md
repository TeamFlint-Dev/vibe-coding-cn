# 25.00 Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/25-00-release-notes-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:32:00.264046

---

## 25.30 What's New

## Creative

**Fixes**

- Players no longer get stuck on certain islands when joining a game in progress.

### Devices

**Fixes**

- Fixed an issue with the Level Instance Device sometimes showing incorrect material.

## Creative and UEFN

**New**

- Slap Splash visuals now display correctly when healing another player.

### Devices

**New**

- The **Grow** event and the **Initial Delay** and **Regrowth Delay** options for the Bomb Flower, Stink Flower, Slurp Plant and Hop Flower now explain that a plant will not grow or regrow if the player is too close. The safe zone radius was also reduced.

**Fixes**

- Fixed an issue with the Boat Spawner where the device hologram blocked players from entering the vehicle.
- Fixed issue with certain items showing as black on device previews (for example, Item Spawner and Team Settings & Inventory devices).
- Post Game Types not set to **Classic** in My Island Settings now correctly trigger the Game End UI when played through a second time.
- Reduced the Air Vent device memory usage.
- Fixed several issues with the Bomb Flower, Stink Flower, Hop Flower and Slurp Plant:

  - Phone tool now correctly highlights these devices.
  - Instigators are correctly passed to event bindings so exploding the devices using event bindings now works correctly.
  - All weapons now correctly cause a plant to launch.
  - Bomb Flowers set to not launch projectiles and those with **Regrowth Delay** set to **Instant** no longer trigger a chain of endless explosions.
  - The Bomb Flower leaf animation now plays correctly when a plant explodes without launching.

## UEFN

**New**

- When opening project documentation links to non-Epic sites, users are now prompted with an unsafe website warning, per web standards.
- The **Contact Player Support** hyperlink now displays when users try to upload or access a locked project.
- Fixed an issue where the **Create Physics Asset** option was missing when importing FBX and Datasmith skeletal meshes in UEFN. Users can now create a physics asset on import.

**Fixes**

- Double-clicking on local projects in the Project Browser now works correctly.

## Verse

### API

**Removed**

- Removed `WorldPartition` module.

**New**

- Verse localization support added for the following devices:

  - Button device
  - Conditional Button device
  - Switch device
  - Billboard device
  - Tracker device
- Verse support added for the Item Shop Portal device.
- Added the following Verse API calls to the Player Reference device:

  - `IsReferenced`
  - `GetAgent`
  - `GetStatValue`
- Added support for `navigatable` and `focus_interface` for creatures spawned by the Wildlife Spawner device.

## 25.20 What's New

## Creative

**New**

- The phone tool is now automatically selected when you return to your island at the end of a playtest session.

**Fixes**

- Fixed an issue where the player would get stuck on certain islands if they joined while the game was in progress.
- Fixed an issue where the Shockwave Hammer bounce ability was not properly bouncing the player.
- Fixed an issue where the post-game flow erroneously showed a draw when **Game End Callout** options were set to **Cooperative**.
- Fixed an issue with the Level Instance device sometimes showed incorrect material.

### Devices

**New**

- The Attribute Evaluator device now has stronger visual differences between Enabled and Disabled states.
- Added the **Persist Over Elimination** option to Powerup devices. If this is set to On, the powerup will continue to apply after a player respawns.
- Added the **Effects** option to the Damage Amplifier Powerup device. Values for this option are: **None**, **Only Glow**, and **All Effects**.
- Added an option to the Mutator Zone device to block emotes when a player is inside the volume.
- Added options to the Collectible Object Gallery devices. The color of the collectible objects can be based on Direct Color, Collecting Team Color, Collecting Team Relationship, Specific Team Color or Specific Team Relationship (not all collectibles are supported). Added the option to disable idle VFX.
- Added the **Disguise Animation Duration** option to Prop-O-Matic Manager device.

**Fixes**

- Fixed the Dial-A-Drop issue where Health Drop did not contain the expected items.
- Fixed issues with the Grind Rail:

  - Camera no longer gets stuck on the rail when grinding on an upward slope.
  - Ending a round or match on the Grind Rail no longer prevents players from respawning to their desired respawn locations.
  - The Water Volume device no longer gets destroyed when riding the Grind Rail through it.
  - The Creature Placer and Creature Spawner are no longer broken when riding the Grind Rail toward them during a match.
- When taking damage from a Damage Volume device, players no longer see a damage indicator.

## Creator Portal

**New**

- Added a **By [Creator]** label to the top of the project page to create more consistency for creator presence.
- Updated the project card UI to include CCU, removed the creator label (since it is now at the top of the project page), and added richer color-coded current version statuses.

**Fixes**

- Fixed several localization issues.
- The version for Island Title and Island Description now correctly sets to the active version.
- Selecting **Monetization** no longer incorrectly changes your team status to **No Team (Just Me)**.

## UEFN

**New**

- The last project location used in the Project Browser is now remembered, and doesn't reset back to the default project location.
- Added a custom **UEFN Documentation** menu entry to the Reference section of the Help menu.
- Exposed the Community section in the Help menu.
- A customized warning now shows in the Project Browser when a locked project is selected (such as **severely failing moderation**).

**Fixes**

- Fixed an issue where the **Community** button in the Project Browser opened a blank tab.
- Fixed validation errors caused by Zipline poles.
- Fixed a documentation link for importing static meshes.
- Fixed assign issue where the editor crashed on startup when auto-loading a project with a crashing default map. The editor should remember the crash and not attempt to autoload the project the next time.
- Fixed the font used in the News window.

### Devices

**New**

- Added an option to the Collectible Object devices to assign and play a unique **On Collected** VFX.

**Fixes**

- The Dance Mannequin device can now be enabled using the **Enabled On Phase** option.
- Item Spawner device:

  - The **Time Between Spawns** option is now consistent between Creative and UEFN.
  - The **Time Before First Spawn** option is now consistent between Creative and UEFN.
- The Grappler Range option on the Baller Spawner device no longer skips to minimum or maximum when trying to change the value.
- The Pinball Bumper **Activated** Event now works with vehicles.
- Fixed an issue where Player Spawn pads were located inside terrain when creating new islands.
- Fog and Time Of Day island settings now work in UEFN.

## Verse

### Language

**New**

- Added `session` class, `GetSession` function, and `weak_map` map supertype lacking iteration or `Length` to allow defining session-local globals. For example:

  ```verse
        var GlobalInt:weak_map(session, int) = map{}
        ExampleFunction():void=
            X := if (Y := GlobalInt[GetSession()]) then Y + 1 else 0
            if:
                set GlobalInt[GetSession()] = X
            Print(“{X}”)
  ```

### API

**Deprecated**

- VehicleSpawnedEvent and VehicleDestroyedEvent for vehicle devices.

**New**

- Added SpawnedEvent and DestroyedEvent for vehicle devices (SpawnedEvent returns the spawned fort\_vehicle).
- Verse support added for Barrier device functions **Add Player To Ignore List**, **Remove Player From Ignore List**, and **Remove All Players From Ignore List**.
- Verse support added for Beacon device functions Add **Player To Show List**, **Remove Player From Show List**, and **Remove All Players From Show List**.
- Added MoveTo API to creative\_device.
- Added TeleportTo API for the following devices:

  - air\_vent\_device
  - barrier\_device
  - billboard\_device
  - button\_device
  - campfire\_device
  - capture\_area\_device
  - capture\_item\_spawner\_device
  - changing\_booth\_device
  - character\_device
  - cinematic\_sequence\_device
  - class\_and\_team\_selector\_device
  - class\_designer\_device
  - collectible\_object\_device
  - color\_changing\_tiles\_device
  - conditional\_button\_device
  - crash\_pad\_device
  - creature\_placer\_device
  - customizable\_light\_device
  - dance\_mannequin\_device
  - effect\_volume\_device
  - end\_game\_device
  - explosive\_device
  - fuel\_pump\_device
  - guard\_spawner\_device
  - holoscreen\_device
  - lock\_device
  - map\_indicator\_device
  - objective\_device
  - pinball\_bumper\_device
  - pinball\_flipper\_device
  - player\_checkpoint\_device
  - player\_counter\_device
  - player\_spawner\_device
  - powerup\_device
  - radio\_device
  - real\_time\_clock\_device
  - round\_settings\_device
  - score\_manager\_device
  - sentry\_device
  - switch\_device
  - timed\_objective\_device
  - timer\_device
  - trigger\_base\_device
  - vfx\_spawner\_device
  - wildlife\_spawner\_device

## 25.10 What's New

## Creative

**New**:

- The Hop Flower bouncer device has new "Maintained Momentum" and "Maintained Vehicle Momentum" options, which both allow a percentage of directional momentum to be maintained and added to the bounce.

**Fixes**:

- Fixed an issue with the Campfire device not being extinguished by water.
- Fixed an issue where the Kinetic Boomerang was not properly targeting and damaging an enemy Falcon Scout.
- Fixed an issue where the Chug Cannon was missing its "Ranged Weapon" label.
- Fixed an issue where the Bandage Bazooka was missing its countdown UI during cooldown.

## Creative and UEFN

**New**:

- Added a new "Show Spawn Radius" option in the upgraded Guard Spawner device.
- Adding a new "Requires Holding Item" option to the Conditional Button device. This means the instigator must be holding one of the items in order to pass the condition. If no items in the Conditional Button can be held, the test will always fail.

**Fixes**:

- Fixed an issue that made the device preview get stuck when placing certain devices.
- Fixed an issue where the Creature Spawner's "Wave Timer" option was showing inaccurate values in UEFN.
- The Creature Spawner's "Wave Timer" option now supports any amount of time from 1-600 seconds in both Creative and UEFN.
- Fixed an issue where the Beacon device wouldn't correctly update its visibility when it was set to only display for a team, and a player was respawned by a team or class switch.

## UEFN

**New:**

- New volumetric textures have been added to the Epic Textures folders, Volumetric Clouds.
- PhysicsAssets can be added to SkeletalMeshes for Querying/Probing; these can help in defining behavior for skeletal meshes such as creating accurate bounding boxes for animating meshes, or accurate collision.

**Fixes:**

- The Kinetic Boomerang now deals damage to structures in UEFN.
- Fixed an issue where players would not spawn on player spawn pads.
- Fixed the issue where some UEFN modules would time out when loading on clients.
- Rimlight levels are reflected in connected clients when changes are pushed from UEFN.
- Fixed an intermittent sync issue caused when deleting Actors.
- The Physics Tree and Boulder now fall when released.

### Devices

**New**:

- The Lock device now works properly when set up in UEFN.
- The Day Sequence device has a new volume option to determine volume size for the device.

**Fixes**:

- Fixed an issue where an animation would appear frozen when out of the client’s range and brought quickly into range using a Cinematic Sequencer.
- Fixed texture and color issues with the Ball Spawner device:

  - Changes to the Color, Roughness, Metalness, and Logo Brightness settings now show up in the UEFN viewport.
  - Changing the Color setting in-game no longer selects the previous color in the list, and the default color now shows at the beginning of the list.
- Riding creatures from the Wildlife Spawner works correctly in Play from an island code.

### Editor

**New:**

- Props will now display their approximate dimensions when hovering over them in the Content Browser.

**Fixes:**

- Fixed a Live Edit issue where actors disappear on the client when using Replace Actors or Undo.
- Fixed a Live Edit issue where gallery actors would teleport to a different location rather than the released location.
- Player Spawn Pads no longer spawn inside terrain when creating a new island.

## Verse

**New**:

- Increased the time threshold for Verse hang detection, which is the max time a Verse call is allowed to run before it throws a runtime error.

### API

**New**:

- The `creative_device` class now has `TeleportTo()` functionality like `creative_prop`, which means you can teleport your Verse-authored device to a different location.
- All devices in the Bouncer Gallery now have Verse API.
- Conditional Button device now has the following Verse functions:

  - 'GetItemCount(Agent:agent, KeyItemIndex:int):int', which returns the number of items the Agent is holding that match the item held by the Conditional Button in a specific key item index.
  - 'HasAllItems(Agent:agent, KeyItemIndex:int)<transacts><decides>:void, which succeeds if the Agent has all of the items required for a specific Item in the Conditional Button. You can also call this function without the `KeyItemIndex` argument to check all items in the device.
  - 'IsHoldingItem<public>(Agent:agent, KeyItemIndex:int)<transacts><decides>:void', which succeeds if the Agent is currently holding the item at the index specified. You can also call this function without the `KeyItemIndex` argument to check if the Agent is holding any of the items.
- AI Module updated with the following interfaces:

  - `focus_interface` to control where characters should look, and which you can access with `(InCharacter:fort_character).GetFocusInterface` extension.
  - `fort_leashable` to set the character’s leash, and which you can access with `(InCharacter:fort_character).GetFortLeashable()` extension.
  - `navigatable` to set target and query, and which you can access with `(InCharacter:fort_character).GetNavigatable()` extension.
- Added the following events and functions to the Verse API for AI Patrol Path device:

  - `Assign()`
  - `NodeReachedEvent`
  - `NextNodeUnreachableEvent`
  - `PatrolPathStartedEvent`
  - `PatrolPathStoppedEvent`
  - `Enable()`
  - `Disable()`
  - `GoToNextPatrolGroup()`
- Added the following events and functions to the Verse API for Guard Spawner device:

  - `AlertedEvent`
  - `TargetLostEvent`
  - `SuspiciousEvent`
  - `UnawareEvent`
  - `DamagedEvent`
  - `EliminatedEvent`
  - `EliminatingEvent`
  - `HiredEvent`
  - `DismissedEvent`
  - `ForceAttackTarget()`
  - `GetSpawnLimit()`
- Added the following events and functions to the Verse API for Creature Spawner device:

  - `EliminatedEvent`
  - `GetSpawnLimit()`
- Added the following events and functions to the Verse API for Wildlife Spawner device:

  - `EliminatedEvent`
  - `EliminatingEvent`
  - `TamedEvent`
  - `UntamedEvent`
  - `DamagedEvent`
  - `SomethingIsEatenEvent`
  - `RiddenEvent`
  - `DismountedEvent`
  - `GetSpawnLimit()`

## 25.00 What's New

## Creative

### Fixes

- Fixed an issue where players would always gain 50 health when eliminating opponents.
- The island setting "Health gain on Elimination" now functions correctly.
- The Wildlife Spawner device's preview icon now displays correctly when placed.
- Fishing Zone device's VFX now functions correctly.
- Chug Cannon now correctly extinguishes lit Campfire devices.
- Fixed an issue where the buttons on the Create/Select Island console appeared disabled.
- The Quick Bar now correctly displays when the Creative Inventory is first opened.

## Creative and UEFN

- Added **On Begin Entering Disguise**, **On Finish Entering Disguise**, and **On Exiting Disguise** events to the Prop-O-Matic Manager device, along with Verse support for these events.

### Fixes:

- Fixed an issue in the Visual Effect Powerup device where the custom color can't be changed when editing an island.

## UEFN

- Added Lookat Tracking Settings to the Cinematic Camera Actor to allow you to point the camera at another actor.
- Re-enabled cancellation during the New Level from Island flow.
- Team selection is now maintained across editor sessions and project browser instances. You no longer have to continually reselect your team.

### Fixes

- Fixed issues with Replace Actors during live edit.
- Fixed the New Level from Island flow, which now loads an empty level if the creation of the new level was unsuccessful.

## Verse API

- You can now add debug volumes with Verse. Enable the per user Verse Debug Draw mode in Island Settings.
- Added the Collectible Object device to the Verse API.

### Fixes

- Fixed visual flickering of a `creative_prop` when animating it using `MoveTo()`.
- When you use `SetMaxValue` and `SetMinValue` on the `slider_regular` widget you no longer are allowed to define an invalid interval.

## Verse Tools

- Verse gameplay tags can now be displayed in the editor with or without their tag hierarchy.

### Fixes

- New `.verse` files added to a blank template project will now show up in Verse Explorer in UEFN.

## Creator Portal

- Improved tooltip for creators encountering a disabled Submit to Release button
- Updates/improvements to Island Creator Program related messaging via tooltips and navigation
- Clearer messaging around sending Team invites
- Various UI and localization improvements and fixes

### Fixes

- Fixes related to to project transfers
- Fix for a bug that caused Verse Path collisions with island names
- Traffic from China can now reach the site as expected
- Fix for crashes occurring on the Project view page
- Various fixes to the publishing flow service pipeline
- Fix to address intermittent red error bar Unknown server error
- Fix for Total Active Players Graph numbers being off by one month
- Fix for new users occasionally hitting a 404 error page
- Island title should now correctly prepopulate in Publishing submission process
- Additional project ownership/transfer related fixes
- Fixes related to localization/selected language

## Fab

### Fixes

- Fixed a bug where FAB dependencies were not always removed from projects when FAB assets were no longer being referenced.
