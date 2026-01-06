# Drum Sequencer

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-drum-sequencer-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:04:39.568727

---

The **Drum Sequencer (D-SEQR)** device lets you place notes on a grid to create a looping pattern. You can create a sequence of up to five different notes per step, or choose from preset drum patterns.

Connect this sequencer to an audio generator device like the Patchwork Drum Sequencer then into a speaker device to hear the results. It is the start of a [device chain](https://dev.epicgames.com/documentation/en-us/fortnite/device-chain) that results in audio output.

## Device Options

[![Drum Sequencer callouts](https://dev.epicgames.com/community/api/documentation/image/16b7b313-a73e-491c-aa13-bdebfa54a3ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/16b7b313-a73e-491c-aa13-bdebfa54a3ac?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When disabled, the device does not output audio data. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Note Out Cable** | N/A | Connect the Note Out cable to a yellow Note In port. |
| **4. Auto Page** | **On**, Off | Toggles whether output should loop through all pages or current page only. Whenever Auto-Page is turned on, the sequencer will be synced with the global timeline as if they both started at the same time. When you make changes to the Sequencer that would put them out of sync, Auto-Page will automatically turn off. Turn Auto-Page on again to restore the sync. |
| **5. Page Status Display** | N/A | The filled circle shows which pages have content, and the green outline shows the page currently played. |
| **6. Page Knob** | **1** - 8 | Select which page is played and displayed on the grid. Each page can contain its own pattern of notes. |
| **7. Note Shape Buttons** | Shapes | Press a button to choose which note you want when placing notes into the grid. |
| **8. Note Grid** | N/A | A grid of squares where each square represents a single step of the device output. Selecting a square in the grid will toggle the selected note shape in that square. Clicking and dragging over the grid places or removes multiple notes of the selected shape. The grid layout will change to reflect your Triplet Timing setting and the current time signature set on the Patchwork Music Manager. |
| **9. Triplet Timing Toggle** | **Off**, On | Selects the rate of the sequencer output. When this toggle is off, the sequencer will output notes at a 1/16 note rate. When on, the sequencer will output notes in a shuffle feel at a 1/8 note triplet rate. The toggle is disabled when the time signature is not 4/4. |
| **10. Duplicate Page** | N/A | Copies current grid contents onto the next available blank page. If no pages are blank, this button is disabled. |
| **11. Clear** | N/A | Remove all notes from the grid on the current page. |
| **12. Presets Carousel** | Techno, Reggaeton, Soca, Bossa Nova, Neo Soul, Big Beat, Miami Bass. Default: **Random** | Choose from a small selection of common beat patterns to auto-populate the sequencer grid. If you edit the grid, the Preset toggle switches to Off. |
| **13. Presets Toggle** | **Off**, On | While off, the Presets Carousel can still cycled without affecting the grid. When the Preset toggle is switched back on, the selected Preset content replaces the current grid. Using the Page Knob to change to a blank page will also toggle the Preset off. |

### Other Device Options

In Create mode, walk up to the device and press **E** to open the Customize panel. Some device options mirror the controls you can manipulate with the Patchwork tool. They are present so that you can use the event binding system to trigger changes to how those controls behave, although you can choose to change them here instead of using the knobs. The **Allow Cable Access** option can only be modified using the Customize panel.

| Option | Values | Description |
| --- | --- | --- |
| **Looping Toggle** | **Off**, On | If turned off, when the device is enabled, the sequence automatically plays from the beginning, then disables itself when complete. |
| **Auto-Page plays Blank Pages** | Enabled, **Disabled** | When enabled, Auto-Page will include blank pages in the automatic sequential playing of the pages. |
| **Allow Cable Access** | **On**, Off | Determines if the Patchwork Tool can access any cable input or output ports on the device. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. Pre-Game includes all phases prior to the game starting. |

## Note Grid

The [note grid](https://dev.epicgames.com/documentation/en-us/fortnite/note-grid) is where you select the specific notes you want to play. On the right side, select a note from the column on the right, then target and select grid squares to toggle them On and Off.

Click and drag over the grid to place or remove multiple notes of the selected shape.

## VFX Preview

The VFX preview for the Drum Sequencer shows:

- Each of the sequencer steps
- Which of the steps have content
- The sequencer's progression through the steps

[![Preview VFX gif](https://dev.epicgames.com/community/api/documentation/image/42f431b6-6fae-47e7-8f5d-ed384f7ba57d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42f431b6-6fae-47e7-8f5d-ed384f7ba57d?resizing_type=fit)

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-with-direct-event-binding-in-fortnite-creative) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/function) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | The device is enabled when an event occurs. |
| **Disable When Receiving From** | The device is disabled when an event occurs. |

### Events

An event tells another device when to perform a function.

1. For any [event](https://dev.epicgames.com/documentation/en-us/fortnite/event), click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Enabled Send Event To** | When this device is enabled, an event is sent to the linked device. |
| **On Disabled Send Event To** | When this device is disabled, an event is sent to the linked device. |

## Patch Ideas

Try connecting the Drum Sequencer to any of these devices!

[![Drum Player](https://dev.epicgames.com/community/api/documentation/image/b8cf7066-0ea5-4468-a0e3-a3180258e9ec?resizing_type=fit&width=640&height=640)

Drum Player

Use the Drum Player device to play different drum sounds for your music setup.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-drum-player-devices-in-fortnite-creative)[![Note Progressor](https://dev.epicgames.com/community/api/documentation/image/a71f7792-e484-4468-a835-3fb2108bf5b5?resizing_type=fit&width=640&height=640)

Note Progressor

The Note Progressor transposes a note pattern to a different key or follows a user-specified chord progression.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-progressor-devices-in-fortnite-creative)

## Using Drum Sequencer in Verse

### Drum Sequencer API
