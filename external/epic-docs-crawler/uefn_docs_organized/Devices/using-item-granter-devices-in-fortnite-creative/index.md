# Item Granter Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:38:55.302538

---

The **Item Granter** device can automatically place items into player inventories during your game, or you can set conditions for manually placing items in player inventories.

You can determine what items are granted and when, and set other conditions by configuring the device using the options listed below. You can set whether to send an item to a player's inventory, or drop it near a player in-game. You can also use other devices to trigger the Item Granter.

To register items with the Item Granter, follow these steps.

1. In the Creative inventory, use the Weapons and Items tabs to find the items you want to register with the Item Granter. Click **EQUIP** to put them in your Player inventory.
2. Stand directly beside the Item Granter.
3. Press the **Tab** key to open the Creative inventory screen, then click **PLAY** to switch to the Player inventory screen.
4. Click the desired item, then press either **Z** or **X** to split or drop the item. You can also drag the item to the side until a [backpack icon](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#backpack-icon) appears.

When an item is registered with the Item Granter using the steps above, a hologram of the registered item will float above the device.

Like the [Item Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative), this device is the recommended method of delivering [items](https://dev.epicgames.com/documentation/en-us/fortnite/using-items-in-fortnite-creative) and weapons to players in game.

The difference between the Item Spawner and the Item Granter is that the Item Spawner creates the [registered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#register) item and drops it into the game world for players to pick up while the Item Granter automatically places the registered devices into the player's inventory.

**Looking for more inspiration?** See **[D-Launcher Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/dlauncher-device-design-examples-in-fortnite-creative)** to kick off your imagination!

To find the Item Granter device, go to the Creative inventory and select the Devices tab. From there you can search or browse for the device. For more information on finding devices see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

## Device Options

The Item Granter has some basic functionality, like what item to grant to players, what to do with a player's existing inventory when granting an item, and whether to give a player extra ammo if the player is given a weapon. Additionally, there are some advanced options, like setting conditions for when a player is granted an item, if players from certain teams get different items, and how the items in the device are cycled.

### Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled on Game Start** | **Yes**, No | Determines whether or not the device is enabled when the game starts. |
| **Receiving Players** | Triggering Team, **Triggering Player**, All, Pick a team | Determines which players receive the item. |
| **On Grant Action** | **Clear Inventory**, Clear Items, Clear Resources, Keep All | Defines the action that occurs when the device grants an item to a player. |
| **Grant** | **Current Item**, All Items | **Current Item**: Only the item selected on the device is granted to the player. **All Items**: All the items registered with the device are granted to the player. |
| **Grant Condition** | **Always**, Only If Empty, Only If Space, Only If Not Owned | Only grants items to players that meet this condition.  Values for this option are:   - **Always**: Always grants items to players. - **Only If Empty**: Only grants items to players if their inventory is completely empty. - **Only If Space**: Only grants items to players if there is space in the player's inventory. - **Only If Not Owned**: Only grants items to players if the item is not already in the player's inventory. |
| **Grant on Cycle** | **Yes**, No | When the device cycles to a new item, it grants that new item to the player. |
| **Equip Granted Item** | **No**, *Yes* | If the device gives items, equip the item listed. If **Yes** is selected, the **Item On Grant** option becomes available. |
| **Item to Grant** | **Item 1**, Pick an item number | *This option only appears if **Equip Granted Item** is set to **Yes***. If the device gifts items, equip the item listed here. If you choose an item later than the number gifted, the last item will be equipped instead. |
| **Remove Item On Grant** | **No**, Yes | When an item is granted, it is removed from the Item Granter. |
| **Initial Weapon Ammo** | **Don't Override**, select a number from 1 to 999 | Sets the amount of ammunition loaded in the weapon when granted, limited by the weapon's magazine size. |
| **Spare Weapon Ammo** | **Default**, select a number from 1 to 999 | Sets how much spare ammunition is added to the player's inventory when a weapon is granted. **Default** provides ammo based on the ammo type used by the weapon. |
| **Cycle Behavior** | **Stop**, Wrap | Determines how the device cycles through the items registered to the device.  Values for this option are:   - **Stop**: The device cannot cycle forward past the last item, or cycle backward past the first item. - **Wrap**: When the device reaches the last item registered, it will cycle around to the first item. |
| **Grant while offline** | **No**, Yes | If you choose **Yes** the device will continue granting items to players, even while they are not on the island. |
| **Drop Items at Player Location** | Never, Always, **If Inventory Full** | Determines when an inventory item should be dropped at the player's location rather than place it in the player's inventory. If set to **Never**, the **Ownership of Dropped Item** option becomes hidden. |
| **Ownership of Dropped Item** | All, **Receiving Player**, Instigator | Determines who can pick up a dropped item.  Values for this option are:   - **All**: Any player can pick up the item. - **Receiving Player**: Only the receiving player can pick up the item. - **Instigator**: Only the player who instigates the device can pick up the item. |
| **Grant on Timer** | **Off**, Pick an amount of time | If this option is set to an amount of time, the device grants items to players every time that amount of time has passed. |
| **Grant Time** | Pick a time | Grants an item at intervals based on time set. |
| **Play Audio** | **No**, Yes | Determines whether the device plays audio effects. |
| **Grant on Game Start** | **Off**, On | Set whether player gets the item at the start of the game. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Grant Item When Receiving From** | Grants an item when an event occurs. |
| **Cycle To Previous Item When Receiving From** | The device cycles to the previous item when an event occurs. |
| **Cycle To Next Item When Receiving From** | The device cycles to the next item when an event occurs. |
| **Cycle To Random Item When Receiving From** | The device cycles to a random item when an event occurs. |
| **Restock Items When Receiving From** | If items have been removed from the device, the device is restocked with items when an event occurs. |
| **Clear Save Data For Player When Receiving From** | This option only works when the **Grant While Offline** is set to **Yes**. The instigating player no longer receives items when that player is offline. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Item Granted Send Event To** | When the device grants an item to a player, it sends an event to the selected device, which triggers the selected function. |

## Gameplay Examples Using Item Granters

- [Mazey Escape](https://dev.epicgames.com/documentation/en-us/fortnite/mazey-escape-in-fortnite-creative)
