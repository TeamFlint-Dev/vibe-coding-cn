# Intro to Post-Processing

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/intro-to-postprocessing-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T22:56:26.453233

---

Post processing is a non-destructive way of defining the overall look of the whole or part of an island by using placed volumes in Unreal Editor for Fortnite (UEFN). Post process volumes include settings that can affect lighting, scene coloring, add camera effects, and more. These affect how the island looks and add visual interest.

Post-process volumes (PPV) help you push the look of your lighting further if you are developing for multiple platforms. PPVs have an impact on the number of variables you have to keep track of for a consistent look throughout the gamut of low-end and high-end devices, as not all devices support all features and post effects.

Let’s begin by exploring some industry lighting and post-processing terms to better understand what effect you’re using and how to make the most of it in your project. Following the terms section is a tutorial that teaches you how to use the Post Processing Volume to create a cinematic effect.

## Learning Post Processing and Lighting Terms

These terms are used with lighting and post processing, and common across gaming, media, and computer graphics industries concerned with capturing images.

Knowing them will help you understand what you can achieve when you’re creating your lighting and post-processing effects. You can even apply these terms to other industries that capture images, such as film and photography.

### Contrast

**Contrast** describes how highlights transition into shadows. The brightest areas are the highlights. The darkest areas are the shadows. Between these extremes, an image will have lights, midtones, and darks.

### Saturation

**Saturation** describes the amount of brightness a color appears to have. In **contrast**, lightness tells how dark or light a specific color is. Color saturation can mute colors which yields a grayscale or black-and-white appearance, or it can over-saturate a specific color or range of colors to make them more vivid.

### Value Saturation

Enhances the contrast between two of the three RGB (red, green, blue) values. With Lumen Exposure, you can achieve uniform **saturation** in your project.

### Direct Light

**Direct light** is any lighting that comes directly from a light source such as a light bulb or flash light, or the sun.

### Indirect Light

**Indirect light** is lighting that comes from a direct source but through indirect means, such as light bouncing off objects in the world (walls, rocks, and so on) or an overcast sky, or places like the shade from a building.

### Occlusion

**Occlusion** refers to blocking, as when an object blocks light. It wouldn’t be wrong to say that all regular shadows are kinds of occlusion, but the term occlusion really refers to other kinds of light blocking that aren't regular shadows from a light.

### Ambient Occlusion

**Ambient Occlusion** is a post-processing effect that approximates crevice shadows in real time, darkening creases, holes, intersections, and surfaces that are close to each other. This gives a more realistic appearance to parts of objects where ambient light is blocked out or occluded.

### Dynamic Light and Reflections

**Dynamic lights** simulate different kinds of light sources. There are a few different types of control options for dynamic lighting: **warm dimming**, **color-tunable**, and **color changing**.

**Dynamic reflections** are a quality level of reflections from given light sources. Lumen handles the shadows and reflections once you add the **Lumen Exposure Manager** to your project. The manager allows you to edit occlusion, contrast, and saturation to create a richer experience.

Think about the lighting in Fortnite Battle Royale Chapter 4 — you can achieve this with dynamic lighting.

### Color Grading

**Color grading** is the process that alters or corrects the color and luminance of the final image. You can also think of color grading as the process of altering and enhancing the color on your island to give it more emotion by creating a stylized and aesthetically pleasing scene.

