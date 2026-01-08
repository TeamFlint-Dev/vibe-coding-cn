# Item Spawner Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:32:26.877594

---

This is a device that creators can use to create a [spawn point](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) for various [Items](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#item), and to assign specific items to each spawn location.

The **Item Spawner** is one of several devices in Creative that spawns items — in this case, spawning them just above the location of the device.

To find the Item Spawner device, go to the Content Browser and select the Devices category. From there you can search or browse for the device. For more information on finding devices, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

It’s helpful to [customize device names](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) when you use multiple copies of the same device.

## Device Options

This device has some basic functionality, like how much time passes between item spawns, and which classes can pick up spawned items. Additionally, there are some advanced options, such as setting a resource cost for spawned items.

The default state of the Item Spawner when it is first placed is Inactive.

### Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use italic for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

Default values are **bold**.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Items Respawn** | **On**, Off | Determines whether the device will keep the items in the list after they are spawned, or whether items are removed from the list when spawned. If you choose **Off**, If this is disabled, the device will eventually run out of items and be unable to spawn more. |
| **Random Spawns** | **Off**, Random, No Repeats | This option controls randomized spawning. If you choose **No Repeats**, the device randomly spawns every item in the device once before repeating an item. |
| **Base Visible During Games** | **On**, Off | Determines whether the device is visible to player during the game. |
| **Spawn Item On Timer** | **On**, *Off* | Set to specify how much time before an item spanws. When the option is set to **Off**, the **Time Before First Spawn** option is hidden. |
| **Time Before First Spawn** | Never, Instant, **10 seconds**, Pick an amount of time | After the game starts, this is how much time must pass before the device spawns an item. |
| **Respawn Item On Timer** | **On**, *Off* | Use Time Between Spawns to specify how much time to wait before spawning the next item. When set to **Off**, the **Time Between Spawns** option is hidden. |
| **Time Between Spawns** | Never, Instant, **10 seconds**, Pick an amount of time | This is how much time passes between one item spawn and the next one. |
| **Wood [Cost of Item](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary)** | **No Cost**, Pick an amount | How much wood the item costs. |
| **Stone Cost of Item** | **No Cost**, Pick an amount | How much stone the item costs. |
| **Metal Cost of Item** | **No Cost**, Pick an amount | How much metal the item costs. |
| **Gold Cost of Item** | **No Cost**, Pick an amount | How much gold the item costs. |
| **Initial Weapon Ammo** | **Don't Override**, select a number from 1 to 999 | Sets the amount of ammunition loaded in the weapon when granted, limited by the weapon's magazine size. |
| **Spare Weapon Ammo** | **Default**, select a number from 1 to 999 | Sets how much spare ammunition is added to the player's inventory when a weapon is granted. **Default** provides ammo based on the ammo type used by the weapon. |
| **Run Over Pickup** | *On*, **Off** | Determines the size of the item displayed. |
| **Allow Spawning When Blocked** | Yes, **No** | Only displayed when **Run Over Pickup** is set to **On**. Determines if an item can spawn even when a player blocks the spawner. |
| **Initial Movement of Item** | None, **Gravity**, Toss | Initial movement of item spawned. **None**: Item is not tossed or falls on spawn. **Gravity**: Item falls on spawn. **Toss** Item is tossed on spawn. |
| **Item Scale** | **1x**, Pick a size | By default, the items are displayed at normal size. You can choose to make the display larger so that items are more visible. |
| **Enabled At Game Start** | **Yes**, No | By default, the device is enabled when the game starts. If you want to set conditions for enabling the device, set this option to **No**. |
| **Continuously Spawn Items** | On, **Off** | Determines whether the device continues spawning items even if the previous items have not been picked up. Use with caution, as this can result in large numbers of items spawning in a single location if combined with other options such as **Items Respawn**, or **Time Between Spawns**. The last item spawned is tracked by the device, but the rest are left in the world and are not cleaned up if the device is disabled, or if **Cycle to Next Item** is [called](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#call). |
| **Allowed Team** | **Any**, Pick a team | Only players on this team are allowed to pick up items spawned by this device. |
| **Invert Team** | **No**, Yes | **No:** The chosen team is the only one that cannot activate the device. **Yes:** The chosen team is the only one that can activate the device. |
| **Affects Team** | All But Selected, **Only Selected** | If you choose **All But Selected**, anyone can pick up spawned items except players on the team selected in **Allowed Team**. If you choose **Only Selected**, only players on the team selected in **Allowed Team** can pick up spawned items. |
| **Allowed Class** | No Class, **Any**, Pick a class | Determines which class is allowed to pick up an item spawned by this device. If you choose **No Class**, only players without an assigned class can pick up items spawned by this device. |
| **Invert Class** | **No**, Yes | **No:** The chosen class is the only one that cannot activate the device. **Yes:** The chosen classis the only one that can activate the device. |
| **Affects Class** | All But Selected, **Only Selected** | If you choose **All But Selected**, anyone can pick up spawned items except players assigned the class selected in **Allowed Class**. If you choose **Only Selected**, only players assigned the class selected in **Allowed Class** can pick up spawned items. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Enable When receiving From** | Enables the device when an event occurs. |
| **Disable Device When Receiving From** | Disables the device when an event occurs. |
| **Cycle to Next Item When Receiving From** | Cycles the time spawner to the next item when an event occurs. |
| **Spawn Item When Receiving From** | Spawns an item from the item spawner when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Item Pick Up Send Event To** | When a player picks up the items, it sends an event to the selected device, which triggers the selected function. |

## Design Examples

Here is an example of how you can use the Item Spawner device.

### Continuous Item Spawning

To have items spawn nonstop after an event, combine an Item Spawner with a Switch.

**Devices used**:

- 1 x **Item Spawner**
- 1 x [**Switch**](using-switch-devices-in-fortnite-creative)

1. Place an **Item Spawner** and drop as many items as you would like near the device to register them. Customize it to the following settings:

   [![Item Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/aaa5bd85-4290-40fc-a225-c352da0cf95e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aaa5bd85-4290-40fc-a225-c352da0cf95e?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Random Spawns | Random | Each time the Item Spawner spawns an item, a random item from the device’s registered items will be spawned. |
   | Base Visible During Game | Off | The base will not be visible during gameplay. |
   | Time Before First Spawn | 1 Second | After being enabled, there will be a 1 second delay before the Item Spawner begins to spawn items. |
   | Time Between Spawns | Instant | There will be no delay between item spawns. |
   | Enabled At Game Start | No | The Item Spawner will not begin enabled and will not spawn items until it is enabled. |
   | Continuously Spawn Items | On | The Item Spawner will continue to spawn items regardless of whether or not they have been picked up. |

2. Place a **Switch** and customize it to the following settings:

   [![Switch Settings](https://dev.epicgames.com/community/api/documentation/image/2aa5d824-1553-4745-8d41-6e9a7d996ec0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2aa5d824-1553-4745-8d41-6e9a7d996ec0?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Device Model | Antique Lever | The Switch will appear as an Antique Lever in game. |

3. Set the direct event bindings of the Switch to the following:

   [![Switch Events](https://dev.epicgames.com/community/api/documentation/image/39449e73-e2fb-4ed9-a557-1c2e767b8b9a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/39449e73-e2fb-4ed9-a557-1c2e767b8b9a?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Turned On Send Event To | ItemSpawner | Enable | When the Switch is turned on, the Item Spawner will begin spawning items. |
   | On Turned Off Send Event To | ItemSpawner | Disable | When the Switch is turned off, the Item Spawner will stop spawning items. |

Here’s an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **ItemSpawner** | Enable | **Switch** | On Turned On Send Event To | When the Switch is turned on, the Item Spawner will begin spawning items. |
| **ItemSpawner** | Disable | **Switch** | On Turned Off Send Event To | When the Switch is turned off, the Item Spawner will stop spawning items. |

You now have the basic functionality for continuously spawning items.

This is a very effective technique to create rewards and sources of power for players. Try using different gameplay devices to enable the Item Spawner and begin the flow of items. Use a [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) to start the spawning when a player enters a room, or try connecting a [Guard Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/guard-spawner-device) so that the player will be rewarded after eliminating a guard.

Adjust the **Time Between Spawns** setting to find the spawn frequency that best fits your game mode.

## Gameplay Examples Using Item Spawners

- [Mazey Escape](https://dev.epicgames.com/documentation/en-us/fortnite/mazey-escape-in-fortnite-creative)
- [Shooting Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/shooting-gallery-in-fortnite-creative)
