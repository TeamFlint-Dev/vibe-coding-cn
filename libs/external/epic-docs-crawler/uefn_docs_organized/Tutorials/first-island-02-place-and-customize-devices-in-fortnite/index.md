# 2. Place and Customize a Device

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/first-island-02-place-and-customize-devices-in-fortnite
> **爬取时间**: 2025-12-26T23:53:15.166008

---

**Devices** are assets that do things. Different devices do different things, but they all do *something*. Some devices wait for player interaction to do something, while other devices do something when they're triggered by another device.

Devices, along with other devices and player actions, are what create **gameplay**.

In this tutorial, using devices, you will set up the game so that the player receives a weapon when spawning onto the island. The player will use that weapon to shoot at the targets. When the player hits a target, their score will change. This is a basic **gameplay loop**, which is a key element of game design.

## Devices Used

- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device

## Place the Item Granter

You already have the Player Spawner device on your island. To give the player a weapon when they spawn, you will use an **Item Granter** device.

1. If the Content Browser is not already open, go to the menu bar at the top, click **Window** > **Content Browser**, then select the **Content Browser 1** panel.

   [![](https://dev.epicgames.com/community/api/documentation/image/734171c2-3770-41e9-8ce1-57b5717d998f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/734171c2-3770-41e9-8ce1-57b5717d998f?resizing_type=fit)

   This opens the **Content Browser**.

   [![](https://dev.epicgames.com/community/api/documentation/image/574c27d0-8875-40bd-a3f1-8f33f4577278?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/574c27d0-8875-40bd-a3f1-8f33f4577278?resizing_type=fit)

   If you close the Content Browser, when you open it again, it will restore to exactly how it was when you closed it.
2. An **asset** is any element you use to build a game. The **Content Browser** is where you can find all of the assets associated with or available to your project.

   In the Content Browser, click **Fortnite**. This shows the different asset folders.

   [![](https://dev.epicgames.com/community/api/documentation/image/5fd3480a-3dfb-44b5-9aed-35368bb485d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5fd3480a-3dfb-44b5-9aed-35368bb485d5?resizing_type=fit)
3. Click the **Devices** folder and scroll down until you find the **Item Granter** device, or use the **search bar** to quickly search for **item granter**.

   [![](https://dev.epicgames.com/community/api/documentation/image/c2b206f6-b5c3-4f1a-aa71-fe528f54fe11?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c2b206f6-b5c3-4f1a-aa71-fe528f54fe11?resizing_type=fit)
4. Drag the **Item Granter** device into the viewport.

   ![](https://dev.epicgames.com/community/api/documentation/image/142b2c97-5e6e-45c9-9049-e1f2b3652b2e?resizing_type=fit)

## Customize the Item Granter

All devices have default settings that determine what they do, but you can customize most devices to create your own gameplay. Rather than customizing the actual device, you are going to customize an **instance** of the device.

Think of an **instance** as a unique copy of your asset. The original asset determines the default properties for that asset (in this case, the Item Granter device), but you can customize the new instance without affecting the original asset.

1. Open the **Details** panel if it's not already open (**Window > Details > Detail 1**).
2. Click the **Item Granter** device in the viewport to select it and you'll see the device in the Details panel.
3. Highlight **Item Granter (Instance)**, then set the following **User Options**:

   [![](https://dev.epicgames.com/community/api/documentation/image/9d80d3fc-c263-485a-b98a-58ddcf1b23a3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d80d3fc-c263-485a-b98a-58ddcf1b23a3?resizing_type=fit)

   |  |
   | --- |
   | On Grant Action = **Keep All** |
   | Grant = **All Items** |
4. Without collapsing User Options, expand **Advanced**, then customize these settings:

   |  |
   | --- |
   | Grant on Cycle = **Uncheck** |
   | Equip Granted Item = **Check** |
   | Item Count = **Check**, then **1** |

## Add a Weapon and Ammo

To provide a weapon for the player, you will need to **register** the weapon with the granter. **Registering** is how you associate a weapon (or any other item) with the Item Granter device.

1. On the **Item Granter (Instance)** Details panel, look under **User Options** and find **Item List**.
2. An **array** is a collection of items or data. Click the **+ icon** next to **Array**, then click the dropdown for **Index [0]**.

   [![](https://dev.epicgames.com/community/api/documentation/image/b162fa17-5da4-4121-be95-0c3c06bbb7ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b162fa17-5da4-4121-be95-0c3c06bbb7ea?resizing_type=fit)

     This opens more options.
3. Click the dropdown shown below.

   [![](https://dev.epicgames.com/community/api/documentation/image/548e8f10-2586-4cc0-ba9e-a6d7db733cef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/548e8f10-2586-4cc0-ba9e-a6d7db733cef?resizing_type=fit)

   This opens another window where you can search for a specific item or a type of item.
4. Type **assault rifle** in the search bar, then select from the list of weapons.

   [![](https://dev.epicgames.com/community/api/documentation/image/2815db17-01a9-4939-a142-10ed6ca86efd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2815db17-01a9-4939-a142-10ed6ca86efd?resizing_type=fit)
5. To search for a specific weapon, you can use the weapon name. Select an **assault rifle** from the list. This adds the rifle to the Array list for the Item Granter device.

   [![](https://dev.epicgames.com/community/api/documentation/image/7c2da40e-04f1-4262-b0f4-c7460e2ad6ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7c2da40e-04f1-4262-b0f4-c7460e2ad6ea?resizing_type=fit)

   Select an assault rifle.

   The **Item Quantity** is **1** by default. The granter will grant one assault rifle to the player.

   [![](https://dev.epicgames.com/community/api/documentation/image/5dff412b-904e-4550-aa9e-1e20b7385c55?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5dff412b-904e-4550-aa9e-1e20b7385c55?resizing_type=fit)

   Quantity of Item Index [0].
6. Click the **+ icon** next to **Item List** to add another item.
7. Type ammo in the search bar. This surfaces all the ammo types in the search list.

   [![](https://dev.epicgames.com/community/api/documentation/image/5fa1212f-5408-4075-9c56-71aece67b949?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5fa1212f-5408-4075-9c56-71aece67b949?resizing_type=fit)

   Add Medium Bullets at quantity 900.
8. Assault rifles use **medium bullets**. Search for and select the **AmmoMediumBullets** from the list.

The next step is to get the Player Spawner and Item Granter devices working together.

## Bind the Item Granter and Player Spawner

Devices communicate using **Functions**, whichare things devices do, and **Events**,whichare things that trigger functions.

Unlike in Fortnite Creative, where you can bind from a function to an event or from an event to a function, in UEFN, you can only bind from a function to an event.

1. From the **Item Granter (Instance)** in the Details panel, go to **User Options - Functions** and expand it.
2. Scroll down to **Grant Item,** click the **+ icon**, then click the dropdown. **Grant Item** is the **function** you'll bind from.

   [![](https://dev.epicgames.com/community/api/documentation/image/4128fdb3-db91-4249-b583-a18cf4da16dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4128fdb3-db91-4249-b583-a18cf4da16dc?resizing_type=fit)
3. Search for or scroll down to **Player 1 Spawn Pad** and click it to select. This is the device you'll **bind** the **Item Granter** to.

   [![](https://dev.epicgames.com/community/api/documentation/image/edc871de-12b7-42f0-a448-2504eb6c467e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/edc871de-12b7-42f0-a448-2504eb6c467e?resizing_type=fit)
4. Click the dropdown, then select **On Player Spawned**. This is the event you're binding to the **Grant Item** function.

Players spawning onto the island now spawn with the assigned assault rifle and ammo!

If you ever have difficulties finding the settings you're looking for, click the edge of the Details panel and drag it to make it wider.

## Move Objects

You can move an **asset**, also known as an **object**, using one of the **Move** tools. 

[![](https://dev.epicgames.com/community/api/documentation/image/3c4a64c3-127a-4127-8309-36c059b462d2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c4a64c3-127a-4127-8309-36c059b462d2?resizing_type=fit)

The **pivot point** controls how an object **rotates** and **scales**. Any change of size or orientation is relative to the object's pivot point. The pivot point is at the bottom of any object that is included with or native to UEFN. The **QWER** keys are the keyboard equivalents to clicking the icons.

|  |  |  |
| --- | --- | --- |
| **1. Select objects (Q)** | Selects an object and highlights it. |  |
| **2. Select and translate objects (W)** | Makes it translatable (movable) using the translate arrows. |  |
| **3. Select and rotate objects (E)** | Makes it rotatable in three dimensions. |  |
| **4. Select and scale objects (R)** | Makes it scalable in three dimensions. |  |

The other key component of moving objects is the **axis**. **Axes** are directions in three dimensions. These axes are in relation to the pivot point, and are referred to as **X-axis**, or **up**, **Y-axis**, or **left**, and **Z-axis**, or **forward**.

## Up Next

[![3. Build a Shooting Gallery](https://dev.epicgames.com/community/api/documentation/image/126bd430-2bc9-47d2-8208-f8d2d20b33b9?resizing_type=fit&width=640&height=640)

3. Build a Shooting Gallery

Add some target devices to build your gallery and a barrier to keep players from getting too close.](https://dev.epicgames.com/documentation/en-us/fortnite/first-island-03-build-a-shooting-gallery-in-fortnite)
