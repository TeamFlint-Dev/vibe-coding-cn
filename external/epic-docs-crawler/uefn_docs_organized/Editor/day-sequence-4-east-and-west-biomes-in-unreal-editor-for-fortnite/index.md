# 4. East and West Biomes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-4-east-and-west-biomes-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:42:20.344220

---

## East - Desert

So far, you’ve learned how to create three unique environments: Neutral (center island), Winter, and Jungle. At this point in the template, you should recognize that each biome uses the same options to design the environments: **Time of Day**, **Fog**, **Sky**, and **Clouds**.

*Trigger Volume Area transition point*

The goal in creating the Desert biome is to make it appear hot. To achieve the desired look, the sun’s intensity is increased, the sky is clear, and an intense lens flare with [chromatic aberration](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#chromatic-aberration) is added to the scene. Press the **3** key to go to the **East** quadrant.

### Desert Secondary Day Sequence Device

Select the **Day Sequence Device\_East** asset from the **East** folder in the Outliner and toggle on **Show Only Modified Properties** in the Details panel. Below is a list of options and settings used to achieve the desert aesthetic.

[![The Eastern biome](https://dev.epicgames.com/community/api/documentation/image/a2cf63e4-e8f9-4462-86b7-8771d6a673a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a2cf63e4-e8f9-4462-86b7-8771d6a673a5?resizing_type=fit)

- **Time of Day:** The time was set to **5am**.
- **Sun Light:** The following settings were adjusted to create a full-sun effect to the environment lighting.

  - **Intensity:** The value was set to **15** to make the sun feel intense.
  - **Color:** Tones of yellow and orange were used to make the biome feel warm.
- **Fog**: To learn more about Fog, refer to the [Unreal Engine Volumetric Fog](https://dev.epicgames.com/documentation/en-us/unreal-engine/volumetric-fog-in-unreal-engine?application_version=5.5) documentation.

  - **Fog Color:** A blue tint was used to align with the sky.
  - **Max Opacity:** The value was set to **0.5** to decrease the fog coverage.
- **Skylight:** To learn more about Skylight, refer to the [Unreal Engine Skylight](https://dev.epicgames.com/documentation/en-us/unreal-engine/sky-lights-in-unreal-engine?application_version=5.5) documentation.

  - **Intensity:** The value was set to **2.0**, which is twice the normal intensity.
  - **Color:** This was set to a blue hue.
- **Sky:** These two secondary sky options create the sky and atmosphere of the desert.

  - **Gradient Blend:** The value is set to **0.5** which blends with the default Day Sequence device by **50%**.

    The color of the sunlight, fog, and skylight were changed to make them look a bit less saturated and whiter at the bottom towards the horizon.
  - **Sun Size:** The value is set to **3.0**, which is three times the sun’s normal size.

## West - Beach

The majority of the options used to create the Desert biome are once again modified in the Beach biome secondary Day Sequence device. The settings were adjusted to accommodate the time of day used for the Western quadrant to create the luminous glow you see in the GIF below.

*Trigger Volume Area transition point*

Press the **5** key to go to the Beach biome.

### Beach Secondary Day Sequence Device

Select the **Day Sequence Device\_West** asset in the **West** folder inside the Outliner and toggle on the **Show Only Modified Properties** in the Details panel. Below are the adjusted settings for the Beach biome.

- **Time of Day:** The time is set to **3.8am**, placing the sun low in the horizon.
- **SunLight:** The following sunlight settings were adjusted to create a dawn effect to the environment lighting.

  - **Intensity:** The value is set to **10** to make the sun’s light look bright.
  - **Color:** Yellows and pinks were chosen to keep the scene on the warmer side.
- **Fog:** The following settings were adjusted to create the illusion of early morning.

  - **Density:** Changed to **0.2**, which makes the sky more hazy than the Desert biome.
  - **Color:** Pink and red tones were selected to keep the environmental accent lighting colors on the warm side.
  - **Directional Inscattering Color:** Set to a warm yellow for the fog’s primary color.
- **Skylight:** These settings determine how much accent lighting is in the sky.

  - **Intensity:** The value is set to **1.5**, which creates an intensity coming from the sky light.
  - **Color:** Changed the skylight color to light blue.
- **Sky:** To learn more about the Sky option, refer to the [Day Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-day-sequence-devices-in-unreal-editor-for-fortnite) device document.

  - **Sky Gradient Blend:** Set to **0.5** or 50% to blend all the colors chosen for the sky.

  [![The Western biome](https://dev.epicgames.com/community/api/documentation/image/187747f0-d029-49ed-9a95-2dda99f82b88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/187747f0-d029-49ed-9a95-2dda99f82b88?resizing_type=fit)

  The color of the sunlight, fog, skylight, and sun were changed to make them look a bit less saturated and whiter at the bottom towards the horizon.

  - **Sun Size:** The size was set to **9.0** to make the sun larger as it gets closer to the horizon.
  - **Sun Intensity**: A bit more intensity was added to the sun by changing the value to **1.1** from the default value (1.0).
  - **Custom Color:** The custom color was set to orange with a **0.8** blend to make the glow of the sun more colorful.

## Next Section

[![5. Post-Process Volumes](https://dev.epicgames.com/community/api/documentation/image/21eda3b7-7241-42e1-becf-4e664782f3d6?resizing_type=fit&width=640&height=640)

5. Post-Process Volumes

Learn how to use post-process volumes to create custom lighting for different environments inside your project.](https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-5-postprocess-volumes-in-unreal-editor-for-fortnite)
