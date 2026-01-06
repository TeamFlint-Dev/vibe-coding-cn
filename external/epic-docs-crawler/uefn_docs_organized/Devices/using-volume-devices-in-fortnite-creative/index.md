# Volume Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:38:20.350416

---

Have you ever wanted to trigger specific devices or events for a whole area of your island? The **Volume** device is designed to help you do that. As a customizable and nestable [volume](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#volume), you can size and place multiple volumes that can trigger events or functions when a player, vehicle, creature, wildlife animal, or guard enters or leaves that volume.

There are lots of ways to use this device, but they work particularly well with the **Fixed Point Camera**, **Fixed Angle Camera**, and **Third Person Controls** devices. See [Designing with Cameras and Controls](https://dev.epicgames.com/documentation/en-us/fortnite/designing-with-cameras-and-controls-in-fortnite-creative) for more examples for how to use this device with camera and controls devices.

**Looking for a spark of creative freedom?** See **[Down But Not Out Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/down-but-not-out-device-design-examples-in-fortnite-creative)** to liberate your imagination!

To find the Volume device, go to the Content Browser and select the **Devices** category. From there you can search or browse for the device. For more information on finding devices see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Device Options

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Visible in Game** | On, **Off** | Determines whether the volume is visible during the game. |
| **Selected Team** | **Any**, Pick or enter a team | Determines which team is affected by the volume. |
| **Invert Team Selection** | On, **Off** | Determines if all teams except the selected team are affected by the volume. |
| **Selected Class** | **Any**, Pick or enter a class | Determines which class is affected by the volume. |
| **Invert Class Selection** | On, **Off** | Determines if all classes except the selected class are affected by the volume. |
| **Volume Shape** | **Box**, *Cylinder*, *Sphere* | Determines the shape of the volume.  When you select either **Cylinde**r or **Sphere**, the **Volume Radius** option becomes available. |
| **Volume Width** | **1.0**, Pick or enter an amount | Determines the width of the volume, in tiles. |
| **Volume Depth** | **1.0**, Pick or enter an amount | Determines the depth of the volume, in tiles. |
| **Volume Height** | **1.0**, Pick or enter an amount | Determines the height of the volume, in tiles. |
| **Volume Radius** | **1.0**, Pick or enter an amount | This option is only available if the **Volume Shape** option is set to **Cylinder** or **Sphere**. Determines the radius of the volume, in tiles. |
| **Player Events Enabled** | **On**, Off | Determines if players trigger enter and exit events. |
| **Vehicle Events Enabled** | **On**, Off | Determines if vehicles trigger enter and exit events. |
| **External Volume** | **None**, Select an external volume | Provides a way to use a volume other than the default volume. |
| **Creature and Wildlife Events Enabled** | **On**, Off | Determines if creatures and wildlife trigger enter and exit events. |
| **Guard Events Enabled** | **On**, Off | Determines if guards trigger enter and exit events. |

### Additional UEFN Options

When you use this device in UEFN, additional user options are available.

| Option | Value | Description |
| --- | --- | --- |
| **Custom Volume Mesh** | Select a volume mesh | Assigns a custom mesh for the volume to use, rather than a shape. |

### Physics-Enabled Options

The following options become available when the [Physics](https://dev.epicgames.com/documentation/en-us/fortnite/physics) feature is enabled in a project:

| Option | Value | Description |
| --- | --- | --- |
| **Physics Events Enabled** | **On**, Off | Determines whether the volume triggered physics entered and exit events. |

## Direct Event Binding

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding)  allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the functions and events for this device.

### Functions

This device has no functions.

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function. In UEFN, events are not editable. In Creative, follow these steps to set an event.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the device to a function for that device.
3. If more than one device is affected by the event, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Enter Send Event To** | When a valid entity enters the volume, an event is sent to the selected device, which triggers the selected function. |
| **On Exit Send Event To** | When a valid entity exits the volume, an event is sent to the selected device, which triggers the selected function. |
| **On Physics Enter** | When a physics prop enters the volume, an event is sent to the selected device, which triggers the selected function. |
| **On Physics Exit** | When a physics prop exits the volume, an event is sent to the selected device, which triggers the selected function. |

## Using Volume Devices In Verse

You can use the code below to control a Volume device in Verse. This code shows how to use events and functions in the Volume device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Simulation }

# A Verse-authored creative device that can be placed in a level
volume_device_verse_example := class(creative_device):
    
    # Reference to the Volume device in the level.
    # In the Details panel for this Verse device,
    # set this property to your Volume device.
    @editable
    MyVolumeDevice:volume_device = volume_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        # Example for subscribing to an event on the Creative device.
        # Signaled when an agent enters the Volume.
        MyVolumeDevice.AgentEntersEvent.Subscribe(OnAgentEntered)

        # Example for subscribing to an event on the Creative device.
        # Signaled when an agent exits the Volume.
        MyVolumeDevice.AgentExitsEvent.Subscribe(OnAgentExited)
  
    # This function runs when an agent enters the Volume because it's an event handler for AgentEntersEvent.
    OnAgentEntered(Agent:agent):void=
        Print("Agent entered the volume.")

    # This function runs when an agent exites the Volume because it's an event handler for AgentExitsEvent.
    OnAgentExited(Agent:agent):void=
        Print("Agent exited the volume.")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a Volume device onto your island.
2. Create a new Verse device named **volume\_device\_verse\_example**. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) for steps.
3. In Visual Studio Code, open **volume\_device\_verse\_example.verse** in Visual Studio Code and paste the code above.
4. Compile your code and drag your Verse-authored device onto your island. See [Adding Your Verse Device to Your Level](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite#adding-your-verse-device-to-your-level) for steps.
5. Add a reference for the Volume device on your island to your Verse device. See [Adding a Verse Reference to a Creative Device in Your Level](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite#adding-your-verse-device-to-your-level) for steps.
6. Save your project and click **Launch Session** to playtest.

### Volume Device Verse API

See the [`volume_device` API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/volume_device) for more information on using the Volume device in Verse.
