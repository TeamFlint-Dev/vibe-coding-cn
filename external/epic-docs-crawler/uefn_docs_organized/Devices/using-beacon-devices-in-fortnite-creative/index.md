# Beacon Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-beacon-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:44:47.393388

---

The **beacon** provides several types of beacons that can use different particle effects in different colors. They can all be used to mark a location in the world, either with the particle effect or a HUD marker.

In **Beacon** mode, the beacon will show one of several particle effects in one of several colors. In **Badge** mode, it will show a HUD Marker with multiple customization options for the color and text shown. The text shown can be different based on the team relationship with the local client.

To find the **Beacon** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

The device can either show a beacon in the world view, a badge in the HUD, or both. It can be configured with a variety of particle effects and text, depending on the team of players viewing it.

In its default state the beacon shows one of several particle effects, depending on which beacon is chosen.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Beacon To Show** | ***Particle***, *Badge*, *Both* | Determines if the beacon displays its particle effect, the HUD Marker (Badge) or both. |
| **Beacon Particle Style** | Arrow, **Light Beam**, Flare | This only displays if the **Beacon to Show** option is set to **Particle** or **Both**. Determines what visual effect would be shown to players. |
| **Badge UI Style** | **Default**, Backless | This option only displays if the **Beacon to Show** option is set to **Badge** or **Both**. Determines the visual style for the badge. |
| **Friendly Team** | Any, Hostiles, **Neutral**, Pick or enter a team | This determines which team, if any, sees the badge as friendly. |
| **Friendly Class** | No Class, **Any**, Pick or enter a class | Determines which class sees the beacon as friendly. If you choose **No Class** only players with no assigned class are seen as friendly. |
| **Invert Class Selection** | On, **Off** | If this is set to **On**, all classes except the one selected in **Friendly Class** are seen as friendly. |
| **Team Visibility** | None, **Any**, Hostile, Friendlies, Neutral, Pick or enter a team | Determines which team can see the beacon. |
| **Beacon Color** | ***Direct Color***, Team Color, Team Relationship Color | Determines the beacon color. If you choose **Direct Color**, the **Custom Beacon Color** option displays below this one. |
| **Custom Beacon Color** | **White**, Pick a color swatch | This option only displays if the **Beacon Color** option is set to **Direct Color**. Determines the color of the beacon. Click the swatch to open the Color Picker. Select a color, then click the checkmark to close the Color Picker. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phase during which the device will be enabled. |
| **Badge Uses Beacon Color** | On, **Off** | If set, the badge will inherit color from the beacon rather than using the Team Relationship color. |
| **Icon Identifier** | **None**, Pick an icon | This only displays when the **Beacon to Show** option is set to **Badge** or **Both**. Assigns an icon to the badge, making it identifiable. Click to open the Icon Picker. Select an icon, then click the checkmark to close the Icon Picker. |
| **Hide HUD Icon At** | **20M**, Pick or enter a distance | If the beacon shows a HUD marker, only show the HUD marker to players who are closer than this distance from the device. This only displays when the **Beacon to Show** option is set to **Badge** or **Both**. |
| **Display Distance Text** | On, ***Off*** | If the beacon shows a HUD marker, this determines whether the HUD also shows the distance between the player and the beacon. This only displays when the **Beacon to Show** option is set to **Badge** or **Both**. |
| **Friendly Icon Text** | Enter text (30 character limit) | Specifies the text displayed on the badge for friendly players. This only displays when the **Beacon to Show** option is set to **Badge** or **Both**. |
| **Neutral Icon Text** | Enter text (30 character limit) | Specifies the text displayed on the badge for neutral players. This only displays when the **Beacon to Show** option is set to **Badge** or **Both**. |
| **Hostile Icon Text** | Enter text (30 character limit) | Specifies the text displayed on the badge for hostile players. This only displays when the **Beacon to Show** option is set to **Badge** or **Both**. |
| **Text Font Style** | Subtle, **Bold** | Defines the font for any custom text displayed by this beacon. This only displays when the **Beacon to Show** option is set to **Badge** or **Both**. |
| **HUD Text Size** | **1.0X**, Pick or enter a multiplier | Determines the size of the text displayed on the badge. This only displays when the **Beacon to Show** option is set to **Badge** or **Both**. |
| **Requires Line of Sight** | **On**, Off | This determines whether direct line of sight is required to see the badge. This only displays when the **Beacon to Show** option is set to **Badge** or **Both**. |
| **Clamp to Screen** | On, **Off** | When showing the HUD marker, this sets the badge to always appear on the screen. If the beacon is far away, the badge will display on the side of the HUD that matches the direction the player needs to go. This only displays when the **Beacon to Show** option is set to **Badge** or **Both**. |
| **Show Offscreen Arrow** | On, **Off** | Sets to show an arrow pointing in the offscreen direction when the actual rendering position is offscreen and shows as a HUD element. This only displays when the **Beacon to Show** option is set to **Badge** or **Both**. |

## Direct Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Add Player to Show List When Receiving From** | This function adds the instigating player to the Show List when an event occurs. |
| **Remove Player from Show List When Receiving From** | This function removes the instigating player from the Show List when an event occurs. |
| **Remove All Players from Show List When Receiving From** | This function removes all players from the Show List when an event occurs. |

### Events

This device has no events.

## Gameplay Examples Using Beacons

- [Random Sentry Fight](https://dev.epicgames.com/documentation/en-us/fortnite/random-sentry-fight-in-fortnite-creative)
- [Search and Destroy Bomb](https://dev.epicgames.com/documentation/en-us/fortnite/search-and-destroy-bomb-in-fortnite-creative)
