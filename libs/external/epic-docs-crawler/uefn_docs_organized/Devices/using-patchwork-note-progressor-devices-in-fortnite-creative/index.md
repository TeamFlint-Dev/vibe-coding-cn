# Note Progressor

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-progressor-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:05:04.870999

---

The **Note Progressor (N-PRG)** device is a way to make your note sequences follow a chosen [chord progression](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#chord-progression). You can also use it to change keys while staying in the scale of the [Music Manager](using-patchwork-music-manager-devices-in-fortnite-creative), creating conventionally pleasing chord progressions.

When active, the device indicates which chord in the progression is currently playing. Each knob has 14 settings, accounting for transposition both up and down. These values are shown in Roman numerals.

## Device Options

[![Note Progressor callouts](https://dev.epicgames.com/community/api/documentation/image/da183130-9f82-4411-a21e-fdf3409046ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da183130-9f82-4411-a21e-fdf3409046ef?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When Disabled, no note data is generated. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Note Out Cable** | N/A | Connect the **Note Out** cable to a yellow **Note In** port. |
| **4. Preset Progression Carousel** | Various | Cycle through preset progressions. When you change the carousel value, the Transposition Knobs jump to the settings of that preset. Note that some presets are marked with Maj (Major) or Min (Minor) because they are traditionally used with this scale. Check the Key Mode carousel on the Patchwork [Music Manager](using-patchwork-music-manager-devices-in-fortnite-creative) to see which scale you’re using. |
| **5. Transposition Knobs 1 to 4** | ▼I, ▼II, ▼III, ▼IV, ▼V, ▼VI, ▼VII, I, ▲II, ▲III, ▲IV, ▲V, ▲VI, ▲VII, ▲I; default **I** | Indicates where the input note will be transposed based on the root note. |
| **6. Snap to Scale Toggle** | **On**, Off | When enabled, snap all incoming notes to the current scale, keeping all notes [diatonic](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#diatonic-scale). When disabled, allow non-diatonic notes to pass through. |
| **7. Global Toggle** | **On**, Off | When Global is on, all other Note Progressors with this toggle set to On will share the same settings. This makes it easy to change all Note Progressors set to Global to the same chord progression. |
| **8. Rate Carousel** | 1-4 Bars, default **1 Bar** | Indicates how many bars will play with each chord tone before progressing to the next. |
| **9. Note In Port** | N/A | Can only receive a yellow Note In cable. |

### Other Device Options

In Create mode, walk up to the device and press **E** to reveal the device options. The options below can only be modified using this method.

| Option | Values | Description |
| --- | --- | --- |
| **Allow Cable Access** | **On**, Off | Determines if the Patchwork Tool can access any cable input or output ports on the device. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled.   - Pre-Game includes all phases prior to the game starting (Waiting for players in the lobby, Featured Islands, and the Game Start Countdown). |

## VFX Preview

The VFX preview for the Note Progressor shows:

- How the device is transposing the incoming notes
- Where it is in the step sequence
- Each step shape indicator scaling up when active
- Each step position and active step remain visible when the device is disabled

[![Preview VFX gif](https://dev.epicgames.com/community/api/documentation/image/03cc9d19-199e-4cf5-8e2a-b739d4fbb612?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/03cc9d19-199e-4cf5-8e2a-b739d4fbb612?resizing_type=fit)

## Direct Event Binding System

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the functions and events for this device:

### Functions

| Option | Select Device | Select Event | Description |
| --- | --- | --- | --- |
| **Enable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | The device is enabled when an event occurs. If this device can be enabled by more than one event, click **Add** to add a line. |
| **Disable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | The device is disabled when an event occurs. If this device can be disabled by more than one event, click **Add** to add a line. |

### Events

| Option | Select Device | Select Function | Description |
| --- | --- | --- | --- |
| **On Enabled Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When this device is enabled, a signal is sent to the linked device. |
| **On Disabled Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When this device is disabled, a signal is sent to the linked device. |

You can use the code below to control a Note Progressor device in Verse. This code uses all features of the Note Progressor device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level

distortion_effect_example := class(creative_device):

    @editable

    NoteProgressor:patchwork_note_progressor_device = patchwork_note_progressor_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        

        Sleep(5.0)

        NoteProgressor.Disable()

        Print("Device Disabled")

        Sleep(5.0)

        NoteProgressor.Enable()

        Print("Device Enabled")
```

To use this code in your UEFN experience, follow these steps.

See the `note_progressor_device` API Reference for more information on using the Note Progressor device in Verse.

## Patch Ideas

Try patching the Note Sequencer into the Note Progressor to make more complex patterns.

[![Note Sequencer](https://dev.epicgames.com/community/api/documentation/image/152a0539-36fb-4215-9631-6736999bcbe6?resizing_type=fit&width=640&height=640)

Note Sequencer

The Note Sequencer device allows you to choose the notes you want to use in your compositions.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-sequencer-devices-in-fortnite-creative)

Try patching the Note Progressor into these devices to shape the sounds!

[![Omega Synthesizer](https://dev.epicgames.com/community/api/documentation/image/cd4b37b9-039d-46b5-9f57-931644136443?resizing_type=fit&width=640&height=640)

Omega Synthesizer

The Omega Synthesizer device allows you to turn note inputs into audio data.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-omega-synthesizer-devices-in-fortnite-creative)[![Instrument Player](https://dev.epicgames.com/community/api/documentation/image/400c75be-0d90-4616-8f07-6bab3c33a705?resizing_type=fit&width=640&height=640)

Instrument Player

The Instrument Player device gives you a selection of instruments for playing melodic content.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-instrument-player-devices-in-fortnite-creative)
