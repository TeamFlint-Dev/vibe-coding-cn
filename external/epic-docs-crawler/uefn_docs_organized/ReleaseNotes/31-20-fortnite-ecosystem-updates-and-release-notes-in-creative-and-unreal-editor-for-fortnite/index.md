# 31.20 Fortnite Ecosystem Updates and Release Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/31-20-fortnite-ecosystem-updates-and-release-notes-in-creative-and-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:36:51.766928

---

The v31.20 update brings the **Village Template** in UEFN for creating cozy village experiences and adds **Control: Side Scroller** support to Fall Guys islands.

## Village Template Is Now Available in UEFN

The Village island is now available as a template in the UEFN Project Browser. Use this template to make your own cozy village experience!

## Fall Guys Islands Now Support the Control: Side Scroller Device

The **Control: Sides Scroller (Side Scroller Controls)** device is now available for Fall Guys islands. See a whole new side to the Bean as you create the side scroller Fall Guys adventure of your dreams!

[![Fall Guys Side Scroller](https://dev.epicgames.com/community/api/documentation/image/90a03d1b-dfe6-402e-8a40-8a9ab890ec13?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/90a03d1b-dfe6-402e-8a40-8a9ab890ec13?resizing_type=fit)

## Texture Validation Errors Update

Texture validation warnings now generate errors, and they can no longer be ignored as of the v31.20 update. If the errors are not corrected, you won't be able to launch your session. Fixing these errors increases the compatibility and stability of your island across platforms.

UEFN offers a built-in way to make your texture sizes conform to UEFN requirements automatically. To do this:

1. In the **Content Browser**, select one or more invalid textures.
2. Right-click a texture thumbnail and choose **Conform Texture** from the menu.

To learn more, see [Resizing Textures in UEFN](https://dev.epicgames.com/documentation/en-us/uefn/resizing-textures-in-unreal-editor-for-fortnite).

## Creative Updates and Fixes

**Fixes:**

- Fixed an issue that prevented the **Chains of Hades** from appearing in the Creative inventory.
- Fixed an issue in Create mode where devices like the Class Designer, with options that overlapped with Island Settings, were incorrectly overwriting the value of the Island Setting of the same name after navigating to Island Settings.
- Fixed an issue where **Input Trigger** Next/Prev Item bindings were flipped for the mouse wheel.

### Devices

**Fixes:**

- Updated the **Distance** option entry steps on the **Decal** device to more easily read values.

## Creative and UEFN Updates and Fixes

### Devices

**Fixes:**

- Fixed an issue where the **Trick Tile** device would sometimes use incorrect textures on targets.
- Fixed an issue that prevented players from traveling between **Hiding Prop** gallery devices after another player used them.
- Fixed incorrect descriptions for the **Item Placer**.
- Added an inventory description to the **Modded Weapon Case Gallery**.
- Fixed an issue with Input Trigger **Pressed** events firing as **Released** events when a user was pressing touch screen buttons.

## UEFN Updates and Fixes

**New:**

- Changed the **!EarlyAccess** devices folder name to **!Beta**.

**Fixes:**

- During texture cooks, resizing now accounts for the RGBA32F Source Data size in the memory estimates.
- Fixed the validation error that occurred when changing the **SearchSpeed** property of Chests.
- New quest bangs, once removed, do not reappear when the client is relaunched.
- Fixed an issue where materials with alpha holdout blend mode failed to cook.
- Validation issues found in textures are now treated as errors instead of warnings.

## Verse Updates and Fixes

### Language

**Fixes:**

- Fixed a bug that caused the server to crash when rolling back compound assignments (`+=`, `-=`, `/=`, `*=`) to local variables.

### API

**Fixes:**

- Teleporting the player no long zeroes out their pitch.
