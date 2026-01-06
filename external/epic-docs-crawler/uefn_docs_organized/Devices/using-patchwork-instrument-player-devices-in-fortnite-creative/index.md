# Instrument Player

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-instrument-player-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:05:57.123884

---

The **Instrument Player (I-PLAY)** device provides a wide sound palette, incorporating acoustic instruments and other sounds that would be hard to simulate with a [synthesizer](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#synthesizer).

Like the [Drum Player](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-drum-player-devices-in-fortnite-creative), the Instrument Player is an [audio generator](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#audio-generator) that converts note data input into audio data using a bank of [samples](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#sample). It allows you to make big, quick changes to sound output by switching from one instrument to another.

## Device Controls

[![Instrument Player callouts](https://dev.epicgames.com/community/api/documentation/image/e472ae5e-5093-459c-a79d-c3623a35b661?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e472ae5e-5093-459c-a79d-c3623a35b661?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When disabled, the device does not produce any audio and the signal chain ends. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Audio Out Cable** | N/A | Connect the Audio Out cable to a teal Audio In port. |
| **4. Volume Knob** | **1**, 0-10 | Control loudness of audio output. |
| **5. Vibrato Rate Carousel** | 1 Bar, ½ Note, ¼ Note, **⅛ Note**, 1/16 Note, 1/32 Note, 1/64 Note | Sets the oscillation rate of Vibrato when the Vibrato knob is set to a value greater than 0. |
| **6. Detune Knob** | default **0**, -12 to 12 | Sets the scale of a constant pitch offset of the audio output. |
| **7. Vibrato Knob** | default **0**, 0 to 1 | Sets the scale of an oscillating pitch offset of the audio output. |
| **8. Instrument Carousel** | **Piano**, Flute, Organ, Upright Bass, Vibraphone, Elec Piano, Baritone Sax, Strings, Pizzicato, Horns, Guitar Clean, Kalimba, Glocken | Selects which instrument sound will be applied to the audio output. |
| **9. Note In Port** | N/A | Can only receive a yellow **Note In** cable. |

## Device Options

In Create mode, walk up to the device and press **E** to open the Customize panel. Some device options mirror the controls you can manipulate with the Patchwork tool. They are present so that you can use the event binding system to trigger changes to how those controls behave, although you can choose to change them here instead of using the knobs. The **Allow Cable Access** option can only be modified using the Customize panel.

| Option | Values | Description |
| --- | --- | --- |
| **Volume** | **1**, Pick or enter a number | Determines the loudness of the Instrument Player's audio output. |
| **Instrument** | **Piano**, Flute, Organ, Upright Bass, Vibraphone, Elec Piano, Baritone Sax, Strings, Pizzicato, Horns, Guitar Clean, Kalimba | Determines what instrument sound is applied to the audio output. |
| **Detune** | **0.0**, Pick or enter a number | Sets the scale of a constant pitch offset of the audio output. |
| **Vibrato** | **0**, Pick a value between 0-1 | Sets the scale of an oscillating pitch offset of the audio output. |
| **Vibrato Rate** | 1 Bar, ½ Note, ¼ Note, **⅛ Note**, 1/16 Note, 1/32 Note, 1/64 Note | Sets the oscillation rate of Vibrato when the Vibrato knob is set to a value greater than 0. |
| **Allow Cable Access** | **On**, Off | Determines if the Patchwork Tool can access any cable input or output ports on the device. |

## VFX Preview

The VFX preview for the Instrument Player gives you a sense of the audio emitting from the device. Visuals change based on the selected sample.

[![Preview VFX gif](https://dev.epicgames.com/community/api/documentation/image/6341c09b-7e4c-43e5-a06e-aa790d999bad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6341c09b-7e4c-43e5-a06e-aa790d999bad?resizing_type=fit)

## Import and Play Custom Samples with UEFN

Using UEFN, you can import custom audio samples and create a Fusion patch to use as a custom instrument for this device!

[![Samples library](https://dev.epicgames.com/community/api/documentation/image/a9bf058e-5d95-469f-9db0-ca44efe7b0fa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9bf058e-5d95-469f-9db0-ca44efe7b0fa?resizing_type=fit)

This opens up a world of possibilities:

- Make your own instruments: you can map samples across a range of notes to create a full musical scale from a limited set of sounds. In this example video, audio files for six bass guitar notes were used to create a custom instrument that can play a full musical scale.
- Upload longer samples, like vocal clips or even full songs, starting the sample when a specific note is played. This allows the Instrument Player to function like an audio bank, triggering sounds when you play a certain note. In this video example, an audio file of a synthesizer melody is mapped to a single note, allowing for a longer imported recording to be synced to Patchwork audio.

### Loading Samples

To load your own samples into the Instrument Player device:

1. Open **Unreal Editor for Fortnite** and select your project.
2. Inside your UEFN project, create an **Audio** folder in the Content Library.

   [![Audio folder](https://dev.epicgames.com/community/api/documentation/image/3662800a-52d6-40a8-b263-1b019ccfa8d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3662800a-52d6-40a8-b263-1b019ccfa8d7?resizing_type=fit)
3. Select your audio samples and drag them into the **Audio** folder, or right-click and select **Import to**, then choose your audio samples. They will appear as **Sound Wave** assets. Sound Wave assets can be created from **.wav**, **.aif**, **.flac**, and **.ogg** files.

   [![Samples](https://dev.epicgames.com/community/api/documentation/image/6bb4fd75-3d2d-4fa9-9b73-010299afda95?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6bb4fd75-3d2d-4fa9-9b73-010299afda95?resizing_type=fit)
4. Select all the Sound Wave assets, right-click on one of them and select **Edit**.
5. Change the **Sound Asset Compression Type** to **PCM**.

   [![PCM](https://dev.epicgames.com/community/api/documentation/image/6e1bfc9e-68eb-4b11-aa84-42ba1845ce1b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e1bfc9e-68eb-4b11-aa84-42ba1845ce1b?resizing_type=fit)
6. Select all the assets again, right-click on one of them and select **Create Fusion Patch**.

   [![Fusion Patch](https://dev.epicgames.com/community/api/documentation/image/f6ed91d2-8e47-4497-b74a-27c6610d15f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f6ed91d2-8e47-4497-b74a-27c6610d15f5?resizing_type=fit)
7. Configure the Fusion Patch settings for your custom instrument and click **OK**.

   [![Fusion settings](https://dev.epicgames.com/community/api/documentation/image/eb80fc35-3adc-40b7-b256-5abffb3307f1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb80fc35-3adc-40b7-b256-5abffb3307f1?resizing_type=fit)
8. Select an **Instrument Player** device.
9. In the **Details** panel under **Advanced**, check the box for **Custom Instrument**, then assign the Fusion Patch you created.

   [![Custom Instrument](https://dev.epicgames.com/community/api/documentation/image/1fd3dee2-6430-4223-9ef7-b4cd6a84905e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1fd3dee2-6430-4223-9ef7-b4cd6a84905e?resizing_type=fit)

When an Instrument Player uses a custom instrument, the Instrument Select carousel does not display.

### Multiple Sound Wave Assets

You can add multiple Sound Wave assets to your Fusion Patch:

- When making a custom instrument, give each asset a **Root Note** as well as a **Min/Max** note range. If you do this, the Instrument Player will play your sound for all notes in the range, adjusting its pitch relative to the Root Note if needed.
- If you want to play a sound only at its original pitch, set its **Min**, **Root**, and **Max Note** to the same value.

### Pro Tips

- When using the Instrument Player to trigger samples with single notes, make sure any Note Sequencers providing input have their **Chromatic** user option set to **On**. This will ensure that the Note Sequencer outputs all possible notes you might use to trigger your samples.
- Extend the **sustain length** of the note on the Note Sequencer so it plays for the full length of the sample. If needed, you can also extend the **Length** of the Note Sequencer grid or slow down its **Step Rate** for even longer sample durations.
- To make sure the Instrument Player's vibrato control works for a custom Fusion Patch, edit the **LFO: 1** settings on the Fusion Patch. Set **Target** to **Pitch** and **Is Enabled** to **True**. If these are not set, the Vibrato control will have no effect.

[![LFO: 1 Settings](https://dev.epicgames.com/community/api/documentation/image/74dfa295-9513-44dc-8cae-e634d1fa0a8b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/74dfa295-9513-44dc-8cae-e634d1fa0a8b?resizing_type=fit)

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | The device is enabled when an event occurs. |
| **Disable When Receiving From** | The device is disabled when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Enabled Send Event To** | When this device is enabled, an event is sent to the linked device. |
| **On Disabled Send Event To** | When this device is disabled, an event is sent to the linked device. |

## Using Instrument Player in Verse

You can use the code below to control a Instrument Player device in Verse. This code uses all features of the Instrument Player device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level

instrument_player_example := class(creative_device):

    @editable

    InstrumentPlayer:patchwork_instrument_player_device = patchwork_instrument_player_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        

        Sleep(5.0)

        InstrumentPlayer.Disable()

        Print("Device Disabled")

        Sleep(5.0)

        InstrumentPlayer.Enable()

        Print("Device Enabled")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a Instrument Player device onto your island.
2. Create a new Verse device named **instrument\_player\_example**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).
3. Open Verse Explorer and double-click **instrument\_player\_example.verse** to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the Verse-authored device onto your island.
5. Select your Verse device in the **Outliner**.
6. In the device's **Details** panel, assign the object reference for the InstrumentPlayer to the instrument player device on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
7. Save your project and click **Launch Session**.

### Instrument Player API

See the `instrument_player_device` API Reference for more information on using the instrument player device in Verse.

## Patch Ideas

Try patching the Instrument Player into the Echo Effect or the Distortion Effect to add texture to your sound.

[![Echo Effect](https://dev.epicgames.com/community/api/documentation/image/9fe53df2-535a-4aed-b983-b8b9299565f8?resizing_type=fit&width=640&height=640)

Echo Effect

This device takes in an audio signal and sends it out again, but with a time delay, like your voice echoing in a canyon.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-echo-effect-devices-in-fortnite-creative)[![Distortion Effect](https://dev.epicgames.com/community/api/documentation/image/fe26526b-54d6-4832-8114-6deb1f7f1a00?resizing_type=fit&width=640&height=640)

Distortion Effect

Use this audio-shaping tool that results in sounds typical of genres like electronic, rock, and metal.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-distortion-effect-devices-in-fortnite-creative)

Patch the Instrument player into the Speaker to hear the result of the Patchwork chain.

[![Speaker](https://dev.epicgames.com/community/api/documentation/image/780e06d4-572a-4000-93e3-84c4dc6d6fa2?resizing_type=fit&width=640&height=640)

Speaker

Use the Patchwork Speaker device to play the Patchwork audio you create, either at a specific location or across the entire island.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-speaker-devices-in-fortnite-creative)
