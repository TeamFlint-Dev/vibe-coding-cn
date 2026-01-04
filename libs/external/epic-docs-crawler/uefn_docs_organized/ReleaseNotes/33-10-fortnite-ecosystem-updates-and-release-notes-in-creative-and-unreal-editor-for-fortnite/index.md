# 33.10 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/33-10-fortnite-ecosystem-updates-and-release-notes-in-creative-and-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:35:32.180234

---

Get ready to publish your Fortnite islands using the First Person Camera device. Publishing for these islands unlocks tomorrow! Also with v33.10 you’ll find new options for player communication in your islands with text chat now available and more ways to grow your following with players now able to access Creator Pages in the Fortnite client.

## Publish Your Islands Using the First Person Camera Device Tomorrow!

It’s almost time! Starting tomorrow, **December 11** **at 9 A.M. Eastern Time (ET)**, you can publish your Fortnite islands using the First Person Camera device. We’re excited to see your first-person shooters, tactical games, horror adventures, and everything else you’ve created with this new point of view. [Submit your island](https://create.fortnite.com/welcome)!

Use the First Person Camera device with the new set of Ballistic Weapons special-made for first-person experiences. Read more about the new weapons below.

## Reminder: Retiring the Old Time of Day Manager and Skydome Device

The Fortnite Creative S14 Time of Day Manager (TODM) and Skydome device are being retired in an upcoming release. This change affects islands using the Skydome device to create custom lighting.

It is recommended to convert all Islands you wish to preserve to the new TODM now. This will give you ample time to adjust the visuals and ensure the conversion is working properly for you.

Converting your island to the new TODM is a **one-way conversion**. Back up your island before upgrading.

## New Text Chat Experience in Fortnite

**Text chat** has been redesigned and is now available for all Fortnite islands, offering greater flexibility to customize chat settings for your islands.

In addition to voice chat, you can now customize text chat settings for your island’s **Game Channel**, choosing to enable text chat for all players, limit it to teammates only, or disable it entirely. By default, your island’s text chat settings align with your voice chat settings, and you can customize them in the **Island Settings** under **Text Chat**. These new chat options open up exciting opportunities for role playing, and enhance player coordination.

## New Locomotion Preset Island Setting

The new **Locomotion Preset** setting allows creators to quickly adopt and inherit locomotion from either Battle Royale or Ballistic. Creators will notice other locomotion island settings ([Player Movement] (https://dev.epicgames.com/documentation/en-us/fortnite-creative/player-movement-in-fortnite-creative)) are disabled when using either preset value. This affects the following Player Movement settings:

- Energy Max
- Energy Recharge Amount
- Energy Recharge Delay
- Fall Damage
- Fall Damage Type
- Jump Fatigue
- Allow Mantling
- PBWs Generate Ledges
- Mantling Minimum Height
- Mantling Minimum Height in Water
- Allow Hurdling
- Allow Sprinting
- Sprinting Energy Cost Per Second
- Sprinting Jump Multiplier
- Sprinting Speed Multiplier
- Allow Sliding
- Allow Slide Kick
- Allow Shoulder Bashing
- Glider Redeploy
- Player Flight
- Player Flight Sprint
- Flight Speed
- Disable Player Collision
- Movement Speed Tunings
- Allow Boosted Jump
- Allow Roll Landing
- Allow Wall Kick
- Allow Wall Scramble

Inherited settings and tuning values will be used, not the values of disabled locomotion island settings. Creators who want finer control of locomotion will use the Custom value, which enables locomotion island settings. Find the new Locomotion Preset settings under Player in the Island Settings.

## Creator Pages Live in Fortnite

Grow your following with Creator Pages, now live in Fortnite. Showcase your islands, feature Creator Picks, and link your socials — all in one place. Players can favorite you, so make your page shine with a custom image, header, and bio.

## Content Browser and Inventory Updates

### OG Weapons

- Burst Assault Rifle
- Striker AR
- Revolver
- Pump Shotgun

### OG Items

- Grenade
- Wall Dynamo
- Ceiling Zapper

### Ballistic Weapons

- Striker AR
- Nemesis AR
- Enforcer AR
- Ranger Pistol
- Hand Cannon
- Hammer Pump Shotgun
- Frenzy Auto Shotgun
- Thunder Burst SMG
- Hyper SMG
- Reaper Sniper Rifle

### Ballistic Items

- Smoke Grenade
- Proximity Mine
- Recon Grenade
- Frag Grenade
- Flashbang
- Bubble Shield
- Impulse Grenade

### Prefabs & Galleries

- Warrior’s Watch Castle
- Flooded Frogs Temple
- Bushido Base Dojo
- Warrior’s Watch Roof Gallery
- Japanese Temples Wall & Fences Gallery
- Japanese Temples Floor & Stair Gallery
- Japanese Temples Prop Gallery
- Flooded Frogs Roof Gallery
- Bushido Base Roof Gallery

### Release Notes

## Community Bug Fixes

The following list of fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed a crash caused by making an island private.

  - [Crash when I try to make a private version…](https://forums.unrealengine.com/t/crash-when-i-try-to-make-a-private-version-i-crash-following-the-memory-calculation/2114869?u=laabouds)
- Fixed issues where islands would stop updating at 99% when matchmaking.

  - [Stuck at Updating 99% when matchmaking] (https://forums.unrealengine.com/t/stuck-at-updating-99-when-matchmaking/2106981)
- Fixed an issue where a conversation would terminate as soon as it began when the conversation involved an infinite loop.

  - [Fortnite session was broken with conversation bank](https://forums.unrealengine.com/t/fortnite-session-was-broken-with-conversation-bank/2117440)
- Fixed an issue where the CH5 terrain wouldn’t allow creators to build on it.

  - [New CH5 terrain disallows fbuilding](https://forums.unrealengine.com/t/new-ch5-terrain-disallows-building/2120081)

## Fortnite Ecosystem Updates

**New**:

- A new Island Setting, **Disable Harvesting Slot**, provides a way to enable and disable the Harvesting Tool slot appearance and selection.
- Creator social handles are now displayed on the Creator Profile Link device.

**Fixes**:

- Fixed an issue where the Fishing Rod items were not showing up in the Creative inventory and were invisible on the island.
- Fixed an issue where the Demon Fire Mask is destroyed after firing a single shot when Infinite Charge is set to On.
- Fixed a bug that caused the Tracker device to become invisible to players joining a game in progress.

### Devices

**New**:

- A new Map Controller device option called **Minimap Rotation Mode** forces the minimap camera to follow the player’s point of view.
- Creator Profile Link Device now displays social handles on the in-world device display.

## UEFN Updates and Fixes

**New**:

- New **Auto Save on Launch** option provides a way to auto-save when launching a new session.
- Reduced the time it takes to open UEFN projects on a cold Derived Data Cache. This improvement is particularly noticeable on large projects.
- Added new and updated Spatial Profiler resolution options to ensure a better resolution and color for all projects:

  - **New** GetViewportViewBounds
  - **New** MaxViewExtentWorldUnits
  - **New** FHeatmapColorProperties - Low Point Color ratio
  - **Updated** InitializeMinimapState
  - **Updated** Cell Size
  - **Updated** GetHeatValueLinear Color
  - **Updated** SpatialProfiler Legend

### Modeling

**New**:

- A new BakeVertex option allows users to reuse existing vertex color topology.

**Fixes**:

- Fixed an issue where HVAC jump pads didn't make an audible sound when players jumped into their updraft.
- Fixed an issue where the UEFN project progress bar loaded to 20% then jumped to 100%.
- Fixed an issue with the Composite Curve Editor that caused a crash.
- Fixed an issue where a dialog would incorrectly report that assets were incompatible when upgrading a MetaHuman in a project that contained multiple MetaHumans.

### Lighting

**Fixes**:

- Fixed a leak in AgcShaderBundles where input buffer memory could be allocated but not freed.

### Materials

**Fixes**:

- Removed the MF\_CreativiveFortniteGameplay material function.

### Animation and Cinematics

**New**:

- Updated the jump and aim animations for position and height when Ballistic Weapons are in use.
- Updated the hand cannon jump animation for Ballistic Weapons.
- A new general pistol tac sprint animation added to the outro for Ballistic Weapons.
