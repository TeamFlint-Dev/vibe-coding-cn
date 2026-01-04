# Vehicle Service Station Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-vehicle-service-station-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:45:41.935510

---

The **Vehicle Service Station** can automatically repair and refuel any vehicles that drive into the station. Players don't have to get out to interact with the station or use an item. You can determine how much fuel is provided and how quickly vehicle damage is repaired.

For help on how to find the [**Vehicle Service Station**] device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [**Event Browser**](event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Seconds Per Restore Tick** | **0.48 seconds**, Pick or enter a number | The device restores health or fuel in increments over time. This option determines the amount of time that passes between each increment of restoration. |
| **Heal Percentage Per Restore Tick** | **5%**, Pick or enter a percentage | Determines what percentage of vehicle health is restored for each restoration increment. |
| **Fuel Refill Percentage Per Restore Tick** | **5%**, Pick or enter a percentage | Determines what percentage of vehicle fuel is restored for each restoration increment. |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines which phases the device is enabled in. **Pre-Game** refers to all phases that occur before the game starts. |
| **Damageable** | ***Yes***, No | Determines whether the device can be damaged and destroyed. If this is set to **No**, the **Max Health** option does not display. |
| **Max Health** | **200**, Pick or enter an amount | If the vehicle service station can be damaged, this determines the maximum amount of health it has. |
| **Display Fuel Pump** | **Show**, Hide | Determines if the fuel pump part of the device is visible. |
| **Display Repair Pad** | **Show**, Hide | Determines if the repair pad part of the device is visible. |
| **Allowed Team** | **Any**, Pick or enter a team | Determines which team is able to use the vehicle service station. If you select **Any**, all players can use the vehicle service station. |
| **Allowed Class** | No Class, **Any**, Pick or enter a class | Determines which class is able to use the vehicle service station. If you select **No Class**, only players with no assigned class can use it. If you select **Any**, all players with an assigned class can use it. |
| **Invert Team Selection** | True, **False** | If this option is set to **True**, all teams except the one selected in the **Allowed Team** option can use the vehicle service station. |
| **Invert Class Selection** | True, **False** | If this option is set to **True**, all classes except the one selected in the **Allowed Class** option can use the vehicle service station. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** **dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Check Vehicle Inside When Receiving From** | This function checks whether a vehicle is inside the service station when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** **dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Vehicle Entered Send Event To** | When a vehicle enters the service station, an event is sent to the selected device. |
| **Vehicle Left Send Event To** | When a vehicle leaves the service station, an event is sent to the selected device. |
| **Vehicle Started Fueling Send Event To** | When a vehicle in the station receives the first increment of fuel, an event is sent to the selected device. |
| **Vehicle Started Repairing Send Event To** | When a vehicle in the station receives the first increment of repair, an event is sent to the selected device. |
| **Vehicle Stopped Fueling Send Event To** | When a vehicle in the station is refueled to the vehicle's maximum fuel, an event is sent to the selected device. |
| **Vehicle Stopped Repairing Send Event To** | When a vehicle in the station is repaired to the vehicle's maximum health, an event is sent to the selected device. |
| **Damaged Send Event To** | When the service station is damaged, an event is sent to the selected device. |
| **Destroyed Send Event To** | When the service station is destroyed, an event is sent to the selected device. |
| **Vehicle Is Inside Send Event To** | If a vehicle is inside the service station when the **Check Vehicle Inside When Receiving From** function is triggered, an event is sent to the selected device. |
| **Vehicle Is Not Inside Send Event To** | If a vehicle is not inside the service station when the **Check Vehicle Inside When Receiving From** function is triggered, an event is sent to the selected device. |
| **Vehicle Entered at Full Health Send Event To** | When a vehicle enters the service station with full health, an event is sent to the selected device. |
| **Vehicle Entered at Full Fuel Send Event To** | When a vehicle enters the service station with full fuel, an event is sent to the selected device. |
| **Vehicle Left Under Full Health Send Event To** | If a vehicle in the station leaves before its maximum health is restored, an event is sent to the selected device. |
| **Vehicle Left Under Full Fuel Send Event To** | If a vehicle in the station leaves before its maximum fuel is restored, an event is sent to the selected device. |
| **Vehicle Left Without Being Healed Send Event To** | If a vehicle in the station leaves before health restoration starts, an event is sent to the selected device. |
| **Vehicle Left Without Being Fueled Send Event To** | If a vehicle in the station leaves before fuel restoration starts, an event is sent to the selected device. |
