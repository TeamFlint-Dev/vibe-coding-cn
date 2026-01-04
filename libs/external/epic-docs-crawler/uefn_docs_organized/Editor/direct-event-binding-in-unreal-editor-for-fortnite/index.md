# Using Direct Event Binding

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/direct-event-binding-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:29:38.902208

---

If you’ve ever created an island in **Fortnite Creative**, you’ll be familiar with the **channel system** that uses [transmitters](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#transmit) and [receivers](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#receive) to send signals between devices.
**Unreal Editor for Fortnite (UEFN)** uses a **direct event binding** that allows devices to talk to one another directly by using **functions**. In other words, it binds an [event](unreal-editor-for-fortnite-glossary#event) (a trigger) from one device to a [function](unreal-editor-for-fortnite-glossary#function) in another device.
Think of **events** as **transmitters** and **functions** as **receivers**, where one device’s event tells another device to perform a function. For example, the event of a player spawning on a spawn pad causes the [Prop Mover](https://www.epicgames.com/fortnite/en-US/creative/docs/using-prop-mover-devices-in-fortnite-creative) device to begin moving a prop back and forth.

[![When the player spawns on the pad, the prop begins to move.](https://dev.epicgames.com/community/api/documentation/image/6c7284b1-632b-4b5c-aafd-84e5eb985181?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c7284b1-632b-4b5c-aafd-84e5eb985181?resizing_type=fit)

The **direct event binding system** is superior for creating connections between multiple devices to trigger actions, define players, and customize gameplay.

## What Direct Event Binding Does

Devices in UEFN use the direct event binding system by default. Direct event binding does exactly what the name suggests. Two or more devices are bound together when you modify the device's **User Options - Function**. The function is used to bind devices together through an array of options in the **Details** panel.

You can even [copy and paste devices](outliner-tips-and-tricks-in-unreal-editor-for-fortnite) that use the direct event binding system to duplicate functions in another part of your island.

Duplicating a function creates a second unique direct event binding, meaning that when the original event or function is set off, it doesn’t affect the copied devices.

## How Direct Event Binding Works

The direct event binding system uses the device names to specify the function or event that takes place between multiple devices instead of sending signals through coordinated channels to trigger the action.

[![The difference between using a channel system and the direct event binding system](https://dev.epicgames.com/community/api/documentation/image/87bf25db-ca35-4c77-9cb7-06c41df71f62?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/87bf25db-ca35-4c77-9cb7-06c41df71f62?resizing_type=fit)

Channels must be paired correctly for events to take place, but the direct event binding system is a direct line of communication.

## Build It Yourself

Follow the instructions below to bind functions between these devices:

- **Collectables Gallery**
- **Score Manager**
- **Player Spawn Pad**

Drag the **Collectables Gallery**, **Score Manager**, and **Player Spawn Pad** onto the **Viewport** from the **Content Browser**. Select each device in the **Outliner** to edit their options in the **Details** panel.

### Collectables Gallery

[![Collectable collection device](https://dev.epicgames.com/community/api/documentation/image/68e28ddb-487e-4ca9-aa92-12e7c5e284a6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/68e28ddb-487e-4ca9-aa92-12e7c5e284a6?resizing_type=fit)

Set six coins aside from the collection. Only alter the options for these six coins.

Set the following options:

- Type **20** in the **Collectable Object** field.
- Type **50** in the **Score** field.
- Type **1** in the **Consume if collected by** field.
- Navigate to **User Options - Functions**, click the **plus icon** next to **Turn Visibility On**. An **Array Elements** panel opens:

  - Click the **eyedropper** icon and select the **Player Spawn Pad**.
  - Select **On Player Spawned** from the **function** dropdown menu.

All of the coins are visible to the player when they spawn, and as the player collects the coins, the **Score Manager** will track the points awarded for each coin until the win condition has been met.

### Score Manager

Set the following options:

- Type **50** in the **Score** field.
- Select **Add** from the **Score Award Type** dropdown menu.
- Make sure **Increment Score on Award** is checked.
- Type **50** in the **Score Change When Activated** and **Minimum Score** fields.
- Navigate to **User Options - Functions**, click the **plus** icon next to **Set to Player Score**:

  - Click the **eyedropper** icon and select the **Player Spawn Pad**.
  - Select **On Player Spawn** from the **Functions** dropdown menu.

The Score Manager is bound to the Player Spawn Pad and now increments the player’s score as they collect coins.  
Your gameplay example should look similar to the image below.

[![Set the Island settings for your island](https://dev.epicgames.com/community/api/documentation/image/6f4c5d47-c964-463c-a914-22d245f59bcd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6f4c5d47-c964-463c-a914-22d245f59bcd?resizing_type=fit)

### Island Settings

Edit the following options:

- Type **300** in the **Score to End** field.

The game will end when the player collects 300 points.

You now have a working function. The video below shows the result of the direct event binding system using the setup above.
