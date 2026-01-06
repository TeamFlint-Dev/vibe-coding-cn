# 33.30 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/33.30-fortnite-ecosystem-updates-and-release-notes-in-creative-and-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:35:24.696864

---

The v33.30 update introduces the LEGO® Brick Grid Island starter plot, making it easier to bring the magic of LEGO bricks to your LEGO islands. We’ve also enabled more devices for use in LEGO Islands.

Plus, Engagement Payout Estimates are now available in the Monetization tab of your islands in the Creator Portal.

## LEGO® Brick Grid Island

Use this new starter template to add the magic of LEGO bricks to your primitives and environments. The island’s brick grid makes it easier to align assets in the viewport.

With grid-snapping active and set to 256 or lower, all LEGO building actors can snap accurately along the grid.

You can use the new material asset by opening the LEGO® Brick Grid Island template from the UEFN Launcher. The grid material assets are also available on the new Plane and Cube props.

## New Devices Available in LEGO(R) Islands

We have enabled several more devices to be utilized in LEGO Islands:

- Skilled Interaction device
- Stat Creator device
- Stat Counter device
- Conversation device

## Fortnite Engagement Payout Estimates Now Available in Creator Portal

Engagement Payout Estimates are now available in the Monetization tab of the Creator Portal. You can track your previous payouts with daily and monthly breakdowns, which helps to more precisely monitor changes over time.

These estimates, based on available data, provide an approximation of your potential payouts.

**Please note:** Payout estimates are not guaranteed and are subject to change. Check out the [blog post]([https://create.fortnite.com/news/fortnite-engagement-payout-estimates-now-available](https://create.fortnite.com/news/fortnite-engagement-payout-estimates-now-available)) for more information.

## Vehicle Mod Box Spawner Device Updates

The Vehicle Mod Box Spawner has a new setting named **No Mod** that can trigger a new **On No Mod** event that you can use to create custom events.

You can also use the new setting in Verse with the NoModEvent. Now, when mod boxes are destroyed in-game, the NoModEvent can open doors, apply damage to enemies, or any other mechanics you can imagine!

The user option **Visual Style** was renamed **Overall Visual Style**. This setting makes it possible to customize the look of the mod box by changing:

- Paint Color
- Icon
- Icon Color
- Icon Scale

These options exist for Overall Visual Style, which applies to non-**Custom List** mod boxes, as well as each **Custom List** entry. Each Custom List entry can also be set to use the Overall Visual Style settings.

Using Verse, you can apply vehicle mods by creating a custom list of mods in the device then calling that list with an array in your Verse code. You can also use Verse to modify the look of the mod boxes.

**New Verse Events, Arrays, and Variables:**

- NoModEvent
- ModBoxCustomListSettings
- ModBoxOverallSettings

You can use the ModBoxOverallSettings variable and the ModBoxCustomListSettings array to change the values of the mod box, specifically its color and icon using the same values listed above.

## New Prefabs & Galleries

- Added 2 New **Redline Rig Prefabs**:

  - Redline Rig Platform
  - Redline Rig Drill
- Added 5 New **Redline Rig Galleries**:

  - Redline Rig Prop Gallery A
  - Redline Rig Prop Gallery B
  - Redline Rig Prop Gallery C
  - Redline Rig Floor & Stair Gallery
  - Redline Rig Wall & Roof Gallery

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed a useability issue with the Rocket Racing Car Spawner:

  - [Forum Issue Report](https://forums.unrealengine.com/t/critical-bug-v33-00-rendered-rr-car-spawner-completely-unusable/2161260)
- Fixed an issue where poison and spike traps appear red on maps and not register on walls, floors, or ceilings. When playtesting, the traps wouldn’t function either:

  - [Forum Issue Report](https://forums.unrealengine.com/t/spike-traps-and-poison-traps-will-not-place-in-v33-10/2198906)
- Fixed an issue where islands would break during a playtesting session:

  - [Forum Issue Report](https://forums.unrealengine.com/t/starting-and-stopping-a-game-in-session-flips-all-my-props/2200071)
- Fixed an issue where building in Creative during an edit session wouldn’t sync and render properly in UEFN:

  - [Forum Issue Report](https://forums.unrealengine.com/t/uefn-and-creative-not-syncing-builds-correctly/2254386)

## Fortnite Ecosystem Updates and Fixes

### Prefab & Gallery Bug Fixes

- Fixed an issue where all singular assets from Megalodon did not correctly display in the content window or content browser.
- Fixed an issue where the preview boundary for the Japanese Temple Prop Gallery was too large.
- Fixed an issue with the Bushido Base Roof Gallery where some singular roof asset icons did not display the asset correctly.

### Fortnite Ecosystem Known Issues

- Prop Hunt Feature Template fails validation and fails to launch the edit session. A fix is coming in 34.00.

**New:**

- New memory calculation now optimizes for large worlds and sample location generation. In some cases, this results in greatly reduced memory calculation times.
- Added an Audio section filter for components in the Details panel.

**Fixes:**

- The Earth Sprite device can no longer be used with Prop-o-Matic devices.
- Guard NPCs can now use the Hunting Rifle (Rare).
- Fixed a bug where weapons could be used with Cloak Gauntlets after modifying cosmetics in a Changing Booth.
- Fixed an issue with the Prop-O-Matic device where the user prop appeared at a different size for other users compared to its target when viewed from a great distance.
- Fixed an issue with the Changing Booth device where users in Changing Booths could not interact with devices when the pre-game countdown ended.
- Fixed a bug where dirty navigation areas could accumulate indefinitely and cause an out-of-memory server crash after a long level edit session in UEFN or Creative.
- Fixed an occasional crash caused by editing patrols in the AI Patrol Path device from Creative or UEFN.

### LEGO® Islands

**Fixes:**

- Changed the default timing for two of the LEGO® starter islands templates to 0.0s. This is more in-line with other UEFN templates and makes iteration faster.

### Editor

**New:**

- Added an Audio section filter for actors in the Detail panels.

**Fixes:**

- Fixed a bug that resulted in a crash when clicking the **Copy Verse Build Errors Dialog to Clipboard** button.
- Fixed a bug that caused attachment issues for traps in UEFN and LiveEdit.
- Fixed an issue where the editor crashes when changing or reloading a level with the Material Editor open.
- Fixed an editor loading bug where, after selecting **Undo,** the editor would become tangled in transactions, causing a potential crash or unwanted side effects.
- Fixed an issue where destroying a building actor using the Phone Tool would also destroy attached actors — for example: traps, chests and more.
- Fixed a bug where moving the TakeRecorder camera resulted in improperly recorded movements in UEFN.

### Audio

**Fixes:**

- Fixed an issue where the ADSR Envelope MetaSound node would only trigger OnSustain if the Decay stage was more than 0 seconds long
