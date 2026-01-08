# 34.10 Fortnite Ecosystem Updates and Release Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/34-10-fortnite-ecosystem-updates-and-release-notes>
> **爬取时间**: 2025-12-27T00:33:44.497363

---

Content for levels now downloads before matchmaking, allowing players to load into creative islands much faster! Creator Portal now shows Accolades and Analytics device activation data to all team members. Have fun discovering LEGO® Spring content and the updated Assembly device. Seaport Prefabs and Galleries are here, along with new weapons and items! Don’t forget to check out the latest Verse code snippets to bring more functionality to your islands. Level up your knowledge with the Mission Selection Screen tutorial and brand new device design examples!

## Content Downloads Pre-Matchmaking

Before matchmaking starts, all players in the lobby will download the content needed to play an Unreal Editor for Fortnite experience. Previously, this download would happen once the player connected to the server — but now it happens before matchmaking. This will help players load into the island faster for those with slower internet connections or for players on mobile devices.

Matchmaking will not start until all party members have downloaded the required content to play. This improves the experience for large islands because players won't be joining as late, and players won't be left in the lobby while their party members travel to the game.

## Creator Portal Metrics Updates

Accolades and Analytics device activation data is now available in the Creator Portal through your Project Analytics tab. This allows all team members with access to analytics to view device data regardless of who placed the devices.

## Brand Island Updates

### LEGO® Updates

#### Project Spring

Spring is here! With the new LEGO Spring Content, you can add festive flora and fun to your LEGO island. These galleries consist of 47 spring-festival themed props — think trees, flower stalls, picnic tables, benches, and more.

- Two new prefabs:

  - Spring Market
  - Spring Playground
- Two new galleries:

  - Spring Celebration Prop Gallery
  - Spring Woodland Nature Gallery

#### Assembly Device

The Assembly device has gotten some quality-of-life updates! You can now select volume shapes — you’ve got three options. In UEFN, there’s a new setting for previewing material so you can customize the holographic preview.

### Rocket Racing Secondary Tracks

Secondary tracks can now be located anywhere in the map without affecting respawns! Secondary tracks in Rocket Racing (RR Track), which are tracks players can only get to by teleporting, can now be marked as **Is Independent**.

## New Weapons

- Outlaw Shotgun
- Pump & Dump
- Lawless Blink Pump & Dump
- Lawless Heavy Impact Tracking Rifle
- Lawless Stink Rifle
- Lawless Trinity Assault Rifle
- Lawless Shockwave Rocket Launcher
- Rocket Drill

## New Items

- Lawless Slap Cannon

## New Prefabs & Galleries

- Three Seaport City prefabs:

  - Seaport City Usagi Hotel
  - Seaport City Stores
  - Seaport City Durrr Sushi
- Eight Seaport City galleries:

  - Seaport City Wall & Fence Gallery
  - Seaport City Floor, Balcony & Stair Gallery
  - Seaport City Train Structure Gallery
  - Seaport City Road Gallery
  - Seaport City Foundation Gallery
  - Seaport City Outdoor Prop Gallery
  - Seaport City Prop Gallery
  - Seaport City Roof Gallery

## New Verse Code Snippets

