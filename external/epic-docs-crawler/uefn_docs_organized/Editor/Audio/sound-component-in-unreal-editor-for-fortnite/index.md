# Sound Component

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/sound-component-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:43:49.039692

---

Components are basic building blocks that use data and logic to build your game. Use the **sound component** to add audio that enhance the ambiance in your level.

The **sound component** is an asset-generated component. An **asset-generated component** is a component class that is automatically created based on preexisting content in your project, such as a mesh, sound, or particle system asset. These assets may also expose properties that you can modify on the generated component.

You can add an asset-generated component to an entity by selecting **+Component** in the Details panel and navigating to the base class to find the component you want. You can also drag and drop the asset from the Content Browser into the Details panel for your entity. These asset-generated components also can be referenced specifically in your Verse code and appear in your **Assets.digest.verse** file.

You need to compile the Verse code for your project after you import or create your asset in order to generate the component class.

To add a component to your entity, refer to [**Working with Entities and Components**](working-with-entites-and-components-in-unreal-editor-for-fortnite#addingacomponent). The component is listed as **sound\_component**, which matches the Verse class for the mesh component. For more information about the Verse API for the sound component, check out the [sound\_component API reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/unrealenginedotcom/temporary/scenegraph/sound_component).

## Example

To add sounds to your level, you will need to create a [Metasound](https://dev.epicgames.com/documentation/en-us/unreal-engine/metasounds-quick-start) preset. Follow the steps below to create a MetaSound for the **sound component** in your level.

1. In the **Content Drawer**, navigate to **All** > **Epic** > **Audio** > **MetaSounds** > **Sources**.

[![](https://dev.epicgames.com/community/api/documentation/image/a67b1b1c-b8d2-4064-b649-9843e1308b44?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a67b1b1c-b8d2-4064-b649-9843e1308b44?resizing_type=fit)

1. Right-click on a MetaSound source preset then select **Create MetaSound Source Preset**.

   1. Use the **MSS\_PlayRandom\_Loop** to play a given Sound Wave from an array that loops indefinitely.
   2. Use the **MSS\_PlayRandom\_Oneshot** to play a given Sound Wave from an array one time.
2. Name your sound, then click **Save**.
3. Create a prefab entity. In the **Details** panel for the entity, click **+ Component**.
4. Select **sound\_component**, then select the MetaSound asset you would like to use as a component.

   1. You can also reference the MetaSound through the [**Audio Player**](audio-player-in-unreal-editor-for-fortnite) device.

## Component Options

All options on the sound\_component can be enabled and disabled from the component and can be used with a Verse component.

Any input setting on the sound component will auto-populate any input setting you defined on the MetaSound preset. These settings can then be overridden on the sound component.

[![](https://dev.epicgames.com/community/api/documentation/image/9292e123-1567-49d5-8f8b-a99b184f53ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9292e123-1567-49d5-8f8b-a99b184f53ab?resizing_type=fit)

| Options | Value | Description |
| --- | --- | --- |
| **Sounds** | Select a Sound Wave asset | Sets the audio file. |
| **PitchBase** | **0**, Enter a number | Sets the audio's base pitch. |
| **PitchRandomSpread** | **0**, Enter a number | Sets the maximum deviation from the base value, and defines the range within which random pitch shift values can be selected in semitones. The actual value will be within the range of either adding or subtracting the spread from the base. |
| **VolumeBase** | **0**, Enter a number | Sets the base volume applied to the sound in decibels. A value of **0** results in the default volume. A value of **-60** results in silence. |
| **VolumeRandomSpread** | **0**, Enter a number | Sets the maximum deviation from the base value, defining the range within which the random volume multiplier values can be selected. The actual value will be within the range. |
| **AutoPlay** | **True**, False | Sets the audio to autoplay during gameplay. |
| **Enable** | **True**, False | Enables the audio. |
