# Conditional Button Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/conditional-button-device-design-examples-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:06:20.246314

---

The **Conditional Button** device can only be triggered when a player carries one or more specific items. You can [register](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#register) any required items to the device.

You'll find multiple examples here of fun ways to make conditional buttons an integral part of your gameplay! Also note that each example is a little more complex than the one before it, so if you're new to Fortnite Creative, start with the first example to build your creative skills!

## Example 1: Locked Door

A common use for a conditional button is to create a locked door that can be opened with a specific item — for instance, a keycard. This is useful in many situations, such as when creating new puzzles or games where exploration is a basic mechanic.

### Devices Used

- 1 x [**Conditional Button**](using-conditional-button-devices-in-fortnite-creative) device
- 1 x [**Lock**](using-lock-devices-in-fortnite-creative) device

### Build Steps

1. Go to the **Prefabs** category in the **Content** browser and search for **Blue House**. Place the entire structure on your island, then find the front door.

   [![](https://dev.epicgames.com/community/api/documentation/image/58ff1f89-adbc-4f6b-9592-0ceef76aba3d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/58ff1f89-adbc-4f6b-9592-0ceef76aba3d?resizing_type=fit)
2. Find the **Lock** device under the **Devices** category on the **Content** browser, then place it on the doorframe. Make sure that the lock touches the building and that the light on the lock is blue as this indicates that it successfully connected to the door.

   [![](https://dev.epicgames.com/community/api/documentation/image/7ea690d0-6431-47fd-bc8a-7a56e56be36d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7ea690d0-6431-47fd-bc8a-7a56e56be36d?resizing_type=fit)
3. Open the door and go inside, then place a Conditional Button device on the other side of the door.
4. Without moving away from the conditional button, go to the **Items** category in the **Content** browser, and search for **keycard**. Click the keycard item you want to use, then click **Drop** to register it to the Conditional Button device.
5. [**Direct event binding**](getting-started-with-direct-event-binding-in-fortnite-creative) is how you set devices to communicate directly with other devices. This involves setting **functions** or **events** for the devices involved. Open the **Customize** panel for the conditional button, then set the following event.
6. Open the **Customize** panel for the conditional button, then set the following event.

   [![](https://dev.epicgames.com/community/api/documentation/image/9deb1c32-4084-49d5-ba0b-c5d573e4311f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9deb1c32-4084-49d5-ba0b-c5d573e4311f?resizing_type=fit)

   This tells the conditional button to open the lock device when it's activated.
7. From the **Items** category, select the keycard you just registered with the Conditional Button device, then click **Add to Chest**. This will put the keycard into a chest.

   [![](https://dev.epicgames.com/community/api/documentation/image/8cfa9f8e-435d-4ca8-8523-0f101ab9cf29?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8cfa9f8e-435d-4ca8-8523-0f101ab9cf29?resizing_type=fit)
8. After you add one or more items to the chest, go to the **Chest** category and click **Create Chest**. The chest will be added to your island.

   [![](https://dev.epicgames.com/community/api/documentation/image/f60b9537-5e3e-40b6-9267-3f36d7a1179c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f60b9537-5e3e-40b6-9267-3f36d7a1179c?resizing_type=fit)

A player can now take the keycard from the chest to unlock the door!

### Design Tips

Think about other ways you could use a locked door:

- A single player survival map where the player needs to search through an abandoned warehouse to find a key that opens the door to a huge supply cache.
- Players must eliminate a certain number of enemies in an area to gather enough materials to open a door to a new section of gameplay.

Find creative ways to implement this simple combination of devices!

## Example 2: Craft a Gun

Conditional Button devices can require the player to provide multiple items before it's triggered.

In this example, you will learn how to create a simple system for the player to [craft](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#crafting) a gun using building materials.

### Devices Used

- 1 x [**Conditional Button**](using-conditional-button-devices-in-fortnite-creative) device
- 1 x [**Item Granter**](using-item-granter-devices-in-fortnite-creative) device

### Build Steps

1. Set up your island with sources of three building materials: **wood**, **stone**, and **metal**. You can use any props you want as long as they are made of these materials.
2. Place an **Item Granter** device.
3. While standing near the item granter, drop a pistol from the **Weapons** category on the **Content** browser to register the weapon to the item granter.
4. Place a **Conditional Button** device and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/6c29d637-91e1-4f61-b20c-b636c598e653?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c29d637-91e1-4f61-b20c-b636c598e653?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Number of Key Item Slots** | 3 | This lets you register three different key items. |
   | **Key Items Required** | 100 | Each key item will require 100 to activate the button. |
   | **Second Key Items Required** | 100 | See **Key Items Required** above. |
   | **Third Key Items Required** | 100 | See **Key Items Required** above. |
5. While standing near the Conditional Button device, go to the **Items** category in the **Content** browser, then find and drop **wood**, **stone**, and **metal** to register the materials to the device.
6. Configure a conditional button event to grant the pistol from the item granter to the player when the device is activated.

   (w:600)

   This tells the item granter to grant the pistol to the player when the conditional button has all the items it needs to trigger.

### Design Tip

Using multiple different key items opens up new uses for the Conditional Button device.

Crafting is a fun addition to many different game genres, including farming and survival games. This crafting system could be extended into a more robust system with many different ingredients and outputs, potentially even with certain outputs serving as ingredients for different recipes.

## Example 3: Upgrade a System

Many games use a currency system to reward players and allow them to purchase different items and upgrades. The Conditional Button device is one way to achieve a working upgrade system.

You can use [**Billboard devices**](using-billboard-devices-in-fortnite-creative) to label your conditional buttons for the player.

### Devices Used

- 2 x [**Item Granter**](using-item-granter-devices-in-fortnite-creative) devices
- 1 x **[Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-spawn-pad-devices-in-fortnite-creative)** device
- 1 x [**Creature Spawner**](using-creature-spawner-devices-in-fortnite-creative) device
- 1 x [**Elimination Manager**](using-elimination-manager-devices-in-fortnite-creative) device
- 1 x [**Health Powerup**](using-item-granter-devices-in-fortnite-creative) device
- 2 x [**Conditional Button**](using-conditional-button-devices-in-fortnite-creative) devices

### Build Steps

1. Place an **Item Granter** device and name it Pistol Item Granter. Drop a pistol while standing near it to register the weapon to the device.
2. lace a **Player Spawner** device where you want the player to spawn.
3. Configure the player spawner with an **event** that grants the player a pistol when they spawn. (You will set up the option later for players to purchase an upgraded weapon.)

   [![](https://dev.epicgames.com/community/api/documentation/image/d72c72f5-ff63-49c9-90db-4b60eb4698ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d72c72f5-ff63-49c9-90db-4b60eb4698ef?resizing_type=fit)
4. Place a **Creature Spawner** device away from the player’s spawn area.
5. Place an **Elimination Manager** device, then drop a stack of gold while standing near it to register the gold to the device.
6. Place a **Health Powerup** device and customize it:

   [![](https://dev.epicgames.com/community/api/documentation/image/ad8ccd48-6a55-4138-bb99-8fae8e1bd72a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad8ccd48-6a55-4138-bb99-8fae8e1bd72a?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Effect Magnitude** | 100 | How much health the player gets when this device is activated. |
   | **Respawn** | No | Once used, the powerup will not respawn. |
   | **Spawn on Mini-Game Start** | No | This powerup should not spawn until the player activates it. |

   The Health Powerup will restore all of the player’s health, but will not spawn until triggered by another device. As you continue through this example, you will set this up so a player can purchase the health upgrade for 1,000 gold.
7. Place a second **Item Granter** device, rename it **Assault Rifle Item Granter**, then drop an **assault rifle** while standing near it to register the weapon to the device. You will set up this upgrade so a player can purchase it for 2,500 gold.
8. Place a Conditional Button device and name it **Health Conditional Button**.
   Customize the **Key Items Required** option to **1,000**. This will be used to restore a player's health when a player uses 1,000 gold.

   [![](https://dev.epicgames.com/community/api/documentation/image/aff7e08e-060f-4580-8a95-04d9a08b7479?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aff7e08e-060f-4580-8a95-04d9a08b7479?resizing_type=fit)
9. Set an event on this device that spawns the Health Powerup when activated.

   [![](https://dev.epicgames.com/community/api/documentation/image/60ff8962-03c3-42fa-948c-b3a851e69539?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/60ff8962-03c3-42fa-948c-b3a851e69539?resizing_type=fit)
10. Place a second conditional button and name it **Upgrade Conditional Button**. Set the **Key Items Required** to **2.500**. This will be used to upgrade a player's weapon when a player has 2.500 gold.

    [![](https://dev.epicgames.com/community/api/documentation/image/b0d0a186-6744-4733-9840-e8b37e73c983?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b0d0a186-6744-4733-9840-e8b37e73c983?resizing_type=fit)
11. Set an event on this button that activates the **Assault Rifle Item Granter** to **Grant Item** when activated.
12. Register gold to each of the conditional buttons from the **Items** category.

### Design Tip

The core functionality of an upgrade system can be extended to create all kinds of new and exciting gameplay. Explore ways in which different devices can be connected to this system.

For example, a player could purchase upgrades that provide additional ammo or other resources, friendly guards to fight alongside them, or even access to a vehicle!
