# Song Sync

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-song-sync-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:04:57.602650

---

The **Song Sync (S-SYNC)** device allows you to play songs from other sources and synchronize them with Patchwork devices. Working in Unreal Editor for Fortnite, you can sync a level sequence to the imported sound data. When you import MIDI files into the device, you can generate Patchwork note data output to control other audio or events!

**Possible uses:**

- Set up a virtual concert with pre-recorded audio, then use Patchwork to control the timing of audiovisual effects in sync with that audio.
- Build musical gameplay experiences ranging from rhythm action, like Fortnite Festival, to platformers where hazards and enemies move to the music, or racing games where the song you select changes the track layout, and more!
- Play a pre-recorded vocal track and mix live Patchwork audio with it.

The video below gives a preview of possibilities when using the Song Sync device:

## Device Options

[![Song Sync device](https://dev.epicgames.com/community/api/documentation/image/2c37a8a7-13cd-4285-815a-660602ac82e2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2c37a8a7-13cd-4285-815a-660602ac82e2?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When disabled, the device does not play content or output note data. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Note Out Cable** | N/A | Connect the Note Out cable to a yellow Note In port. |
| **4. Playback Time Counter** | N/A | Shows the current playback time and the total time for the displayed MIDI asset, Level Sequence, or synced device. |
| **5. Linked Song Syncs icon** | N/A | Indicates if any other Song Sync devices are linked to this one. There are 2 possible states:   - Disabled state: No icon shown. This device is not linked to any other Song Syncs.  [link-disabled](https://dev.epicgames.com/community/api/documentation/image/d3c6507f-56a5-4bcd-86f2-072c79c10408?resizing_type=fit) - Enabled state: White link icon shown. This device is linked to other Song Syncs. When it is played/stopped, linked devices will also play/stop.  [link-enabled](https://dev.epicgames.com/community/api/documentation/image/367b4b68-ec75-47cb-bd38-770d879bea13?resizing_type=fit) |
| **6. Controls Tempo icon** | N/A | Indicates whether the Controls Tempo Play Behavior is selected. There are 4 possible states:   - Disabled state: No icon shown. This device will never try to control the tempo.  [Disabled State](https://dev.epicgames.com/community/api/documentation/image/d5175c28-4fde-492f-9349-0d65d97630e9?resizing_type=fit) - Enabled state: White tempo icon shown. This device is not playing, but will try to control the tempo when played.  [Enabled State](https://dev.epicgames.com/community/api/documentation/image/7713d9c1-9d89-46a5-bf00-472ee9c5810a?resizing_type=fit) - Active state: Green tempo icon shown. This device is currently playing and controlling the tempo.  [Active State](https://dev.epicgames.com/community/api/documentation/image/70be82df-4074-4ebd-aa20-9c1c09ea3477?resizing_type=fit) - Blocked state: Red tempo icon shown. This device is currently playing and is set to control the tempo, but can't because another device has control.  [Blocked State](https://dev.epicgames.com/community/api/documentation/image/be56c22b-43b7-47a4-85df-7803092250ec?resizing_type=fit) |
| **7. Sync Target display** | N/A | If you’ve selected a MIDI asset for the device, its name is shown here. If not, the name of the longest Level Sequence or synced device is shown. |
| **8. Stop Button** | N/A | End output of selected track. Disabled until playback begins. |
| **9. Play Button** | N/A | Begins playback of any MIDI file and Sync Targets. Disabled if neither MIDI nor Sync Targets are defined. |

### UEFN Editor Options

The options appear in the UEFN Editor only, and you can choose which assets should play in sync when this device is played.

| Option | Description |
| --- | --- |
| **MIDI File** | Select a MIDI asset in your UEFN project to be played by the device. For details on how to set up and use MIDI data, see [MIDI Files](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-song-sync-devices-in-fortnite-creative) below. |
| **Level Sequence** | Select a Level Sequence in your UEFN project to be played by the device. |
| **Synced Devices** | Select any number of other Song Sync devices to be played by the device. Triggering **Play** or **Stop** on a Song Sync device, whether with the Patchwork Tool or Event System, will also play or stop all devices in this list. |

### Other Device Options

The options below can be modified in the UEFN editor, but you can also modify them in Create mode by walking up to the device and pressing **E** to reveal the device options.

| Option | Values | Description |
| --- | --- | --- |
| **Play Behavior** | **Control Tempo**, Play from Start, Play from Current Time | - When a Song Sync device is set to Control Tempo, playing it will restart the Patchwork timeline. While playing, the device will control the Patchwork tempo and disable the Music Manager Tempo knob. - If a MIDI file has been selected, the device will set the Patchwork tempo based on the MIDI file’s tempo map. If no MIDI file is selected, or if the MIDI file has no tempo map, the device will lock Patchwork to the Music Manger’s current tempo for the duration of its play time. - If a second Song Sync device set to Control Tempo is played when another Song Sync device already has control, the second device behaves as if it is set to Play from Start instead. - When set to **Play from Start**, when this device is played, its Sync Targets will start at the beginning of their timeline when played. - When set to **Play from Current Time**, when this device is played, its Sync Targets will start at a position in their timeline based on the current Patchwork timeline. That is, the Sync Targets position will be set as though the Song Sync had started at the same time as the device that is currently controlling the Patchwork tempo, then looped continuously. |
| **Playback Delay** | None, **Next Beat**, Next Bar | When this device is played, this option determines if it starts immediately or if it waits to play on a selected [quantized](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quantize) interval. |
| **Looping** | **None**, On MIDI Length, On Sequence Length | Determines whether the playback loops. The loop length must be based on either a MIDI file or a Level Sequence. If "Control Tempo" is selected for the Play Behavior user option, the global timeline will reset each time the playback loops on this device. |
| **MIDI track** | N/A | Lets you select a track within the chosen MIDI file. |
| **MIDI Beat Offset** | **Default: 0** | Allows for notes to be delivered early/late in musical time, to enable gameplay akin to a Fortnite Festival target appearing on the note highway before it needs to be played. Offsets only affect the Note output from the device. |
| **MIDI Millisecond Offset** | **Default: 0** | The same as Beat Offset, but useful in cases where real time is more relevant than musical time. |
| **MIDI Starting Time** | **Default: 0** | Sets the starting point for MIDI playback in seconds. Any Sync Targets will have their starting points adjusted to match. |
| **Allow Cable Access** | **On**, Off | Determines if the Patchwork Tool can access any cable input or output ports on the device. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. |

The following video shows you the steps needed to play your custom audio using the Song Sync device:

## Playback Delay

Playback Delay is essentially the concept of **quantization** in music. It is like snapping notes to the beat. If a note is played a little early or late, quantization moves it to the nearest beat or rhythm spot, making the timing more exact. It helps the music sound more on time and organized.

With **Playback Delay** set to **None** and **Play Behavior** set to **Play from Start**, pressing Play on the Song Sync device will result in the sample starting at the exact moment the button is pressed, regardless of the measure count on the global timeline:

[![No quantization](https://dev.epicgames.com/community/api/documentation/image/8d216062-39d0-4f17-9c46-653ee86f04c6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8d216062-39d0-4f17-9c46-653ee86f04c6?resizing_type=fit)

With **Playback Delay** set to **Next Beat** and **Play Behavior** set to **Control Tempo**, pressing Play will only start the sample at the start of the next beat. The **Control Tempo** setting will restart the measure count:

[![Quantized](https://dev.epicgames.com/community/api/documentation/image/3e3b2af5-4438-4378-8198-a5a4bea1ab73?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e3b2af5-4438-4378-8198-a5a4bea1ab73?resizing_type=fit)

## Looping

Looping determines whether the sample and/or MIDI file loaded into your Song Sync device will restart from the beginning after it finishes playing.

With **Looping** set to **On MIDI Length** and **Play Behavior** set to **Control Tempo**, the length of the MIDI file loaded into the device will determine where the device loops. The **Control Tempo** setting will restart the measure count:

[![looping MIDI](https://dev.epicgames.com/community/api/documentation/image/c292e224-039c-4e63-a32e-ccbf7a1b9f06?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c292e224-039c-4e63-a32e-ccbf7a1b9f06?resizing_type=fit)

With **Looping** set to **On Sequence Length** and **Play Behavior** set to **Control Tempo**, the length of the Level Sequence synced to the device will determine where the device loops:

[![looping sequence](https://dev.epicgames.com/community/api/documentation/image/b6e03c0c-9fc2-4ca3-8ec1-774dc5caf066?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6e03c0c-9fc2-4ca3-8ec1-774dc5caf066?resizing_type=fit)

The following video illustrates how quantization and looping work in the context of a real musical sample:

## MIDI Files

The Song Sync device allows you to import and play MIDI files as though you were using the [Patchwork Note Sequencer](using-patchwork-note-sequencer-devices-in-fortnite-creative). Using the Note Out cable, you can patch Song Sync to an [Instrument Player](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-instrument-player-devices-in-fortnite-creative) or an [Omega Synthesizer](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-omega-synthesizer-devices-in-fortnite-creative) to play the MIDI notes using Patchwork! You can also patch Song Sync output to a [Note Trigger](using-patchwork-note-trigger-devices-in-fortnite-creative) to drive Events timed to your MIDI data.

Be aware that some Digital Audio Workstations (DAWs) do not add a Tempo Map when exporting MIDI files. A MIDI file without a Tempo Map cannot control the tempo of Patchwork devices.

The following video takes a deeper dive into using the Song Sync device with a MIDI file:

When a Song Sync device **Play Behavior** is set to **Control Tempo**, it can use a MIDI file tempo map to determine the Patchwork tempo. The minimum Patchwork tempo is 60 BPM and the maximum is 180 BPM. Tempo values outside of that range will be clamped.

MIDI files can also change the Patchwork key and mode. To do this, open your MIDI file editor and add a text event in the following format at the MIDI time where you’d like the change to happen:

- `key KEY_NAME MODE_NAME`

Sharps are denoted with #, and flats with b. Currently, only major and minor modes are supported. Some example text events:

- `key F# minor`
- `key Bb major`

## Direct Event Binding System

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the functions and events for this device:

### Functions

| Option | Select Device | Select Event | Description |
| --- | --- | --- | --- |
| **Play** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | The device is played when an event occurs. If this device can be enabled by more than one event, click **Add** to add a line. |
| **Stop** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | The device is stopped when an event occurs. If this device can be enabled by more than one event, click **Add** to add a line. |
| **Enable** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | The device is enabled when an event occurs. If this device can be enabled by more than one event, click **Add** to add a line. |
| **Disable** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | The device is disabled when an event occurs. If this device can be disabled by more than one event, click **Add** to add a line. |

### Events

| Option | Select Device | Select Function | Description |
| --- | --- | --- | --- |
| **On Played** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When this device is played, a signal is sent to the linked device. This Event occurs \_after \_any delay set in the Playback Delay user option. |
| **On Stopped** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When this device is stopped, a signal is sent to the linked device. |
| **On Playback Initiated** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When the playback is initiated, a signal is sent to the linked device. This can be triggered by direct user interaction or by this device receiving a Play event. This Event occurs \_before \_any delay set in the Playback Delay user option. |
| **On Enabled** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When this device is enabled, a signal is sent to the linked device. |
| **On Disabled** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When this device is disabled, a signal is sent to the linked device. |

## Using Song Sync in Verse

You can use the code below to control a Song Sync device in Verse. This code uses all features of the Song Sync device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Devices/Patchwork }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level

song_sync_example := class(creative_device):

    @editable

    SongSync:song_sync_device = song_sync_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

       
        Sleep(5.0)

        SongSync.Disable()

        Print("Device Disabled")

        Sleep(5.0)

        SongSync.Enable()

        Print("Device Enabled")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a drum sequencer device onto your island.
2. Create a new Verse device named **song\_sync\_example**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse).
3. Open Verse Explorer and double-click **song\_sync\_example.verse** to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the Verse-authored device onto your island.
5. Select your Verse device in the **Outliner**.
6. In the device’s **Details** panel, assign the object reference for the DrumSequencer to the drum sequencer device on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
7. Save your project and click **Launch Session**.

### Song Sequencer API

See the `song_sync_device` API Reference for more information on using the drum sequencer device in Verse.
