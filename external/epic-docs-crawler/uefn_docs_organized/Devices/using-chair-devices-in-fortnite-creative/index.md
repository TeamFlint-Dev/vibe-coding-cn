# Chair Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-chair-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:29:13.586099

---

The **Chair** device provides a way to place and keep players in a seated position, limiting or changing their ability to move the camera so you can focus the player's view on something specific.

Ways you can use this in your islands include:

- Cinemas
- Concerts or other virtual events
- Terminal/PC interactions
- Restaurants
- Roller coasters or other rides

The device has multiple chair types available, and chairs can also be set to invisible.

If you are using the Chair device in a [UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) project, you can also set the **Chair Model** option to **Custom**, and use a custom [mesh](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#mesh) and [material](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#material) for your chair.

To find the Chair device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature reduces clutter in the Customize panel and makes options easier to manage and navigate. However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Chair Model** | Invisible, Comfy Chair, Barstool, Barrel, Stone, **Basic**, Custom | Determines the appearance of the chair. Note: **Custom** is only usable if you are using UEFN; it is not usable in Creative. |
| **Interact Time** | Do Not Interact**,** ***Instant***, Pick or enter an amount of time | Determines the amount of time the player must hold the interaction control before they sit down in the chair. When set to the default, or when you set an interaction time, two additional options display. If you select **Do Not Interact**, those options don't display. |
| **Interact Radius** | **Don't Override**, Pick a radius | This determines how far away a player can be and still interact with the device, as measured in meters. |
| **Interact Angle** | **45**, Pick an angle | This determines the angle of space, anchored at a device. A player must be in this angle of space to interact with the device. If this is set to its maximum of 180 degrees, that you can interact with the chair from any direction. |
| **Activating Team** | **Any**, Pick a team | Determines which team can activate the device. |
| **Invert Team Selection** | On, **Off** | If set to **On**, all teams can activate the device except the team selected in the **Activating Team** option. This is **Off** by default. |
| **Allowed Class** | No Class, **Any**, Pick a class | Determines which classes can activate the device. |
| **Invert Class Selection** | On, **Off** | If set to **On**, all classes can activate the device except the class selected in the **Activating Class** option. This is **Off** by default. |
| **Enabled During Game** | **On**, Off | Determines whether the device is enabled when the game starts. Disabled devices ignore all events except for **Enable**. |
| **Player Exit Enabled** | **On**, Off | Determines whether players can exit the chair on their own. |
| **Camera Collision** | On, **Off** | Determines whether the chair will block the camera for players sitting in it. If the chair is invisible, camera collision is disabled for everything within a 40 cm radius from the seating position. |
| **Play Seated Audio** | **On**, Off | Determines whether an audio effect is played for entering and exiting the chair. |
| **Interact Text** | **Sit**, Enter text | Determines the text players will see on the interaction prompt for the chair. The text field has a character limit of 150. |
| **Dismount Direction** | Forward, Backward, Left, Right, Enter Direction, **Camera Facing** | Determines the direction the player is launched when dismounting the chair.  If set to Enter Direction, this determines the direction which players entered the chair.  If set to Camera Facing, players are launched in the direction of the character's camera is currently facing. This option is limited to the interaction angle of the chair. |
| **Dismount Force** | 500 cm/s, Select a force amount | Determines the force with which the character launched when dismounting the chair, in the direction specified by Dismount Direction. |
| **Dismount Upwards Force** | 250 cm/s, Select an upwards force amount | Determines the force with which the character launched when dismounting the chair, directly upwards. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. When disabled, the chair will not receive players and any player seated in the chair when disabled will be ejected. |
| **Enable Player Exit When Receiving From** | When an event occurs, it enables players to exit the chair whenever they want. |
| **Disable Player Exit When Receiving From** | When an event occurs, the players can't exit the chair themselves. |
| **Seat Player When Receiving From** | Seats the player in the chair when an event occurs. |
| **Eject Player When Receiving From** | Removes the player from the chair when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the Chair to a function for the selected device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Player Seated Send Event** | When a player sits in the chair, an event is sent to the selected device, which triggers the selected function. |
| **On Player Exited Send Event** | When the player exits the chair, an event is sent to the selected device, which triggers the selected function. |

## Using a Chair Device in Verse

You can use the code below to control a Chair device in [Verse](https://dev.epicgames.com/documentation/en-us/uefn/learn-programming-with-verse-in-unreal-editor-for-fortnite). This code shows how to use events and functions in the **Chair Device API**. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /UnrealEngine.com/Temporary/Diagnostics }

using { /Verse.org/Simulation }

using { /Verse.org/Random }

# A Verse-authored creative device that can be placed in a level

chair_device_verse_example := class(creative_device):

    # Reference to the Chair device in the level.

    # In the Details panel for this Verse device,

    # set this property to your Chair device.

    @editable

    MyChairDevice:chair_device = chair_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        # Example for subscribing to an event on the Creative device.

        # Signaled when an agent sits on the Chair.

        MyChairDevice.SeatedEvent.Subscribe(OnAgentSeated)

        # If the Chair is occupied by someone, eject them from the chair.

        if:

            MyChairDevice.IsOccupied[]

        then:

            MaybeAgent := MyChairDevice.GetSeatedAgent()

            if (Agent := MaybeAgent?):

                MyChairDevice.Eject(Agent)

        # Grab a random player in the game and seat them in the Chair now that it's guaranteed to be empty.

        Players := GetPlayspace().GetPlayers()

        RandomIndex := GetRandomInt(0, Players.Length - 1)

        if (RandomPlayer := Players[RandomIndex]):

            MyChairDevice.Seat(RandomPlayer)

    # This function runs when an agent is seated in the Chair because it's an event handler for SeatedEvent.

    OnAgentSeated(Agent:agent):void=

        Print("Agent seated in Chair")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a Chair device onto your island.
2. Create a new Verse device named **chair\_device\_verse\_example**. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse#creatinganewdevicewithverse) for steps.
3. In Visual Studio Code (VSC), open **chair\_device\_verse\_example.verse** and paste the code into this file.
4. Compile your code and drag your Verse-authored device onto your island. See [Adding Your Verse Device to Your Level](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse#addingyourversedevicetoyourlevel) for steps.
5. Add a reference for the Chair device on your island to your Verse device. See [Adding a Verse Reference to a Creative Device in Your Level](https://dev.epicgames.com/documentation/en-us/uefn/customize-verse-device-properties-in-verse#addingaversereferencetoacreativedeviceinyourlevel) for steps.
6. Save your project and click **Launch Session** to playtest.

### Chair Device Verse API

See the [`chair_device` API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/chair_device) for more information on using the Chair device in Verse.
