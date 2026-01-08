# Step Modulator

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-step-modulator-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-27T02:05:42.296848

---

The **Step Modulator (S-MOD)** device lets you directly set a series of values for the controls on other Patchwork devices. Patch the Step Modulator cable into other device controls to create sequenced patterns with settings that you define in the Step Modulator.

## Device Options

[![Step modulator device diagram](https://dev.epicgames.com/community/api/documentation/image/e9f19397-b2f6-4258-9f47-f48f96cc2cf6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9f19397-b2f6-4258-9f47-f48f96cc2cf6?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When Disabled, the targeted control is not modified. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Modulator Cable** | N/A | The Modulation Out cable should be patched to a control on another Patchwork device. |
| **4. Blend Time Knob** | -1 to 1, **0** | Sets a percentage of the time between steps to blend between the steps' values. Setting this control to a positive value will begin blending at the step time, while setting it to a negative value will begin blending before the step time. |
| **5. Length Knob** | 1 - **8** | Number of steps in the sequence before it loops back to the beginning. |
| **6. Step Value** | Various | Determines the value to be sent when this step is active. The step value control changes to reflect the targeted control. Patch the device to the control you want before setting these values to make sure you get the output you want. |
| **7. Currently Active Step** | N/A | The step with the value currently being set has a green outline. |
| **8. Step Rate** | 16 Bars - 1/16 Note, default: **1 Bar** | Sets the speed at which the Step Modulator moves through steps. |

### Other Device Options

In Create mode, walk up to the device and press **E** to open the Customize panel. Some device options mirror the controls you can manipulate with the Patchwork tool. They are present so that you can use the event binding system to trigger changes to how those controls behave, although you can choose to change them here instead of using the knobs. The **Allow Cable Access** option can only be modified using the Customize panel.

| Option | Values | Description |
| --- | --- | --- |
| **Allow Cable Access** | **On**, Off | Determines if cable connections to the device can be modified. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. Pre-Game includes all phases prior to the game starting. |

## Using the Step Modulator

The Step Modulator can be used in a number of ways. For example, you could use it to create a variety of multi-page note patterns by modulating the Page Knob of a Note Sequencer. Or, modulate the Volume knob of an Instrument Player to create song dynamics as the volume of that instrument changes over time.

This device can be used in many different ways to add complexity and interest to a musical sequence, such as:

- [Modulating](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) the [key](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#key) for the Music Manager to change the sound of your entire mix.
- Turning devices on and off automatically in a sequence.

The UI indicates all active [step](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#step) values and the [step rate](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#step-rate) for the device. Turning the Step Value Knob decreases or increases the step value for the selected step. A step value provides control data as an output that connects to the knob of another Patchwork device.

The device has a dynamic UI that can change based on its output destination type, changing into a continuous knob, stepped knob, carousel, or toggle as needed.

[![Gif of player setting the step value](https://dev.epicgames.com/community/api/documentation/image/09c14099-b75a-4ea0-a206-49f23abac583?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/09c14099-b75a-4ea0-a206-49f23abac583?resizing_type=fit)

## VFX Preview

The VFX preview for the Step modulator shows:

- The highlighted column indicates the current position in the sequence of steps.
- The heights of the diamond shapes indicate the relative value of each step.

  [![Preview VFX gif](https://dev.epicgames.com/community/api/documentation/image/5dbc9d0d-3bdf-429c-ab25-af62e77dee02?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5dbc9d0d-3bdf-429c-ab25-af62e77dee02?resizing_type=fit)

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | The device is enabled when an event occurs. |
| **Disable When Receiving From** | The device is disabled when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Enabled Send Event To** | When this device is enabled, an event is sent to the selected device. |
| **On Disabled Send Event To** | When this device is disabled, an event is sent to the selected device. |

## Using Step Modulator in Verse

You can use the code below to control a dDistortion eEffect device in Verse. This code uses all features of the Step Modulator device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level

step_modulator_example := class(creative_device):

    @editable

    StepModulator:patchwork_step_modulator_device = patchwork_step_modulator_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        

        Sleep(5.0)

        StepModulator.Disable()

        Print("Device Disabled")

        Sleep(5.0)

        StepModulator.Enable()

        Print("Device Enabled")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a Step Modulator device onto your island.
2. Create a new Verse device named **step\_modulator\_example**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse).
3. Open Verse Explorer and double-click **step\_modulator\_example.verse** to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the Verse-authored device onto your island.
5. Select your Verse device in the **Outliner**.
6. In the device’s **Details** panel, assign the object reference for the StepModulator to the Step Modulator device on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
7. Save your project and click **Launch Session**.

### Step Modulator API

See the `step_modulator_device` API Reference for more information on using the Step Modulator device in Verse.

## Patch Ideas

Patch the Step Modulator to the Page Knobs to play pages in any order you like.

[![Drum Sequencer](https://dev.epicgames.com/community/api/documentation/image/c9b73c30-c206-4b39-8909-c05e6d761374?resizing_type=fit&width=640&height=640)

Drum Sequencer

Use the Drum Sequencer device to make your own drum pattern, or choose from a number of presets.](<https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-drum-sequencer-devices-in-fortnite-creative)[![Note> Sequencer](<https://dev.epicgames.com/community/api/documentation/image/152a0539-36fb-4215-9631-6736999bcbe6?resizing_type=fit&width=640&height=640>)

Note Sequencer

The Note Sequencer device allows you to choose the notes you want to use in your compositions.](<https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-sequencer-devices-in-fortnite-creative>)

Patch the Step Modulator to the Key Carousel to create a progression in the global mix.

[![Music Manager](https://dev.epicgames.com/community/api/documentation/image/ea656a73-4d82-4b19-ab27-1744ab3297c1?resizing_type=fit&width=640&height=640)

Music Manager

Use this device to change the key, mode and tempo for all Patchwork devices on your island.](<https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-music-manager-devices-in-fortnite-creative>)

Patch the Step Modulator to different controls on these devices to create regular variations in their sound.

[![Omega Synthesizer](https://dev.epicgames.com/community/api/documentation/image/cd4b37b9-039d-46b5-9f57-931644136443?resizing_type=fit&width=640&height=640)

Omega Synthesizer

The Omega Synthesizer device allows you to turn note inputs into audio data.](<https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-omega-synthesizer-devices-in-fortnite-creative)[![Echo> Effect](<https://dev.epicgames.com/community/api/documentation/image/9fe53df2-535a-4aed-b983-b8b9299565f8?resizing_type=fit&width=640&height=640>)

Echo Effect

This device takes in an audio signal and sends it out again, but with a time delay, like your voice echoing in a canyon.](<https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-echo-effect-devices-in-fortnite-creative>)
