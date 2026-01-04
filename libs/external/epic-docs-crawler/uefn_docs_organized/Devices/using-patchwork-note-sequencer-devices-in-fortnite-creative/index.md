# Note Sequencer

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-sequencer-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:05:12.205185

---

The **Note Sequencer (N-SEQR)** is a device that you can use to place notes on a grid to create a looping pattern. It is an easy way to start the device chain that results in audio.

You can specify the notes that you want to hear, or randomize the [note grid](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) before connecting this sequencer to an [audio generator](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) device and then into an [output](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) device to hear the result.

## Device Options

All of the settings that can be manipulated with the Patchwork Tool can also be adjusted using the **Customize** panel in Create mode, or using the **Details** panel in UEFN.

[![Note Sequence device diagram](https://dev.epicgames.com/community/api/documentation/image/46238b43-8be9-4adc-a888-2a01988cab57?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/46238b43-8be9-4adc-a888-2a01988cab57?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When Disabled, no note data is generated. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Note Out Cable** | N/A | The Note Out cable needs to be connected to a yellow Note In port. |
| **4. Auto Page** | **On**, Off | Toggles whether the sequencer cycles through every populated page, or remains on the current page only. Whenever Auto-Page is turned on, the sequencer will be synced with the global timeline as if they both started at the same time. When you make changes to the Sequencer that would put them out of sync, Auto-Page will automatically turn off. Turn Auto-Page on again to restore the sync. |
| **5. Page Status Display** | N/A | The filled circle shows which pages have content, and the green outline shows the page currently being played. |
| **6. Page Knob** | **1** - 8 | Select which page is played and displayed on the Note Grid. Each page can contain its own pattern of notes. |
| **7. Length Knob** | 1 - 16 | Number of steps per page in the sequence. |
| **8. Octave Knob** | 0 - 6 | Sets the octave for all the notes in the sequence. |
| **9. Downbeat Indicator** | N/A | Shows the first beat in every measure. They change position if Triplet style is selected. |
| **10. Note Grid** | N/A | Area where the users make their note selections. For more details, see [Note Grid](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-sequencer-devices-in-fortnite-creative). |
| **11. Duplicate Page** | N/A | Copies current grid contents onto the next available blank page. If no pages are blank, this button is disabled. |
| **12. Clear** | N/A | Remove all notes from the grid on the current page. |
| **13. Random** | N/A | Places notes randomly on the current page. It can help you overcome writer’s block and get inspired! Note that Random will replace all grid content with a new random pattern. |
| **14. Rate Carousel** | Whole Note, 1/2 Note, 1/4 Note, **1/8 Note**, 1/16 Note, 1/32 Note, 1/64 Note | Sets the speed at which the Note Sequencer moves through steps. |
| **15. Style Carousel** | **Straight**, Triplet, Dotted | Sets the timing modifier for the selected rate. Straight will divide the pulse by halves, Triplet will divide the pulse by thirds, and Dotted will create a more syncopated feel. This can change where the downbeat indicator appears above the grid. |

### Other Device Options

In Edit mode, walk up to the device and press **E** to reveal the device options. The options below can only be adjusted in the Customize panel in Creative, or the Details panel in UEFN.

| Option | Values | Description |
| --- | --- | --- |
| **Looping** | **On**, Off | When set to **Off**, the sequencer will play through its pattern once when enabled, then return to its disabled state. |
| **Auto-Page plays Blank Pages** | Enabled, **Disabled** | When enabled, Auto-Page will include blank pages in the automatic sequential playing of the pages. |
| **Grid Height** | 4-13, default **8** | Change the vertical height of the grid so that more or fewer notes are available. |
| **Monophonic** | **On**, Off | When set to Off, allows multiple notes to be placed on the same step of the Note Grid. Use this when sending output to polyphonic devices like the Instrument Player, which can play multiple notes at the same time. Monophonic devices like the Omega Synth can only play one note at a time. |
| **Chromatic** | On, **Off** | When set to On, allows semitones to be placed on the Note Grid. Semitones are a smaller musical interval. |
| **Allow Cable Access** | Off, **On** | Determines if cable connections to the device can be modified using the Patchwork tool. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. Pre-Game includes all phases prior to the game starting. |

## Note Grid

The note grid is where you select the specific pitches you want to hear played at the end of the chain. Target and select notes to toggle them On and Off.

Note names are displayed on the left side of the grid. They will change when you change the [key](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) using the [Music Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-sequencer-devices-in-fortnite-creative) device.

[![Note Sequencer device](https://dev.epicgames.com/community/api/documentation/image/95bb9026-d97e-4771-a1cb-b91bf40a2cd0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/95bb9026-d97e-4771-a1cb-b91bf40a2cd0?resizing_type=fit)

When set to **On**, a note plays its [pitch](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) as the [playhead](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-sequencer-devices-in-fortnite-creative) passes the [step](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) it’s on and lasts for the duration set by the number of cells the note is [sustained](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-sequencer-devices-in-fortnite-creative) over.

Point to the grid, and click the note you want to activate. It will play every time the playhead passes over it.

![](https://dev.epicgames.com/community/api/documentation/image/363caca7-637f-4e26-9a0a-1500c5f00df8?resizing_type=fit)

Toggle Notes On and Off

You can **click** and **drag** the note across two or more grid columns to achieve a **Sustain** effect. Drag to the onset of the next note or to the edge of the grid, if there are no other notes in that row.

[![Gif of player making sustained note](https://dev.epicgames.com/community/api/documentation/image/7e698ef6-53d9-4244-9e6d-4bf244aa1c58?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e698ef6-53d9-4244-9e6d-4bf244aa1c58?resizing_type=fit)

## VFX Preview

The VFX preview for the Note Sequencer shows:

- The current grid length
- Which grid steps contain notes
- Which grid steps are currently active

[![Preview VFX gif](https://dev.epicgames.com/community/api/documentation/image/8c85ed94-5c1c-4393-8217-734400d63c3c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c85ed94-5c1c-4393-8217-734400d63c3c?resizing_type=fit)

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | The device is enabled when an event occurs. |
| **Disable When Receiving From** | The device is disabled when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Enabled Send Event To** | When this device is enabled, an event is sent to the linked device, triggering the selected function. |
| **On Disabled Send Event To** | When this device is disabled, an event is sent to the linked device, triggering the selected function. |

## Using Note Sequencer in Verse

You can use the code below to control a Note Sequencer device using Verse. This code uses all features of the Note Sequencer device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level

note_sequencer_example := class(creative_device):

    @editable

    NoteSequencer:patchwork_note_sequencer_device = patchwork_note_sequencer_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        Sleep(5.0)

        NoteSequencer.Disable()

        Print("Device Disabled")

        Sleep(5.0)

        NoteSequencer.Enable()

        Print("Device Enabled")
```

To use this code in your UEFN experience, follow these steps:

1. Drag a **Note Sequencer** device onto your island.
2. Create a new Verse device named **note\_sequencer\_example**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse).
3. Open Verse Explorer and double-click **note\_sequencer\_example.verse** to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the Verse-authored device onto your island.
5. Select your Verse device in the **Outliner**.
6. In the device’s **Details** panel, assign the object reference for the NoteSequencer to the Note Sequencer device on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
7. Save your project and click **Launch Session**.

### Note Sequencer API

See the `note_sequencer_device` API Reference for more information on using the Note Sequencer device in Verse.

## Patch Ideas

Try patching the Note Sequencer to any of the following devices!

Patch a Note Sequencer to the inputs on these devices to turn your note inputs into audio.

[![Instrument Player](https://dev.epicgames.com/community/api/documentation/image/400c75be-0d90-4616-8f07-6bab3c33a705?resizing_type=fit&width=640&height=640)

Instrument Player

The Instrument Player device gives you a selection of instruments for playing melodic content.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-instrument-player-devices-in-fortnite-creative)[![Omega Synthesizer](https://dev.epicgames.com/community/api/documentation/image/cd4b37b9-039d-46b5-9f57-931644136443?resizing_type=fit&width=640&height=640)

Omega Synthesizer

The Omega Synthesizer device allows you to turn note inputs into audio data.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-omega-synthesizer-devices-in-fortnite-creative)

Patch a Note Sequencer to the input on a Note Trigger to activate Events when certain notes are played.

[![Note Trigger](https://dev.epicgames.com/community/api/documentation/image/bed80978-d8b0-4531-9993-e515995660d3?resizing_type=fit&width=640&height=640)

Note Trigger

The Note Trigger relays signals to other Creative/UEFN devices each time a particular note is played.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-trigger-devices-in-fortnite-creative)

Patch a Note Sequencer to the input on a Progressor to transpose your sequences in a chord progression.

[![Note Progressor](https://dev.epicgames.com/community/api/documentation/image/a71f7792-e484-4468-a835-3fb2108bf5b5?resizing_type=fit&width=640&height=640)

Note Progressor

The Note Progressor transposes a note pattern to a different key or follows a user-specified chord progression.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-progressor-devices-in-fortnite-creative)
