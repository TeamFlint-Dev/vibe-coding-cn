# 27.00 Release Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/27-00-release-notes-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:32:22.607690

---

## 27.10 What's New

See the [Fortnite Ecosystem Patch Notes - V27.10 Update](https://create.fortnite.com/news/fortnite-ecosystem-v27-10-update) for the latest news and release highlights.

## Creative

**New:**

- Added **lock** and **unlock** controls for IARC rating into the Creative Feedback widget.
- Added interface which allows the Creative Feedback widget to stay open when cursor mode changes.
- Added a cursor mode call when a party member needs to unlock an island code.

**Fixes:**

- Fixed an infinite spinning wheel that occurred when a user opened Events and Functions tabs.
- Fixed converted HUD Controller and Teleporter options.
- Fixed an issue where stakes from the Wood Stake Shotgun wouldn't be instantly removed from objects on destruction.

## Creative and UEFN

**Fixes:**

- Fixed an issue where players on different teams spawned together when islands didn't have a Player Spawner device set at island start.
- Fixed an issue where two Advanced Storm Controllers were shown in the Content Browser.
- Fixed an issue where the **On Team Is Out Of Respawns** event in the Team Settings and Inventory device was not triggering when players out of lives spawned on a different team.
- Fixed an issue where the Damage Volume device failed to damage guards.

### Fortnite Patchwork

**New:**

- Added a copyright disclaimer to the publish workflow and device details in UEFN.
- Higher-end texture settings on a PC will now show higher quality audio cable visualizations on Patchwork devices.

**Fixes:**

- Fixed an issue where two slightly different versions of the same audio would appear to be playing when cutting and pasting Patchwork devices.
- Fixed the Speaker SFX ducking signal chain.
- Updated the Instrument Player (I-PLAY) device patches.
- Changed the Echo Effect (FX-ECHO) device Feedback maximum value to .99.
- Fixed an issue where cables became stuck when players grabbed them.
- Removed knob sounds and balanced the levels of carousel sounds.
- Fixed an issue with the front panel of the Instrument Player (I-PLAY) that was causing the highlighted mesh to extend beyond the Open and Close buttons.
- Fixed an issue that caused environmental Digital Signal Processing to be applied to Patchwork audio.
- Fixed an issue where changing Note Style on the Note Sequencer might change note grid contents.
- Fixed an issue on the Instrument Player and Drum Player where, after switching to a different instrument or drum kit, you would temporarily hear the wrong instrument or kit the next time you connected or disconnected a cable.
- Fixed an issue where the green beat display on the Music Manager wasn't initializing in UEFN.

## UEFN

**Fixes:**

- Reduced the number of cases where spawning props causes the Push Changes button tooltip to show "Some changes may not be reflected in the Edit Session".
- Fixed the color property during live edit of primitive shapes gallery and many other actors.
- Fixed an issue where pressing Play again after a match during testing would receive a few changes from the editor.
- Fixed the toggle for the Actor Hidden in Game property.

## Verse

**Fixes:**

- Truncates the names of tuples created during codegen so that they remain safely under `FName` limits. This is done by allowing the initial portion of the name to remain the same, but hashing any characters over the limit using SHA256 and appending that to the name.
- Decreased the threshold for hashing overly long Verse tuple names since the asset registry also adds its own special prefix which causes such names to go over the `FName` limit and thus fail the cook.

## 27.00 What's New

See the [Fortnite Ecosystem Patch Notes - V27.00 Update](https://create.fortnite.com/news/fortnite-ecosystem-v27.00-update) for the latest news and release highlights.

## Creative

**New:**

- Changed the Loot Controller in Battle Royale Island so that when the **Loot Selection** option is set to **No Loot**, the options that control different types of loot are now hidden.

**Fixes:**

- Fixed an issue in the Battle Royale Island where Heist Bags, Coolers, and certain AIs would drop loot even when the Loot Controller is set to **No Loot**.
- Fixed an issue where the Mounted Turret and Heavy Turret were unaffected by the Shield Breaker EMP.
- Fixed an issue in the Battle Royale Island where Proxy Loot Containers were unaffected by the Loot Controller settings.
- Fixed an issue where grenades from the Sticky Grenade Launcher passed through a Falcon Scout instead of sticking to it.
- Fixed an issue where the effect of a Shield Breaker EMP thrown while editing the island didn't disappear after starting a game.
- Fixed an issue where the Twin Mag Assault Rifle wasn't affected by the Weapon Destruction setting in My Island.
- Explosion damage no longer does full damage to players in vehicles or behind the line of sight of vehicles.
- If the Pizza Party lands on a vehicle, pizza slices now correctly spawn as items in that location.
- Fixed an issue where the Crash Pad or Crash Pad Jr. could be deployed on a D-Launcher device and would block it.

### Devices

**New:**

- Added a new **Enable Ambience Sound** option to allow creators to enable/disable the ambient sound of the Creature Spawner.

**Fixes:**

- The correct sound now plays while repairing tires on vehicles.
- The **Enable Respawn** option on the Boat Spawner device is no longer stuck on **False** when it shouldn't be
- Fixed an issue with Creative devices not saving non-visible options.
- Fixed an issue on the Explosive Barrel device where a barrel triggered by proximity would not send signals to the triggering player.
- Fixed an issue on the Explosive Barrel device where a vehicle wouldn't trigger barrel proximity if it had a passenger that was a valid target but the driver was not.

### Fortnite Patchwork - Known Issues

With the release of Fortnite Patchwork and 14 new devices, we've included a list of known issues and their workarounds.

| Description | Workaround |
| --- | --- |
| When you or another user make changes to a Patchwork device connection, you may hear temporary audio dropouts. | If you have the Patchwork tool equipped when this happens, you should see a progress bar with a speaker icon near your reticle. This progress bar indicates when the audio will resume. We'll be working to reduce or remove these audio drops in the future. |
| Patchwork audio may not play as intended during the pre-game Waiting for Player phase. | None |
| If you carry a Patchwork cable over a long distance, it could disappear. | Even if the cable can't be seen, you should still be able to connect the plug to another device. |
| If you increase the Grid Height user option for a Note Sequencer, and then copy and paste the device, note data in rows above 8 may not be copied. | If this occurs, try restarting your session then copying the device again. |
| When editing sustain notes on the Note Sequencer, you might encounter issues where note input is ignored, or unexpected player camera behavior. | If this occurs, try inputting your sustain notes again. |
| You might see persistent sustain tail visuals when editing sustain notes on a Note Sequencer. | Toggle the affected notes to clear the sustain tails. If you don't clear them, they can prevent you from adding more notes. |
| When changing the Timing Style of a Note Sequencer, the device output may go out of sync with other devices. | If this happens, try disabling and re-enabling the device. |
| When the Auto Page Plays Blank Pages user option is enabled on the Drum Sequencer, the device output may go out of sync with other devices. | To avoid this, try controlling the Drum Sequencer Page knob with a Step Modulator instead of using the Auto Page option. |
| When you patch a disabled LFO device to another device, the targeted control will be set to 0. | After patching the LFO to a new target control, adjust the control as you normally would to set the intended value. |
| After copying and pasting an LFO device, it may only output a value of 0. | If this occurs, delete the affected LFO device and place another, or restart your session. |
| When the Step Modulator is patched to a toggle switch, the VFX Preview above the device displays incorrectly. The VFX indicating toggle on and off positions are reversed. | None needed. The device should still function as intended. |
| If the Value Setter is patched to enable a Sequencer with Looping set to off, using the Value Setter's Delay option may cause the Sequencer to go out of sync with other devices. | None. |
| When pushing changes from UEFN to a Live Edit session, Patchwork will be temporarily inaccessible and will continue to loop audio during the push process. | None--set your Patchwork audio mix to something you like before you push your changes! |
| When placing and moving Patchwork devices in a UEFN Live Edit session, you might encounter graphical issues like Patchwork device screen elements not moving with their devices or devices failing to open and close. | If this occurs, pushing your changes from UEFN should fix the issues. |
| When starting and ending a game in a UEFN Live Edit session, Patchwork cables may become invisible. | Restarting the Live Edit session should fix this. |
| When starting and ending a game in a UEFN Live Edit session, the key of your Patchwork audio may change unexpectedly. | Place a Patchwork Music Manager device to prevent this from happening. |
| After ending a game in a UEFN Live Edit session, note data on Note Sequencer devices may change unexpectedly. | Editing any note on the device's Note Grid should restore your note data. |
| The values for the Patchwork Note Sequencer, LFO Modulator, and Step Modulator devices' Rate user options do not appear in UEFN, A number entry field is shown instead. | Set the Rate in a Live Edit session, or enter the value corresponding to the Rate you want from the list below:   - 32 Bars: 128.00 - 16 Bars: 64.00 - 8 Bars: 32.00 - 4 Bars: 16.00 - 2 Bars: 8.00 - 1 Bar: 4.00 - 1/2 Note: 2.00 - 1/4 Note: 1.00 - 1/8 Note: 0.50 - 1/16 Note: 0.250 - 1/32 Note: 0.125 - 1/64 Note: 0.0625 - Free: 0.0000 |
| You may hear the wrong instrument playing if you changed the instrument on the Instrument Player and then made changes to the cable connections. | If this occurs, disconnect and reconnect the cables. |

## UEFN

**New:**

- Exposed an initial subset of Editor Keyboard Shortcut Bindings in UEFN. You can access them via Editor Preferences > Keyboard Shortcuts
- Exposed an initial subset of input bindings to UEFN.
- Reduced cases where the push changes button turns yellow on spawning some props with the warning: **Some changes may not be reflected in the Edit Session**.

**Fixes:**

- Fixed issue with My Island settings not updating when values changed in UEFN.
- Fixed a performance issue for loading or reloading maps when objects are scaled to very large sizes.
- Fixed an issue where the screen sometimes would stay black indefinitely after teleporting a character.
- Fixed an issue where garbage collection caused UEFN to crash in Sequencer.
- Fixed multiple edge cases and situations regarding how the Camera Cut track restores the pre-animated view target when a sequence is finished. This affects both the in-game and in-editor behavior of the Camera Cut track.
- Fixed UEFN crashing when importing ADPCM audio files.
- Fixed several issues related to the Project Browser:

  - Putting a `.uefnproject` at the root of the default project location no longer makes local projects disappear from the project browser.
  - Fixed an infinite loading issue with the project browser if the user is not logged in while opening the project browser.
  - Fixed window size overflow issues with the project browser for computers set to smaller resolutions and higher font scaling settings.
- Actors set to **Hidden in Game** are now correctly hidden in live edit.
- Fixed the UI so that the Push Changes button changes to a yellow state when loading a new level.
- Fixed an issue with published watermarks not showing on HUD.
- Fixed a crash that could occur in the modeling mode Dynamic Sculpt tool if a user attempted to undo a brush stroke while drawing it.

### Devices

**New**

- Auto Play Minigame State in the Cinematic Sequence Device is now **Enabled on Phase**. This includes:

  - Always - Any minigame state
  - PreGameOnly - EFortMinigameState::PreGame (island in read only state)
  - GameplayOnly - EFortMinigameState::InProgress
  - CreateOnly - EFortMinigameState::PreGame (island is NOT in read only state)
- Changed the autoplay behavior in the Cinematic Sequence Device so that the sequence stops playing when states change.
- Added **Finish Completion State Override** to the Cinematic Sequence Device options to control whether the state for the entire sequence should be kept or restored when the sequence finishes playing.
- Updated the Auto Play Minigame state to automatically be set to **PreGameOnly** if it was previously set to PreGame and GameplayOnly if device was InProgress.

**Fixes:**

- Fixed an issue for the Race Manager where an internal Verse error caused respawning when the race started.

## Verse

**New:**

- Disabled argument modifier evaluation for user-facing text defined in Verse.

**Fixes:**

- Fixed an issue when calling `ReleasePhysicsBoulder` that caused a Verse internal error.
- Definitions now correctly check for public accessibility as well as possible overriding definitions.
- Fixed an issue where a device would fail to be assigned to an @editable property in the property grid.

### API

**New:**

- Support Print for `verse::message`.
- Player Counter Device - `IsCounted[Agent:agent]` will now succeed correctly if the agent is counted.
