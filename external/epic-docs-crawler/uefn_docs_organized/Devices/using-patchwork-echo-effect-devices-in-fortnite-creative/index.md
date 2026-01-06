# Echo Effect

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-echo-effect-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:05:28.767961

---

The **Echo Effect (FX-ECHO)** device repeats the incoming audio signal at a specified [delay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [feedback](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) level. It is an optional part of the signal chain before the audio is sent to an [Output](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) device for players to actually hear it.

An echo can be used as a creative tool to produce an effect that changes the character of a sound. It can be used to fill out a thin synth sound, for instance, or to mimic familiar echo effects found in the world, like yelling into a canyon.

## Device Options

[![Echo Effects device diagram](https://dev.epicgames.com/community/api/documentation/image/3202d496-86f8-4afb-8b4b-8ba7a29556a4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3202d496-86f8-4afb-8b4b-8ba7a29556a4?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When disabled, the audio data is passed through without any effect applied. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Audio Out Cable** | N/A | The Audio Out cable should connect to a teal Audio In port on another device. |
| **4. Style Carousel** | **Straight**, Triplet, Dotted | Selects the style for the chosen Sync Timing. Straight will divide the pulse by halves, Triplet will divide the pulse by thirds, and Dotted will create a more syncopated feel. |
| **5. Mix Knob** | 0.00-1.00, default **0.5** | This determines how much of the audio output is **wet** (processed by the echo effect). At one extreme, no echo is output at all and only the input audio is heard. At the other extreme, 100% of the **dry** (unprocessed) audio and 100% of the processed audio is output. |
| **6. Filter Knob** | -1.00-1.00, default **0** | Filters the frequency of the delayed signal with a low-pass filter on the left and a high-pass filter on the right. |
| **7. Feedback Knob** | 0.00-0.99, default **0.5** | Sets the length of the delay. |
| **8. Delay Carousel** | 4 Bars, 2 Bars, 1 Bar, 1/2 Note, 1/4 Note, **1/8 Note**, 1/16 Note, 1/32 Note, 1/64 Note | Sets the time in musical increments that an echo is heard after the original source is played. |
| **9. Audio In Port** | N/A | The Audio In port needs to receive input from a teal Audio Out cable. |

### Other Device Options

In live edit, walk up to the device and press **E** to reveal the device options. The options below can only be modified using this method.

| Option | Values | Description |
| --- | --- | --- |
| **Allow Cable Access** | Off, **On** | Determines if cable connections to the device can be modified using the Patchwork tool. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled.   - Pre-Game includes all phases prior to the game starting (Waiting for players in the lobby, Featured Islands, and the Game Start Countdown). |

## VFX Preview

You can get a sense of the Echo parameters based on the VFX Preview:

[![Preview VFX gif](https://dev.epicgames.com/community/api/documentation/image/a588b794-0ac9-4be7-bfab-26e06df7cd4b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a588b794-0ac9-4be7-bfab-26e06df7cd4b?resizing_type=fit)

## Direct Event Binding System

**Direct event binding** allows devices to communicate directly. Below are the functions and events for this device:

### Functions

| Option | Select Device | Select Event | Description |
| --- | --- | --- | --- |
| **Enable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | The device is enabled when an event occurs. If this device can be enabled by more than one event, click Add to add a line. |
| **Disable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | The device is disabled when an event occurs. If this device can be disabled by more than one event, click Add to add a line. |

### Events

| Option | Select Device | Select Function | Description |
| --- | --- | --- | --- |
| **On Enabled Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When this device is enabled, a signal is sent to the linked device. |
| **On Disabled Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When this device is disabled, a signal is sent to the linked device. |

## Patch Ideas

Try patching the Echo to any of these devices!

[![Instrument Player](https://dev.epicgames.com/community/api/documentation/image/400c75be-0d90-4616-8f07-6bab3c33a705?resizing_type=fit&width=640&height=640)

Instrument Player

The Instrument Player device gives you a selection of instruments for playing melodic content.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-instrument-player-devices-in-fortnite-creative)[![Omega Synthesizer](https://dev.epicgames.com/community/api/documentation/image/cd4b37b9-039d-46b5-9f57-931644136443?resizing_type=fit&width=640&height=640)

Omega Synthesizer

The Omega Synthesizer device allows you to turn note inputs into audio data.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-omega-synthesizer-devices-in-fortnite-creative)[![Drum Player](https://dev.epicgames.com/community/api/documentation/image/b8cf7066-0ea5-4468-a0e3-a3180258e9ec?resizing_type=fit&width=640&height=640)

Drum Player

Use the Drum Player device to play different drum sounds for your music setup.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-drum-player-devices-in-fortnite-creative)[![Speaker](https://dev.epicgames.com/community/api/documentation/image/780e06d4-572a-4000-93e3-84c4dc6d6fa2?resizing_type=fit&width=640&height=640)

Speaker

Use the Patchwork Speaker device to play the Patchwork audio you create, either at a specific location or across the entire island.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-speaker-devices-in-fortnite-creative)
