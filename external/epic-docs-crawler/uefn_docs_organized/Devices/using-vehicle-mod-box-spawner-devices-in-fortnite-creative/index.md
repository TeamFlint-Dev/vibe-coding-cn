# Vehicle Mod Box Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-vehicle-mod-box-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:43:34.774654

---

Use this device to offer players respawning [vehicle mods](https://dev.epicgames.com/documentation/en-us/fortnite/using-vehicle-mod-items-in-fortnite-creative) to attach to the following vehicles:

- [Armored Battle Bus](https://dev.epicgames.com/documentation/en-us/fortnite/using-armored-battle-bus-spawner-devices-in-fortnite-creative) (excluding Bulletproof Tire mods)
- [Armored Transport](https://dev.epicgames.com/documentation/en-us/fortnite/using-armored-transport-spawner-devices-in-fortnite-creative)
- [Big Rig](https://dev.epicgames.com/documentation/en-us/fortnite/using-big-rig-spawner-devices-in-fortnite-creative)
- [Fang](https://dev.epicgames.com/documentation/en-us/fortnite/using-fang-spawner-devices-in-fortnite-creative)
- [Nitro Drifter](https://dev.epicgames.com/documentation/en-us/fortnite/using-nitro-drifter-spawner-devices-in-fortnite-creative)
- [Pickup Truck](https://dev.epicgames.com/documentation/en-us/fortnite/using-pickup-truck-spawner-devices-in-fortnite-creative)
- [Sedan](https://dev.epicgames.com/documentation/en-us/fortnite/using-sedan-spawner-devices-in-fortnite-creative)
- [Sports Car](https://dev.epicgames.com/documentation/en-us/fortnite/using-sports-car-spawner-devices-in-fortnite-creative)
- [SUV](https://dev.epicgames.com/documentation/en-us/fortnite/using-suv-spawner-devices-in-fortnite-creative)
- [Taxi](https://dev.epicgames.com/documentation/en-us/fortnite/using-taxi-spawner-devices-in-fortnite-creative) (excluding Rooftop mods)
- [War Bus](https://dev.epicgames.com/documentation/en-us/fortnite/using-war-bus-spawner-devices-in-fortnite-creative) (excluding Bulletproof Tire mods)

The Repair Box mod is compatible with all vehicles.

Vehicle mods are alterations that will automatically attach to the triggering vehicle. These mods can help you navigate terrain, damage the environment and other players, and repair the triggering vehicle.

By default, the Vehicle Mod Box Spawner will spawn a random vehicle mod type when your game starts and will randomly switch to a different mod when respawned. You can recognize the vehicle mods by their box icons and the names that appear over the box.

Place these mod boxes on your island and instruct your players to run over the mod boxes to apply the mod to the triggering vehicle.

Pair the **Vehicle Mod Box Spawner** device on your island with a vehicle, such as [Fang Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-fang-spawner-devices-in-fortnite-creative), as an easy way for players to modify to attach to their vehicles when they drive over the box..

You can even place [Vehicle Service Station](https://dev.epicgames.com/documentation/en-us/fortnite/using-vehicle-service-station-devices-in-fortnite-creative) devices to allow players to refuel their vehicles in your drivable gameplay.

## Vehicle Mods

Based on your device configurations, vehicle mods can spawn with variations of mod types from the table below.

|  | Vehicle Mod | Description |
| --- | --- | --- |
| [Tire Mod](https://dev.epicgames.com/community/api/documentation/image/e906a066-f9bf-484c-8206-4e4fcc448075?resizing_type=fit) | **Tire Mod** | Spawns a box that can contain tire mods like:   - **Bulletproof Tires** - **Offroad Tires** |
| [Bumper Mod](https://dev.epicgames.com/community/api/documentation/image/78cf82c1-0b03-4d7f-95d7-5939cee1e42a?resizing_type=fit) | **Bumper Mod** | Spawns a box that can contain bumper mods like:   - **Cow Catcher** - **Spiked Bumper** |
| [Rooftop Mod](https://dev.epicgames.com/community/api/documentation/image/ea1210ee-7083-48b4-af8f-23693f25b2f9?resizing_type=fit) | **Rooftop Mod** | Spawns a box that can contain bumper mods like:   - **Grenade Launcher** - **Machine Gun** |
| [Repair Box](https://dev.epicgames.com/community/api/documentation/image/adca4eea-b0c5-4780-8368-86deec37166a?resizing_type=fit) | **Repair Box** | Spawns a box that can repair vehicles. |
|  | **Custom Mod** | Spawns a custom mod box that you build. |

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled on Game Start** | **True**, False | Determines whether the device is enabled at the start of the game. When disabled, the boxes spawned from this device will be hidden. |
| **Overall Visual Style** | **Default**, Blank, *Custom*, *Custom (Paint Only)*, *Custom (Icon Only)* | Determines how a spawned mod box will look. When set to **Blank**, the mod box will look like an unpainted wooden crate.  When creating a custom style box, new style options become available for the box's color and icon. |
| **Paint Color** | Select a paint color. | This option only appears if you have set the **Overall Visual Style** option to **Custom** or **Custom (Paint Only)**. Determines what color the mod box is. |
| **Icon** | Select an icon for the mod box. | This option only appears if you have set the **Overall Visual Styl****e** option to **Custom** or **Custom (Icon Only)**. Determines what icon is featured on the sides of the mod box. |
| **Recolor Icon** | **False**, *True* | This option only appears if you have set the **Overall Visual Style** option to **Custom** or **Custom (Icon Only)**.  When set to **True**, an option appears to choose the color of the icon. |
| **Icon Color** | Click the swatch to open the Color Picker and choose a color. | This option only appears if you have set the **Recolor Icon** option to **True**. Determines the color of the icon. |
| **Icon Scale** | **1.0x**, Pick a scale size (0.1 - 2.0) | This option only appears if you have set the **Overall Visual Style** option to **Custom** or **Custom (Icon Only)**. Determines how large or small the icon appears on the sides of the mod box. |
| **Initial Spawn Timer** | **Instant (0)**, Pick or enter a time | Determines the time in seconds before the mod box spawns for the first time. The timer clears if it is active when the device is disabled. |
| **Respawn Timer** | **30 Seconds**, Pick or enter a time | Determines the time in seconds before the mod box respawns. If the timer is active, it is cleared when the device is disabled. |
| **Possible Mods** | **All**, Tire Only, Bumper Only, Rooftop Only, Repair Box Only, *Custom List, None* | When set to **All**, the device will select from all possible mods. When set to **Tire Only**, **Bumper Only**, or **Rooftop Only**, only mods for that part of the vehicle will be used. When set to **Repair Box Only**, only the Repair Box will spawn. When set to **Custom List**, the **Custom List Mod 1** through **Custom List Mod 6** options will display, and you can use these to create a customized list of mods. |
| **Initial Mod** | **Random**, Custom List Mod 1 | This option only displays if the **Possible** **Mods** option is set to **Custom List**. Determines which mod box the device will spawn first. When set to **Random**, the device randomly chooses from all possible mods. |
| **Change Mod on Respawn** | ***True***, False | Determines whether the device will select again from within the group set for **Possible Mods** when it respawns. |
| **Respawn Selection** | ***Random***, Cycle | This option only displays if the **Change Mod on Respawn** option is set to **True**. Determines how to choose a mod box when respawning. When set to **Random**, the device randomly chooses from all possible mods. When set to **Cycle**, the initial mod box is the first provided mod in the list. Each mod box placed after that selects the next mod in the list, and restarts at the beginning once the entire list has been used. |
| **Avoid Duplicates** | **On**, Off | This option only displays if the **Change Mod on Respawn** option is set to **True**, and the **Respawn Selection** option is set to **Random**.  Determines whether a randomly selected mod can be the same as the one that spawned previously. |
| **Custom List Mod 1** | **Bulletproof Tires**, Pick a mod type | This option only appears if you set the **Possible Mods** option to **Custom List**. Determines the mod that can be spawned by this device. For each mod you have in your custom list, a **Weight** and **Visual Style** option will display as well. |
| **Mod 1: Weight** | **10**, Pick or enter a number | Sets a weighted probability of mods spawned from the custom list. The higher the mod weight, the more likely **Custom List Mod 1** will be chosen to spawn. When set to **0**, it is likely to not be chosen. |
| **Mod 1: Visual Style** | **Overall Visual Style**, Default, Blank, *Custom*, *Custom (Paint Only), Custom (Icon Only)* | Determines what the Custom List Mod 1 box looks like when spawned. If this option is set to **Custom**, **Custom (Paint Only**, or **Custom (Icon Only)**, the **Mod 1:****Paint Color**,  Mod 1: **Icon**, Mod 1: **Recolor Icon**, **Mod 1: Icon Color**, and **Mod 1: Icon Scale** might display (depending on which setting you pick). |
| **Custom List Mod 2** | Pick a mod type | This option only appears if you set the **Possible Mods** option to **Custom List**. Determines the mod that can be spawned by this device.  You must select a mod type to add a new one to your custom list. For each mod in your custom list, additional options will display. |
| **Custom List Mod 3** | Pick a mod type | This option only appears if you set the **Possible** **Mods** option to **Custom** **List**. Determines the mod that can be spawned by this device.  You must select a mod type to add a new one to your custom list. For each mod in your custom list, additional options will display. |
| **Custom List Mod 4** | Pick a mod type | This option only appears if you set the **Possible Mods** option to **Custom List**. Determines the mod that can be spawned by this device.  You must select a mod type to add a new one to your custom list. |
| **Custom List Mod 5** | Pick a mod type | This option only appears if you set the **Possible****Mods**option to **Custom****List**. Determines the mod that can be spawned by this device.  You must select a mod type to add a new one to your custom list. For each mod in your custom list, additional options will display. |
| **Custom List Mod 6** | Pick a mod type | This option only appears if you set the **Possible****Mods**option to **Custom****List**. Determines the mod that can be spawned by this device.  You must select a mod type to add a new one to your custom list. For each mod in your custom list, additional options will display. |
| **Mod Box Name Style** | **Default**, *Custom*, Hide | Controls the spawned mod box's name and whether to display it. **Custom** sets a custom name that all of the device's mod boxes will use. |
| **Custom Mod Box Name** | Enter a mod box name | This option only displays if the **Mod Box Name Style** option is set to **Custom**. Sets a custom name that all of the device's mod boxes will use. |
| **Show Player Tooltip** | **On**, Off | Determines whether to show the tooltip when a player gets close to the mod box without a vehicle. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device and starts the spawn timer. While the device is enabled, it can spawn vehicle mod boxes, which players can interact with. |
| **Disable When Receiving From** | Disables the device and clears any active spawn timers. When disabled, it will be hidden and mod boxes will not spawn. |
| **Spawn Box When Receiving From** | Spawns a mod box. If a mod box is already spawned, it despawns the first one without triggering **On Box Destroyed**. The device must be enabled for this setting to work. |
| **Despawn Box When Receiving From** | Disables the device and clears any active spawn timers. While disabled, it will be hidden and the vehicle mod boxes will not spawn. |
| **Start Spawn Timer When Receiving From** | Despawns the box if necessary without triggering **On Box Destroyed** to start the spawn timer. The device must be enabled for this setting to work. |
| **Spawn Last Chosen Mod When Receiving From** | Spawns the same mod box this device spawned before. If a mod box is already spawned, it despawns the first one without triggering **On Box Destroyed**. If this device is disabled or has not spawned more than one mod box, this setting will not work. |
| **Cycle to Previous Valid Index****When Receiving From** | If the mod box is spawned, it respawns as the previous valid entry in the list without triggering **On Box Destroyed**. If it is not spawned, that will be the next mod box. This setting does nothing if **Possible Mods** is not set to **Custom List** or if the device is disabled. |
| **Cycle to Next Valid Index****When Receiving From** | If the mod box is spawned, it respawns as the next valid entry in the list without triggering **On Box Destroyed**. If it is not spawned, that will be the next mod box. This setting does nothing if **Possible Mods** is not set to **Custom List** or if the device is disabled. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Box Spawn Send Event To** | Triggers an event when the mod box spawns. |
| **On Box Destroyed Send Event To** | Triggers an event when the mod box is destroyed regardless of whether a mod was applied, sending the vehicle's driver as the instigator if applicable. |
| **On Mod Applied Send Event To** | Triggers an event when the mod is applied to the vehicle, sending the vehicle's driver as the instigator if applicable. |
| **On Mod Failed to Apply Send Event To** | Triggers an event when the mod fails to apply to a vehicle, sending the vehicle's driver as the instigator if applicable. |
| **On No Mod  Send Event To** | Triggers an event when the device reaches a No Mod entry in a custom list, sending the vehicle's driver as the instigator if applicable. |
