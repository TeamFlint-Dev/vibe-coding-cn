# Note Trigger

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-trigger-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:04:26.793493

---

The **Note Trigger (N-TRG)** device is a musical version of the [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative). It receives note input, and you can specify which notes will send events to other Fortnite Creative devices.

For example, you could patch the Note Trigger to a [Drum Sequencer](using-patchwork-drum-sequencer-devices-in-fortnite-creative), then bind it to a [Creature Spawner](using-creature-spawner-devices-in-fortnite-creative) that spawns a new creature on the beat, or patch it to a [Note Sequencer](using-patchwork-note-sequencer-devices-in-fortnite-creative) to trigger some barrels to explode every time C♯ is played.

## Device Options

[![Note Trigger callouts](https://dev.epicgames.com/community/api/documentation/image/183fc923-6dab-48f6-bbfb-dfdb87a64c8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/183fc923-6dab-48f6-bbfb-dfdb87a64c8c?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | Note data is always passed through this device unchanged. When Disabled, note data is passed through unchanged and no Events are sent. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Note Out Cable** | N/A | The Note Out cable needs to be connected to a yellow **Note In** port. |
| **4. Octave Carousel** | **All**, 0-6 | Select whether the device should be triggered by notes in any octave or in a specific octave. |
| **5. Drum Note Shape Label** | Shapes | When patching the Patchwork Drum Sequencer into the Note Trigger, these labels indicate which drum note shapes on the Drum Sequencer correspond to which notes. |
| **6. Note Select Button** | Any number of notes. Default: **No Notes** | Users can select each button and toggle it to be active/inactive. When a note is set to its active state, the device will send a message when it receives that note as input. |
| **7. Note In Port** | N/A | Can only receive a yellow **Note In** cable. |

### Device Options in the Customize Panel

In [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode), walk up to the device and press **E** to open the **Customize** panel. Some device options mirror the controls you can manipulate with the Patchwork tool. They are present so that you can use the event binding system to trigger changes to how those controls behave, although you can choose to change them here instead of using the knobs. You can also modify the options below using the Details panel in UEFN.

| Option | Values | Description |
| --- | --- | --- |
| **Allow Cable Access** | **On**, Off | Determines if the Patchwork Tool can access any cable input or output ports on the device. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. Pre-Game includes all phases prior to the game starting. |

## VFX Preview

The VFX preview for the Note Sequencer shows when an input triggers an event.

[![Preview VFX gif](https://dev.epicgames.com/community/api/documentation/image/48718156-4bf4-4d0d-bd5e-68f5442e2d34?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48718156-4bf4-4d0d-bd5e-68f5442e2d34?resizing_type=fit)

## Direct Event Binding System

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the functions and events for this device:

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | The device is enabled when an event occurs. |
| **Disable When Receiving From** | The device is disabled when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Enabled Send Event To** | When this device is enabled, an event is sent to the linked device. |
| **On Disabled Send Event To** | When this device is disabled, an event is sent to the linked device. |
| **When Note On Received Transmit On** | Sends an event when a selected note input begins playing. |
| **When Note Off Received Transmit On** | Sends an event when a selected note input stops playing. This occurs after any sustain applied to the note. |

## Using Note Trigger in Verse

You can use the code below to control a Note Trigger device in Verse. This code uses all features of the Note Trigger device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level

note_trigger_example := class(creative_device):

    @editable

    NoteTrigger:patchwork_note_trigger_device = patchwork_note_trigger_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        

        Sleep(5.0)

        NoteTrigger.Disable()

        Print("Device Disabled")

        Sleep(5.0)

        NoteTrigger.Enable()

        Print("Device Enabled")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a Note Trigger device onto your island.
2. Create a new Verse device named **note\_trigger\_example**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse).
3. Open Verse Explorer and double-click **note\_trigger\_example.verse** to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the Verse-authored device onto your island.
5. Select your Verse device in the **Outliner**.
6. In the device's **Details** panel, assign the object reference for the Note Trigger to the Note Trigger device on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
7. Save your project and click **Launch Session**.

### Note Trigger API

See the `note_trigger_device` API Reference for more information on using the Note Trigger device in Verse.

## Patch Ideas

Try patching the Note Sequencer to the Note Trigger to control when the triggers are activated.

[![Note Sequencer](https://dev.epicgames.com/community/api/documentation/image/152a0539-36fb-4215-9631-6736999bcbe6?resizing_type=fit&width=640&height=640)

Note Sequencer

The Note Sequencer device allows you to choose the notes you want to use in your compositions.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-sequencer-devices-in-fortnite-creative)

Try patching the Note Trigger device to these audio generators!

[![Drum Player](https://dev.epicgames.com/community/api/documentation/image/b8cf7066-0ea5-4468-a0e3-a3180258e9ec?resizing_type=fit&width=640&height=640)

Drum Player

Use the Drum Player device to play different drum sounds for your music setup.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-drum-player-devices-in-fortnite-creative)[![Instrument Player](https://dev.epicgames.com/community/api/documentation/image/400c75be-0d90-4616-8f07-6bab3c33a705?resizing_type=fit&width=640&height=640)

Instrument Player

The Instrument Player device gives you a selection of instruments for playing melodic content.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-instrument-player-devices-in-fortnite-creative)
