# 5. Post-Process Volumes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-5-postprocess-volumes-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:42:35.720100

---

## Post Process Volumes

After going through each biome and seeing how the Day Sequence device settings are adjusted to create the distinct look and feel for each quadrant, you should be able to create your own unique environments with a few minor adjustments.

Each biome has an extra **Post Process Volume** in its folder next to the corresponding Day Sequence device. These post effects have been added to each quadrant to show you how to push the lighting of the environment further.

[![A view of all the Post Process Volumes on the island.](https://dev.epicgames.com/community/api/documentation/image/c1d350be-786d-4be2-a8d0-ed062762a2dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c1d350be-786d-4be2-a8d0-ed062762a2dd?resizing_type=fit)

Remember, while this will help you push the look further, if you are developing for several platforms, this will have an impact on the number of variables you have to keep track of for consistent looks throughout the gamut of low-end and high-end devices, as not all devices support all features and post effects.

Search and select the **West\_PPV** actor inside the **West** folder from the Outliner. Ensure the Details panel setting **Show Only Modified Properties** is toggled on. From the Outliner, hide and unhide the PPV actor so you can see the effect the volume has on each quadrant.

Cycle through the different biomes and select the corresponding PPV to see its effect when toggled on and off. Next, play with the settings on the PPV to see how you can create a new look for each quadrant.

Below is an overview of the settings adjusted to create the **West\_PPV**. The same basic settings were modified in all of the volumes.

- **Lens Flare:** Decreased the value to **0.01** for a subtle lens flare from the sun.
- **Temperature:** The value is set to **5476.0**, which creates more balance across the colors selected for the sky.
- **Tint:** The value is decreased to **-0.12** so the color of the lens flare is reduced.
- **Global Saturation:** The value is set to **0.8** to control the look of the scene.

The Beach biome PPV required an adjustment to the overall color. For this reason, only the Temperature setting was modified. Afterward, the Tint values were decreased and desaturated to make the beach look less like a cartoon.

Modify the colors for all the other Post Process Volumes and use the settings above to see how they affect the final look of each biome.

## Things to Keep in Mind

The most important thing to remember is to make bold adjustments to the main settings.

- Think about light and shadow first. Ask yourself where the direct lighting comes from.
- Think about color and temperature second. Literally think about the exterior and interior scene temperature and what it should feel like — cold, warm, hot, or humid. This will help you decide which colors to use.
- Consider what complimentary environmental details you need for your scene, like fog, clouds, and sky.
- Lastly, consider using subtle post effects like [chromatic aberration](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#chromatic-aberration), [vignetting](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#vignette), and [bloom](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#bloom) to effectively add depth and dimension to your lighting and scene.
- Pay close attention to the priorities of your Day Sequence device and Post Process Volumes.
- Always check how your project looks in all scalabilities to make sure you aren’t diverting too much from the high-end look.
- Be bold with your changes. If you design your project with small, linear increments, it could be hard to see the differences between settings, and you will most likely end up with a flat-looking scene that you won't know how to fix. A drastic change allows you to establish your limits then go back to find the middle ground that works for your project. Use this approach to get faster results with the fewest number of changes to settings.
