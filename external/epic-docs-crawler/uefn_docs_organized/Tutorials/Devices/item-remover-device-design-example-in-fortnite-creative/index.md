# Item Remover Device Design Example

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/item-remover-device-design-example-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:06:38.468005

---

The **Item Remover** is a powerful device that gives you control over which items are in a player's inventory.

In this design example, you'll set up an **Item Remover** to work with a **Down But Not Out** device. This simple game mechanic will force players to drop whatever weapons and items they are carrying if their health drops to zero.

## Devices Used

- 1 x [**Down But Not Out**](using-down-but-not-out-devices-in-fortnite-creative) device
- 1 x [**Item Remover**](using-item-remover-devices-in-fortnite-creative) device

## Build Your Own

1. Place a **Down But Not Out** device anywhere on your island.
2. The default settings are fine for multiple players, but won't work with only one player. To use this device for a single player game, change the **DBNO Enabled** setting to **Yes**.

   [![settings for Down But Not Out](https://dev.epicgames.com/community/api/documentation/image/33bd176b-7303-40ed-af19-2e525e764fc7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/33bd176b-7303-40ed-af19-2e525e764fc7?resizing_type=fit)
3. Place an **Item Remover** device anywhere on your island.
4. Modify the Item Remover:

   [![Settings for Item Remover](https://dev.epicgames.com/community/api/documentation/image/2cb2f85b-a7b1-47f1-b374-5b3a54f82c70?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2cb2f85b-a7b1-47f1-b374-5b3a54f82c70?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Affected Items** | Weapons and Items | Sets what can be removed from a player's inventory. |
   | **Amount to Remove** | Percentage | The default amount when you select percentage is 100 percent, so this effectively removes all items. |
   | **Removal Method** | Drop Items | This leaves any items removed near where the player has fallen. |

And there you go — a simple way to add fun variety into your multiplayer islands!

## Design Tip

Try adjusting the settings for the Item Remover to have items vanish or to only remove guns.
