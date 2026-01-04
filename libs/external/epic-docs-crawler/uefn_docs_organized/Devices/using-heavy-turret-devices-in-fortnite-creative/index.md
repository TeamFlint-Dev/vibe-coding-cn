# Heavy Turret Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-heavy-turret-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:29:36.599010

---

The **Heavy Turret** is a ground-based version of the turret on the Armored Battle Bus. You can place these devices around your island for players to use to eliminate vehicles, [NPCs](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), or other players.

For help on how to find the Heavy Turret device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | Always, None, Pre-Game Only, Gameplay Only | Determines the game [phases](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) during which the device will be enabled. Pre-Game includes all phases prior to the Game starting (the waiting for players lobby on Featured Islands and the Game Start Countdown). |
| **Enable Respawn** | On, *Off* | Determines if the vehicle will respawn after being destroyed. If set to Off, the following option is hidden: Respawn Time. |
| **Respawn Time** | Never, **Instant**, Pick an amount of time | When the vehicle is destroyed, this determines the amount of time before another one spawns. |
| **Respawn Vehicle When Enabled** | **Yes**, No, Only When Needed | Determines whether the device respawns a vehicle when it is enabled.   - **Yes**: a vehicle spawns when the device is enabled. - **Only When Needed**: The device only spawns if the original was destroyed. - **No**: The device doesn't spawn a vehicle when it is enabled. |
| **Destroy Vehicle When Disabled** | **Yes**, No | Determines whether an existing vehicle is destroyed when the device is enabled.   - **Yes**: An existing vehicle is destroyed when the device is disabled. - **No**: A spawned vehicle remains when the device is disabled. |
| Activating Team | **Any**, Pick a team | Determines which team owns the vehicle spawner. |
| Allowed Class | All, Any, No Class, Pick a class | Determines which classes can use the vehicle.   - All: All players can use the vehicle, even those without an assigned class. - Any: Any player who has an assigned class can use it. - No Class: Only players with no assigned class can use it. |
| **Visible During Game** | **On**, Off | Determines whether the device is visible during the game. This affects its collision properties. |
| Vehicle Indestructible | Off, *On* | Determines if the vehicle can be destroyed by damage. If set to On, the following options becomes hidden: Vehicle Health. |
| **Vehicle Health** | **400 (Default)**, Indestructible, Pick an amount of health | Determines how much damage the vehicle can take before it is destroyed. |
| Destroy When Stuck Under Water | On, Off | Determines if the vehicle will destroy itself when it’s stuck under water. |
| Water Destruction Timer | Instant, **5 Seconds**, Pick an amount of time | When the vehicle drives through deep water, this determines how long the vehicle lasts before being destroyed. |
| **Visible During Game** | On, Off | Determines whether the spawner is visible during the game. |

## Direct Event Binding

### Functions

A function listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the Add button to add a line and repeat these steps

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Respawn Vehicle When Receiving From** | Respawns the vehicle when an event occurs. |
| **Destroy Vehicle When Receiving From** | Destroys the vehicle when an event occurs. |
| **Assigns Driver When Receiving From** | Seats the instigating player in the vehicle when an event occurs. |

### Events

An event tells another device when to perform a function.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Player Enters Vehicle Send Event To** | When a player enters the vehicle, an event is sent to the selected device. |
| **On Player Exits Vehicle Send Event To** | When a player exits the vehicle an event is sent to the selected device. |
| **On Vehicle Spawns Send Event To** | When the vehicle is spawned an event is sent to the selected device. |
| **On Vehicle is Destroyed Send Event To** | When the vehicle is destroyed an event is sent to the selected device. |
