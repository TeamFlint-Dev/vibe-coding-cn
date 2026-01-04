# Post Process Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-post-processing-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:36:30.472582

---

**Post-processing** refers to customizable filters that you can use to create specific visual effects. Most of these filters primarily affect lighting.The **Post Process** device provides a way to apply these different effects on your island.

You may recognize some of the effects from the **camera filters** in **Island Settings** under the [**World**](world-settings-in-fortnite-creative) category, but this device provides even more options.

For a Post Process effect to work correctly, make sure the **Camera Filter** option in the World category is set to **Default (none)**.

Apply these effects to a specific player, throughout an entire island, or set up different effects to happen based on user interactions or activation by other devices. You can also set the effect to remain indefinitely, or to turn off after a specified time or based on [event bindings](https://dev.epicgames.com/documentation/en-us/fortnite/using-post-processing-devices-in-fortnite-creative).

You can control transitions between different effects or from no effect to effect and back again by using the **blend** options to set how an effect blends from one state to another.

These effects can be used to simulate or enhance environmental factors or character moods or attitudes.

Using UEFN? Learn more about [post-process effects](https://dev.epicgames.com/documentation/en-us/uefn/intro-to-post-processing-in-unreal-editor-for-fortnite) in our UEFN and Verse documentation.

For help on how to find the **Post Process** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [**Event Browser**](event-browser-in-fortnite-creative).

## Device Options

Configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled During Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Sets the phase in which the device will be enabled. |
| **Post Process Effect** | **None**, Pick an effect | This is the effect that is applied when the device is enabled. See [Effect Options](https://dev.epicgames.com/documentation/en-us/fortnite/using-post-processing-devices-in-fortnite-creative) below for more info on each effect. |
| **Effect Duration** | **Infinite**, Pick a time in seconds | How long the post process effect will last. **Infinite (0)** continues the effect indefinitely, or you can set a time for when it starts blending out. |
| **Priority** | **0**, Pick a priority | If you're using more than one effect and they overlap, this determines which effect will display. If two or more effects have the same priority, they will attempt to blend together, but they may not blend the same way for every player. |
| **Starting Strength** | **1.0**, Pick a value | How strong the effect you use is at the start. The higher the value, the more intense the effect is. The value you set here clamps to **Blend In Strength**. |
| **Blend In Strength** | **0.0**, Pick a value | How strong the effect is when blended in. |
| **Blend In Duration** | **0.0**, Pick a time in seconds | How long it takes for a blend to go from 0 strength to full blend. |
| **Blend Out Duration** | **0.0**, Pick a time in seconds | How long it takes for a blend to go back to 0 strength. |
| **Applies to Team** | **Any**, Pick a team | Sets which team can activate the device and see the effect. |
| **Applies to Class** | **Any**, Pick a class | Sets which class can activate the device and see the effect. |

## Effect Options

| Effect | What It Looks Like |
| --- | --- |
| **None**: How things look with no effect applied. |  |
| **Oak**: Washes out the color and shadows and applies subtle outlines. |  |
| **Dark**: Makes things look pretty danged dark. Good for creating a night setting. |  |
| **Film Noir**: Gives everything a washed-out black-and-white effect. |  |
| **Film Warm**: Warms up the appearance by increasing the yellow. |  |
| **Happy Place**: Uses a cheerful palette that makes your island scene look fun! |  |
| **Pixelizer**: Pixelizes the image in a way that conjures up old video game consoles from last century. |  |
| **Red**: Gives everything a red hue. |  |
| **Sepia**: Gives the scene a reddish-brown hue, like an old Wild West photograph. |  |
| **Crazy**: This effect makes your players want to emote like no one's watching! The solarization effect reverses colors in unexpected ways. |  |
| **Retro**: Outlines images with a glowing line. |  |
| **Spooky**: Desaturates the colors just enough to create an edgy feeling. |  |
| **Neon Party**: Applies a neon glow to things, but more subtly than the retro effect does. |  |
| **Horror Movie**: Washes out color, but less so than the low exposure effect. |  |
| **Old Cartoon**: Applies outlines similarly to Comic, but in black and white. It also adds a static effect that simulates old film moving through an analog projector. |  |
| **Desolate**: Deepens shadows regardless of time-of-day setting, which creates a feeling of foreboding. |  |
| **Halftone**: A bright effect that uses a texture similar to Comic and Neocomic. |  |
| **CCTV**: Shows a low-fidelity image in monochrome as though you're watching over a closed-circuit security camera. |  |
| **70s Print**: This effect is reminiscent of a Polaroid snapshot that has faded over decades. |  |
| **Action Lines**: Dynamic lines radiating outward from the character and action. This effect can convey excitement when a character reacts to something dramatically. |  |
| **Comic**: Applies an outline to details. |  |
| **Low Exposure**: Washes out much of the color and contrast, the way an underexposed photo would. |  |
| **Neocomic**: Intensifies contrast, and adds subtle outlines. |  |
| **Nightvision**: Seeing the world through night-vision goggles makes this effect great for stealth games or missions. |  |
| **Radial Blur**: Creates a blur effect that radiates from a central point. |  |
| **Simple Blur**: Makes everything blurry. What the world looks like when some people take off their glasses. |  |
| **VHSfilter**: What things look like when a VHS tape that was played too many times, this is an effect that conjures a vibe from last century, right down to static on the screen and moving bands of color. |  |
| **Vignette**: An effect that simulates darkening in a real-world camera lens.Vignetting is mostly noticeable near the edges of the image. |  |
| **Heatwave**: A shimmery effect that mimics looking at things in extreme heat such as in a desert area. |  |
| **Rain**: Shows raindrops as though on the surface of the camera lens. This is useful when you're creating a rain environment, or when the camera is coming out of water. |  |
| **Frost**: An effect like frost on a window pane. It's primarily around the edges. |  |
| **80s Cartoon**: Applies outline similarly to Comic, but with brighter and flatter colors. |  |
| **Comic Noir**: Applies an outline like Comic or Old Cartoon, but has no static and includes a white border around the entire game screen. |  |
| **Heavy Linework**: Applies a black and white comic book filter with heavy linework around assets and characters on screen. |  |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable for All When Receiving From** | Enables the device for all players when an event occurs. |
| **Disable for All When Receiving From** | Disables the device for all players when an event occurs. |
| **Blend In for All When Receiving From** | Starts the Blend In from current strength to the Blend In Strength value for all players when an event occurs. |
| **Blend Out for All When Receiving From** | Starts the Blend Out from current strength to 0 value for all players when an event occurs. |
| **Reset for All When Receiving From** | Resets to the initial starting strength for all players when an event occurs. This also ends any ongoing blending. |
| **Enable for Instigator When Receiving From** | Enables the device only for the instigating player when an event occurs. |
| **Disable for Instigator When Receiving From** | Disables the device only for the instigating player when an event occurs. It also pauses (and hides) any ongoing blending until the device is re-enabled. |
| **Blend In for Instigator When Receiving From** | Starts blending in when an event occurs, but only for the instigating player. |
| **Blend Out for Instigator When Receiving From** | Starts blending out when an event occurs, but only for the instigating player. |
| **Reset for Instigator When Receiving From** | Resets to the initial starting strength when an event occurs, but only for the instigating player. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Blending In Is Send Event To** | Sends an event to a linked device when blending in is complete. |
| **On Blending Out Is Send Event To** | Sends an event to a linked device when blending out is complete. |
