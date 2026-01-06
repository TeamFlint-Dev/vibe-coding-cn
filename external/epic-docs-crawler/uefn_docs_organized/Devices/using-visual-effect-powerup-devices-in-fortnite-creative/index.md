# Visual Effect Powerup Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-visual-effect-powerup-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:35:13.436759

---

Use **Visual Effect Powerups** to trigger a visual effect (a glow or an outline) when a player picks something up, or does something noteworthy.

Powerups can be triggered by player interaction, or by binding the effect to another device.

For example, you can set the Visual Effect Powerup to be triggered when a player picks up a Health Powerup, and [grant](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grant) the player [health](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#health) and a green glow (the effect).

To find the Visual Effect Powerup device, go to the **Creative inventory** and select the **Devices** tab. From there, you can search or browse for the device. For more information on finding devices see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This device has some basic functionality, like choosing the type of visual effect, the color, the duration, and the [respawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#respawn) time. Additionally, there are some advanced options, like [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) and team restrictions, and visibility restrictions.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Infinite Effect Duration** | **No**, *Yes* | If set to **Yes**, the effect will remain indefinitely. If **No**, you can set the duration of the effect in the next option. |
| **Effect Duration** | **3 seconds**, Infinite, Pick a duration | The amount of time the applied effect will stay active for. |
| **Disables Effect on Pickup** | Yes, **No** | If this is set to **Yes** then the effect of this powerup will be canceled when the powerup is collected. |
| **Pickup Radius** | **On Touch**, Pick a distance | The distance in meters the player needs to be from the powerup to collect it. |
| **Respawn** | **Yes**, *No* | If set to **Yes**, you can set the respawn time in the next option. If set to **No**, it will never respawn. |
| **Time to Respawn** | Never, Instant, **15 seconds**, Pick a time | The amount of time after pickup for this item to respawn. |
| **Spawn on Minigame Start** | **Yes**, No | When the minigame starts, is the powerup immediately spawned? If set to **No**, the powerup will spawn after its respawn time. |
| **Ambient Audio** | **On**, Off | Plays audio when players are nearby. |
| **Pickup Audio** | **On**, Off | Plays audio when picking up powerup. |
| **Selected Class** | **Any**, Pick a class | Specifies which Class can interact with this powerup. |
| **Selected Team** | **Any**, Pick a team | Specifies which Team can interact with this powerup. |
| **Apply To** | **Player**, Player’s Team, Player’s Class, Same Class in Player’s Team, All Players | The powerup effect will be applied to the selected receiver. |
| **Who Can See This Powerup** | None, All, **Only Players Who Can Pick Up** | Only the selected players will be able to see this powerup. |
| **Visual Effect** | **Glow**, Outline | Apply this VFX to the player that picks up this powerup. |
| **Color Type** | Team Relationship, Team Color, **White**, Pick a color | Which color is applied.  **Team Color** applies the color of the target’s team.  **Team Relationship** applies red if it’s hostile, green if it’s neutral and blue if it’s friendly. |
| **Custom Color** | **#00000000**, Select a color | Click the color number to open the Color Picker. Click a color to select. |
| **Is Effect Visible to Local Player** | **Visible to Local Player**, Not Visible to Local Player | If the effect is not visible on the local player, then the local player will see this effect on other players but not themselves. |
| **Team Relationship Visibility** | **Everyone**, Only Owning Player’s Team | Whether the effect is visible to everyone, or only the owning player’s team. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Spawn When Receiving From** | Immediately spawns the powerup when an event occurs. |
| **Despawn When Receiving From** | Immediately despawns the powerup when an event occurs. This powerup will not spawn again until activated by the **Spawn When Receiving From** function. |
| **Pickup When Receiving From** | Picks up the powerup when an event occurs, and applies the effect through other devices. |
| **Clear When Receiving From** | Clears any effects for this powerup when an event occurs |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Item Picked Up Send Event To** | Sends an event to a linked device when a player picks up the powerup. |
