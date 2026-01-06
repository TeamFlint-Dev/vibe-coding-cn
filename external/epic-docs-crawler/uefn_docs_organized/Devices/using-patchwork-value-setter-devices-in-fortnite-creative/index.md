# Value Setter

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-value-setter-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:04:05.281294

---

The **Value Setter (V-SET)** device is the glue that allows gameplay events to control the state of Patchwork systems, such as enabling a new section of music when a specific gameplay stage is reached.

When the Value Setter receives a signal from another device, it sets the value of your choosing on any Patchwork parameter.

## Device Options

[![Value Setter device diagram](https://dev.epicgames.com/community/api/documentation/image/ff5762fc-c08b-4eba-b923-32c587bb923a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ff5762fc-c08b-4eba-b923-32c587bb923a?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When Disabled, no note data is generated. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Control Out Cable** | N/A | The Control Out cable needs to connect to a knob, a carousel or a toggle switch on another Patchwork device. |
| **4. Set Button** | **SET** | A single-action button that allows you to immediately set the value specified by the knob. |
| **5. Blend Time** | 0.0 to 16, default **0** | Sets a time in beats to blend from the targeted control's current value to the new value. This blend begins after any Delay time. |
| **6. Delay Carousel** | **Instant**, Next Beat, Next Bar, Next Phrase | Lets you to set a musical interval to wait before applying the value to the target. |
| **7. Value Knob** | 0.0 to 1, default **0** | The value of this knob will be mapped onto the knob, carousel or toggle that the device is connected to. |

### Other Device Options

In Create mode, walk up to the device and press **E** to open the Customize panel. Some device options mirror the controls you can manipulate with the Patchwork tool. They are present so that you can use the event binding system to trigger changes to how those controls behave, although you can choose to change them here instead of using the knobs. The **Allow Cable Access** option can only be modified using the Customize panel.

| Option | Values | Description |
| --- | --- | --- |
| **Triggered by Player** | **Off**, On | Determines whether to trigger this device based on player proximity. |
| **Triggered by Damage** | **Off**, On | Determines whether to trigger this device when it receives damage. |
| **Triggered by Pulse Trigger** | Off, **On** | Determines whether to activate the trigger when it is touched by a Pulse Trigger or an RNG device pulse. |
| **Allow Cable Access** | Off, **On** | Determines if cable connections to the device can be modified using the Patchwork tool. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. Pre-Game includes all phases prior to the game starting. |

## Configuration

Depending on what you choose to connect the Value Setter to, the Value Knob could become a carousel or a toggle.

[![Value Setter variants](https://dev.epicgames.com/community/api/documentation/image/cd3bb950-1fa9-45f5-ad2d-103feff28000?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cd3bb950-1fa9-45f5-ad2d-103feff28000?resizing_type=fit)

## VFX Preview

The VFX preview for the Value Setter shows the moment a new value is set. When a delay is set, a ring will appear when the Value Setter is triggered, then shrink over the length of the delay until the value is set.

[![Preview VFX gif](https://dev.epicgames.com/community/api/documentation/image/3c1afbec-fe70-4408-aedf-cf39f81ae47c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c1afbec-fe70-4408-aedf-cf39f81ae47c?resizing_type=fit)

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
| **Set Value When Receiving From** | Sets the value of the targeted control when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Enabled Send Event To** | When this device is enabled, an event is sent to the selected device. |
| **On Disabled Send Event To** | When this device is disabled, an event is sent to the selected device. |
| **On Value Set Send Event To** | Sends an event to the selected device whenever this device sets the value of the targeted control. |

## Using Value Setter in Verse

You can use the code below to control a Value Setter device in Verse. This code uses all features of the Value Setter device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level

value_setter_example := class(creative_device):

    @editable

    ValueSetter:patchwork_value_setter_device = patchwork_value_setter_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        

        Sleep(5.0)

        ValueSetter.Disable()

        Print("Device Disabled")

        Sleep(5.0)

        ValueSetter.Enable()

        Print("Device Enabled")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a Value Setter device onto your island.
2. Create a new Verse device named **value\_setter\_example**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse).
3. Open Verse Explorer and double-click **value\_setter\_example****.verse** to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the Verse-authored device onto your island.
5. Select your Verse device in the **Outliner**.
6. In the device’s **Details** panel, assign the object reference for the ValueSetter to the Value Setter device on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
7. Save your project and click **Launch Session**.

### Value Setter API

See the `value_setter_device` API Reference for more information on using the Value Setter device in Verse.

## Patch Ideas

Connect Value Setters to the Page Knob, then trigger them when you want to jump to specific pages. You can use the Delay Carousel on the Value Setter to make sure the current page completes before jumping to the new one.

[![Note Sequencer](https://dev.epicgames.com/community/api/documentation/image/152a0539-36fb-4215-9631-6736999bcbe6?resizing_type=fit&width=640&height=640)

Note Sequencer

The Note Sequencer device allows you to choose the notes you want to use in your compositions.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-note-sequencer-devices-in-fortnite-creative)[![Drum Sequencer](https://dev.epicgames.com/community/api/documentation/image/c9b73c30-c206-4b39-8909-c05e6d761374?resizing_type=fit&width=640&height=640)

Drum Sequencer

Use the Drum Sequencer device to make your own drum pattern, or choose from a number of presets.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-drum-sequencer-devices-in-fortnite-creative)

Connect Value Setters to the Volume Knob, then trigger them based on gameplay. For example, you could have an intense drum pattern that’s always playing, but only audible when players are in combat.

[![Speaker](https://dev.epicgames.com/community/api/documentation/image/780e06d4-572a-4000-93e3-84c4dc6d6fa2?resizing_type=fit&width=640&height=640)

Speaker

Use the Patchwork Speaker device to play the Patchwork audio you create, either at a specific location or across the entire island.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-speaker-devices-in-fortnite-creative)

Connect Value Setters to the Mix Knob to adjust the impact of the effect at different points in a song.

[![Echo Effect](https://dev.epicgames.com/community/api/documentation/image/9fe53df2-535a-4aed-b983-b8b9299565f8?resizing_type=fit&width=640&height=640)

Echo Effect

This device takes in an audio signal and sends it out again, but with a time delay, like your voice echoing in a canyon.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-echo-effect-devices-in-fortnite-creative)
