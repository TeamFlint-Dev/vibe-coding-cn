# Capture Item Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-capture-item-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:41:17.872778

---

The **Capture Item Spawner** is a special type of [item spawner](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) that will only [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a single [item](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

With this device, you can restrict interaction with that item to a single team, send messages to players based on the state of the item, and transmit signals to other devices based on the state of the item. In this way, you can use an item as an objective.

The Capture Item Spawner holds only one item. Dropping a new item will replace the one currently in the device.

The device has a pulse effect when it is captured or interacted with, and shows current capture percentage on the capture area material. When starting to capture an area, an effect will play on the players that are capturing.

To find the Capture Item Spawner device, go to the Creative inventory and select the Devices tab. From there you can search or browse for the device. For more information on finding devices see [Finding and Placing Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Device Options

In its default state, the Capture Item Spawner has no interaction. You need to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) an item on the device before it can be used.

Once an item has been placed, it will spawn at the start of the game and relay messages to players when the item is picked up, dropped, or captured by a capture area.

### Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Friendly Team** | **All**, Pick a team | The team that owns the area at the start of the game. Can be used to determine who can interact with it (only friendlies, or only enemies), and determines what messages are displayed if capture areas are [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). |
| **Captured By** | **Friendly Team**, Hostile Teams | Determines whether friendly teams need to pick up the item, or whether enemies need to pick it up. |
| **Accent Color Type** | **Team Color**, *Direct Color* | Determines how the device should be colored. |
| **Accent Color** | **Aqua**, Pick a color | Changes the device color to a specific color preset. *This option only appears if the **Accent Color Type** is set to **Direct Color***. |
| **Score Value** | **0**, Pick a score amount | When capturing the item, a player gains this much score. |
| **Return Dropped Items** | Instantly, **Never**, Pick an amount of time | If the item is dropped, it returns to the capture area after this defined amount of time. |
| **Play Capture Sounds** | **On**, Off | Determines whether the item should play sound when it is captured. |
| **Show Capture Messages** | **On**, Off | Prints messages to the chat when the item is dropped, captured, picked up, or returned. |
| **Enabled At Game Start** | **Enabled**, Disabled | Determines whether the spawner is enabled at the start of the game. A disabled spawner is powered down, and will not spawn items. |
| **Initial Weapon Ammo** | **Don't Override**, select a number from 1 to 999 | Sets the amount of ammunition loaded in the weapon when granted, limited by the weapon's magazine size. |
| **Spare Weapon Ammo** | **Default**, select a number from 1 to 999 | Sets how much spare ammunition is added to the player's inventory when a weapon is granted. **Default** provides ammo based on the ammo type used by the weapon. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enable the spawning of a capture item when an event occurs. |
| **Disable When Receveing From** | Disable the spawning of a capture item when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Item Picked Up Send Event To** | When an item is picked up, it sends an event to the selected device, which triggers the selected function. |
| **On Item Dropped Send Event To** | When an item is dropped, it sends an event to the selected device, which triggers the selected function. |
| **On Item Is Returned Send Event To** | Item is returned. |
| **On Item Captured** | When an item is captured, it sends an event to the selected device, which triggers the selected function. |
