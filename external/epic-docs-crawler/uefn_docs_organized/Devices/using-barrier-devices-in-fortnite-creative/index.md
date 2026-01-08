# Barrier Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:37:09.252668

---

A **Barrier** device creates a customized zone that blocks players and weapon fire. It can also be used to create different visual styles that decorate levels throughout environments.

For an island with a complicated shape and layout, the barrier zone can serve as the map border, providing a [clean collision](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) that avoids collision issues.

For information on finding the Barrier device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Device Options

Once a barrier device is placed in the island, it generates an invisible collision box the size of one standard building tile. This box blocks both player movement and ranged weapon fire.

You can configure the device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, Always, Pre-Game Only, **Gameplay Only** | Determines which game phases the device will activate in. |
| **Barrier Material** | **Translucent (Red)**, Pick a visual style | Defines the visual style of the barrier. In [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), the visual style is invisible if the player is close to the device. |
| **Zone Shape** | **Box**, Hollow Box, Cylinder | Sets the shape of the zone. |
| **Barrier Depth** | **1.0**, Pick or enter an amount | Determines the depth of the barrier in tiles. |
| **Barrier Width** | **1.0**, Pick or enter an amount | Determines the width of the barrier in tiles. |
| **Barrier Height** | **1.0**, Pick or enter an amount | Determines the height of the barrier in tiles. |
| **Block Weapon Fire** | **On**, Off | Determines if the barrier blocks weapon fire. |
| **Collide With Camera** | **On**, Off | Determines whether the barrier with block the camera while active. |
| **Ignore Team** | On, **Off**, Team Index, None, Any, Pick or enter a number | Causes the barrier to ignore the player and their camera when that player is on the selected team. |
| **Ignore Class** | *On*, **Off**, Team Index, None, Any, Pick or enter a number | Causes the barrier to ignore the player and their camera when that player is of the selected class.  When this option is turned On, the Match Team and Class option becomes available. |
| **Match Team and Class** | **On**, Off | Determines if the barrier will only ignore pawns that match BOTH the ignored team and class or will ignore pawns that match either the ignored team or class. |
| **Shrink to Allow Building** | On, **Off** | When set to On, applies a slight scale reduction that accomodates building on the top and sides of the barrier. |
| **Invisible to Ignored Players** | On, **Off** | Determines whether or not players on the ignored list can see the barrier. If the barrier is invisible, it has no collision and can be moved through. |
| **Can NPC Added to Ignore List** | On, **Off** | Determines if NPCs can be added to the ignore list of the barrier. Once any NPC is added, all NPCs will be ignored by the device since they share the same navigation data. |
| **Affected by Fade Distance** | **On**, Off | Whether the barrier should fade when past its fade distance.  If ON, the barrier will be disabled when players are further than the Fade Distance , and Enabled when they are closer.  If OFF, the barrier will always remain enabled, regardless of the player's distance to the barrier. |

### Physics-Enabled Options

The following options become available when [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) are enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Block Physics Props** | **On**, Off | Determines whether the barrier blocks physics props while active. |

## Direct Event Binding

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the functions and events for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Add Player to Ignore List When Receiving From** | When an event occurs, this function adds the instigating player to a list of players the Barrier ignores. This is in addition to players covered by the Ignore Team and Ignore Class options. |
| **Remove Player from Ignore List When Receiving From** | When an event occurs, this function removes the instigating player from the list of players the Barrier ignores. |
| **Remove All Players from Ignore List When Receiving From** | When an event occurs, this function removes all players from the list of players the Barrier ignores. |

### Events

This device has no events.

## Gameplay Examples Using Barriers

- [Pinball Wizard](https://dev.epicgames.com/documentation/en-us/fortnite/pinball-wizard-in-fortnite-creative)
- [Shooting Academy](https://dev.epicgames.com/documentation/en-us/fortnite/shooting-academy-in-fortnite-creative)
