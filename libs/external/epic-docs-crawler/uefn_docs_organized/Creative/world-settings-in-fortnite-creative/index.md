# World Settings

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/world-settings-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:22:37.564290

---

Your island is a **world** where you can set the rules for friendly AI behavior, vehicles, harvesting, and lighting (ambiance). The settings on this category control how players interact with your world.

There are several World subcategories, and most of them have multiple settings. From the Island Settings tab, click **World**, then click any **subcategory** to expand it.

[![Find the World category under Island Settings.](https://dev.epicgames.com/community/api/documentation/image/91247eb5-6e1e-4f47-aa08-4424e27955d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/91247eb5-6e1e-4f47-aa08-4424e27955d5?resizing_type=fit)

If you know the name of a setting you want to change, use the **search bar** to find it.

Any changes you make to these settings are automatically saved. You can restore the settings to their original values at any time by clicking the **Restore Defaults** button. This will reset only the settings for your current category.

The following sections describe the settings available in each subcategory, and how you can use them.

Some settings are grayed out. This usually indicates that another setting must be changed to make that setting available.

Default values are **bold**. Values that make other settings active or inactive are *italic*.

## Friendly AI Settings

An **AI** (short for artificial intelligence), is a programmed [non-player character](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#npc). An AI can be an opponent, but in some cases, can also be an ally. When an AI is on your side, it's a **friendly AI**.

| Option | Values | Description |
| --- | --- | --- |
| **Maximum Tamed Wildlife** | **3**, 1, 2 | Sets a limit to how many tamed animals you can have active at one time. This setting can be overridden by the [Wildlife Spawner device](using-wildlife-spawner-devices-in-fortnite-creative). |
| **Maximum Hired Guards** | **3**, 1, 2 | Limits how many guards a player can hire in a single game. This setting can be overridden by the [Guard Spawner device](using-guard-spawner-devices-in-fortnite-creative). |

## Vehicles Settings

Use these settings to determine what damage, if any, vehicles suffer in collisions.

| Option | Values | Description |
| --- | --- | --- |
| **Vehicle Impacts Damage Objects** | **Yes**, No | Determines whether vehicles will damage any objects they collide with. |
| **Vehicle Impacts Damage Vehicles** | **Yes**, No | Determines whether vehicles that collide with other vehicles will take damage. If set to **Yes**, all vehicles in a collision will take damage. The amount of damage is determined by the health of the individual vehicle. |
| **Enable Vehicle Cosmetics** | **On**, Off | Determines whether players can use vehicle cosmetics to customize their vehicle when entering the island. |

## Harvesting Settings

Harvesting is a way to collect resources such as wood or stone, for building or crafting.

| Option | Values | Description |
| --- | --- | --- |
| **Harvest Style** | **Creative**, Battle Royale, Save the World | Determines which values are used in the game for resource gathering. Options are:   - **Creative**: Creative gives a value of 45 when player uses their pickaxe to harvest resources for building. - **Battle Royale**: In BR, the player gets a value of 5 when harvesting with their pickaxe for building. - **Save the World**: Uses the default value used in Save the World. |
| **Harvest Multiplier** | **3 Seconds**, Don't Show, Pick a time | Determines the rate at which players can harvest resources from world objects. |

## Ambience Settings

Ambience is the mood an island has. Ambience contains a number of influencing elements, most of which have to do with light and color. Use these settings to adjust your island's mood to support the overall vibe you're going for.

| Option | Values | Description |
| --- | --- | --- |
| **Time of Day** | **Default**, Random, Pick a time | Sets the time of day on the island, which affects both light and shadows. Options include:   - **Default**: Uses the Chapter 5 lighting settings as well as Lumen and Nanite for the normal time for the continual day/night cycle. - **Random**: Selects a random time of day at the start of the game, then takes the island through a day/night cycle from that point. - **Pick a time**: Set a specific time. The island will stay at that time until you change it. |
| **Camera Filter** | **Default**, Pick a filter | The filter you select will impact the island mood. Options are:   - **Default**: No filter.  [No filter.](https://dev.epicgames.com/community/api/documentation/image/758e139e-68fb-450a-83a1-6054a2bd3a18?resizing_type=fit) - **Half-Tone**: A bright effect that uses a texture similar to comic books. - **Desolate**: Deepens shadows regardless of the set Time of Day, which creates a feeling of foreboding.  [Desolate filter.](https://dev.epicgames.com/community/api/documentation/image/ca62a8d8-80fe-4d5d-8e30-e1d60b19b5cc?resizing_type=fit) - **Old Cartoon**: Applies outlines, is in black and white, and adds an effect that simulates old film moving through a projector.  [Old cartoon filter.](https://dev.epicgames.com/community/api/documentation/image/21c3f094-b7fb-4e62-89a7-d5ce63b0250c?resizing_type=fit) - **Horror Movie**: Washes out color, but less so than the Low Exposure filter.  [Horror filter.](https://dev.epicgames.com/community/api/documentation/image/74012809-bb77-4e1d-8e34-546073500e4e?resizing_type=fit) - **Neon Party**: Applies a neon glow to things, but more subtly than the glow of the Retro filter.  [Neon filter.](https://dev.epicgames.com/community/api/documentation/image/9ea5e51e-b8d5-4ec2-913f-86b53f7b995e?resizing_type=fit) - **Low Exposure**: Washes out much of the color.  [Low exposure filter.](https://dev.epicgames.com/community/api/documentation/image/a5bf4094-5cc8-45c1-b27a-dff041644082?resizing_type=fit) - **Retro**: Outlines images with a glowing line.  [Retro filter.](https://dev.epicgames.com/community/api/documentation/image/7f931e90-0107-4ba4-96c0-6dbf90d75f4b?resizing_type=fit) - **Sepia**: Gives the whole scene an old-fashioned, light brown hue.  [Sepia filter.](https://dev.epicgames.com/community/api/documentation/image/1f47253f-0fdc-47f8-873f-b08f2e7beb11?resizing_type=fit) - **Film Noir**: Gives everything a washed-out black-and-white effect.  [Film noir filter.](https://dev.epicgames.com/community/api/documentation/image/43fc2f3f-bdb5-41e1-8cb1-5168ecd08ba5?resizing_type=fit) - **Oak**: Washes out the color and shadows and applies subtle outlines. |
| **Light Brightness** | **Default**, Pick a value | Sets the intensity of natural lighting. This impacts both interior and exterior light levels. **Default** value is **100/%**. |
| **Light Color** | **Default**, Pick a color | Sets the color of the natural lighting. Each color can convey a specific mood or emotion. For example, red creates tension, while yellow creates warmth. |
| **Character Rimlight Intensity** | **0**, Pick an intensity | A rim light is a backlight behind a character that makes the character stand out from the background. This setting determines how strong the rim light is. |
| **Fog Thickness** | **Default**, Pick a value | Fog is an element that can add an eerie quality to your island. If this is set to **Default** the result is no fog. The higher the percentage you pick, the thicker the fog. Setting this to 100% setting makes a dense fog that limits visibility dramatically. |
| **Fog Color** | **Default**, Pick a color | As with the **Light Color** setting, applying a color to the fog can change the mood of the island. |

## Physics Settings

| Option | Values | Description |
| --- | --- | --- |
| **Gravity Value** | **Don't Override** | Set a custom gravity value for this island, in centimeters per second squared. For example, normal Earth gravity would be -980.0.  **This value can only be modified from UEFN, and only if Physics has been enabled on the island.** |
