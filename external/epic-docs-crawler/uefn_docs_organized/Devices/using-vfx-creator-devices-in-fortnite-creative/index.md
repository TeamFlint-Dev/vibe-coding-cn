# VFX Creator Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-creator-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:37:49.500025

---

Use the **VFX Creator** to create and customize your own [visual effects](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#vfx),
using a library of [sprites](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#sprite), and with lots of ways to modify them.

This device is more flexible than the [VFX Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative), which gives you a selection of pre-made visual effects to choose from but limits how much you can customize or change those effects.

The VFX Creator creates a [sprite particle effect](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#sprite-particle-effect). You have a large variety of [sprites](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#sprite) to choose from, and a lot of ways to customize how the particle effect works and what it looks like. Using this device, you can create unique effects for your game.

Ways you can use this device include:

- Highlight an in-game event, such as the beginning or end of a race, or the completion of an objective.
- Make eliminating a boss even more spectacular and satisfying.
- Create a particular atmosphere on your island, or emphasize a fantastical aspect of your game.
- Create environmental effects like rain or leaves.
- Create interesting trail effects by attaching the VFX to a player.

**Looking for a spark of creative freedom?** See [**Down But Not Out Device Design Example**](down-but-not-out-device-design-example-in-fortnite-creative) to liberate your imagination!

To find the VFX Creator device, go to the **Creative inventory** and select the **Devices** tab. From there, you can search or browse for the device. For more information on finding devices see [Finding and Placing Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the [Customize panel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#customize-panel) and make options easier to manage and navigate. However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, any values in our device docs that trigger contextual filtering are in *italic*.

All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like choosing the sprite for the effect, and choosing the color and brightness of the effect. Additionally, there are some advanced options, like choosing a secondary color and determining whether the effect loops.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Start Effects When Enabled** | **Yes**, No | Determines whether the device executes the effects when it is enabled. |
| **Enabled During Phase** | None, **All**, Create Only, Game Countdown, Gameplay Only | Determines the phases during which the device is enabled. |
| **Sprite Shape** | **Soft Circle**, Pick a sprite | Determines which sprite is used for the particle effect. Click the sprite to open the sprite picker. Click to select a sprite.  [Pick a sprite in the Sprite Picker](https://dev.epicgames.com/community/api/documentation/image/874a373a-38c2-475b-b391-a6c8adc02786?resizing_type=fit) |
| **Sprite Size** | **1X**, Pick a multiplier | Determines the sprite particle size when the effect starts. This is expressed as a multiple of the sprite's default size, which can vary from sprite to sprite. |
| **Sprite Duration** | **1S**, Pick an amount of seconds | Determines the lifetime of each sprite particle in the effect. |
| **Sprite Rotation Alignment** | **Random**, Speed, Planar | Determines how the sprite particles are displayed. **Random** rotates each particle in a random direction. **Speed** rotates each in the direction the particle is moving. With **Planar** each sprite particle faces the device. |
| **Use Random Color** | ***No***, Yes | Determines the color of the effect. **Yes** uses a random color each time the effect loops. If you select **No**, the **Main Color** option displays and you can select a color. |
| **Main Color** | **White**, Pick a color | Only displays if **No** is set for **Use Random Color**. This sets the color of the effect. Click the swatch to open the **Color Picker**, then click the picker to select a color.  [Pick a swatch in the Color Picker](https://dev.epicgames.com/community/api/documentation/image/53c2d9e5-ef5a-4a3d-9b89-1fb224b55c97?resizing_type=fit) |
| **Main Color Brightness** | **1**, Pick a level | Determines the brightness of the effect color. |
| **Use Secondary Color** | **No**, *Yes* | Determines whether a second color will be used along with the main color, to create a color transition in the effect. If you choose **Yes**, the **Random Secondary Color** and **Secondary Color Brightness** options display. |
| **Random Secondary Color** | ***No***, Yes | This option only displays if you choose **Yes** for the **Use Secondary Color** option. Determines how the secondary color of the effect is chosen. If you choose **Yes**, the device uses a random secondary color for the effect. If you choose **No**, the **Secondary Color** option displays so you can select a color for the effect. |
| **Secondary Color** | **White**, Pick a color | This option only displays if you choose **No** for the **Random Secondary Color** option. This option sets the secondary color of the effect. Click the swatch to open the color picker. Click to select a color, then click the checkmark to close the color picker. |
| **Secondary Color Brightness** | **1**, Pick a level | Determines the brightness level of the effect's color. |
| **Sprite Speed** | **50%**, Pick a percentage | Determines the speed of the sprite particles when the effect loop starts. |
| **Effect Gravity** | **50%**, Pick a percentage | Determines how fast sprite particles fall, expressed as a percentage of normal gravity. |
| **Randomness** | **50%**, Pick a percentage | Determines how random the movement and size of the sprites will be. The percentage values are an abstract expression of the amount of randomness used. |
| **Keep Size** | **Yes**, *No* | Determines whether spawns keep the same size after spawning, or change size over time. If you select **No**, the option **Size Over Time** will display. |
| **Size Over Time** | **75%**, Pick a percentage | Sets how much the sprites will change in size over time. Less than 100 percent will make them smaller; more than 100 will make them larger. |
| **Spawn Mode** | **Continuous**, Bursts | Determines whether the sprite particles will generate continually, or whether they will generate in bursts. |
| **Effect Generation Amount** | **50%**, Pick a percentage | Determines how many sprite particles are generated. |
| **Loop** | **Forever**, Never, Custom | Determines whether the effect loops.  **Forever:** Once the effect spawns, it will continue to spawn in a loop until something stops it.  **Never:** It will play once, then stop.  **Custom:** Select how many times you want it to loop under **Loop Times**. |
| **Loop Times** | **1**, Pick a number | Set how many times an effect should loop. This option only appears if you select **Custom** for **Loop**. |
| **Loop Duration** | **1S**, Pick a time in seconds | Determines how long it takes for the effect to play through once. If the effect loops, this is how long the loop lasts. |
| **Time Between Loops** | **1S**, Instant (0), Pick a time in seconds | If the effect is set to loop, this determines whether the effect begins again immediately, or if the device waits the selected amount of time before starting the effect again. |
| **Spawn Zone Shape** | **Sphere**, Box, Point | Determines the shape of the space where the sprite particles initially spawn. |
| **Spawn Zone Size** | **0.5**, Pick a size | Sets the size of the spawn shape in [tiles](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#tile). |
| **Stick to Player** | **No**, *Yes* | Determines whether the sprite effect spawns and sticks to a player. If you choose **Yes**, the **Spawn On Player Body Part** options display. |
| **Spawn On Player Body Part** | **Center**, Head, Base, Weapon | Sets where on the player the effects will spawn. |

### Sprites Available

Below is a table showing all the sprites you can use when creating an effect.

| Sprites |  |  |  |  |
| --- | --- | --- | --- | --- |
| [Soft Circle](https://dev.epicgames.com/community/api/documentation/image/804deabe-c9d6-4649-8347-2bd12a663b12?resizing_type=fit) | [Square](https://dev.epicgames.com/community/api/documentation/image/9f2f9813-f46f-4144-8bb2-7f71df2d2730?resizing_type=fit) | [Triangle](https://dev.epicgames.com/community/api/documentation/image/b3d13bd2-e441-4659-adf9-ffcf81d6ecad?resizing_type=fit) | [Spark](https://dev.epicgames.com/community/api/documentation/image/d705999f-fab2-43bd-b70b-c71f72ae08f1?resizing_type=fit) | [Lens Flare 01](https://dev.epicgames.com/community/api/documentation/image/0b9c5536-fdf0-4a0c-990f-50998057df2d?resizing_type=fit) |
| Soft Circle | Square | Triangle | Spark | Lens Flare 01 |
| [Lens Flare 02](https://dev.epicgames.com/community/api/documentation/image/1b1d24a0-cc91-4d49-ae04-6f5cdb74f30c?resizing_type=fit) | [Star](https://dev.epicgames.com/community/api/documentation/image/14a6ff5f-3903-4544-8ca1-7a77e1fc0c3d?resizing_type=fit) | [Disc 01](https://dev.epicgames.com/community/api/documentation/image/cd7d5cd5-6178-4db8-abb6-daf5d4fe1e4b?resizing_type=fit) | [Disc 02](https://dev.epicgames.com/community/api/documentation/image/0954c264-5fc5-464f-afd4-acaa019e1b1e?resizing_type=fit) | [Fire Disc](https://dev.epicgames.com/community/api/documentation/image/9343d36e-d46f-4603-89cc-3727bb9d161a?resizing_type=fit) |
| Lens Flare 02 | Star | Disc 01 | Disc 02 | Fire Disc |
| [Shockwave Disc](https://dev.epicgames.com/community/api/documentation/image/1690757f-e625-486b-9d1e-905e0180f41b?resizing_type=fit) | [Dots](https://dev.epicgames.com/community/api/documentation/image/6e9ce8f4-cc84-48c3-8d48-4a02befa255d?resizing_type=fit) | [Musical Notes](https://dev.epicgames.com/community/api/documentation/image/54ad1794-4c4f-4748-a0ab-e290773f8efb?resizing_type=fit) | [Electric](https://dev.epicgames.com/community/api/documentation/image/d947c877-a088-43e8-ae73-27fbcb6f9654?resizing_type=fit) | [Leaf](https://dev.epicgames.com/community/api/documentation/image/f3d94bb0-8c5c-48d4-879a-47343842077b?resizing_type=fit) |
| Shockwave Disc | Dots | Musical Notes | Electric | Leaf |
| [Flower](https://dev.epicgames.com/community/api/documentation/image/b969492c-ffe1-41bc-a173-0ea65ecf0fbc?resizing_type=fit) | [Snowflake](https://dev.epicgames.com/community/api/documentation/image/30232fde-9650-4d15-bf25-4b43f394e066?resizing_type=fit) | [Droplet](https://dev.epicgames.com/community/api/documentation/image/f6121a92-c5dd-44f4-89bd-732d4ae799a4?resizing_type=fit) | [Arrow 01](https://dev.epicgames.com/community/api/documentation/image/a3dfded2-159d-444e-9fd2-94a1b4f931cc?resizing_type=fit) | [Arrow 02](https://dev.epicgames.com/community/api/documentation/image/65b1bdce-0fe2-420c-a064-ca0283f33b09?resizing_type=fit) |
| Flower | Snowflake | Droplet | Arrow 01 | Arrow 02 |
| [Arrow 03](https://dev.epicgames.com/community/api/documentation/image/8fbcada4-769e-42a3-9271-80392ff1255e?resizing_type=fit) | [Smoke 01](https://dev.epicgames.com/community/api/documentation/image/571eff6e-34cb-4e49-bba1-4a1858c7b918?resizing_type=fit) | [Smoke 02](https://dev.epicgames.com/community/api/documentation/image/8930f563-fa98-4072-bb49-9a8cd49db309?resizing_type=fit) | [Smoke 03](https://dev.epicgames.com/community/api/documentation/image/7400a3cc-5e43-44c2-bd94-87e8a49dc265?resizing_type=fit) | [Plus Sign](https://dev.epicgames.com/community/api/documentation/image/3cf1453d-f1ae-428d-8164-70a78be46249?resizing_type=fit) |
| Arrow 03 | Smoke 01 | Smoke 02 | Smoke 03 | Plus Sign |
| [Heart](https://dev.epicgames.com/community/api/documentation/image/3466d5e4-fa0a-4974-83c4-d48d5567a0b6?resizing_type=fit) | [Splatter](https://dev.epicgames.com/community/api/documentation/image/8fc7c99a-9123-49a5-ab31-1e2600626114?resizing_type=fit) | [Bubble](https://dev.epicgames.com/community/api/documentation/image/03666a0a-175a-4dca-892d-32ec1e26c398?resizing_type=fit) | [Ash](https://dev.epicgames.com/community/api/documentation/image/153d1698-43ad-4148-8bf7-84c37515a7cf?resizing_type=fit) |  |
| Heart | Splatter | Bubble | Ash |  |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Start Effect at Device When Receiving From** | Starts the effect generation when receiving a signal from the selected event. |
| **Stop Effect at Device When Receiving From** | Stops the effect generation when receiving a signal from the selected event. |
| **Toggle Effect at Device When Receiving From** | Starts or stops the effect generation when receiving a signal from the selected event. |
| **Enable When Receiving From** | Enables the device when receiving a signal from the selected event. |
| **Disable When Receiving From** | Enables the device when receiving a signal from the selected event. |
| **Toggle Effect Pause at Device When Receiving From** | Pauses or resumes the effect keeping it frozen in place when receiving a signal from the selected event. |
| **Spawn at Player When Receiving From** | Spawns a start the effects at the instigating player's position when receiving a signal from the selected event. |
| **Remove Effect from Player When Receiving From** | Removes the effect from the moving player to the device position without stopping the effects when receiving a signal from the selected event. |
| **Remove Effect from All Players When Receiving From** | Removes the effect from the moving instigating player to the device position without stopping the effects when receiving a signal from the selected event. |
| **Start Effect at Player When Receiving From** | Starts the effect generation when receiving a signal from the selected event. |
| **Start Effect for All Players When Receiving From** | Starts the effect generation when receiving a signal from the selected event. |
| **Stop Effect at Player When Receiving From** | Stops the effect generation when receiving a signal from the selected event. |
| **Stop Effect for All Players When Receiving From** | Stops the effect generation when receiving a signal from the selected event. |
| **Toggle Effect Pause at Player When Receiving From** | Pauses or resumes the effect keeping it frozen in place when receiving a signal from the selected event. |
| **Toggle Effect Pause for All Players When Receiving From** | Pauses or resumes the effect keeping it frozen in place when receiving a signal from the selected event. |
| **Toggle Effect at Player When Receiving From** | Starts or stops the effect generation when receiving a signal from the selected event. |
| **Toggle Effect for All Players When Receiving From** | Starts or stops the effect generation when receiving a signal from the selected event. |
| **Toggle Enabled When Receiving From** | Enables or disables the device when receiving a signal from the selected event. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

There are no events for this device.
