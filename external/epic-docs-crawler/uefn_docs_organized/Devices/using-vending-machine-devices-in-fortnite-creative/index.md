# Vending Machine Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-vending-machine-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:37:27.230319

---

The **Vending Machine** is a device that can hold and [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) [items](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#item), with an optional [cost](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) for each item. The Vending Machine can hold up to three items, and players can cycle between these by hitting the machine with their pickaxe.

The Vending Machine is one of several devices in Creative that spawns items — in this case, spawning them in front of the device when the player pays the cost. If the item was spawned by a player interacting directly with the device (not remotely), the item will be added to the player's inventory. To add an item to the Vending Machine, drop it in front of the device while in [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode).

To find the Vending Machine device, go to the Creative inventory and select the Devices tab. From there you can search or browse for the device. For more information on finding devices see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Adding Items to the Device

[![Adding items to the Vending Machine](https://dev.epicgames.com/community/api/documentation/image/fc76aa84-394f-41c3-b015-b928bf92dc5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc76aa84-394f-41c3-b015-b928bf92dc5b?resizing_type=fit)

1. Stand in front of the Vending Machine.
2. Press the **Tab** key to open the Creative inventory. Click the tab for the type of item you want to [register](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#register) to the device. Locate the item and select it.
3. Click **Equip** at the bottom of the screen. This equips the item to your [Equipment Bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#equipment-bar).
4. Repeat the first three steps until you have equipped the three items you want to put in the Vending Machine.
5. While still in the Creative inventory, drag an item from your Equipment Bar into a blank area on the screen. This drops the item, and if you are in front of the device it will add that item to the device.
6. Repeat the previous step for the other two items. You should see images of the three items cycling on the front display of the Vending Machine.

## Device Options

When placed, the Vending Machine is inactive. When an item is dropped onto it in Create mode, a preview of that item will appear on the screen. When the game starts, a player can interact with the device and it will spawn the item. By default, there is no cost for the item.

You can register up to three items to the Vending Machine, and will show an error message if you try to add more.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **First Item Resource Type** | **Wood**, Stone, Metal, Gold | Determines what type of resource the first item is purchased with. |
| **Cost of First Item** | **No Cost**, Pick a cost | Determines the amount of resources (defined in the **First Item Resource Type** option) the first item costs. |
| **Second Item Resource Type** | Wood, **Stone**, Metal, Gold | Determines what type of resource the second item is purchased with. |
| **Cost of Second Item** | **No Cost**, Pick an amount | Determines the amount of resources (defined in the **Second Item Resource Type** option) the second item costs. |
| **Third Item Resource Type** | Wood, Stone, **Metal**, Gold | Determines what type of resource the third item is purchased with. |
| **Cost of Third Item** | **No Cost**, Pick an amount | Determines the amount of resources (defined in the **Third Item Resource Type** option) the third item costs. |
| **Initial Weapon Ammo** | **Don't Override**, select a number from 1 to 999 | Sets the amount of ammunition loaded in the weapon when granted, limited by the weapon's magazine size. |
| **Spare Weapon Ammo** | **Default**, select a number from 1 to 999 | Sets how much spare ammunition is added to the player's inventory when a weapon is granted. **Default** provides ammo based on the ammo type used by the weapon. |
| **Enabled at Game Start** | **Yes**, No | Determines whether or not the Vending Machine is enabled at start of the game. |
| **Interaction Time** | **Instant**, Pick an amount of seconds | Determines how long the player needs to hold down the Interact control to purchase an item from the Vending Machine. |
| **Model** | **Default**, Western, Modern, Screen Only | Determines the visual style of the Vending Machine. |
| **Selected Team** | **Any**, pick a number | Determines which team can use the Vending Machine. |
| **Invert Team Selection** | **Off**, On | When set to **On**, all teams except the **Selected Team** can use this device. |
| **Selected Class** | No Class, **Any**, pick a number | Determines which class can use the Vending Machine. |
| **Invert Class Selection** | **Off**, On | When set to **On**, all classes except the **Selected Class** can use this device. |

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
| **Cycle to Next Item When Receiving From** | Cycles through the registered items to the next item in the Vending Machine when an event occurs. |
| **Spawn Item When Receiving From** | Spawns an item when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Item Spawned Send Event To** | When an item spawns, it sends an event to the selected device, which triggers the selected function. |

## Design Examples

Here are some examples of how you can use the Vending Machine device.

- You can resize the Vending Machines.
- You can use resources to purchase items.
- You can Enable or Disable Vending Machines.
- You can place multiple items in each Vending Machine.

### Resizing Vending Machines

If you resize the Vending Machines, you can fit many Vending Machines into a smaller area, such as an equipment store.

You can also connect the size of the Vending Machine to the value of the items, then stack smaller machines with less valuable items, and put more expensive items in larger machines.

[![Resizing the Vending Machine Device](https://dev.epicgames.com/community/api/documentation/image/c01ad5b4-d105-436b-84af-cb3c7a936325?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c01ad5b4-d105-436b-84af-cb3c7a936325?resizing_type=fit)

*Click image to enlarge.*

**Designer's Tip**

If you are going to stack machines, or place them near each other, make sure that they are already filled with items. Trying to drop items into machines that are close to each other is difficult, because you might end up adding it to the wrong one.

### Using Resources To Purchase Items

As a creator, you can adjust the cost of the items in a Vending Machine and use any kind of resource as a currency. For each item you can set Wood, stone, metal or gold as the currency used to pay for that item. For example, the first item can cost 50 wood, the second item can cost 100 stone, and the third item can cost 200 gold.

This gives you some interesting ways to control the resources on your island, and determines how valuable every type of resource is.

### Enable or Disable Vending Machines

The Vending Machine can be disabled until a channel is activated. This effectively locks the machine until a criteria is met, or until the player performs a specific action. This is useful if you want to limit the player's access to items.

[![A disabled Vending Machine](https://dev.epicgames.com/community/api/documentation/image/e99a5ec2-d29a-44ce-b091-2e568cc9480f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e99a5ec2-d29a-44ce-b091-2e568cc9480f?resizing_type=fit)

1. Place a Vending Machine device and customize the following options as shown below.

   - **Enabled At Game Start**: No
   - **Enable When Receiving From**: Channel 1
   - **Disable When Receiving From**: Channel 2
2. By using other devices to send the appropriate signals, you can enable or disable the device from being used certain times during your game.

**Designer's Tip**

You can have Vending Machines become available when a player reaches a certain level, when they press a certain button, or even when they defeat a specific type of creature.

### Multiple Items in Each Vending Machine

Each Vending Machine can sell up to 3 different items.

1. To put three items into the machine, drop the items in order that you want them to be displayed.
2. Next open the Customize panel and enter a price for each item using the **Cost of First Item**, **Cost of Second Item** and **Cost of Third Item** options. The price values range from **No Cost** to 999 of any resource. The type of resource used to buy an item is set in the **Resource Type** option for each item.

   [![Cycling Vending Machine Video](https://dev.epicgames.com/community/api/documentation/image/0a0a61dd-79d5-45b0-ba11-8ef32c9dfa71?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0a0a61dd-79d5-45b0-ba11-8ef32c9dfa71?resizing_type=fit)

A player can cycle through each item in the Vending Machine by waiting for a few seconds until the next item is shown, or by using their pickaxe to hit the machine. Each hit will show the next item that can be purchased.

**Designer's Tip**

You can include a text message for the player, using a HUD Message or Billboard device to remind them that they can hit the Vending Machine to cycle through all the available items that it can sell.
