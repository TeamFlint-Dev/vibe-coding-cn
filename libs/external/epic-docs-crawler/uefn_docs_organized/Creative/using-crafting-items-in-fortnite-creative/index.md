# Crafting Items

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-crafting-items-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:09:58.918613

---

Offer **crafting** items to players throughout gameplay as an island resource that can be collected and exchanged. Players cannot directly consume these items, but can collect them to simulate [crafting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#crafting) by exchanging them for other usable items.

Crafting items are:

- **Animal Bones**
- **Stink Sac**
- **Mechanical Parts**
- **Cube Monster Parts**

Though more items are considered crafting items, only these items will show on the top row of the **Resources** bar as shown in [Managing Consumables](https://dev.epicgames.com/documentation/en-us/fortnite/using-crafting-items-in-fortnite-creative).

These items could be required along with another to unlock requirements for [devices](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#device) like the [**Conditional Button**](using-conditional-button-devices-in-fortnite-creative).

[![Pairing Crafting Consumables](https://dev.epicgames.com/community/api/documentation/image/41e5104f-ac60-4555-ac84-209c31cd8128?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/41e5104f-ac60-4555-ac84-209c31cd8128?resizing_type=fit)

*Use the devices like Conditional Button and Item Granter to create the system of crafting.*

You could pair **Animal Bones** with **[Rough Ore](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-mineral-ore-crafting-items-in-fortnite-creative)** as requirements needed to craft weapons like the **Primal Pistol**.

To do so, you will need to set the Conditional Button's setting **Key Items Required** to **2** and pair the device with an [**Item Granter**](using-item-granter-devices-in-fortnite-creative) to grant the usable item.

You can also blend items with [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop) of similar [themes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) from the **Galleries** and **Prefabs** tab.

[![Blending Crafting Consumables](https://dev.epicgames.com/community/api/documentation/image/20ddfcb6-39bf-4e33-a2eb-47b2faac60a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/20ddfcb6-39bf-4e33-a2eb-47b2faac60a7?resizing_type=fit)

*Click image to enlarge.*

For example, you can blend Cube Monster Parts with props from the **Crashed Abductor Gallery** to fully immerse players onto your island.

To create the process of crafting, you will need to either [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) or [grant](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grant) items onto the map for players to collect with the **Item Spawner** or **Item Granter**.

Players can collect these items to exchange for usable items through devices like Conditional Button, which consumes equipped items. They can also use these items to craft other items that will build up to a larger item.

Visit our [video tutorials](https://mediaspace.unrealengine.com/playlist/dedicated/208434573/1_gxu6mwv5/1_qfnz9w5c) to learn more about working with items and for tips to enhance gameplay.

## Finding and Placing Items

[![Finding Crafting Consumables](https://dev.epicgames.com/community/api/documentation/image/61e562ec-a1bd-49fe-a110-94de992866fd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/61e562ec-a1bd-49fe-a110-94de992866fd?resizing_type=fit)

*Click image to enlarge.*

1. From **Build** mode, press the **Tab** key, then click **CREATIVE** on the top navigation bar to select the CREATIVE inventory screen if not already displayed.
2. Click the **CONSUMABLES** tab.
3. On this screen, scroll to find and select the item, use the **Search** box to look up the item by name, or check the list of relevant **Categories** specific to the item you’re looking for to filter the view.
4. Click the item, then click either **EQUIP** or **ADD TO CHEST**.

Clicking **Equip** will add the item to your [Resources bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#resources-bar). (When you're back in Create mode, you can view items in your Resources bar by pressing the **Tab** key and selecting **Play**.)

[![Crafting Items Chest Tab](https://dev.epicgames.com/community/api/documentation/image/0cfd1cf9-3e53-4516-b0a1-f2cf0fd60c0e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0cfd1cf9-3e53-4516-b0a1-f2cf0fd60c0e?resizing_type=fit)

*Click image to enlarge.*

You may want to offer an item bundle to players through a [chest](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#chest) or [llama](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#llama). Selecting **Add To Chest** will add the item to the [Chest tab](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Each time you click it, the item count will increase by one, shown in a yellow box on the **Chest** tab.

From the **Chest** tab, you can select either **Create Chest** or **Create Llama** to store the items in a Chest or a Llama for use [in-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#in-game).

You can add up to fifteen items to the **Chest** tab. When it’s full, the **Add To Chest** tab will disappear. To add more items, you first have to remove items from the **Chest** tab.

## Managing Items

You can manage these items when you are in [Play inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#play-inventory). To access the **Play** inventory screen, press **Tab** and click **Play** in the top navigation bar. In the PLAY inventory, you can create or split item stacks, or remove them entirely from your Resources bar.

[![Crafting Items Resources Bar](https://dev.epicgames.com/community/api/documentation/image/590cc33e-7ecb-41eb-87f7-2ef69ccf12ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/590cc33e-7ecb-41eb-87f7-2ef69ccf12ae?resizing_type=fit)

*Click image to enlarge.*

Instead of dropping these items on the ground, it's best to grant them to players by using item-granting devices like the Item Spawner.

You cannot reposition or copy items with the phone tool. To delete an item from your inventory in Create mode, you will have to select either *Respawn* or *Back To Hub* from the *Menu*. When you do this, your inventory clears.

## Crafting Items

|  | Item | Usage |
| --- | --- | --- |
| [Animal Bones](https://dev.epicgames.com/community/api/documentation/image/19956d80-8378-472b-8327-def6f99439c2?resizing_type=fit) | **Animal Bones** | Can be gathered from bone-themed props or wildlife to craft items like the **Pimal Pistol**. |
| [Mechanical Parts](https://dev.epicgames.com/community/api/documentation/image/bb2c7b95-0c66-4bbd-8705-6289fdbfd9b6?resizing_type=fit) | **Mechanical Parts** | Can be gathered from mechanical-themed props or vehicles to craft items like the **Clinger**. |
| [Stink Sac](https://dev.epicgames.com/community/api/documentation/image/604e7f18-6df3-4fa4-846c-28ee4cd97d7f?resizing_type=fit) | **Stink Sac** | Can be gathered from wildlife or trash-themed props to craft items like the **Stink Bomb**. |
| [Cube Monster Parts](https://dev.epicgames.com/community/api/documentation/image/4fac2128-1805-4114-b38b-48f1eb8e1732?resizing_type=fit) | **Cube Monster Parts** | Can be gathered fas alien-themed items from **Galleries** like the **Kevin Cube** or **Zero Point** to craft items like the **Sideways Rifle**. |

## Registering Items

[![Pairing Consumables](https://dev.epicgames.com/community/api/documentation/image/896c3b8f-3c8f-462b-b1e8-25c44a43acd2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/896c3b8f-3c8f-462b-b1e8-25c44a43acd2?resizing_type=fit)

*Click image to enlarge.*

You can drop items directly onto devices that can either hold or grant items. Above shows the Conditional Button, which holds two crafting items and an Item Granter that holds one usable item.

This pair of devices can be set up for players to exchange Animal Bones and Rough Ore for a Primal Pistol. To do so, these items must first be [registered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#register) to the devices that will hold the information.

[![Registering Consumables](https://dev.epicgames.com/community/api/documentation/image/aee0a2a7-65e5-45ab-afe2-2ba4fe06a915?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aee0a2a7-65e5-45ab-afe2-2ba4fe06a915?resizing_type=fit)

*Click image to enlarge.*

To register an item for this kind of device, follow the steps below. (You can also watch a [video tutorial](https://mediaspace.unrealengine.com/media/RegisteringCraftingConsumablesinFortniteCreative/1_zpmj3v0g) that shows you how to register items, for [crafting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#crafting) or other [in-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#in-game) use.)

To register an item for this kind of device, follow these steps.

1. In the CREATIVE inventory, find the equipment and items you want to register with a device and equip them.
2. In Create mode, stand directly beside the device that will register the item.
3. Press the **Tab** key to open the **PLAY** inventory screen.
4. Click the item, then press either **Z** or **X** to split or drop the item. You can also drag the item to the side until a [backpack icon](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#backpack-icon) appears.

The compatible device will automatically register the dropped item.

Compatible devices that can hold items are:

- **Vending Machine**
- **Team Settings & Inventory**
- **Class Designer**
- **Capture Item Spawner**
- **Capture Area**
- **Item Granter**
- **Item Spawner**
- **Conditional Button**
- **Elimination Manager**
- **Item Remover**

Use these devices to set up your own system for granting and spawning items onto your island.