Check out the latest Verse snippets added to the [Snippets Repository](https://dev.epicgames.com/community/fortnite/snippets)! Snippets are ready-made, copy-pastable code blocks that you can bring into your existing projects to add custom functionality.

[**Heaps and Heapsort:**](https://dev.epicgames.com/community/snippets/Gw1G/fortnite-heaps-and-heapsort) A parametric type implementation of priority queues using Min-Heaps, including Heapsort, an application of priority queues for sorting arrays. Common applications of priority queues include pathfinding algorithms on graph structures such as Dijkstra's algorithm or A\* pathfinding algorithm.

[**Matrices:**](https://dev.epicgames.com/community/snippets/bO9r/fortnite-matrices) A Verse library containing an implementation of float matrices, including: matrix addition and multiplication, transposition, inversion, determinants, and solving systems of linear equations.

[**Graphs:**](https://dev.epicgames.com/community/snippets/2WVO/fortnite-graphs) A Verse library implementation of integer and float edge-weighted graphs, including methods for generating random graphs and an implementation of Dijkstra's path algorithm that uses both the Graphs and Heaps libraries. You can use edge-weighted graphs to represent distances or costs of traveling between objects in your game. Dijkstra's algorithm finds the shortest or lowest cost path between any two objects.

## Documentation Updates

Check out the latest tutorials and learning content online!

### Mission Selection Screen Tutorial

Check out this new [Mission Selection Screen tutorial](https://dev.epicgames.com/documentation/uefn/making-a-mission-selection-screen-in-unreal-editor-for-fortnite) that sends players directly into missions. You’ll learn how to:

- Design and style a selection screen.
- Add devices to the UI.
- Teleport players to the mission they select.

[![](https://dev.epicgames.com/community/api/documentation/image/42f53130-3b93-4ae0-845a-85321ba2f698?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42f53130-3b93-4ae0-845a-85321ba2f698?resizing_type=fit)

### Device Design Examples

Ready for some inspiration? We've got it with a new round of device design examples!

**[Stat Creator Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite-creative/stat-creator-design-examples)**See some new ways to track player progress across your games, including a parkour skill example!

**[Skilled Interaction Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite-creative/skilled-interaction-device-design-examples)**  From escaping a volcano to setting up a fishing game using this device, learn ways to help your players hone their outdoor skills — after all, spring is almost here!

[**Switch Device Design Examples**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/switch-device-design-examples)  Let your players turn things on and off with a switch device, and build a King-of-the-Hill game while you're at it!

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue with assets not updating when overriding custom editable assets.

  - [Forum Report](https://forums.unrealengine.com/t/major-custom-assets-exposed-in-verse-not-working/2280994)
- Fixed an issue where building Auto Localization was failing.

  - [Forum Report](https://forums.unrealengine.com/t/build-auto-localization-failing/2102873)
- Fixed an issue with Verse tags not working on Volume devices.

  - [Forum Report](https://forums.unrealengine.com/t/volume-devices-still-dont-work-with-tags/1623465)
- Fixed an issue with Hired NPC Guards not reviving DBNO players.

  - [Forum Report](https://forums.unrealengine.com/t/guard-navigation-and-revive-feature-broken-in-published-games/2288821)

## Fortnite Ecosystem Updates and Fixes

**New:**

- Added a user option to the Bank Vault device to control initial weak point delay.
- Renamed the Bank Vault's **On Activated Send Event To** event to **On Sequence Started Send Event To**.

**Fixes:**

- Fixed the **Slow Motion On End Of Round** setting for Creative islands.
- Updated the description of the **Capture Area** and **Capture Item Spawner** devices to specify that they do not work with stackable items, and can only accept one item at a time.
- Fixed an issue where changing device options inside the Rift Point Volume device would not update players’ ability to plant a Rift Point device item.
- Fixed an issue where the Earth Sprite device would not stop chewing after spitting out an item.
- Fixed an issue where some weapons were not damaging the Bank Vault after it had been destroyed and reset.
- Fixed an issue where NPCs stopped emoting when the player swapped emotes or jams.
- Fixed an issue where the Axe in LEGO Islands did not display the correct color when dropped.
- Fixed an issue where players returning to the lobby from a LEGO Island would not have a minifig character.
- Fixed an issue where the Phone Tool holographic preview persisted in edit mode after the player started running.
- Fixed a performance degradation that could occur after adding and removing Verse UI widgets.
- Fixed a rare server crash that occurred when using Verse UI.
- Fixed an issue where the First Person render space mesh scaling was turned off by the flashbang effect.
- Fixed an issue where the Bank Vault device was not opening on Creative islands converted that had been converted to UEFN projects.
- Fixed an issue where the Bank Vault **Place Thermite** interaction did not honor the **Infinite Consumables** island setting.

## UEFN Updates and Fixes

**New:**

- Added a Search functionality to the metrics tree view for the Spatial Profiler.
- Added a change that allows the maximum number of AI NPCs displayed to the client to match the maximum number of AI NPCs allowed to be spawned in a session. This value is now 90 for both at the time of this release.
- As you animate, you can now hold down the Shift key to keep sockets in the same absolute location when reparenting.
- Improved the Texture Validation tooltip warning that displays when a texture's LOD Bias needs updating. Removed unnecessary Texture Validation warnings related to missing asset tags.
- Character Definitions will now generate a thumbnail matching the selected skin of that character in most cases.
- UMG widget assets are now generated in the Verse digest. It's possible to add and remove them on-screen using `player_ui AddWidget/RemoveWidget`.
- Thumbnails can now be generated on existing character definitions by  swapping the character type, saving it, swapping it back, and then resaving it.

**Fixes:**

- Pushing changes for a map material no longer crashes the game.
- Fixed an issue where iterative validation failed to cache the previous validation state.
- Fixed a duplicate file mount issue in Editor Localization when a user would open multiple UEFN projects in succession.
- Fixed an issue where the combined editor gizmo failed to sync changes through Live Edit.
- Fixed an issue where crashes occurred the first time shaders were compiled if no shader compilation had taken place during the startup process.
- Fixed a crash that occurred when running the Subdivide tool using the Loop subdivision scheme on a volume.
- Fixed a crash that occurred when accepting the Duplicate tool on a volume.

## Scene Graph Update

The Scene Graph Verse path has been updated. Instead of  `/UnrealEngine.com/Temporary/SceneGraph` you should now be using `/Verse.org/SceneGraph`.

## Verse Updates and Fixes

### API Updates

**New:**

- Change `(Verse.org/SpatialMath:)GetYawPitchRollDegrees` to return a `tuple(float, float, float)` instead of a `[]float`.

**Fix:**

- Fixed an issue where volume devices were not working with Verse tag queries.

### Tools Update

**New:**

- Improved error messaging by qualifying conflicting variables with the same name from different modules.
