# Shove Gameplay Item

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/shove-gameplay-item-in-fortnite
> **爬取时间**: 2025-12-27T00:09:46.719354

---

The **Shove** gameplay item grants a player the unique ability to push another player, and for physics-enabled islands, a prop a short distance.

The shoving action is done with bare hands by players (there is no external indication of whether or not a player has the item equipped). This hidden design can create an element of suspense on your island.

You can use this item in many ways to create interesting gameplay options:

- Players can push others off high places, causing fall damage.
- Players can push a team member or other ally out of the way of a hazard, vehicle, or attack.
- Players can push physics-enabled props on a trigger to activate an event.

To learn more about enabling physics, see [Getting Started with Physics](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-with-physics).

Add this item to your island to help create intense situations, for example, a player not knowing if others in the game will use the item to help or harm.

![Player using Shove to push another player off a cliff](https://dev.epicgames.com/community/api/documentation/image/18718546-4e2f-4ff6-89d0-85b3f22c1e64?resizing_type=fit)

Player using Shove to push another player off a cliff

## Finding the Shove Item in Creative

To find the Shove item in Creative, follow these steps:

1. Open the Creative Menu by pressing the **M** key on PC, or using the control that opens the Creative Menu. Click **Content** to open the inventory.
2. Click **Items** in the **Categories** panel on the left. To find the Shove item, you can type "shove" in the search bar, or just the first few letters of the word.

   [![Find the Shove item in the Creative Content browser](https://dev.epicgames.com/community/api/documentation/image/e86aba1e-0941-4a23-ba97-2a45f0858923?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e86aba1e-0941-4a23-ba97-2a45f0858923?resizing_type=fit)

   Find the Shove item in the Creative Content browser
3. Select the **Shove** item, and click **Equip** at the bottom of the screen. Alternatively, you can drag it to the Equipment bar.

To grant the Shove item to players, you need to attach it to a device such as the **Item Spawner**. See the **Registering Items in Creative** section to learn how.

## Finding the Shove Item in UEFN

To find the Shove item in UEFN and add it to your level, follow these steps:

1. Open your project in UEFN.
2. In the Content Browser, select the **Fortnite** Folder. In the search bar, type "shove", or just the first few letters of the word.

   [![Find the Shove item in the UEFN Content Browser](https://dev.epicgames.com/community/api/documentation/image/42201521-2a5f-41de-9df0-b66d5461d449?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42201521-2a5f-41de-9df0-b66d5461d449?resizing_type=fit)

   Find the Shove item in the UEFN Content Browser
3. Select the **Shove** item, and drag it into your level.

To grant the Shove item to players, you need to attach it to a device such as the **Item Spawner**. See the **Adding Shove to the Item List in UEFN** section to learn how.

## Registering Items in Creative

To grant items to a player, you can use several devices that grant players items. Some examples of devices that can grant items to players, or offer them in exchange for currency, are listed below.

- [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative)
- [Conditional Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative)
- [Elimination Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-elimination-manager-devices-in-fortnite-creative)
- [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)
- [Item Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative)
- Team Settings & Inventory
- [Vending Machine](https://dev.epicgames.com/documentation/en-us/fortnite/using-vending-machine-devices-in-fortnite-creative)

You must register items to attach them to the device. To register an item for this kind of device, follow the steps below.

1. In the **Content** tab of the menu screen, find the equipment and items you want to register with a device and equip them.
2. In Create mode, stand directly beside the device that will register the item.
3. Press the **Tab** key to open the player inventory screen.
4. Click and drag the item with your mouse until a backpack icon appears.

   ![Registering the Shove item with the Item Spawner](https://dev.epicgames.com/community/api/documentation/image/1da8c773-9026-46fb-ac34-95f6092fe1b1?resizing_type=fit)

   Registering the Shove item with the Item Spawner

The compatible device will automatically register the dropped item.

## Adding Shove to the Item List in UEFN

To grant the items to your players, you must attach the item to a device that grants items to players, or offers them to players in exchange for currency. For example, the steps below show you how to add the Shove item to an **Item Spawner** device.

1. In the Content Browser, expand the **Fortnite** folder and select the **Devices** folder.
2. In the search bar, type "spawner" to reduce the number of devices shown.
3. Scroll down to find the **Item Spawner** device, and drag it into your level.
4. Select the Item Spawner in your viewport or in the Outliner. In the **Details** panel, locate the **Item List** option under **User Options**.

   [![Locate the Item List option in the Details panel](https://dev.epicgames.com/community/api/documentation/image/46b2f432-408c-4e52-b209-623ea60e915c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/46b2f432-408c-4e52-b209-623ea60e915c?resizing_type=fit)

   Locate the Item List option in the Details panel
5. Click the **+ (plus)** icon to add an array element.

   [![Click the plus sign to add an array element](https://dev.epicgames.com/community/api/documentation/image/927b6943-2bf8-42b7-adde-9f8f9aac924f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/927b6943-2bf8-42b7-adde-9f8f9aac924f?resizing_type=fit)

   Click the plus sign to add an array element
6. Click the dropdown for **Pickup to Spawn**, and type "shove" into the search bar. Select the **Shove** item.

   [![Click the dropdown and select the Shove item](https://dev.epicgames.com/community/api/documentation/image/f54d2172-2018-4cc4-9a56-028b0ffc1144?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f54d2172-2018-4cc4-9a56-028b0ffc1144?resizing_type=fit)

   Click the dropdown and select the Shove item

Now the Shove item is attached to the Item Spawner, and it will spawn the item in the game.
