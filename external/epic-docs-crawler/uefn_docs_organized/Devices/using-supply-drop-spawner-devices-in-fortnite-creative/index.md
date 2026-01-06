# Supply Drop Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-supply-drop-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:48:27.428209

---

A **Supply Drop Spawner** [spawns](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#spawning) a box of supplies that parachutes down from the sky. This can be triggered by players, providing a more dynamic and immersive way of equipping players with weapons and other items.

There are a lot of [game modes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#game-mode) where this would be useful. For example:

- If your island is a Battle Royale or Storm Wars game, you can spawn [supply drops](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) just like Fortnite Battle Royale.
- If you have a zombie defense game, players could request a supply shipment from an organization or NPCs.
- If your island is a survival game, this could be a way to provide critical supplies in a tough area.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use italic for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

Configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Destructible Balloon** | **True**, False | Determines whether the balloon is destructible. |
| **Balloon Health** | **250**, Pick an amount | If the balloon is destructible, determines how much damage the balloon can take before it is destroyed and drops the supply crate. |
| **Owning Team** | **Any**, Pick or enter a team | Determines which team can damage the balloon and interact with the supply crate. |
| **Invert Team Selection** | On, **Off** | If set to **On**, all teams except the one selected in the **Owning Team** option can interact with the supply drop. |
| **Invert Team Damage** | On, **Off** | If set to **On**, all teams except the one selected in the **Owning Team** option can damage the balloon. |
| **Owning Class** | No Class, **Any**, Pick or enter a class | Determines which class can interact with the supply crate. If you choose **No Class**, only players with no assigned class can interact with the supply crate. If you choose **Any** any player with an assigned class can interact with the supply crate. |
| **Invert Class Selection** | On, **Off** | If set to **On**, all classes except the one selected in the **Owning Class** option can interact with the supply crate. |
| **Invert Class Damage** | On, **Off** | Determines which classes can damage the supply drop balloon. If set to **On**, all teams except the one selected in the **Owning Class** option can damage the balloon. |
| **Spawn Without Balloon** | True, **False** | Determines whether the supply drop spawns with a balloon. |
| **Fall Speed** | **1.0x**, Pick a multiplier | Determines how fast the supply crate falls, expressed as a multiple of normal speed. |
| **Start Locked** | True, **False** | Determines whether the supply crate is locked when spawned. |
| **Spawn Radius** | Island, **Above**, *Custom* | Determines how far from the spawner the supply crate can spawn. If you choose **Island**, supply crates can spawn anywhere on the island. If you choose **Above**, supply crates will always spawn directly above the device. If you choose **Custom** another option displays below this one. |
| **Custom Spawn Radius** | **0.0 m**, Pick or enter a radius | Customize how far from the device the supply drop spawns. |
| **Show Flare Where Landing** | **True**, False | Determines whether the flare smoke and reticle appear when the supply drop spawns. |
| **Show Icon on Minimap** | **True**, False | Determines whether the supply drop icon should appear on the minimap when the supply drop spawns. |
| **Spawn Delay** | Off, **Game Start**, *Custom* | Determines how long the device waits before spawning a supply drop. If you select **Game Start** a supply drop will spawn when the game starts. If you select **Off**, the supply drop will only be spawned by event binding. If you choose **Custom** another option displays below this one. |
| **Custom Spawn Delay** | **1.0 second**, Pick or enter an amount | Customize how long it takes for the device to spawn a supply drop crate. |
| **Supply FX Color** | **Blue**, Pick a color swatch | Determines the color of the smoke and reticle VFX for the spawner. |
| **Balloon Style** | **Standard**, Old School, Birthday, Holiday | Determines the visual style of the balloon attached to the supply crate. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these step

| Option | Description |
| --- | --- |
| **Spawn Supply Drop When Receiving From** | Spawns a supply drop when an event occurs, provided one hasn't already spawned. |
| **Destroy Balloon When Receiving From** | When an event occurs, it destroys the balloon and causes the supply crate to drop. |
| **Open Supply Drop When Receiving From** | When an event occurs, it opens the supply drop whether it is locked or unlocked. |
| **Unlock Supply Drop When Receiving From** | When an event occurs, it unlocks the supply crate so players can open it. |
| **Lock Supply Drop When Receiving From** | When an event occurs, it locks the supply crate so players can't open it. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Opened Send Event On** | When the supply crate is opened, an event occurs. |
| **On Balloon Popped Send Event On** | When the balloon on the supply crate is popped, an event occurs. |
| **On Landing Send Event On** | When the supply crate lands for the first time, an event occurs. |
