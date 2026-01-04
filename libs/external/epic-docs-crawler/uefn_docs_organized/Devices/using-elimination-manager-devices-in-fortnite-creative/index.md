# Elimination Manager Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-elimination-manager-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:39:15.186023

---

You can drop items on the **Elimination Manager** device to [register](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the items. When a player eliminates a certain target, items registered with the **Elimination Manager** will spawn at the eliminated target's location. You can also set the device to drop items in a specific order, or to drop them randomly, or have the items drop when a player is eliminated, or when other enemies, such as fiends or sentries, are eliminated.

For help on how to find the **Elimination Manager** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

**Looking for more inspiration?** See [Elimination Manager Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/elimination-manager-device-design-examples-in-fortnite-creative) to spark your imagination!

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

By default, the Elimination Manager does nothing. Once an item has been placed into it during [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), the Elimination Manager becomes active and will drop that item at the location of any player that is eliminated during the game.

This device has some basic functionality, like determining how many items drop when a player is eliminated. Additionally, there are some advanced options, like choosing which target drops items when eliminated, or changing the drop rate to a percentage so items only drop sometimes.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled At Game Start** | **On**, Off | Determines if the Elimination Manager is enabled when the game starts. |
| **Number of Items Dropped** | **All**, Pick or enter a number | Determines how many registered items are dropped when a target is eliminated. |
| **Valid on Self-Elimination** | On, **Off** | Determines whether the device is triggered when players eliminate themselves. |
| **Target Type** | **All Types**, Select a target type | The device activates when the selected target type is eliminated.  Options include:   - Players Only - All Creatures - Sentries - Fiend - Red Fiend - Brute - Red Brute - Ranged - MegaBrute - Ice Fiend - Major Ice Fiend - Ice Brute - Major Ice Brute - Ice Ranged - Poison Fiend - Exploding Fiend - Chicken - Frog - Boar - Wolf - Raptor - Any Guard - Shadow Guard - Ghost Guard - Grotto Guard - Shark Guard - Rig Guard - Kit Guard - IO Guard - Trespasser Guard |
| **Initial Movement of Item** | None, **Gravity**, Toss | Movement types:   - **None**: Item is not tossed and does not fall on spawn. - **Gravity**: Item falls on spawn. - **Toss**: Item is tossed on spawn. |
| **Random Drop** | **Off**, Random, No Repeats | This option controls randomized spawning. If you choose **No Repeats**, the device randomly spawns every item in the device once before spawning any item a second time. |
| **Drop Chance** | **100%**, Pick or enter a percentage | Determines the chance that the device will drop items. |
| **Random Spawn Distance** | **0.0 Meters**, Pick or enter a distance | Determines how far from the eliminated target dropped items will spawn. |
| **Run Over Pickup** | On, **Off** | Determines if dropped items are automatically picked up when a player runs or drives over them. |
| **Item Scale** | **1.0**, Pick or enter a scale | Determines the size of items spawned by this device. |
| **Initial Weapon Ammo** | **Don't Override**, select a number from 1 to 999 | Sets the amount of ammunition loaded in the weapon when granted, limited by the weapon's magazine size. |
| **Spare Weapon Ammo** | **Default**, select a number from 1 to 999 | Sets how much spare ammunition is added to the player's inventory when a weapon is granted. **Default** provides ammo based on the ammo type used by the weapon. |
| **Selected Team** | **Any**, Pick or enter a number | The device only activates when a player on the selected team is eliminated. The device will always activate for applicable creatures. |
| **Invert Selected Team** | **Off**, On | If set to **On**, eliminated players on the selected team do not activate the device.. |
| **Selected Class** | No Class, **Any**, Pick or enter a number | The device only activates when a player with the selected class is eliminated. The device will always activate for applicable creatures. |
| **Invert Selected Class** | On, **Off** | If this is set to **On**, eliminated players with the selected class do not activate the device. |
| **Elimination Penalty** | **Off**, *On* | Determines whether there is a penalty applied when a target is eliminated. If this is set to **On**, additional options are displayed below this one. |
| **Penalty Item** | **All**, Gold, Materials, Score | *This only displays if the **Elimination Penalty** option is set to **On***. Determines what items are affected by the elimination penalty. |
| **Penalty Amount** | **10%**, Pick or enter a percentage | *This only displays if the **Elimination Penalty** option is set to **On***. Determines the how much of the item that is removed as a penalty. |
| **Penalty Effect** | **Remove**, Drop, Grant to Eliminator | *This only displays if the **Elimination Penalty** option is set to **On***. Determines what happens to the penalty item.  Values for this option are:   - **Remove**: The penalty amount of items are removed from the eliminated player's inventory. - **Drop**: The penalty amount of the eliminated player's items are dropped on the ground, and other players can pick them up. - **Grant to Eliminator**: The penalty amount of the eliminated player's items is granted to the player that eliminated them. |
| **Pickup Allowed Team** | **Any**, Pick or enter a number | Determines which team is allowed to pick up items spawned by this device. |
| **Invert Pickup Allowed Team** | On, **Off** | If this is set to **On**, the team set in **Pickup Allowed Team** is the only team not allowed to pick up items spawned by this device. |
| **Pickup Allowed Class** | No Class, **Any**, Pick or enter a number | Determines which classes are allowed to pick up items spawned by this device. |
| **Invert Pickup Allowed Class** | On, **Off** | If this is set to **On**, the class set in **Pickup Allowed Class** is the only class not allowed to pick up items spawned by this device. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. If more than one device or event can enable the device, click **Add** to add another line. |
| **Disable When Receiving From** | This function disables the device when an event occurs. If more than one device or event can disable the device, click **Add** to add another line. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Item Picked Up Send Event To** | When an item is picked up, an event is sent to the selected device, which triggers the selected function. |
| **On Eliminated Send Event To** | When a player is eliminated, an event is sent to the selected device, which triggers the selected function. |
| **On Elimination Send Event To** | When a player eliminated another player, an event is sent to the selected device, which triggers the selected function. |
