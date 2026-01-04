# Ammo Items

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-ammo-items-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:10:57.922419

---

Offer **Ammo** [items](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) for players to restock weapons during gameplay. These ammo variations can supply bullets, shells, rockets, and arrows that projectile weapons consume.

When selecting ammo, you should also offer players a corresponding weapon. The required ammo for each weapon is indicated by an icon, which is shown in the [Using Ammo Items](https://dev.epicgames.com/documentation/en-us/fortnite/using-ammo-items-in-fortnite-creative) section below.

For your gameplay, you may want to either automatically grant ammo through the [**Item Granter**](using-item-granter-devices-in-fortnite-creative) or spawn them onto the map for players to find with the [**Item Spawner**](using-item-spawner-devices-in-fortnite-creative).

## Finding and Placing Items

[![Finding Ammo Consumables](https://dev.epicgames.com/community/api/documentation/image/2173da84-d1d2-4d10-a61a-dff97062b925?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2173da84-d1d2-4d10-a61a-dff97062b925?resizing_type=fit)

*Click image to enlarge.*

1. From [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode), press the **Tab** key and click **CREATIVE** on the top navigation bar to select the CREATIVE inventory screen if not already displayed.
2. Click the [CONSUMABLES](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tab.
3. On this screen, scroll to find and select the item, use the **Search** box to look up the item by name, or check the list of relevant **Categories** specific to the item you’re looking for to filter the view.
4. Click the item, then click either **EQUIP** or **ADD TO CHEST**.

Clicking **Equip** will add the item to your [Resources bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#resources-bar). (When you're back in Create mode, you can view items in your Resources bar by pressing the **Tab** key and selecting **Play**.)

[![Add Ammo To Chest](https://dev.epicgames.com/community/api/documentation/image/0a78cf80-5e90-4ffa-9320-ee00a0e5180f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0a78cf80-5e90-4ffa-9320-ee00a0e5180f?resizing_type=fit)

*Click image to enlarge.*

You may want to offer an item bundle to players through a [chest](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#chest) or [llama](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#llama). Selecting **Add To Chest** will add the item to the [Chest tab](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Each time you click it, the item count will increase by one, shown in a yellow box on the **Chest** tab.

From the **Chest** tab, you can select either **Create Chest** or **Create Llama** to store the items in a Chest or a Llama for use [in-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#in-game).

You can add up to fifteen items to the **Chest** tab. When it’s full, the **Add To Chest** tab will disappear. To add more items, you first have to remove items from the **Chest** tab.

## Managing Items

You can manage these items when you are in [Play inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#play-inventory). To access the **Play** inventory screen, press **Tab** and click **Play** in the top navigation bar. In the PLAY inventory, you can create or split item stacks, or remove them entirely from your Resources bar.

[![Resources Bar](https://dev.epicgames.com/community/api/documentation/image/e9026e6e-dfac-46d2-947d-23a5afb994ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9026e6e-dfac-46d2-947d-23a5afb994ae?resizing_type=fit)

*Click image to enlarge.*

Instead of dropping these items on the ground, it's best to grant them to players by using item-granting devices like the Item Spawner.

You cannot reposition or copy items with the phone tool. To delete an item from your inventory in Create mode, you will have to select either *Respawn* or *Back To Hub* from the *Menu*. When you do this, your inventory clears.

## Ammo Items

The **Max Qty** column in the table below shows the maximum ammo quantity you can equip for each type.

|  | Ammo type | Description | Max Qty | Ammo Icon |
| --- | --- | --- | --- | --- |
| [Arrow Consumable](https://dev.epicgames.com/community/api/documentation/image/470cc1e4-ddbf-477d-8caa-2200ab51b587?resizing_type=fit) | **Arrows** | Used with bows and crossbows, and are equipped in quantities of four. Weapons that use arrows have an icon of a single arrow on its inventory screen selection and in its description. | 999 | [Arrow Icon](https://dev.epicgames.com/community/api/documentation/image/c4e454db-a819-48bf-b8bf-966df4061a49?resizing_type=fit) |
| [Light Bullet Ammo](https://dev.epicgames.com/community/api/documentation/image/3e36cb5c-2d40-48e1-b096-60ae4c501ab0?resizing_type=fit) | **Light Bullets** | Used with pistols and submachine guns (SMG's), and are equipped in quantities of 100. Weapons that use light bullets have an icon of a curved set of five bullets on its inventory screen selection and in its description. | 999 | [Light Bullet Icon](https://dev.epicgames.com/community/api/documentation/image/07919c60-1567-4ec9-bf04-e30d1013db4f?resizing_type=fit) |
| [Medium Bullet Ammo](https://dev.epicgames.com/community/api/documentation/image/3d18a205-3a30-4256-ba53-b8f469f6ee6b?resizing_type=fit) | **Medium Bullets** | Used with revolvers, rifles, and light machine guns (LMG's), and are equipped in quantities of 100. Weapons that use medium bullets have an icon of three bullets on its inventory screen selection and in its description. | 999 | [Medium Bullet Icon](https://dev.epicgames.com/community/api/documentation/image/283facbb-a1a8-41d4-aacf-7bb3f7e52a05?resizing_type=fit) |
| [Heavy Bullet Ammo](https://dev.epicgames.com/community/api/documentation/image/cb4addd8-7511-4b81-8282-bc82f7171602?resizing_type=fit) | **Heavy Bullets** | Used with rail guns and rifles, and are equipped in quantities of 100. Weapons that use heavy bullets have an icon of a single bullet on its inventory screen selection and in its description. | 999 | [Heavy Bullet Icon](https://dev.epicgames.com/community/api/documentation/image/60aaffae-e9f1-421d-bd26-3bce1026b13d?resizing_type=fit) |
| [Shell Ammo](https://dev.epicgames.com/community/api/documentation/image/2f094fbf-cd6a-41ac-b9f2-9bbf9fbb7204?resizing_type=fit) | **Shells** | Used with shotguns, and are equipped in quantities of twenty. Weapons that use shells have an icon of two shotgun shells on its inventory screen selection and in its description. | 999 | [Shell Icon](https://dev.epicgames.com/community/api/documentation/image/f8893bb2-7fc0-432f-ae19-9f14a880dbf1?resizing_type=fit) |
| [Rocket Ammo](https://dev.epicgames.com/community/api/documentation/image/6797c754-adbc-4fd8-b7f9-df1d91642302?resizing_type=fit) | **Rockets** | Used with launcher weapons, and are equipped in a quantity of one. Weapons that use rockets have an icon of a single rocket on its inventory screen selection and in its description. | 60 | [Rocket Icon](https://dev.epicgames.com/community/api/documentation/image/816e5390-fc41-4443-ab90-a4edbe5a27f2?resizing_type=fit) |

## Registering Items

You can drop items directly onto devices that can either hold or grant items.

To [register](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#register) items for these kind of devices, follow these steps.

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
- **Item Granter**
- **Item Spawner**
- **Conditional Button**

Use these devices to set up your own system for granting and spawning items onto your island.