It’s a lot like when you apply a filter to a picture you post on social media. In this case, color-grading tools included in the post-processing stack use the tone-mapping features with [HDR](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#hdr) to color-correct the processing of images.

For additional industry terms, see [Lumen Exposure Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-the-lumen-exposure-manager-in-unreal-editor-for-fortnite).

## Creating Cinematic Effects

Post processing is used across media to add filters and effects to image, film, and video games. By using a Post Processing Volume on your island you can create an effect that adds to the drama of the island and how players feel when playing on your island.

In this tutorial, you’ll learn about the relationship between materials, lighting, and post-processing, by changing your scene lighting settings, tweaking visuals, and post-process settings.

1. Create a project using a template pre-populated with assets.
2. Select **Actors > Visual Effects > Post Process Volume**. A box appears in the viewport, this is your Post Process Volume.
3. Select the **Post Process Volume** in the **Outliner** to open its settings in the **Details** panel.
4. Toggle on **Infinite Extent (Unbound)**.

   [![Toggle on Infinite Extent.](https://dev.epicgames.com/community/api/documentation/image/265254b9-5dbd-419b-b224-d98482944d5a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/265254b9-5dbd-419b-b224-d98482944d5a?resizing_type=fit)
5. Set **Priority** to **10.0**.

   [![Set the prioirty to 10.](https://dev.epicgames.com/community/api/documentation/image/10ba136e-a3d3-401f-8d95-345edacee275?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/10ba136e-a3d3-401f-8d95-345edacee275?resizing_type=fit)
6. Expand the following settings and toggle them on:

   1. Color Grading
   2. Exposure
   3. Chromatic Aberration
   4. Image Effects
7. Expand the Color Grading effect **Global** and toggle on **Gamma**.
8. Set the RGB settings to the following:

   1. **R** = .75
   2. **G** = .85
   3. **B** = 1.0
   4. **Y** = 1.0

These settings give the scene a blue tint.

1. Expand the **Exposure** settings and set **Exposure Compensation** to **1.5**. The viewport scene gets brighter.

   [![Set the Exposur setting to 1.5.](https://dev.epicgames.com/community/api/documentation/image/9d1b5493-4411-44a0-b6dd-30e00882d201?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d1b5493-4411-44a0-b6dd-30e00882d201?resizing_type=fit)
2. Expand **Chromatic Aberration** and set **Intensity** to **1.0**. You should see some color separation, especially at the edges of the screen.

   [![Set Chromatic Aberration Intensity to 1.](https://dev.epicgames.com/community/api/documentation/image/46bd4eda-d5bb-44a2-b4a6-099dcbd8e3f0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/46bd4eda-d5bb-44a2-b4a6-099dcbd8e3f0?resizing_type=fit)
3. Expand **Image Effects** and set **Vignette Intensity** to **1.0**. The viewport should darken around the edges.

   [![Set the Image effect vignette intensity to 1.](https://dev.epicgames.com/community/api/documentation/image/81578a75-6eaf-4dd4-afeb-5dbe849b9c2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/81578a75-6eaf-4dd4-afeb-5dbe849b9c2e?resizing_type=fit)

   You can toggle the Post Process Volume visibility on and off in the viewport from the Outliner to see the difference between using the volume and turning it off.

   [![Toggle the Post Processing Volume visibility on and off to see the difference the volume makes to the viewport.](https://dev.epicgames.com/community/api/documentation/image/1cf97434-eeb9-44b4-ad8e-e8d9969f93bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1cf97434-eeb9-44b4-ad8e-e8d9969f93bb?resizing_type=fit)

### Using a Post-Process Material

For the second part of this tutorial, you will create a material to use with the Post Process Volume that changes the look of the scene to black and white.

For more information on creating materials, see [Materials](https://dev.epicgames.com/documentation/en-us/fortnite/materials-in-unreal-editor-for-fortnite).

1. Create a folder in the **Content Browser** called **Materials**, then double-click the Materials folder to open it.
2. Right-click inside the folder and select **Material** from the dropdown menu. Name the material **PPV\_Material**.
3. Double-click the material thumbnail to open the **Material Editor**.

   [![clicking on the material thumbnail opens the Material Editor.](https://dev.epicgames.com/community/api/documentation/image/4c1cfc27-ddc3-4b70-9c21-d69eb7c6885d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c1cfc27-ddc3-4b70-9c21-d69eb7c6885d?resizing_type=fit)
4. Change the **Material Domain** setting to **Post Processing**.

   [![Change the Material Domain setting to Post Processing.](https://dev.epicgames.com/community/api/documentation/image/3b594515-1754-4479-8f95-c1e65f231d2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3b594515-1754-4479-8f95-c1e65f231d2e?resizing_type=fit)
5. Add the following material nodes to the [material graph](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#material-graph):

   1. **Scene Texture node**
   2. **Desaturation node**
   3. **ScalarParameter node**
6. Select and expand the **Scene Texture node**, change the **Scene Texture ID** to **PostProcessInput0** from the dropdown menu. This applies the material to the post-process scene.
7. Drag off from the **Color output** on the **Scene Texture node** and connect to the **Desaturation node input**. This desaturates the look of the applied material by the value applied to **Fraction Input**.
8. Change the **ScalarParameter node’s** value to **1.0** and drag off from the output pin and connect it to the **Fraction input** on the **Desaturation node**. This desaturates the look of the applied material by the value applied to **Fraction Input**.
9. Drag off the **Desaturation node** output pin and connect to the **Emissive Color input** on the **Main Material node**.
10. Click **Apply > Save**.

    [![Create the Post Processing Material.](https://dev.epicgames.com/community/api/documentation/image/746126c1-7e4a-4722-872c-25ac66bb0ea5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/746126c1-7e4a-4722-872c-25ac66bb0ea5?resizing_type=fit)
11. Return to the main viewport and select the **Post Processing Volume** in the **Outliner**.
12. Expand **Post Process Materials** under **Rendering Features** and click the **plus (+) sign** to add an array.
13. Click the dropdown menu and select **Asset Reference**.

    [![Add an array to the Post Process Volume.](https://dev.epicgames.com/community/api/documentation/image/c9df6db5-627d-42e0-bd2d-5d785bcf4ae9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c9df6db5-627d-42e0-bd2d-5d785bcf4ae9?resizing_type=fit)
14. Click the **Array** dropdown menu and select the **PPV\_Material** you created.

    [![Add the material you created to the Array.](https://dev.epicgames.com/community/api/documentation/image/a5999b1b-58f7-4779-9312-043e424f9394?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a5999b1b-58f7-4779-9312-043e424f9394?resizing_type=fit)

The scene in your viewport should now have a black-and-white filter applied, driven by your post-process material.

[![The scene in the viewport should have a black and white filter applied ot the4 scene.](https://dev.epicgames.com/community/api/documentation/image/4bb289bf-5a62-477b-910e-e04cf77a623e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4bb289bf-5a62-477b-910e-e04cf77a623e?resizing_type=fit)
