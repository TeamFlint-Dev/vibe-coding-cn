# Firefly Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-firefly-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:31:48.044448

---

The **Firefly Spawner** device places collectible fireflies that can be used to cause fire destruction. Fireflies spawned from this device will circle around the spawn area until collected.

You can control both the total number of fireflies produced and the duration between spawns. Once collected, these fireflies will be placed in jars that can be equipped in stacks of six in your Equipment Bar.

[![Thrown Jar](https://dev.epicgames.com/community/api/documentation/image/902f5102-cd9c-4f37-abe1-cbf0a8ff2795?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/902f5102-cd9c-4f37-abe1-cbf0a8ff2795?resizing_type=fit)

Thrown firefly jars will cause any surrounding terrain and structures to take fire damage if **Enable Fire**, **Environment Damage**, and **Structure Damage** are enabled in [My Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

Players directly hit with a firefly jar will take 40 points of damage. Stepping into fire from this device will take 15 points of health per second. Both the affected player and their health bar will be in flames.

  To find the Firefly Spawner device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

This device has some basic functionality, like choosing which team can activate the device and how long it takes to collect fireflies. You can also set collected fireflies to transmit a signal to a selected channel.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled At Game Start** | **Yes**, No | Determines the game phases during which the device will be enabled. |
| **Spawn Timer** | None, **3 Seconds**, Pick a time | Sets the minimum time between spawning fireflies. |
| **Activating Team** | **Any**, Pick a team | Determines which team can activate the device. |
| **Allowed Class** | No Class, **Any**, Pick a class | Determines which class can activate the device. |
| Total Spawn Limit | Infinite, 1, Pick a number | Sets the maximum number of fireflies this device can produce during its lifetime. |
| Time to Collect | Instant, .5 Seconds, Pick a time | Determines the interaction time required to collect the fireflies. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event and select the event that triggers this function.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the Firefly Spawner when an event occurs. |
| **Disable When Receiving From** | Disables the Firefly Spawner when an event occurs. |
| **Reset Spawn Count When Receiving From** | Resets the Firefly Spawner’s respawn count when an event occurs. |
| **Respawn When Receiving From** | Respawns fireflies when an event occurs. |

### Events

Transmitters send a signal on the selected channel when triggered.

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Fireflies Collected Transmit On** | When the spawned fireflies are collected, an event is sent to the selected device. |
