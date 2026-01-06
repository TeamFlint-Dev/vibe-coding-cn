# Animated Mesh Device

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-animated-mesh-device-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:04:37.661694

---

The **Animated Mesh** [device](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#device) provides a way for creators to play animations on [skeletal meshes](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#skeletal-mesh) ([FBX files](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#fbx)) with FBX animation files in Unreal Editor for Fortnite (UEFN). Think of it as creating a new actor for players to interact with.

For example:

- Create a boss for players to fight at the end of a level.
- Create a new NPC that players can interact with.
- Move or animate a [prop](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#prop).
- Create special animations to use in conjunction with the [Cinematic Sequence device](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) to create a [cutscene](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#cutscene) between [levels](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#level).

The device [memory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) depends on the referenced animation sets.

Playtest your animations to make sure that they work in Fortnite Creative.

## Finding and Placing the Device

1. Open the [Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-browser).
2. Open the **Fortnite** folder index list.
3. Open the **Devices** folder.
4. Select the **Animated Mesh** device and drag the device into the **viewport**.
5. Select the **Animated Mesh** device in the **Outliner** panel.
6. Customize the options for the **Animated Mesh** device in the **Details** panel.

If you're using multiple copies of a device on an island, it can be helpful to rename them. Choose [names](https://dev.epicgames.com/documentation/en-us/uefn/outliner-tips-and-tricks-in-unreal-editor-for-fortnite) that relate to each device’s purpose, so it’s easier to remember what each one does.

## User Options

This device applies animations to a skeletal mesh. Drag the device into the **viewport** where you can change the device’s scale, [axis](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#axis) (X, Y, and Z), and rotation. Pull the device by its Z-axis to make the base visible, and make it sit on the level plane.

[![The Animated Mesh device in the viewport](https://dev.epicgames.com/community/api/documentation/image/9d6cf539-a310-4991-9434-78422fa9e140?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d6cf539-a310-4991-9434-78422fa9e140?resizing_type=fit)

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Loop** | **True**, False | Loops the animation. |
| **Play Rate** | **1.0**, Select a Play Rate | Sets the speed and rate the animation plays at. |
| **Skeletal Mesh** | Select a skeletal mesh file from the dropdown menu. | Attaches the selected skeletal mesh to the device. |
| **Animation** | Select an animation file from the dropdown menu. | Attaches the animation file to the device. |

## Direct Event Binding

Devices in UEFN use **Direct Event Binding** to communicate. To set direct event binding for your device in UEFN:

1. Select the device in the **Outliner** panel.
2. Open the **Details** panel.
3. Navigate to **User Options-Function**.
4. Select a **device** to interact with.
5. Set the **function** the device performs when the **Animated Mesh** triggers the device.

### Functions

A **[function](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary)** tells the selected device what it needs to do when the triggering device performs an action.

| Option | Value | Description |
| --- | --- | --- |
| **Play Animation Event** | Click the **Add** icon to select a device, then select an event. | Plays the animation when the selected device and event triggers the Animated Mesh device. |
| **Pause Animation Event** | Click the **Add** icon to select a device, then select an event. | Pauses the animation when the selected device and event triggers the Animated Mesh device. |
| **Play Reverse Animation Event** | Click the **Add** icon to select a device, then select an event. | Plays the animation in reverse when the selected device and event triggers the Animated Mesh device. |
