# Progress Based Mesh Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-progress-based-mesh-devices-in-fortnite
> **爬取时间**: 2025-12-26T23:36:48.647346

---

The **Progress Based Mesh** device provides the option to create a visual system for the progress of an item. The device can swap between meshes and materials to visually represent different stages. The default mesh is a jar with a liquid material to show filling and draining.

You can use the device to simulate players placing objects inside other objects, track the progress of an event, and more. The device options and use cases change between Fortnite Creative and Unreal Editor for Fortnite (UEFN). To learn more, see the [Using the Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-progress-based-mesh-devices-in-fortnite#using-the-device) section on this page.

## Device Access

The Progress Based Mesh device is available in Creative and UEFN.

You can find the device in the following locations:

- **Creative: Creative Menu > Content > Fortnite > Devices > Progress Based Mesh**
- **UEFN: Content Drawer > Fortnite > Devices > Environment > Progress Based Mesh**

To learn the fundamentals of how to access, place, and adjust settings for a device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Using the Device

The device creates a visual representation of progress. You can use buttons, triggers, and receivers for players to interact with the device.

If you're using multiple copies of a device on an island, you can rename them for organization. Choosing names that relate to a device's purpose helps to remember what each one does, and finding a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

The general flow of using the device is as follows:

1. Place the device into your level.
2. Set the [progression values](https://dev.epicgames.com/documentation/en-us/fortnite/using-progress-based-mesh-devices-in-fortnite#user-options).
3. Create a [threshold list of meshes](https://dev.epicgames.com/documentation/en-us/fortnite/using-progress-based-mesh-devices-in-fortnite#visuals-nbsp) (predefined in Creative).
4. Trigger the [device's functions](https://dev.epicgames.com/documentation/en-us/fortnite/using-progress-based-mesh-devices-in-fortnite#direct-event-binding), or set the value directly in [Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-progress-based-mesh-devices-in-fortnite#verse-api) (UEFN only) to activate the threshold meshes.
5. Add [visual and sound effects](https://dev.epicgames.com/documentation/en-us/fortnite/using-progress-based-mesh-devices-in-fortnite#additional-uefn-options-nbsp) (UEFN only).

### Creative

In Creative, the Progress Based Mesh devices come with a predefined list of threshold meshes that are not configurable.

You can adjust the options around the progression values, functions, and events. The material for the device is dynamic, meaning you can rotate the jar, and the liquid physically moves with it.

### UEFN

In UEFN, you can use the default or custom meshes to create a mesh sequence. The default jar behaves the same as in Creative.

You can't change the static mesh from the component. You must use the [Threshold Mesh](https://dev.epicgames.com/documentation/en-us/fortnite/using-progress-based-mesh-devices-in-fortnite#visuals-nbsp) option to add meshes. When the progress of the device changes, the static mesh component updates with the active threshold mesh.

You can build a range of mechanics like:

- Growing or decaying plants in a garden
- The filling and draining of fuel tanks
- Progress bar for players' rank in a game
- Tip jar for your restaurant tycoon

The device also writes its progression state to the mesh's material via a **FillAmount** scalar material parameter. You can create your own materials using this parameter to get smooth transitions. This parameter becomes active through the **Fill Material Index** in the [Visuals](https://dev.epicgames.com/documentation/en-us/fortnite/using-progress-based-mesh-devices-in-fortnite#visuals-nbsp) category of the device.

The index represents the material slot attached to your static mesh. For the fundamentals of working with materials, see [Materials in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/materials-in-unreal-editor-for-fortnite).

To assign the material index:

1. In a new or existing material, create a **ScalarParameter** node.
2. Set the **Parameter Name** to **FillAmount**. You must use this name for the device to register the **Fill Material Index**.
3. Connect the node as needed in the material graph.
4. Assign the material to your static mesh.
5. In the **Threshold Mesh** list, set the **Fill Material Index** to the material slot containing the **FillAmount** parameter. Only one material slot per mesh supports the fill parameter.

To view and adjust the material slots, open the mesh in the Static Mesh Editor and use the Details panel.

[![](https://dev.epicgames.com/community/api/documentation/image/7027716d-223a-4df9-b560-0445dd6b9d87?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7027716d-223a-4df9-b560-0445dd6b9d87?resizing_type=fit)

Progress Bar Material

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature hides or displays options depending on the values selected for certain related options. This organization reduces clutter in the Details panel, helping to manage and navigate the settings. To identify these options, values that trigger contextual filtering in the settings tables on this page are in italic.

All options are listed in the following sections, including those affected by contextual filtering. If an option is hidden or displayed based on a specific value, there will be a note about it in the **Description** field of the table for that option.

## User Options

The core options for the device are the target value for complete progress and the rate of progression.

You can configure this device with the following options. Default values are bold. Values that trigger contextual filtering are italic.

|  |  |  |
| --- | --- | --- |
| Option | Value | Description |
| **Progress Target** | **100**, choose a value | The maximum progress for the device to reach.  Value ranges from 0 - 100. |
| **Game Start Progress Amount** | **0**, choose a value | The amount of progress the device has at the start of the game.  Value ranges from 0 - 100. |
| **Progress Rate** | **5**, choose a value | The rate at which to increase the progress amount based on the **Progression Type**.  If set to continuous, it's the rate at which progress changes. If set to instant rate, it's how much to change by per event call.  Value ranges from 0 - 100. |
| **Regress Rate** | **5**, choose a value | The rate at which to decrease the progress amount based on the **Progression Type**.  If set to continuous, it's the rate at which progress changes. If set to instant rate, it's how much to change by per event call.  Value ranges from 0 - 100. |
| **Progression Type** | **Continuous Rate**, Instant | Options for how the progress amount updates.   - **Instant Rate:** Gains a single chunk of the Progress or Regress Rate at once. - **Continuous Rate:** Updates at the specific Progress or Regress Rate per second. |

## Direct Event Binding

The following are the direct event binding options for this device. To learn more, see [Using Direct Event Binding](https://dev.epicgames.com/documentation/en-us/fortnite/direct-event-binding-in-unreal-editor-for-fortnite).

### User Options - Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device and then performs an action.

To create or edit a function in UEFN:

1. Open the device settings, and click a function option.
2. Click the plus icon (**+**) to add an element, then click the dropdown to choose a device in your island. The second dropdown for events becomes active.
3. Click the second dropdown to bind the device to an event that triggers the function.

To create or edit a function in Creative:

1. Open the device settings, and click a function option.
2. Click **ADD**, then click **Select Device** to choose a device in your island.
3. Click **Select Event** to bind the device to an event that triggers the function for the device.

You can add multiple events to a function.

| Functions | Description |
| --- | --- |
| **Begin Progressing When Receiving From** | Increases the current progress level by the **Progress Rate** user option. |
| **Begin Regressing When Receiving From** | Reduces the current progress level by the **Regress Rate** user option. |
| **Pause When Receiving From** | Pauses the device. |
| **Progress Fully** | Increases the device to its **Progress Target**. |
| **Regress Fully** | Reduces the **Progress Target** to 0. |

### User Options - Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

To create an event in UEFN:

1. In the connected device create a function.
2. Choose the event type for the Progress Based Mesh device.

Use the **Events** category in UEFN to view the connected functions.

To create or edit an event in Creative:

1. Open the device settings, and click an event option.
2. Click **Add**, then **Select Device** to choose a device in your island.
3. Click **Select Function** to bind the event to a function for that device.

You can add multiple functions to an event.

| Events | Description |
| --- | --- |
| **On Progress Filled Completely** | Event that occurs when the device reaches its **Progress Target**. |
| O**n Progress Emptied Completely** | Event that occurs when the device regresses to 0. |
| **On Progress Changed** | Event that occurs when the current progress of the device changes. |
| **Progress Threshold Cross Event** | Event that occurs when the device hits one of the mesh thresholds, and a mesh is swapped in response. |

## Additional UEFN Options

### Visuals

Use the **Visuals** category to adjust the appearance of the mesh and materials at different thresholds. The default value is the jar mesh at different fill stages.

| Visual Options | Value | Description |
| --- | --- | --- |
| **Threshold Mesh** | *Index* | Represents the list of meshes for the stages of progression.  To add meshes to the list, click the plus (**+**) icon. |
| **Threshold** | Minimum (Min)  Maximum (Max) | Sets the progress range (the bound) for the mesh to be active.  Use the following options to determine how the set min and max values are included in the range.   - **Exclusive:** Excludes the set value. - **Inclusive (Default):** Includes the set value. - **Open:** Uses the whole range, from the set value to the **Progress Target**.   If two thresholds overlap, the device uses the first qualifying threshold in the list. |
| **Static Mesh** | Choose a Static Mesh Asset | Sets the mesh for the threshold range. The mesh that the device will show while its progress value falls between that threshold. |
| **Transition VFX** | Choose a Niagara System | Simulates the visual effect (VFX) when the device transitions into the set static mesh. |
| **Transition Sound Cue** | Choose a Sound Cue Asset | Plays the sound when the device transitions into the set static mesh. |
| **Fill Material Index** | **2**, choose a number | Creates a dynamic material instance for the material in this slot, and writes to the **FillAmount** scalar material parameter.  This material parameter for the current fill is expressed as a ratio of `Current Progress / Progress Target`. For example, if your target progress is 100 vs 50, but you have a current progress of 25, then you'll get 1/4 full vs 1/2 full. To disable the functionality, set the value to -1.  You must use a **ScalarParameter** node in the material, and rename it to **FillAmount**. |

### Audio

With **Continuous Rate** active, you can add audio to indicate the progress.

| Audio Type | Description |
| --- | --- |
| **Progress Audio** | Plays audio when the device is progressing at a continuous rate. |
| **Regress Audio** | Plays audio when the device is regressing at a continuous rate. |
| **Finish Audio** | Plays audio when the device reaches its **Progress Target**. |

The following general categories are included in the Details panel:

- HLOD
- Displacement
- Rendering
- Draw Distance
- Data Layers

To learn more about the panel, see [User Interface Reference](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite).

## Verse API

You can use the Verse API for the Progress Based Mesh device to customize your further mechanics. In Verse, you can directly set the progress amount. When coupled with triggers and receivers, you can configure pre-determined progress and regression amounts.

For more information on using the device in Verse, see the `progress_based_mesh_device` API reference.
