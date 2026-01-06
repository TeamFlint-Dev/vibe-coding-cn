# 31.10 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/31-10-fortnite-ecosystem-updates-and-release-notes-in-creative-and-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:36:41.242366

---

The v31.10 update introduces new device design examples in the Fortnite Creative documentation, as well as fixes for the issue affecting UEFN experiences converted from Fortnite Creative. We're also replacing the "Early Access" tag with "Beta" to better reflect features that are still in progress but stable enough to use.

## Updated Feature Tags: "Beta" Replaces “Early Access”

We're updating our terminology. The "Early Access" tag will be replaced with "Beta," following Unreal Engine's convention. **Beta** means you're getting early access to features or devices that are still under development, but which are stable enough to use effectively in your published islands. This means you can explore a feature and provide feedback, helping us improve it for final release. The "Experimental" tag remains unchanged, indicating features with no compatibility guarantees, and publishing with Experimental features is still restricted.

## New "Clicks" and "Plays" Metrics in the Creator Portal

You can now track both clicks and plays for your island in the Analytics tab! These new metrics let you see how many clicks your thumbnails are getting and how many times your island is played each day.

[![Track "Clicks" and "Plays" in the Analytics tab](https://dev.epicgames.com/community/api/documentation/image/b3ba2e0f-3c56-4da2-afa8-b41487045581?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3ba2e0f-3c56-4da2-afa8-b41487045581?resizing_type=fit)

## New Device Design Examples

We've added more new device design examples to the [Fortnite Creative documentation](https://dev.epicgames.com/documentation/en-us/fortnite-creative/device-design-examples-in-fortnite-creative?lang=en-US) focusing on different ways to use game mechanics that showcase different Creative devices. The following is the list of new device design examples. Take a look at these examples for inspiration on fresh ways to use Creative devices!

[D-Launcher Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite-creative/d-launcher-device-design-examples-in-fortnite-creative):

- **Parkour Traversal**: Use the D-Launcher as a traversal mechanic in a simple parkour challenge.
- **Hazard Ahead**: Because the D-Launcher device can launch a player in any direction, it also works as a hazard for players to avoid. In this example, players must avoid touching launchers that are set to launch them away from the parkour area.
- **Skeet Shooting**: Launcher devices can launch more than just players — they can also launch wildlife and creatures! This example uses creature-launching, along with a low-gravity function, to create a simple skeet-shooting mini-game.

[Down But Not Out Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite-creative/down-but-not-out-device-design-example):

- **ooperative mountain-climbing game**: In this example, the objective is to occupy the capture area at the mountain's summit for a specified time to win the game, with players working cooperatively to achieve the objective. You will learn how to build a cooperative mountain-climbing game where players have to rely on each other to overcome the dangers of the mountain and reach the summit!

More examples are routinely added to this section of the Creative documentation, so keep a lookout!

## Community Bug Fixes

The following list of fixes is from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed the issue causing Down But Not Out device to no longer work.

  - [Forum Issue Report](https://forums.unrealengine.com/t/down-but-not-out-device-is-no-longer-working/1955009/1)
- The Day Sequence Devices, Skydome Devices, and the legacy **Time of Day** island setting should now behave correctly and no longer reset to default.

  - [Forum Issue Report](https://forums.unrealengine.com/t/time-of-day-acts-like-it-is-set-to-default-overwriting-ignoring-any-settings-devices/1978228/1)
- Long-term fix for Project Size Calculation Failure / Content (re)cook error.

  - [Forum Issue Report](https://forums.unrealengine.com/t/project-size-calculation-failure-content-re-cook-error/1978476)

## Creative Updates and Fixes

**Fixes**:

- Fixed an issue with the Creative content browser where assets were sometimes listed in the wrong categories when editing LEGO® islands.

## Creative and UEFN Updates and Fixes

**New**:

- The **Item Placer** device now has cost functionality, allowing you to set resource costs for items.

### Devices

**Fixes**:

- Fixed several issues with the **Down But Not Out (DNBO)** device:

  - Changed the default value for the **Invert Team Selection** and **Invert Class Selection** options to **False**.
  - Fixed an issue where Team and Class options were not applying to broadcast events. This fix will only apply to newly placed DBNO devices.
- Fixed an issue with the **Channel** device where global events could broadcast multiple times per trigger.
- Fixed an issue with the **Class Selector UI** device where placeholder options were displayed in UEFN.
- Fixed an issue with the **Class Selector UI** device where two options that were available in Creative were not available in UEFN.
- Fixed an issue with the Player Counter device where when the player count changed, it prevented success and failure events from triggering.
- Fixed an issue with the **Supply Drop** spawner where gameplay events wouldn't trigger.
- Fixed an issue with the **Vehicle Service Station** that caused it to ignore vehicles without drivers.

## UEFN Updates and Fixes

**Fixes**:

- Fixed a crash that could occur when closing the editor while the news page was visible at startup.
- Fixed an issue where, in certain circumstances, the texture validator could incorrectly report a texture as a non-power of 2.
- Fixed an issue where a warning was not displayed if a project was about to be created in a folder typically managed by external backup systems, such as OneDrive or Dropbox.

## Verse Updates and Fixes

### API

**New**:

- Exposed Verse API for the **Vehicle Service Station** device.
- Added new Verse API for vehicles `fort_vehicle`: `GetFuelRemaining()` and `GetFuelCapacity()`.
