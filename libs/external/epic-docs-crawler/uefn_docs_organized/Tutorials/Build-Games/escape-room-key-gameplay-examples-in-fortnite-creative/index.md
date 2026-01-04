# Escape Room Key Mechanics

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-key-gameplay-examples-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:26:42.610898

---

The player’s goal in an escape room is to find clues that lead them to the objects they need to escape from one or more rooms.

[![An example of an escape room.](https://dev.epicgames.com/community/api/documentation/image/a2ee9e9c-3964-4749-b2f2-df82635657cd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2ee9e9c-3964-4749-b2f2-df82635657cd?resizing_type=fit)

After creating this example, you will know how to use the [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative), the [Hud Message device](using-hud-message-devices-in-fortnite-creative), the [Perception Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/using-perception-trigger-devices-in-fortnite-creative), the [Item Placer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-placer-devices-in-fortnite-creative), and the [Lock device](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative), and how to use items with Item Spawners.

## Ingredients

[![Lay out the devices in a way that forces players to search for clues, and where they can accidentally set off a trigger that will send them a clue.](https://dev.epicgames.com/community/api/documentation/image/34528bae-7150-43fd-ad24-b1f8c191a7e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/34528bae-7150-43fd-ad24-b1f8c191a7e0?resizing_type=fit)

You will need:

| Number | Device |
| --- | --- |
| 1 | **2X Trigger device** |
| 2 | **1X Player Spawn Pad device** |
| 3 | **1X Conditional Button device** |
| 4 | **1X Lock device** |
| 5 | **1X End Game device** |
| 6 | **1X HUD Message device** |
| 7 | **1X Prop Manipulator device** |
| 8 | **1X Item Spawner device** |
| 9 | **1X Key item** |

### Items

For this gameplay mechanic to work, you will need to spawn a **key** [item](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#item) using the [Item Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative) device. The key is consumed by the **Conditional Button** when the player finds and equips it.

To add an item to the Item Spawner device:

1. Drag a **item** item from the list until you see the **backpack icon**.
2. Select the **Item Spawner** device.
3. Select **Tab** > **Play**.
4. Drag the item from the slot into the Item Spawner to to equip it with the item.

## Method

Place the first Trigger device somewhere that players are guaranteed to step on. This provides a way for the HUD Message device to send players their first clue.

The first Trigger device also triggers the Prop Manipulator device, which makes the prop hiding the escape item to disappear, and the Item Spawner to spawn the item.

Place the Trigger device in front of a desk or beside a bed. Don’t place it directly in front of the player. Players should have a chance to explore the room before they get their first clue.

After a player receives a clue, they begin hunting for the items that will help them escape the room. When players find an item, they will equip the item then head for the escape door.

When the player takes the item to the Conditional Button device, the Lock device opens the escape door.

Place the second Trigger device outside of the escape door. When a player unlocks the door and steps on the Trigger device, the End Game device will be triggered to end the game.

## Modified Options

### Trigger Device #1 Options

| Modified Options |  |
| --- | --- |
| Trigger Sounds | Disabled |
| Trigger VFX | Disabled |
| Visible In Game | No |
| Times Can Trigger | 3 |

### Trigger Device #2 Options

| Modified Options |  |
| --- | --- |
| Trigger Sounds | Disabled |
| Trigger VFX | Disabled |
| Visible In Game | No |
| Times Can Trigger | 1 |

### HUD Message Device Options

| Modified Options |  |
| --- | --- |
| Message | Add a clue |

Using riddles for clues to key items is not only fun for players, it’s also fun for you. To create riddles, use the following prompts to think about the key items in a unique way:

- Brainstorm words associated with the key item.
- Use a thesaurus to find synonyms for the word.
- Think about what life is like from the object’s point of view.
- Use figurative language to describe what the item does, sounds like, or is.

### Item Spawner Device Options

Place this device over the door inside the room where the hidden key is.

| Modified Options |  |
| --- | --- |
| Items Respawn | Off |
| Base Visible In Game | Off |
| Time Before Fisrt Spawn | Never |
| Time Before Spawns | Never |
| Run Over Pickup | On |

### Conditional Button Device Options

Place this device above the door where the player will make their ultimate escape from the room.

| Modified Options |  |
| --- | --- |
| Missing Items Text | Need Key! |
| Disable After Use | Yes |

## Modified Event Options

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding)

allows devices to communicate directly, making your workflow more intuitive, and giving you more freedom to focus on your design ideas. The direct event binding system eliminates limitations because the devices communicate directly.

### Trigger Device #1 Event Options

| Modified Event | Device | Value |
| --- | --- | --- |
| **On Triggered Send Event To** | **HUD Message Device** | Show |
| **On Triggered Send Event To** | **Prop Manipulator** | Hide Props |
| **On Triggered Send Event To** | **Item Spaner** | Spawn Item |

### Trigger Device #2 Event Options

| Modified Event | Device | Value |
| --- | --- | --- |
| **On Device Sees A Player Send Event To** | **End Game device** | Activate |

### Conditional Button Device Event Options

| Modified Event | Device | Value |
| --- | --- | --- |
| **On Activated Send Event To** | **Lock device** | Open |

## Tips and Tricks

Make players find multiple items before unlocking the door with the [Conditional Button](using-conditional-button-devices-in-fortnite-creative). A Conditional Button can require the player to gather multiple resources and items before unlocking the Lock device.

Use a Trigger device and the Item Spawner device to spawn an item when the player reaches a specific spot inside the escape room.

Use the HUD Message device to send the player a message to double-back and search for additional items, or provide clues about where a player should be searching.

Add a sound when the clue spawns.

## Putting It All Together

You can use this mechanic multiple times in an escape room, or even add onto this mechanic to create a maze.
