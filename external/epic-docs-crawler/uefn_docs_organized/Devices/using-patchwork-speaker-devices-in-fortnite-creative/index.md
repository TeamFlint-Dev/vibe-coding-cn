# Speaker

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-speaker-devices-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:05:49.691393

---

The **Patchwork Speaker (SPK)** device outputs audio generated from other Patchwork devices. The Patchwork Speaker is the end of the chain that results in audio.

Ther Patchwork Speaker is meant to work with other Patchwork devices only. This speaker will not play sound cues.

The Patchwork Speaker accepts audio input, then plays the sound that players can hear.

You can set up multiple speakers on an island and have each play different sounds. This will let you mix your audio by adjusting the relative volume of each speaker, without he need to travel back to the source audio devices.

## Device Options

[![Speaker device diagram](https://dev.epicgames.com/community/api/documentation/image/3a7c0349-c137-43c5-94a3-4d4eccaea038?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a7c0349-c137-43c5-94a3-4d4eccaea038?resizing_type=fit)

| Option | Values | Description |
| --- | --- | --- |
| **1. Enabled Switch** | **On**, Off | When set to Off, no sound is produced. |
| **2. Expand Buttons** | **Closed**, Open | Expand the device to reveal more customization options. |
| **3. Volume Bars** | N/A | Simple visualization of the volume level. Useful for comparing the relative volume of multiple speakers at a glance. |
| **4. Volume Knob** | 0.0 - 2.0, default **1.0** | Sets the volume of the speaker. |
| **5. Audio In Port** | N/A | Can only receive a teal Audio Out cable. |

### Other Device Options

In Create mode, walk up to the device and press **E** to open the Customize panel. Some device options mirror the controls you can manipulate with the Patchwork tool. They are present so that you can use the event binding system to trigger changes to how those controls behave, although you can choose to change them here instead of using the knobs. The **Allow Cable Access** option can only be modified using the Customize panel.

| Option | Values | Description |
| --- | --- | --- |
| **Full Volume Distance** | **Full Island**, Very Large, Large, Medium, Small, Very Small | Sets the distance from the speaker where its audio is heard at full volume. Setting this to **Full Island** will play the audio at full volume regardless of distance from the speaker. |
| **Falloff Distance** | **Very Large**, Large, Medium, Small, Very Small | Sets the distance beyond the Full Volume Distance, over which the speaker's audio gradually becomes silent. Only visible when Full Volume Distance is set to something other than Full Island. |
| **Visible in Game** | **On**, Off | When set to OFF, hides the speaker in Play mode. This allows it to be positioned as needed for spatial audio without players seeing it. |
| **Music Event Group** | Select a group | Determines which speakers can be heard at the same time. |
| **Compressor Settings** | None, **Soft**, Hard, Auto | Determines how much to adjust the dynamic range of the signal. A **Hard** setting will more aggressively turn down loud sounds and turn up the quiet sounds. |
| **SFX Ducking** | **0.0** - 1.0 | Determines how much to reduce the volume of sound effects while the speaker is playing. |
| **Play at Location** | **Device**, Registered Players | Determines if the audio is played from the device location or any registered players' locations. |
| **Can Be Heard By** | **Everyone**, Registered Players Only, Non-Registered Players Only | Determines who will be able to hear the sound played from this speaker. |
| **Fade In Time** | 0.01 - 60.00, default **0.01** | When this device becomes audible to a player, determines the time in seconds it takes to ramp to its set volume from 0. |
| **Fade Out Time** | 0.01 - 60.00, default **0.01** | When this device ceases to be audible to a player, determines the time in seconds it takes to ramp from its set volume to 0. |
| **Allow Cable Access** | **On**, Off | Determines whether cable connections to the device can be modified with the Patchwork tool. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only | Determines the game phases during which the device will be enabled. Pre-Game includes all phases prior to the game starting. |

## VFX Preview

The VFX preview for the Patchwork Speaker shows:

- The motion of the VFX preview shows the soundwave pattern being played by the Speaker.
- The width of the VFX preview indicates the volume setting of the Speaker.

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
| **Register Player When Receiving From** | Registers the instigating player as a target for the speaker when an event occurs. |
| **Unregister Player When Receiving From** | Removes the instigating player as a target for the speaker when an event occurs. |
| **Unregister All Players When Receiving From** | Removes all registered players as targets for the speaker when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Enabled Send Event To** | When this device is enabled, an event is sent to the selected device. |
| **On Disabled Send Event To** | When this device is disabled, an event is sent to the selected device. |

## Using Speaker in Verse

You can use the code below to control a Speaker device in Verse. This code uses all features of the Speaker device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level

speaker_example := class(creative_device):

    @editable

    Speaker:patchwork_speaker_device = patchwork_speaker_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        

        Sleep(5.0)

        Speaker.Disable()

        Print("Device Disabled")

        Sleep(5.0)

        Speaker.Enable()

        Print("Device Enabled")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a Speaker device onto your island.
2. Create a new Verse device named **speaker\_example**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse).
3. Open Verse Explorer and double-click **speaker\_example.verse** to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the Verse-authored device onto your island.
5. Select your Verse device in the **Outliner**.
6. In the device’s **Details** panel, assign the object reference for the Speaker to the Speakert device on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
7. Save your project and click **Launch Session**.

### Speaker API

See the `speaker_device` API Reference for more information on using the Speaker device in Verse.

## Patch Ideas

Patch the Instrument Player into the Speaker to hear the instrument play the music you composed with the Note Sequencer.

[![Instrument Player](https://dev.epicgames.com/community/api/documentation/image/400c75be-0d90-4616-8f07-6bab3c33a705?resizing_type=fit&width=640&height=640)

Instrument Player

The Instrument Player device gives you a selection of instruments for playing melodic content.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-instrument-player-devices-in-fortnite-creative)

Patch the Distortion Effect into the Speaker to hear distortion in your music.

[![Distortion Effect](https://dev.epicgames.com/community/api/documentation/image/fe26526b-54d6-4832-8114-6deb1f7f1a00?resizing_type=fit&width=640&height=640)

Distortion Effect

Use this audio-shaping tool that results in sounds typical of genres like electronic, rock, and metal.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-distortion-effect-devices-in-fortnite-creative)

Patch the Echo Effect into the Speaker to hear echo in the music.

[![Echo Effect](https://dev.epicgames.com/community/api/documentation/image/9fe53df2-535a-4aed-b983-b8b9299565f8?resizing_type=fit&width=640&height=640)

Echo Effect

This device takes in an audio signal and sends it out again, but with a time delay, like your voice echoing in a canyon.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-echo-effect-devices-in-fortnite-creative)

Patch the Omega Synth into Speaker to hear synth sounds in your music.

[![Omega Synthesizer](https://dev.epicgames.com/community/api/documentation/image/cd4b37b9-039d-46b5-9f57-931644136443?resizing_type=fit&width=640&height=640)

Omega Synthesizer

The Omega Synthesizer device allows you to turn note inputs into audio data.](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-omega-synthesizer-devices-in-fortnite-creative)
