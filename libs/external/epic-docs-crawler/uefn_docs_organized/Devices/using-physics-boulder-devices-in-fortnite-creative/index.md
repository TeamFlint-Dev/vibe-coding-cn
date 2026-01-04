# Physics Boulder Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-physics-boulder-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:34:08.086627

---

The **Physics Boulder** is a large, rounded boulder that sits on a rocky base. The boulder can be released, and can roll or fall through the environment, depending on where you place it. It is subject to physics and gravity, so it will collide with players, creatures, vehicles, structures, and terrain. You can determine the maximum amount of [damage](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#damage) the falling or rolling boulder does when it hits something (although the actual damage depends on the speed of the boulder on impact).

**Looking for a spark of creative freedom?** See **[Down But Not Out Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/down-but-not-out-device-design-examples-in-fortnite-creative)** to liberate your imagination!

  For help on how to find the [Nitro Hoop] device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Damage to Players** | None, **150**, Pick an amount | Determines the maximum damage a rolling boulder can do to a player. Actual damage to a player depends on the velocity of the boulder when it hits. |
| **Damage to Creatures** | None, **450**, Pick an amount | Determines the maximum damage a rolling boulder can do to a creature. Actual damage to a creature depends on the velocity of the boulder when it hits. |
| **Damage To Vehicles** | None, **450**, Pick an amount | Determines the maximum damage a rolling boulder can do to a vehicle. Actual damage to a vehicle depends on the velocity of the boulder when it hits. |
| **Damage to Environment** | None, **3000**, Pick an amount | Determines the maximum damage a rolling or falling boulder can do to the environment on each hit. Actual damage to environmental objects depends on the velocity of the boulder when it hits them. |
| **Timed Respawn** | None, **15m**, Pick an amount of minutes | Determines how long it takes for the balanced boulder to respawn on the base. |
| **Boulder Base Required For Respawn** | **Yes**, No | Determines whether the boulder base is required to respawn a balanced boulder. |
| **Spawn When Enabled** | **Yes**, No | Determines whether a balanced boulder automatically spawns when the device is enabled. |
| **Destroy When Disabled** | **Yes**, No | Determines whether a rolling boulder is automatically destroyed when the device is disabled. |
| **Health** | Indestructible, **180**, Pick an amount | Determines how much damage a boulder on its base can take before it is destroyed. |
| **Leave Base** | **Yes**, No | Determines if the boulder's base remains after the boulder is destroyed. |
| **Base Health** | Indestructible, **180**, Pick an amount | Determines how much damage the boulder's base can take before it is destroyed. |
| Rolling Boulder Health | Indestructible, **900**, Pick an amount | Determines how much damage a rolling boulder can take before it is destroyed. |

## Direct Event Binding

Below are the direct event binding options for this device.

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the option, then **Select Device** to access and select from the Device dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Spawn When Receiving From** | When an event occurs, the device spawns the balanced boulder. This destroys any previously spawned objects. |
| **Enable When Receiving From** | The device is enabled when an event occurs. |
| **Disable When Receiving From** | The device is disabled when an event occurs. |
| **Destroy All When Receiving From** | When an event occurs, it destroys all spawned rolling boulders. This does not release or destroy the boulder currently on the base. |
| **Release Physics Object When Receiving From** | When an event occurs, it releases the boulder that is balanced on the base (if there is one). |
| **Destroy Rolling Boulder When Receiving From** | When an event occurs, it destroys the current rolling boulder. |
| **Destroy Base When Receiving From** | When an event occurs, it destroys the boulder's base. |

### Events

Transmitters send a signal on the selected channel when triggered.

| Option | Description |
| --- | --- |
| **When Balance Boulder Spawned Send Event To** | When the balanced boulder is spawned on the base, an event is sent to the selected device. |
| **When Boulder Is Destroyed** Send Event To | When the boulder is destroyed, an event is sent to the selected device. |
| **When Base Is Destroyed** Send Event To | When the base for the boulder is destroyed, an event is sent to the selected device. |
| **When Rolling Boulder Is Released** Send Event To | When the rolling boulder is released from the base, an event is sent to the selected device. |
