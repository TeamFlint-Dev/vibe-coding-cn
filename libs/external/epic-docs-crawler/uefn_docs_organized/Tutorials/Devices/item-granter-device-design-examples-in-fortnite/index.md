# Item Granter Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/item-granter-device-design-examples-in-fortnite
> **爬取时间**: 2025-12-26T23:06:52.313583

---

You can use the **Item Granter** device to place items into player inventories at any point in a game. This page walks you through three different examples of ways to use this device.

## Armed from the Start!

The Item Granter is great for giving players a weapon at the beginning of a game.

### Devices Used

- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Creature Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-spawner-devices-in-fortnite-creative) device

### Set Up the Devices

1. Place a **Player Spawner** device.
2. Place an **Item Granter** device and register a **Legendary Tactical Assault Rifle** to the device.

   Drop Items on the Item Granter to register them to the device!
3. Customize the Item Granter as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/6cc21e5a-99bd-48e3-ab38-9b406d124d68?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6cc21e5a-99bd-48e3-ab38-9b406d124d68?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | Equip Granted Item | Yes |
   | Spare Weapon Ammo | 999 |
   | Grant on Game Start | On |
4. Place a **Creature Spawner** in front of the Player Spawner.

You now have the basic functionality for a starting weapon.

### Design Tip

This is configured so that all players in the game will receive the same weapon at the beginning of the game. If you want specific players to receive specific weapons, use the built-in events to trigger specific Item Granters from different Player Spawners.

Similar functionality can be achieved with other devices, such as the Team Settings & Inventory Device, but this is one simple way to give the player a starting weapon.

## Weapon Upgrades

You can register multiple items to the Item Granter and decide how the device should grant these items — either all at once or by cycling through the items. In this example, you’ll use the cycling functionality to create a system that upgrades player weapons as they get eliminations.

### Devices Used

- 1 x Item Granter device
- 1 x Player Spawner device
- 1 x Creature Spawner device
- 1 x [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) device
- 1 x [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative) device

### Set Up the Basic Devices

