# 2. North Biome

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-2-north-biome-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:42:41.156787

---

## North - Winter

The quadrants provide four distinct biomes for you to explore. To start in the North biome, press the **2** key. This quadrant has the most drastic environment lighting changes of the four quadrants.

[![The North quadrant is the most extreme environment set up out of the all quadrants.](https://dev.epicgames.com/community/api/documentation/image/82245c31-f013-4625-bfc1-e153d641ba70?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82245c31-f013-4625-bfc1-e153d641ba70?resizing_type=fit)

A good light design strategy is to start with a drastic change to your light settings as this sets the boundaries for the look of your project. This also gives you a feel for how much is too much or too little.

This also means you won't waste time with small adjustments that make it harder to see what lighting settings you’re adjusting without easily showing the results of your adjustments.

### Priorities

It's important to understand how to use the priorities of the **Post Process Volumes** included in the Day Sequence device and Lumen Exposure Manager, and what they’re capable of.

Inside the **North** folder, you’ll find **Day Sequence Device\_North** and **North\_PPV**. This is where the art direction starts to get more complex, so you’ll have to pay attention to the **Priority** value in both of these.

The Day Sequence device defaults to **Priority 2000** and the Lumen Exposure Manager default is **Priority 10**. If you add more Day Sequence devices or PPVs, you’ll have to increase their priority values to override the ones with lower values. For example:

![Day Sequence Device_North with priority 0 does not affect the scene.](https://dev.epicgames.com/community/api/documentation/image/90c42aa4-a242-4984-b9fb-56d780c62db6?resizing_type=fit&width=1920&height=1080)

![Day Sequence Device_North with priority 3000 does override the general priority of 2000.](https://dev.epicgames.com/community/api/documentation/image/c387d152-6ff2-41a9-b976-37eb941aa5ff?resizing_type=fit&width=1920&height=1080)

Day Sequence Device\_North with priority 0 does not affect the scene.

Day Sequence Device\_North with priority 3000 does override the general priority of 2000.

Note that priorities will mix. If the Island Center Day Sequence device Priority value is 2000 and the North Day Sequence device Priority value is 2000, the two device Priority settings will mix evenly. Set the **North Day Sequence** device to a **higher priority** so that its settings are used 100%.

**There is an exception:** If the general look you create uses a higher value for **Chromatic Aberration** on your first Day Sequence device and you don’t adjust the same value further in the second Day Sequence device, your project will use the established settings from the first device.

You have to change the settings of the second Day Sequence device for your project to use the look you created with the second Day Sequence device.

Inside the Outliner, select the **North\_PPV** asset from the North folder and toggle it on and off. You should notice a subtle change in the overall look of the scene. This was done as a third pass to exaggerate the winter look even further.

### Secondary Post Process Volume

Once the North look was established using **DaySequenceDevice\_North**, a second Post Process Volume was added to the winter biome.

The Lumen Exposure Manager has a Post Process Volume (PPV) inside that was used to set the "neutral" look for the entire island. This PPV sets the look for low and high scalabilities.

The second PPV was added to polish the look with more contrast, [bloom](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#bloom), stronger [vignetting](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#vignette), and less [saturation](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#saturation).

[![An example of the layered lighting designed to make the winter biome.](https://dev.epicgames.com/community/api/documentation/image/7b43fa38-53aa-4c13-8729-75c71be8fbc6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7b43fa38-53aa-4c13-8729-75c71be8fbc6?resizing_type=fit)

What you see in the image on the far left above is the default look from the Day Sequence device alone. The middle image shows how the scene changes when the Lumen Exposure Manager is enabled, and how it affects the whole scene. The image on the right shows further subtle changes to the environment lighting when the Post Process Volume is added.

The Lumen Exposure Manager uses priority settings the way the Day Sequence device does. The Lumen Exposure Manager PPV has a default Priority value of **10**. Make sure additional PPVs use a higher priority than 10 to take effect over the PPV that sets the general look.

For this biome, the Priority value is set to **15** for no other reason than that this is higher than 10.

You should now understand the importance of Priority values for the Day Sequence device, the Lumen Exposure Manager, and Post Process Volumes.

To understand how the winter look was achieved, examine the lighting design decisions used in the secondary Day Sequence device.

### Secondary Day Sequence Device Settings

A second Day Sequence device was added to the biome. This second device uses the **Trigger Volume** option, and you must toggle this option **On** to enable it in the scene.

[![Toggle on the Show Only Modified Properties option in the Details panel.](https://dev.epicgames.com/community/api/documentation/image/1db1bdff-aff1-4088-894e-7daf4e712d88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1db1bdff-aff1-4088-894e-7daf4e712d88?resizing_type=fit)

A trigger volume allows you to have more than one Day Sequence device in effect and controls the look of the environment inside the Post Process Volume of the secondary Day Sequence device.

You can now make use of blending even when you have set a fixed time of day. Click the dropdown for **Blending** in the **Trigger Volume** section of the device options. You can choose to blend by **Distance** or by **Time**.

[![When the blending options are not used, they become grayed out and unusable.](https://dev.epicgames.com/community/api/documentation/image/9ea9d4f4-0b90-4348-9a83-544cf0003edd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9ea9d4f4-0b90-4348-9a83-544cf0003edd?resizing_type=fit)

If you use the default Day Night Cycle, you can enable the Trigger Volume to blend between looks, but the time of day will constantly change during gameplay.

[![An aerial view of the trigger volume over the winter biome.](https://dev.epicgames.com/community/api/documentation/image/c55a7f00-e260-4382-8c56-fc2a954cb29a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c55a7f00-e260-4382-8c56-fc2a954cb29a?resizing_type=fit)

*Trigger Volume Area*

*Trigger Volume Area transition point.*

In the Outliner, select the **Day Sequence Device\_North** asset and make sure **Show Only Modified Properties** is toggled on in the Details panel. Below is a closer look at the settings used to achieve the winter look with the secondary Day Sequence device.

- **Time of Day:** The time value is set to **6am**.

  **Time of Day** is the most important part of your exterior lighting as it determines where the environmental light is coming from. However, in the winter biome, Time of Day becomes a secondary consideration because of the nature of the diffuse lighting created by the clouds and skylight
- **Sunlight Intensity**: The brightness was lowered to **2** from the default **10**. In this biome, time of day is not important because the focus is to achieve an extreme diffused lighting effect for the scene where you can't really see where the direct light of the sun is coming from.

The scene has a cloudy, blue look to make the environment seem cold. The sky is overcast, with a lot of fog on the ground level. You can see the difference between intensities in the GIF below.

[![Lowering the Intensity creates a different look and feeling to the scene.](https://dev.epicgames.com/community/api/documentation/image/900172a2-04ba-462a-ac6d-d2d790bf1d22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/900172a2-04ba-462a-ac6d-d2d790bf1d22?resizing_type=fit)

*Difference between Default intensity of 10 versus 2*

The idea was to simulate an environment where the sunlight isn’t strong enough to pass through the dense cloud layer created with the Fog Density settings.

- **Fog Density:** The default value was increased from **.01** to **1.2**. Additional Fog Density options were used to achieve the look of the environment.

  - **Fog Color:** The color value of the fog was changed to **blue**, adding a cool temperature to the outdoor lighting.
  - **Directional Inscattering Color:** The same color principle for Fog Color is applied to this setting to enhance the winter look.
  - **Secondary Density:** The value is set to **0.5** for a subtle addition to the overall look of the fog achieved through Fog Density.

Although you’re not able to see much of the clouds beyond the fog, they are there. The clouds add extra detail to the scene, especially on high-end platforms where you can take advantage of Lumen and [volumetric effects](https://dev.epicgames.com/documentation/en-us/unreal-engine/volumetric-fog-in-unreal-engine?application_version=5.5).

- **Clouds:** To create the cold and overcast look of the winter biome, blue tints were used to color the clouds, and high values were set to brightness, cloud coverage, and size.

  - **Light Color:** A simple **blue tint** was added to ensure that the clouds weren't too white.
  - **Shadow Color:** The color value was set to a **Dark Blue** tint for the darker areas of the clouds. These areas needed to look more ominous and stormy.
  - **Lighting Brightness:** The value was set to **10**, much larger than the default value of **5**. This increased the overall light intensity coming from the clouds.
  - **Coverage:** The value was set to **0.9** to create an overcast look with 90% cloud coverage.
  - **Size:** The value is lowered to **0.5** from the default value of **1**. This makes the clouds appear smaller and more repetitive, and adds more **noise** to the sky.
  - **Opacity:** The default value **1** was used to create 100% cloud visibility.

## Next Section

[![3. South Biome](https://dev.epicgames.com/community/api/documentation/image/97f7e9ec-2fcc-48d8-ad45-7623550fc450?resizing_type=fit&width=640&height=640)

3. South Biome

Learn how to use the Day Sequence device to create custom outdoor lighting for unique swampy and humid environment.](https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-3-south-biome-in-unreal-editor-for-fortnite)
