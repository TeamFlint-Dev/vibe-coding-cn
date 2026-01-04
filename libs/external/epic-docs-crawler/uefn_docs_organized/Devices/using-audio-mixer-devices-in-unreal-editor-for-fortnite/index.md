# The Audio Mixer Device

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-mixer-devices-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:16:12.383625

---

Use the **Audio Mixer** device to adjust the volume for groups of sounds with dynamic and automatic control of a game’s volume mix, much like a professional mixing console would.

With the Audio Mixer, you can adjust the level of sounds that are already in Fortnite (such as weapons, character footsteps, and vehicles) as well as custom [sound waves](unreal-editor-for-fortnite-glossary#sound-wave) and [sound cues](unreal-editor-for-fortnite-glossary#sound-cue) by using [**control buses**](unreal-editor-for-fortnite-glossary#control-bus) and [**control bus mixes**](unreal-editor-for-fortnite-glossary#control-bus-mix).

The Audio Mixer is also available directly in Fortnite Creative. Check out the [Audio Mixer Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-audio-mixer-devices-in-fortnite-creative) for more info.

Jump to [Activate Mix for a Duration](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-mixer-devices-in-unreal-editor-for-fortnite) for a step-by-step guide on activating a mix for a short duration on your island.

## Control Buses

When a sound is set to use a **control bus**, all the sounds on that bus can be modulated together in a **Control Bus Mix**.

The following control buses are available to control the volume of the sounds that occur in Fortnite by default:

| Control Bus Name | Description |
| --- | --- |
| CB FortAmbient | Used to set the volume of FN ambient sounds. |
| CB FortExplosions | Used to set the volume of FN explosion sounds. |
| CB FortFootstep | Used to set the volume of character footsteps. |
| CB FortGadgets | Used to set the volume of sounds associated with FN Creative gadgets and devices. |
| CB FortGlobal | Used to set the volume of all FN sounds. |
| CB FortHitNotify | Used to set the volume of sounds associated with the Player getting impacted. |
| CB FortImpacts | Used to set the volume of impact sounds. |
| CB FortJam Volume | Used to control the volume of Jam tracks. |
| CB FortMusic | Used to set the volume of music (includes emote music). |
| CB FortPatchwork Volume | Used to set the volume of Patchwork devices. |
| CB FortVehicles | Used to set the volume of vehicle sounds (not including engine sounds). |
| CB FortVehicles Engine | Used to set the volume of vehicle engines. |
| CB FortWeapon | Used to set the volume of weapons. |

You can also create your own control buses. To create a control bus:

1. In the **Content Browser**, with the project content folder selected, click the **+Add** button or right-click in an empty space in the Content Browser to bring up a context menu.
2. Under the **Create Advanced Assets** section, click **Audio > Modulation**, then click **Control Bus**.
3. Enter a name for your new **control bus**.
4. Open the **Control Bus** asset and set the **Parameter to Volume**

To use a control bus on custom audio assets, the control bus must be set on the sound wave asset. The sound wave can still be used on a sound cue and the effect will be applied.

To add a control bus to your sound wave:

1. In the **Content Browser**, open the sound wave you want to add to a control bus to.
2. Under Modulation, set  **Volume Routing** to **Override**.
3. Click the **Modulate** checkbox.
4. Add one or more **control buses** to the **Volume Modulators** array.

## Control Bus Mixes

**Control bus mixes** take a group of control buses and allow you to define the volume level for each control bus.

To create a control bus mix:

1. In the **Content Browser**, with the project content folder selected, click the **+ Add** button or right-click in an empty space in the Content Browser to bring up a context menu.
2. Under the **Create Advanced Assets** section, click **Audio > Modulation**, then click **Control Bus Mix**.
3. Enter a name for your new **control bus mix**.

Control bus mixes can also be created directly from the Mixer device.

Control bus mixes take an array of **mix stages**. Each mix stage has the following parameters:

| Parameter | Description |
| --- | --- |
| Bus | A control bus. Can be a Fortnite-defined bus or a user-created one. |
| Value | The volume of the sounds routed to this control bus should be scaled when a mix is activated. |
| Attack Time (sec) | [Attack](unreal-editor-for-fortnite-glossary#attack) is the time in sections for the mix to be applied when the mix is activated. |
| Release Time (sec) | [Release](unreal-editor-for-fortnite-glossary#release) is the time in sections for the mix to be applied when the mix is deactivated. |

## Finding and Placing the Device

1. Open the **Content Browser.**
2. Open the **Fortnite** folder index list.
3. Open the **Devices** folder.
4. Select the **Audio Mixer** device and click-and-drag the device into the **viewport**.
5. Select the **Audio Mixer** device in the **Outliner** panel.
6. Configure the **User Options** for the **Audio Mixer** device in the **Details** panel

## User Options

This device applies a control bus mix when activated, and you can configure this device to set the value:

| Option | Value | Description |
| --- | --- | --- |
| **Mix** | **None,** Select a Control Bus Mix | The control bus mix to apply when the device is activated. |

## Direct Event Binding

Devices in UEFN use **Event Binding** to communicate. To set [direct event binding](unreal-editor-for-fortnite-glossary#direct-event-binding) for your device in UEFN:

1. Select the device in the **Outliner** panel.
2. Open the **Details** panel.
3. Navigate to **User Options-Functions**.
4. Add an element to a function.
5. Select a **device** to interact with.
6. Set the **function** the device performs to send a trigger to the **Audio Mixer**.

### Functions

A [**function**](unreal-editor-for-fortnite-glossary#function) tells the selected device what it needs to do when the triggering device performs an action.

| Option | Value | Description |
| --- | --- | --- |
| **Activate Mix** | Click the **Add** icon to select a device, then select an [event](unreal-editor-for-fortnite-glossary#event). | Activates the control bus Mix when the selected device and event triggers the Audio Mixer device. |
| **Deactivate Mix** | Click the **Add** icon to select a device, then select an event. | Deactivates the control bus Mix when the selected device and event triggers the Audio Mixer device. |
| **Register Player When Receiving From** | Click the **Add** icon to select a device, then select an event. | When an event occurs, this function registers the triggering player to this device. |
| **Unregister Player When Receiving From** | Click the **Add** icon to select a device, then select an event. | When an event occurs, this function unregisters the triggering player to this device. |
| **Unregister All Players When Receiving From** | Click the **Add** icon to select a device, then select an event. | When an event occurs, this function unregisters all players from this device. |

## Using the Audio Mixer Device in Verse

All Audio Mixer functions are exposed in Verse. You can now activate mixes, deactivate mixes and register/unregister players to a mix or bus using Verse.

```verse
# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# A creative device that allows an audio mixer to be toggled on and off via a button device
on_off_audio_mixer_device := class(creative_device):

    @editable
    AudioMixerDevice:audio_mixer_device = audio_mixer_device{}

    @editable
    Button:button_device = button_device{}

    var MixActive:logic = false

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Button.InteractedWithEvent.Subscribe(OnButtonInteractedWith)

    OnButtonInteractedWith(InPlayer:agent):void=
        if(MixActive?):
            AudioMixerDevice.DeactivateMix()
            set MixActive = false
        else:
            AudioMixerDevice.ActivateMix()
            set MixActive = true
```

To use this code in your UEFN experience, follow these steps.

1. Drag an Audio Mixer device onto your island.
2. Create a new Verse device named **audio\_mixer\_device\_example**. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse).
3. Open Verse Explorer and double-click **audio\_mixer\_device\_example.verse** to open the script in Visual Studio Code.
4. Paste in the code above, compile, and drag the Verse-authored device onto your island.
5. Select your Verse device in the **Outliner**.
6. In the device’s **Details** panel, assign the object reference for the AudioMixerDevice to the Audio Mixer device on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
7. Save your project and click **Launch Session**.

### Audio Mixer API

See the `audio_mixer_device` API Reference for more information on using the Audio Mixer device in Verse.

## Activate a Mix for a Duration

For this example, let's prototype a Hide and Seek game. Footsteps are muted while players look for a hiding spot, and once the timer runs out, everything is fair game! These four devices are required to test this example:

- Player Spawner
- Audio Mixer
- Timer
- Round Settings

[![Timer Example](https://dev.epicgames.com/community/api/documentation/image/10c7e169-951b-4c38-8c6a-b3b2a5a222bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/10c7e169-951b-4c38-8c6a-b3b2a5a222bc?resizing_type=fit)

1. Select and drag the **Audio Mixer** device into the viewport.
2. In the **Details** panel, assign **CBFortFootstep** in the Bus field.
3. Set **Fader Value** to **0.0**.
4. Check **Activate on Game Start**.

   [![CBFortFootstep](https://dev.epicgames.com/community/api/documentation/image/5ddfd174-a233-4894-b826-a248fb21663e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5ddfd174-a233-4894-b826-a248fb21663e?resizing_type=fit)
5. Select a **Timer** device and drag it into your scene.
6. Customize the device settings as you see fit for your island. In this example, **Duration** is set to **30.0**.

   [![Timer options](https://dev.epicgames.com/community/api/documentation/image/328df765-041b-4886-a61e-009332359423?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/328df765-041b-4886-a61e-009332359423?resizing_type=fit)
7. Select and drag the **Round Settings** device into the viewport. This example uses the default options.
8. Select the **Audio Mixer** device again and go to the **User Options - Functions** section.
9. Click **+** to add an Array element to **Activate Mix**
10. Select the **Round Settings** device and choose the **On Round Start** option.
11. Click **+** to add an Array element to **Deactivate Mix**
12. Select the **Timer** device and choose the **On Success** option.

    [![Mixer functions](https://dev.epicgames.com/community/api/documentation/image/5353689e-eabe-4540-8d83-5e2f4ebfd550?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5353689e-eabe-4540-8d83-5e2f4ebfd550?resizing_type=fit)
13. Press on **Launch Session** and test your game! When a round starts, you should not be able to hear footsteps until the 30-second timer has run out.

    [![Launch Session](https://dev.epicgames.com/community/api/documentation/image/a01c8cc3-6089-47e9-a123-9718fd9ea52c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a01c8cc3-6089-47e9-a123-9718fd9ea52c?resizing_type=fit)

## More Topics

[![Adding Audio to Your Project](https://dev.epicgames.com/community/api/documentation/image/4120c4ca-d9f0-4179-95fe-10297986b79e?resizing_type=fit&width=640&height=640)

Adding Audio to Your Project

Add audio to a project.](https://dev.epicgames.com/documentation/en-us/fortnite/adding-audio-to-your-project-in-unreal-editor-for-fortnite)[![Audio Player Device](https://dev.epicgames.com/community/api/documentation/image/b75bc25e-8809-400a-b3bf-fbc937a8cec8?resizing_type=fit&width=640&height=640)

Audio Player Device

Import, play and customize sound waves and sound cues.](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-unreal-editor-for-fortnite)[![Importing Custom Audio](https://dev.epicgames.com/community/api/documentation/image/54adc69d-66fe-4b57-8b03-df9597f7f562?resizing_type=fit&width=640&height=640)

Importing Custom Audio

Import custom audio into your island and immerse players in the world of your creation.](https://dev.epicgames.com/documentation/en-us/fortnite/importing-custom-audio-in-unreal-editor-for-fortnite)[![Audio Troubleshooting](https://dev.epicgames.com/community/api/documentation/image/b3caded9-a92a-4682-91dd-ee1acc7fdfa4?resizing_type=fit&width=640&height=640)

Audio Troubleshooting

Answers to common audio issues in Unreal Editor for Fortnite.](https://dev.epicgames.com/documentation/en-us/fortnite/audio-troubleshooting-in-unreal-editor-for-fortnite)
