# Music Manager

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-music-manager-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-27T02:04:33.791186

---

The **Music Manager (M-MGR)** device provides a way for you to set the [key](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), mode (major or minor), and [tempo](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) of the audio mix for all Patchwork devices on your island. It ensures that all Patchwork devices stay in time and in key with each other. It is not directly part of anyPatchwork [device chain](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), though its controls can be manipulated by [modulator](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) devices.

## Device Options

[![Music Manager callouts](https://dev.epicgames.com/community/api/documentation/image/58f2ecd1-90a9-44ec-b93c-7782813911f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/58f2ecd1-90a9-44ec-b93c-7782813911f3?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When enabled, playback begins from beat 0. When disabled, other devices can still be interacted with and modified, but their functionality will be limited. For example, behaviors that fire every beat won't activate, as beats are not being counted. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Key Carousel** | C, C♯/D♭, D, D♯/E♭, E, F, F♯/G♭, G, G♯/A♭, A, A♯/B♭, B, default **Random** | Selects the key for all Patchwork note generators. |
| **4. Beat Visualization** | N/A | An animated timeline showing the beats per measure and the current beat within the measure, as well as a counter indicating the current measure. |
| **5. Time Signature Display** | N/A | Shows the time signature in a traditional fractional display, with the beats per measure over the note length per beat. |
| **6. Time Signature Bottom Value Carousel** | 2, **4**, 8, 16 | Sets the note length per beat in the time signature. A value of 2 represents a half note per beat, 4 represents a quarter note per beat, and so on. |
| **7. Time Signature Top Value Carousel** | **4**, pick a number between 2-15 | Sets the number of beats per measure in the time signature. |
| **8. Tempo Knob** | 60-180, default **Random within range of 80-160** | Sets the tempo for all Patchwork devices. |
| **9. Key Mode Carousel** | Major, Minor, default **Random** | Sets the mode for the entire mix. Major usually lends itself to a happier tone while a minor mode is generally associated with sadder music. |

### Other Device Options

In Create mode, walk up to the device and press **E** to open the Customize panel. Some device options mirror the controls you can manipulate with the Patchwork tool. They are present so that you can use the event binding system to trigger changes to how those controls behave, although you can choose to change them here instead of using the knobs. The **Allow Cable Access** option can only be modified using the Customize panel.

| Option | Values | Description |
| --- | --- | --- |
| **Allow Cable Access** | **On**, Off | Determines if the Patchwork Tool can access any cable input or output ports on the device. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. Pre-Game includes all phases prior to the game starting. |
| **Jam Settings Control** | **Patchwork Controls**, Not Shared | When both Patchwork and a Jam are active, determines if their tempo, key, and mode are shared and where those settings are controlled. |

## VFX Preview

The VFX preview for the Music Manager gives you a sense of the overall tempo of the Patchwork system.

[![Preview VFX gif](https://dev.epicgames.com/community/api/documentation/image/4164e855-a128-45ea-8f5b-bc4c658dfcee?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4164e855-a128-45ea-8f5b-bc4c658dfcee?resizing_type=fit)

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

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
| **On Enabled Send Event To** | When this device is enabled, a signal is sent to the linked device. |
| **On Disabled Send Event To** | When this device is disabled, a signal is sent to the linked device. |

## Using Music Manager in Verse

You can use the code below to control a music manager device in Verse. This code uses all features of the music manager device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level

music_manager_example := class(creative_device):

    @editable

    MusicManger:patchwork_music_manager_device = patchwork_music_manager_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        Sleep(5.0)

        MusicManager.Disable()

        Print("Device Disabled")

        Sleep(5.0)

        MusicManager.Enable()

        Print("Device Enabled")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a music manager device onto your island.
2. Create a new Verse device named **music\_manager\_example**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse).
3. Open Verse Explorer and double-click **music\_manager\_example.verse** to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the Verse-authored device onto your island.
5. Select your Verse device in the **Outliner**.
6. In the device’s **Details** panel, assign the object reference for the MusicManager to the music manager device on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
7. Save your project and click **Launch Session**.

### Music Manager API

See the `music_manager_device` API Reference for more information on using the music manager device in Verse.

## Patch Ideas

The Music Manager does not have cable inputs or outputs, but can be controlled by Modulator devices:

[![Value Setter](https://dev.epicgames.com/community/api/documentation/image/a989b185-5af2-439c-b5a2-f61bc3ba908e?resizing_type=fit&width=640&height=640)

Value Setter

This is the glue that allows Creative and UEFN devices to control the state of Patchwork systems.](<https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-value-setter-devices-in-fortnite-creative)[![LFO> Modulator](<https://dev.epicgames.com/community/api/documentation/image/c4b5f838-6a8d-47e1-9f52-9db16729ab7b?resizing_type=fit&width=640&height=640>)

LFO Modulator

Use the Low-Frequency Oscillator Modulator device to modify a setting on another Patchwork device in a repeating pattern.](<https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-lfo-modulator-devices-in-fortnite-creative)[![Step> Modulator](<https://dev.epicgames.com/community/api/documentation/image/d6d1c0b3-dcd4-4489-b49d-dd352758c0c5?resizing_type=fit&width=640&height=640>)

Step Modulator

Patch the Step Modulator device to controls on other devices to create sequenced patterns with values from the Step Modulator.](<https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-step-modulator-devices-in-fortnite-creative>)
