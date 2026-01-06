# 39.00 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/39-00-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-26T22:56:37.403148

---

## Reminder: Legacy Analytics Site Retiring December 10, 2025

With the launch of the account-wide Monetization page in Creator Portal last September, we announced that the Legacy Analytics site will be retired on December 10, 2025.

All monetization metrics are now available in the Monetization page in Creator Portal. A new Reporting page will soon be available just under Monetization, enabling owners and administrators to download data from multiple games at once.

## In-Island Transactions Updates

There are several updates for in-island transactions in this release.

### Island Publishing on Jan 9, 2026!

Publishing for in-island transactions will now open on **January 9, 2026**. We’re shifting the date out to give ourselves more time to test and fix bugs before going live to players. You will see the Experimental flag removed for in-island transactions, but publishing will not go live until January 9.

### Testing is Now Available for Several Features

The following are now available for testing on your island:

- Restrictions such as `GetMinPurchaseAge`, `RestrictDirectPromptsToPurchase`, and `RestrictPaidRandomItem`
- Validation rules, such as receiving an error when the products have invalid data (exceeding V-Bucks pricing maximums)
- Real & persistence flows (no V-Bucks deducted)

### Consequential to Gameplay Function Added!

Items that give players meaningful advantages for gameplay are considered **Consequential to Gameplay**, and in your code `ConsequentialToGameplay` must be set to `True`. To learn more about consequential to gameplay items, see [Creating Items and Offers](https://dev.epicgames.com/documentation/en-us/fortnite/creating-items-and-offers-in-fortnite).

### Developer Rules Updates

Please review the [Fortnite Developer Rules](https://legal.epicgames.com/fortnite/developer-rules) for details, as we’ve added two new rules outlining disclosure requirements for in-island items that give players a meaningful advantage (4.4.12) and in-island offers that provide access to paid areas (4.4.13).

## Update to Fortnite Publishing Terms

We’ve recently updated the "Engagement Payout Program Terms" to the "Fortnite Developer Agreement", and require you to accept the updated terms to continue to publish games in Fortnite. Starting now, you can review and accept the new agreement in the [Creator Portal](https://create.fortnite.com/). Soon, accepting it will be required to keep publishing in the ecosystem.

## Mobile Updates

The following features have been added to support the creation of mobile-first experiences in Unreal Editor for Fortnite (UEFN).

### Mobile Preview

The [Mobile Preview](https://dev.epicgames.com/documentation/en-us/fortnite/mobile-preview-session-in-unreal-editor-for-fortnite) feature in UEFN provides an easier and more accessible way to iterate and refine the quality of mobile experiences by enabling developers to launch a Fortnite session in mobile mode, with configurable aspect ratios and mobile scalability settings.

With this feature, experiences built in UEFN can now load using appropriate mobile configurations, enabling developers to evaluate the quality of art assets, lighting, materials, visual effects, and UI/HUD layouts directly within a mobile context.

**Known issue**: Device Profiles are currently an approximation, as they currently use the Windows Scalability Group. This issue will be fixed in a subsequent release.

### Input Trigger Device Updates

Developers looking to build mobile-first experiences can now customize touch-based button layouts, scaling, and mobile icons, as well as subscribe to a player’s directional inputs (such as  a virtual joystick) through the [Input Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/using-input-trigger-devices-in-fortnite-creative#mobile-options). This flexibility exemplifies our ongoing plan to provide more fine-tuned touch support on Fortnite experiences ranging from shooters and tycoons to role-playing games, puzzle games and more.

## Spatial Profiler Improvements

We have added new metrics and made several UX improvements to the Spatial Profiler in order to make the tool more useful and easier to use and ensure the reported information is easier to digest. Here are some highlights:

- The tool now saves/loads data from multiple devices in a single file.
- Metric status system: Colors are displayed alongside each metric according to their value relative to the threshold.

  - **Yellow**: reaching limits
  - **Green**: within threshold
  - **Red**: beyond threshold
- Tooltips have been added to each metric to clarify the impact of the metric and its role in the overall performance of the game.
- You can right-click to pan in the map view, consistent with the panning behavior across the editor.
- There is improved grouping and iconography for the device selector.

## Fortnite Tools for Memory Diagnostics

We have added two new Fortnite Tools to help manage memory in UEFN experiences.

- **Optimize Texture**: Detects and reports various potential inefficiencies with Project Textures.
- **Optimize Static Mesh**: Detects and reports various potential inefficiencies with Project Static Meshes.

You can find **Fortnite Tools** in the dropdown menu when clicking **Select Mode**.

## Physics Updates

The following features have been added to the physics toolset for this release:

### New Physics Verse API Has Arrived

We’ve added new Verse functions for `fort_character` and `creative_prop` to enable novel physics interactions. The `fort_character` class now has the ability to get and set linear velocity, get the character’s mass, and apply a linear impulse or a force. The `creative_prop` class can do all of that as well as get and set angular velocity and apply an angular impulse and a torque. Consult the [Verse API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api) for more information.

### New Add Physics Tool

Fortnite Tools has a new addition: the **Add Physics** tool. It gives you a way to quickly add or remove the FortPhysics Scene Graph component on multiple selected objects at the same time. The tool actions are:

- **Add Physics**: Adds the FortPhysics Component to all selected objects in the Editor. This will only work for Props that are not devices or that already have a FortPhysics Component. This action will also automatically set **Simulate Physics** to **True**.
- **Remove Physics**: Removes the FortPhysics Component from all selected objects in the editor.
- **Select Physics**: Selects only Physics props from a wider selection of objects in the editor. This should allow developers to isolate Physics props from Non-Physics props when dealing with large numbers of objects on an island.
- **Select Non Physics**: Selects only Non-Physics props from a wider selection of objects in the editor — the inverse of **Select Physics**. It allows for quick search and debugging of islands by isolating Non-Physics props and objects.

### Chaos Visual Debugger

The **Chaos Visual Debugger (CVD)** is now enabled for UEFN development, allowing for the capture, inspection and replay of the physics scene from a UEFN experience. CVD is capable of capturing all physics geometry, collision contacts, scene queries and more from your scenes so they can be inspected while debugging physics-related issues in your projects.

To find the Chaos Visual Debugger, select **Tools** > **Debug** > **Chaos Visual Debugger**.

[![Chaos Visual Debugger window](https://dev.epicgames.com/community/api/documentation/image/43e409ed-8c15-45a3-a01e-cc9b381e2313?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/43e409ed-8c15-45a3-a01e-cc9b381e2313?resizing_type=fit)

Chaos Visual Debugger window

A few use cases are outlined below:

- **Unexpected Query Results**

  - If you perform a query and don’t get the result you expected, then CVD can help illuminate the situation as it captures all of the inputs, with each potential object it considered and why it did or did not include that shape in the results. See the [Scene Query Inspector](https://dev.epicgames.com/documentation/en-us/unreal-engine/data-inspectors-in-chaos-visual-debugger?application_version=5.6#scene-query-inspector) page for more details.
- **Collision Contact Behavior**

  - If you notice a dynamic collision that causes a response you don’t expect, or would like to better understand why a collision occurred, CVD also captures this data. Each contact is recorded with all of its properties, including how it was solved and what corrections it made to each object. See the [Collision Data Inspector](https://dev.epicgames.com/documentation/en-us/unreal-engine/data-inspectors-in-chaos-visual-debugger?application_version=5.6#collision-data-inspector) page for more details.
- **Collision Complexity**

  - The CVD viewport gives you an exact representation of the physics geometry in your world. This view can give you an insight into the complexity of your physics geometry. For example, this could be used to find meshes that would have poor overlap or sweep performance during a query.

Check out the full [Chaos Visual Debugger documentation](https://dev.epicgames.com/documentation/en-us/unreal-engine/chaos-visual-debugger-in-unreal-engine?application_version=5.6) to explore the feature set, with more examples.

## New Scene Graph API on NPC AI Behaviors

We've introduced a major update to how you control and interact with NPCs in Verse by empowering NPC actions and awareness functionalities with Scene Graph components. This change will provide deeper control and more granular awareness detection for all of your AI logic. Four new scene graph components are now available. They are added to the NPC-associated entity, which can be retrieved through **npc\_behavior.GetEntity[]** or **fort\_character.GetEntity[]**

- **npc\_actions\_component:**

  - Centralizes basic execution commands for all NPCs. Use this for fundamental movement and focus logic.
  - It supersedes the `navigable` and `focusable` interfaces.

- **guard\_actions\_component:**

  - Provides advanced Fortnite Guard-specific actions, unlocking high-level behaviors like attacking, jumping over obstacles, and reviving other units.
  - It supersedes the `leashable` interface.

- **Npc\_awareness\_component**:

  - Gives you access to monitor targets that the NPC has successfully detected, which serves as a foundational tool for reactive AI behaviors.

- **guard\_awareness\_component**:

  - Provides comprehensive monitoring for Fortnite Guards, including detected targets, nearby obstacles, and the guard’s current alert level.

## Debug Commands

To help you efficiently debug your projects, we are committed to adding more debug commands to the Beta Debug Command menu. We've added:

- **Print Owned Products**: Prints all owned products to the output log.
- **Change World Speed:** Changes the speed of the game world. This affects everything that relies on time.
- **Infinite Building Resources**: Enables infinite building resources. This is comprised of wood, stone, and metal.

## Updates to Personalized Rows in Discover

We’ve updated the models powering personalized rows in Discover, including the addition of new metrics related to social play. Successful party invites and joins (as a percentage of unique players) and percentage of time spent in a party are now part of the data used to determine **For You** row recommendations. This rewards developers who generate social interactions and encourage players to invite their friends. We’re also testing new rows in Discover that highlight social islands.

In addition, we’ve updated the **New and For You** row, which influences how Discover prioritizes and tests new content, to boost visibility for innovative islands that bring something new to the ecosystem, and for islands that quickly immerse players.

Our viral detection and social graph systems have also been improved to better recognize when an island is gaining momentum.

We recently made changes to limit similar islands from appearing in the **New and Updated** and **New Experiences** rows. Improved duplicate detection will also be introduced in the future to further improve the variety of islands displayed in these rows.

For more information on these changes and new details on how Discover works, check out the updated [How Discover Works](https://dev.epicgames.com/documentation/en-us/fortnite/how-discover-works-in-fortnite) documentation.

## Epic’s Picks: Attribution Requirement

Starting with v39.00, all islands submitted to [Epic’s Picks](https://creative.fortnite.com/s/) must include [attributions](https://dev.epicgames.com/documentation/en-us/fortnite/attribution-screen-in-fortnite-creative) on their island code. Developers will need to upload attribution links in Creator Portal for any custom assets or music they do not own. This step is mandatory for reviewing your island’s eligibility for featuring. [Epic’s](https://creative.fortnite.com/s/)

Even if your island meets all other quality criteria, submissions missing attributions will not be reviewed.

## XP Tag Removed

We have removed the XP tag from islands in Discover, because the tag did not indicate what, outside of play time, was awarding XP.

## Pacific Break Content Update

The Pacific Break rolls into UEFN and Creative with a huge amount of Fortnite Battle Royale Chapter Seven content. We’ve added more than 30 galleries across 6 POIs, new weapons and items, including the Wingsuit, changes to the Down But Not Out Device, and more.

[![](https://dev.epicgames.com/community/api/documentation/image/202b9e4c-4df2-4829-9a74-fe28b9ce72a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/202b9e4c-4df2-4829-9a74-fe28b9ce72a2?resizing_type=fit)

### Devices

A **Loot Cannon** has been added to the **Chest and Ammo Gallery**.

There is a known issue with validation on this device. Please see Known Issues for how to fix.

The **Down But Not Out** device has new and updated options:

- **DBNO Enabled**: Added the value **Improved DBNO** which was previously only available in island settings.
- **Allow Dodge Roll:** Allows downed players to roll using the jump button.
- **Allow Sprinting:** Allows downed players to move quickly when down.
- **Sprinting Stamina Cost:** Controls how rapidly a downed player's stamina drains while sprinting. Requires **Allow Sprinting**.
- **Allow Hurdle:** Allows downed players to hurdle over low obstacles.
- **Allow Interactions**: Can be set to **CH7S1** to allow downed players to enter vehicle passenger seats and to ride ziplines and ascenders.

**Known issues**:

- The Loot Cannon has a validation error in UEFN. On the **Creative\_LootCannon** prop, select the **CannonFireEffect** component. Under the **User Parameters** > **SkeletalMesh** section, set the **Preview Mesh** setting to **None**.

### Art Content

 The new galleries cover the following **Chapter Seven: Pacific Break** locations:

- Battlewood Boulevard

  [![](https://dev.epicgames.com/community/api/documentation/image/c8b00f96-265f-403a-83d9-d1dee4555bf8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c8b00f96-265f-403a-83d9-d1dee4555bf8?resizing_type=fit)
- Tiptop Terrace

  [![](https://dev.epicgames.com/community/api/documentation/image/fe18d008-9847-4d6c-83ab-02a1cbf2180f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fe18d008-9847-4d6c-83ab-02a1cbf2180f?resizing_type=fit)
- Bumpy Bay

  [![](https://dev.epicgames.com/community/api/documentation/image/bb647473-8603-4783-8c34-0009b61f4faf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb647473-8603-4783-8c34-0009b61f4faf?resizing_type=fit)
- Classified Canyon

  [![](https://dev.epicgames.com/community/api/documentation/image/e1c5787a-7d97-4445-b16e-46a4900b8bef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e1c5787a-7d97-4445-b16e-46a4900b8bef?resizing_type=fit)
- Ripped Tides

  [![](https://dev.epicgames.com/community/api/documentation/image/e6ecdda5-0e75-43a4-be87-56e1f960fd66?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e6ecdda5-0e75-43a4-be87-56e1f960fd66?resizing_type=fit)
- Wonkeeland

  [![](https://dev.epicgames.com/community/api/documentation/image/2b0e448d-6ea6-4f05-a867-81087f08bac1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b0e448d-6ea6-4f05-a867-81087f08bac1?resizing_type=fit)

  - This gallery contains a set of props with unique gameplay:

    - Ferris Wheel
    - Water Slide
    - Water Jet (when used with a water volume)
    - Water Innertubes (when used with a water volume)

There are no prefabs for this release, only galleries.

We’ve added graffiti decals, foliage assets, and landscape textures so you can fully realize the West Coast vibes in your own islands. The texture content specifically is only available in UEFN.

For more information on the assets we’re releasing to celebrate Chapter Seven, see [Pacific Break Galleries](https://dev.epicgames.com/documentation/en-us/fortnite/pacific-break-galleries-in-fortnite).

### Items

- Wingsuit
- Grenade

### Weapons

**New Weapons:**

- Arc Lightning Gun
- Holo Rush SMG
- Iron Pump Shotgun
- Twin Hammer Shotguns
- Deadeye Assault Rifle

**Weapon Updates:**

CH7S1 weapons can take advantage of a series of new improvements including:

- Aimpoint Recoil
- Checkpoint Reload
- Aim Down Sights While Reloading
- Aim Down Sights While In Air
- Haptic Feedback During Reload

New versions of these unvaulted weapons with the new weapon updates have been added to the content browser:

- Enforcer AR
- Tactical Pistol
- Dual Micro SMGs

## New Documentation

### New Device Design Example Docs

Some new example docs have just rolled out!

#### Cinematic Sequence Device Design Examples

[![](https://dev.epicgames.com/community/api/documentation/image/8d2dd658-bbad-4fa8-92bd-4571619f8eb3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8d2dd658-bbad-4fa8-92bd-4571619f8eb3?resizing_type=fit)

Cutscenes are a great way to onboard players or provide in-game instructions. [See some scenarios](https://dev.epicgames.com/documentation/en-us/fortnite/cinematic-sequenceples-in-fortnite) where you can use the Cinematic Sequencer device to accomplish this!

#### Conversation Device Design Examples

[![](https://dev.epicgames.com/community/api/documentation/image/c8e930a5-fe36-4ef5-8e2e-c824cf75b2d6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c8e930a5-fe36-4ef5-8e2e-c824cf75b2d6?resizing_type=fit)

Want some ideas on how to break the conversational ice between the players and the NPCs in your game? [We've got you covered!](https://dev.epicgames.com/documentation/en-us/fortnite/conversation-device-design-examples)

#### Vehicle Mod Box Spawner Device Design Examples

[![](https://dev.epicgames.com/community/api/documentation/image/3ac744cd-8c3a-4669-8c1d-a5d84d368940?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ac744cd-8c3a-4669-8c1d-a5d84d368940?resizing_type=fit)

See some cool [ways to use crazy vehicle powerups](https://dev.epicgames.com/documentation/en-us/fortnite/vehicle-mod-box-spawner-device-design-examples-in-fortnite) when players collide into this device!

For a look at all the examples available, see [Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/device-design-examples-in-fortnite-creative)!

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for bringing these issues to our attention.

- Fixed an issue where the yellow and purple flower props from the Restored Reels Amphitheater prefab could not be selected.

  - [Forum Report](https://forums.unrealengine.com/t/fix-the-flowers-from-the-restored-reels-theater-prefab-i-m-on-1-0-and-we-can-t-delete-the-flowers-no-matter-what-my-map-have-been-suffered-by-someone-and-this-person-put-the-flowers-everywhere-in-my-map-i-can-t-delete/2491173)
- Fixed an issue where activating and deactivating the custom depth pass through sequencer was not behaving as expected.

  - [Forum Post](https://forums.unrealengine.com/t/sequencer-custom-depth-pass-activation-through-sequencer-doesnt-seem-to-work-anymore/2659743)
- Fixed an issue where activating the First Person Controls device would break the functionality of the Third Person Controls device and the Sidescroller Controls device.

  - [Forum Post](https://forums.unrealengine.com/t/third-person-controls-and-sidescroller-controls-completely-broken-after-using-first-person-camera/2474289)
- Fixed an issue where the player counter failed to register NPCs or Guards when using teams, and **count guard as player** was checked in the device options.

  - [Forum Post](https://forums.unrealengine.com/t/player-counter-device-ai/2548629)
- Fixed an issue where disallowing building on Island Settings would break build editing for the entire match

  - [Forum Post](https://forums.unrealengine.com/t/disallowing-building-on-islandsettings-breaks-build-editing-for-the-entire-match/2514787)

## Fortnite Updates and Fixes

**New**:

- **Creative Hub** now has a fixed time of day.

**Fixes**:

- Fixed several First Person Camera device bugs:

  - Only the Body Part mesh should be visible in first person.
  - Immersive Edit mode in Creative shouldn't use a first-person component.
  - The player's mesh isn't visible at all.
  - If there's no FP camera on the stack, the FirstPersonWeight resets so that the mesh rendering settings are restored.
- Fixed control points appearing on UEFN when duplicating spline meshes with the phone tool.
- Fixed Zipline and Grind Rail devices having inconsistent previews when using the phone tool.

### UI

**New**:

- Exposed SetFocus method to `player_ui` in Verse.
- Added an automated conversion binding setup from the Details panel for MVVM.

**Fixes**:

- The Player Speaker widget now accurately displays the name of the other speaking players, even if they are not on the same team or socially connected to the listener.
- Fixed an issue where the Fine Art Gold Rock Sculpture reacted to player damage when set to be non-interactable.

### Devices

**New**:

- Updates to Creator Matchmaking Settings:

  - Added matchmaking-related settings to the Round Settings device.
  - Added **MMS Backfill** and **Social Joining** options to both the Island Settings and Round Settings device. This allows the creator to control the initial matchmaking behavior and override it on a per-round basis.
  - Matchmaking settings on a Round Settings device now overrides the equivalent settings on the Island Settings.
  - Enable/Disable/Toggle Matchmaking settings on the Round device have been renamed to **Enable/Disable/Toggle Join In Progress**.
- Replaced **Join In Progress** with clearer, more distinct options.

  - **Join In Progress Behavior** now allows you to select between **Spawn During New Round** (spectate until next round), **Spawn Immediately**, and **Watch Only** (remain a spectator for the rest of the game).
  - **Join In Progress Behavior** retains previous behavior if it is set to Watch Only. Backfilling will automatically disable backfilling at the start of the round, or if it's the last round and Spawn During New Round is set.
  - Allows developers to override the join-in-progress team assignment through a separate **Join In Progress Assigned** Team property.
  - Legacy options are automatically migrated into separate options.
  - If backfilling is enabled, then party joining is always possible.
- Added **Stamina (sprint)** to the Player Info View Model.
- Verse API Updates for Spawner Devices

  - We've expanded the Verse capabilities for the NPC, Wildlife, Guard, and Creature Spawner devices. The changes add the ability to spawn one of these agents at a specified position, requiring fewer devices.
  - The Wildlife and Guard Spawner devices have also reflected device properties to Verse, such as Damage, Speed, and Health attributes, so that Verse scripts can modify them during runtime.

**Fixes**:

- Updated the Guard Spawner and NPC Spawner to allow **Despawn on Disabled Device**. Removed the **IsEnabled** check when trying to despawn NPCs so the Despawn API / event can be executed when the device is disabled.
- Fixed an issue where the teleporter applied impulse instead of direct velocity.
- Fixed an issue where the teleporter was teleporting constantly.
- Fixed an issue where the air vent was playing visual effects constantly. This also fixed anything that uses the FortPhysicsImpulseComponent and OnPhysicsImpulseOverlapTriggered.
- Fixed an issue with the modal popup in Matchmaking Portal never displaying if the island will split teams.
- Fixed VFX/SFX retriggering on prop collision for the Bouncer Gallery.
- Fixed VFX/SFX retriggering on prop collision with Crash Pad.
- Fixed an issue where the HUD Controller (Verse) was not hiding resources when calling HideElements with `creative_hud_identifier_all`.
- Fixed an issue with the HUD Controller (Verse) where `GetHUDController()` reset the visibility of everything previously hidden when calling `GetPlayspace()`.

## Known Issues

- Typhoon Blade and The Kneecaper fail to activate their tactical sprint.
- For islands that set the **Post Game Type** to **Custom**, the post match screen is not navigable and input is not recoverable.  Players must open the Overlay to return to the lobby.
- Some assets in the new Chapter Seven galleries show glass in UEFN which will not appear when the island is published. This is due to them containing “breakable glass” that is not compatible with UEFN.
- Some assets within the new galleries for this release exhibit the following known issues:

  - Resource Type = Blank
  - Misalignment of some assets (floating or slightly underground when using grid-snap)
  - Invisible or missing collision
  - Preview missing when using the Phone Tool
  - Incorrect or missing icon
  - Incorrect or inconsistent texture present on asset
  - Asset unselectable in VK-Edit (specifically, chainlink fence doors)

## UEFN Updates and Fixes

**New**:

- Added the **Ignore Devices** filter to the **Find Overlapping tool** in **Fortnite Tools** to prevent finding devices based on various matches to Class Path.
- When detecting corrupt installation files on startup, a dialog to ask for a validation through Epic Games Store is shown.
- Added validation support that checks for enum properties with missing or invalid enumerator values. Added localization support in the Verse property validator's messages.
- Simplified physics constraints user options to match those of UE. Removed the **Lock Axis** option. Had to update some users as well as provide a refresh of the details customization now that the options are gone.

**Fixes**:

- Fixed an issue where VFX did not appear when adding an entity to the quick bar.
- Fixed cut action breaking verse references in Live Edit.
- Fixed an issue where making changes to large numbers of objects at once in a Fortnite client during an edit session could cause performance issues in UEFN.
- Fixed entities having larger drop shadows than actors when using the same mesh.

### Audio

**Fixes**:

- Fixed the `==` operator on `FSoundAttenuationSettings`.
- Fixed the `PlaySoundAtLocation()` function playing the sound on very low attenuation settings. Put in a way to pull the attenuation settings from the sound asset.

### Editor

New:

- Added the **device** token to default working and download directories for the Capture Manager, which are editable in the Live Link Hub.
- Switched to camera-relative vertical panning by default. Added an option for world-based vertical panning.
- Added visibility function versions that work on the selected actor's hierarchy, and set **H**as the default to toggle the selected hierarchy.
- Chaos Visual Debugger Scene Outliner now updates during playback by default.
- Changed **Browse Live Sessions Menu** to **ToolMenu** in the Chaos Visual Debugger.
- Changed the default of `bUseLinkedOrthographicViewports` to **False**.
- Added example calibration generation Python script for MetaHumans.
- Added tooltips to ingest the job status icon for the Capture Manager.
- Added an example stereo ingest device script for the Capture Manager.
- Removed redundant ActorFolders refresh calls, improving load times of maps with nested level Instances.
- Added a new Toggle Selected Actor Visibility command and behavior. This command takes the default H binding from Hide Selected Actors. The command hides selected actors if any actors in the selection are visible or shows selected actors if all actors in the selection are hidden, or does not affect selection.

**Fixes**:

- Fixed a potential crash in map-error checking where an ABrush had a null Polys reference.
- Fixed an inconsistency in the viewport right-click context menu where the Transform options were ordered as FLU rather than the expected LUF.
- Fixed a crash when loading content from a corrupted .pak file or optional segment files.
- Fixed a bug where viewports could control the movement of a locked actor in a different viewport.
- Fixed an issue where assets were missing in the content browser due to incorrect settings.
- Fixed a regression that caused middle-clicking in the level editor viewport to select objects.
- Fixed a crash when opening the Dataprep Asset.
- Fixed console variables not being included in the Help command.
- Fixed broken gizmo and spline occlusion dithering.
- Fixed an issue where Spline-related UI elements were displaying XYZ instead of LUF.

### Editor UI

**New**:

- Added the Editor Setting **Scale Asset Picker Widget Size** to allow the size of asset pickers to be scaled up or down.
- Default Project Names can now use {Timestamp} and {Version} macros.
- Added a Project Products Catalog to visual products defined in Verse.
- Enabled optional overlay over the tree view widget in the subobject editor.
- Improved the login window.
- Added support for an optional name suffix which can be rendered differently than the name for ObjectNameEditSink.
- Made the **Show Selected** action for actors always visible in the context menu. Added **can execute** handlers for Hide & Show Selected actions.
- Refactored the camera speed to be based on a single float value within min and max values.
- Added support for direct manipulation of editor viewport orthographic near and far planes. Added a new **Editor Viewport Depth Bar** that allows visual control over those planes. The depth bar supports displaying custom widgets that are automatically arranged by depth. This is used in the Level Viewport Client to display selected objects along the depth bar. These features can be revealed using the `r.Editor.ManualOrthoDepth 1` CVar.
- The camera speed min/max is now separated into absolute and UI min/max values. The camera min/max UI is now found in the camera speed menu. Added a shortcut to the viewport settings page.
- Enabled the optional overlay widget on the tree view in `SSubobjectBlueprintEditor`, similar to `SSubobjectInstanceEditor`.
- Added a `DetailNameAreaObjectFilter` to control which objects are sent to the `DetailNameArea` in the Details panel.

- Added Reusable Settings Asset for FastGeo transformers in the World Settings panel.
- Updated the UEFN application title to Unreal Editor for Fortnite.
- Added a **Save Assets** button to the context menu on changelists and items. The button dynamically enables only if unsaved assets exist in the changelist, and only saves assets within the selected changelist (instead of  all assets). No icon is used, consistent with other context menu entries.

**Fixes**:

- When displaying the **Island Conversion Failed** message box, the raw error message is no longer displayed. Instead, the user gets a message to look at the Output Log.
- Fixed an issue where UEFN was using the UE application icon.
- Fixed Prefab Editor outliner rows disappearing on autosave.
- Fixed an issue where the **tint** value was reset every time the configuration menu was opened for Film Overlays.

### Environments and Landscapes

**New**:

- Landscape edit layers weight-blending improvements:

  - **None**, previously **No Weight Blend Final Weight Blending**.
  - **Advanced Weight Blending**, previously Premultiplied Alpha Blending: an improved weight blending solution that is compatible with edit layers and is applied at every blend step of the merge algorithm instead of at the very end. It relies on the weight sum of the blend group of the current layer as the alpha value.
  - Removed the landscape layer info submenu to create a **Non-Weight Blended** **or Weight Blended**: there is now a new landscape setting that defines which one is the default. The blend settings moved to the landscape layer info asset. Advanced Weight Blending also has the concept of a blend group, to let certain layers be weight-blended with each other but remain additive against others.
  - Added **Sort by Blend Method** option in the target layers list of the landscape paint panel.

Fixes:

- Removed landscape **paint-time weight balancing** for the legacy weight blending layers.
- Fixed landscape painting when toggling **invert** during brush stroke.
- Fixed landscape flatten tool behavior at edges of geometry.
- Fixed landscape final (legacy) weight blending, introducing ghosting artefacts in weightmaps.
- Fixed landscape flatten tool conflict with undo.
- Added refined Water Body underwater detection to avoid applying post processing when the camera is underneath or outside the bounds of the collision volume.
- Fixed deleted landscape spline points/segments coming back after duplicating the spline.
- Fixed a crash and visual errors when importing landscape weightmap images of a different size than the landscape.
- Fixed a crash when auto-filling target layers from material.
- Fixed assert when deleting many landscape spline control points at once.
- Landscape add component tool fixes:

  - Extrapolated height data is properly generated on each persistent edit layer so that there's continuity on the corners on each.
  - Delayed the collision generation until the merge, since that's the first time the collision values would be valid.
  - Existing neighboring components are no longer dirtied when adding a new component.
  - Splines are automatically applied after component creation, so that new components are immediately affected by the splines that overlap with them.
  - Visualizer for a component about to be added is improved.

### In-Game UI

**New**:

- Added support for adding color and color\_alpha variables with UMG Verse Class Editor.

### Materials

**New**:

- Improved Mask Nodes tooltip information to reflect which ones lead to new permutations. The changes have been made to the ChannelMask Parameter node and the StaticComponentMask Parameter node.
- Improved the Material Instance Parameter tooltip to show all parameter override sources.
- Made material editor log errors hyperlinks to represent that they can be clicked to go to the issue.
- Optimized performance for Material Instance Editor being opened. Average 20% performance improvement.
- Added **Select Focused Nodes** feature to the **Hide Unrelated Nodes** mode for the Material Editor. This adds an entry that allows selection to happen on all the nodes that are focused, based on the options selected for Hide Unrelated Nodes.
- Improved tooltip present in Material Editor Context Menu for Material Functions to also show the asset path.

**Fixes**:

- Changed `UMaterialFunctionInterface` to include the BlueprintType annotation.
- Fixed a crash that occurred when the material parent of an instance was changed through scripting.
- Fixed an uncommon crash in a lerp material expression when the alpha pin was connected to a non-primitive output.
- Fixed `UMaterialExpressionParticleSubUV::Compile` bug that caused the node not to use the texture object connected to the Texture input pin.
- Fixed the ShadingModel material expression in-node combobox to display only valid shading model entries.

### Modeling

**New**:

- Modeling Tools improvements:

  - Replaced the sculpt and sculpt max brushes with ones that only use the stamp normal for application, which typically is less likely to break meshes.
  - Renamed old brushes to **inflate (stroke)** and **inflate max**.
  - Exposed the brush update method for overriding in the vertex sculpt tool, and added some comments describing brushes.
- The Paint Vertex tool now supports a symmetry option.
- Added support for the tangents tool to choose the reference UV layer to use when computing tangents.
- Added options for the mesh simplify tool to drive simplification by a weight map.
- Enabled snapping on the free translation gizmo.
- The Inspect tool can now be used on skeletal meshes.
- Added separate options for erase and smooth in the paint tool, and added support pressure sensitivity.
- The MeshAttributePaintTool now supports a BrushValue property that allows users to specify the target value that is painted rather than always accumulating to 1.0.
- The MeshAttributePaintTool now supports a HitBackfaces option.
- Added **assign** and **start new keyboard** commands to the cube grid.
- Improved the modeling mode Simplify tool results on planar regions by adding an optional small regularization term.

**Fixes**:

- Fixed the spacing mode in sculpt tools, which behaved poorly when moving across ridges.
- Fixed a localization issue for the **Advanced Transform** category label in the UV Editor.
- Fixed a crash in the modeling mode **Convert** tool on converting multiple dynamic meshes to static mesh.
- Fixed CubeGrid **Accept and Start New** action not working correctly when editing an existing asset.
- Fixed a crash when hovering over Mesh Element Selection before a viewport is focused for the first time in an editor session.
- Made real-time warning for modeling mode and scriptable tools mode only update when the app has focus, to avoid unnecessary warnings when the **background** **task** override disables real-time mode.
- Fixed brush stamps skewing on meshes with non-uniform scale in the MeshAttributePaintTool.
- Fixed PivotActorTool crashing when run on an actor whose root component is not a primitive component.
- Reduced confusion during displace tool computations by adding a slight delay to the appearance of the **in progress** material.
- Addressed a bug that displayed random gizmo orientation in local space in the PolyEdit tool.

### Physics

**New**:

- Rigid Body with Control Anim Node now supports selecting the physics collision types that a world physics object must have in order to be included in the immediate physics simulation. This allows users to include objects that have the Physics, Query or Probe collision types.

**Fixes**:

- Fixed an issue where the `SetPhysicsLinearVelocity()` call wasn’t doing what was expected.

### Visual Effects

**New**:

- Added a C++ fallback option for Niagara version upgrade scripts, which is used in case Python is not available.

**Fixes**:

- Fixed an issue where SFX and VFX were not reactivated when their network relevancy changed. This could typically occur at the start of a match.

## Scene Graph

**New**:

- Agent now a subclasses entity. Agents are injected into the scene graph when they join and leave.
- The property matrix now shows entity components when `PropertyEditor.AllowPropertyMatrixForNonActors` is true. Note that most items are still read-only due to customizations that are currently used.
- Made improvements to the Prefab Editor behavior:

  - Added CVars to control the prefab editor
  - The focus is now on the root entity when first opening the prefab editor.
  - The viewport refreshes when adding or removing a component.
  - Updated the gizmo on transform manipulations in detail panel.
- Introduced surface alignment for drag and drop in Prefab editor. Improved surface alignment for entities.
- EntityPrefab editor now selects placed entities after viewport drag and drop.
- Added an option to create a prefab subclass from the content drawer context menu.
- Added automatic filters for components (native and custom).
- Enabled creating a new prefab subclass from existing prefab within the Prefab Editor.
- The Prefab Editor now has real-time updates enabled by default.
- Entity hierarchies can now be selected to use the **Save as Prefab/Group** options in the context menu. Grouping has been improved so that children can be selected without undoing the hierarchy and having orphaned selected children will now disable the options.
- Clicking on an entity now selects the parent prefab for the Prefab Editor.
- Added the **Group Under New Entity** menu item to the context menu of the Entity Prefab Editor.
- When selecting multiple entities that have the same asset component in the Entity Editor, the thumbnail in the Details panel shows the common asset.

**Fixes**:

- Functions that relied on overloads between agent and entity will fail to compile in v38.00 and beyond. The recommendation is to create a single function that only takes an entity, or rename one of the colliding functions.
- Aliases in Content package can now feed into the reinstancing queue and redirector array. This allows users to define class aliases and have the editor understand how to redirect existing usages in the project, just like asset redirectors. It requires UEFN redirectors to be enabled, which is currently experimental.
- Fixed build breaks in ExampleNetworkIngestDevice for the Capture Manager.
- The display name for `verse::rotation` editable property is now based on the variable name, and inside the Transform Component is still called **rotation**.
- Fixed entities in the level not colliding with the viewport placement of actors and entities.
- We now send all components within a prefab that's missing its class on the server when creating it via LiveEdit.
- Fixed a crash occurring when ingesting with the `-nosound` argument.
- Fixed erroneous behavior for duplication of prefabs with children.
- Fixed an issue where localization data may not appear in-game when using the **Build Localization** workflow via **Upload to Private Version** or **Publish Project**.
- Players are now available in the simulation as soon as they are added to the playspace. Previously, players were added at login. This should not have any influence on UEFN, just VersePrototypes.

### Prefab Editor

- Introduced custom columns and component filters in the Prefab Editor outliner to bring it in line with the world outliner functionality.
- Fixed issues where the Prefab Editor outliner could lose its content when saving other prefabs.
- Opening the Prefab Editor window now focuses on the root entity and selects it.
- Selecting an entity in the prefab editor now correctly focuses the outliner onto it.
- You can select multiple entities and use Save as Prefab to create a prefab of the selection under a new root entity.
- You can now select Group under new entity inside the prefab editor to create subclasses of entities.
- The Create prefab button is available in the prefab editor while selecting the root so you can more easily sub-class an entire entity.
- Creating a new Verse component inside the prefab editor now properly adds it to the selected entity automatically.
- The Prefab Editor’s viewport is now set to Real-time by default.
- The Prefab Editor viewer selection hierarchy is now properly respected as it is in the world viewer. Each click on an entity/prefab will bring you a level deeper.

### Entities

- Static mesh component assets now have a **Hidden in game** flag.
- Entities can now snap to vertices, and snap-to-surface behavior has been improved.
- Disabled the ability to use the property matrix with entities and components, until the scene graph implementation can be properly fixed.
- Fixed a situation where duplicating a prefab removed all overrides on its copy.

### Scene Graph Known Issues

**Scene Events is still in Experimental**

Due to an unexpected issue, Scene Events is still considered Experimental, even though the experimental tag in the API is removed. If you attempt to launch a Live Edit session with the API in use, the session will fail and you will receive a compile error. This includes any projects that worked previously to the 39.00 release using this API. A fix for this issue is targeted for an upcoming release.

**Workaround:** For projects that have advanced implementations with Scene Events, particularly with Custom Items, we recommend waiting for the fix to be implemented. Otherwise, you may  want to remove the code from your project.

To properly remove Scene Events from your project, you need to remove references to the following:

- `scene_event`
- `scene_event_participant`
- `base_entity.SendUp`

Additionally, any islands with Custom Items code that is overriding the `SendUp` function will also be unable to launch a session. You will need to remove this function in order to playtest.

## Unreal Revision Control

**New**:

- Made improvements to decrease the complexity, frequency, and duration of various revision control operations.

**Fixes**:

- Fixed an issue causing Japanese snapshot messages to appear incorrectly.
- Updated the URC with various fixes to lessen the chances of local URC folder corruption leading to the intermittent need to delete and regenerate a local URC folder.
- Fixed an issue causing the **Sync Latest** button to temporarily become active after a background revision control operation completes.
- Fixed an issue causing **Keep Files Checked Out** functionality upon submit to not work for newly added assets.

## Verse Updates and Fixes

**Fixes**:

- Fixed an issue where some asset types, when exposed with `@editable`, would not update when assigned to a value other than their default.

### API

**New**:

- Added Verse API for **Reboot Van** device

**Fixes**:

- Fixed a Creative prop asset scale not being respected when spawning Blueprint-defined props via SpawnProp.
- Fixed NaN-related issues with prop Verse transformations such as spawning props, animating props and moving props.

### Language

**Fixes**:

- Constructing an instance of `concrete_subtype(some_class)` now has the transacts effect, as the specific subtype of `some_class` may have greater effects than `some_class`.

### Tools

**New**:

- Added `@editable` support for `classifiable_subset(tag)`.
