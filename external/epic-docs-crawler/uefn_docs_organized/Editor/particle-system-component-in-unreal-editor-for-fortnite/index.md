# Particle System Component

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/particle-system-component-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:43:26.851151

---

Components are basic building blocks that use data and logic to build your game. Use the **particle\_system\_component** to add Niagara effects to your level. You can use this component alone to add Niagara effects to your level, or pair it with a mesh component to add realism and depth to your creations.

The **particle\_system\_component** is an asset-generated component. It is a component class that is automatically created based on preexisting content in your project, such as a mesh, sound, or particle system asset. These assets may also expose properties that you can modify on the generated component.

Add an asset-generated component to an entity by selecting **+Component** in the Details panel and navigating to the base class to find the component you want. You can also drag and drop the asset from the Content Browser into the Details panel for your entity. These asset-generated components can also be referenced specifically in your Verse code and appear in your **Assets.digest.verse** file.

You need to compile the Verse code for your project after you import or create your asset in order to generate the component class.

To add a component to your **entity**, refer to [**Working with Entities and Components**](working-with-entites-and-components-in-unreal-editor-for-fortnite#addingacomponent). The component is listed as **particle\_system\_component**, which matches the Verse class for the particle system component. For more information about the Verse API for the component, check out the [particle\_system\_component API reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/particle_system_component).

## Example

To add a particle system component to your level:

1. Create a particle effect by right-clicking in your project’s Content Browser and selecting **Niagara System**.
2. Select an effect and choose **Create**.
3. In the topmost Editor menu, choose **Verse** > **Build Verse Code**.
4. Open **Verse Explorer** from the same menu.
5. Right-click on your project name and select **Add new Verse file to project**.
6. From the pop-up window, select **Scene Graph Component**, name it and choose **Create**.
7. Once again, select **Verse** > **Build Verse Code**.
8. When adding a particle\_system\_component, you should now see the added particle effect in the dropdown menu.

## Component Options

Particle system components currently have the following options:

| Options | Value | Description |
| --- | --- | --- |
| **Enabled** | **True**, False | Enables the particle effect. |
| **AutoPlay** | **True**, False | Sets the particle effect to autoplay during gameplay. |
| **AutoPlayInEditor** | **True**, False | Sets the particle effect to autoplay during the UEFN edit session. |
