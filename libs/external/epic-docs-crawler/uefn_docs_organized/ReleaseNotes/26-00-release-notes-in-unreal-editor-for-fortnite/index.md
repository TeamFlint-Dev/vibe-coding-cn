# 26.00 Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/26-00-release-notes-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:32:06.246434

---

## 26.30 What's New

See the [Fortnite Ecosystem Patch Notes - V26.30 Update](https://create.fortnite.com/news/fortnite-ecosystem-v26-30-update) for the latest news and release highlights.

## Creative

**Fixes:**

- The Geothermal Vent gallery now opens correctly.
- You can now correctly swing basic weapons on the zipline.
- Loot now drops correctly based on the Loot Controller settings in Creative Royale.
- Fixed an issue where grenades from the Sticky Grenade Launcher passed through a Falcon Scout rather than sticking to it.
- Fixed an issue where using a Changing Booth caused the effect of the Cloak Gauntlet to continue indefinitely.

### Devices

**Fixes:**

- Automated Turrets can no longer be damaged when set to indestructible.
- **Fast Iteration Mode** now migrates correctly when using upgraded devices.
- Players can no longer incorrectly enter changing booths while gliding and blocking controls.

## Creative and UEFN

**Fixes:**

- Fixed an issue where street signs from the Mega City Sign Gallery appeared in greyscale.
- The Grapple Glove reticle now displays correctly.

## UEFN

**New:**

- Added loading behavior options to SoundWave assets.
- Any package pointing to one or more renamed objects is now detected, and the user is prompted to save during upload.
- Material stats on mobile platforms are now enabled by default.
- Material hierarchies now show warnings if derived material instances fail to compile.
- Underwater post-process effects should now render correctly on mobile platforms.

**Fixes:**

- The **Allow Slide Kick** island setting can now be used on published UEFN islands.
- Fixed an issue with montages not replicating what section to play on simulated clients when the 'AbilitySystemComponent' is set to only replicate the current montage section instead of the precise montage position. The current montage section would only be replicated when jumping to a section, and not when naturally transitioning from one section to the next. This has been fixed by ensuring 'SectionIdToPlay' is updated in 'AnimMontage\_UpdateReplicatedData'. 'NextSectionID' is now also used when replicating sections to improve the transition between them.
- Fixed performance and memory issues when some types of actors scaled very large.
- Fixed an issue where cooked assets would try to load waveform transformations.
- Fixed a localization bug in the project browser where the project title for the **Simple** and **Blank** island templates were not localized.
- Fixed an issue where after a match, certain devices were marked as edited when there were no user changes.
- Canceling an upload no longer causes UEFN to get out of sync with the session or disconnect.
- Fixed an issue where local projects were being ignored if there was an additional .uefnproject file at the root of the parent folder.

### Devices

**Fixes:**

- Fixed validation errors related to AI Navigation Modification device usage.

## Verse

**New:**

- Added the ability to set the playback frame or time (in seconds) for a Cinematic Sequence Device in Verse.

### API

**New:**

- Message Feed Device Verse API - Added the ability to activate without an instigating agent for the Message Feed Device.

## 26.20 What's New

See the [Fortnite Ecosystem Patch Notes - V26.20 Update](https://create.fortnite.com/news/fortnite-ecosystem-patch-notes-v26-20-update) for the latest news and release highlights.

## Creative

**Fixes**:

- Bots that spawn in Battle Royale Island matches now use team-size limits to assign themselves to the appropriate team.
- Signs in the **Mega City Sign** **Gallery** now align to grid snap previews.
- The **Geothermal Vent** **Gallery** can now be opened to preview the assets inside.

### Devices

**Fixes**:

- The following **My Island** menu options now migrate correctly when opting into **Upgraded Devices**. Affected options included:

  - Score To End
  - Allow Spectating Other Teams
  - Allow Slide Kick
  - Allow Hurdling
  - HUD Info Type
  - Time Alive Team Tracking Method

## Creative and UEFN

### Devices

**Fixes**:

- Lava Tiles now correctly bounce and damage the player when the option **Is Lava Surface** is set to **Yes**.

## UEFN

**Fixes:**

- Fixed an issue where the **Ch4 Jungle** landscape colored non-Nanite grass in unintentional ways.

### Devices

**New**:

- The **Day Sequence** device now features the **Add FadeIn** and **FadeOut** events.

## 26.10 What's New

See the [Fortnite Ecosystem Patch Notes - V26.10 Update](https://create.fortnite.com/news/fortnite-ecosystem-patch-notes-v26-10-update) for the latest news and release highlights.

## Creative

**New**:

- Fixed an issue where players using a Rocket Ram were unaffected by Teleporter devices.

**Fixes**:

- Fixed an issue where entering the Golden Rift does not initiate matchmaking for a Battle Royale Island.
- Fixed an issue where the Turbo Delete option stayed activated after releasing the button.
- Fixed Last Resort season tag on weapons and items from the current season.
- Fixed an issue where blocking was prevented after using the sword and hammer's secondary attack while blocking.

### Devices

**Fixes**:

- Fixed an issue with the Save Point not saving player inventories when they are eliminated. This avoids exploits that result in duplication of items.
- Fixed an issue with the Player Marker device where the Beacon Particle VFX was not properly appearing around players when Position Update Frequency is set to Constant.
- Fixed an issue with the Player Marker device tooltip for Beacon Style not displaying.
- Fixed an issue with the Player Marker Device where the Beacon Particle VFX that appears around players was not changing to the correct team color.

## Creative and UEFN

**Fixes**:

- Fixed an issue where Show (Any) Resource Count was not working in My Island settings.
- Fixed a case where players joining an island would not be able to see the scoreboard.
- Fixed a case where players joining an island mid-game would be assigned to the wrong team.
- Fixed an issue where players who landed on a Grind Rail after falling from a Rocket Ram could get stuck in the falling animation.

### Devices

**Fixes**:

- Fixed an issue where players joining later in the game saw the Button device as incorrectly enabled.
- To prevent streaming problems, when dashing with the Kinetic Blade, any balloons on the player are removed.
- The Checkbox mesh for the switch device can now be interacted with from both sides.

## UEFN

**Fixes**:

- Fixed validation errors related to using the Pizza Party item.
- Fixed missing Volume modulation parameter in Control Buses.
- Fixed Live Edit disconnecting after ending the game or rapidly placing a large number of buildings.
- Fixed an issue where placing certain Cyber City assets in Live Edit unintentionally spawned sign assets in the editor.

### Devices

**Fixes**:

- Fixed an issue where UEFN maps with the Bomb Flower, Stink Flower, or Slurp Plant could have validation errors.

## 26.00 What's New

See the [Fortnite Ecosystem Patch Notes - V26.00 Update](https://create.fortnite.com/news/fortnite-ecosystem-patch-notes-v26-00-update) for the latest news and release highlights.

## Creative

**Fixes**:

- Replay camera view is now the standard over-the-shoulder, third-person view.
- Items that were showing black material in item previews now use the proper materials.

### Devices

**Fixes**

- The Crash Pad device no longer remains enabled at all times.

## Creative and UEFN

**Fixes**

- You can now properly interact with the Asteria Industrial SlapBottleEmpty asset.
- Fixed audio on player footsteps so they are now heard.

### Devices

**New**:

- The Down But Not Out device features a new user option in UEFN that sets invincibility time when the player is down.
- The Wildlife Spawner device features a new User Option in UEFN that prevents a player from manually dismounting from the wildlife.
- The Beacon device features a new **Backless** badge style and has added support for custom badge widgets.
- The Team Settings & Inventory device has the following new User Options:

  - **On Team Member Spawned** - Activates when any team member is spawned.
  - **Spawn Event Activates for Players** - Determines whether the **On Team Member Spawned** event will activate when players are spawned on the tracked team.
  - **Spawn Event Activates for AI** - Determines whether the **On Team Member Spawned** event will activate when AI are spawned on the tracked team.
- The Signal Remote Manager device features a new broadcast event that works immediately rather than waiting on players.
- The Class Selector device **Change Selector Team** event has been updated with a new description to reflect the intended use.

**Fixes**

- The Wildlife Spawner device now allows players to tame wildlife when the **Riding** option is disabled.
- The Player Reference device now shows player information text on the editor.

## UEFN

**New**:

- Added IK Retargeting in UEFN to transfer animations from one actor to a completely different actor (including imported and custom actors). With the animation retargeted to the correct mannequin, you can then use that animation within your Cinematic Level Sequence or with the Animated Mesh device.
- Support has been added for archiving and unarchiving projects in the project browser with the right-click context menu and toggle button to display archived projects for the current project list (such as "My Projects").

**Fixes**:

- Resolved Validation Errors for the following:

  - Kapok Tree Gallery
  - Rumble Ruins A
  - Rumble Ruins B
  - Shady Stilts Building A
  - Shady Stilts Building B Prefab
  - Slappy Shores Slurp Room Prefab
  - Port-a-Fortress item
  - Launch Pad
- Fixed an issue where the control was not returning to the player after playing a cinematic sequence in the Level Sequencer.
- The account icon next to the username in the project browser is no longer broken when the underlying SVG file is moved.
- Fixed a couple of bugs to do with the Audio Player that could crash the client.

### Devices

**New:**

- The Player Counter device has a feature that registers players to the player counter. These players can either be added to, removed from, or intersected with the normally tracked players to get a final count of players. This new feature adds the following events and options:

  - **Register** - Event that registers a player to the registered player list.
  - **Unregister** - Event that removes a player from the registered player list.
  - **Unregister All** - Event that removes all players from the registered player list.
  - **Count Registered Players** - Determines how the registered player list is used.
  - **Union** - Players tracked by the device **or** in the registered player list are counted.
  - **Intersection** - Players must be tracked by the device **and** be in the registered player list to be counted.
  - **Difference** - Players must be tracked by the device but **not** be in the registered player list to be counted.
- The Cinematic Sequence Device now supports skipping the playback of a cinematic sequence by using the Go To End and Stop function.

**Fixes**:

- The Character device **Bind Pose** option now functions correctly.
- The Collectible Object device no longer sends validation errors related to the **Custom Color** option.
- The Day Sequence device now disables distance blending when using fixed time options for the Day Night Cycle mode. Blending is not supported when using fixed time.

## Verse

### API

**New**:

- The Tracker device features the following new functionality in the Verse API:

  - `GetValue()`, `GetValue(Agent:agent)`, and `GetValue(TeamIndex:int)`\*\* - Returns the value for a specific player, team, or the entire match (depending on tracker settings)
  - `SetValue(Value:int)`, `SetValue(Agent:agent,Value:int)`, and `SetValue(TeamIndex:int,Value:int)` - Sets the value for a specific player, team, or the entire match (depending on the tracker settings).
  - `IsActive(Agent:agent)<decides>` - Is true if the tracker is active for a specific Agent.
  - `HasReachedTarget(Agent)<decides>` - Is true if Agent has reached the TargetValue for the tracker.
- The Prop-O-Matic Manager device features 5 new Verse API events as well as the following new functionality to alter UI Settings in the Verse API:

  - `PingPlayerProps`
  - `PingPlayerProp`
  - `TogglePingProps`
  - `ToggleShowPropsRemaining`
  - `ToggleShowPropPingCooldown`
  - `SetPingProps(On:logic)` - Toggle Pinging props on/off.
  - `SetPingFrequency(Time:float)` - Adjust the ping time.
  - `SetShowPropsRemaining(On:logic)` - Toggle showing the props remaining on the UI.
  - `SetShowPropPingCooldown(On:logic)` - Toggle showing the prop ping cooldown.
  - `PingPlayerProps()` - Manually ping all players that are currently hiding as props.
  - `PingPlayerProp(Agent:agent)` - Manually ping a specific player if they are currently a prop.
  - `IsPlayerProp(Agent:agent)<decides>` - Returns whether or not a player is currently hiding.
- The Powerup device features the following new functionality to track duration, and use player-driven actions in the Verse API:

  - `GetDuration():float` - Returns the duration that a powerup will last if it's applied to an agent.
  - `SetDuration():float` - Sets the duration that a powerup will last if it's applied to an agent.
  - `HasEffect(Agent:agent)<decides>` - Returns true if an agent has this powerup effect applied (or any other matching effect).
  - `GetTimeRemaining(Agent:agent)` - If the agent has this powerup effect applied (or any matching effect), this will return the remaining time that the effect will be active.
- The Health Powerup features the following new functionality that tracks health stats in the Verse API:

  - `GetMagnitude():float` - Returns the amount of health/shield the health powerup will apply.
  - `SetMagnitude():float` - Sets the amount of health/shield the health powerup will apply. Will not apply to any currently applied effects.
- The Damage Amplifier Powerup features the following new functionality that tracks health stats in the Verse API:

  - `GetMagnitude():float` - Returns the damage multiplier the damage amplifier powerup will apply.
  - `SetMagnitude():float` - Sets the damage multiplier the damage amplifier powerup will apply. Will not apply to any currently applied effects.
- The Mutator Zone, Damage Volume, and Skydive Volume devices feature the following new player functionality in the Verse API:

  - `IsInVolume(Agent:agent)<decides>` - This is true if a specific agent is within the bounds of the volume.
- The Player Counter device has new functionality in the Verse API:

  - `GetCount():int` - Returns how many players are currently being counted.
  - `IsPassingTest()<decides>` - Is true when the counter is successful in its count.
  - `IsCounted(Agent:agent)<decides>` - Is true when the agent queried is one of the counted players.
- The Team Settings & Inventory device has new functionality in the Verse API for Agent actions:

  - `IsOnTeam(Agent:agent)<decides>` - Is true when the Agent is on the same team as the device.
- Added `TeleportTo()` support for `fort_character`.
- Added `AngularDistance` function in Verse for rotations.

## Creator Portal

**Fixes**:

- Creators will now see more detailed reasons for rejection mapped to our Creator Rules when an island submission has failed content moderation.
- Creators will also see specific asset path information for UEFN assets causing ASMR review failures, giving creators more agency to address these problems themselves ahead of re-submission.
- You can now sort projects by Most Popular (CCU).
- Team members with a Publish role but no creator code can now publish projects for teams owned by an account that does have a creator code.
