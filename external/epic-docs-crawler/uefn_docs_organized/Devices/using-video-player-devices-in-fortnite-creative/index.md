# Video Player Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-video-player-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:30:47.451560

---

You can add media to your gameplay with the **Video Player** device that incorporates Fortnite-themed music videos. You can also set up these devices to be controlled by players or other devices.

Though multiple instances of the same video can be shown, only one video stream can play at a time.

You can use triggers, such as [Timers](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative), to automatically play a video through [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#event) like **Enable When Receiving From** and **Disable When Receiving From**.

Through settings like **Interact Time**, you can also control whether players can directly turn videos on or off.

You can customize the video presentation by changing the device's shape, and adjust the distance at which the videos can be heard.

To find the Video Player device, go to the **Creative inventory** and select the **Devices** tab. From there, you can search or browse for the device. For more information on finding devices see [**Finding and Placing Devices**](using-devices-in-fortnite-creative#findingandplacingdevices).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This device has some basic functionality that allows you to change the device’s volume and interaction time. You can also use channel signals to alternate collision settings and playback for this device.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Video to Play** | **Come On Down**, Jungle Jam, Rifting Reality, In The Clouds, Toon Takeover, Jukebox Joint, Current Default Party Royale Mix | The selected video will play when this device takes control. For descriptions, see [Video Choices](https://dev.epicgames.com/documentation/en-us/fortnite/using-video-player-devices-in-fortnite-creative) below. |
| **Play Automatically** | **Yes**, No | Determines if the selected video will stream on all players. |
| **Stream Priority** | Never Select, **0**, Pick a number | Higher priority streaming devices are chosen to stream first when the stream is not forced to a specific device. |
| **Enabled During Phase** | None, **All**, Gameplay Only, Create Only | Determines the game phases during which the device will be enabled. |
| **Screen Shape** | **Default**, Circular, Curved, Portrait, Square, Triangular, Half-Circle | Sets the shape for the device screen.See the [screen shape](https://dev.epicgames.com/documentation/en-us/fortnite/using-video-player-devices-in-fortnite-creative) options below. |
| **Show Border** | **On**, Off | This determines whether a border is shown for the device if the selected shape supports borders. |
| **Volume** | **1.0X**, Pick a multiplier | Determines the volume multiplier for the device. This is only used if this device is the controlling streaming device. |
| **Attenuation Distance** | **Island**, Pick a distance | Determines how far the audio sound travels. This setting is only used for the controlling streaming device. |
| **Restart When This Stream Is Loaded** | Yes, **No** | When this stream is chosen, this option will restart the video at the beginning when loading. |
| **Looping** | **Yes**, No | This determines whether the video stops when it reaches the end, or plays again from the beginning. |
| **Behavior on Other Stream Playing** | **Play Other Stream**, Stop Playing Current | Only one stream can be played at a time. This determines what happens when another streaming device takes control. |
| **Triggered Seek Time** | **0 Seconds**, Pick an amount | When using the **Seek When Receiving From** function, this determines the time (in seconds) to which the video is set. |
| **Can Interact** | ***Yes***, No | If set to **Yes**, players can turn the video on and off in-game, and the **Interaction Time** option is displayed below. |
| **Interact Time** | **Instant (0.0)**, Pick a time | This option only displays if the **Can Interact** option is set to **Yes**. Determines how long it takes for a player to toggle the switch to turn the video player on or off. |
| **Picture in Picture** | **No**, *Yes* | Determines if players can set Picture in Picture. If set to **Yes**, additional options related to Picture in Picture (PIP) will display below. |
| **Always Allow PIP** | **No**, *Yes* | This option only shows if **Picture in Picture** is set to **Yes**. If **Always Allow PiP** is set to **No**, the **Picture-in-Picture Trigger Range** option displays below. |
| **Picture-in-Picture Trigger Range** | **250M**, Pick a distance | This option only displays when the **Always Allow PIP** option is set to **No**. Use this setting to determine the distance at which PIP will be visible. |
| **Set Collision** | **Enabled**, Disabled | Determines whether players can pass through the device. |
| **Use Greenscreen** | **Disabled**, *Enabled* | Determines if a greenscreen is present. When you select **Enabled**, you can set a color and a transparency value for the greenscreen in the two options that display below. |
| **Greenscreen Color** | **Green**, Pick a color | Sets the target color for greenscreening. To change from the default, click the color to open the Color Picker. Click in the search field and type to locate a specific color, or use the scroll bar to browse. Click a swatch to select a color, then click the checkmark to close the Color Picker. |
| **Use Manual Color Entry** | **Disabled**, *Enabled* | Determines if you can enter RGB values manually to set the greenscreen color. If this is set to **Enabled**, the **Greenscreen Color** option is hidden, and three more options display below. |
| **Manual Color (Red)** | **0**, Pick a value | This option only displays if the **Use Manual Color Entry** option is set to **Enabled**. Manually enter a color value for red. |
| **Manual Color (Green)** | **0**, Pick a value | This option only displays if the **Use Manual Color Entry** option is set to **Enabled**. Manually enter a color value for green. |
| **Manual Color (Blue)** | **0**, Pick a value | This option only displays if the **Use Manual Color Entry** option is set to **Enabled**. Manually enter a color value for blue. |
| **Cutoff Adjustment** | **0.5**, Set a value | Controls the tolerance for greenscreen color detection. A lower value means less tolerance when detecting the color to mask, and a higher value gives more tolerance for variations in the color. |
| **Show Color Values** | Yes, **No** | This shows the color values for screen locations during playback. This only functions when you are editing your island, and is a helpful tool for determining the RGB value of a video when using the Manual Color options. |
| **Force Fullscreen on Activation** | On, **Off** | Determines whether making the video fullscreen is optional or automatic. If this is set to **On**, the player cannot exit fullscreen normally. You will have to use events to exit them from fullscreen, or fullscreen will end when the video ends. |
| **Audience** | **Everyone**, Player, Party | Determines who will see the video. |

## Videos to Play

|  | Video | Description |
| --- | --- | --- |
| [Come On Down](https://dev.epicgames.com/community/api/documentation/image/152b6b52-20da-4305-a091-d4a94b620863?resizing_type=fit) | **Come On Down** | A country-themed video that encourages friends to visit the Butter Barn. |
| [Jungle Jam](https://dev.epicgames.com/community/api/documentation/image/60d4f65f-f599-439e-bc33-c77cfec60af5?resizing_type=fit) | **Jungle Jam** | A jungle-themed video of friends on their journey to a tropical dance party. |
| [Rifting Reality](https://dev.epicgames.com/community/api/documentation/image/5863ca96-38cf-4d88-908c-873d18a3ade3?resizing_type=fit) | **Rifting Reality** | An adventurous video of an expedition through various rifts. |
| [In The Clouds](https://dev.epicgames.com/community/api/documentation/image/27836e68-73e9-41e3-8b79-4a538cb351ea?resizing_type=fit) | **In The Clouds** | An upbeat video showing a hopeful journey to win back a partner. |
| [Toon Takeover](https://dev.epicgames.com/community/api/documentation/image/8cf01ad8-308e-4719-ae30-59307ac85443?resizing_type=fit) | **Toon Takeover** | A rap-themed video of Toon Meowscles and his friend’s journey to a concert performance. |
| [Jukebox Joint](https://dev.epicgames.com/community/api/documentation/image/0e9c2cdd-d2f9-467c-83e9-29d37a94aed7?resizing_type=fit) | **Jukebox Joint** | A randomized mix of back-to-back videos. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#function) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Stop All Streaming When Receiving From** | Turns off all video devices of this type when an event occurs. |
| **Seek When Receiving From** | Seek to a triggered seek time when this event occurs. While the video buffer is loading, the stream will pause. |
| **Restart When Receiving From** | When an event occurs, this will restart the stream on the triggered device from the beginning. |
| **Enable Collision When Receiving From** | Enable collision on this device when an event occurs. |
| **Disable Collision When Receiving From** | Disable collision on this device when an event occurs. |
| **Enable Visibility When Receiving From** | When an event occurs, this enables the video player visibility. This also enables collision based on the **Enable Collision** setting above. |
| **Disable Visibility When Receiving From** | Disables both visibility and collision when an event occurs. |
| **Make PIP Full Screen When Receiving From** | Set the picture-in-picture (PIP) to full screen when an event occurs. |
| **Make PIP Default Size When Receiving From** | Set the PIP to default size when an event occurs. |
| **Hide PIP When Receiving From** | Hide the PIP window when an event occurs. |
| **Enter Full Screen When Receiving From** | Set the device to full screen when an event occurs. |
| **Exit Full Screen When Receiving From** | Exit full screen when an event occurs. |
| **Remote Video Start When Receiving From** | Start the video remotely when an event occurs. |
| **Mirror Another Screen When Receiving From** | When an event occurs, this screen mirrors another screen. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Stream Started Send Event To** | If you have multiple video players on your island, only one at a time can stream. This sends an event to linked devices when this device becomes the controlling streaming device. |
| **Mirror This Screen Send Event To** | This event causes the selected video player to mirror what is streaming on this screen. |
| **On Stream Ended** | When the stream ends, an event is sent to the selected device, which triggers the selected function. |
