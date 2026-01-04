# Grind Powerup Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/grind-powerup-devices
> **爬取时间**: 2025-12-26T23:38:06.160388

---

You can use the **Grind Powerup** device to force players to slide on any surface. As they slide, sparks fly from their feet with a spark effect. This effect, along with the ambient audio, shows how long the powerup lasts.

This can be useful in [brawl games](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) where you can offer a status [buff](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to increase the [damage](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) they put out, or to boost their speed.

You can also use it in [skillrun](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary)- or [parkour](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary)-type games where you can raise stakes by forcing players to slip on a surface, making the run more challenging.

For help finding the Grind Powerup device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

## Device Options

[Default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options include a duration of 3 seconds, with 15 seconds until [respawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). These and a number of other options can be customized to suit your [gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

You can also set the device to affect only the player who picks it up, or the player's whole team.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Disables Effect On Pickup** | **No**, Yes | If set to **Yes**, the effect will be cancelled when a player picks up the device. |
| **Pickup Radius** | **On Touch**, Pick a distance | How close the player needs to be to collect the device. |
| **Spawn On Minigame Start** | **Yes**, No | Determines whether the device will [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) immediately at the start of a minigame. If set to **No**, the device will spawn only at the respawn time set under **Time To Respond**. |
| **Pick Up Audio** | **On**, Off | Determines whether a sound plays when a player picks up the device. |
| **Selected Team** | **Any**, Pick a team | Only the selected team can interact with this device. |
| **Selected Class** | **Any**, Pick a class | Only the selected [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) can interact with this device. |
| **Apply To** | **Player**, Player’s Team, Player’s Class, Same Class in Player’s Team, All Players | Effect will only be applied to the selected players. |
| **Who Can See This Powerup** | **Only Players That Can Pickup**, All, None | Only selected players will be able to see the device. |
| Effect Duration | 3 Seconds, Infinite, Pick a time | Determines how long the effect lasts. |
| Time To Respawn | Never, Instant, 15 Seconds, Pick a time | How long until the item respawns after it is picked up. |
| Ambient Audio | On, Off |  |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/function) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Spawn When Receiving From** | Immediately spawns the device when an event occurs. |
| **Despawn When Receiving From** | Immediately despawns the device when an event occurs. |
| **Pickup When Received From** | Picks up the powerup when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/event) tells another device when to perform a function.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **When Item Picked Up Transmit On** | When a player collects the powerup, an event is sent to the selected device. |
