# Physics Tree Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-physics-tree-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:42:33.491908

---

The **Physics Tree** is a large tree that can be chopped down by players. Unlike typical trees in Fortnite, which disappear when destroyed, this tree has a trunk that will fall after taking a certain amount of damage (becoming a log). The log can crash down through structures, people or creatures, depending on where you place it. It is subject to physics and gravity, so it will collide with players, creatures, vehicles, structures, and terrain. You can determine the maximum amount of [damage](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#damage) the log does when it hits something (although the actual damage depends on the speed of the tree on impact).

For help on how to find the Physics Tree device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

You can configure this device with the following options.

Default values are **bold**.

### All Options (Additional)

| Option | Value | Description |
| --- | --- | --- |
| **Damage to Players** | None, **150 (Default)**, Pick an amount | Determines the maximum damage a log can do to a player. Actual damage to a player depends on the velocity of the log when it hits. |
| **Damage to Creatures** | None, **450 (Default)**, Pick an amount | Determines the maximum damage a log can do to a creature. Actual damage to a player depends on the velocity of the log when it hits. |
| **Damage To Vehicles** | None, **450 (Default)**, Pick an amount | Determines the maximum damage a log can do to a vehicle. Actual damage to a player depends on the velocity of the log when it hits. |
| **Damage to Environment** | None, **1200 (Default)**, Pick an amount | Determines the maximum damage a log can do to the environment on each hit. Actual damage to environmental objects depends on the velocity of the log when it hits. |
| **Timed Tree Respawn** | **15M**, None, Pick an amount of time | Determines how long it takes for a tree to respawn after it is chopped down. |
| **Spawn When Enabled** | **Yes**, No | Determines whether the tree automatically spawns when the device is enabled. |
| **Destroy When Disabled** | **Yes**, No | Determines whether the tree is automatically destroyed when the device is disabled. |
| **Health** | Indestructible, **200 (Default)**, Pick an amount | Determines how much damage the tree can take before it is chopped down. |
| **Leave Stump** | **Yes**, No | Determines whether a stump is left behind after the tree is chopped down. |
| **Stump Health** | Indestructible, **120 (Default)**, Pick an amount | If the Leave Stump option is set to Yes, this determines how much damage the stump can take before it is destroyed. |
| **Log Health** | Indestructible, **600 (Default)**, Pick an amount | Once the tree is chopped down, the falling tree becomes a log. This determines how much damage the log can take before it is destroyed. |

## Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | The device is enabled when an event occurs. |
| **Disable When Receiving From** | The device is disabled when an event occurs. |
| **Spawn When Receiving From** | When an event occurs, it spawns the tree. This destroys any previously spawned objects. |
| **Destroy All When Receiving From** | When an event occurs, it destroys all spawned trees. This does not release the log. |
| **Release Log When Receiving From** | When an event occurs, it releases the log (if there is one). |
| **Destroy Log When Receiving From** | When an event occurs, it destroys the current log. |
| **Destroy Stump When Receiving From** | When an event occurs, it destroys the stump. |

### Events

An event tells another device when to perform a function.

1. For any event, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Tree Is Knocked Send Event To** | When the tree has taken enough damage to be knocked down, an event is sent to the selected device. |
| On **Log Is Destroyed**Send Event To | When the log is destroyed, an event is sent to the selected device. |
| **On Stump Is Destroyed** Send Event To | When the stump is destroyed, an event is sent to the selected device. |
| **On Tree Spawned** Send Event To | When a tree is spawned, an event is sent to the selected device. |
