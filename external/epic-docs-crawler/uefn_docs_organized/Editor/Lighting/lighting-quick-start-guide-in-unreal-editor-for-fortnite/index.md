# Lighting and Lumen Quick Start Guide

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/lighting-quick-start-guide-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:42:04.810215

---

**Unreal Editor for Fortnite (UEFN)** comes with **Lumen**. [Lumen](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#lumen) is a comprehensive lighting tool that creates softer shadows, realistic global illumination, and better visual experiences for [islands](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#island) created in UEFN, much like the lighting you see in **Chapter 4** of **Fortnite Battle Royale**.

This guide shows you how to use Lumen in your project. Whether you want to upgrade an existing island you created in Fortnite Creative or create a new island in UEFN that uses Lumen, you can create the island with custom high-end lighting.

There are three paths you can take to use Lumen on your island:

- **[Basic](https://dev.epicgames.com/documentation/en-us/fortnite/lighting-and-lumen-quick-start-guide-in-unreal-editor-for-fortnite#existing-fortnite-creator)**: Existing Fortnite creator
- **[Intermediate](https://dev.epicgames.com/documentation/en-us/fortnite/lighting-and-lumen-quick-start-guide-in-unreal-editor-for-fortnite#new-uefn-artist)**: New UEFN artist
- **[Expert](https://dev.epicgames.com/documentation/en-us/fortnite/lighting-and-lumen-quick-start-guide-in-unreal-editor-for-fortnite#bespoke-lighting)**: Bespoke lighting

If you want to test out the different lighting paths, create an island in Fortnite Creative using a template island that has pre-existing structures, then move through the lighting paths described below to learn the differences between each path.

The intermediate tutorial uses the Time of Day manager, while the expert tutorial turns off the Time of Day manager to use the [Environment Light Rig](https://dev.epicgames.com/documentation/en-us/fortnite/environment-light-rig-device-in-unreal-editor-for-fortnite).

| Time of Day Manager | Day Sequence Device | Environment Light Rig |
| --- | --- | --- |
| ON |  |  |
| OFF |  |  |

Explore the power of Lumen in the [Lumen Global Illumination and Reflections](https://dev.epicgames.com/documentation/en-us/unreal-engine/lumen-global-illumination-and-reflections-in-unreal-engine?application_version=5.5) page in the Unreal Engine documentation.

## Troubleshooting Lighting Issues

Lighting is highly technical and not an easy element to work with. Adding too many individual lights to your island becomes data-heavy and hard to render on low-end consoles, while looking great on high-end consoles and on PC. Always test your lighting on a few different consoles after creating custom lighting.

Trying to create island lighting using light actors will cause your island to appear black across most platforms. Only use Directional Lighting or the Skylight to create custom lighting.

Do not rely solely on the following light actors to create custom lighting on your island:

- Point Lights
- Spot Lights
- Rectangle Lights

If the lighting looks completely different on the low-end consoles and mobile than it does on the high-end consoles and PC, use the following steps with the **Engine Scalability Settings** to troubleshoot lighting across platforms.

1. Click **Project** **Settings** on the viewport toolbar and select **Viewport Scalability**. The different engine settings open.
2. Select **Medium** from the **Global Illumination** settings.

   [![](https://dev.epicgames.com/community/api/documentation/image/1d9cc7f4-9dd4-418c-a9f6-da28401d3d66?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d9cc7f4-9dd4-418c-a9f6-da28401d3d66?resizing_type=fit)

The lighting settings you use should now become standard across the different platforms. The following table breaks down which settings are good for the different console capabilities.

| Global Illumination Setting | Console Compatibility |
| --- | --- |
| Low | All consoles  This severely restricts the ability to create custom lighting. |
| Medium | All consoles |
| High | Mid to high tier consoles |
| Epic | PCs |

## Existing Fortnite Creator

Begin by following the directions in [Importing Fortnite Islands](https://dev.epicgames.com/documentation/en-us/fortnite/importing-fortnite-islands-into-unreal-editor-for-fortnite) to import and convert an existing island into a UEFN project. Once converted, toggle the **Global Illumination** settings between **Epic** and **Medium** to see the difference in lighting results.

![Medium Setting](https://dev.epicgames.com/community/api/documentation/image/556c802b-40bc-46f1-815c-12dfcab2bde2?resizing_type=fit&width=1920&height=1080)

![Epic Setting](https://dev.epicgames.com/community/api/documentation/image/fc46a899-3577-45bc-a0bc-c82b6e52e0cf?resizing_type=fit&width=1920&height=1080)

Medium Setting

Epic Setting

The Lumen Exposure Manager device does not unlock the full capability of Lumen in your project. To fully use Lumen on your island, follow the steps in the **New UEFN Artist** section below.

You can further edit lighting settings with the [Day Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-day-sequence-devices-in-unreal-editor-for-fortnite) device. Switching your **Time of Day** settings immediately changes how your island renders in the viewport. Lumen must be used with **High** or **Epic** Global Illumination settings. This enhances the world lighting for next-gen platforms. Lower-performing platforms do not get dynamic Global Illumination. Instead, use a skylight to simulate Lumen effects for these platform types.

[![Enabling the Lumen system in a converted island.](https://dev.epicgames.com/community/api/documentation/image/f2547ffe-96ed-4a70-b800-d00f00f7989e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2547ffe-96ed-4a70-b800-d00f00f7989e?resizing_type=fit)

With the [Day Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-day-sequence-devices-in-unreal-editor-for-fortnite) device, you can edit lighting settings for the following:

- Clouds
- Fog
- Sky Color
- Sun
- Moon
- Skylight

## New UEFN Artist

All UEFN projects have Lumen available by default. Lumen automatically cycles your island through the 24 hour day cycle so you don’t need to edit the Island Settings device to determine the time of day.

Take advantage of the Lumen system by adding the **Day Sequence** device to the viewport in your project. You can add the Lumen Exposure Manager to your island as well, you’ll notice a slight difference in the shadows and lighting after adding the device to the project.

Bold, incremental changes are recommended to establish a middle ground for your natural lighting. Create your project’s base lighting first with as few adjustments as possible, then work on the unique look of your project.

Establishing your base lighting with minimal adjustments means you won’t have to start from scratch with your lighting every time you make adjustments.

With the Day Sequence device selected in the **[Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/outliner-panel)**, you can edit its settings from the **Details** panel. All Day Sequence device settings can be used together, separately, or with some turned on and others turned off.

Lumen post-process settings are the default settings used on Fortnite Battle Royale. They can be tweaked to fit your game’s aesthetic on high-end platforms.

### Editing Sunlight Settings

Sunlight across the island determines how shadows look, whether there are sun flares, and how light bounces off the [materials](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#material) in the world. Sunlight also determines how much interior and exterior lighting is necessary when you place building [props](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#prop).

To create custom sunlight, follow the instructions below:

1. Toggle **Sunlight** on to edit the following sunlight settings:

   1. Set **Intensity** to **5**. This makes the sunlight less intense.
   2. Click the **Color** to open the color wheel and select a new color, then click **OK**.
2. Toggle **Enable Sun Component** on and off to see the difference in the sunlight.

In the viewport, you should see the edits reflected in the sky and in the shadows on the ground. The sky color will change and reflect a new color off the clouds, and the shadows will become subdued around the edges.

If you want to make your island appear darker to use street lamps, point lights, and spot lights, you must:

1. Toggle **Sunlight** on.
2. Toggle **Enabled Sun Component** off. This makes  your island look like nighttime. The sky will still have the moon and sky light, but now the point lights will be turned on.

[![Toggle off the Enable Sun Component to create a night time scene.](https://dev.epicgames.com/community/api/documentation/image/c717cac5-d230-4b49-9883-baceca88ff96?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c717cac5-d230-4b49-9883-baceca88ff96?resizing_type=fit)

### Editing Fog Settings

Depending on the type of island you’re building, you might want to add fog. Lumen’s fog capabilities give you control over the density and color of the fog and how the fog falls off.

Add fog to your island by editing the following fog settings:

1. Toggle **Sunlight** off. This turns off the custom sunlight settings and uses the default sunlight settings.
2. Toggle **Fog** on to edit the fog settings.
3. Increase the **Density** setting to **2.0**.
4. Click **Color** to open the color wheel. Select a new color for the fog and click **OK**.
5. Increase the **Height Falloff** setting to **0.75**.
6. Click on **Directional Inscattering Color** to open the color wheel. Select a new color and click **OK**.
7. Set the **Secondary Density** to **0.25**.
8. Set the **Secondary Falloff** to **0.45**.
9. Set the **Secondary Offset** to **0.15**.
10. Slide the **Sunlight Volumetric Scattering** to **0.0**. This makes the sunlight less intense and increases the selected colors for the fog color and fog directional scattering in the atmosphere.
11. Set the **Max opacity** to **0.2**. This controls how dense the fog appears at its strongest.

This creates an early morning fog effect, or a creepy fog effect depending on the colors you selected and the fog density settings you used to edit the fog properties.

You can use the sunlight settings to alter how the fog looks as well. In the image below all the sunlight settings have been left in place alongside the fog settings.

[![Sunlight and fog settings have been edited to create thicker fog and more intense sunlight](https://dev.epicgames.com/community/api/documentation/image/f2b1b644-6f30-47d6-8339-c44a562984fe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2b1b644-6f30-47d6-8339-c44a562984fe?resizing_type=fit)

### Editing Skylight and Sky Settings

Skylight settings determine how intensely the skylight plays off the materials and props in the world. This affects how dark shadows become and how much light bounces off emissive materials.

Sky settings determine how the sky in your project looks. This is where you can edit the sky to look like a certain time of day, or create a funky looking sky for a completely unique look and feel.

Edit the Skylight settings by doing the following:

1. Return all the fog settings to their default state by clicking the return arrows in each field.
2. Disable the **Fog** setting. This returns the island to a default state.
3. Toggle **Skylight** on to edit the skylight settings.
4. Slide the **Intensity** slider to the right to increase the brightness, much like a hazy summer day.
5. Slide the slider to the left to decrease the brightness and neutralize the haze effect.
6. Click **Color** to open the color wheel and change the skylight color, then click **OK**.

Play around with the skylight color and notice how the light bouncing off objects in the world changes slightly.

Now edit the Sky settings:

1. Toggle on **Sky** to edit the sky settings.
2. Slide the **Sky Gradient Blend** all the way to the right. This decreases the blend between the 3 selected colors for Sky Gradient Low, Medium, and High.
3. Set the **Sky Gradient Blend** setting to **0.5**.
4. Click the **Sky Gradient Low Color** to open the color wheel and select a new color, then click **OK**.
5. Click on the **Sky Gradient Mid Color** to open the color wheel and select a new color, then click **OK**.
6. Click the **Sky Gradient High Color** to open the color wheel and select a new color, then click **OK**.
7. Change the **Sun Size** setting with the slider. Sliding to the right increases the sun’s size, sliding to the left reduces the sun’s size.
8. Change the **Sun Intensity** setting with the slider. Sliding to the right makes the sun more distinct, sliding to the left makes the sun more veiled.
9. Click on **Sun Color** to open the color wheel and change the color of the sun’s haze, then click **OK**. The sun’s color influences how sunlight looks on materials and clouds.
10. Slide the **Custom Sun Color** slider to the right to increase the Sun Color effect in the level.

### Editing Cloud and Time of Day Settings

Clouds can create ambience and alter how the lighting in the world looks due to the volume of clouds in the sky. This can result in more shadows all around, deeper shadow colors in existing shadows, and less visible sky.

[![](https://dev.epicgames.com/community/api/documentation/image/eb7d7209-c633-43df-8785-70acc0335125?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb7d7209-c633-43df-8785-70acc0335125?resizing_type=fit)

To edit clouds:

1. Toggle off the **Sky** and **Skylight** settings to turn them off.
2. Toggle on **Clouds**, the default moving clouds in the sky disappear. Edit the cloud settings.
3. Click **Light Color** to open the color wheel and select a new cloud color, then click **OK**.
4. Click **Shadow Color** to open the color wheel and select a new shadow color, then click **OK**.
5. Slide the Light Brightness slider all the way to the right to increase the brightness of the light color.
6. Slide the Coverage slider all the way to the right to increase the size of the clouds in front of the sun.
7. Slide the **Size** slider all the way to the right to increase the size of the cloud coverage.
8. Slide the **Opacity** slider to the left, this makes the clouds more see through and changes the look of the sun at the same time.
9. Slide the **Speed** slider to the left, this increases the speed the clouds traverse the sky.
10. Slide the **Direction X** and **Direction Y** sliders to the left and right. These settings work independently or in tandem to create a new direction for the clouds to roil as they form.

You can change the starting time of day for your island by editing the **Time of Day** setting in the viewport. This setting works in tandem with any of the other settings you're using in your island.

To change the time of day, click the **Viewport toolbar icon** then select **Time of Day** and then use the slider to determine the time of day.

To create a night time scene in your project, do the following:

1. From the **Viewport toolbar**, slide the **Time of Day** slider all the way to the left or right until the daylight turn to night.
2. Select the **Day Sequence** device in the **Outliner** to open its settings in the Details panel.
3. From the **Details panel**, toggle on **Sky** to edit the moon settings:

   1. Slide the **Moon Size** slider to the left and right to resize the moon.
   2. Click **Moon Color** to open the color wheel and change the color of the moon.
4. Slide the **Star Brightness** slider to the right to increase the number of stars visible in the sky.

Now you have a custom night time that you can further edit by changing the color of the sky gradients and shading the blending value. To make your night time scene creepy, add fog and increase the fog density.

### Editing Interior Lighting

You can edit interior lighting using the **Trigger Volume** setting. This setting limits the effects of the Day Sequence device to the interior of the volume. You can use multiple Day Sequence devices in your level to create multiple, concurrent lighting looks on your island.

For instance, you can use one Day Sequence device for outdoor lighting with the Trigger Volume turned off, and another Day Sequence device used inside a building with the Trigger Volume turned on and the Priority setting set to a higher priority which would create a unique interior lighting set up that looks dark and cavernous.

To create a Trigger Volume, do the following:

1. Drag a **Day Sequence device** inside a prefab on your island.
2. Toggle the Trigger Volume setting to on.
3. Click on the **Extent X** option and enter a dimension size for that axis to extend the volume to the size of the building.
4. Click on the **Extent Y** option and enter a dimension size for that axis to extend the volume to the size of the building.
5. Click on the **Extent Z** option and enter a dimension size for that axis to extend the volume to the size of the building.

This overrides the exterior lighting and preserves the custom interior lighting setup inside the volume.

If you have different lighting materials, you can use them with this actor. Select the material from the **Light Function Material** dropdown menu to change the lighting.

There are some instances where the exterior lighting affects the interior of a building. To stop the exterior lighting from seeping into a building actor, place a **Day Sequence** device in the affected building, then use the device's **Trigger Volume** setting to limit the area affected by the Day Sequence device's settings.

## Bespoke Lighting

UEFN uses the power of Lumen to create customized skylines, sky lighting, and volumetric clouds and fog. Additional Lumen functionality is possible without using the Day Sequence device.

To create custom-built lighting for your island you need to turn off all day managers. Then you can use the [Environment Light Rig](https://dev.epicgames.com/documentation/en-us/fortnite/environment-light-rig-device-in-unreal-editor-for-fortnite) device which includes many Lumen settings that provide the means to customize your lighting further with the use of [Post Processing](https://dev.epicgames.com/documentation/en-us/fortnite/intro-to-postprocessing-in-unreal-editor-for-fortnite) Volumes.

As you develop the lighting for your scene, you'll be able to use the post-processing volumes inside the Environment Light Rig to compensate for inconsistencies between high-end and low-end devices.

Start small by using the general settings first, and keep adjusting as necessary when there are drastic changes in look and feel.

To learn more about what Lumen has to offer, see the [Auto Exposure](https://dev.epicgames.com/documentation/en-us/unreal-engine/auto-exposure-in-unreal-engine?application_version=5.5) documentation in the Unreal Engine documentation.

To begin, follow the instructions below:

1. Open **World Settings**.
2. Toggle on **Disable All Time of Day Managers**. All environment lighting will be turned off in your project.

   [![Disable the time of day managers.](https://dev.epicgames.com/community/api/documentation/image/3749a9a2-66f4-45d9-8dce-5e8621d29669?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3749a9a2-66f4-45d9-8dce-5e8621d29669?resizing_type=fit)
3. In the Content Browser click **Fortnite > Devices**.
4. Search for the **Environment Light Rig** device.
5. Drag the **Environment Light Rig** into the viewport. The lighting returns to your project.

   [![Drag the Environment Light Rig into the viewport.](https://dev.epicgames.com/community/api/documentation/image/c86a5086-f40a-45c5-a4d4-f5e256f114f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c86a5086-f40a-45c5-a4d4-f5e256f114f4?resizing_type=fit)

To edit the different lighting settings, you'll need to select each lighting actor individually from the **Details** panel. You’ll be able to edit the following:

- DirectionalLight
- SkyAtmosphere
- SkyLight
- ExponentialHeightFog
- LumenExposure
- BasicExposure
- ColorGradient

  [![All lighting actors are available from the Details panel.](https://dev.epicgames.com/community/api/documentation/image/70e923fe-f51e-4af8-ada4-7a0b0c5a78e4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/70e923fe-f51e-4af8-ada4-7a0b0c5a78e4?resizing_type=fit)

### Using Directional Light

DirectionalLight is a multi-faceted actor that simulates light emitted from a single source in the distance, much like sunlight or moonlight. Using the DirectionalLight settings you decide how the light source affects the world and shadows cast by objects in the world.

To create a single source of light in your project, use the following **Light** settings:

1. Select **DirectionalLight** from the **Environment Light Rig** components field.

   [![Select DirectionalLight in the components field.](https://dev.epicgames.com/community/api/documentation/image/285bb17e-8498-44dd-bd23-070d3fa7abab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/285bb17e-8498-44dd-bd23-070d3fa7abab?resizing_type=fit)
2. Set the **Intensity** to **2.0**. This setting affects other lighting in the world, notice how the street lamps in the world are illuminating the ground plane.
3. Click **Light Color** and select a new color in the color wheel, then click **OK**. Your lighting and world take on the hue of the color you selected.
4. Set the **Source Angle** to **6.0**. This increases the light source's angle and diameter. The default is 0.5357, which is the angle of our sun.
5. Set the **Source Soft Angle** to **5.0**, this softens or blurs the edges of shadows depending on the intensity, global illumination, and indirect lighting--which all contribute to how soft and blurred the edges of the shadows become.
6. Toggle on **Use Temperature**, you can now edit the **Temperature** slider.
7. Slide the **Temperature** slider to the left, and the selected light color becomes more saturated, slide the slider to the right and the light color becomes less saturated. Set the Temperature to **11640** to reduce the saturation of the light color.
8. Slide the **Indirect Lighting Intensity** slider to the left and all indirect lighting becomes less intense. Slide the bar to the right and all indirect lighting becomes more intense. Set the indirect lighting to **2.0**.
9. Slide the **Volumetric Scattering Intensity** slider to the left and the lighting decreases. Slide the slider to the right and the lighting brightens.

You can assign the lighting in Directional Light to specific lighting channels using the **Advanced** options by assigning the lighting to a specific channel.

The lighting channels determine which objects are affected by the lighting.

This setting is used to  control which objects are affected by the lighting.

The lighting looks like early evening in your project with soft lighting and shadows.

![You can see the starting point before editing world lighting with the Environment Light Rig device.](https://dev.epicgames.com/community/api/documentation/image/0127878c-21e1-4e7f-be0d-fdc3992df09c?resizing_type=fit&width=1920&height=1080)

![The lighting on the right was edited using the settings above.](https://dev.epicgames.com/community/api/documentation/image/6be8a5f9-39bf-4823-a8f9-9c5a635f292c?resizing_type=fit&width=1920&height=1080)

You can see the starting point before editing world lighting with the Environment Light Rig device.

The lighting on the right was edited using the settings above.

Slide the bar to see the difference between the starting point of the island and using the **Light** settings to create world lighting for your project.

You can leave the Directional Lighting settings at their defaults as the default settings already work efficiently.

The next part of creating your lighting setup is to determine lighting properties. Lighting properties decide how light shafts look and behave in your project. This is most impactful for projects that include gameplay in caves and areas that contrast between light and dark.

[![Some light shaft properties were set to extremes used in this example.](https://dev.epicgames.com/community/api/documentation/image/60b3edf4-01a3-4e05-866f-dbc18b0b3eba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/60b3edf4-01a3-4e05-866f-dbc18b0b3eba?resizing_type=fit)

Some light shaft properties were set to extremes in the example above.

In the **Details** panel scroll down to the **Light Shafts** settings and do the following:

1. Toggle on **Light Shaft Occlusion**. You can now access the Occlusion tools.
2. Toggle on **Light Shaft Bloom**. You can now access the Bloom tools.
3. Set **Bloom Scale** to **10.0**.

   [![Use the following settings.](https://dev.epicgames.com/community/api/documentation/image/5c3ead35-07d4-49ce-8313-f1d246254260?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c3ead35-07d4-49ce-8313-f1d246254260?resizing_type=fit)

The lighting in your world now produces powerful light shafts.

[![Using the settings above you can create powerful light shafts in your project.](https://dev.epicgames.com/community/api/documentation/image/1b0dfa04-951e-4d44-bc19-525b140b01f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1b0dfa04-951e-4d44-bc19-525b140b01f3?resizing_type=fit)

You can further edit your light shafts by deciding on a new color for your bloom tint, decreasing the brightness of the bloom, and increasing the occlusion mask of the darkness. Using the slider tool for each setting will help you create the perfect light shafts for your project.

### Using Sky Atmosphere

Sky Atmosphere acts like a backdrop to the Directional Lighting and Sky Lights. The settings determine how the sky in the background looks in your project. If the theme of your project is otherworldly, begin with the Sky Atmosphere tools to create an alien world.

Before you alter Sky Atmosphere settings, you need to have already determined the light source in your project and the direction the world light is coming from using the settings from Directional Light. Now you can complement the decisions you made through Sky Atmosphere.

To begin:

1. Select **Sky Atmosphere** from the components field in the **Details** panel. The Sky Atmosphere settings appear in the Details panel.

   [![Select Sky Atmosphere from the components field in the Details panel.](https://dev.epicgames.com/community/api/documentation/image/65cd415b-a64c-4f24-befb-4e0a845db22c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/65cd415b-a64c-4f24-befb-4e0a845db22c?resizing_type=fit)
2. Click **Ground Albedo** and select a new color from the color wheel. This changes the color radiance bouncing off the ground plane that affects the color of the horizon.
3. Slide the **Atmosphere Height** slider to the left and the horizon becomes darker, slide to the right and the horizon becomes lighter. Set the slider to **30.0**.
4. Slide the **Multiscattering** slider to the left and the upper atmosphere gets darker in your project. Set Multiscattering to **0.5**.

   [![The atmosphere settings used.](https://dev.epicgames.com/community/api/documentation/image/6571c83a-b825-4e42-bba9-fdb5806c6dbb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6571c83a-b825-4e42-bba9-fdb5806c6dbb?resizing_type=fit)
5. Slide the **Mie Scattering Scale** slider to the right and the background becomes increasingly foggier. Set Mie Scattering Scale to **0.2** to increase the fog in the distance and over the water in the background.
6. Slide the **Mie Absorption Scale** slider to the right and the upper atmosphere becomes darker, just like the sky does when going from daytime to nighttime. Set the Mie Absorption Scale to **0.4**.
7. Click **Mie Absorption** and select a new color from the color wheel. This changes the color of the upper atmosphere.

   When you pick colors for the Mie Absorption and Absorption settings, the results are the color on the opposite side of the color wheel from what you selected. The reason for this is because it is 'absorbing' the color you are putting in.
8. Click **Mie Scattering** and select a new color from the color wheel. This changes the color of the lower atmosphere in the distance.
9. Slide the **Mie Anisotropy** slider to the left and the upper atmosphere color lightens. Slide to the right and the upper atmosphere color darkens. Set Mie Anisotropy to **0.75** This should create a gradient in the horizon where all colors gradually blend together.
10. Slide the **Mie Exponential Distribution** slider all the way to the left and the horizon color changes to look like the natural blue color. Slide all the way to the right and your project becomes absorbed in a light the color you selected for Mie Absorption. Set Mie Exponential Distribution to **1.5**. Your project atmospheric lighting will use 1.5 times the amount of the Mie Absorption color for its horizon and world lighting color.

    [![The Mie settings used.](https://dev.epicgames.com/community/api/documentation/image/69fdd2f5-3869-4170-bb3c-7bda744f9135?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69fdd2f5-3869-4170-bb3c-7bda744f9135?resizing_type=fit)

Using these settings you can create a horizon that looks like early morning, late evening, or midnight.

[![How the skyline looks using the settings above.](https://dev.epicgames.com/community/api/documentation/image/8997b393-5aa5-471b-adac-ce58046eeec7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8997b393-5aa5-471b-adac-ce58046eeec7?resizing_type=fit)

You can alter the horizon absorption further and change the details on the horizon by doing the following:

1. Slide the **Absorption Scale** slider all the way to the right and the world lighting becomes darker and takes on a different hue.
2. Click **Absorption** and select a new color from the color wheel. Notice how the horizon and the filter of light in your project takes on the color you select.
3. Expand **Tent Distribution** to see all the settings available.
4. Slowly slide the **Tip Altitude** slider all the way to the right. Notice how your world seems to be going through the phases of the day cycle on the horizon. Set Tip Altitude to **29.0**. This should mimic the early hours of the day.
5. Slide the **Tip Value** slider to the left. As you do the upper atmosphere and world lighting becomes lighter. Set Tip Value to **0.2**.
6. Slide the **Width** slider to the left, the outer atmosphere of your project becomes lighter. Slide to the right and the outer atmosphere becomes darker.

   [![These settings change the look of the upper and outer atmosphere](https://dev.epicgames.com/community/api/documentation/image/a9695753-9d64-4653-8f5d-176aa9a2402b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9695753-9d64-4653-8f5d-176aa9a2402b?resizing_type=fit)
7. Click **Sky Luminance Factor** and select a color from the color wheel. This changes the color of the luminance of your horizon and the hue of light filtering the atmosphere of your project.
8. Slide the **Aerial Perspective View Distance Scale** slider all the way to the left, this reveals more of the landmasses in the background.Slide all the way to the right and all objects in the background disappear into fog. Set the Aerial Perspective View Distance Scale to **0.5**. The distant objects are barely visible through the fog.
9. Slide the **Transmittance Min Light Elevation Angle** slider to the right, this increases the amount of light transmitted from the direction of the main light source. Set Transmittance Min Light Elevation Angle to **60.0**. This softens the light in the project.

   [![These settings change what’s visible on the horizon of your project.](https://dev.epicgames.com/community/api/documentation/image/0bde3e90-a553-4dba-b8e0-4eac910b3990?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0bde3e90-a553-4dba-b8e0-4eac910b3990?resizing_type=fit)

The horizon you’ve created is ready for the additional tools in Sky Light that control the clouds, and how light bounces off of objects on your island.

### Using Sky Light

Sky Light is the aspect of illumination that concerns the fill of light in the project that isn’t attributed to sunlight or moonlight. Instead, Sky Light settings determine how the light bounces off of the objects in your world. This is called global illumination.

Think of how light bounces off objects to create ambient lighting in real life. For example, think about the lighting in the Grand Canyon and how light bounces off the rocks. If you’re wearing a white t-shirt while standing next to the rock face, your white t-shirt would appear to have a red hue. This is the type of light that you control using SkyLight.

Start by selecting **SkyLight** from the components field. In the Details panel you’ll see **Real Time Capture** is already selected. This setting places a camera in your project to capture everything around the island and how it all contributes to lighting and reflections.

[![Select Sky Light from the components field.](https://dev.epicgames.com/community/api/documentation/image/a2b420c4-fc1a-4d09-88fc-1d5e516477c9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2b420c4-fc1a-4d09-88fc-1d5e516477c9?resizing_type=fit)

If you toggle **Real Time Capture** off, then you’ll need to create a cubemap for your project. A cubemap captures the area of the project much like Real Time Capture does, but with a cubemap you can control the angle source and resolution for your cubemap in the Sky Light settings.

To learn more about cubemaps, see [Sky Lights](https://dev.epicgames.com/documentation/en-us/unreal-engine/sky-lights-in-unreal-engine?application_version=5.5) in the Unreal Engine documentation.

Leaving Real Time Capture toggled on, change the following settings:

1. Undo all the changes you’ve made in **DirectionalLight** and **SkyAtmosphere** components.
2. Slowly slide the **Intensity** slider to the right, the intensity of the light bouncing from the water and ground plane increases. Set Intensity to **8.0**.
3. Click **Light Color** and select a new color from the color wheel. This changes the color of the light that bounces off objects in your project. This affects the color of shadows and the water around your island.

   [![These sky light settings determine the hue of light that bounces off of objects and the color of the shadows cast in your project.](https://dev.epicgames.com/community/api/documentation/image/526dcae3-d16a-4eb0-a21a-cafd3b4e37eb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/526dcae3-d16a-4eb0-a21a-cafd3b4e37eb?resizing_type=fit)

   If you don't want to apply these changes to your whole island, toggle **Affects World** off to use additional Sky Light settings on your island to create custom light bounce effects.

### Using Exponential Height Fog

The settings used under **Exponential Height Fog** determine the amount of haze in the sky, and fog on the ground. Fog softens the lighting on your island by adding a filter to the stratosphere and troposphere of your project.

Fog can create an atmosphere of dread, and you can use it to mimic early morning or evening. Adding fog to your project may cause players to move about your island cautiously because their vision is reduced.

Create customized fog by doing the following:

1. Select **Exponential Height Fog** from the component field in the Details panel.

   [![Select Exponential Height Fog from the component field in the details panel.](https://dev.epicgames.com/community/api/documentation/image/2dde6cfb-1ca1-449a-8627-bb287e3641e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2dde6cfb-1ca1-449a-8627-bb287e3641e9?resizing_type=fit)
2. Focus the viewport camera across to the farthest section of the ground plane.
3. Slowly slide the **Fog Density** slider all the way to the right. The fog density on your island increases. Sliding the slider to the left reduces the amount of fog on your island. Set the slider to **0.15**.
4. Slowly slide the **Fog Height Falloff** slider to the right, the fog shifts from the sky to the ground. Set the slider to **1.5**.
5. Expand the **Second Fog Data** settings.

   [![Expand the Second Fog Data settings.](https://dev.epicgames.com/community/api/documentation/image/164dc471-d285-496b-a7de-8a63f3798109?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/164dc471-d285-496b-a7de-8a63f3798109?resizing_type=fit)
6. Slowly slide the **Fog Density** slider to the right to add fog to the upper atmosphere. Set the slider to **0.02**.
7. Slowly slide the **Fog Height Falloff** slider to the right, this makes the haze in the sky less opaque. Slide the slider to the left to increase the opacity of the haze in the sky. Set the slider to **2.0**.
8. Slowly slide the **Fog Height Offset** slider to the right, as you do the sunlight in the world will slowly be filtered out by the fog. The secondary height offset mainly affects how light is filtered in the background. Set the Fog Height Offset to **2.5**.

   [![These settings determine how the fog looks and where the fog sits on the island.](https://dev.epicgames.com/community/api/documentation/image/061fa702-8d13-4cea-a2f0-d851ed2a2d34?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/061fa702-8d13-4cea-a2f0-d851ed2a2d34?resizing_type=fit)

   If you slide the **Fog Height Offset** slider all the way to the right, the values result in strange clipping behavior.
9. Click on **Fog Inscattering Color** and select a color from the color wheel. This changes the hue of the fog in the distance.
10. Slide the **Fog Max Opacity** all the way to the left, the fog completely disappears because you’ve reduced the opacity of the fog to 0.0. Set the slider to **0.04** to thin out the fog.

    If you selected earlier to create a cubemap, you can add your cubemap to the **Inscattering Texture** settings and edit the angle, tint, and distance color of the fog on your island.
11. Click on **Directional Inscattering Color** and select a color from the color wheel. This changes the hue of the fog in the sky to the selected color.
12. Slide the **Directional Inscattering Start Distance** slider to the right to reduce the opacity of the fog in the background. Set to **15000.0**.
13. Slide the **Directional Inscattering Exponent** slider to the right to reduce the amount of light bouncing back into the sky. Set the slider to **7.0**.

    [![These settings determine the color, thickness and distance of the directional inscattering.](https://dev.epicgames.com/community/api/documentation/image/fc50b089-9453-49a8-a93c-883247184dc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc50b089-9453-49a8-a93c-883247184dc0?resizing_type=fit)
14. Click on **Albedo** and select a new color from the color wheel. This changes the hue of the fog through the light bouncing from the ground back into the atmosphere.
15. Slide the **Extinction Scale** slider to the right to increase the opacity of the fog. Set the slider to **4.0**.
16. Slowly slide the **View Distance** slider to the right, the fog reduces the visibility of distant objects. Sliding the slider to the left increases the distance visibility. Set the slider to **4500.0**.
17. Slide the **Start Distance** slider to the right to increase the distance the fog starts from the viewport camera. Set to **600.0**.
18. Slide the **Near Fade In Distance** slider to the right, the volumetric fog begins to fade over the set distance from the start distance. Set the slider to **500.0**.

    [![These are the settings used to edit the fog’s density and visibility in the distance.](https://dev.epicgames.com/community/api/documentation/image/3f3ca380-818d-42e7-bc0b-59e713cc6a4f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f3ca380-818d-42e7-bc0b-59e713cc6a4f?resizing_type=fit)

Here’s how these fog settings look on the island in UEFN.

[![The settings used create a soft looking fog in the distance on the island.](https://dev.epicgames.com/community/api/documentation/image/c7a3a66e-f162-4c4f-97cb-d1c7a498254a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c7a3a66e-f162-4c4f-97cb-d1c7a498254a?resizing_type=fit)

### Using Lumen Exposure and Basic Exposure

The Environment Light Rig uses both Lumen Exposure and Basic Exposure by default. Both exposure types can edit the look of the global lighting, but how the custom lighting is rendered depends on the platform used to access the island during gameplay.

- **Lumen Exposure** uses Auto Exposure from UE as a feature to render lighting. For more information on Auto Exposure and how to use it, refer to the [Auto Exposure documentation](https://dev.epicgames.com/documentation/en-us/unreal-engine/auto-exposure-in-unreal-engine?application_version=5.5). Using these exposure settings enhances the look and feel of an island for high-end platforms.
- **Basic Exposure** uses the classic Fortnite Creative exposure across the island. Although the basic exposure will render across all platforms, these options are meant to upscale the basic exposure settings to create a custom look that works with low-end platforms.

#### Lumen Exposure

For platforms that support Lumen, the Environment Light Rig provides a way to use Auto Exposure. Auto Exposure calculates a histogram of the luminance values on screen, which is then used to determine the average luminance value.

This option uses more memory, but provides a better custom lighting setup. Auto Exposure is necessary when using Lumen because its accurate global illumination will cause indoors to be much darker than outdoors.

**Min Brightness** and **Max Brightness** define the range of exposure values you can use to determine the amount of brightness when you use indirect lighting.

#### Basic Exposure

Basic Exposure supports a player’s experience on mobile and low-end platforms because it’s less memory intensive and isn’t using a histogram to calculate luminance scene values. This means your island performs as normal, but with custom world lighting.

Auto Exposure isn’t necessary when using Basic Exposure because the sky light isn’t shadowed on platforms that don’t support Lumen. So the interiors of your island still receive plenty of light. You can use Exposure Compensation to brighten and darken the scene.

Use the Locked Exposure settings to alter the scene’s brightness range:

- Min Brightness = Max Brightness (no range, default values = 1.0)

### Using Color Grading

Color grading determines how the camera views the scene in the viewport. This is a post-processing enhancer.

Color grading adds a post-process look to your island that determines how the player sees the island. With color grading, you can determine how the light source of your island appears in the sky, add chromatic aberration to the lens of the viewport camera, edit local exposure settings, and much more.

Create visual interest with the following settings:

1. Select **Color Grading** from the component field in the **Details** panel.

   [![Select color grading from the component menu in the details panel.](https://dev.epicgames.com/community/api/documentation/image/d1f10d1f-1646-462e-ab68-4c3b7e6bdd88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d1f10d1f-1646-462e-ab68-4c3b7e6bdd88?resizing_type=fit)
2. Expand the **Lens** category. There are a number of Lens options you'll use below.
3. Expand the **Bloom** option, then toggle on **Preferred** **Method** and Intensity.
4. Set **Intensity** to **1.0** and **Threshold** to **0.4**.

   [![Change the intensity settings.](https://dev.epicgames.com/community/api/documentation/image/4cb5c74d-82ba-41f0-b79f-bcbef84cd9cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4cb5c74d-82ba-41f0-b79f-bcbef84cd9cb?resizing_type=fit)
5. Expand **Chromatic Aberration** then toggle on **Intensity** and **Start Offset**. This will cause the colors of an object to seemingly separate causing objects to look different.
6. Set **Intensity** to **5.0** and **Start Offset** to **0.3**.

   [![Change the intensity and start offset settings.](https://dev.epicgames.com/community/api/documentation/image/36ff23a7-a22b-4863-9341-85ad0243f714?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36ff23a7-a22b-4863-9341-85ad0243f714?resizing_type=fit)
7. Expand the **Local Exposure** options then toggle on **Detail Strength**, and **Blurred Luminance Blend**.
8. Set **Detail Strength** to **0.6**, and **Blurred Luminance Blend** to **0.2**.

   [![Change the local exposure settings.](https://dev.epicgames.com/community/api/documentation/image/1ebd6907-f534-45fb-aef5-bbf43985ed26?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1ebd6907-f534-45fb-aef5-bbf43985ed26?resizing_type=fit)
9. Expand **Lens Flare** then toggle on **Intensity**.
10. Set **Intensity** to **16.0**.

    [![Change the lens flare settings.](https://dev.epicgames.com/community/api/documentation/image/7a66f158-2bd1-47a7-a951-ec710adcaf99?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a66f158-2bd1-47a7-a951-ec710adcaf99?resizing_type=fit)
11. Expand the **Color Grading** options, then toggle on **Temp** and **Tint.**
12. Set **Temp** to **7740.0** and **Tint** to **0.5**.

    [![Change the color grading settings.](https://dev.epicgames.com/community/api/documentation/image/7f3bcb01-c7d4-4c7a-afbc-22830369d342?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7f3bcb01-c7d4-4c7a-afbc-22830369d342?resizing_type=fit)
13. Expand **Global**, then toggle on and expand the **Saturation** and **Contrast** options.
14. Slide the saturation color slider to **2.0**.
15. Select **HSV** from the Contrast settings and set the **V** (value) to **1.17**.

    [![Change the global option settings.](https://dev.epicgames.com/community/api/documentation/image/2c1788c5-2f31-451f-9f81-95e91f54ae5d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2c1788c5-2f31-451f-9f81-95e91f54ae5d?resizing_type=fit)
16. Expand **Misc** then toggle on **Scene Color Tint**.
17. Click **Scene Color Tint**, select a light red color from the color wheel, then click **OK**.
18. Set the **Blend Weight**  to **0.5**.

    [![Change the blend weight settings.](https://dev.epicgames.com/community/api/documentation/image/b10d6f01-23e0-4fe3-b1b8-bfe173584549?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b10d6f01-23e0-4fe3-b1b8-bfe173584549?resizing_type=fit)

The viewport now has a dreamlike quality to it. You could use these settings in a short cut scene or to create a game that makes players feel like they’re walking through a dream world.

[![The settings result in a dream-like quality.](https://dev.epicgames.com/community/api/documentation/image/c9d09d85-3f9f-4030-ad9d-dff606e7bada?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c9d09d85-3f9f-4030-ad9d-dff606e7bada?resizing_type=fit)

#### World Light Editing

Edit the world lighting of your island by using the Lens and Lens Flare settings. Be sure that the directional and sky light colors you selected for your world are not too washed out. Once you edit the settings, playtest your island to see if the changes you make affect the world lighting as you intended.

Begin by selecting a bloom scale for the directional lighting on the island. Bloom affects how the sun looks in the sky. You can make the ring around your sun more or less distinct depending on the intensity and threshold you select.

1. Return all the component settings back to the default settings.
2. Select **Lumen Exposure** in the component field to view the Lumen Exposure settings in the **Details** panel.
3. Slide the **Bloom Intensity** slider to the right. The ring around the sun becomes thicker. Sliding the slider to the left makes the ring smaller until it blurs. Set the slider to **0.1**.
4. Slide the **Threshold** slider to the right. Less light will bounce back into the sky, causing the horizon to become less hazy.

   [![Use the following lens settings.](https://dev.epicgames.com/community/api/documentation/image/207bdda6-6976-47c1-bc11-ab2a22db8fb2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/207bdda6-6976-47c1-bc11-ab2a22db8fb2?resizing_type=fit)
5. Scroll down to **Lens Flare.**
6. Toggle on **Intensity** to create a lens flare.
7. Slide the **Intensity** slider to the right. As you do, the lens flare becomes larger. Set the Intensity to **1.15**.

   [![Set the Lens Flare setting to 1.15.](https://dev.epicgames.com/community/api/documentation/image/bb8c4b64-2ab6-4cff-8356-8d94350599a1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb8c4b64-2ab6-4cff-8356-8d94350599a1?resizing_type=fit)

These settings create a lens flare and more realistic outdoor lighting in UEFN.

[![This is the result of the edits to Lens and Lens Flare.](https://dev.epicgames.com/community/api/documentation/image/9451f52c-df72-4d4f-91c4-f0110b24f56f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9451f52c-df72-4d4f-91c4-f0110b24f56f?resizing_type=fit)

#### Cinematic Lighting and Film Grain

Cinematic lighting refers to the color exposure of the lighting. This post-process effect is commonly used in film to express a feeling throughout a movie. Some movies use a blue hue to add a cool feel to the lighting, or yellow to create a feeling of warmth.

You can use this cinematic effect on your island using the **Color Grading** setting from the Lumen Exposure component.

If you’ve already added color to your world lighting using the Directional Light and Sky Light components, the use of color grading may be too much of one color for your island.

Playtest your island to make sure the wash of color isn’t distracting from the gameplay, and adds to the look and feel you’re aiming for.

To begin, make sure **Lumen Exposure** is selected from the components field in the Details panel. All the color grading settings will be available now.

[![Select Lumen Exposure from the component field in the details panel.](https://dev.epicgames.com/community/api/documentation/image/dd25742d-0cc9-4186-8526-1a013f3782c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd25742d-0cc9-4186-8526-1a013f3782c2?resizing_type=fit)

1. Expand the **Color Grading > Temperature** settings.

   [![Expand the color grading and temperature settings.](https://dev.epicgames.com/community/api/documentation/image/a8459f01-0fa0-4b80-af7b-bae2e2ad826e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a8459f01-0fa0-4b80-af7b-bae2e2ad826e?resizing_type=fit)
2. Toggle both the **Temp** and **Tint** options. The Temp and Tint sliders become active.
3. Slide the **Temp** slider to the right, the light of the island becomes washed in a warm yellow color. Slide the slider to the left and the light of the island becomes washed in a blue color. Set the slider to **9000.5**. The light on the island becomes washed in a light yellow hue.
4. Slide the **Tint** slider all the way to the right. The light on the island becomes tinted in a pink hue. Sliding the slider all the way to the left tints the light with a green hue. Set the slider to **0.5**.

   [![Use these settings to edit the light on the island with a hue of color.](https://dev.epicgames.com/community/api/documentation/image/ea586c12-8e24-4876-8179-a269d6f00d0a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ea586c12-8e24-4876-8179-a269d6f00d0a?resizing_type=fit)

   In this example, the **Temperature Type** was left at **White Balance**. White light is used to balance out the colors used in the temperature settings. Alternatively, you can set the Temperature Type to **Color Temperature** and use color to balance out the temperature settings instead.

   [![Change the temperature type to change how the hue added to the light affects the island.](https://dev.epicgames.com/community/api/documentation/image/4015c5ed-0dbc-4d0d-b3d4-6b6044b03e07?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4015c5ed-0dbc-4d0d-b3d4-6b6044b03e07?resizing_type=fit)
5. Expand the **Global** settings.
6. Toggle on and expand the **Saturation** settings. You can now use the Saturation color wheel.
7. Slide the **R** slider to **2.0**. This increases the red hue in the light and increases the warmth of the light.

   [![Select a color for the light saturation.](https://dev.epicgames.com/community/api/documentation/image/1556a62e-5a1f-4e48-a4c4-53b9638a99b5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1556a62e-5a1f-4e48-a4c4-53b9638a99b5?resizing_type=fit)

   For each color grading setting you can slide the individual **RGBY** sliders to find the right color for the light saturation, or click on the color wheel to select a new color.

   Additionally, you can select **HSV** to open the hue, saturation, and value sliders for the selected color.
8. Toggle on and expand the **Contrast** settings. You can now use the contrast color wheel and settings.
9. Click **HSV** and set the **Y** (luminance) value to **1.45**. This begins to wash out red hues and increases the warmth of the light.

   [![Change the luminance setting using the Y slider.](https://dev.epicgames.com/community/api/documentation/image/ae0499a9-e122-4897-819b-d6b7f4b9825c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ae0499a9-e122-4897-819b-d6b7f4b9825c?resizing_type=fit)
10. Toggle on **Misc > Scene Color Tint**. You can now use the Scene Color Tint settings.

    [![Toggle on the scene color tint through the Misc setting.](https://dev.epicgames.com/community/api/documentation/image/3d9672a0-66bc-47c9-b35f-33c40264e9e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3d9672a0-66bc-47c9-b35f-33c40264e9e9?resizing_type=fit)
11. Click on **Scene Color Tint** to open the color wheel.
12. Select a light pink color and click **OK** to balance the red tint to the light. The reds on the island should no longer be completely washed out, but will reflect a smaller amount of light than before.

    [![Select a light pink color to return some red tint to the light.](https://dev.epicgames.com/community/api/documentation/image/8c0d82eb-edf5-48bb-8d0d-acad59c25ce0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c0d82eb-edf5-48bb-8d0d-acad59c25ce0?resizing_type=fit)
13. Expand **Film Grain**, then toggle on **Film Grain Intensity** and **Film Grain Texel Size**.

    [![Add a film grain to the viewport by enabling the film grain settings](https://dev.epicgames.com/community/api/documentation/image/3444ac2a-2c3e-4610-9040-68bd3d667ecf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3444ac2a-2c3e-4610-9040-68bd3d667ecf?resizing_type=fit)
14. Set **Film Grain Intensity** to **1.0**.
15. Set **Film Grain Texel Size** to **2.5**.

Your viewport now looks grainy, like an old movie. You can use this effect to create a vignette for your island, or to create an old-time movie feeling to your island gameplay. These settings would be most effective visually with a game that takes place in the desert.

[![The settings above create an old west film feeling to the viewport.](https://dev.epicgames.com/community/api/documentation/image/efba3175-5fb3-4766-81d7-4a242b44eb89?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/efba3175-5fb3-4766-81d7-4a242b44eb89?resizing_type=fit)
