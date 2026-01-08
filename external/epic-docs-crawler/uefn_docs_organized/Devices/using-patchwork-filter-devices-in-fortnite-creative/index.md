# FX Filter

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-filter-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-27T02:05:34.415397

---

The **Patchwork Filter** device [filters](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) which audio frequencies are cut and which are allowed to pass through. The cut frequencies are **attenuated** (reduced in volume), effectively turning them off. This changes the sound of the audio output.

The Patchwork Filter device can be used as a creative tool to produce an effect that changes the character of a sound. One common use is to pair a filter with a [Low-Frequency Oscillator (LFO)](using-patchwork-lfo-modulator-devices-in-fortnite-creative) device plugged into its Cutoff knob. This creates a "filter sweep" effect. It can also be used to clean up or tighten parts of the full song mix.

Different filter settings affect your audio in the following ways:

- **Low-Pass**: Audio frequencies above the Cutoff value are attenuated.
- **High-Pass**: Audio frequencies below the Cutoff value are attenuated.
- **Band-Pass**: Audio frequencies on either side of the Cutoff value are attenuated.
- **Notch**: Audio frequencies in the center of the Cutoff value are attenuated.

For help on how to find the **Patchwork Filter** device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [**Event Browser**](event-browser-in-fortnite-creative).

## Device Options

[![](https://dev.epicgames.com/community/api/documentation/image/7d731108-4437-4873-8265-b35d31db70cf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d731108-4437-4873-8265-b35d31db70cf?resizing_type=fit)

Default values are **bold**.

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When disabled, the audio data is passed through without any [effect](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#audio-effect) applied. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Audio Output Cable** | N/A | Connect the **Audio Output** cable to a yellow **Note In** port. |
| **4. Mix knob** | **1**, choose a value between 0.0 - 1.0 | Sets how much of the audio output is processed. |
| **5. Onscreen Graph** | N/A | Shows the effect of adjusting the device parameters (**Filter Type**, **Cutoff** and **Resonance**) by looking at changes to the onscreen graph. This works similarly to the LFO device Waveform Display. |
| **6. Filter Type carousel** | **Low-Pass**, High-Pass, Band-Pass, Notch | Determines which filter is applied to the audio input. |
| **7. Resonance knob** | **0.0**, choose a value between 0.0-1.0 | Sets a range around the **Cutoff** frequency within which frequencies will be boosted. |
| **8. Cutoff knob** | **1.0 (1000 Hz)**, choose a value between 0.01-15.0 (10 Hz-15000 Hz) | Sets the frequency at which the filter will be applied. For example, setting this to 5000 Hz with a Low-Pass filter type will cut off frequencies above 5000 Hz. |
| **9.****Audio Input Port** | N/A | Connect the input device's cable to the audio input port. |

### Other Device Options

In [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode), walk up to the device and press **E** to open the **Customize** panel. You can also modify the options below using the Customize panel or the user options in UEFN.

| Option | Value | Description |
| --- | --- | --- |
| **Filter Type** | **Low-Pass**, High-Pass, Band-Pass, Notch | Determines which filter is applied to the audio input. |
| **Cutoff** | **1.0 (1000 Hz)**, choose a value between 0.01-15.0 (10 Hz-15000 Hz) | Sets the frequency at which the filter will be applied. For example, setting this to 5000 Hz with a Low-Pass filter type will cut off frequencies above 5000 Hz. |
| **Resonance** | **0.0**, choose a value between 0.0-1.0 | Emphasizes the frequencies at the Cutoff value. High resonance values can create a whistling effect. |
| **Mix** | **1**, choose a value between 0.0 - 1.0 | Sets how much of the audio output is processed. |
| **Allow Cable Access** | **On**, Off | Determines if the Patchwork Tool can access the cable input and output ports on the device. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the phases in which device is enabled. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

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

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Enabled Send Event To** | When the device is enabled, an event occurs, which triggers the selected function. |
| **On Disabled Send Event To** | When the device is disabled, an event occurs, which triggers the selected function. |
