# Side Scroller Controls Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-side-scroller-controls-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:46:01.107049

---

The **Control: Side Scroller** (Side Scroller Controls) device clamps the player's facing direction to the left-right axis so that no matter how they move, they are always facing left or right. Used with the [Fixed Point](using-fixed-point-camera-devices-in-fortnite-creative) or [Fixed Angle Camera](https://dev.epicgames.com/documentation/en-us/fortnite/using-fixed-angle-camera-devices-in-fortnite-creative) devices, this gives you a toolbox to create all kinds of 2D retro-style games, such as [side-scrolling platformers](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) or [beat 'em ups](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

For help on how to find the **Side Scroller Controls** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Creative Preview** | N/A | Click **Start** to preview the controls. Click **Stop** to leave the preview and go back to editing your island. |
| **Priority** | **0**, Pick or enter a number | Multiple control devices can be present at any time, but only the one with the highest priority is considered active. |
| **Add to Players on Start** | **On**, Off | Determines whether this device is automatically added to all players when the game starts. |
| **Remove on Elimination** | On, **Off** | Determines whether this control device is removed from a player when they are eliminated. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines which phases the control device is active in. If you choose **None**, the camera can only be enabled manually using events. |
| **Constrain Movement** | **On**, Off | When set to **On**, player movement is constrained to the direction indicated by the arrow on the device itself. |
| **Jump** | Disabled, **Dedicated**, Movement | Determines whether jumping is enabled, and if so what controls players use to jump. Select **Dedicated** to have players use the default jump control. Select **Movement** to have players use the Up control to jump. |
| **Crouch** | Disabled, **Dedicated**, Movement | Determines whether crouching is enabled, and if so what controls player use to crouch. Select **Dedicated** to have players use the default crouch control. Select **Movement** to have players use the Down control to crouch. |
| **Ranged Direction** | **Facing**, Cardinal Movement, Full Range Movement, *Full Range Manual* | Determines how the player aims while in side scroller mode. Values included are:   - **Facing**: Uses the direction the player is facing to aim. - **Cardinal Movement**: Players can use the Up/Down/Left/Right controls to aim in those directions. - **Full Range Movement**: Uses the direction the player is moving to aim. So if the player is holding forward and up, they will aim forward and up. - **Full Range Manual**: Players aim using the mouse or right stick similar to a twin stick shooter. |
| **Lock Direction While Aiming** | On, **Off** | If this is set to **On**, the player's facing direction is locked when they are aiming. |
| **Lock Direction While Shooting** | On, **Off** | If this is set to **On**, the player's facing direction is locked when they are shooting. |
| **Movement Speed Multiplier** | **1.0x**, Pick an amount | Determines how fast the player moves, as a multiple of the default speed. |
| **Movement Speed Multiplier When Shooting** | **1.0x**, Pick an amount | Determines how fast the player moves while shooting, as a multiple of the default speed. |
| **Movement Speed Multiplier When Aiming** | **1.0x**, Pick an amount | Determines how fast the player moves while aiming, as a multiple of the default speed. |
| **Targeting Lock On** | Never, Always, Shooting, Aiming, **Shooting or Aiming** | When the player has a target, this determines when the player aims toward that target. |
| **Target Retention Duration** | **1.5 sec**, Pick a number of seconds | Determines the amount of seconds a player will attempt to face their target after each ranged action. |
| **Require Target on Screen** | **On**, Off | Determines whether or not the target has to be on screen in order for a target to be valid. |
| **Ranged Targeting Distance** | **1000 cm**, Pick or enter an amount | Determines the maximum distance targets can be from the player to be considered valid targets. |
| **Ranged Targeting Height** | **500 cm**, Pick or enter an amount | Determines the maximum vertical distance targets can be from the player to be considered valid targets. |
| **Targeting Distance When Aiming** | **1000 cm**, Pick or enter an amount | Determines the maximum distance targets can be from the player to be considered valid targets when the player is aiming. |
| **Targeting Height When Aiming** | **300 cm**, Pick or enter an amount | Determines the maximum vertical distance targets can be from the player to be considered valid targets when the player is aiming. |
| **Ranged Targeting Angle** | **85°**, Pick a number of degrees | From the player's facing direction, this is the angle within which targets must be to be considered valid targets. |
| **Targeting Angle When Aiming** | **85°**, Pick a number of degrees | From the player's facing direction, this is the angle within which targets must be to be considered valid targets when the player is aiming. |
| **Require Line of Sight** | **On**, Off | Determines whether or not line of sight is required in order for a target to be valid. |
| **Base Weight Player** | **1.0**, Pick a number | Determines the targeting prioritization assigned to players. If you select **0**, players cannot be targeted. |
| **Base Weight Creatures** | **0.5**, Pick a number | Determines the targeting prioritization assigned to creatures. If you select **0**, creatures cannot be targeted. |
| **Base Weight Vehicles** | **0.3**, Pick a number | Determines the targeting prioritization assigned to vehicles. If you select **0**, vehicles cannot be targeted. |
| **Scale Weight by Distance** | **0.5**, Pick a number | Scales the target's calculated priority weight, reducing the final value by the target's distance from the player. |
| **Scale Weight by Angle** | **1**, Pick a number | Scales the target's calculated priority weight, reducing the final value by the target's angle to the player. |
| **Affects Team** | **Any**, Pick or enter a team | Determines which team is affected by this device. |
| **Invert Team** | On, **Off** | If this is set to **On**, all teams are affected by this device except the team selected in the **Affects Team** option. |
| **Affects Class** | No Class, All, **Any**, Pick or enter a class | Determines which classes are affected by this device. **No Class** means only players with no assigned class are affected. **All** means all players, including those with no assigned class, are affected. **Any** means players with any assigned class are affected. |
| **Invert Class** | On, **Off** | If this is set to **On**, all classes are affected by this device except the class selected in the **Affects Class** option. |
| **Targetable Device in Edit Mode** | On, **Off** | Determines whether the device itself is targetable. If set to **On**, the device is only targetable when you are editing your island. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** **dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Add to When Receiving From** | Adds this device to the instigating player when an event occurs. |
| **Remove From When Receiving From** | Removes this device from the instigating player when an event occurs. |
| **Add to All When Receiving From** | Adds this device to all players when an event occurs. |
| **Remove From All When Receiving From** | Removes this device from all players when an event occurs. |

### Events

This device has no events.

## Use Side Scroller Controls Device In Verse

### Side Scroller Controls API

See the [`Side Scroller Controls` API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/button_device) for more information on using the Side Scroller Controls device in Verse.
