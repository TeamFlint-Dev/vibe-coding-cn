# Water Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-water-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:48:21.340117

---

You can use the **Water device** to create a body of water on your island that players can interact with. You can control the water level, and make it increase or decrease with triggered events.

The device creates water within a specific [volume](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#volume), which you can customize to create lakes, ponds, oceans, swimming pools, sewers, and so on. Players can swim in these bodies of water, or drive boats on them. You can also place [fishing zones](using-fishing-zone-devices-in-fortnite-creative) in these bodies of water so that players can fish.

For information on finding devices see [**Using Devices**](using-devices-in-fortnite-creative). To find the Water device in UEFN, open the Content Drawer and click **Fortnite > Devices > Environment**.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Device Options

This device has some basic functionality, like setting the size of the water volume, and how quickly the volume fills or empties. Additionally, there are some advanced options, like when the device is enabled, and whether it interacts with [Trigger devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative).

Default values are **bold**.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Enable During Phase** | None, All, Create Only, Game Countdown Only, **Gameplay Only** | Determines in which phases the water volume is enabled. |
| **Interact With Trigger** | **Off**, On | Determines whether the water interacts with the Trigger device. If you choose **Yes**, you can place Trigger devices in the water volume where they will be affected by the water level. You can then use the Trigger to initiate an event related to the water level. |
| **Zone Width** | **1.0**, Pick a size in tiles | Determines the width of the water volume, in [tiles](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#tile). |
| **Zone Depth** | **1.0**, Pick a size in tiles | Determines the depth of the water volume, in tiles. |
| **Zone Height** | **1.0**, Pick a size in tiles | Determines the height of the water volume, in tiles. |
| **Default Vertical Water Percentage** | **100.0**, Pick a percentage | Determines the default vertical water level as a percentage of the value set in the **Water Height** option. |
| **Vertical Filling Speed (T PM)** | **60.0**, Pick a speed | Determines the rate at which the volume fills with water. |
| **Vertical Emptying Speed (T PM)** | **60.0**, Pick a speed | Determines the rate at which the volume's water empties. |
| **Water Type** | **Default**, River Styx, Red River Styx | Determines what kind of water fills the volume. **River Styx** creates green water with a special effect. **Red River Styx** creates red water with a special effect. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Reset Water When Receiving From** | Resets the water level to its default percentage level when an event occurs. |
| **Resume Vertical Movement When Receiving From** | Resumes the last vertical movement of the water when an event occurs. |
| **Start Vertical Emptying When Receiving From** | Starts emptying the water level when an event occurs. |
| **Start Vertical Filling When Receiving From** | Starts filling the volume vertically with water when an event occurs. |
| **Stop Vertical Movement When Receiving From** | Stops the volume from filling or emptying further when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Player Entering Water Send Event To** | Sends an event to a linked device when a player enters the water. |
| **On Player Leaving Water Send Event To** | Sends an event to a linked device when a player enters the water. |
| **On Vertical Emptying Completed Send Event To** | Sends an event to a linked device when the water level reaches 0 percent. |
| **On Vertical Filling Completed Send Event To** | Sends an event to a linked device when the water level reaches 100 percent. |

## Device Design Examples That Use This Device

- [Grind Vine Device Example](https://dev.epicgames.com/documentation/en-us/fortnite/grind-vine-device-design-example-in-fortnite-creative)