1. Place a **Player Spawner** device.
2. Customize the spawner so it's not visible in-game:

   [![](https://dev.epicgames.com/community/api/documentation/image/c2414ec0-c5a6-49f6-a4d8-5374074ad333?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c2414ec0-c5a6-49f6-a4d8-5374074ad333?resizing_type=fit)
3. Place an **Item Granter**.
4. In order, register a Tactical Assault Rifle of each rarity (**Common**, **Uncommon**, **Rare**, **Epic**, **Legendary**).
5. Customize the Item Granter:

   [![](https://dev.epicgames.com/community/api/documentation/image/e6e468c5-7d3d-4deb-9174-09e0363fa5ba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e6e468c5-7d3d-4deb-9174-09e0363fa5ba?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | On Grant Action | Clear Items |
   | Equip Granted Items | Yes |
   | Remove Item on Grant | Yes |
   | Grant on Game Start | On |
6. Place a **Creature Spawner** in front of the Player Spawner.
7. Customize the Creature Spawner to select **Creature Type** as **Fiend**:

   [![](https://dev.epicgames.com/community/api/documentation/image/7d2ab6d2-a5a5-4908-8539-43521a635b21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d2ab6d2-a5a5-4908-8539-43521a635b21?resizing_type=fit)
8. Place a **Trigger** device.
9. Customize the Trigger:

   [![](https://dev.epicgames.com/community/api/documentation/image/b7b14819-36db-4a29-8615-6b8dc50d1e10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b7b14819-36db-4a29-8615-6b8dc50d1e10?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Visible In Game | Off |
   | Triggered by Player | Off |
   | Times Can Trigger | 10 |
   | Trigger VFX | Off |
   | Trigger SFX | Off |
   | Transmit Every X Triggers | 2 |
10. Place a **HUD Message** device.
11. Customize the HUD Message:

    [![](https://dev.epicgames.com/community/api/documentation/image/197a9854-e43e-4dcd-bdcf-c751926ca62c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/197a9854-e43e-4dcd-bdcf-c751926ca62c?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | Message | Receive a Weapon Upgrade |
    | Show on Round Start | On |
    | Time from Round Start | Instant |
    | Text Color | White |

### Bind Functions / Events

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#directeventbinding) is how you set devices to communicate directly with other devices. This involves setting [functions](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) and [events](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#event) for the devices involved.

1. Configure the following event on the Creature Spawner so it triggers the Trigger anytime a creature is eliminated.

   [![](https://dev.epicgames.com/community/api/documentation/image/5eb86d4e-74ba-49e5-9616-31c1e2a30491?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5eb86d4e-74ba-49e5-9616-31c1e2a30491?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On a Creature Is Eliminated Send Event To | Weapon Upgrade Trigger | Trigger |
2. Configure the following event on the Trigger so that every time it sends a triggered event (every 2 eliminations from the Creature Spawner), the Item Granter will grant a weapon upgrade.|

   [![](https://dev.epicgames.com/community/api/documentation/image/e0dd27b0-ad51-46bf-9b87-acd4a6c9d6b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e0dd27b0-ad51-46bf-9b87-acd4a6c9d6b1?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Triggered Send Event To | Weapon Item Granter | Cycle to Next Item |

You now have the basic functionality for an elimination-based weapon upgrade system!

### Design Tip

Item Granters can cycle through items in a few different ways. In this example, each item can only be granted once, but the device can be configured to continue granting items in a repeating pattern! Also, the **Cycle to Random Item** event can be used to trigger random item grants!

## Build an Automation Game!

Item Granters can also be configured to grant items repeatedly at a regular interval. In this example, you’ll use Item Granters to set up a basic automation game in which players can build “factories” that produce resources for them!

### Devices Used

- 6 x Item Granter devices
- 1 x Player Spawner device
- 5 x [Prop Manipulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-manipulator-devices-in-fortnite-creative) devices
- 5 x [VFX Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative) devices
- 6 x [Conditional Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative) devices
- 1 x [Tracker](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative) device

### Set Up the Play Area

1. Begin with the **Survival Island** starter island.
2. Near an area with trees, use floors from the **Shipyard Floor & Stairs Gallery** to create a platform.
3. On one side of the platform, place an upright computer console prop from the Shipyard Prop Gallery. This will be the visual for the Automated Wood Producers.

   [![](https://dev.epicgames.com/community/api/documentation/image/5b496a54-e439-4c01-80e6-6670e178ee34?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5b496a54-e439-4c01-80e6-6670e178ee34?resizing_type=fit)
4. On another side of the platform, place a desk-sized computer console prop from the Shipyard Prop Gallery. This will be the visual for the shop.

   [![](https://dev.epicgames.com/community/api/documentation/image/734366ca-81ec-432c-98f6-e2dbdf9733d1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/734366ca-81ec-432c-98f6-e2dbdf9733d1?resizing_type=fit)
5. On the platform, place a **Player Spawner** device.
6. Customize the Player Spawner to not be visible in-game.

### Configure the Automated Wood Producer

1. Behind the upright computer console, place an **Item Granter** device and register **Wood** to the device.
2. Customize the Item Granter:

   [![](https://dev.epicgames.com/community/api/documentation/image/100831b0-a63a-4c90-bd79-2230db84c4cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/100831b0-a63a-4c90-bd79-2230db84c4cb?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | On Grant Action | Keep All |
   | Item Count | 2 |
   | Grant on Timer | On |
3. Place a **Prop Manipulator** device that's connected to the upright computer console.

   The Prop Manipulator will be green when it is successfully connected to a prop.
4. Customize the **Prop Manipulator**:

   [![](https://dev.epicgames.com/community/api/documentation/image/a68e287b-8058-4084-9a9f-4e47c2219d64?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a68e287b-8058-4084-9a9f-4e47c2219d64?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Start Hidden | On |
   | Modify Prop Health | Yes |
   | Is Prop Invulnerable | Yes |
5. Place a VFX Spawner device in the middle of the upright computer console.
6. Customize the VFX Spawner:

   [![](https://dev.epicgames.com/community/api/documentation/image/93d3a48a-4a23-4e5f-8558-8519ebcd6134?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93d3a48a-4a23-4e5f-8558-8519ebcd6134?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Effect Type | Burst |
   | Burst Visual Effect | Explosion Electrical |
   | Colorize VFX | On |
   | Custom Color | #FFF000 |
7. Place a **Conditional Button** device at the front of the upright computer console and register **Gold** to the device.
8. Customize the Conditional Button:

   [![](https://dev.epicgames.com/community/api/documentation/image/1663e88e-d7cf-4090-8d0e-baeb72b48512?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1663e88e-d7cf-4090-8d0e-baeb72b48512?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/2ed7d521-92fb-4cfe-bcaf-da98ddf05765?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2ed7d521-92fb-4cfe-bcaf-da98ddf05765?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Interact Time | 2.0 Seconds |
   | Use Color for Hologram | On |
   | Interact Text | Build an Automated Wood Producer |
   | Missing Items Text | Not enough Gold for Automated Wood Producer! |
   | Disable After Use | On |
   | Key Items Required | 3 |
   | Visible During Game | Hologram Only |
9. Configure the following event on the Conditional Button so that when the player builds an Automated Wood Producer, the Item Granter begins granting wood, the computer console is made visible, and the VFX burst triggers.

   [![](https://dev.epicgames.com/community/api/documentation/image/60806e31-7bbf-4bf4-b8fb-2c12d9078228?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/60806e31-7bbf-4bf4-b8fb-2c12d9078228?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Activated Send Event To | Wood Producer Item Granter 1 | Grant Item |
   | On Activated Send Event To | Wood Producer VFX Spawner 1 | Restart |
   | On Activated Send Event To | Wood Producer Prop Manipulator 1 | Show Props |
10. Select all of these devices and props together (Conditional Button, Prop Manipulator, VFX Spawner, Item Granter, and upright computer console) and duplicate them four more times along the edge of the platform.

### Set Up the Shop and Quest

1. Place an Item Granter behind the desk-sized computer console and register **Gold** to the device.
2. Customize the Item Granter:

   [![](https://dev.epicgames.com/community/api/documentation/image/bd024729-f27b-4a40-85cd-e01dff60866c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd024729-f27b-4a40-85cd-e01dff60866c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | On Grant Action | Keep All |
   | Item Count | 5 |
3. Place a **Conditional Button** in front of the desk-sized computer console and register **Wood** to the device.
4. Customize the Conditional Button:

   [![](https://dev.epicgames.com/community/api/documentation/image/371c8e2d-e532-4be6-86d8-682a079637b9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/371c8e2d-e532-4be6-86d8-682a079637b9?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/76372350-9bac-4b2d-806e-23610c2dbabd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/76372350-9bac-4b2d-806e-23610c2dbabd?resizing_type=fit)

   | Option |  |
   | --- | --- |
   | Interact Time | 1.0 Second |
   | Direct Color | Gold |
   | Use Color for Hologram | On |
   | Interact Text | Sell 100 Wood for 5 Gold |
   | Missing Items Text | Not Enough Wood to Complete Sale! |
   | Key Items Required | 100 |
   | Visible During Game | Hologram Only |
5. Configure the following event on the Conditional Button so that when the player completes the sale, they are granted 5 Gold from the Item Granter.

   [![](https://dev.epicgames.com/community/api/documentation/image/32e55220-0e13-4b12-b243-2b3858745657?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/32e55220-0e13-4b12-b243-2b3858745657?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Activated Send Event To | Gold Item Granter | Grant Item |

   Use a [Billboard](https://dev.epicgames.com/documentation/en-us/fortnite/using-billboard-devices-in-fortnite-creative) device to label the shop and make it clear what the player will give and receive in the transaction.
6. Place a **Tracker** device.
7. Customize the Tracker:

   [![](https://dev.epicgames.com/community/api/documentation/image/e7bbd655-66b9-44fd-b473-eeae6b7017ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7bbd655-66b9-44fd-b473-eeae6b7017ef?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Stat to Track | Events |
   | Target Value | 5 |
   | Description Text | Build 5 Automated Wood Producers! |
   | Quest Icon | Wood |
8. Configure the following functions on the Tracker so that every time the player builds an Automated Wood Producer, the Tracker’s progress increments.

   [![](https://dev.epicgames.com/community/api/documentation/image/c9697f7b-a284-4906-b9e6-298070264b7b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c9697f7b-a284-4906-b9e6-298070264b7b?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | Increment Progress When Receiving From | Wood Producer Conditional Button (Buttons 1–5) | On Activated |

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > Player**.
2. Under **Inventory**, change **Maximum Building Resources** to **99,999**.

   [![](https://dev.epicgames.com/community/api/documentation/image/1f093cb9-09cf-4e45-9fc9-f203a77874b9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1f093cb9-09cf-4e45-9fc9-f203a77874b9?resizing_type=fit)
3. Go to **Island Settings > World**.
4. Under **Harvesting**, change **Harvest Multiplier** to **0.1X**.

   [![](https://dev.epicgames.com/community/api/documentation/image/61ba0d1a-de06-4f51-b67c-600ae90f7368?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/61ba0d1a-de06-4f51-b67c-600ae90f7368?resizing_type=fit)
5. Go to **Island Settings > User Interface**.
6. Under **HUD**, change **Show Gold Resource Count** to **Yes**.

   [![](https://dev.epicgames.com/community/api/documentation/image/36509a7c-a095-4dce-b040-cceea3fbe59d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36509a7c-a095-4dce-b040-cceea3fbe59d?resizing_type=fit)

You now have an automation game in which the player can set up resource factories!

### Design Tip

Think of ways that you can expand this game. Consider adding more types of resources and factories, or use Conditional Buttons with multiple Key Items to create a complex crafting system.

Players love games where they can make efficient production systems, so look to other games in the genre for inspiration!
