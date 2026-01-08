# Item Placer Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-item-placer-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:49:04.086356

---

The **Item Placer** device gives you a way to place weapons or [item](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) items in locations that are more realistic, as opposed to [Item Spawners](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#item-spawner) or chests that just drop items and weapons on the ground. You can drop an item or weapon onto the Item Placer to register it. The device acts as a container, but is shaped like the item registered. When a player interacts with the device, it grants the registered item to that player. If the device is mounted on a destructible object and that object is destroyed, the registered item drops to the ground. Destructible objects can include [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop), building pieces, and terrain, depending on the settings you have modified in [My Island](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) or in other devices.

To find the Item Placer device in Creative, see [**Using Devices**](using-devices-in-fortnite-creative). To find the Item Placer in UEFN, open the Content Drawer and click **Fortnite > Devices > Item**.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This device has some basic functionality, like setting the interaction time and which teams or [classes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) can interact with the device. Additionally, there are some advanced options, like inverting the class or team selection and determining whether the device is enabled when the game starts.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Allow Interact** | ***On***, Off | Determines whether players can interact with this device. If this is set to **Off**, the **Interact Text**, **Interact Time**, **Allowed Team**, and **Allowed Class** options do not display. |
| **Interact Text** | **Pick Up {item}**, Enter text | This text appears to players when they look at the item. The keyword **{item}** displays the name of the item that is registered with this device. The text field is limited to 150 characters. This option only displays if the **Allow Interact** option is set to **On**. |
| **Interact Time** | **Instant**, Pick an amount of time | Determines how long the player must hold the interaction control in order to activate the device. Use the arrows to choose an amount of time, or click in the field to type in a number. This option only displays if the **Allow Interact** option is set to **On**. |
| **Allowed Team** | None, **Any**, Pick a team | Determines which team can interact with the device. Click the arrows to choose, or click in the field to type in a number. This option only displays if the **Allow Interact** option is set to **On**. |
| **Invert Team Selection** | **Off**, On | If you choose **On**, all teams except the one selected in the **Allowed Team** option can interact with the device. |
| **Allowed Class** | No Class, **Any**, Pick a class | Determines which class can interact with the device. Click the arrows to choose, or click in the field to type in a number. If this is set to **No Class**, only players with no assigned class can interact with the device. This option only displays if the **Allow Interact** option is set to **On**. |
| **Invert Class Selection** | **Off**, On | If you choose **On**, all classes except the one selected in the **Allowed Class** option can interact with the device. |
| **Show Rarity Effects** | **On**, Off | Determines whether or not rarity effects for placed items are displayed when the device is enabled. |
| **Play Audio** | **On**, Off | Determines whether the device plays audio effects. |
| **Enabled at Game Start** | **Enabled**, Disabled | Determines whether the device is enabled when the game starts. |
| **Allow Respawn** | **Off**, On | Determines whether the device can respawn. |
| **Can Be Damaged at Game Start** | **Yes**, No | Determines whether the device can be damaged during the game. |
| **Item Health** | **1**, Pick a number | If the device can be damaged, this determines the amount of health the device has. Click the arrows to choose, or click in the field to type in a number. |
| **Allowed Class to Damage** | No Class, All, **Any**, Pick or enter a class number | Determines which class can interact with the device. Click the arrows to choose, or click in the field to type in a number. |
| **Invert Class Selection to Damage** | **Off**, On | If you choose **On**, all classes except the one selected in the **Allowed Class to Damage** option can damage. |
| **Allowed Team to Damage** | None, All, **Any**, Pick or enter a number | Determines which team can interact with the device. Click the arrows to choose, or click in the field to type in a number. |
| **Invert Team Selection to Damage** | **Off**, On | If you choose **On**, all teams except the one selected in the **Allowed Team** option can damage. |
| **Visual Style** | **Model**, Icon, Icon (Camera Facing) | Determines if the item is placed as its regular model or if it is placed as an icon. |
| **Wood Cost of Item** | **No Cost**, Pick or enter a number | Determines how much the item costs in wood. |
| **Metal Cost of Item** | **No Cost**, Pick or enter a number | Determines how much the item costs in metal. |
| **Stone Cost of Item** | **No Cost**, Pick or enter a number | Determines how much the item costs in stone. |
| **Gold Cost of Item** | **No Cost**, Pick or enter a number | Determines how much the item costs in gold. |

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
| **Enable Device When Receiving From** | This function enables the device when an event occurs. |
| **Disable Device When Receiving From** | This function disables the device when an event occurs. |
| **Respawn Device When Receiving From** | This function respawns the item when an event occurs. |
| **Allow Damage When Receiving From** | This function allows the device to take damage when an event occurs. |
| **Disallow Damage When Receiving From** | This function disallows the device to take damage when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Item Dropped Send Event To** | When the device drops an item, it sends an event to the selected device, which triggers the selected function. |
| **On Item Granted Send Event To** | When the device grants an item, it sends an event to the selected device, which triggers the selected function. |
| **On Item Respawned Send Event To** | When the device respawns an item, it sends an event to the selected device, which triggers the selected function. |
