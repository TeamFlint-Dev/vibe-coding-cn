# Campfire Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-campfire-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:47:00.437294

---

You can use the **Campfire** device in several ways. The campfire can be used for:

- A decoration
- A healing zone in the world
- A healing zone that requires fuel

Looking for more inspiration? See [Campfire Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/campfire-device-design-example-in-fortnite-creative) to boost your imagination!

For help on how to find the the **Campfire** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate. However, it may not be easy to recognize which options or values trigger contextual filtering.

To help you identify them, our device docs use italic for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Start Lit** | Yes, **No** | Determines whether the fire is lit at the start of the round. |
| **Can Be Lit** | **Yes**, No | Determines whether a player can light the campfire by interacting with it. |
| **Time to Light** | Instant, **1.0 Second**, Pick a number of seconds | Sets the amount of time it takes to light the campfire. Use the arrows to choose an amount, or click in the field to type in a number. |
| **Can Be Extinguished** | **Yes**, No | Determines whether a player can put out the campfire by interacting with it. |
| **Time to Extinguish** | Instant, **1.0 Second**, Pick a number of seconds | Sets the amount of time it takes to put out the campfire. Use the arrows to choose an amount, or click in the field to type in a number. |
| **Can Be Stoked** | **No**, Yes | Determines if players can add more fuel to the campfire while it is lit. |
| **Campfire Zone Size** | **7.68 Meters**, Pick a size | Determines the size of the zone that that affects Players and Hostile AI. Use the arrows to choose a size, or click in the field to type in a distance. |
| **Pulse Interval** | **1.0 Second**, Pick a number of seconds | Determines the amount of time between campfire pulses. Use the arrows to choose an amount, or click in the field to type in a number. |
| **Health Per Pulse** | **2**, Pick an amount | Determines the amount of [health](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) gained per second by each player within range. Use the arrows to choose an amount, or click in the field to type in a number. |
| **Uses Wood** | Yes, **No** | Determines whether the campfire requires wood to be used. |
| **Wood Consumption Per Pulse** | **1.0**, Pick an amount | Determines the amount of wood the campfire uses per second to keep itself lit. Use the arrows to choose an amount, or click in the field to type in a number. |
| **Max Wood Capacity** | **30**, Pick an amount | Sets the maximum wood capacity that the campfire can take. Use the arrows to choose an amount, or click in the field to type in a number. |
| **Starting Wood** | **30**, Pick an amount | Sets the amount of wood the campfire starts with, up to the value selected for **Max Wood Capacity**. Use the arrows to choose an amount, or click in the field to type in a number. This option is only used if the **Uses Wood** option is set to **Yes**. |
| **Wood To Add On Trigger** | **10**, Pick an amount, Maximum | Sets the amount of wood to add to the campfire when the **Add Wood When Receiving On** channel option is triggered. Use the arrows to choose an amount, or click in the field to type in a number. |
| **Can Affect Vehicles** | **Yes**, No | Allows vehicles to trigger campfire events and be affected by the pulse. |
| **Interacting Team** | None, **All**, Pick a team | Determines which team is allowed to interact with the campfire. Use the arrows to choose a team, or click in the field to type in a team number. |
| **Invert Interacting Team Selection** | On, **Off** | If set, the selected Interacting Team is the only one that cannot interact with the device. |
| **Affected Team** | None, **All**, Pick a team | Determines the team that will be affected by the campfire pulse. Use the arrows to choose a team, or click in the field to type in a team number. |
| **Invert Affected Team Selection** | On, **Off** | If set, the selected Affected Team is the only one that cannot be affected by the device. |
| **Interacting Class** | No Class, **Any**, Pick a class | Determines the class that is allowed to interact with the campfire. Use the arrows to choose a class, or click in the field to type in a class number. If you choose **No Class**, only players without an assigned class can interact with the campfire. |
| **Affected Class** | No Class, **Any**, Pick a class | Determines the class that will be affected by the campfire's pulse. Use the arrows to choose a class, or click in the field to type in a class number. If you choose **No Class**, only players without an assigned class are affected by the campfire pulse. |
| **Affects AI** | **No Effect**, Repel, *Damage*, *Repel & Damage* | Determines what a Campfire does to creatures and wildlife that enter the zone. |
| **Affects Creatures Option** | **Do Not Override**, No Effect, Repel, Damage, Repel & Damage | Determines how the Campfire should affect Creatures that enter the area. This setting will override **Affects AI** if set. |
| **Affects Predator Option** | **Do Not Override**, No Effect, Repel, Damage, Repel & Damage | Determines how the Campfire should affect Wildlife Predators that enter the area. This setting will override **Affects AI** if set. |
| **AI Damage Per Pulse** | **2**, Pick an amount | This option only displays if you choose **Damage** or **Repel & Damage** for the **Affects AI** option. Determines how much damage the Campfire pulse does to creatures and wildlife that enter the zone. Use the arrows to choose an amount, or click in the field to type in a number. |
| **Use Advanced Lighting** | **Yes**, No | Enables advanced lighting on the campfire. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines in which phases the device is enabled.  If this is set to **Pre-Game Only**, the campfire will not provide healing to players or damage creatures and wildlife during the game. |

## Direct Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Light When Receiving On** | This function lights the campfire when an event occurs. |
| **Extinguish When Receiving On** | This function puts out the campfire when an event occurs. |
| **Add Wood When Receiving On** | This function adds wood to the campfire when an event occurs. This function is only used if the **Uses Wood** option is set to **Yes**. |
| **Enable When Receiving On** | This function enables the device when an event occurs. |
| **Disable When Receiving On** | This function disables the device when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Lit Send Event To** | When the campfire is lit, an event is sent to the selected device. |
| **On Extinguished Transmit On** | When the campfire is put out, an event is sent to the selected device. |
| **On Entering Area Transmit On** | When a player enters the campfire area, an event is sent to the selected device.it transmits a signal on the selected channel. |
| **On Leaving Area Transmit On** | When a player leaves the campfire area, an event is sent to the selected device. |
| **On Campfire Pulse Transmit On** | When the lit campfire pulses, an event is sent to the selected device. |
| **On Player Pulsed Transmit On** | For each player affected by a lit campfire pulse, an event is sent to the selected device. |
| **On Enabled Transmit On** | When the device is enabled, an event is sent to the selected device. |
| **On Disabled Transmit On** | When the device is disabled, an event is sent to the selected device. |
