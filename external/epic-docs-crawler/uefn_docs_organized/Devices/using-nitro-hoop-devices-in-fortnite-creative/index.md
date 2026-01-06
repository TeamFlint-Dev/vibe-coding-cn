# Nitro Hoop Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-nitro-hoop-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:35:00.603073

---

Get players and vehicles moving even faster by placing this flaming hoop on your island! You can add a touch of flare to any racing game, or just give player vehicles a little boost to get away from enemies.

For help on how to find the **Nitro Hoop** device, see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the **[Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative)**.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Base Type** | **Default**, Halfway, None | Determines what kind of base the hoop has. **Default** raises the hoop slightly off the ground; **Halfway** is intended for hoops that are partly embedded in the group; **None** means the hoop is level with the ground. |
| **Add Columns** | **None**, Pick a number | This will place the hoop on top of a short column to raise it in the air. If you select a number higher than 1, the columns will be stacked vertically to make a taller column that raises the hoop higher. |
| **Add Stand** | True, **False** | If you select **True**, it places the hoop on a short stand. This raises the hoop up, but less than adding a column does. |
| **Enable on Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the phases in which the device is enabled. **Pre-Game Only** includes all phases occurring before the game starts. |
| **Enable Cooldown** | True, **False** | Determines whether automatic cooldown is enabled. If this is set to **True**, using the hoop will cause it to enter cooldown (during which the device is disabled). At the end of the time set in the **Cooldown Duration** option, the hoop will automatically be reenabled. |
| **Cooldown Duration** | **10**, Manual End, Pick or enter an amount | Determines how long the cooldown state lasts, in seconds. If you select **Manual End**, the cooldown state does not automatically end, and you must use event binding to enable the device. |
| **Cooldown at Game Start** | On, **Off** | Determines whether the device goes into the cooldown state as soon as the game starts. If this is set to **On**, the device must be enabled at game start for this to work. |
| **Cooldown at Round Start** | On, **Off** | Determines whether the device goes into the cooldown state as soon as a new round starts (excluding the first round). If this is set to **On**, the device must be enabled when the round starts for this to work. |
| **Added Player Velocity** | **45 m/s**, Pick or enter an amount | If the device is enabled, this determines the amount of velocity (in meters per second) that is added to the player when they pass through the hoop. |
| **Vehicle Velocity Multiplier** | **1.125x**, Pick or enter an amount | If the device is enabled, this determines the velocity multiplier added to vehicles when they pass through the hoop. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Allow Cooldown When Receiving From** | When an event occurs, it allows the hoop to go into a cooldown state after a player or vehicle passes through it. |
| **Disallow Cooldown When Receiving From** | When an event occurs, it prevents (disallows) the hoop from going into a cooldown state after a player or vehicle passes through it. |
| **Start Cooldown When Receiving From** | When an event occurs, this puts the hoop into a cooldown state, and re-enables the hoop at the end of the cooldown. If this occurs when the hoop is already in the cooldown state, this function resets the cooldown timer. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select** **Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Triggered by Player Send Event To** | When a player goes through the hoop, an event is sent to the selected device. |
| **On Triggered by Vehicle Send Event To** | When a vehicle goes through the hoop, an event is sent to the selected device. |
| **On Start Cooldown Send Event To** | When the hoop enters a cooldown state, an event is sent to the selected device. Note: this does not trigger if the device is disabled manually. |
| **On Enabled Send Event To** | When the hoop is enabled after being disabled, an event is sent to the selected device. This includes when the hoop is disabled by entering a cooldown state. |
