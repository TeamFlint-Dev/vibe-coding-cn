# Audio Player Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:43:51.663128

---

Use the Audio Player device to play special sound effects during your game. Choose from a large number of one-time sound effects.

If you are using UEFN, you can also create custom audio and map it to this device. See [Audio Player Device](https://dev.epicgames.com/documentation/en-us/uefn/using-audio-player-devices-in-unreal-editor-for-fortnite) for more information.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

text here

| Option | Values | Description |
| --- | --- | --- |
| **Enabled During Phase** | Always, None, Pre-Game Only, Gameplay Only, Create Only | Determines which phases in which the device is enabled. |
| **Restart Audio when Activated** | On, **Off** | Determines whether the audio will restart when it is triggered to play. If this is set to **Off**, activations will be ignored if audio is already playing. |
| **Audio** | Pick an audio cue or sound effect | This is the cue or sound effect that plays when the device is activated. |
| **Volume** | **1.0**, Select a Volume | Sets the volume for the audio. This is a linear setting, so 0.5 is half as loud and 2.0 is twice as loud as the source audio volume. |
| **Visible in Game** | On, Off | Determines whether the device will be visible during the game. |
| **Play on Hit** | On, Off | Determines whether the audio will play when the device is hit by the player. |
| **Can be Heard By** | **Everyone**, Instigator Only, Registered Players Only, Non-Registered Players Only | Determines who will be able to hear audio from this device. |
| **Play Location** | **Device**, Local Player, Registered Players, Instigating Players | Determines if the audio should be played from the device location, or the location of a player. |
| **Playback Speed** | **1.0**, Select a Play Rate | Raises or lowers the pitch of the audio by changing the playback speed. 2.0 is twice as fast, 0.5 is half-speed as the source audio volume. |
| **Fade In Duration** | **0.0**, Select a Duration | The time it takes the sound to reach full volume in seconds when the device is triggered to play. |
| **Fade Out Duration** | **0.0**, Select a Duration | The time it takes the sound to reach full volume in seconds when the device is triggered to stop. |
| **Mesh** | **Speaker**, Loudspeaker | Determines the visual appearance of the device's mesh. |
| **Enable Spatialization** | ***On***, Off | Enables audio panning based on position relative to the listener. If this is set to **Off**, the **Stereo Spread** option is not displayed. |
| **Stereo Spread** | **0.0**, Pick an amount | This option only displays if the **Enable Spatialization** option is set to **On**. This setting sets the distance between the virtual left and right speakers, with the play location at the center of the spread. |
| **Enable Volume Attenuation** | *On*, Off | Enables volume changes based on the device's proximity to the listener. Source audio will become quieter the further the listener is from the location of the sound. If this is set to **Off**, several attenuation options are not displayed. |
| **Attenuation Function** | **Linear**, Logarithmic | Defines the mapping function between the value of the **Attenuation Min** **Distance** option and the value of the **Attenuation Falloff** **Distance**  option. |
| **Attenuation Min Distance** | **4.0**, Set a Distance | The range in which the audio will remain at the value set in the **Volume** setting. |
| **Attenuation Falloff Distance** | **32.0**, Set a Distance | The range from the **Attenuation Min Distance** over which the sound will go from the value set in the  **Volume** option to silent. |
| **Enable Attenuation Visuals** | On, Off | If this is set to **On**, there are visual effects. |
| **Sync Player Audio** | On, **Off** | Determines whether the audio played is synchronized for all player devices. This is best used when you are playing a longer audio piece, such as music or dialogue. |
| **Auto Play - Create** | On, **Off** | If this is set to **On**, the chosen audio will automatically play during Create Mode. |
| **Auto Play - Waiting For Players** | On, **Off** | If this is set to **On**, the chosen audio will automatically play during the Waiting For Players phase. |
| **Auto Play - Countdown** | On, **Off** | If this is set to **On**, the chosen audio will automatically play during the Countdown phase. |
| **Auto Play - Gameplay** | On, **Off** | If this is set to **On**, the chosen audio will automatically play during the game. |
| **Auto Play - Round End** | On, **Off** | If this is set to **On**, the chosen audio will automatically play when a round ends. |
| **Auto Play - Game End** | On, **Off** | If this is set to **On**, the chosen audio will automatically play when the |

## Direct Event Binding

  Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/function) listens for an event on a device, and then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Play**When Receiving From | Plays the selected audio when an event occurs. |
| **Stop When Receiving From** | Stops the audio when an event occurs. |
| **Enable**When Receiving From | Enables the device when an event occurs. |
| **Disable**When Receiving From | Disables the device when an event occurs. |
| **Register Player**When Receiving From | When an event occurs, the player is registered as a target for the audio player. |
| **Unregister** **Player**When Receiving From | When an event occurs, the player is unregistered as a target for the audio player. |
| **Unregister** **All** **Players**When Receiving From | When an event occurs, all players are unregistered as targets for the audio player. |

### Events

This device has no events.
