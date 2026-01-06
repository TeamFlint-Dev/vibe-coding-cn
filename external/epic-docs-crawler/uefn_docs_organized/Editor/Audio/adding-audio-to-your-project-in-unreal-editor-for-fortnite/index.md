# Adding Audio to Your Project

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/adding-audio-to-your-project-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:16:17.871152

---

Audio is a key element for giving players feedback on their actions in game, and providing players with important cues during gameplay.

To do this, Unreal Editor for Fortnite (UEFN) uses [sound wave](unreal-editor-for-fortnite-glossary#sound-wave) and [sound cue](unreal-editor-for-fortnite-glossary#sound-cue) files.

[![sound cues and waves](https://dev.epicgames.com/community/api/documentation/image/fdbb8155-41c9-41c5-af74-310b7e8c16bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fdbb8155-41c9-41c5-af74-310b7e8c16bb?resizing_type=fit)

A **sound wave** is the format of an audio file after it has been imported into UEFN.

A **sound cue** is an audio asset that runs complex sound design tasks set up inside a **[node graph](https://dev.epicgames.com/documentation/en-us/fortnite/node-graph)**. Sound cues provide freedom to dynamically change parts of a sound effect design by arranging and modifying [sound nodes](unreal-editor-for-fortnite-glossary#sound-graph).

## Creating Sound Cues

With UEFN, you can craft complex audio experiences using sound cues.

Sound cues are an Unreal Engine feature that has existing [documentation](https://docs.unrealengine.com/5.0/en-US/sound-cues-in-unreal-engine/). UEFN has a subset of these features.

To create a sound cue:

1. In the **Content Browser**, with the [project content](unreal-editor-for-fortnite-glossary#project-content) folder selected, right-click and select **Audio**, and then click **Sound Cue**.

   [![create sound cue](https://dev.epicgames.com/community/api/documentation/image/aa22be07-2660-4910-98f0-b19b201aca4a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aa22be07-2660-4910-98f0-b19b201aca4a?resizing_type=fit)
2. Enter a name for your new sound cue.

You can also create a new sound cue by right-clicking one or more sound waves in the Content Browser and selecting **Create Single Cue** or **Create Multiple Cues** in the **Sound Wave Actions** menu.

[![create sound cue from multiple waves](https://dev.epicgames.com/community/api/documentation/image/f77a5dc3-50b4-42e9-9e5d-cc196e3633ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f77a5dc3-50b4-42e9-9e5d-cc196e3633ca?resizing_type=fit)

Name the newly-created sound cue and double-click it to open the Sound Cue Editor.

Sound cue nodes available to UEFN users are:

| Sound Node | Description |
| --- | --- |
| **Concatenator** | Plays branches in a sound cue sequentially. |
| **Crossfade by Distance** | Fades between two or more input sounds based on the distance from the sound cue origin to the listener. The sound will only play if it is within the minimum and maximum distance settings. |
| **Delay** | Inserts a delay into the sound node chain to cause a pause before the input sound is passed to the output. |
| **Doppler** | Simulates a Doppler effect, in which a sound's pitch changes based on the source's movement in relation to the listener. The pitch will increase as the source approaches the listener and decrease as the source moves away |
| **Enveloper** | Creates an envelope where a sound’s volume and pitch are manipulated over a specified period via distribution curves. |
| **Looping** | Retriggers the input either indefinitely or for a set number of times. This node is intended for logical and procedural looping. For seamless indefinite looping, use the **Looping** flag on the **Wave Player** node. |
| **Mixer** | Defines how concurrent sounds in a sound cue are mixed together by providing volume control for each individual input. |
| **Modulator** | Used to randomize volume and pitch modulation. You can set maximum and minimum values to determine the range of randomization. |
| **Oscillator** | Used to introduce continuous pitch and volume oscillation. |
| **Random** | Used to randomly trigger a node from the list of connected input nodes. |
| **WavePlayer** | Contains a reference to a sound wave asset to be played with the sound cue. Can be set as a **Looping** waveplayer. |
| **Add Comment…** | Adds a comment tag to the sound cue. |

## Using Audio Devices

The audio you import and the sound cues you create can be selected from different audio devices. Here is an overview of what you can do with each device:

**[Audio Player Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-unreal-editor-for-fortnite):**

[![Audio player device](https://dev.epicgames.com/community/api/documentation/image/7d3f8f08-09bd-40b6-ad7b-3338f061cdb9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d3f8f08-09bd-40b6-ad7b-3338f061cdb9?resizing_type=fit)

- Play sound waves and sound cues.
- Fade audio in and out.
- Change the speed of the sound.
- Add attenuation to your sound.
- Decide who will hear the audio.
- Use function options to edit when audio plays and stops.

**[Audio Mixer Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-mixer-devices-in-unreal-editor-for-fortnite)**:

[![Audio player device](https://dev.epicgames.com/community/api/documentation/image/3d19ff4c-282b-4d02-af7e-4db07e49cbd7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3d19ff4c-282b-4d02-af7e-4db07e49cbd7?resizing_type=fit)

- Play [control bus mixes](unreal-editor-for-fortnite-glossary#control-bus-mix).
- Control the sound levels already in Fortnite.
- Control volumes of groups of sounds.

## Best Practices

Following are a few techniques to maximize audio quality in your UEFN experiences.

### Use an audio asset's dynamic range.

Make sure your imported audio is fully utilizing its dynamic range.

Audio assets you create should try to avoid compressing their dynamic range too much so you can control the volume of the sounds inside the UEFN experience itself (using the [Audio Mixer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-mixer-devices-in-unreal-editor-for-fortnite) and setting volumes on the generated assets in UEFN). When audio sums together in an audio engine, all the noise in the asset will accumulate and the audio in your experience can get loud very fast depending on the amount of audio that is playing.

### Use similar volume levels in a group.

Make sure the volume of the assets you intend to control in a common group using the [Audio Mixer device](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-mixer-devices-in-unreal-editor-for-fortnite) are at a similar volume level.

When you control the volume of a group of sounds, it’s helpful if the sounds in that group are of similar perceptual volume. This is a little tricky to get right and it doesn’t have to be perfect, but loudness perception is non-linear, and it depends on the frequency content of the sound. This means that different sounds at different perceptual loudness levels will react to different volume changes in a way that is hard to predict.

### Keep an eye on memory usage.

Try to avoid using large files, and be creative when making longer duration sounds. For example, instead of a three-minute ambience loop, consider breaking it down into smaller fragments of sound that crossfade randomly in a sound cue.

See [Memory Management](https://dev.epicgames.com/documentation/en-us/uefn/memory-management-in-unreal-editor-for-fortnite) for more tips.

### Subtlety is key.

It's common to focus on the big sounds in a game experience, but the small, quiet sounds are a huge aspect of creating a believable immersive audio experience.

## More Topics

[![Audio Player Device](https://dev.epicgames.com/community/api/documentation/image/b75bc25e-8809-400a-b3bf-fbc937a8cec8?resizing_type=fit&width=640&height=640)

Audio Player Device

Import, play and customize sound waves and sound cues.](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-unreal-editor-for-fortnite)[![The Audio Mixer Device](https://dev.epicgames.com/community/api/documentation/image/36ccfbcb-c8fd-4297-88a7-4d90754a1f69?resizing_type=fit&width=640&height=640)

The Audio Mixer Device

Adjust volumes of sound groups using the Audio Mixer device.](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-mixer-devices-in-unreal-editor-for-fortnite)[![Importing Custom Audio](https://dev.epicgames.com/community/api/documentation/image/54adc69d-66fe-4b57-8b03-df9597f7f562?resizing_type=fit&width=640&height=640)

Importing Custom Audio

Import custom audio into your island and immerse players in the world of your creation.](https://dev.epicgames.com/documentation/en-us/fortnite/importing-custom-audio-in-unreal-editor-for-fortnite)[![Audio Troubleshooting](https://dev.epicgames.com/community/api/documentation/image/b3caded9-a92a-4682-91dd-ee1acc7fdfa4?resizing_type=fit&width=640&height=640)

Audio Troubleshooting

Answers to common audio issues in Unreal Editor for Fortnite.](https://dev.epicgames.com/documentation/en-us/fortnite/audio-troubleshooting-in-unreal-editor-for-fortnite)
