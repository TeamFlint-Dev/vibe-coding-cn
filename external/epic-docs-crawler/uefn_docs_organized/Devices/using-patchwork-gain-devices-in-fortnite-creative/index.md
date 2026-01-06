# FX Gain

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-gain-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:04:44.948039

---

The Patchwork Gain device gives you a volume control that can be applied to specific parts of your Patchwork system.

You can connect one or more of your Patchwork audio devices to the Gain input port to raise or lower the volume of just those devices in your composition.

This device should be placed at the end of your device chain, right before the [Patchwork Speaker](using-patchwork-speaker-devices-in-fortnite-creative) device.

For help on how to find the **Patchwork Gain** device, see [**Using Devices**](using-devices-in-fortnite-creative).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [**Event Browser**](event-browser-in-fortnite-creative).

## Device Options

Default values are **bold**.

[![Patchwork Gain with callouts](https://dev.epicgames.com/community/api/documentation/image/bf377432-d37b-4566-8600-f01b1d011deb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bf377432-d37b-4566-8600-f01b1d011deb?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When disabled, the audio data is passed through without any [effect](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#audio-effect) applied. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Audio Output Cable** | N/A | Connect the audio output cable to another device. |
| **4. Gain Knob** | **1**, choose a value between 0.00-2.00 | Multiplies the volume of the audio input by the selected value. A value of **0** will mute the audio. A value of **2** will double the volume of the audio. |
| **5. Audio Input Port** | N/A | Connect the input device's cable to the audio input port. |

### Other Device Options

In [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode), walk up to the device and press **E** to open the **Customize** panel. You can also modify the options below using the Customize panel or the user options in UEFN.

| Option | Value | Description |
| --- | --- | --- |
| **Gain** | **1.0**, choose a value between 0.00-2.00 | This is the same as the Gain knob, described above. |
| **Allow Cable Access** | **On**, Off | Determines if the [Patchwork tool](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#patchwork-tool) can access the cable input and output ports on the device. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the phases in which the device is enabled. |

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
