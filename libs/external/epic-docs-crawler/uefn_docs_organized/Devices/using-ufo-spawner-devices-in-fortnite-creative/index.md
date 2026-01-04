# UFO Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-ufo-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:42:21.404494

---

A **UFO Spawner** is a device that [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) a UFO vehicle onto your island at the spawner's given location and orientation.

- Use UFO Spawner devices in combination with the [Race Checkpoint Device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#race-checkpoint) to design a racing game for your players.
- You can place a player directly inside the UFO using a trigger.

## Finding and Placing the Device

[![The UFO Spawner device in the Creative inventory](https://dev.epicgames.com/community/api/documentation/image/9393c5aa-9dfa-487a-8362-5e83595f27ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9393c5aa-9dfa-487a-8362-5e83595f27ea?resizing_type=fit)

*Click image to enlarge.*

1. From [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode), press the **Tab** key to open the [CREATIVE inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) screen.
2. Click the **DEVICES** tab and scroll to select the device. You can also use the **Search** box or the **Categories** panel on the left to find your device.
3. Click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) immediately, or put the device in the [QUICK BAR](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-bar) to place later.
4. Press **Esc** to return to your island in Create mode. Use your [phone](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#phone) tool to position the device, then left-click to place it. Press **Esc** to detach the device from your phone.
5. Point at the base of the device with your phone. If the **CUSTOMIZE** popup doesn’t open immediately, move closer until it does, then press **E** to open the CUSTOMIZE panel.

It’s helpful to [customize device names](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) when you use multiple copies of the same device.

## Device Options

This device has some basic functionality, like whether it is visible in game, or whether it supports [wraps](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#wrap). Additionally, there are some advanced options, like which [class](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class) and team can use the vehicle, and whether [enabling](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#enable) or disabling the device spawns or [despawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#despawn) the vehicle.

You can configure this device with the following options.

Default values are **bold**.

### Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. This does affect its [collision](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) properties. |
| **Reboots** | **2**, No Reboots, Unlimited, Pick a number | Determines how many times the UFO will reboot to full health after being reduced to 0 health. |

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | **All**, None, Pre-Game Only, Gameplay Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-phase) during which the device will be enabled. Pre-Game includes all phases prior to the Game starting (the waiting for players lobby on Featured Islands and the Game Start Countdown). |
| **Respawn Time** | **Instant**, Never, Pick a time | Respawns a vehicle that's been destroyed after a selected delay. |
| **Respawn Vehicle when Enabled** | **Yes**, No, Only if Needed | If this is set to **Yes**, a vehicle will spawn when the device is enabled. Choosing **Only If Needed** will not reset an existing vehicle. |
| **Destroy Vehicle when Disabled** | **Yes**, No | Destroys a spawned vehicle when the spawner is disabled. |
| **Owning Team** | **Any**, Pick a team | Sets the team the device belongs to. |
| **Selected Class** | **None**, Any, No Class, Pick a class | Determines what class can use this vehicle.  Values for this option are:   - **None**: All players, including players with no class assigned, can use the vehicle. - **Any**: Any player with a class assigned can use the vehicle. - **No Class**: Only players with no class assigned can use the vehicle. - **Pick a class**: Pick a [class identifier](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#class-identifier); only players assigned that class can use the vehicle. |
| **Vehicle Health** | **1500**, Indestructible, Pick a number | Determines how much damage the vehicle can take before it is destroyed. |
| **Enable Cannon** | **Yes**, No | Determines whether the cannon can be used. |
| **Enable Tractor Beam** | **Yes**, No | Determines whether the tractor beam can be used. |

## Channels

When one device needs to "talk" to another device, it does so by [transmitting](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) a [signal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) on a specific [channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). The receiving device needs to be set up to [receive](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#receive) the signal on the same channel.

A channel is identified by a number, and channel numbers are customized for a device under the option that uses the channel. Most devices will also pass the identity of the player who [triggered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the device with the signal.

When the UFO Spawner device receives a signal on a channel, it can be enabled or disabled, can spawn or destroy a vehicle, and assign a driver. It can transmit a signal on a channel when a player enters or exits the vehicle, and when the vehicle is spawned or destroyed.

### Receivers

Receivers listen for a channel and perform an action when they hear any device (including themselves) send a signal on that channel.

| Option | Value | Description |
| --- | --- | --- |
| **Assigns Driver When Receiving From** | **No Channel**, Pick a channel | Sets the player that [instigated](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#instigator) the signal as the spawned vehicle's pilot |
| **Respawn Vehicle When Receiving From** | **No Channel**, Pick a channel | Spawns a new vehicle after receiving a signal on the selected [channel](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). The existing vehicle will be destroyed before a new vehicle spawns. |
| **Destroy Vehicle When Receiving From** | **No Channel**, Pick a channel | When receiving a signal on the selected channel, the spawned vehicle is destroyed if it exists. |
| **Enable When Receiving From** | **No Channel**, Pick a channel | When a signal is received on the selected channel, the UFO spawner is enabled. |
| **Disable When Receiving From** | **No Channel**, Pick a channel | When a signal is received on the selected channel, the UFO spawner is disabled. |

### Transmitters

Transmitters send a signal on the selected channel when triggered.

| Option | Value | Description |
| --- | --- | --- |
| **When Player Enters Vehicle Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a player enters the spawned vehicle. |
| **When Player Exits Vehicle Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a player exits the spawned vehicle. |
| **When Vehicle Spawns Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a vehicle is spawned or respawned. |
| **When Vehicle is Destroyed Transmit On** | **No Channel**, Pick a channel | Transmits a signal on the selected channel when a vehicle is destroyed. |
