# Class Selector Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-class-selector-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:33:00.988735

---

The **Class Selector** device is used in conjunction with the [Class Designer](using-class-designer-devices-in-fortnite-creative) device for creating [class-based gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Once you've set up your custom [classes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) with the Class Designer, you can use the Class Selector to set how they'll be used [in-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

You need one Class Selector for each custom class you use. When in [Play mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), a player can select or switch to a specific class by walking over the device's colored activation zone.

You can also use the Class Selector to set up team selection independently from class selection, but be aware that team switching will force the player to [respawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

To find the Class Selector device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the **Description** field for that option.

## Device Options

Before you start to customize a Class Selector, make sure you've placed and customized your Class Designer devices, each with it's own **Class Identifier**. You will use this identifier with the **Class to Switch to** option in the Class Selector.

Keep in mind the following:

- You have to specify a **class number** for this to work.
- That number must be defined in a Class Designer device.
- If the number is not defined in a Class Designer, the player will be assigned default attributes with no weapons. The device **will not** fall back to the Default Class Identifier assigned in a Team Settings & Inventory device, or in [Island Settings > Mode](https://dev.epicgames.com/documentation/en-us/fortnite/mode-settings-in-fortnite-creative).

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Class to Switch To** | **Don't Override**, No Class, Pick a class number | Indicates which class the player will switch to, as defined by the **Class Identifier** in the **Class Designer**. If you choose **No Class**, the player will not switch their class. This is mostly used for team switching. |
| **Send Game Start Class Changes at Warmup** | **Off**, On | Determines whether the device sends any **Class Changed** events that are triggered at the start of the game during warmup instead of when the countdown is finished. |
| **Team To Switch To** | **Don't Override**, Random, Pick or enter a team number | With **Do Not Switch**, no team switching happens when a player changes their class. If you choose **Random**, the player switches to a random team that is not their current team. |
| **Send Game Start Team Changes at Warmup** | **Off**, On | Determines whether the device sends any **Team Changed** events that are triggered at the start of the game during warmup instead of when the countdown is finished. |
| **Activating Team** | **Any**, Pick or enter a team number | Only players in a specific team can use this device. If you choose **Any**, all teams can use this device. |
| **Time to Switch** | **Instant**, Pick or enter a time | The time it takes for the player to switch their class after they walk over the activation zone. This is irrelevant to Team Switching since the player is forced to respawn when they switch teams. |
| **Respawn Player On Switch** | On, **Off** | Determines whether a player will respawn when switching classes. |
| **Restore Health and Shields on Switch** | **On**, Off | Determines whether the player's health and shields are restored to their starting amount when they switch classes. |
| **Clear Items On Switch** | **Never**, Team, Class, Always | Determines whether items are removed from the player's inventory when they switch classes. [INCLUDE:#clearitems] |
| **Size of Volume** | **1 Meter**, Pick a size | The size of the activation volume in meters. |
| **Volume Visible In Game** | **On**, Off | Determines whether the activation volume is visible during the game. This does not affect the collision properties of the device. |
| **Visible During Game** | **On**, Off | Determines whether the device is visible to the player. This also affects [collision](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) when the player interacts with the device. When **On**, the device has collision. When **Off**, the device has no collision. |
| **Accent Color Type** | ***Direct Color***, Team Color, Team Relationship | Determines whether the device uses a custom color, or the team or team relationship color. If you set this to **Direct Color**, the **Accent Color** option displays below this one. |
| **Accent Color** | **Aqua**, Pick a color swatch | Determines the color used by the device. Click the swatch to open the Color Picker. Select a color, then click the checkmark to close the Color Picker. |
| **Enabled During Phase** | None, Always, Pre-Game Only, **Gameplay Only** | Sets the [game phase](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) in which the device is enabled. If you choose **Pre-Game Only**, the device is only enabled before the game begins. (Pre-game includes [lobby](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and countdowns.) If you choose **Gameplay Only**, the device is only enabled during the game. |
| **Activation Audio** | **On**, Off | This option only displays if the **Accent Color Type** option is set to **Direct Color**. Determines whether the Class Selector plays audio effects when activated. |
| **Zone Audio** | **On**, Off | **Determines whether the Class Selector should play audio effects when players enter the zone.** |
| **Display VFX Effect On Activation** | **On**, Off | Controls whether a [VFX](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) effect is created when a player changes class or team. |
| **Throttle Class Changes** | On, **Off** | If this is set to **On**, when a player changes class the device will delay any subsequent class changes for 3 seconds in order to avoid potential performance impacts. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the class selector when an event occurs. |
| **Change Player to Class When Receiving From** | This function changes the player to the specified class when an event occurs. |
| **Change Player to Team When Receiving From** | This function changes player to the specified Team when an event occurs. |
| **Change Player to Team and Class When Receiving From** | This function changes the player to the specified team when an event occurss, even if player is within the team switch cooldown period. |
| **Change Selector Team When Receiving From** | When an event occurs, this function changes the **Team to Switch To** value to the team of the instigating player. |

### Events

Sends an event to a linked device when a player interacts with the button.
Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Class Switched Send Event To** | When a player switches classes, an event is sent to the selected device, which triggers the selected function. |
| **On Team Switched Send Event To** | When a player switches teams, an event is sent to the selected device, which triggers the selected function. |

## Gameplay Examples

- [Class Setup In An Arena](https://dev.epicgames.com/documentation/en-us/fortnite/class-setup-in-an-arena-gameplay-example-in-fortnite-creative)
- [Top Scorer In Class](https://dev.epicgames.com/documentation/en-us/fortnite/top-scorer-in-class-in-fortnite-creative)
- [Dungeon Crawler](https://dev.epicgames.com/documentation/en-us/fortnite/dungeon-crawler-gameplay-example-in-fortnite-creative)
