# Damage Volume Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:47:31.729858

---

The **Damage Volume** device creates zones that can damage or eliminate players, vehicles, and creatures that pass through them. The created zones can pass through any surrounding environment.

The device creates a customizable [volume](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) that deals damage to players, vehicles, or creatures who enter the volume. It can also be set to eliminate players, vehicles or creatures that enter the volume.

  For help finding the **Damage Volume** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

**Looking for more inspiration?** See **[D-Launcher Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/dlauncher-device-design-examples-in-fortnite-creative)** and the **[Down But Not Out Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/down-but-not-out-device-design-examples-in-fortnite-creative)** to kick off your imagination!

## Device Options

When placed, the Damage Volume default size is a single grid, with options to change the overall size of the zone. Other default options include immediately dealing 200 damage to any player, vehicle, or creature who enters the zone, which eliminates them.

The default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled on Phase** | None, All, Pre-Game Only, **Gameplay Only** | Determines which [game phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the device will be enabled. Pre-Game includes all phases prior to the Game starting (the waiting for players lobby on Featured Islands and the Game Start Countdown. |
| **Zone Visible During Game** | Yes, **No** | Determines whether the zone is visible during the game. |
| **Zone Width** | Pick a number | Sets the width of the zone in tiles. |
| **Zone Depth** | Pick a number | Sets the depth for the zone. |
| **Zone Height** | Pick an number | Sets the height for the zone. |
| **Damage Type** | Elimination, **Damage Over Time** | Determines whether the zone will instantly eliminate the target or deal damage over time while they remain inside it. |
| **Damage** | **10**, Pick a number | Sets the amount of damage inflicted on a target each tick while they are in the zone. Has no effect if **Damage Type** is set to Elimination. |
| **Damage Tick Rate** | **2 Seconds**, Pick a time | (Damage Volume only) Determines how often the selected damage amount is applied to a target in the zone. Has no effect if **Damage Type** is set to Elimination. |
| **Selected Team** | **None**, Pick a team | If set to None, all players are affected. Otherwise, the chosen team will be used to determine the **Affects Team** effect. |
| **Invert Team Selection** | **Off**, On | If set to **On**, all teams except the selected team are affected by this volume. |
| **Selected Class** | **None**, Any, No Class, Pick a number | If set to None, affect all Classes (including players with no Class). Otherwise, use the chosen Class to determine the Affects Class effect. Any Class means that to affect all players with an assigned Class, regardless of what Class it may be. No Class affects players without an assigned Class. |
| **Invert Class Selected** | **Off**, On | If set to **On**, all classes except the selected class are affected by this volume. |
| **Affects Shields** | **On**, Off | Determines whether damage is taken to shields before health is impacted. |
| **Affects Creatures** | **Yes**, No | Determines whether Creatures are affected by the zone. |
| **Affects Players** | **Yes**, No | Determines whether players are affected by the zone. |
| **Affects Guards** | **Yes**, No | Determines whether Guards are affected by the zone. |
| **Affects Vehicles** | **Yes**, No | Determines whether vehicles are affected by the zone. If this is Off, no vehicles will be damaged regardless of the **Affects Unmanned Vehicles** option. |
| **Affects Unmanned Vehicles** | Yes, **No** | Determines whether unmanned vehicles are affected by the zone. Only has an effect if **Affects Vehicles** is On. |
| **Enable VFX** | **Enabled**, Disabled | Enable/Disable the VFX when a player enters the zone. |
| **Zone Shape** | **Box**, Cylinder | This determines the shape of the volume. |
| **External Volume** | **None**, Select an external volume | Provides a way to use a volume other than the default volume. |

### Physics-Enabled Options

The following options become available when [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) are enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Affects Physics Props** | On, **Off** | Determines whether the volume affects physics props. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the timer to an event that will trigger the function for the device.
3. If more than one device should be affected by a function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **Disable When Receiving From** | Disables the volume when an event occurs. |
| **Enable When Receiving From** | Enables the volume when an event occurs. |
| **Update Selected Class When Receiving From** | Changes the selected class setting to match the triggering player when an event occurs. |
| **Update Selected Team When Receiving From** | Changes the selected team setting to match the triggering player when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one device is affected by the function, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Player Entering the Zone Send Event To** | When a player enters the zone, it sends an event to the selected device, which triggers the selected function. |
| **On Player Exiting the Zone Send Event To** | When a player exits the zone, it sends an event to the selected device, which triggers the selected function. |
| **On Agent Entering Zone** | When an agent enters the zone, it sends an event to the selected device, which triggers the selected function. |
| On Agent Exiting Zone | When an agent exits the zone, it sends an event to the selected device, which triggers the selected function. |
