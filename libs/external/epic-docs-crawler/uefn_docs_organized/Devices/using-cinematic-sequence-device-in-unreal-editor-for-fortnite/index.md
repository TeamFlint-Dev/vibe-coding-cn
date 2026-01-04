# Cinematic Sequence Device

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:05:30.289548

---

The **Cinematic Sequence** device provides a way to add [cinematic sequences](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#cinematic-sequence) to levels, allowing you to add custom [keyframe](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#keyframe) animation on a non-linear timeline.

Think of it as creating a cutscene to showcase an enemy's capabilities, an important cinematic that shows how to perform a task, or an exchange between characters to drive the story.

For more informaiton on how to use the device with a level sequence, see [Sequencer and Control Rig](https://dev.epicgames.com/documentation/en-us/uefn/sequencer-and-control-rig-in-unreal-editor-for-fortnite).

This device uses a lot of [memory](https://dev.epicgames.com/documentation/en-us/fortnite/memory-used-bar) and requires a lot of computing power to add animations. Loading one Cinematic Sequence device on your island will take a few seconds, so use caution when adding multiples of this device on the same island.

The amount of memory the device takes is largely dependent on the complexity of the asset it plays. Playtest your sequences to make sure they run smoothly in Fortnite Creative.

## Finding and Placing the Device

1. Open the **[Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-browser)**.
2. Open the **Fortnite** folder index list.
3. Open the **Devices** folder.
4. Select the **Cinematic Sequence** device and click-and-drag the device into the **viewport**.
5. Select the **Cinematic Sequence** device in the **Outliner** panel.
6. Configure the **User Options** for the **Cinematic Sequence** device in the **Details** panel.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://www.fortnite.com/en-US/creative/docs/fortnite-creative-glossary#rename-a-device) them. You can choose [names](outliner-tips-and-tricks-in-unreal-editor-for-fortnite) that relate to each device’s purpose, so it’s easier to remember what each one does.

## User Options

This device plays a pre-authored [Level Sequence](https://dev.epicgames.com/documentation/en-us/unreal-engine/level-sequence-settings-in-the-unreal-engine-project-settings?application_version=5.5) when triggered by another device. Drag the device into the **viewport** where you can change the device’s scale, [axis](unreal-editor-for-fortnite-glossary#axis) (X, Y, and Z), and rotation. Pull the device by its Z-axis to make the base visible and to make it sit on the level plane.

[![The Cinematic Sequence device in the viewport](https://dev.epicgames.com/community/api/documentation/image/5b97f6f7-7c8b-4f26-9d2c-bfff05ef4581?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5b97f6f7-7c8b-4f26-9d2c-bfff05ef4581?resizing_type=fit)

This is how the device displays in the viewport while editing, not how it displays on the island during playtest.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Sequence** | Select a sequence from the dropdown menu. | The sequence is the animation you want to play with the device. |
| **Loop Playback** | Toggle the option **On** to use. | Loops the **Level Sequence** until stopped. |
| **Finish Completion State Override** | **None**, Force Keep State, Force Restore State | Determines how to handle the tracks' state after the **Level Sequence** has completed.   - **Force Keep State**: Forces the Level Sequence to keep its state when the track ends. - **Force Restore State**: Forces the Level Sequence to restore its state when the track ends. |
| **Auto Play** | Toggle the option **On** to use. | Starts playing the **Level Sequence** when the game starts. Toggling this option on causes the Enabled on Phase option to become highlighted. |
| **Enabled on Phase** | **Gameplay Only**, Always, Pre-Game Only, Create Only | Determines which mini-game phase of the sequence to play if Auto Play is checked on.   - **Gameplay Only:** The level sequence plays during gameplay. - **Always:** Plays during any game state. - **Pre-Game Only:** Plays the level sequence before the game starts. - **Create Only:** Plays before the game starts when the island is in read only state. |
| **Visibility** | **Everyone**, Instigator Only, Instigator's Team | Specify who is able to see the device playback. |
| **Level Sequence Actor Always Relevant** | **On**, Off | Specifies if the device should always be relevant for networking. When turned off, the device playback only replicates to clients based on proximity. For example, if as a player you aren’t seeing objects from a certain distance during playback, this option should be turned on. |

## Direct Event Binding

Devices in UEFN use **Direct****Event Binding** to communicate. To set event binding for your device:

1. Select the device in the **Outliner** panel.
2. Open the **Details** panel.
3. Navigate to **User Options-Function**.
4. Select a **device** to interact with.
5. Set the **function** that this device performs when the Cinematic Sequence triggers the device.

### Functions

A [**function**](unreal-editor-for-fortnite-glossary#function) tells the selected device what it needs to do when the triggering device performs an action.

| Option | Value | Description |
| --- | --- | --- |
| **Play Function** | Click the **Add** icon to select a function from the dropdown menu, then select a device to trigger the function. | Plays the cinematic when the selected device and event triggers the Cinematic Sequence device. |
| **Pause Function** | Click the **Add** icon to select a function from the dropdown menu, then select a device to trigger the function. | Pauses the cinematic when the selected device and event trigger the Cinematic Sequence device. |
| **Stop Function** | Click the **Add** icon to select a function from the dropdown menu, then select a device to trigger the function. | Stops the cinematic when the selected device and event trigger the Cinematic Sequence device. |
| **Toggle Pause Function** | Click the **Add** icon to select a function from the dropdown menu, then select a device to trigger the function. | Toggles the **Level Sequence** between play and pause when the Cinematic Sequence is triggered by the selected device and event. |

### Events

An [**event**](unreal-editor-for-fortnite-glossary#event) describes an action executed by the selected device. The selected event triggers a function.

| Option | Value | Description |
| --- | --- | --- |
| **Cinematic Sequence device** | On Stopped Event | Sends an event when the **Level Sequence** is stopped. |
