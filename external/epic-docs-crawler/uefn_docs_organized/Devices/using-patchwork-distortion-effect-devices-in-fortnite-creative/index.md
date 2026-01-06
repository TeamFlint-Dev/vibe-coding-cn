# Distortion Effect

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-distortion-effect-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:04:50.750765

---

The **Distortion Effect (FX-DIST)** device can simulate the warm sound of a signal being [overdriven](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) through an analog tube amp, or an unsettling [digital processing](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and warping.

Different styles of [distortion](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) shape the feel of audio in different ways, evoking various moods and music genres. In Patchwork, you can use distortion as a creative tool to customize your sound.

## Device Options

[![Distortion Effect device diagram](https://dev.epicgames.com/community/api/documentation/image/7536fe90-c671-47d0-a4da-4faa023fcfed?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7536fe90-c671-47d0-a4da-4faa023fcfed?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When disabled, the audio data is passed through without any effect applied. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Audio Out Cable** | N/A | Connect the Audio Out cable to a teal Audio In port on another device. |
| **4. Mix knob** | **1.0**, 0.00-1.00 | This determines how much of the audio output is processed by the effect. |
| **5. Tame Knob** | **0**, 0.00-1.00 | Uses a low pass filter to reduce harsh high-frequency output caused by the distortion. Higher Tame values will filter out more frequencies. |
| **6. Shatter Knob** | **0**, 0.00-1.00 | Controls how much of a DC offset is applied to the input signal. Increasing this causes the distortion to alter the signal in more destructive ways. |
| **7. Drive Knob** | **4**, 1.00-11.00 | Sets the gain applied to the audio input. Higher Drive values will increase the distortion. |
| **8. Style Carousel** | **Clip**, Warm, Asymmetric, Crunch | Choose from the available Distortion styles. |
| **9. Audio In Port** | N/A | The Audio In port receives a teal Audio Out cable from another device. |

### Other Device Options

In [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), walk up to the device and press **E** to open the **Customize** panel. You can also modify the options below using the Customize panel or the user options in UEFN.

| Option | Values | Description |
| --- | --- | --- |
| **Mix** | **1.0**, 0.00-1.00 | This determines how much of the audio output is processed by the effect. |
| **Style** | **Clip**, Warm, Asymmetric, Crunch | Choose from the available Distortion styles. |
| **Drive** | **4**, 1.00-11.00 | Sets the gain applied to the audio input. Higher Drive values will increase the distortion. |
| **Shatter** | **0**, 0.00-1.00 | Controls how much of a DC offset is applied to the input signal. Increasing this causes the distortion to alter the signal in more destructive ways. |
| **Tame** | **0**, 0.00-1.00 | Uses a low pass filter to reduce harsh high-frequency output caused by the distortion. Higher Tame values will filter out more frequencies. |
| **Allow Cable Access** | **On**, Off | Determines if the Patchwork Tool has access to any cable input or output ports on the device. If this is set to **Off**, you cannot move existing cables, or plug new cables into the device. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases in which the device will be enabled.  Pre-Game includes all phases prior to the game starting (Waiting for players in the lobby, Featured Islands, and the Game Start Countdown). |

## VFX Preview

You can get a sense of the Distortion parameters based on the VFX Preview:

[![Preview VFX gif](https://dev.epicgames.com/community/api/documentation/image/debe57de-2b96-40e9-9a22-dbbba83b07b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/debe57de-2b96-40e9-9a22-dbbba83b07b6?resizing_type=fit)

## Direct Event Binding System

**Direct event binding** allows devices to communicate directly. Below are the functions and events for this device:

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

|  |  |
| --- | --- |
| **Option** | **Description** |
| **On Enabled Send Event To** | When this device is enabled, an event occurs which triggers the selected function. |
| **On Disabled Send Event To** | When this device is disabled, an event occurs which triggers the selected function. |

## Patch Ideas

- Try patching the [Instrument Player](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-instrument-player-devices-in-fortnite-creative) or the [Omega Synthesizer](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-omega-synthesizer-devices-in-fortnite-creative) into the Distortion Effect to add a crunch to your sound.
- Patch the Distortion Effect into the [Echo Effect](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-echo-effect-devices-in-fortnite-creative) to create more complex sounds!
- Patch the Distortion Effect into the [Speaker](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-speaker-devices-in-fortnite-creative) to hear the result of your Patchwork chain.
