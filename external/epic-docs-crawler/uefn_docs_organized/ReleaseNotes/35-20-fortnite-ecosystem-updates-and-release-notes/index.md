# 35.20 Fortnite Ecosystem Updates and Release Notes

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/35-20-fortnite-ecosystem-updates-and-release-notes>
> **爬取时间**: 2025-12-27T00:34:00.510918

---

The Olympus Prefabs & Galleries have landed in Creative! Check them out along with the Brawler’s Battleground Prefabs & Galleries. You can now use Bubble Chat for the text chat on your islands, and loading screen behavior is improved when entering your Fortnite Creative and UEFN islands. Also, the Creator Portal terms are getting a fresh coat of paint! Read all about it below.

## Create Dynamic Social Environments with Bubble Chat

[![](https://dev.epicgames.com/community/api/documentation/image/f12ec8a4-2a8a-4055-bdb0-bd2c5adedbf9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f12ec8a4-2a8a-4055-bdb0-bd2c5adedbf9?resizing_type=fit)

Bubble chat

You can now enable **Bubble Chat** for the text chat system in your islands, and have in-game conversations displayed directly above your players. Choose from a range of preset styles, like Rounded, Pop, Neon, and Comic, or create your own custom look with the UEFN widget. You can customize the player experience by setting how far away the text bubble can be seen by players, how long it stays visible on screen, and whether it fades when players walk behind objects.

## Improved Loading Screen

Players will notice improved loading screen behavior when entering islands. Characters and devices, including custom cameras, will be properly initialized before the loading screen is dismissed. Creators do not need to take any action to see these benefits—these improvements are being applied to all UEFN and Creative islands.

## Creator Portal Experience Updates

You’ll notice updated terminology throughout Creator Portal to make each stage of the publishing process easier to understand. Here some of the key changes:

- **Publish** now only refers to making an approved island release publicly available to players.
- **Create a release** is the process of submitting an island release for moderation.
- **Active release** is now called **Published release**.
- **Inactive release** is now **Unpublished release**.

#### Simpler Island Visibility States

To make it easier to know how playable and discoverable your island is, we’ve simplified island visibility to just three states:

- **Listed**: Your island is published and playable. It will show up on your public Creator page, it’s eligible to be featured in Discover, and it will show up in search results.
- **Unlisted**: Your island is published and playable, but it won’t show up on your public Creator page and it’s not eligible for Discover. Only players with the island code will be able to find and play it.
- **Unpublished**: Your island is not published, it’s not playable by the public and it’s not generating engagement revenue or analytics data. It could be that the island has never been published, that you unpublished it yourself, or it was unpublished by moderation as a result of a trust and safety violation.

You might be wondering, “What happened to **Deactivated**?” Going forward, instead of deactivating an island, you’ll simply unpublish it. The flow and outcome are the same, and it creates a single unified state for all islands that are not publicly playable for any reason.

When you’re ready to make your island public again, simply go to the **Release** tab, select an approved release, click **Publish Now**, select your desired visibility, and click **Publish**.

#### Improved Project Filtering

We’ve also made it easier to find important projects by adding filtering to the Projects page. You can now filter project tiles by visibility state (Listed, Unlisted or Unpublished). This helps you to get island-specific data for your high-performing islands or surface islands that may need attention.

## Olympus Lands in Creative: New Prefabs & Galleries

[![](https://dev.epicgames.com/community/api/documentation/image/fe7e8147-85b6-46b0-9936-8c20565a25eb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fe7e8147-85b6-46b0-9936-8c20565a25eb?resizing_type=fit)

Olympus Prefabs & Galleries

Summon the might of the Olympians with the Ancient Greek Temple prefabs now available in Fortnite Creative!

- Olympus Throne Prefab
- Olympus Rotunda Prefab
- Olympus Temple Prefab
- Olympus Floor & Stair Gallery
- Olympus Wall Gallery
- Olympus Roof Gallery
- Olympus Prop Gallery
- Olympus Statue and Bridge Gallery
- Olympus Nature Gallery
- Brawler’s Battleground Temple Prefab
- Brawler’s Battleground Rotunda Prefab
- Brawler’s Battleground Wall Gallery
- Brawler’s Battleground Floor & Stair Gallery
- Brawler’s Battleground Roof Gallery
- Brawler’s Battleground Prop Gallery
- Brawler’s Battleground Rotunda Gallery

## Physics Puzzle Dungeon Tutorial

Create a physics puzzle room that uses the new experimental physics feature! Build a dungeon room with moving platforms and add some custom props with physics properties. Soon you'll have a terrific puzzle that you can expand into a larger puzzle dungeon. Check out [Make a Physics Puzzle Dungeon](https://dev.epicgames.com/documentation/en-us/fortnite/make-a-physics-puzzle-dungeon-in-unreal-editor-for-fortnite) for more details.

## Coming Soon: Fortnite Creative and UEFN Docs are Merging

Great news, creators! We're excited to announce the merging of the Fortnite Creative and UEFN documentation sets. Soon, all the resources you need will be in one unified hub. Get ready for a smoother, more efficient learning experience. Say goodbye to switching between separate documentation sets and hello to a streamlined path for all your Fortnite creation needs.

We’re planning to go live at 36.00—stay tuned for launch!

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where a Prop Mover in motion could not be reset or reversed until it finished its full movement.

  - [Forum Report](https://forums.unrealengine.com/t/prop-movers-bugged-or-is-this-a-wanted-change-please-let-me-know-asap/2497580)
- Fixed an issue where smaller props were not instantly broken when hit by moving vehicles.

  - [Forum Report](https://forums.unrealengine.com/t/vehicles-can-no-longer-break-small-props-instantly/2385037)
- Fixed an issue where the All Jam Loops category was not appearing in creator-made islands.

  - [Forum Report](https://forums.unrealengine.com/t/all-jam-loops-do-not-show-up-in-uefn-made-maps/1951406)

## Fortnite Ecosystem Updates and Fixes

**New**

- Added a **Don't Override** setting to **Display Empty Ammo Slots** for **Team Settings** and **Class Designer** devices.

**Fixes**:

- Fixed an issue where the **Modded Weapon Case** devices did not contain weapon mods.
- Fixed an issue where two or more **Prop Manipulator** devices touching the same asset would not get selected based on their Priority settings.
- Fixed issue where the **Rift Point Volume** device did not trigger the **On Defuse Canceled Event** when a defusing player died while attempting to defuse the planted device.
- Fixed an issue where the **Lawless Slap Cannon** could have incorrect visuals when spawned.
- On LEGO® islands, fixed inability to pick up other items when a Crossbow or Sword was equipped with a full quick bar.
- Fixed an issue where the UI for ammo amounts would be incorrect after switching between teams with different **Infinite Ammo** settings.
- Fixed some previously disallowed spider web corner assets.

## UEFN Updates and Fixes

**New**:

- Updated the source control **Revert** dialog to appear and function similar to the **Checkout** dialog.
- Changed default setting for **NVIDIA Reflex** latency reduction from **Off** to **On**.

**Fixes**:

- Fixed some cases where UEFN would fail to detect broken actor references when iterative validation was enabled.
- Fixed an issue where **3D Resolution** would be set to 0% on machines that start in performance mode.
- Fixed an issue where **NVIDIA Reflex** settings were hidden in performance mode.
- Fixed an issue where water would disappear in the editor.
- Fixed an issue that caused the editor to crash when saving landscape and the LandscapeSubsystem was not available for the world.
- Fixed an issue where Lumen was not working with the Ch5 **Time of Day Manager** (**TODM**).
- Fixed sporadic crashes from a memory stomp in modeling mode and UV editor.

## Verse Updates and Fixes

### API

**Fix**:

- Fixed an issue where a runaway loop might hang the server for a very long time. It is now stopped with a runtime error after a few seconds.
