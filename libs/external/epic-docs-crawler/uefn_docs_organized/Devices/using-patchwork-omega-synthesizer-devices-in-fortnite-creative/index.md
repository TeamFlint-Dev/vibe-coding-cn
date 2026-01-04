# Omega Synthesizer

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-omega-synthesizer-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:04:12.256649

---

The **Omega Synthesizer (O-SYN)** device is an [audio generator](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#audio-generator) that converts note data from a [note generator](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#note-generator) like the [Patchwork Note Sequencer](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#patchwork-note-sequencer) into audio data. That data can then be sent to an [audio effect](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#audio-effect) device for further manipulation, or to an output device like a [Patchwork Speaker](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#patchwork-speaker) so players can hear it.

The Omega Synth has many presets that sound good out of the box, and gives you the ability to tweak the knobs yourself to get the sound you're looking for!

## Device Options

All of the settings that can be manipulated with the Patchwork Tool can also be adjusted using the Customize panel in Create mode, or using the Details panel in UEFN.

[![Omega Synth Callouts](https://dev.epicgames.com/community/api/documentation/image/abb93e35-65fb-4d87-8bda-aaace34fddbe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/abb93e35-65fb-4d87-8bda-aaace34fddbe?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Device Enabled Switch** | **On**, Off | When Off, the synth does not produce any audio and the signal chain ends. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Audio Out Cable** | N/A | The Audio Out cable needs to be connected to a teal Audio In port. |
| **4. Volume Knob** | 0.00 - 2.00, default **1.00** | Set the volume of the synth output. |
| **5. Presets Toggle** | **On**, Off | When the Preset carousel is toggled On, the knob values on the expanded panel are set to the preset values. These will override previous values. |
| **6. Sync Knob** | Values: 0.00-1.00, default **0.50** | Adjusts the degree of synchronization between oscillators. |
| **7. Resonance Knob** | Values: 0.00-1.00, default **0.50** | Sets the size of the bump to the frequencies around the filter cutoff. |
| **8. Glide Knob** | 0.00-1.00, default **0.50** | Determines how long it takes to blend to a new pitch. |
| **9. Tone Knob** | 0.00-1.00, default **0.70** | Blends the wave pattern between square, saw, and [detuned](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#detune) dual saw waves. |
| **10. Bite Knob** | 0.00-1.00, default **0.50** | Sets filter envelope amount. |
| **11. Overdrive Knob** | 0.00-1.00, default **0.20** | Sets the amount of distortion applied to the signal. |
| **12. Presets Carousel** | Various | Selects a collection of knob settings to achieve a specific sound. |
| **13. Note In Port** | N/A | Can only receive a yellow **Note Out** cable. This device is monophonic, meaning it can only play one note at a time even if you create multiple simultaneous note inputs. However, you can use multiple Omega Synth devices to simulate a polyphonic sound. |

### Other Device Options

In Create mode, walk up to the device and press **E** to reveal the device options. The options below can only be adjusted in the Customize panel in Creative, or the Details panel in UEFN.

| Option | Values | Description |
| --- | --- | --- |
| **Allow Cable Access** | **On**, Off | Determines if the Patchwork Tool can access any cable input or output ports on the device. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. **Pre-Game** includes all phases that occur prior to the game starting (Waiting for players in the lobby, Featured Islands, and the Game Start Countdown). |

## VFX Preview

The VFX preview for the Omega Synthesizer gives you a sense of the audio emitting from the device. It can show the difference between harsh and buzzy sounds and smooth gliding ones.

[![Preview VFX gif](https://dev.epicgames.com/community/api/documentation/image/26986a4b-a16e-42b0-89a0-fa9570e35a72?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26986a4b-a16e-42b0-89a0-fa9570e35a72?resizing_type=fit)

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

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

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Enabled Send Event To** | When this device is enabled, an event is sent to the linked device, triggering the selected function. |
| **On Disabled Send Event To** | When this device is disabled, an event is sent to the linked device, triggering the selected function. |

## Using Omega Synthesizer in Verse

You can use the code below to control an Omega Synthesizer device in Verse. This code uses all features of the Omega Synthesizer device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level

omega_synthesizer_example := class(creative_device):

    @editable

    OmegaSynthesizer:patchwork_omega_synthesizer_device = patchwork_omega_synthesizer_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        

        Sleep(5.0)

        OmegaSynthesizer.Disable()

        Print("Device Disabled")

        Sleep(5.0)

        OmegaSynthesizer.Enable()

        Print("Device Enabled")
```

To use this code in your UEFN experience, follow these steps.

1. Drag an Omega Synthesizer device onto your island.
2. Create a new Verse device named **omega\_synthesizer\_example**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse).
3. Open Verse Explorer and double-click **omega\_synthesizer\_example.verse** to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the Verse-authored device onto your island.
5. Select your Verse device in the **Outliner**.
6. In the device’s **Details** panel, assign the object reference for the OmegaSynthesizer to the Omega Synthesizer device on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
7. Save your project and click **Launch Session**.

### Omega Synthesizer API

See the `omega_synthesizer_device` API Reference for more information on using the Omega Synthesizer device in Verse.

## Patch Ideas

Try connecting the Omega Synthesizer to any of these devices!

[![Echo Effect](https://dev.epicgames.com/community/api/documentation/image/9fe53df2-535a-4aed-b983-b8b9299565f8?resizing_type=fit&width=640&height=640)

Echo Effect

This device takes in an audio signal and sends it out again, but with a time delay, like your voice echoing in a canyon.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-echo-effect-devices-in-fortnite-creative)[![Distortion Effect](https://dev.epicgames.com/community/api/documentation/image/fe26526b-54d6-4832-8114-6deb1f7f1a00?resizing_type=fit&width=640&height=640)

Distortion Effect

Use this audio-shaping tool that results in sounds typical of genres like electronic, rock, and metal.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-distortion-effect-devices-in-fortnite-creative)[![Speaker](https://dev.epicgames.com/community/api/documentation/image/780e06d4-572a-4000-93e3-84c4dc6d6fa2?resizing_type=fit&width=640&height=640)

Speaker

Use the Patchwork Speaker device to play the Patchwork audio you create, either at a specific location or across the entire island.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-speaker-devices-in-fortnite-creative)
