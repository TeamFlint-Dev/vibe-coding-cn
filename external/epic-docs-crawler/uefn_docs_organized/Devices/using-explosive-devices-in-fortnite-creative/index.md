# Explosive Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-explosive-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:38:33.520321

---

When activated, the **Explosive** device causes damage to whatever is in its blast radius.

There are several ways you can set it to be triggered:

- From player interaction
- By setting up [event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and activating it from another device
- By setting a timer to detonate it after a specific time, or on a timed delay

You can also set this device to ignore damage from specific teams.

For help on how to find the Explosive device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use italic for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

The device can be customized to alter settings such as the blast radius and the [knockback](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) amount. You can also set a delay between the device being triggered and the explosion.

The default values are **bold**.
Values that use [contextual filtering](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) are in italics.

Configure this device with the following options.

Below are the following changes made to the device options:

| Option | Value | Description |
| --- | --- | --- |
| **Can be Damaged** | **On**, *Off* | Determines if the device can be damaged. If set to **Off**, the following option is hidden: **Health**. |
| **Health** | **1**, Indestructible, Pick a number | Determines how much damage the device can take before it explodes. |
| **Display Damage Numbers** | On, **Off** | Determines whether damage numbers should be displayed when players deal damage to the device. |
| **Blast Radius** | **2.0 Tiles**, Pick a number | Determines the radius of the explosion in tiles. |
| **Player Damage** | **50**, Pick a number | Sets the amount of damage dealt to players within the explosion radius. |
| **Ignore Team for Damage** | **None**, Pick a team | Sets a team to be immune to damage from the explosion. |
| **Structure Damage** | **150**, Pick a number | Sets the amount of [damage dealt](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to environment props within the explosion radius. |
| **Damage Indestructible Buildings** | Yes, **No** | Determines whether the explosion can damage the environment even when environment damage is turned off in game settings. |
| **Blast Line of Sight** | **No**, Yes | Determines whether the explosion requires clear line of sight to a player or prop to damage it. |
| **Explode on Proximity** | **Off**, On | Determines whether a player's presence near the device will trigger a detonation. If set to **On**, other options will show. |
| **Explode on Proximity Range** | **1.0 Tile**, On | Sets the distance in tiles for how close the player has to be to cause the device to explode. This option only shows if **Explode on Proximity** is set to **On**. |
| **Knockback Player** | Select a Knockback amount | Determines the amount of impulse applied to players within the explosion radius. |
| **Knockback Vehicle** | Select a Knockback amount | Determines the amount of impulse applied to vehicles within the explosion radius. |
| **Proximity Delay** | **Off**, Pick a time | Determines the delay in seconds between a player's proximity triggering the device and it actually exploding. Only shows if **Explode on Proximity** is set to **On**. |
| **Ignore Team for Proximity** | **None**, Pick a team | Sets a team to be ignored for the purposes of player proximity detonation. This makes the selected team invulnerable to this device. Only shows if **Explode on Proximity** is set to **On**. |
| **Has Timed Detonation from Game Start** | **Off**, *On* | Determines if the device has a timer which causes the device to explode after the selected duration after game start. If set to **On**, the following option becomes available: **Time to Detonation from Game Start**. |
| **Time to Detonation from Game Start** | **1 Second**, Pick a time in seconds | Sets how long after game start the device will explode. Only shows if **Has Timed Detonation from Game Start** is set to **On**. |
| **Play Audio/VFX** | **Yes**, No | Determines whether to play explosion visual and audio effects when the device explodes. |
| **Range Visualization** | **Off**, Damage, Proximity | Determines which range setting to visualize when editing the device. |
| **Visible During Game** | **Yes**, No | Determines whether the device will be visible during the game. |
| **Collision During Games** | Off, **On**, Only When Visible | Determines whether the device uses collision properties during the game. |
| **Show Health Bar** | **Yes**, *No* | Determines if the device should display a health bar in the HUD when damaged. If set to **No**, the **Health Bar Style** option will be hidden. |
| **Health Bar Style** | **Default**, *Badge Style*, *Badge Style (When Damaged)* | Determines the health bar style to use on the HUD. If you select **Badge Style** or **Badge Style (When Damaged)**, several other options will show. |
| **Hide HUD Icon at** | **20M**, Pick a distance | Determines the distance at which the HUD icon stops being visible. Only displays if **Badge Style** or **Badge Style (When Damaged)** is selected for the **Health Bar Style** option. |
| **Requires Line of Sight** | **Yes**, No | Determines whether direct line of sight is required to see the HUD icon. This option only displays if **Badge Style** or **Badge Style (When Damaged)** is selected for the **Health Bar Style** option. |
| **Icon Identifier** | **None**, Pick an Icon | This option only displays if **Badge Style** or **Badge Style (When Damaged)** is selected for the **Health Bar Style** option. Assigns a letter to the HUD icon to make it identifiable. |
| **Display Distance Text** | **No**, Yes | When set to **Yes** and if it is showing as a HUD element, the HUD element also displays the distance between the object and the player. |
| **Clamp to Screen** | **No**, *Yes* | When set to **Yes** and if it is showing as a HUD element, this restricts the rendering to be within the area of the screen.  When this option is set to **Yes**, the option Show Offscreen Arrow become available. |
| **Team Visibility** | Neutral, Friendlies, **Any**, Hostiles, Pick a team | Determines which team can see the icon in their HUD. This option only displays if **Badge Style** or **Badge Style (When Damaged)** is selected for the **Health Bar Style** option. |
| **Friendly Icon Text** | Insert text | Specifies the text that's displayed on the HUD icon for friendly players. This option only displays if **Badge Style** or **Badge Style (When Damaged)** is selected for the **Health Bar Style** option. |
| **Neutral Icon Text** | Insert text | Specifies the text that's displayed on the HUD icon for neutral players. This option only displays if **Badge Style** or **Badge Style (When Damaged)** is selected for the **Health Bar Style** option. |
| **Hostile Icon Text** | Insert text | Specifies the text that's displayed on the HUD icon for hostile players. This option only displays if **Badge Style** or **Badge Style (When Damaged)** is selected for the **Health Bar Style** option. |
| **HUD Text Size** | **1X**, 1.5X, 2X | Determines the size of text displayed on the HUD icon. This option only displays if **Badge Style** or **Badge Style (When Damaged)** is selected for the **Health Bar Style** option. |
| **Play Audio** | No, **Yes** | Determines whether the device should play audio effects. |
| **Device Mesh** | **Barrel**, Bomb | Determines what the explosive item looks like during the game. If you choose **Bomb**, the explosive is a cartoonish round bomb with a fuse coming out of the top. If you have the **Proximity Delay** option or the **Time to Detonation From Game Start** option turned on, the fuse on the bomb will remain lit while the timer is active. |
| **Time Until Reset Allowed** | **1.0 Second**, Pick a time | Controls how long after a device explodes before it can be reset. |

### Physics-Enabled Options

The following options become available when [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) are enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Knockback Physics Prop** | Select a Knockback amount. | Determines the amount of impulse applied to objects within the explosion radius. |

## Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Explode** | Explodes the device when an event occurs. |
| **Turn on Visibility** | Makes the device visible when an event occurs. |
| **Turn off Visibility** | Hides the device when an event occurs. |
| **Reset** | Resets the device when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Exploded** | Sends an event to a linked device when the device explodes. |

## Gameplay Examples That Use Explosive Devices

- [Search and Destroy](https://dev.epicgames.com/documentation/en-us/fortnite/search-and-destroy-bomb-in-fortnite-creative)
- [Knock, Knock](https://dev.epicgames.com/documentation/en-us/fortnite/knock-knock-gameplay-example-in-fortnite-creative)
