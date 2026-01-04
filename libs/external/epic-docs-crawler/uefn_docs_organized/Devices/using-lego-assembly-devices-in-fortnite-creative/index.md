# Assembly Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-lego-assembly-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:28:14.156966

---

Block out time to build with the LEGO® **Assembly** device to create configurations where players can build and disassemble props in your LEGO Islands with the press of a single button! Set up the interaction radius on this device to turn prop pieces it covers into holograms for players to assemble.

The LEGO®  Assembly device does not work with objects made with the LEGO Brick Editor.

Through Verse, you can even set up props for players to disassemble. Design a world where players will never have to worry about stepping on Lego bricks as they watch their builds neatly fall into place. Enjoy the bricks raining down!

With the Assembly device, you can even hide props and dynamically turn off their collision to create progression-based building mechanics.

You can only assemble LEGO brick props with this device, though all props can be temporarily hidden.

Fully engulf players in your buildable simulations by configuring [audio](using-speaker-devices-in-fortnite-creative) and [visual effects](using-vfx-spawner-devices-in-fortnite-creative) to signify a completed build. You can even use [cinematic](https://dev.epicgames.com/documentation/en-us/uefn/making-cinematics-and-cutscenes-in-unreal-editor-for-fortnite) cutscenes in your interactions.

Use this device to create tycoon-styled gameplays where players can collect currencies and unlock quests by assembling props. You can also customize settings to create events that trigger after successfully completing a build. Test out this device in the [LEGO Home Builder](https://dev.epicgames.com/documentation/en-us/fortnite/build-lego-home-builder-in-fortnite) template as you combine both LEGO and Fortnite assets to create new environments.

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [**Event Browser**](event-browser-in-fortnite-creative).

## Device Access

The Assembly device is available in LEGO Islands for Fortnite Creative and Unreal Editor for Fortnite (UEFN).

You can find the device in the following locations:

- **Creative: Creative Menu > Content > LEGO® Content > Devices > Assembly Device**
- **UEFN: Content Drawer > LEGO® Content > Devices > Assembly Device**

To learn the fundamentals of how to access, place, and adjust settings for a device, see [Using Devices](using-devices-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the **Customize** panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering. If an option is hidden or displayed based on a specific value, there will be a note about it in the Description field for that option in the table below.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Selection Radius** | **100.0**, Enter an amount | Actors within the selection radius are assembled and disassembled by the device. |
| **Assembly Time** | **1.0s**, Enter an amount | The time it takes to assemble and disassemble a prop. Measured in seconds. |
| **Held Interaction** | *True*, **False** | Determines if assembling or disassembling is a continuous action or single click. **True** stops the assemble or disassemble when a player releases the input key. |
| **Held Interaction Reset** | True, **False** | Determines if build progress is reset when the interaction is interrupted. This option is only available when **Held Interaction** is set to **True**. |
| **Collison** | **Always On**, Off if Disassembled | Determines how to handle [collision](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) of an actor when the device is disassembled.   - **Always On:** Collision is active when a prop is assembled and disassembled. - **Off if Disassembled:** No collision if the prop is fully disassembled. When partially assembled, collision is active. - **On if Assembled:** Collison is active when the prop is fully assembled. |
| **Enabled During Phase** | None, Always, Pre-Game Only, **Gameplay Only** | Determines the game phase the device is enabled in. A disabled device can not be directly interacted with but responds to events. |
| **Selection Volume Shape** | **Sphere**, Select a static mesh | Sets the static mesh to use for detecting what objects this device will affect. |
| **Start Game Assembled** | True, **False** | Determines the state the device starts the game in. |
| **Show Hologram** | **True**, False | Determines if a preview of the fully assembled actors while disassembled. |
| **Preview Material** | **M\_VFX\_PreviewHologram**, Select a material | Sets the material to use for the unassembled preview hologram. |

## Direct Event Binding

The following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

To create or edit a function, follow these steps:

1. Open the device settings, and click a function option.
2. Click **ADD**, then click **Select** **Device** to access and select from the **Device** dropdown menu.
3. Click **Select Event** to bind the device to an event that triggers the function for the device.
4. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Functions | Description |
| --- | --- |
| **Enable** | Activates the device when receiving the set event. |
| **Disable** | Deactivates the device when receiving the set event. |
| **Reset** | Reverts the device to its initial state when an event occurs. |
| **Stop** | Pauses the assembling or disassembling of the device when receiving an event. |
| **Assemble** | Starts to assemble the prop when receiving the event. |
| **Disassemble** | Starts to disassemble the prop when receiving the event. |
| **Show Hologram** | Shows the hologram when receiving the event. |
| **Hide Hologram** | Hides the hologram when receiving the event. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

To create or edit an event, follow these steps:

1. Open the device settings, and click an event option.
2. Click **Add**, then **Select** **Device** to access and select from the **Device** dropdown menu.
3. Click **Select** **Function** to bind this event to a function for that device.
4. If more than one function is triggered by the event, click **Add** to add a line and repeat these steps.

| Events | Description |
| --- | --- |
| **On Enabled** | Sends an event to the linked devices when the Assembly device is active. |
| **On Disabled** | Sends an event to the linked devices when the Assembly device is deactivated. |
| **On Assembled** | Sends an event to the linked devices when the prop within the selection radius is fully assembled. |
| **On Disassembled** | Sends an event to the linked devices when the prop within the selection radius is fully disassembled. |

## Using LEGO Assembly Device In Verse

You can use the code below to control a LEGO Assembly device in Verse. This code uses features of the Assembly device API to hide, assemble, and disassemble props. You can modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level

HideThenBuild := class(creative_device):

    # Reference to the props in the level.
    # In the Details panel for this Verse device,
    # set this property to the props to hide.

    @editable
    HiddenProps:[]creative_prop = array{}

    # Reference to the Assembly device in the level.
    # In the Details panel for this Verse device,
    # set this property to your Assembly device.  
    @editable
    AssemblyDevice:assembly_device = assembly_device{}

    # Reference to a Button device in the level.
    # In the Details panel for this Verse device,
    # set this property to your Button device.
    @editable
    AssemblyButton:button_device = button_device{}

    # Reference to a Button device in the level.
    # In the Details panel for this Verse device,
    # set this property to your Button device.
    @editable
    DisassembleButton:button_device = button_device{}

    # Reference to the Sleep function in the code.
    # In the Details panel for this Verse device,
    # set this property to a numbered value.
    @editable
    WaitTime:float= 3.0

    # Runs at the start of the game to hide the initial hologram
    OnBegin<override>()<suspends>:void=
        AssemblyButton.InteractedWithEvent.Subscribe(OnButtonInteractedWith)
        DisassembleButton.InteractedWithEvent.Subscribe(OnDisassembleButtonInteractedWith)
        AssemblyDevice.Disable()
        AssemblyDevice.Assemble()

        # Hides the selected props 
        for:
            Prop:HiddenProps
        do:
            Prop.Hide()
        Sleep(1.0)
        AssemblyDevice.Pause()

    # Runs when the assemble button is interacted with
    OnButtonInteractedWith(InAgent:agent):void=

        # Shows props and assembles LEGO® bricks
        # Adjust the Assembly Time option in the Details panel to change the build rate
        for:
            Prop:HiddenProps
        do:
            Prop.Show()
        AssemblyDevice.Reset()
        AssemblyDevice.Assemble()

    # This function runs when the disassemble button is interacted with
    CallDisassembly()<suspends>:void=
        AssemblyDevice.Disassemble()

        #Stops the disassemble prior to it becoming a hologram
        #Sleep time may need to be adjusted depending on the value in Assembly Time
        Sleep(WaitTime)

        # Hides the selected props
        for:
            Prop:HiddenProps
        do:
            Prop.Hide()
        AssemblyDevice.Pause()
   

    # Runs when the disassemble button is interacted with
    OnDisassembleButtonInteractedWith(InAgent:agent):void=
        spawn:
            CallDisassembly()
```

To use this code in your LEGO Island, follow these steps:

1. In UEFN, drag an Assembly device onto your island.
2. Create a new Verse device named **assembly\_example\_device**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse).
3. Open Verse Explorer, and double-click **assembly\_example\_device.verse** to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the device onto your island.
5. In the **Content Drawer**, search and add the **Button** device to your island twice.

   1. Name one button "Assemble" and the other "Disassemble".
6. Select your Verse device in the **Outliner**.
7. In the device's **Details** panel, assign the object references for **Hide Then Build** to the Assembly device, buttons, and props on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
8. Save your project, and click **Launch Session**.

You can only view the Verse API for the Assembly device in the Verse [digest](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) file when you are in a LEGO Island because the device is only available for LEGO Islands.
