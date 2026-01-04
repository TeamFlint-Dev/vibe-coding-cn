# Audio Troubleshooting

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/audio-troubleshooting-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:16:01.109649

---

### How do I add custom audio?

The easiest way to add custom audio is by dragging your audio assets from your desktop into the Content Browser to get them into your project.

Use an **Audio Player** device and make sure to select the right audio file. Set the device to **Auto Play**, or trigger **Play** through **User Options - Functions**.

You can import audio up to 300 seconds long. You must own the copyright for any audio you import or it will fail content validation and/or be flagged. Your imported audio is also expected to follow our [Fortnite Creator Rules](https://www.fortnite.com/news/fortnite-island-creator-rules).

### What audio formats are supported?

The supported formats are: WAV, AIF, OGG and FLAC.

### How can I loop audio?

You can loop audio indefinitely by using the **Looping** setting of the Wave Player node in a [sound cue](unreal-editor-for-fortnite-glossary#sound-cue). You can also add a looping node in a sound cue and set the number of times you want to loop.

See how it’s done in this [video](https://youtu.be/oirU_YcUcdM?t=324) and follow the steps in the documentation to [create a sound cue](adding-audio-to-your-project-in-unreal-editor-for-fortnite#creatingsoundcues).

### How can I set up audio so it’s not coming from a source location?

To add audio that doesn’t [attenuate](unreal-editor-for-fortnite-glossary#attenuation) (get louder or quieter as you change your distance from the source), you can uncheck **Enable Volume Attenuation** .

If you also want to prevent the audio from panning (get louder in the right/left speaker as you rotate from source), you can uncheck **Enable Spatialization**.

This would work for something like background music, which isn’t coming from set locations on your island.

### Why isn’t my audio playing in my Audio Player device?

Here are a few things you can look into:

- Check that you can hear audio from a source other than UEFN. (We all forget to unmute volume from time to time.) Next, is the asset you are trying to play audible? You can quickly find the asset in the content browser. Press the **spacebar** or the **Play** icon to test whether the asset itself is audible.
- Check the **Visible in Game** setting of the device to help you find where the speaker has been dropped into the world:

  - The Audio Player device needs an event to trigger the audio, or to have **Auto Play** enabled.
  - The **Play on Hit** setting is enabled by default. You can walk up to the device and hit it to confirm whether it makes a sound.
    Check that **Volume** hasn't been set to 0. You can also increase the value if the source audio is quiet or being drowned out by other audio playing.
    Try unchecking **Enable Volume Attenuation**. This should make the audio audible on the entire island. If you hear audio at this point, it’s likely attenuation was not set correctly. You can learn more about attenuation settings [here](audio-player-in-unreal-editor-for-fortnite).  
    Check that **Enabled During Phase** setting is set to what you expect. If it’s enabled for pre-game only, you won’t hear it in-game. By default, it’s enabled for all phases.

### How can I randomize from a set of audio assets?

Multi-select all relevant assets in the Content Browser and right-click to select **Create Single Cue**. This will create a [sound cue](unreal-editor-for-fortnite-glossary#sound-cue) that you can access in the Audio Player device **Audio** field. If you want, you can open the sound cue you just created, and set weights to the randomization, along with other behaviors. See [this video](https://youtu.be/oirU_YcUcdM?t=134) for a demonstration.

### What’s the difference between the Radio and Audio Player devices?

The [Radio](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-radio-devices-in-fortnite-creative) is a device that has been available since FN Creative, and can be used to play Fortnite music and ambient sound effects. The [Audio Player device](audio-player-in-unreal-editor-for-fortnite) was introduced with UEFN to support the latest features. It is recommended that you use the Audio Player device whenever possible.

### How can I trigger audio from Sequencer?

There are two ways to add audio to Sequencer:

- You can attach an Audio Player device to an actor in Sequencer by selecting the Audio Player in the Outliner and dragging it onto the appropriate actor. This will parent the Audio Player to the Sequence actor and the Audio device will move relative to the actor. You will still need to move the Audio device near the actor in the viewport. This provides a quick way to have audio attenuate with moving objects (such as a vehicle that is moving away from the player) without having to match the location of the Audio Player device with the actor it’s supposed to follow.
- You can also add an audio track directly to Sequencer. Just note that you won’t be able to attenuate and spatialize audio if you use this method.

You cannot send an event from a level sequence to trigger other devices at this time. A workaround is to use a timer device that you trigger at the same time as the Cinematic Sequence device that is timed to a specific time in the level sequence.

### How can I turn off Footsteps audio, or change audio volume relative to other audio?

The **Audio Mixer** device can be used for this. See [Audio Mixer](audio-mixer-in-unreal-editor-for-fortnite) to learn more.

### Want more resources?

Watch the video series [Working With Audio in Unreal Editor For Fortnite](https://www.youtube.com/watch?v=04XmgG1QhoE&list=PLVtTf6W_xnNSx5vMiPE7VZbEa0eVidrM-). It provides a great overview for new users, along with very practical examples.

## More Topics

[![Audio Player Device](https://dev.epicgames.com/community/api/documentation/image/b75bc25e-8809-400a-b3bf-fbc937a8cec8?resizing_type=fit&width=640&height=640)

Audio Player Device

Import, play and customize sound waves and sound cues.](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-unreal-editor-for-fortnite)[![The Audio Mixer Device](https://dev.epicgames.com/community/api/documentation/image/36ccfbcb-c8fd-4297-88a7-4d90754a1f69?resizing_type=fit&width=640&height=640)

The Audio Mixer Device

Adjust volumes of sound groups using the Audio Mixer device.](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-mixer-devices-in-unreal-editor-for-fortnite)[![Importing Custom Audio](https://dev.epicgames.com/community/api/documentation/image/54adc69d-66fe-4b57-8b03-df9597f7f562?resizing_type=fit&width=640&height=640)

Importing Custom Audio

Import custom audio into your island and immerse players in the world of your creation.](https://dev.epicgames.com/documentation/en-us/fortnite/importing-custom-audio-in-unreal-editor-for-fortnite)[![Adding Audio to Your Project](https://dev.epicgames.com/community/api/documentation/image/4120c4ca-d9f0-4179-95fe-10297986b79e?resizing_type=fit&width=640&height=640)

Adding Audio to Your Project

Add audio to a project.](https://dev.epicgames.com/documentation/en-us/fortnite/adding-audio-to-your-project-in-unreal-editor-for-fortnite)
