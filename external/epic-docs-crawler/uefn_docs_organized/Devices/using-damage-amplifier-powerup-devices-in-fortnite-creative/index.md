# Damage Amplifier Powerup Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-amplifier-powerup-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:42:49.950059

---

When a player picks up or [triggers](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the **Damage Amplifier Powerup** device, their ability to [deal damage](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to another player or [NPC (non-player character)](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) is instantly amplified. This applies to any weapon the player is using at the time of the powerup.

The effect is temporary but you can customize the powerup duration.

You can also control which players, teams or [classes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) can use this [powerup](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), how much the powerup is amplified (multiplied), how long it lasts, and a number of other customizable features. You can use it to give one team an advantage — especially when playing against NPCs — or to level the playing field. It’s also a useful [pickup](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) for players [in-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

  To find the Damage Powerup device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

It’s helpful to [customize device names](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) when you use multiple copies of the same device.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

In its [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) state, this device delivers a 2x amplification of damage dealt with the powerup, and can be used by any player or class. You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Damage Multiplier** | **2.0X**, Pick a multiplier | Multiplies the damage dealt for any weapon used by the triggering player by this multiplier. |
| **Infinite Effect Duration** | **No**, *Yes* | If you select **Yes**, this sets the amount of time the applied effect will stay active as infinite, and the **Effect Duration** option disappears. If left to **No**, the **Effect Duration** option is available. |
| **Effect Duration** | **3 Seconds**, Pick a time | How long the effect will stay active. This option is only available if **Infinite Effect Duration** is set to **No**. |
| **Time to Respawn** | Never, Instant, **15 Seconds**, Pick a time | Once triggered, this determines how long before the device goes active again. |
| **Ambient Audio** | **On**, Off | If set to **On**, the device plays an ambient audio when players are nearby. |
| **Show FX On Player** | **Yes**, No | If this option is set to **No**, there will be no FX played on player while the powerup is active. |
| **Disables Effect On Pickup** | Yes, **No** | If set to **Yes**, the power-up effect will end when a player collects it. If set to **No**, it will continue. |
| **Pickup Radius** | **On Touch**, Pick a distance | Sets how close the player needs to be to the device to collect it. Distance is measured in meters. |
| **Respawn** | **No**, *Yes* | Determines whether the item will respawn after it is picked up. If you set to **Yes**, another option, **Time to Respawn**, will appear. |
| **Time to Respawn** | **15 Seconds**, Pick a time | If **Respawn** is set to **Yes**, you can set how long before the item spawns again. |
| **Spawn On Minigame Start** | **Yes**, No | The device will [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) at start of minigame unless set to **No**, in which case it will spawn after its respawn time. |
| **Ambient Audio** | **On**, Off | When set to **On**, an ambient audio will play when players are near the item. |
| **Pick-up Audio** | **On**, Off | When set to **On**, audio will play when a player picks up the item. |
| **Selected Class** | **Any**, Pick a class | Determines which class can interact with this powerup. |
| **Selected Team** | **Any**, Pick a team | Determines which team can interact with this powerup. |
| **Apply To** | **Player**, Player’s Team, Player’s Class, Same Class in Player’s Team, All Players | Determines who can use the powerup. |
| **Who Can See This Powerup** | **Only Players That Can Pick Up**, All, None | Determines who can see the powerup. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Spawn When Receiving From** | Spawns the Damage Amplifier Powerup when an event occurs. |
| **Despawn When Receiving From** | Despawns the Damage Amplifier Powerup when an event occurs. |
| **Pickup When Receiving From** | Allows the power-up effect to occur when it is picked up. |
| **Clear When Receiving From** | Clears the powerup effect if it is currently in use when an event occurs. |

### Events

Sends an event to a linked device when a player interacts with the button.
Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Item Pickup Send Event To** | Sends an event to linked devices when the powerup is picked up. |
