# Audio Player Device

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/audio-player-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:37:44.611131

---

Use the **Audio Player** device to play audio in your project with your own custom [sound waves](unreal-editor-for-fortnite-glossary#sound-wave) and [sound cues](unreal-editor-for-fortnite-glossary#sound-cue).

## Finding and Placing the Device

1. Open the **Content Browser.**
2. Open the **Fortnite** folder index list.
3. Open the **Devices** folder.
4. Select the **Audio Player** device and drag the device into the **viewport**.
5. Select the **Audio Player** device in the **Outliner** panel.
6. Configure the **User Options** for the **Audio Player** device in the **Details** panel.

## User Options

This device plays a sound wave or sound cue asset when activated. When added to the viewport, the Audio device will appear as a small speaker. This mesh can be hidden during the game or customized to suit the world you are creating.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Audio** | Select a sound wave or sound cue | The audio to play when the device is triggered to play. |
| **Volume** | **1.0**, Select a Volume | Sets the volume for the audio. This is a linear setting, so 0.5 is half as loud and 2.0 is twice as loud as the source audio volume. |
| **Visible in Game** | **False**, True | Determines whether the device will be visible during the game. |
| **Fade in Duration** | **0.0**, Select a Duration | The time it takes the sound to reach full volume in seconds when the device is triggered to play. |
| **Fade Out Duration** | **0.0**, Select a Duration | The time it takes the sound to reach full volume in seconds when the device is triggered to stop. |
| **Enabled During Phase** | **Always**, None, Pre-Game Only, Gameplay Only, Create Only | Determines the game phase in which the device is automatically enabled. |
| **Restart Audio when Activated** | **False**, True | Determines whether audio will restart when triggered to play. If not set, activations will be ignored if audio is already playing. |
| **Play on Hit** | **True**, False | Determines whether the audio will play when hit by the player. |
| **Can be Heard By** | **Everyone**, Instigator Only, Registered Players Only, Non-Registered Players Only | Determines who will be able to hear audio from this device. |
| **Play Location** | **Device**, Local Player, Registered Players, Instigating Players | Determines if the audio should be played from the device location or the location of any registered players. |
| **Playback Speed** | **1.0**, Select a Play Rate | Raises or lowers the pitch of the audio by changing the playback speed. 2.0 is twice as fast, 0.5 is half-speed as the source audio volume. |
| **Enable Spatialization** | **True**, False | Enables audio panning based on position relative to the listener. |
| **Enable Volume Attenuation** | **True**, False | Enables volume changes based on proximity to the listener. Source audio will become quieter the further the listener is from the location of the sound. |
| **Attenuation Function** | **Linear**, Logarithmic | Defines the mapping function between the Attenuation Min Distance and Attenuation Falloff Distance. |
| **Attenuation Min Distance** | **4.0**, Set a Distance | The range in which the audio will remain at the value set in the Volume setting. |
| **Attenuation Falloff Distance** | **32.0**, Set a Distance | The range from Attenuation Min Distance over which the sound will go from set Volume to silent |
| **Enable Attenuation Visuals** | **False**, True | If set, shows additional attenuation visuals while editing. |

### Direct Event Binding

Devices in UEFN use **Event Binding** to communicate. To set direct event binding for your device in UEFN:

[![audio player functions](https://dev.epicgames.com/community/api/documentation/image/a132fc58-781d-41cc-80ad-5ac76aee49cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a132fc58-781d-41cc-80ad-5ac76aee49cb?resizing_type=fit)

1. Select the device in the **Outliner** panel.
2. Open the **Details** panel.
3. Navigate to **User Options-Functions**.
4. Add an element to a function.
5. Select a **device** to interact with.
6. Set the **function** the device performs to send a trigger to the **Audio Device**.

### Functions

A **function** tells the selected device what should do when the triggering device performs an action.

| Option | Value | Description |
| --- | --- | --- |
| **Play** | Click the **Add** icon to select a device, then select an event. | Plays the audio when the selected device and event triggers the Audio Player device. Requires the device to be **Enabled**. |
| **Stop** | Click the **Add** icon to select a device, then select an event. | Stops the audio when the selected device and event triggers the Audio Player device. |
| **Enable** | Click the **Add** icon to select a device, then select an event. | Enables the audio device when the selected device and event triggers the Audio Player device, if not already enabled by the **Enabled During Phase option.** |
| **Disable** | Click the **Add** icon to select a device, then select an event. | Disables the audio device when the selected device and event triggers the Audio Player device. |
| **Register Player** | Click the **Add** icon to select a device, then select an event. | Registers a player as a target for audio to play from when the selected device and event triggers the Audio Player device. |
| **Unregister Player** | Click the **Add** icon to select a device, then select an event. | Unregisters a player as a target for audio to play from when the selected device and event triggers the Audio Player device. |
| **Unregister All Players** | Click the **Add** icon to select a device, then select an event. | Removes all registered players as targets for audio to play from when the selected device and event triggers the Audio Player device. |

## More Topics

[![Adding Audio to Your Project](https://dev.epicgames.com/community/api/documentation/image/4120c4ca-d9f0-4179-95fe-10297986b79e?resizing_type=fit&width=640&height=640)

Adding Audio to Your Project

Add audio to a project.](https://dev.epicgames.com/documentation/en-us/fortnite/adding-audio-to-your-project-in-unreal-editor-for-fortnite)[![The Audio Mixer Device](https://dev.epicgames.com/community/api/documentation/image/36ccfbcb-c8fd-4297-88a7-4d90754a1f69?resizing_type=fit&width=640&height=640)

The Audio Mixer Device

Adjust volumes of sound groups using the Audio Mixer device.](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-mixer-devices-in-unreal-editor-for-fortnite)[![Importing Custom Audio](https://dev.epicgames.com/community/api/documentation/image/54adc69d-66fe-4b57-8b03-df9597f7f562?resizing_type=fit&width=640&height=640)

Importing Custom Audio

Import custom audio into your island and immerse players in the world of your creation.](https://dev.epicgames.com/documentation/en-us/fortnite/importing-custom-audio-in-unreal-editor-for-fortnite)[![Audio Troubleshooting](https://dev.epicgames.com/community/api/documentation/image/b3caded9-a92a-4682-91dd-ee1acc7fdfa4?resizing_type=fit&width=640&height=640)

Audio Troubleshooting

Answers to common audio issues in Unreal Editor for Fortnite.](https://dev.epicgames.com/documentation/en-us/fortnite/audio-troubleshooting-in-unreal-editor-for-fortnite)
