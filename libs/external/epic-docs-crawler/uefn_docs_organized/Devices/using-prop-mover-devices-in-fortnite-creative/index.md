# Prop Mover Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:29:31.154080

---

The **Prop Mover** can be attached to any building piece, terrain piece, or other prop large enough for players to stand on. You can even attach it to devices! The preview sphere will turn green when it is near a prop or device it can attach to.

You can set the movement direction by rotating the Prop Mover device. When paired with other devices, you can expand the uses for this device to create intricate puzzles and traversal problems for players to solve. Here are some examples for how you can use this device:

- Use a [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative), [Conditional Button](https://dev.epicgames.com/documentation/en-us/fortnite/conditional-button), or [Switch](https://dev.epicgames.com/documentation/en-us/fortnite/using-switch-devices-in-fortnite-creative) device to signal the Prop Mover to stop, start, or change direction.
- Change the **Movement Mode** option to **Rotation** to flip or turn a moving prop so that sometimes it's safe to jump on, and sometimes it isn't safe to jump on.

  Use the Prop Mover to rotate the obstacles in the [Fall Guys Obstacle Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/fall-guys-obstacle-course-assets-in-fortnite-creative), to make your Fall Guys obstacle courses better!
- Place an [Objective](https://dev.epicgames.com/documentation/en-us/fortnite/using-objective-devices-in-fortnite-creative) device or [Capture Area](https://dev.epicgames.com/documentation/en-us/fortnite/using-capture-area-devices-in-fortnite-creative) device on a moving platform to make protecting these more challenging.
- Place [Target](https://dev.epicgames.com/documentation/en-us/fortnite/using-target-dummy-devices-in-fortnite-creative) devices on moving platforms to create a more sophisticated shooting gallery.
- Use the Prop Mover to simulate magical or psychic effects like levitation or telekinesis.
- Recreate your favorite [platformer games](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#platformer), with [collectible objects](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#collectible) placed on top of platforms and stationary props for players to scoop up.
- Add moving platforms to a [skillrun](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#skillrun) or [adventure](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#adventure) game, to make it even more challenging.

**Looking for more inspiration?** See [D-Launcher Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/dlauncher-device-design-examples-in-fortnite-creative) to see some ways to use the Prop Mover in a game!

To find the **Prop Mover** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Contextual Filtering in Creative

In Creative, some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the **Customize** panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the **Description** field for that option.

## Device Options

This section details the Prop Mover **device options** (in Creative) or **user options** (in UEFN).

1. To customize options in Creative, approach a device and press **E** to open the **Customize** panel.
2. To customize options in UEFN, select the device in your viewport or in the Outliner. Options for this device are found in the **Details** panel.

You can configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Movement Mode** | **Translation**, *Rotation* | Determines what type of movement the device uses. When Rotation is selected, new rotation options become available:   - Rotation Direction - Rotation Axis - Rotation Angle - Rotation Pivot Point - Rotation Complete |
| **Rotation Direction** | **Clockwise**, Counterclockwise | In Creative, this option only displays when the **Movement Mode** option is set to **Rotation**. Determines in which direction the device rotates the prop. |
| **Rotation Axis** | Roll, Pitch, **Yaw** | In Creative, this option only displays when the Movement Mode option is set to Rotation.  Determines which axis the prop rotates around. |
| **Rotation Angle** | **360**, Pick or enter an angle | In Creative, this option only displays when the **Movement Mode** option is set to **Rotation**. Determines the angle, in degrees, the prop will rotate to if unstopped or uninterrupted. |
| **Rotation Duration** | **10 seconds**, Pick or enter an amount | In Creative, this option only displays when the Movement Mode option is set to Rotation. Determines how much time it takes for the prop to complete its rotation. |
| **Rotation Pivot Point** | **Object Pivot**, Object Center, Prop Mover Position | In Creative, this option only displays when the Movement Mode option is set to Rotation.  Determines the pivot point around which the prop rotates.   - **Object Pivo**t: The prop pivots around the prop's origin point. - **Object Center**: The prop pivots around the center point of the prop. - **Prop Mover Position**: The location where the Prop Mover device overlaps the prop is the pivot point, and the prop rotates around that point. |
| **Rotation Complete** | **None**, Ping Pong, Repeat, Reset | In Creative, this option only displays when the **Movement Mode** option is set to **Rotation**. Determines what the moving prop does once the rotation has completed.   - None: The moving prop stops where the rotation completed. - Ping Pong:  The prop repeats the rotation in the opposite direction. - Repeat: The device resets the prop to its original position, and repeats the rotation. - Reset:  The device resets the prop to its original position and stops. |
| **Distance** | **Metric**: 20 Meters, Pick a distance  **Tiles**: 4.0 Tiles, Pick a distance | In Creative, this option only displays if the Movement Mode option is set to Translation. Determines the distance the prop will move if it is not interrupted or stopped. |
| **Speed** | **Metric**: 5.0 meters/second, Pick a speed  **Tiles**: 1.0 tile/second, Pick a speed | In Creative, this option only displays if the Movement Mode option is set to Translation. Determines the speed of the moving prop. |
| **Enabled During Phase** | None, **Gameplay Only** | Determines in which phases the device is enabled. |
| **Distance Measurement** | **Metric**, Tile | Determines what unit of measurement the device uses. |
| **On AI Collision Behavior** | Continue, **Stop**, Reverse, Push | Determines how the prop behaves when it bumps into a creature, animal, or NPC.   - **Continue**: the moving prop behaves normally. - **Stop**: the moving prop stops moving. - **Reverse**: the moving prop starts moving in the opposite direction. - **Push**: the moving prop forces the creature away from the moving prop. |
| **AI Damage On Collision** | **10.0**, Pick or enter an amount | Determines how much damage the moving prop deals to a creature, animal or NPC if the moving prop hits it. |
| **On Player Collision Behavior** | Continue, **Stop**, Reverse, Push | Determines how the prop behaves when it bumps into a player.   - **Continue**: the moving prop behaves normally. - **Stop**: the moving prop stops moving. - **Reverse**: the moving prop starts moving in the opposite direction. - **Push**: the moving prop forces the player away from the moving prop. |
| **Player Damage On Collision** | **10.0**, Pick or enter an amount | Determines how much damage the moving prop deals to a player if the moving prop hits it. |
| **On Prop Collision Behavior** | Continue, **Stop**, Reverse | Determines how the prop behaves when it bumps into another prop.   - **Continue**: the moving prop behaves normally. - **Stop**: the moving prop stops moving - **Reverse**: the moving prop starts moving in the opposite direction. |
| **Prop Damage On Collision** | **10.0**, Pick or enter an amount | Determines how much damage the moving prop deals to another prop if the moving prop hits it. |
| **Path Complete Action** | **None**, Ping Pong, Repeat, Reset | In Creative, this option only displays if the Movement Mode option is set to Translation. Determines what the moving prop does once it has moved the distance set in **Distance** option.   - **None**: The moving prop stops once it has moved the entire distance. - **Ping Pong**: the moving prop reverses and travels the same distance in the opposite direction. - **Repeat**: the moving prop resets to the original location and restarts the movement. - **Reset**: the moving prop resets to the original location, but doesn't restart the movement. |
| **Enable Device Activation on Move** | On, **Off** | If this is set to **On**, it enables a mode where the moving prop activates other devices as it moves. |
| **Should Move From Start** | ***On***, Off | Determines whether the prop begins moving immediately at the start of the game. If this is set to **Off**, the **Delay From Start** option is hidden. |
| **Delay From Start** | **0.0**, Pick or enter an amount | This option only displays if the **Should Move From Start** option is set to **On**. Determines how long it takes for the device to start moving after the game starts. By default, there is no delay. |
| **Allow Reverse Past Start** | On, **Off** | Determines whether the prop can go backward past its starting position. |

### Additional UEFN Options

When you use this device in UEFN, additional user options are available.

| Option | Values | Description |
| --- | --- | --- |
| **Prop Selection** | **Overlap**, *From Reference* | Determines which prop is affected by the Prop Mover device.   - **Overlap**: The prop the device is overlapping with is the one affected by it. - **From Reference**: Selecting this activates the **Prop Reference** option. |
| **Prop Reference** | Select a prop using the dropdown | This option is only active if the **Prop Selection** option is set to **From Reference**. Click the dropdown to select from a list of props.  You can also click the icons next to the dropdown: Use Selected Actor from the Level Editor, Select in the Viewport, or Pick Actor from Scene. |

## Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

1. In Creative, the functions and events are customized in the **Customize** panel (like other device options).
2. In UEFN, you can find them in the **Details** panel under **User Options - Functions** and **User Options - Events**.

### Functions

**In Creative**, use the following steps to set a function.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the Add button to add a line and repeat these steps.

**In UEFN**, use the following steps to set a function.

1. With a device selected, locate the **User Options - Functions** section in the **Details** panel, and expand it.
2. For any function, click the **+ (plus)** icon to add an array element.
3. Click the first dropdown, and select a device. If you have a lot of devices, you can use the search bar to find a device more easily.
4. Click the second dropdown, and select the event you want to bind to this function.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Start When Receiving From** | This function starts the prop moving when an event occurs. |
| **Stop When Receiving From** | This function interrupts the prop's movement when an event occurs. |
| **Reset When Receiving From** | This function resets the device, returning the prop to its original position, when an event occurs. |
| **Advance When Receiving From** | When an event occurs, this function advances the prop forward based on the device's default direction, ignoring the prop's previous movement. |
| **Reverse When Receiving From** | When an event occurs, this function reverses the prop's movement. |
| **Rotate Clockwise When Receiving From** | This function rotates the prop clockwise when an event occurs. |
| **Rotate Counter Clockwise When Receiving From** | This function rotates the prop counterclockwise when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

Events in UEFN are read-only. They will be set automatically when you set a function on a device that binds to an event on this device.

In Creative, follow these steps to set an event:

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Movement Start Send Event To** | When the prop starts moving, an event is sent to the selected device. |
| **On Movement Interrupted Send Event To** | When the prop's movement is interrupted, an event is sent to the selected device. |
| **On Movement Finish Send Event To** | When a prop finishes moving, an event is sent to the selected device. |
| **On Enabled Send Event To** | When the device is enabled, an event is sent to the selected device. |
| **On Disabled Send Event To** | When the device is disabled, an event is sent to the selected device. |
| **On Translation Type Change Send Event To** | When the translation type or the prop changes, an event is sent to the selected device. |
| **On Rotation Direction Change Send Event To** | When the rotation direction of the prop changes, an event is sent to the selected device. |
| **On AI Hit Send Event To** | When the prop hits an AI entity, an event is sent to the selected device. |
| **On Player Hit Send Event To** | When the prop hits a player, an event is sent to the selected device. |
| **On Prop Hit Send Event To** | When the prop hits another prop, an event is sent to the selected device. |
