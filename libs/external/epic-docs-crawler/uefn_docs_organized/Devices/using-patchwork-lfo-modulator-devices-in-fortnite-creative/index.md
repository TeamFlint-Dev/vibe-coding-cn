# LFO Modulator

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-lfo-modulator-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:04:19.605824

---

Use the **Low-Frequency Oscillator (LFO)** Modulator to adjust or [modulate](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#modulation) another Patchwork device in a customized pattern and rate.

You can connect the LFO output to any visible input port on another Patchwork device. Because the LFO outputs a continuous value that changes over time, it's especially useful for turning a knob control to create repeating audio patterns.

## Device Options

[![Low Frequence Oscillator device diagram](https://dev.epicgames.com/community/api/documentation/image/8c1e6054-5e97-4eed-96bb-f7c3254d395b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c1e6054-5e97-4eed-96bb-f7c3254d395b?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When disabled, the targeted control is not modified. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Modulator Cable** | N/A | The Modulation cable should be patched to a control on another Patchwork device. |
| **4. MIN / MAX Knobs** | N/A | Sets the minimum and maximum value of the modulation for the selected [waveform](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#waveform). |
| **5. Waveform visualizer** | N/A | Shows the current waveform defined by device settings, with a moving indicator showing the current output value. |
| **6. Shape** | -1.0 - 1.0, default **0** | Modifies the modulation pattern of the selected waveform. |
| **7. Timing Style** | **Straight**, Triplet, Dotted | Selects the style for the chosen Step Rate, if the rate is not set to **Free**. **Straight** will divide the pulse by halves, **Triplet** will divide the pulse by thirds, and **Dotted** will create a more syncopated feel. |
| **8. Offset** | **0.0** - 1.0 | Sets a delay in the modulation timing after the beat. This knob appears on the device when Step Rate is set to any option other than **Free**. |
| **9. Waveform** | **Sine**, Triangle, Saw, Square, Random, Wobble | Adjust the [shape](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#shape) of the modulation pattern. |
| **10. Rate** | 32 Bars -1/64 Note plus Free, default **1/2 Note** | Sets the length of time for the LFO to output a cycle of the selected waveform. When set to **Free**, use the Speed control to define the time. |

### Other Device Options

In Create mode, walk up to the device and press **E** to reveal the device options. The options below can only be modified using this method.

| Option | Values | Description |
| --- | --- | --- |
| **Allow Cable Access** | **On**, Off | Determines if cable connections to the device can be modified. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled.   - Pre-Game includes all phases prior to the game starting (Waiting for players in the lobby, Featured Islands, and the Game Start Countdown). |

## Waveform

The waveform shows the selected wave pattern that affects the parameters the Patchwork control targets using the Modulator cable. The visualization updates to reflect changes you make to the device settings.

Setting the Waveform pattern changes the wave in the window.

Move the Minimum and Maximum knobs up and down to select the range for the wave form.

Setting the [step rate](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#step-rate) causes the output value indicator to move faster or slower.

## VFX Preview

[![LFO VFX](https://dev.epicgames.com/community/api/documentation/image/04b167d5-7a94-4249-8fcd-67a90c161760?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/04b167d5-7a94-4249-8fcd-67a90c161760?resizing_type=fit)

The VFX preview for the LFO modulator shows:

- The range of the output value, indicated by the highlighted area of the VFX.
- The current output value, indicated by the moving vertical line. When the vertical line is on the right side of the highlighted area, the LFO is outputting the current maximum value.

## Direct Event Binding System

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the functions and events for this device:

### Functions

| Option | Select Device | Select Event | Description |
| --- | --- | --- | --- |
| **Enable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | The device is enabled when an event occurs. If this device can be enabled by more than one event, click Add to add a line. |
| **Disable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | The device is disabled when an event occurs. If this device can be disabled by more than one event, click Add to add a line. |

### Events

| Option | Select Device | Select Event | Description |
| --- | --- | --- | --- |
| **On Enabled Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available devices. | When this device is enabled, a signal is sent to the linked device. |
| **On Disabled Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available devices. | When this device is disabled, a signal is sent to the linked device. |

## Using Low-Frequency Oscillator in Verse

You can use the code below to control a low-frequency oscillator device in Verse. This code uses all features of the low-frequency oscillator device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level

low_frequency_oscillator_modulator_example := class(creative_device):

    @editable

    LFOModulator:patchwork_lfo_modulator_device = patchwork_lfo_modulator_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        

        Sleep(5.0)

        LFOModulator.Disable()

        Print("Device Disabled")

        Sleep(5.0)

        LFOModulator.Enable()

        Print("Device Enabled")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a drum player device onto your island.
2. Create a new Verse device named low\_frequency\_oscillator\_modulator\_example. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse).
3. Open Verse Explorer and double-click low\_frequency\_oscillator\_modulator\_example.verse to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the Verse-authored device onto your island.
5. Select your Verse device in the Outliner.
6. In the device’s Details panel, assign the object reference for the LFOModulator to the low-frequency oscillator device on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
7. Save your project and click Launch Session.

### LFO Modulator API

See the `lfo_modulator_device` API Reference for more information on using the low-frequency oscillator device in Verse.

## Patch Ideas

Try connecting the Low-Frequency Oscillator to any of the following devices!

Try patching the LFO to the Volume knob to easily hear modulation in action as the sound fades in and out, or try it on the [Bite](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#bite) knob to hear how that control changes the synthesizer sound.

[![Omega Synthesizer](https://dev.epicgames.com/community/api/documentation/image/cd4b37b9-039d-46b5-9f57-931644136443?resizing_type=fit&width=640&height=640)

Omega Synthesizer

The Omega Synthesizer device allows you to turn note inputs into audio data.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-omega-synthesizer-devices-in-fortnite-creative)

Try patching the LFO to the [Tame](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#tame) knob to modulate which audio frequencies are filtered by distortion, which creates an effect known as a filter sweep.

[![Distortion Effect](https://dev.epicgames.com/community/api/documentation/image/fe26526b-54d6-4832-8114-6deb1f7f1a00?resizing_type=fit&width=640&height=640)

Distortion Effect

Use this audio-shaping tool that results in sounds typical of genres like electronic, rock, and metal.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-distortion-effect-devices-in-fortnite-creative)
